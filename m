Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5430060E706
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Oct 2022 20:11:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233986AbiJZSLi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 26 Oct 2022 14:11:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233960AbiJZSLc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 26 Oct 2022 14:11:32 -0400
Received: from smtp-42ae.mail.infomaniak.ch (smtp-42ae.mail.infomaniak.ch [IPv6:2001:1600:4:17::42ae])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C0F583F2B
        for <linux-wireless@vger.kernel.org>; Wed, 26 Oct 2022 11:11:28 -0700 (PDT)
Received: from smtp-2-0000.mail.infomaniak.ch (unknown [10.5.36.107])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4MyH1m0dw9zMq295;
        Wed, 26 Oct 2022 20:11:24 +0200 (CEST)
Received: from [127.0.0.1] (unknown [10.92.206.117])
        by smtp-2-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4MyH1l4jJTzMppDN;
        Wed, 26 Oct 2022 20:11:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fls.name; s=20200831;
        t=1666807884; bh=D3NF6jCSqElwmJS/x3GpSJpzwkgpVIAotpxe1Sn3WZk=;
        h=Date:Subject:From:Reply-To:To:Cc:References:In-Reply-To:From;
        b=jMxKGXVKoE/qIsz9XDQW+V0VHDgwp9gzVZEuQ122VikVLVrwzljpxVd/z9Bf5NRkN
         7dM6a++q9Rhc9WEQqhSzLwj8NLdQfiUqgtgnJHSx2i/jF+Iiv8k4qXcTaT8Aq4e7o9
         mfngsgbA4tjkSAIxmtyhhwFBOHDk+sQvb1KK8zLs=
Message-ID: <e6336941d3f950146c72487501d3ce10@mail.infomaniak.com>
Date:   Wed, 26 Oct 2022 20:11:23 +0200
Subject: Re: iwlwifi: intel ax210: module fail load firmware: Failed to start
 RT ucode: -110
From:   Florian Schmidt <florian@fls.name>
Reply-To: Florian Schmidt <florian@fls.name>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Greenman Gregory <gregory.greenman@intel.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-WS-User-Origin: eyJpdiI6IlFYbkNzTmpvNzdoYXAvTUtoYyt1dHc9PSIsInZhbHVlIjoiVlRVaVRDbmdKdmpHa2Q3SkdTUVI1dz09IiwibWFjIjoiNWYzOTEyMDBkNTE5NjVmNGIyYjc0YTY2OTU0MmZjZTUxZWI0NDhlMGExZDE0MDI5MjhiMzc1ZjEzMWI4ZDVjNCIsInRhZyI6IiJ9
X-WS-User-Mbox: eyJpdiI6IjRycVlhSGhQd1picnBRRWIrQis0elE9PSIsInZhbHVlIjoiY3VKZ2EyU1NlTlRlc1NsQVM2SFo0Zz09IiwibWFjIjoiNGZhZGZmYWIyY2FlNDhlZDhhNDFhMDg5Yjg4M2JlY2QzMmI3ODNkNzBjZTYwMWM3MDM3YjJjYWNiMjQ1Y2YyZiIsInRhZyI6IiJ9
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
In-Reply-To: <e7b7879d-6488-2993-ea3e-98b0718a0c87@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2022-10-26T18:47:20.000+01:00, Florian Fainelli <f.fainelli@gmail.com> w=
rote:

