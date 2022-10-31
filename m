Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDF76613466
	for <lists+linux-wireless@lfdr.de>; Mon, 31 Oct 2022 12:21:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbiJaLVF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 31 Oct 2022 07:21:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbiJaLVD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 31 Oct 2022 07:21:03 -0400
Received: from smtp-bc0c.mail.infomaniak.ch (smtp-bc0c.mail.infomaniak.ch [IPv6:2001:1600:4:17::bc0c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56710DFBE
        for <linux-wireless@vger.kernel.org>; Mon, 31 Oct 2022 04:20:59 -0700 (PDT)
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [10.4.36.107])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4N19gr50ZCzMpp36;
        Mon, 31 Oct 2022 12:20:56 +0100 (CET)
Received: from [127.0.0.1] (unknown [10.92.206.117])
        by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4N19gr3WLdzxJ;
        Mon, 31 Oct 2022 12:20:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fls.name; s=20200831;
        t=1667215256; bh=ZIuT6VVRz1mbb2shjXq4OUbJUD0GR3x22qFedF3GFIY=;
        h=Date:Subject:From:Reply-To:To:Cc:References:In-Reply-To:From;
        b=SEFW09ew76ur+qfi6T20p2plGHlWVTfRyqKYIzHavxB6sg3fbsqX/KooTNzTsanDW
         Vq51kNqGVtvRm5zuxYoft6YbYKgVV22WznPhMc7VRvd6nyt+DAc13laZSYskIQ3qbP
         Injw7lnPg1msJgtRnPItCo//OTSu7Y3oAzNTdHoA=
Message-ID: <d7af605e900846de2afc0a6c7d9fb9ab@mail.infomaniak.com>
Date:   Mon, 31 Oct 2022 12:20:56 +0100
Subject: Re: iwlwifi: intel ax210: module fail load firmware: Failed to start
 RT ucode: -110
From:   Florian Schmidt <florian@fls.name>
Reply-To: Florian Schmidt <florian@fls.name>
To:     Greenman Gregory <gregory.greenman@intel.com>
Cc:     "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-WS-User-Origin: eyJpdiI6ImlyS1ZhdEsyb2YvU1kwVmgxVHR6SXc9PSIsInZhbHVlIjoiVExpNGxyKzA4R0xnSGNqMHhnY0R0QT09IiwibWFjIjoiZmE1OTU0OWY1OWMyYWE1OTkzYzlhMmMzNWRiNWRjMDNlMTFhNmQxZDkxYWQyNmM3NzI4Njg1NTAwM2Y1ZjA0OSIsInRhZyI6IiJ9
X-WS-User-Mbox: eyJpdiI6InM3RXU2Uzh5eUEvajFwSGpLc28vTUE9PSIsInZhbHVlIjoidjhkT3E0UmZidzRmU0gxMjMvT25Pdz09IiwibWFjIjoiZGNkYTA2ZTdmMzJiMWE1Y2ViZGVkMzRkZTg2MmU5ZDEzNTYyNTgyOWE5MDljYzU5NWM0MzAzZTU3ZjdlOWQxZSIsInRhZyI6IiJ9
X-WS-Location: eJxzKUpMKykGAAfpAmU-
X-Mailer: Infomaniak Workspace (1.3.388)
References: <91cad7f52fe275bf567cf5aa7aa6f7c0@mail.infomaniak.com>
 <28dfa897c38286b1cf9ae30631fb7438@mail.infomaniak.com>
 <59fe5bdc361fed71103ee159cdb5ab64@mail.infomaniak.com>
 <f351b0a31b536e7a29d63937a242d5de7e2552ca.camel@intel.com>
 <4077a7705bb86501a9cbbce86fe1ea8c@mail.infomaniak.com>
 <cba07be4-1afc-649f-a172-19f76d726232@gmail.com>
 <79d2434a0160d0c9b677b8144459beca@mail.infomaniak.com>
 <e7b7879d-6488-2993-ea3e-98b0718a0c87@gmail.com>
 <e6336941d3f950146c72487501d3ce10@mail.infomaniak.com>
 <967666583124daef96680c4eb4329a386fd3bcd5.camel@intel.com>
In-Reply-To: <967666583124daef96680c4eb4329a386fd3bcd5.camel@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2022-10-31T08:49:33.000+00:00, Greenman Gregory <gregory.greenman@intel.=
com> wrote:

>  On Wed, 2022-10-26 at 20:11 +0200, Florian Schmidt wrote:
>=20
> >    On 2022-10-26T18:47:20.000+01:00, Florian Fainelli <f.fainelli@gmail=
.com> wrote:
> > =20
> >=20
> > >      On 10/26/22 10:37, Florian Schmidt wrote:
> > >  =20
> > >=20
> > > >         On 2022-10-26T18:04:33.000+01:00, Florian Fainelli <f.faine=
lli@gmail.com> wrote:
> > > >    =20
> > > >   =20
> > > >=20
> > > > >            On 10/26/2022 8:56 AM, Florian Schmidt wrote:
> > > > >    =20
> > > > >    =20
> > > > >=20
> > > > > >               Hi Gregory,
> > > > > >        =20
> > > > > >         Thank you for having a look at this. The .pnvm file was=
 present in my test as shown by my original message:
> > > > > >     =20
> > > > > >     =20
> > > > > >=20
> > > > > > >                md5sum /lib/firmware/*
> > > > > > >          787381c60d907f81a3ddadc5c990a82b ./iwlwifi-ty-a0-gf-=
a0-71.ucode
> > > > > > >          d93cbdcc4bb5be69aac128e2fe291359 ./iwlwifi-ty-a0-gf-=
a0.pnvm
> > > > > > >          33d13d236512466e71c81257209a356f ./regulatory.db
> > > > > >           =20
> > > > > >         I just ran the test again, ensuring I have the .pnvm yo=
u mention and the result is indeed the same.
> > > > > >        =20
> > > > > >         Any other ideas to solve this are welcome.
> > > > >         =20
> > > > >      The driver indicated it wanted to load iwlwifi-ty-a0-gf-a0-7=
2.ucode,
> > > > >      which you do seem to have based upon the listing above?
> > > > >      --=20
> > > > >      Florian
> > > >      =20
> > > >     Hi Florian,
> > > >    =20
> > > >     Indeed, my first log seems to load -72.ucode when my dump show =
a -71 file, that's strange. I must have mismatched some test, sorry for the=
 confusion. During my tests, I've actually tried with
> > > >    many different firmwares (I think I've done all the compatible f=
irmware I could find), tested both with and without the pnvm file and many =
kernel versions, it always seems to fail. The
> > > >    suspicious thing to me is that during my tests, I've confirmed s=
everal times that the same sets of wifi card, kernel and firmware work well=
 on my intel desktop.
> > > >    =20
> > > >     Below are the logs from my latest test today with firmware -71 =
and the .pnvm from git.
> > > >    =20
> > > >     I'd be happy to help debug more, but I have zero visibility on =
the firmware so those register dumps just mean nothing to me. Let me know h=
ow I can assist with this.
> > >    =20
> > >   I am not familiar with ax210, but have worked quite a bit with the =
7260=20
> > >   chips (iwlwifi) and errors like those typically occurred when the P=
CIe=20
> > >   end-point device, that is the ax210 is not able to do PCIe inbound=
=20
> > >   accesses into your system's memory. Now in your case it could be th=
at=20
> > >   the inaility to load the appropriate ucode results in ... you guess=
ed=20
> > >   it, the ucode not being loaded which causes the timeout to happen.
> > >  =20
> > >   Can you tell us more about your ARM32 system here? What PCIe host=
=20
> > >   bridge/controller does it use, do you have an IOMMU attached to tha=
t=20
> > >   PCIe host brideg somehow?
> > >  =20
> > >   Thanks!
> > >  =20
> >  =20
> >  We're using a Xilinx FPGA Based PCIe root complex on a custom zynq-700=
 board. The doc of the PCIe block can be found here:
> >  https://www.xilinx.com/content/dam/xilinx/support/documents/ip_documen=
tation/axi_pcie/v2_8/pg055-axi-bridge-pcie.pdf
> > =20
> >  I'm not really familiar with IOMMU (or PCIexpress) but to my knowledge=
 there is no support of IOMMU on our arm32 platform, at least I couldn't en=
able it in kernel options, it required some other
> >  platform flags.
> > =20
> >  You can find everything lspci has to say about our device below.
> > =20
> >  root@BV1-27109:~# lspci -vv
> >  00:00.0 PCI bridge: Xilinx Corporation Device 7121 (prog-if 00 [Normal=
 decode])
> >          Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- Pa=
rErr+ Stepping- SERR+ FastB2B- DisINTx-
> >          Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast TAbort=
- <TAbort- <MAbort- SERR- <PERR- INTx-
> >          Latency: 0, Cache Line Size: 64 bytes
> >          Bus: primary=3D00, secondary=3D01, subordinate=3D01, sec-laten=
cy=3D0
> >          I/O behind bridge: 00000000-00000fff [size=3D4K]
> >          Memory behind bridge: 00000000-000fffff [size=3D1M]
> >          Prefetchable memory behind bridge: 00000000-000fffff [size=3D1=
M]
> >          Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=3Dfast TAbort=
- <TAbort- <MAbort- <SERR- <PERR-
> >          BridgeCtl: Parity+ SERR+ NoISA- VGA- VGA16- MAbort- Reset- Fas=
tB2B-
> >                  PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
> >          Capabilities: [40] Power Management version 3
> >                  Flags: PMEClk- DSI+ D1- D2- AuxCurrent=3D0mA PME(D0-,D=
1-,D2-,D3hot-,D3cold-)
> >                  Status: D0 NoSoftRst+ PME-Enable- DSel=3D0 DScale=3D0 =
PME-
> >          Capabilities: [48] MSI: Enable- Count=3D1/32 Maskable+ 64bit+
> >                  Address: 0000000000000000  Data: 0000
> >                  Masking: 00000000  Pending: 00000000
> >          Capabilities: [60] Express (v2) Root Port (Slot+), MSI 00
> >                  DevCap: MaxPayload 256 bytes, PhantFunc 1
> >                          ExtTag+ RBE+
> >                  DevCtl: CorrErr- NonFatalErr- FatalErr- UnsupReq-
> >                          RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+
> >                          MaxPayload 128 bytes, MaxReadReq 512 bytes
> >                  DevSta: CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxP=
wr- TransPend-
> >                  LnkCap: Port #0, Speed 5GT/s, Width x1, ASPM L0s, Exit=
 Latency L0s unlimited
> >                          ClockPM- Surprise- LLActRep+ BwNot+ ASPMOptCom=
p-
> >                  LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- CommClk-
> >                          ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
> >                  LnkSta: Speed 5GT/s (ok), Width x1 (ok)
> >                          TrErr- Train- SlotClk+ DLActive+ BWMgmt- ABWMg=
mt+
> >                  SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlu=
g- Surprise-
> >                          Slot #0, PowerLimit 0.000W; Interlock- NoCompl=
-
> >                  SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt=
- HPIrq- LinkChg-
> >                          Control: AttnInd Off, PwrInd Off, Power- Inter=
lock-
> >                  SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresD=
et- Interlock-
> >                          Changed: MRL- PresDet- LinkState-
> >                  RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIn=
tEna- CRSVisible-
> >                  RootCap: CRSVisible-
> >                  RootSta: PME ReqID 0000, PMEStatus- PMEPending-
> >                  DevCap2: Completion Timeout: Not Supported, TimeoutDis=
-, LTR-, OBFF Not Supported ARIFwd-
> >                           AtomicOpsCap: Routing- 32bit- 64bit- 128bitCA=
S-
> >                  DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-=
, LTR-, OBFF Disabled ARIFwd-
> >                           AtomicOpsCtl: ReqEn- EgressBlck-
> >                  LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- Sp=
eedDis-
> >                           Transmit Margin: Normal Operating Range, Ente=
rModifiedCompliance- ComplianceSOS-
> >                           Compliance De-emphasis: -6dB
> >                  LnkSta2: Current De-emphasis Level: -3.5dB, Equalizati=
onComplete-, EqualizationPhase1-
> >                           EqualizationPhase2-, EqualizationPhase3-, Lin=
kEqualizationRequest-
> >          Capabilities: [100 v1] Device Serial Number 00-00-00-00-00-00-=
00-00
> >          Capabilities: [128 v1] Vendor Specific Information: ID=3D0001 =
Rev=3D0 Len=3D038 <?>
> >          Capabilities: [200 v1] Vendor Specific Information: ID=3D0002 =
Rev=3D0 Len=3D038 <?>
> > =20
> >  01:00.0 Network controller: Intel Corporation Device 2725 (rev 1a)
> >          Subsystem: Intel Corporation Device 0020
> >          Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- Pa=
rErr- Stepping- SERR- FastB2B- DisINTx-
> >          Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast TAbort=
- <TAbort- <MAbort- SERR- <PERR- INTx-
> >          Interrupt: pin A routed to IRQ 52
> >          Region 0: Memory at 80000000 (64-bit, non-prefetchable) [size=
=3D16K]
> >          Capabilities: [c8] Power Management version 3
> >                  Flags: PMEClk- DSI+ D1- D2- AuxCurrent=3D0mA PME(D0+,D=
1-,D2-,D3hot+,D3cold+)
> >                  Status: D0 NoSoftRst+ PME-Enable- DSel=3D0 DScale=3D0 =
PME-
> >          Capabilities: [d0] MSI: Enable- Count=3D1/1 Maskable- 64bit+
> >                  Address: 0000000001374000  Data: 0000
> >          Capabilities: [40] Express (v2) Endpoint, MSI 00
> >                  DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s=
 <512ns, L1 unlimited
> >                          ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset=
+ SlotPowerLimit 0.000W
> >                  DevCtl: CorrErr- NonFatalErr- FatalErr- UnsupReq-
> >                          RlxdOrd+ ExtTag- PhantFunc- On Wed, 2022-10-26=
 at 20:11 +0200, Florian Schmidt wrote:
> >  On 2022-10-26T18:47:20.000+01:00, Florian Fainelli <f.fainelli@gmail.c=
om> wrote:
> > =20
> >=20
> > >      On 10/26/22 10:37, Florian Schmidt wrote:
> > >  =20
> > >=20
> > > >         On 2022-10-26T18:04:33.000+01:00, Florian Fainelli <f.faine=
lli@gmail.com> wrote:
> > > >    =20
> > > >   =20
> > > >=20
> > > > >            On 10/26/2022 8:56 AM, Florian Schmidt wrote:
> > > > >    =20
> > > > >    =20
> > > > >=20
> > > > > >               Hi Gregory,
> > > > > >        =20
> > > > > >         Thank you for having a look at this. The .pnvm file was=
 present in my test as shown by my original message:
> > > > > >     =20
> > > > > >     =20
> > > > > >=20
> > > > > > >                md5sum /lib/firmware/*
> > > > > > >          787381c60d907f81a3ddadc5c990a82b ./iwlwifi-ty-a0-gf-=
a0-71.ucode
> > > > > > >          d93cbdcc4bb5be69aac128e2fe291359 ./iwlwifi-ty-a0-gf-=
a0.pnvm
> > > > > > >          33d13d236512466e71c81257209a356f ./regulatory.db
> > > > > >           =20
> > > > > >         I just ran the test again, ensuring I have the .pnvm yo=
u mention and the result is indeed the same.
> > > > > >        =20
> > > > > >         Any other ideas to solve this are welcome.
> > > > >         =20
> > > > >      The driver indicated it wanted to load iwlwifi-ty-a0-gf-a0-7=
2.ucode,
> > > > >      which you do seem to have based upon the listing above?
> > > > >      --=20
> > > > >      Florian
> > > >      =20
> > > >     Hi Florian,
> > > >    =20
> > > >     Indeed, my first log seems to load -72.ucode when my dump show =
a -71 file, that's strange. I must have mismatched some test, sorry for the=
 confusion. During my tests, I've actually tried with
> > > >    many different firmwares (I think I've done all the compatible f=
irmware I could find), tested both with and without the pnvm file and many =
kernel versions, it always seems to fail. The
> > > >    suspicious thing to me is that during my tests, I've confirmed s=
everal times that the same sets of wifi card, kernel and firmware work well=
 on my intel desktop.
> > > >    =20
> > > >     Below are the logs from my latest test today with firmware -71 =
and the .pnvm from git.
> > > >    =20
> > > >     I'd be happy to help debug more, but I have zero visibility on =
the firmware so those register dumps just mean nothing to me. Let me know h=
ow I can assist with this.
> > >    =20
> > >   I am not familiar with ax210, but have worked quite a bit with the =
7260=20
> > >   chips (iwlwifi) and errors like those typically occurred when the P=
CIe=20
> > >   end-point device, that is the ax210 is not able to do PCIe inbound=
=20
> > >   accesses into your system's memory. Now in your case it could be th=
at=20
> > >   the inaility to load the appropriate ucode results in ... you guess=
ed=20
> > >   it, the ucode not being loaded which causes the timeout to happen.
> > >  =20
> > >   Can you tell us more about your ARM32 system here? What PCIe host=
=20
> > >   bridge/controller does it use, do you have an IOMMU attached to tha=
t=20
> > >   PCIe host brideg somehow?
> > >  =20
> > >   Thanks!
> > >  =20
> >  =20
> >  We're using a Xilinx FPGA Based PCIe root complex on a custom zynq-700=
 board. The doc of the PCIe block can be found here:
> >  https://www.xilinx.com/content/dam/xilinx/support/documents/ip_documen=
tation/axi_pcie/v2_8/pg055-axi-bridge-pcie.pdf
> > =20
> >  I'm not really familiar with IOMMU (or PCIexpress) but to my knowledge=
 there is no support of IOMMU on our arm32 platform, at least I couldn't en=
able it in kernel options, it required some other
> >  platform flags.
> > =20
> >  You can find everything lspci has to say about our device below.
> > =20
> >  root@BV1-27109:~# lspci -vv
> >  00:00.0 PCI bridge: Xilinx Corporation Device 7121 (prog-if 00 [Normal=
 decode])
> >          Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- Pa=
rErr+ Stepping- SERR+ FastB2B- DisINTx-
> >          Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast TAbort=
- <TAbort- <MAbort- SERR- <PERR- INTx-
> >          Latency: 0, Cache Line Size: 64 bytes
> >          Bus: primary=3D00, secondary=3D01, subordinate=3D01, sec-laten=
cy=3D0
> >          I/O behind bridge: 00000000-00000fff [size=3D4K]
> >          Memory behind bridge: 00000000-000fffff [size=3D1M]
> >          Prefetchable memory behind bridge: 00000000-000fffff [size=3D1=
M]
> >          Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=3Dfast TAbort=
- <TAbort- <MAbort- <SERR- <PERR-
> >          BridgeCtl: Parity+ SERR+ NoISA- VGA- VGA16- MAbort- Reset- Fas=
tB2B-
> >                  PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
> >          Capabilities: [40] Power Management version 3
> >                  Flags: PMEClk- DSI+ D1- D2- AuxCurrent=3D0mA PME(D0-,D=
1-,D2-,D3hot-,D3cold-)
> >                  Status: D0 NoSoftRst+ PME-Enable- DSel=3D0 DScale=3D0 =
PME-
> >          Capabilities: [48] MSI: Enable- Count=3D1/32 Maskable+ 64bit+
> >                  Address: 0000000000000000  Data: 0000
> >                  Masking: 00000000  Pending: 00000000
> >          Capabilities: [60] Express (v2) Root Port (Slot+), MSI 00
> >                  DevCap: MaxPayload 256 bytes, PhantFunc 1
> >                          ExtTag+ RBE+
> >                  DevCtl: CorrErr- NonFatalErr- FatalErr- UnsupReq-
> >                          RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+
> >                          MaxPayload 128 bytes, MaxReadReq 512 bytes
> >                  DevSta: CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxP=
wr- TransPend-
> >                  LnkCap: Port #0, Speed 5GT/s, Width x1, ASPM L0s, Exit=
 Latency L0s unlimited
> >                          ClockPM- Surprise- LLActRep+ BwNot+ ASPMOptCom=
p-
> >                  LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- CommClk-
> >                          ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
> >                  LnkSta: Speed 5GT/s (ok), Width x1 (ok)
> >                          TrErr- Train- SlotClk+ DLActive+ BWMgmt- ABWMg=
mt+
> >                  SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlu=
g- Surprise-
> >                          Slot #0, PowerLimit 0.000W; Interlock- NoCompl=
-
> >                  SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt=
- HPIrq- LinkChg-
> >                          Control: AttnInd Off, PwrInd Off, Power- Inter=
lock-
> >                  SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresD=
et- Interlock-
> >                          Changed: MRL- PresDet- LinkState-
> >                  RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIn=
tEna- CRSVisible-
> >                  RootCap: CRSVisible-
> >                  RootSta: PME ReqID 0000, PMEStatus- PMEPending-
> >                  DevCap2: Completion Timeout: Not Supported, TimeoutDis=
-, LTR-, OBFF Not Supported ARIFwd-
> >                           AtomicOpsCap: Routing- 32bit- 64bit- 128bitCA=
S-
> >                  DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-=
, LTR-, OBFF Disabled ARIFwd-
> >                           AtomicOpsCtl: ReqEn- EgressBlck-
> >                  LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- Sp=
eedDis-
> >                           Transmit Margin: Normal Operating Range, Ente=
rModifiedCompliance- ComplianceSOS-
> >                           Compliance De-emphasis: -6dB
> >                  LnkSta2: Current De-emphasis Level: -3.5dB, Equalizati=
onComplete-, EqualizationPhase1-
> >                           EqualizationPhase2-, EqualizationPhase3-, Lin=
kEqualizationRequest-
> >          Capabilities: [100 v1] Device Serial Number 00-00-00-00-00-00-=
00-00
> >          Capabilities: [128 v1] Vendor Specific Information: ID=3D0001 =
Rev=3D0 Len=3D038 <?>
> >          Capabilities: [200 v1] Vendor Specific Information: ID=3D0002 =
Rev=3D0 Len=3D038 <?>
> > =20
> >  01:00.0 Network controller: Intel Corporation Device 2725 (rev 1a)
> >          Subsystem: Intel Corporation Device 0020
> >          Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- Pa=
rErr- Stepping- SERR- FastB2B- DisINTx-
> >          Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast TAbort=
- <TAbort- <MAbort- SERR- <PERR- INTx-
> >          Interrupt: pin A routed to IRQ 52
> >          Region 0: Memory at 80000000 (64-bit, non-prefetchable) [size=
=3D16K]
> >          Capabilities: [c8] Power Management version 3
> >                  Flags: PMEClk- DSI+ D1- D2- AuxCurrent=3D0mA PME(D0+,D=
1-,D2-,D3hot+,D3cold+)
> >                  Status: D0 NoSoftRst+ PME-Enable- DSel=3D0 DScale=3D0 =
PME-
> >          Capabilities: [d0] MSI: Enable- Count=3D1/1 Maskable- 64bit+
> >                  Address: 0000000001374000  Data: 0000
> >          Capabilities: [40] Express (v2) Endpoint, MSI 00
> >                  DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s=
 <512ns, L1 unlimited
> >                          ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset=
+ SlotPowerLimit 0.000W
> >                  DevCtl: CorrErr- NonFatalErr- FatalErr- UnsupReq-
> >                          RlxdOrd+ ExtTag- PhantFunc- On Wed, 2022-10-26=
 at 20:11 +0200, Florian Schmidt wrote:
> >  On 2022-10-26T18:47:20.000+01:00, Florian Fainelli <f.fainelli@gmail.c=
om> wrote:
> > =20
> >=20
> > >      On 10/26/22 10:37, Florian Schmidt wrote:
> > >  =20
> > >=20
> > > >         On 2022-10-26T18:04:33.000+01:00, Florian Fainelli <f.faine=
lli@gmail.com> wrote:
> > > >    =20
> > > >   =20
> > > >=20
> > > > >            On 10/26/2022 8:56 AM, Florian Schmidt wrote:
> > > > >    =20
> > > > >    =20
> > > > >=20
> > > > > >               Hi Gregory,
> > > > > >        =20
> > > > > >         Thank you for having a look at this. The .pnvm file was=
 present in my test as shown by my original message:
> > > > > >     =20
> > > > > >     =20
> > > > > >=20
> > > > > > >                md5sum /lib/firmware/*
> > > > > > >          787381c60d907f81a3ddadc5c990a82b ./iwlwifi-ty-a0-gf-=
a0-71.ucode
> > > > > > >          d93cbdcc4bb5be69aac128e2fe291359 ./iwlwifi-ty-a0-gf-=
a0.pnvm
> > > > > > >          33d13d236512466e71c81257209a356f ./regulatory.db
> > > > > >           =20
> > > > > >         I just ran the test again, ensuring I have the .pnvm yo=
u mention and the result is indeed the same.
> > > > > >        =20
> > > > > >         Any other ideas to solve this are welcome.
> > > > >         =20
> > > > >      The driver indicated it wanted to load iwlwifi-ty-a0-gf-a0-7=
2.ucode,
> > > > >      which you do seem to have based upon the listing above?
> > > > >      --=20
> > > > >      Florian
> > > >      =20
> > > >     Hi Florian,
> > > >    =20
> > > >     Indeed, my first log seems to load -72.ucode when my dump show =
a -71 file, that's strange. I must have mismatched some test, sorry for the=
 confusion. During my tests, I've actually tried with
> > > >    many different firmwares (I think I've done all the compatible f=
irmware I could find), tested both with and without the pnvm file and many =
kernel versions, it always seems to fail. The
> > > >    suspicious thing to me is that during my tests, I've confirmed s=
everal times that the same sets of wifi card, kernel and firmware work well=
 on my intel desktop.
> > > >    =20
> > > >     Below are the logs from my latest test today with firmware -71 =
and the .pnvm from git.
> > > >    =20
> > > >     I'd be happy to help debug more, but I have zero visibility on =
the firmware so those register dumps just mean nothing to me. Let me know h=
ow I can assist with this.
> > >    =20
> > >   I am not familiar with ax210, but have worked quite a bit with the =
7260=20
> > >   chips (iwlwifi) and errors like those typically occurred when the P=
CIe=20
> > >   end-point device, that is the ax210 is not able to do PCIe inbound=
=20
> > >   accesses into your system's memory. Now in your case it could be th=
at=20
> > >   the inaility to load the appropriate ucode results in ... you guess=
ed=20
> > >   it, the ucode not being loaded which causes the timeout to happen.
> > >  =20
> > >   Can you tell us more about your ARM32 system here? What PCIe host=
=20
> > >   bridge/controller does it use, do you have an IOMMU attached to tha=
t=20
> > >   PCIe host brideg somehow?
> > >  =20
> > >   Thanks!
> > >  =20
> >  =20
> >  We're using a Xilinx FPGA Based PCIe root complex on a custom zynq-700=
 board. The doc of the PCIe block can be found here:
> >  https://www.xilinx.com/content/dam/xilinx/support/documents/ip_documen=
tation/axi_pcie/v2_8/pg055-axi-bridge-pcie.pdf
> > =20
> >  I'm not really familiar with IOMMU (or PCIexpress) but to my knowledge=
 there is no support of IOMMU on our arm32 platform, at least I couldn't en=
able it in kernel options, it required some other
> >  platform flags.
> > =20
> >  You can find everything lspci has to say about our device below.
> > =20
> >  root@BV1-27109:~# lspci -vv
> >  00:00.0 PCI bridge: Xilinx Corporation Device 7121 (prog-if 00 [Normal=
 decode])
> >          Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- Pa=
rErr+ Stepping- SERR+ FastB2B- DisINTx-
> >          Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast TAbort=
- <TAbort- <MAbort- SERR- <PERR- INTx-
> >          Latency: 0, Cache Line Size: 64 bytes
> >          Bus: primary=3D00, secondary=3D01, subordinate=3D01, sec-laten=
cy=3D0
> >          I/O behind bridge: 00000000-00000fff [size=3D4K]
> >          Memory behind bridge: 00000000-000fffff [size=3D1M]
> >          Prefetchable memory behind bridge: 00000000-000fffff [size=3D1=
M]
> >          Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=3Dfast TAbort=
- <TAbort- <MAbort- <SERR- <PERR-
> >          BridgeCtl: Parity+ SERR+ NoISA- VGA- VGA16- MAbort- Reset- Fas=
tB2B-
> >                  PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
> >          Capabilities: [40] Power Management version 3
> >                  Flags: PMEClk- DSI+ D1- D2- AuxCurrent=3D0mA PME(D0-,D=
1-,D2-,D3hot-,D3cold-)
> >                  Status: D0 NoSoftRst+ PME-Enable- DSel=3D0 DScale=3D0 =
PME-
> >          Capabilities: [48] MSI: Enable- Count=3D1/32 Maskable+ 64bit+
> >                  Address: 0000000000000000  Data: 0000
> >                  Masking: 00000000  Pending: 00000000
> >          Capabilities: [60] Express (v2) Root Port (Slot+), MSI 00
> >                  DevCap: MaxPayload 256 bytes, PhantFunc 1
> >                          ExtTag+ RBE+
> >                  DevCtl: CorrErr- NonFatalErr- FatalErr- UnsupReq-
> >                          RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+
> >                          MaxPayload 128 bytes, MaxReadReq 512 bytes
> >                  DevSta: CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxP=
wr- TransPend-
> >                  LnkCap: Port #0, Speed 5GT/s, Width x1, ASPM L0s, Exit=
 Latency L0s unlimited
> >                          ClockPM- Surprise- LLActRep+ BwNot+ ASPMOptCom=
p-
> >                  LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- CommClk-
> >                          ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
> >                  LnkSta: Speed 5GT/s (ok), Width x1 (ok)
> >                          TrErr- Train- SlotClk+ DLActive+ BWMgmt- ABWMg=
mt+
> >                  SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlu=
g- Surprise-
> >                          Slot #0, PowerLimit 0.000W; Interlock- NoCompl=
-
> >                  SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt=
- HPIrq- LinkChg-
> >                          Control: AttnInd Off, PwrInd Off, Power- Inter=
lock-
> >                  SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresD=
et- Interlock-
> >                          Changed: MRL- PresDet- LinkState-
> >                  RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIn=
tEna- CRSVisible-
> >                  RootCap: CRSVisible-
> >                  RootSta: PME ReqID 0000, PMEStatus- PMEPending-
> >                  DevCap2: Completion Timeout: Not Supported, TimeoutDis=
-, LTR-, OBFF Not Supported ARIFwd-
> >                           AtomicOpsCap: Routing- 32bit- 64bit- 128bitCA=
S-
> >                  DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-=
, LTR-, OBFF Disabled ARIFwd-
> >                           AtomicOpsCtl: ReqEn- EgressBlck-
> >                  LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- Sp=
eedDis-
> >                           Transmit Margin: Normal Operating Range, Ente=
rModifiedCompliance- ComplianceSOS-
> >                           Compliance De-emphasis: -6dB
> >                  LnkSta2: Current De-emphasis Level: -3.5dB, Equalizati=
onComplete-, EqualizationPhase1-
> >                           EqualizationPhase2-, EqualizationPhase3-, Lin=
kEqualizationRequest-
> >          Capabilities: [100 v1] Device Serial Number 00-00-00-00-00-00-=
00-00
> >          Capabilities: [128 v1] Vendor Specific Information: ID=3D0001 =
Rev=3D0 Len=3D038 <?>
> >          Capabilities: [200 v1] Vendor Specific Information: ID=3D0002 =
Rev=3D0 Len=3D038 <?>
> > =20
> >  01:00.0 Network controller: Intel Corporation Device 2725 (rev 1a)
> >          Subsystem: Intel Corporation Device 0020
> >          Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- Pa=
rErr- Stepping- SERR- FastB2B- DisINTx-
> >          Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast TAbort=
- <TAbort- <MAbort- SERR- <PERR- INTx-
> >          Interrupt: pin A routed to IRQ 52
> >          Region 0: Memory at 80000000 (64-bit, non-prefetchable) [size=
=3D16K]
> >          Capabilities: [c8] Power Management version 3
> >                  Flags: PMEClk- DSI+ D1- D2- AuxCurrent=3D0mA PME(D0+,D=
1-,D2-,D3hot+,D3cold+)
> >                  Status: D0 NoSoftRst+ PME-Enable- DSel=3D0 DScale=3D0 =
PME-
> >          Capabilities: [d0] MSI: Enable- Count=3D1/1 Maskable- 64bit+
> >                  Address: 0000000001374000  Data: 0000
> >          Capabilities: [40] Express (v2) Endpoint, MSI 00
> >                  DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s=
 <512ns, L1 unlimited
> >                          ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset=
+ SlotPowerLimit 0.000W
> >                  DevCtl: CorrErr- NonFatalErr- FatalErr- UnsupReq-
> >                          RlxdOrd+ ExtTag- PhantFunc-0000:01:00.0: 0x804=
792E6 | umac data2
> >=20
> > > =20
> > > >       iwlwifi 0000:01:00.0: 0x00000000 | umac data3
> > > >     iwlwifi 0000:01:00.0: 0x00000047 | umac major
> > > >     iwlwifi 0000:01:00.0: 0x058653F6 | umac minor
> > > >     iwlwifi 0000:01:00.0: 0x0006488D | frame pointer
> > > >     iwlwifi 0000:01:00.0: 0xC0886244 | stack pointer
> > > >     iwlwifi 0000:01:00.0: 0x00000000 | last host cmd
> > > >     iwlwifi 0000:01:00.0: 0x00000400 | isr status reg
> > > >     iwlwifi 0000:01:00.0: IML/ROM dump:
> > > >     iwlwifi 0000:01:00.0: 0x00000B03 | IML/ROM error/state
> > > >     iwlwifi 0000:01:00.0: 0x000080F3 | IML/ROM data1
> > > >     iwlwifi 0000:01:00.0: 0x00000080 | IML/ROM WFPM_AUTH_KEY_0
> > > >     iwlwifi 0000:01:00.0: Fseq Registers:
> > > >     iwlwifi 0000:01:00.0: 0x60000000 | FSEQ_ERROR_CODE
> > > >     iwlwifi 0000:01:00.0: 0x80440005 | FSEQ_TOP_INIT_VERSION
> > > >     iwlwifi 0000:01:00.0: 0x00080009 | FSEQ_CNVIO_INIT_VERSION
> > > >     iwlwifi 0000:01:00.0: 0x0000A652 | FSEQ_OTP_VERSION
> > > >     iwlwifi 0000:01:00.0: 0x00000002 | FSEQ_TOP_CONTENT_VERSION
> > > >     iwlwifi 0000:01:00.0: 0x4552414E | FSEQ_ALIVE_TOKEN
> > > >     iwlwifi 0000:01:00.0: 0x00400410 | FSEQ_CNVI_ID
> > > >     iwlwifi 0000:01:00.0: 0x00400410 | FSEQ_CNVR_ID
> > > >     iwlwifi 0000:01:00.0: 0x00400410 | CNVI_AUX_MISC_CHIP
> > > >     iwlwifi 0000:01:00.0: 0x00400410 | CNVR_AUX_MISC_CHIP
> > > >     iwlwifi 0000:01:00.0: 0x00009061 | CNVR_SCU_SD_REGS_SD_REG_DIG_=
DCDC_VTRIM
> > > >     iwlwifi 0000:01:00.0: 0x00000061 | CNVR_SCU_SD_REGS_SD_REG_ACTI=
VE_VDIG_MIRROR
> > > >     iwlwifi 0000:01:00.0: Failed to run INIT ucode: -110
> > > >     iwlwifi 0000:01:00.0: retry init count 2
> > >    =20
> > >   --=20
> > >   Florian
> > =20
> > I tried exactly this combination of firmware and PNVM versions on a cou=
ple of (Intel based) machines
> > that I have and the driver loads ok. It can point to some PCIe related =
issue indeed. I see we already
> > have a related bug, that probably covers a bunch of different issues wi=
th similar behavior. Maybe you can
> > try the suggestion from the last comment https://bugzilla.kernel.org/sh=
ow_bug.cgi?id=3D212371#c34?
> > If you will be able to enable IOMMU, it'd be possible to get a firmware=
 debug dump that can shed some
> > light on what's going on there.
> >=20
> > Gregory.
>=20


Hi Gregory,

Regarding the bugzilla comment, I can't remove "pci=3Dnomsi,noaer" from boo=
targs. They're were never there (my bootarg are "console=3DttyPS0,921600 ea=
rlyprintk uio_pdrv_genirq.of_id=3Dgeneric-uio").=20
Kernel config PCIAER is enabled. The listing above from lspci -v seems to i=
ndicate that MSI is working properly, it enabled one vector for the ax210. =
This all indicate I should be in the suggested configuration.

Unfortunately, this hardware (Xilinx Zynq-7000) has no IOMMU support.

I've also tried the same kernel/firmware/pnvm on x64 and x32 intel computer=
s without issue.

On which level of PCIe do you think the issue would be? I could get access =
access to a serialtek pcie analyzer if this kind of low level trace could b=
e of any help investigating the issue.

Thank you for taking time to help with this,
Florian
