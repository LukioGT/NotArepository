// Decompiled by AS3 Sorcerer 6.20
// www.as3sorcerer.com

//net.spider.modules.dynamicoptions

package net.spider.modules
{
    import flash.display.MovieClip;
    import flash.display.SimpleButton;
    import fl.controls.TextInput;
    import flash.text.TextField;
    import net.spider.draw.ToolTipMC;
    import flash.events.MouseEvent;
    import flash.events.Event;
    import net.spider.main;
    import flash.net.navigateToURL;
    import flash.net.URLRequest;
    import net.spider.draw.listOptionsItemBtn;
    import net.spider.draw.listOptionsItem;
    import net.spider.draw.listOptionsItemExtra;
    import flash.text.TextFormat;
    import fl.controls.*;
    import flash.display.*;
    import flash.events.*;
    import flash.system.*;
    import flash.net.*;
    import net.spider.handlers.*;
    import flash.text.*;
    import flash.utils.*;
    import net.spider.draw.*;
    import flash.ui.*;

    public class dynamicoptions extends MovieClip 
    {

        public var a1:MovieClip;
        public var btnClose:SimpleButton;
        public var a2:MovieClip;
        public var txtSearch:TextInput;
        public var cntMask:MovieClip;
        public var txtVersion:TextField;
        public var frame:MovieClip;
        public var bg:MovieClip;
        public var SBar:MovieClip;
        public var optObj:*;
        public var optItem:*;
        public var Len:*;
        public var optionList:*;
        public var hRun:Number;
        public var dRun:Number;
        public var oy:Number;
        public var mDown:Boolean;
        public var mbY:int;
        public var mbD:int;
        public var mhY:int;
        public var pos:int;
        public var i:int;
        public var optionGet:Array;
        private var toolTip:ToolTipMC;
        private var toolTipMC:*;
        internal var sDown:Boolean;

        public function dynamicoptions()
        {
            this.toolTip = new ToolTipMC();
            this.toolTipMC = this.addChild(this.toolTip);
            this.txtSearch.textField.background = true;
            this.txtSearch.textField.backgroundColor = 0x111111;
            this.initOptions();
            this.redraw(this.optionGet);
            this.SBar.h.addEventListener(MouseEvent.MOUSE_DOWN, this.onScrDown, false, 0, true);
            this.addEventListener(MouseEvent.MOUSE_UP, this.onScrUp, false, 0, true);
            this.addEventListener(MouseEvent.MOUSE_WHEEL, this.onWheel, false, 0, true);
            this.optionList.addEventListener(Event.ENTER_FRAME, this.hEF, false, 0, true);
            this.optionList.addEventListener(Event.ENTER_FRAME, this.dEF, false, 0, true);
            this.txtSearch.addEventListener(Event.CHANGE, this.onSearch, false, 0, true);
            this.btnClose.addEventListener(MouseEvent.CLICK, this.onClose, false, 0, true);
            if (main.isUpdated == false)
            {
                this.txtVersion.appendText(" (OUTDATED)");
                this.txtVersion.textColor = 0xFF0000;
                this.txtVersion.addEventListener(MouseEvent.CLICK, this.onGotoRelease);
            };
        }

        public function initOptions():void
        {
            this.optionGet = [{
                "strName":"Drops arrastavel",
                "bEnabled":main.sharedObject.data.draggable,
                "sDesc":"Permite arrastar os drops na tela usando o mouse"
            }, {
                "strName":"Drops detalhados ",
                "bEnabled":main.sharedObject.data.detaildrop,
                "sDesc":"Identifica itens dropados, se eles forem apenas membros,AC ou ambos\Clique no ícone do item para visualiza-lo!"
            }, {
                "strName":"Descrições aprimoradas dos itens",
                "bEnabled":main.sharedObject.data.boost,
                "sDesc":"Adiciona o valor da pilha de itens e informações extras as descrições dos itens no seu inventário"
            }, {
                "strName":"Quest Drop Rates",
                "bEnabled":main.sharedObject.data.qRates,
                "sDesc":"Substitui as taxas de drop de missoes do AQW pelas taxas de drop de quests originais do AQLite"
            }, {
                "strName":"Quest Reward Previews",
                "bEnabled":main.sharedObject.data.qPrev,
                "sDesc":"Permite que você clique nas recompensas da missao para visualizar sua aparencia. Voce pode visualizar o equipamento se clicar no '?' \! A interface do usuario e arrastavel!"
            }, {
                "strName":"Detailed Quest Rewards",
                "bEnabled":main.sharedObject.data.detailquest,
                "sDesc":"Identifica recompensas da missao se forem apenas membros,ac ou ambos"
            }, {
                "strName":"Permitir registro de missoes",
                "bEnabled":main.sharedObject.data.qLog,
                "sDesc":"Bloqueio de teclas: L \ Permite que voce entregue missoes usando seu log de missoes na tela inferior direita! Substituicao para falha de missao!"
            }, {
                "strName":"Aceitar a missao apos a devolucao",
                "bEnabled":main.sharedObject.data.qAccept,
                "sDesc":"Depois de entregar uma missao, ela tentara aceitar a missao, se possivel"
            }, {
                "strName":"Quest Pinner",
                "bEnabled":main.sharedObject.data.qPin,
                "sDesc":'Um substituto para falha na caixa de missoes. \ N1. Abra missoes de qualquer NPC \ n2. Pressione o botao "Pin Quests" \ n3. Agora voce pode acessa-lo de qualquer lugar clicando no icone amarelo (!) Do registro de missoes no canto superior esquerdo!'
            }, {
                "strName":"Desativar animacoes de habilidades",
                "bEnabled":main.sharedObject.data.disableSkillAnim,
                "sDesc":"Animacoes de habilidades de classe desativadas",
                "extra":[{
                    "strName":"Mostre apenas suas animacoes de habilidades",
                    "bEnabled":main.sharedObject.data.filterChecks["chkSelfOnly"],
                    "sDesc":'Funciona apenas se "Desativar animacoes de habilidades" estiver ativado!\Adiciona uma excecao a "Desativar animações de habilidades" para mostrar apenas suas animações de habilidades'
                }]
            }, {
                "strName":"Animacoes de habilidades personalizadas",
                "bEnabled":main.sharedObject.data.cSkillAnim,
                "sDesc":"Atualmente, apenas as classes suportadas: DragonLord, Void Highlord \ Void Highlord traz de volta suas animacoes graficas de habilidades pesadas!"
            }, {
                "strName":"Desativar animacoes de monstro",
                "bEnabled":main.sharedObject.data.disMonAnim,
                "sDesc":"Desativa as animacoes dos monstros"
            }, {
                "strName":"Classe Ativas / Auras UI",
                "bEnabled":main.sharedObject.data.skill,
                "sDesc":"(UI arrastavel) Mostre buffs/passivos e suas pilhas como o rastreador buff / passivo de um MMO comum"
            }, {
                "strName":"Congelar/Bloquear posicao do Monstro",
                "bEnabled":main.sharedObject.data.lockM,
                "sDesc":"Isso congelara os monstros no mapa para impedir que os jogadores atraiam / arrastem monstros por todo o mapa"
            }, {
                "strName":"Tipo de Monstro",
                "bEnabled":main.sharedObject.data.mType,
                "sDesc":"Mostra o tipo de monstro do seu alvo"
            }, {
                "strName":"Alvos mortos automatico",
                "bEnabled":main.sharedObject.data.untargetMon,
                "sDesc":"Isso desarmara os que ja estao mortos"
            }, {
                "strName":"Anti alvejamento",
                "bEnabled":main.sharedObject.data.selfTarget,
                "sDesc":"Isso impedira que você se alveje de qualquer maneira"
            }, {
                "strName":"UI de drops personalizados",
                "bEnabled":main.sharedObject.data.cDrops,
                "sDesc":"Um UI reimaginada de dropss do AQW",
                "extra":[{
                    "strName":"Notificacao de Drpos",
                    "bEnabled":main.sharedObject.data.filterChecks["chkCDropNotification"],
                    "sDesc":"Cada novo item dropado tera uma notificacao de drop acompanhada"
                }]
            }, {
                "strName":"Interface de usuario personalizada do SBP",
                "bEnabled":main.sharedObject.data.sbpcDrops,
                "sDesc":"Inspirado pela SharpBladePoint na R/AQW\N Uma interface do usuario reimaginada dos drops do AQW",
                "extra":[{
                    "strName":"Inverter Menu",
                    "bEnabled":main.sharedObject.data.filterChecks["chkInvertDrop"],
                    "sDesc":"Isso alterara o menu suspenso da interface do usuario personalizada do SBP, de deixar a lista para baixo e passar para cima"
                }]
            }, {
                "strName":"Ocultar jogadores",
                "bEnabled":main.sharedObject.data.hideP,
                "sDesc":"Isso ocultara os jogadores no mapa \ Desativar mostrará os jogadores novamente \Voce pode ocultar jogadores especificos clicando nos retratos deles (direcionando-os)!",
                "extra":[{
                    "strName":"Mostrar Tags de Nome",
                    "bEnabled":main.sharedObject.data.filterChecks["chkName"],
                    "sDesc":"So funciona se \"Ocultar jogadores\" estiver ativado! \N Com isso ativado permitira que voce veja as tags de nome dos jogadores, mesmo estando ocultos. Essa configuracao tambem funciona se voce ocultar jogadores especificos, segmentando-os e clicando nos retratos deles."
                }, {
                    "strName":"Mostrar Sombras",
                    "bEnabled":main.sharedObject.data.filterChecks["chkShadow"],
                    "sDesc":'So funciona se a opcao "Ocultar jogadores" estiver ativada! \ NA opcao "Ativar jogadores" permitira que voce ainda veja as sombras dos jogadores, e clicar nas sombras os direcionara. Essa configuracao tambem funciona se voce ocultar jogadores especificos, segmentando-os e clicando nos retratos deles.'
                }]
            }, {
                "strName":"Desativar animacoes de armas",
                "bEnabled":main.sharedObject.data.disWepAnim,
                "sDesc":"Animacoes de armas desativadas \ Voce pode desativar as animacoes de armas de um jogador especifico mirando nelas e clicando em seu retrato!",
                "extra":[{
                    "strName":"Mantenha apenas suas animacoes de armas",
                    "bEnabled":main.sharedObject.data.filterChecks["chkDisWepAnim"],
                    "sDesc":'Funciona apenas se a opcao "Desativar animacao de armas" estiver ativada! \ A ativacao dessa opcao permitira que as animacoes de armas continuem funcionando enquanto outras pessoas estoo desabilitadas.'
                }]
            }, {
                "strName":"Desativar animacies de mapa",
                "bEnabled":main.sharedObject.data.disMapAnim,
                "sDesc":"Desativar animacoes de mapa"
            }, {
                "strName":"Cache Players",
                "bEnabled":main.sharedObject.data.bitmapP,
                "sDesc":"Reduz os graficos de outros jogadores e congela-os no lugar. Util se voce ainda deseja ver outros jogadores, mas deseja um desempenho melhorado que \"Ocultar Jogadores\" oferece. AVISO! A ativacao dessa opcao pode ou nao mostrar alguns dos equipamentos de outros jogadores (falta de capacetes, etc.). Voce tambem nao poderaver as alteracoes nos equipamentos com isso ativado. Voce nao pode clicar em outros jogadores com isso ativado."
            }, {
                "strName":"Filtro do Bate-Papo",
                "bEnabled":main.sharedObject.data.chatFilter,
                "sDesc":"Ocultar mensagens de bate-papo, dependendo das configuracoes marcadas abaixo (mensagens de aviso vermelho, mensagens do servidor azul) \ Isso NAO ocultara as mensagens de desligamento do servidor!",
                "extra":[{
                    "strName":"Ocultar mensagens de aviso vermelhas",
                    "bEnabled":main.sharedObject.data.filterChecks["chkRed"],
                    "sDesc":"Oculta mensagens de aviso vermelhas"
                }, {
                    "strName":"Ocultar mensagens azuis do servidor",
                    "bEnabled":main.sharedObject.data.filterChecks["chkBlue"],
                    "sDesc":"Ocultar mensagens azuis do servidors"
                }, {
                    "strName":"Desativar mensagens de aviso de habilidade",
                    "bEnabled":main.sharedObject.data.filterChecks["chkRedSkills"],
                    "sDesc":"Voce deve voltar a ativar o filtro de bate-papo para que isso funcione! \ Desativa as mensagens de aviso de habilidade nao disponível"
                }]
            }, {
                "strName":"Desativar FX de som",
                "bEnabled":main.sharedObject.data.disableFX,
                "sDesc":"Desative os efeitos sonoros no jogo para voce apreciar a musica do jogo"
            }, {
                "strName":"Exibir FPS",
                "extra":"btn",
                "sDesc":"Alterna a exibicao de quadros por segundo"
            }, {
                "strName":"Seletor de cores",
                "extra":"btn",
                "sDesc":"Permite recuperar codigos de cores hexadecimais e valores RGB do que voce clica com o mouse"
            }, {
                "strName":"Recusar todos os drops",
                "extra":"btn",
                "sDesc":"Recusar todos os drops da tela"
            }, {
                "strName":"Item Drops Blacklist",
                "extra":"btn",
                "sDesc":"Recusar / bloquear automaticamente dropd que voce nao deseja"
            }, {
                "strName":"Fundo suave",
                "bEnabled":main.sharedObject.data.smoothBG,
                "sDesc":"Remove os pixels no mapa"
            }, {
                "strName":"Conjuntos de Sets",
                "bEnabled":main.sharedObject.data.bColorSets,
                "sDesc":"Um recurso que permite salvar e carregar conjuntos de cores para personalizacao de armaduras / cabelos! Se ativado, aparecera quando voce personalizar sua armadura / cabelo"
            }, {
                "strName":"Alfabetizar o Book of Lore",
                "bEnabled":main.sharedObject.data.alphBOL,
                "sDesc":"Classificars todos os emblemas do Book of Lore badges em ordem alfabetica"
            }, {
                "strName":"Ocultar Monstros",
                "bEnabled":main.sharedObject.data.hideM,
                "sDesc":"Ocultar monstros. Voce pode alveja-los clicando na sombra deles."
            }, {
                "strName":"O Arquivo",
                "bEnabled":main.sharedObject.data.theArchive,
                "sDesc":"Uma colecao de mapas esquecidos / ocultos / impopulares. Se ativado, ele pode ser encontrado no Book of Lore -> Missoes."
            }, {
                "strName":"Lista de Reputacao Limpa",
                "bEnabled":main.sharedObject.data.cleanRep,
                "sDesc":"Limpa a lista de reputacao, certificando-se de que o Rank 10 seja exibido como 0/0 \ nO Blacksmithing so sobe para o Rank 4 e sera exibido como Rank 10 \n Se voce mudar para desativado, e necessario fazer login novamente para que as alteracoes tenham efeito."
            }, {
                "strName":"Ferramenta de câmera",
                "extra":"btn",
                "sDesc":"WIP"
            }, {
                "strName":"Ocultar nomes de jogadores",
                "bEnabled":main.sharedObject.data.hidePNames,
                "sDesc":"Ocultar nomes de jogadores \ Passe o mouse sobre um jogador para revelar seu nome e guild"
            }, {
                "strName":"Battlepets",
                "bEnabled":main.sharedObject.data.bBattlePet,
                "sDesc":"Permite que os animais de estimacao em batalha lutem ao seu lado na batalha sem ter que equipar uma classe de animais de batalha!"
            }, {
                "strName":"Teleporte de entrada da casa",
                "bEnabled":main.sharedObject.data.bHouseEntrance,
                "sDesc":"Enquanto ja estiver em sua casa, se voce clicar no icone da casa (o mesmo que voce usa para ir para sua casa), voce pode se teletransportar para a entrada da sua casa!"
            }, {
                "strName":"Exibir uso da memoria",
                "extra":"btn",
                "sDesc":"Alterna a exibicao de uso de memoria"
            }];
        }

        public function onGotoRelease(e:MouseEvent):void
        {
            navigateToURL(new URLRequest("https://github.com/133spider/AQLite/releases/latest"), "_blank");
        }

        public function onClose(evt:MouseEvent):void
        {
            this.parent.removeChild(this);
            main.Game.ui.mcPopup.onClose();
        }

        public function onOver(e:MouseEvent):void
        {
            try
            {
                if (!e.target.parent.sDesc)
                {
                    return;
                };
                this.toolTip.openWith({"str":e.target.parent.sDesc});
            }
            catch(e)
            {
            };
        }

        public function onOut(e:MouseEvent):*
        {
            this.toolTip.close();
        }

        public function redraw(filteredArray:Array):void
        {
            var item:*;
            var j:int;
            this.SBar.h.y = 0;
            if (this.optionList != null)
            {
                this.removeChild(this.optionList);
                this.optionList = null;
            };
            this.optionList = this.addChild(new MovieClip());
            setChildIndex(this.toolTipMC, (numChildren - 1));
            this.Len = filteredArray.length;
            filteredArray.sortOn("strName");
            this.i = 0;
            var posI:* = 0;
            while (this.i < this.Len)
            {
                this.optObj = filteredArray[this.i];
                switch (true)
                {
                    case ((this.optObj.hasOwnProperty("extra")) && (this.optObj.extra is String)):
                        this.optItem = new listOptionsItemBtn(this.optObj.sDesc);
                        this.optItem.txtName.text = this.optObj.strName;
                        item = this.optionList.addChild(this.optItem);
                        item.x = this.cntMask.x;
                        item.y = (this.cntMask.y + (35 * posI));
                        item.addEventListener(MouseEvent.MOUSE_OVER, this.onOver, false, 0, true);
                        item.addEventListener(MouseEvent.MOUSE_OUT, this.onOut, false, 0, true);
                        break;
                    case ((this.optObj.hasOwnProperty("extra")) && (this.optObj.extra is Array)):
                        this.optItem = new listOptionsItem(this.optObj.bEnabled, this.optObj.sDesc);
                        this.optItem.txtName.text = this.optObj.strName;
                        item = this.optionList.addChild(this.optItem);
                        item.x = this.cntMask.x;
                        item.y = (this.cntMask.y + (35 * posI));
                        item.addEventListener(MouseEvent.MOUSE_OVER, this.onOver, false, 0, true);
                        item.addEventListener(MouseEvent.MOUSE_OUT, this.onOut, false, 0, true);
                        j = 0;
                        while (j < this.optObj.extra.length)
                        {
                            posI++;
                            this.optItem = new listOptionsItemExtra(this.optObj.extra[j].bEnabled, this.optObj.extra[j].sDesc);
                            this.optItem.txtName.text = this.optObj.extra[j].strName;
                            item = this.optionList.addChild(this.optItem);
                            item.x = (this.cntMask.x + 9);
                            item.y = (this.cntMask.y + (35 * posI));
                            item.addEventListener(MouseEvent.MOUSE_OVER, this.onOver, false, 0, true);
                            item.addEventListener(MouseEvent.MOUSE_OUT, this.onOut, false, 0, true);
                            j++;
                        };
                        break;
                    default:
                        this.optItem = new listOptionsItem(this.optObj.bEnabled, this.optObj.sDesc);
                        this.optItem.txtName.text = this.optObj.strName;
                        item = this.optionList.addChild(this.optItem);
                        item.x = this.cntMask.x;
                        item.y = (this.cntMask.y + (35 * posI));
                        item.addEventListener(MouseEvent.MOUSE_OVER, this.onOver, false, 0, true);
                        item.addEventListener(MouseEvent.MOUSE_OUT, this.onOut, false, 0, true);
                };
                this.i++;
                posI++;
            };
            this.optionList.mask = this.cntMask;
            this.mDown = false;
            this.hRun = (this.SBar.b.height - this.SBar.h.height);
            this.dRun = ((this.optionList.height - this.cntMask.height) + 5);
            this.oy = this.optionList.y;
            this.optionList.addEventListener(Event.ENTER_FRAME, this.hEF, false, 0, true);
            this.optionList.addEventListener(Event.ENTER_FRAME, this.dEF, false, 0, true);
        }

        public function onSearch(e:Event):void
        {
            this.txtSearch.textField.setTextFormat(new TextFormat("Arial", 16, 0xFFFFFF), (this.txtSearch.textField.caretIndex - 1));
            this.initOptions();
            var _tempArray:Array = new Array();
            var k:int;
            while (k < this.optionGet.length)
            {
                if (this.optionGet[k].strName.toLowerCase().indexOf(this.txtSearch.text.toLowerCase()) > -1)
                {
                    _tempArray.push(this.optionGet[k]);
                };
                k++;
            };
            if (_tempArray.length <= 9)
            {
                this.SBar.h.removeEventListener(MouseEvent.MOUSE_DOWN, this.onScrDown);
                this.removeEventListener(MouseEvent.MOUSE_UP, this.onScrUp);
                this.removeEventListener(MouseEvent.MOUSE_WHEEL, this.onWheel);
            }
            else
            {
                if (((_tempArray.length > 9) && (!(this.SBar.h.hasEventListener(MouseEvent.MOUSE_DOWN)))))
                {
                    this.SBar.h.addEventListener(MouseEvent.MOUSE_DOWN, this.onScrDown, false, 0, true);
                    this.addEventListener(MouseEvent.MOUSE_UP, this.onScrUp, false, 0, true);
                    this.addEventListener(MouseEvent.MOUSE_WHEEL, this.onWheel, false, 0, true);
                };
            };
            this.redraw(((this.txtSearch.text) ? _tempArray : this.optionGet));
            _tempArray = null;
        }

        public function onWheel(e:MouseEvent):void
        {
            var _local2:*;
            _local2 = this.SBar;
            _local2.h.y = (int(this.SBar.h.y) + ((e.delta * 3) * -1));
            if ((_local2.h.y + _local2.h.height) > _local2.b.height)
            {
                _local2.h.y = int((_local2.b.height - _local2.h.height));
            };
            if (_local2.h.y < 0)
            {
                _local2.h.y = 0;
            };
        }

        public function onScrDown(param1:MouseEvent):*
        {
            this.mbY = int(mouseY);
            this.mhY = int(this.SBar.h.y);
            this.mDown = true;
        }

        public function onScrUp(param1:MouseEvent):void
        {
            this.mDown = false;
        }

        public function hEF(_arg1:Event):*
        {
            var _local2:*;
            if (this.mDown)
            {
                _local2 = this.SBar;
                this.mbD = (int(mouseY) - this.mbY);
                _local2.h.y = (this.mhY + this.mbD);
                if (((_local2.h.y + 1) + _local2.h.height) > (_local2.b.height + 1))
                {
                    _local2.h.y = int(((_local2.b.height + 1) - _local2.h.height));
                };
                if (_local2.h.y < 1)
                {
                    _local2.h.y = 1;
                };
            };
        }

        public function dEF(_arg1:Event):*
        {
            var _local2:* = this.SBar;
            var _local3:* = this.optionList;
            var _local4:* = (-(_local2.h.y - 1) / this.hRun);
            var _local5:* = (int((_local4 * this.dRun)) + this.oy);
            if (Math.abs((_local5 - _local3.y)) > 0.2)
            {
                _local3.y = (_local3.y + ((_local5 - _local3.y) / 4));
            }
            else
            {
                _local3.y = _local5;
            };
        }


    }
}//package net.spider.modules