>  On 10/26/22 10:37, Florian Schmidt wrote:
>=20
> >    On 2022-10-26T18:04:33.000+01:00, Florian Fainelli <f.fainelli@gmail=
.com> wrote:
> > =20
> >=20
> > >      On 10/26/2022 8:56 AM, Florian Schmidt wrote:
> > >=20
> > >=20
> > > >        Hi Gregory,
> > > >   =20
> > > >    Thank you for having a look at this. The .pnvm file was present =
in my test as shown by my original message:
> > > >=20
> > > >=20
> > > > >        md5sum /lib/firmware/*
> > > > >    787381c60d907f81a3ddadc5c990a82b ./iwlwifi-ty-a0-gf-a0-71.ucod=
e
> > > > >    d93cbdcc4bb5be69aac128e2fe291359 ./iwlwifi-ty-a0-gf-a0.pnvm
> > > > >    33d13d236512466e71c81257209a356f ./regulatory.db
> > > >     =20
> > > >    I just ran the test again, ensuring I have the .pnvm you mention=
 and the result is indeed the same.
> > > >   =20
> > > >    Any other ideas to solve this are welcome.
> > >    =20
> > >  The driver indicated it wanted to load iwlwifi-ty-a0-gf-a0-72.ucode,
> > >  which you do seem to have based upon the listing above?
> > >  --=20
> > >  Florian
> >  =20
> >  Hi Florian,
> > =20
> >  Indeed, my first log seems to load -72.ucode when my dump show a -71 f=
ile, that's strange. I must have mismatched some test, sorry for the confus=
ion. During my tests, I've actually tried with many different firmwares (I =
think I've done all the compatible firmware I could find), tested both with=
 and without the pnvm file and many kernel versions, it always seems to fai=
l. The suspicious thing to me is that during my tests, I've confirmed sever=
al times that the same sets of wifi card, kernel and firmware work well on =
my intel desktop.
> > =20
> >  Below are the logs from my latest test today with firmware -71 and the=
 .pnvm from git.
> > =20
> >  I'd be happy to help debug more, but I have zero visibility on the fir=
mware so those register dumps just mean nothing to me. Let me know how I ca=
n assist with this.
> =20
> I am not familiar with ax210, but have worked quite a bit with the 7260=
=20
> chips (iwlwifi) and errors like those typically occurred when the PCIe=20
> end-point device, that is the ax210 is not able to do PCIe inbound=20
> accesses into your system's memory. Now in your case it could be that=20
> the inaility to load the appropriate ucode results in ... you guessed=20
> it, the ucode not being loaded which causes the timeout to happen.
>=20
> Can you tell us more about your ARM32 system here? What PCIe host=20
> bridge/controller does it use, do you have an IOMMU attached to that=20
> PCIe host brideg somehow?
>=20
> Thanks!
>=20

We're using a Xilinx FPGA Based PCIe root complex on a custom zynq-700 boar=
d. The doc of the PCIe block can be found here: https://www.xilinx.com/cont=
ent/dam/xilinx/support/documents/ip_documentation/axi_pcie/v2_8/pg055-axi-b=
ridge-pcie.pdf

I'm not really familiar with IOMMU (or PCIexpress) but to my knowledge ther=
e is no support of IOMMU on our arm32 platform, at least I couldn't enable =
it in kernel options, it required some other platform flags.

You can find everything lspci has to say about our device below.

root@BV1-27109:~# lspci -vv
00:00.0 PCI bridge: Xilinx Corporation Device 7121 (prog-if 00 [Normal deco=
de])
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+=
 Stepping- SERR+ FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <T=
Abort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0, Cache Line Size: 64 bytes
        Bus: primary=3D00, secondary=3D01, subordinate=3D01, sec-latency=3D=
0
        I/O behind bridge: 00000000-00000fff [size=3D4K]
        Memory behind bridge: 00000000-000fffff [size=3D1M]
        Prefetchable memory behind bridge: 00000000-000fffff [size=3D1M]
        Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <T=
Abort- <MAbort- <SERR- <PERR-
        BridgeCtl: Parity+ SERR+ NoISA- VGA- VGA16- MAbort- >Reset- FastB2B=
-
                PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
        Capabilities: [40] Power Management version 3
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,D2=
-,D3hot-,D3cold-)
                Status: D0 NoSoftRst+ PME-Enable- DSel=3D0 DScale=3D0 PME-
        Capabilities: [48] MSI: Enable- Count=3D1/32 Maskable+ 64bit+
                Address: 0000000000000000  Data: 0000
                Masking: 00000000  Pending: 00000000
        Capabilities: [60] Express (v2) Root Port (Slot+), MSI 00
                DevCap: MaxPayload 256 bytes, PhantFunc 1
                        ExtTag+ RBE+
                DevCtl: CorrErr- NonFatalErr- FatalErr- UnsupReq-
                        RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+
                        MaxPayload 128 bytes, MaxReadReq 512 bytes
                DevSta: CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr- T=
ransPend-
                LnkCap: Port #0, Speed 5GT/s, Width x1, ASPM L0s, Exit Late=
ncy L0s unlimited
                        ClockPM- Surprise- LLActRep+ BwNot+ ASPMOptComp-
                LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- CommClk-
                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                LnkSta: Speed 5GT/s (ok), Width x1 (ok)
                        TrErr- Train- SlotClk+ DLActive+ BWMgmt- ABWMgmt+
                SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Su=
rprise-
                        Slot #0, PowerLimit 0.000W; Interlock- NoCompl-
                SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPI=
rq- LinkChg-
                        Control: AttnInd Off, PwrInd Off, Power- Interlock-
                SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet- I=
nterlock-
                        Changed: MRL- PresDet- LinkState-
                RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna-=
 CRSVisible-
                RootCap: CRSVisible-
                RootSta: PME ReqID 0000, PMEStatus- PMEPending-
                DevCap2: Completion Timeout: Not Supported, TimeoutDis-, LT=
R-, OBFF Not Supported ARIFwd-
                         AtomicOpsCap: Routing- 32bit- 64bit- 128bitCAS-
                DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR=
-, OBFF Disabled ARIFwd-
                         AtomicOpsCtl: ReqEn- EgressBlck-
                LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDi=
s-
                         Transmit Margin: Normal Operating Range, EnterModi=
fiedCompliance- ComplianceSOS-
                         Compliance De-emphasis: -6dB
                LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationCom=
plete-, EqualizationPhase1-
                         EqualizationPhase2-, EqualizationPhase3-, LinkEqua=
lizationRequest-
        Capabilities: [100 v1] Device Serial Number 00-00-00-00-00-00-00-00
        Capabilities: [128 v1] Vendor Specific Information: ID=3D0001 Rev=
=3D0 Len=3D038 <?>
        Capabilities: [200 v1] Vendor Specific Information: ID=3D0002 Rev=
=3D0 Len=3D038 <?>

01:00.0 Network controller: Intel Corporation Device 2725 (rev 1a)
        Subsystem: Intel Corporation Device 0020
        Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-=
 Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <T=
Abort- <MAbort- >SERR- <PERR- INTx-
        Interrupt: pin A routed to IRQ 52
        Region 0: Memory at 80000000 (64-bit, non-prefetchable) [size=3D16K=
]
        Capabilities: [c8] Power Management version 3
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=3D0mA PME(D0+,D1-,D2=
-,D3hot+,D3cold+)
                Status: D0 NoSoftRst+ PME-Enable- DSel=3D0 DScale=3D0 PME-
        Capabilities: [d0] MSI: Enable- Count=3D1/1 Maskable- 64bit+
                Address: 0000000001374000  Data: 0000
        Capabilities: [40] Express (v2) Endpoint, MSI 00
                DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s <512=
ns, L1 unlimited
                        ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset+ Slo=
tPowerLimit 0.000W
                DevCtl: CorrErr- NonFatalErr- FatalErr- UnsupReq-
                        RlxdOrd+ ExtTag- PhantFunc- AuxPwr+ NoSnoop+ FLRese=
t-
                        MaxPayload 128 bytes, MaxReadReq 128 bytes
                DevSta: CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr+ T=
ransPend-
                LnkCap: Port #0, Speed 5GT/s, Width x1, ASPM L1, Exit Laten=
cy L1 <8us
                        ClockPM+ Surprise- LLActRep- BwNot- ASPMOptComp+
                LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- CommClk-
                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                LnkSta: Speed 5GT/s (ok), Width x1 (ok)
                        TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
                DevCap2: Completion Timeout: Range B, TimeoutDis+, LTR+, OB=
FF Via WAKE#
                         AtomicOpsCap: 32bit- 64bit- 128bitCAS-
                DevCtl2: Completion Timeout: 16ms to 55ms, TimeoutDis-, LTR=
-, OBFF Disabled
                         AtomicOpsCtl: ReqEn-
                LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDi=
s-
                         Transmit Margin: Normal Operating Range, EnterModi=
fiedCompliance- ComplianceSOS-
                         Compliance De-emphasis: -6dB
                LnkSta2: Current De-emphasis Level: -6dB, EqualizationCompl=
ete-, EqualizationPhase1-
                         EqualizationPhase2-, EqualizationPhase3-, LinkEqua=
lizationRequest-
        Capabilities: [80] MSI-X: Enable- Count=3D16 Masked-
                Vector table: BAR=3D0 offset=3D00002000
                PBA: BAR=3D0 offset=3D00003000
        Capabilities: [100 v1] Advanced Error Reporting
                UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- =
RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- =
RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- =
RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
                CESta:  RxErr+ BadTLP+ BadDLLP+ Rollover- Timeout+ AdvNonFa=
talErr-
                CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFa=
talErr+
                AERCap: First Error Pointer: 00, ECRCGenCap- ECRCGenEn- ECR=
CChkCap- ECRCChkEn-
                        MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
                HeaderLog: 00000000 00000000 00000000 00000000
        Capabilities: [14c v1] Latency Tolerance Reporting
                Max snoop latency: 0ns
                Max no snoop latency: 0ns
        Capabilities: [154 v1] L1 PM Substates
                L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+ L=
1_PM_Substates+
                          PortCommonModeRestoreTime=3D30us PortTPowerOnTime=
=3D18us
                L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2- ASPM_L1.1-
                           T_CommonMode=3D0us LTR1.2_Threshold=3D0ns
                L1SubCtl2: T_PwrOn=3D10us
        Kernel modules: iwlwifi


> >  Florian
> >  -------
> > =20
> >  root@BV1-27109:/lib/firmware# md5sum /lib/firmware/*
> >  787381c60d907f81a3ddadc5c990a82b  /lib/firmware/iwlwifi-ty-a0-gf-a0-71=
.ucode
> >  d93cbdcc4bb5be69aac128e2fe291359  /lib/firmware/iwlwifi-ty-a0-gf-a0.pn=
vm
> >  33d13d236512466e71c81257209a356f  /lib/firmware/regulatory.db
> > =20
> >  Linux BV1-27109 6.0.1-xilinx #1 SMP PREEMPT Wed Oct 12 09:15:44 UTC 20=
22 armv7l GNU/Linux
> > =20
> >  pci 0000:01:00.0: [8086:2725] type 00 class 0x028000
> >  pci 0000:01:00.0: reg 0x10: [mem 0x00000000-0x00003fff 64bit]
> >  pci 0000:01:00.0: PME# supported from D0 D3hot D3cold
> >  pci 0000:00:00.0: BAR 8: assigned [mem 0x80000000-0x800fffff]
> >  pci 0000:01:00.0: BAR 0: assigned [mem 0x80000000-0x80003fff 64bit]
> >  pci 0000:00:00.0: PCI bridge to [bus 01]
> >  pci 0000:00:00.0:   bridge window [mem 0x80000000-0x800fffff]
> >  Intel(R) Wireless WiFi driver for Linux
> >  pci 0000:00:00.0: enabling device (0140 -> 0142)
> >  iwlwifi 0000:01:00.0: enabling device (0000 -> 0002)
> >  iwlwifi 0000:01:00.0: Direct firmware load for iwlwifi-ty-a0-gf-a0-72.=
ucode failed with error -2
> >  iwlwifi 0000:01:00.0: api flags index 2 larger than supported by drive=
r
> >  iwlwifi 0000:01:00.0: TLV_FW_FSEQ_VERSION: FSEQ Version: 0.0.2.36
> >  iwlwifi 0000:01:00.0: loaded firmware version 71.058653f6.0 ty-a0-gf-a=
0-71.ucode  op_mode iwlmvm
> >  iwlwifi 0000:01:00.0: Detected Intel(R) Wi-Fi 6 AX210 160MHz, REV=3D0x=
420
> >  thermal thermal_zone0: failed to read out thermal zone (-61)
> >  iwlwifi 0000:01:00.0: loaded PNVM version a982b33e
> >  iwlwifi 0000:01:00.0: Timeout waiting for PNVM load!
> >  iwlwifi 0000:01:00.0: Failed to start RT ucode: -110
> >  iwlwifi 0000:01:00.0: WRT: Collecting data: ini trigger 13 fired (dela=
y=3D0ms).
> >  iwlwifi 0000:01:00.0: Start IWL Error Log Dump:
> >  iwlwifi 0000:01:00.0: Transport status: 0x00000042, valid: 6
> >  iwlwifi 0000:01:00.0: Loaded firmware version: 71.058653f6.0 ty-a0-gf-=
a0-71.ucode
> >  iwlwifi 0000:01:00.0: 0x00000084 | NMI_INTERRUPT_UNKNOWN
> >  iwlwifi 0000:01:00.0: 0x002002F0 | trm_hw_status0
> >  iwlwifi 0000:01:00.0: 0x00000000 | trm_hw_status1
> >  iwlwifi 0000:01:00.0: 0x004DAEA2 | branchlink2
> >  iwlwifi 0000:01:00.0: 0x004D1336 | interruptlink1
> >  iwlwifi 0000:01:00.0: 0x004D1336 | interruptlink2
> >  iwlwifi 0000:01:00.0: 0x004D9C78 | data1
> >  iwlwifi 0000:01:00.0: 0x01000000 | data2
> >  iwlwifi 0000:01:00.0: 0x00000000 | data3
> >  iwlwifi 0000:01:00.0: 0x00000000 | beacon time
> >  iwlwifi 0000:01:00.0: 0x00052ADD | tsf low
> >  iwlwifi 0000:01:00.0: 0x00000000 | tsf hi
> >  iwlwifi 0000:01:00.0: 0x00000000 | time gp1
> >  iwlwifi 0000:01:00.0: 0x00066975 | time gp2
> >  iwlwifi 0000:01:00.0: 0x00000001 | uCode revision type
> >  iwlwifi 0000:01:00.0: 0x00000047 | uCode version major
> >  iwlwifi 0000:01:00.0: 0x058653F6 | uCode version minor
> >  iwlwifi 0000:01:00.0: 0x00000420 | hw version
> >  iwlwifi 0000:01:00.0: 0x00489002 | board version
> >  iwlwifi 0000:01:00.0: 0x8004FC12 | hcmd
> >  iwlwifi 0000:01:00.0: 0x00020000 | isr0
> >  iwlwifi 0000:01:00.0: 0x00000000 | isr1
> >  iwlwifi 0000:01:00.0: 0x48F00002 | isr2
> >  iwlwifi 0000:01:00.0: 0x00C0000C | isr3
> >  iwlwifi 0000:01:00.0: 0x00000000 | isr4
> >  iwlwifi 0000:01:00.0: 0x00000000 | last cmd Id
> >  iwlwifi 0000:01:00.0: 0x004D9C78 | wait_event
> >  iwlwifi 0000:01:00.0: 0x00000000 | l2p_control
> >  iwlwifi 0000:01:00.0: 0x00000000 | l2p_duration
> >  iwlwifi 0000:01:00.0: 0x00000000 | l2p_mhvalid
> >  iwlwifi 0000:01:00.0: 0x00000000 | l2p_addr_match
> >  iwlwifi 0000:01:00.0: 0x00000009 | lmpm_pmg_sel
> >  iwlwifi 0000:01:00.0: 0x00000000 | timestamp
> >  iwlwifi 0000:01:00.0: 0x00000020 | flow_handler
> >  iwlwifi 0000:01:00.0: Start IWL Error Log Dump:
> >  iwlwifi 0000:01:00.0: Transport status: 0x00000042, valid: 7
> >  iwlwifi 0000:01:00.0: 0x20000066 | NMI_INTERRUPT_HOST
> >  iwlwifi 0000:01:00.0: 0x00000000 | umac branchlink1
> >  iwlwifi 0000:01:00.0: 0x8045EFDC | umac branchlink2
> >  iwlwifi 0000:01:00.0: 0x8047E792 | umac interruptlink1
> >  iwlwifi 0000:01:00.0: 0x804792D6 | umac interruptlink2
> >  iwlwifi 0000:01:00.0: 0x01000000 | umac data1
> >  iwlwifi 0000:01:00.0: 0x804792D6 | umac data2
> >  iwlwifi 0000:01:00.0: 0x00000000 | umac data3
> >  iwlwifi 0000:01:00.0: 0x00000047 | umac major
> >  iwlwifi 0000:01:00.0: 0x058653F6 | umac minor
> >  iwlwifi 0000:01:00.0: 0x00066ABB | frame pointer
> >  iwlwifi 0000:01:00.0: 0xC0886244 | stack pointer
> >  iwlwifi 0000:01:00.0: 0x00000000 | last host cmd
> >  iwlwifi 0000:01:00.0: 0x00000400 | isr status reg
> >  iwlwifi 0000:01:00.0: IML/ROM dump:
> >  iwlwifi 0000:01:00.0: 0x00000B03 | IML/ROM error/state
> >  iwlwifi 0000:01:00.0: 0x000080F1 | IML/ROM data1
> >  iwlwifi 0000:01:00.0: 0x00000080 | IML/ROM WFPM_AUTH_KEY_0
> >  iwlwifi 0000:01:00.0: Fseq Registers:
> >  iwlwifi 0000:01:00.0: 0x20000000 | FSEQ_ERROR_CODE
> >  iwlwifi 0000:01:00.0: 0x80440005 | FSEQ_TOP_INIT_VERSION
> >  iwlwifi 0000:01:00.0: 0x00080009 | FSEQ_CNVIO_INIT_VERSION
> >  iwlwifi 0000:01:00.0: 0x0000A652 | FSEQ_OTP_VERSION
> >  iwlwifi 0000:01:00.0: 0x00000002 | FSEQ_TOP_CONTENT_VERSION
> >  iwlwifi 0000:01:00.0: 0x4552414E | FSEQ_ALIVE_TOKEN
> >  iwlwifi 0000:01:00.0: 0x00400410 | FSEQ_CNVI_ID
> >  iwlwifi 0000:01:00.0: 0x00400410 | FSEQ_CNVR_ID
> >  iwlwifi 0000:01:00.0: 0x00400410 | CNVI_AUX_MISC_CHIP
> >  iwlwifi 0000:01:00.0: 0x00400410 | CNVR_AUX_MISC_CHIP
> >  iwlwifi 0000:01:00.0: 0x00009061 | CNVR_SCU_SD_REGS_SD_REG_DIG_DCDC_VT=
RIM
> >  iwlwifi 0000:01:00.0: 0x00000061 | CNVR_SCU_SD_REGS_SD_REG_ACTIVE_VDIG=
_MIRROR
> >  iwlwifi 0000:01:00.0: Failed to run INIT ucode: -110
> >  iwlwifi 0000:01:00.0: retry init count 0
> >  iwlwifi 0000:01:00.0: Detected Intel(R) Wi-Fi 6 AX210 160MHz, REV=3D0x=
420
> >  thermal thermal_zone0: failed to read out thermal zone (-61)
> >  iwlwifi 0000:01:00.0: Timeout waiting for PNVM load!
> >  iwlwifi 0000:01:00.0: Failed to start RT ucode: -110
> >  iwlwifi 0000:01:00.0: WRT: Collecting data: ini trigger 13 fired (dela=
y=3D0ms).
> >  iwlwifi 0000:01:00.0: Start IWL Error Log Dump:
> >  iwlwifi 0000:01:00.0: Transport status: 0x00000042, valid: 6
> >  iwlwifi 0000:01:00.0: Loaded firmware version: 71.058653f6.0 ty-a0-gf-=
a0-71.ucode
> >  iwlwifi 0000:01:00.0: 0x00000084 | NMI_INTERRUPT_UNKNOWN
> >  iwlwifi 0000:01:00.0: 0x002002F0 | trm_hw_status0
> >  iwlwifi 0000:01:00.0: 0x00000000 | trm_hw_status1
> >  iwlwifi 0000:01:00.0: 0x004DAEA2 | branchlink2
> >  iwlwifi 0000:01:00.0: 0x004D1336 | interruptlink1
> >  iwlwifi 0000:01:00.0: 0x004D1336 | interruptlink2
> >  iwlwifi 0000:01:00.0: 0x004D9C78 | data1
> >  iwlwifi 0000:01:00.0: 0x01000000 | data2
> >  iwlwifi 0000:01:00.0: 0x00000000 | data3
> >  iwlwifi 0000:01:00.0: 0x00000000 | beacon time
> >  iwlwifi 0000:01:00.0: 0x00053473 | tsf low
> >  iwlwifi 0000:01:00.0: 0x00000000 | tsf hi
> >  iwlwifi 0000:01:00.0: 0x00000000 | time gp1
> >  iwlwifi 0000:01:00.0: 0x0006722F | time gp2
> >  iwlwifi 0000:01:00.0: 0x00000001 | uCode revision type
> >  iwlwifi 0000:01:00.0: 0x00000047 | uCode version major
> >  iwlwifi 0000:01:00.0: 0x058653F6 | uCode version minor
> >  iwlwifi 0000:01:00.0: 0x00000420 | hw version
> >  iwlwifi 0000:01:00.0: 0x18489002 | board version
> >  iwlwifi 0000:01:00.0: 0x8004FC12 | hcmd
> >  iwlwifi 0000:01:00.0: 0x00020000 | isr0
> >  iwlwifi 0000:01:00.0: 0x00000000 | isr1
> >  iwlwifi 0000:01:00.0: 0x48F00002 | isr2
> >  iwlwifi 0000:01:00.0: 0x00C0000C | isr3
> >  iwlwifi 0000:01:00.0: 0x00000000 | isr4
> >  iwlwifi 0000:01:00.0: 0x00000000 | last cmd Id
> >  iwlwifi 0000:01:00.0: 0x004D9C78 | wait_event
> >  iwlwifi 0000:01:00.0: 0x00000000 | l2p_control
> >  iwlwifi 0000:01:00.0: 0x00000000 | l2p_duration
> >  iwlwifi 0000:01:00.0: 0x00000000 | l2p_mhvalid
> >  iwlwifi 0000:01:00.0: 0x00000000 | l2p_addr_match
> >  iwlwifi 0000:01:00.0: 0x00000009 | lmpm_pmg_sel
> >  iwlwifi 0000:01:00.0: 0x00000000 | timestamp
> >  iwlwifi 0000:01:00.0: 0x00000020 | flow_handler
> >  iwlwifi 0000:01:00.0: Start IWL Error Log Dump:
> >  iwlwifi 0000:01:00.0: Transport status: 0x00000042, valid: 7
> >  iwlwifi 0000:01:00.0: 0x20000066 | NMI_INTERRUPT_HOST
> >  iwlwifi 0000:01:00.0: 0x00000000 | umac branchlink1
> >  iwlwifi 0000:01:00.0: 0x8045EFDC | umac branchlink2
> >  iwlwifi 0000:01:00.0: 0x8047E792 | umac interruptlink1
> >  iwlwifi 0000:01:00.0: 0x8047E792 | umac interruptlink2
> >  iwlwifi 0000:01:00.0: 0x01000000 | umac data1
> >  iwlwifi 0000:01:00.0: 0x8047E792 | umac data2
> >  iwlwifi 0000:01:00.0: 0x00000000 | umac data3
> >  iwlwifi 0000:01:00.0: 0x00000047 | umac major
> >  iwlwifi 0000:01:00.0: 0x058653F6 | umac minor
> >  iwlwifi 0000:01:00.0: 0x00067375 | frame pointer
> >  iwlwifi 0000:01:00.0: 0xC088625C | stack pointer
> >  iwlwifi 0000:01:00.0: 0x00000000 | last host cmd
> >  iwlwifi 0000:01:00.0: 0x00000400 | isr status reg
> >  iwlwifi 0000:01:00.0: IML/ROM dump:
> >  iwlwifi 0000:01:00.0: 0x00000B03 | IML/ROM error/state
> >  iwlwifi 0000:01:00.0: 0x000080EF | IML/ROM data1
> >  iwlwifi 0000:01:00.0: 0x00000080 | IML/ROM WFPM_AUTH_KEY_0
> >  iwlwifi 0000:01:00.0: Fseq Registers:
> >  iwlwifi 0000:01:00.0: 0x60000000 | FSEQ_ERROR_CODE
> >  iwlwifi 0000:01:00.0: 0x80440005 | FSEQ_TOP_INIT_VERSION
> >  iwlwifi 0000:01:00.0: 0x00080009 | FSEQ_CNVIO_INIT_VERSION
> >  iwlwifi 0000:01:00.0: 0x0000A652 | FSEQ_OTP_VERSION
> >  iwlwifi 0000:01:00.0: 0x00000002 | FSEQ_TOP_CONTENT_VERSION
> >  iwlwifi 0000:01:00.0: 0x4552414E | FSEQ_ALIVE_TOKEN
> >  iwlwifi 0000:01:00.0: 0x00400410 | FSEQ_CNVI_ID
> >  iwlwifi 0000:01:00.0: 0x00400410 | FSEQ_CNVR_ID
> >  iwlwifi 0000:01:00.0: 0x00400410 | CNVI_AUX_MISC_CHIP
> >  iwlwifi 0000:01:00.0: 0x00400410 | CNVR_AUX_MISC_CHIP
> >  iwlwifi 0000:01:00.0: 0x00009061 | CNVR_SCU_SD_REGS_SD_REG_DIG_DCDC_VT=
RIM
> >  iwlwifi 0000:01:00.0: 0x00000061 | CNVR_SCU_SD_REGS_SD_REG_ACTIVE_VDIG=
_MIRROR
> >  iwlwifi 0000:01:00.0: Failed to run INIT ucode: -110
> >  iwlwifi 0000:01:00.0: retry init count 1
> >  iwlwifi 0000:01:00.0: Detected Intel(R) Wi-Fi 6 AX210 160MHz, REV=3D0x=
420
> >  thermal thermal_zone0: failed to read out thermal zone (-61)
> >  iwlwifi 0000:01:00.0: Timeout waiting for PNVM load!
> >  iwlwifi 0000:01:00.0: Failed to start RT ucode: -110
> >  iwlwifi 0000:01:00.0: WRT: Collecting data: ini trigger 13 fired (dela=
y=3D0ms).
> >  iwlwifi 0000:01:00.0: Start IWL Error Log Dump:
> >  iwlwifi 0000:01:00.0: Transport status: 0x00000042, valid: 6
> >  iwlwifi 0000:01:00.0: Loaded firmware version: 71.058653f6.0 ty-a0-gf-=
a0-71.ucode
> >  iwlwifi 0000:01:00.0: 0x00000084 | NMI_INTERRUPT_UNKNOWN
> >  iwlwifi 0000:01:00.0: 0x002002F0 | trm_hw_status0
> >  iwlwifi 0000:01:00.0: 0x00000000 | trm_hw_status1
> >  iwlwifi 0000:01:00.0: 0x004DAEA2 | branchlink2
> >  iwlwifi 0000:01:00.0: 0x004D1336 | interruptlink1
> >  iwlwifi 0000:01:00.0: 0x004D1336 | interruptlink2
> >  iwlwifi 0000:01:00.0: 0x004D9C78 | data1
> >  iwlwifi 0000:01:00.0: 0x01000000 | data2
> >  iwlwifi 0000:01:00.0: 0x00000000 | data3
> >  iwlwifi 0000:01:00.0: 0x00000000 | beacon time
> >  iwlwifi 0000:01:00.0: 0x00050982 | tsf low
> >  iwlwifi 0000:01:00.0: 0x00000000 | tsf hi
> >  iwlwifi 0000:01:00.0: 0x00000000 | time gp1
> >  iwlwifi 0000:01:00.0: 0x00064743 | time gp2
> >  iwlwifi 0000:01:00.0: 0x00000001 | uCode revision type
> >  iwlwifi 0000:01:00.0: 0x00000047 | uCode version major
> >  iwlwifi 0000:01:00.0: 0x058653F6 | uCode version minor
> >  iwlwifi 0000:01:00.0: 0x00000420 | hw version
> >  iwlwifi 0000:01:00.0: 0x18489002 | board version
> >  iwlwifi 0000:01:00.0: 0x8004FC12 | hcmd
> >  iwlwifi 0000:01:00.0: 0x00020000 | isr0
> >  iwlwifi 0000:01:00.0: 0x00000000 | isr1
> >  iwlwifi 0000:01:00.0: 0x48F00002 | isr2
> >  iwlwifi 0000:01:00.0: 0x00C0000C | isr3
> >  iwlwifi 0000:01:00.0: 0x00000000 | isr4
> >  iwlwifi 0000:01:00.0: 0x00000000 | last cmd Id
> >  iwlwifi 0000:01:00.0: 0x004D9C78 | wait_event
> >  iwlwifi 0000:01:00.0: 0x00000000 | l2p_control
> >  iwlwifi 0000:01:00.0: 0x00000000 | l2p_duration
> >  iwlwifi 0000:01:00.0: 0x00000000 | l2p_mhvalid
> >  iwlwifi 0000:01:00.0: 0x00000000 | l2p_addr_match
> >  iwlwifi 0000:01:00.0: 0x00000009 | lmpm_pmg_sel
> >  iwlwifi 0000:01:00.0: 0x00000000 | timestamp
> >  iwlwifi 0000:01:00.0: 0x00000020 | flow_handler
> >  iwlwifi 0000:01:00.0: Start IWL Error Log Dump:
> >  iwlwifi 0000:01:00.0: Transport status: 0x00000042, valid: 7
> >  iwlwifi 0000:01:00.0: 0x20000066 | NMI_INTERRUPT_HOST
> >  iwlwifi 0000:01:00.0: 0x00000000 | umac branchlink1
> >  iwlwifi 0000:01:00.0: 0x8045EFDC | umac branchlink2
> >  iwlwifi 0000:01:00.0: 0x8047E792 | umac interruptlink1
> >  iwlwifi 0000:01:00.0: 0x804792E6 | umac interruptlink2
> >  iwlwifi 0000:01:00.0: 0x01000000 | umac data1
> >  iwlwifi 0000:01:00.0: 0x804792E6 | umac data2
> >  iwlwifi 0000:01:00.0: 0x00000000 | umac data3
> >  iwlwifi 0000:01:00.0: 0x00000047 | umac major
> >  iwlwifi 0000:01:00.0: 0x058653F6 | umac minor
> >  iwlwifi 0000:01:00.0: 0x0006488D | frame pointer
> >  iwlwifi 0000:01:00.0: 0xC0886244 | stack pointer
> >  iwlwifi 0000:01:00.0: 0x00000000 | last host cmd
> >  iwlwifi 0000:01:00.0: 0x00000400 | isr status reg
> >  iwlwifi 0000:01:00.0: IML/ROM dump:
> >  iwlwifi 0000:01:00.0: 0x00000B03 | IML/ROM error/state
> >  iwlwifi 0000:01:00.0: 0x000080F3 | IML/ROM data1
> >  iwlwifi 0000:01:00.0: 0x00000080 | IML/ROM WFPM_AUTH_KEY_0
> >  iwlwifi 0000:01:00.0: Fseq Registers:
> >  iwlwifi 0000:01:00.0: 0x60000000 | FSEQ_ERROR_CODE
> >  iwlwifi 0000:01:00.0: 0x80440005 | FSEQ_TOP_INIT_VERSION
> >  iwlwifi 0000:01:00.0: 0x00080009 | FSEQ_CNVIO_INIT_VERSION
> >  iwlwifi 0000:01:00.0: 0x0000A652 | FSEQ_OTP_VERSION
> >  iwlwifi 0000:01:00.0: 0x00000002 | FSEQ_TOP_CONTENT_VERSION
> >  iwlwifi 0000:01:00.0: 0x4552414E | FSEQ_ALIVE_TOKEN
> >  iwlwifi 0000:01:00.0: 0x00400410 | FSEQ_CNVI_ID
> >  iwlwifi 0000:01:00.0: 0x00400410 | FSEQ_CNVR_ID
> >  iwlwifi 0000:01:00.0: 0x00400410 | CNVI_AUX_MISC_CHIP
> >  iwlwifi 0000:01:00.0: 0x00400410 | CNVR_AUX_MISC_CHIP
> >  iwlwifi 0000:01:00.0: 0x00009061 | CNVR_SCU_SD_REGS_SD_REG_DIG_DCDC_VT=
RIM
> >  iwlwifi 0000:01:00.0: 0x00000061 | CNVR_SCU_SD_REGS_SD_REG_ACTIVE_VDIG=
_MIRROR
> >  iwlwifi 0000:01:00.0: Failed to run INIT ucode: -110
> >  iwlwifi 0000:01:00.0: retry init count 2
> =20
> --=20
> Florian
