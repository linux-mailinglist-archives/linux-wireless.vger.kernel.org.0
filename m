Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2997040B592
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Sep 2021 19:05:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230116AbhINRGP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 14 Sep 2021 13:06:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229960AbhINRGO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 14 Sep 2021 13:06:14 -0400
X-Greylist: delayed 305 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 14 Sep 2021 10:04:57 PDT
Received: from mout1.freenet.de (mout1.freenet.de [IPv6:2001:748:100:40::2:3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D779C061764
        for <linux-wireless@vger.kernel.org>; Tue, 14 Sep 2021 10:04:57 -0700 (PDT)
Received: from [195.4.92.122] (helo=sub3.freenet.de)
        by mout1.freenet.de with esmtpa (ID andreas.tepe@debitel.net) (port 25) (Exim 4.92 #3)
        id 1mQBmg-0005BB-2U
        for linux-wireless@vger.kernel.org; Tue, 14 Sep 2021 18:59:50 +0200
Received: from p200300dd2f146d00f621f3e1feb7b92d.dip0.t-ipconnect.de ([2003:dd:2f14:6d00:f621:f3e1:feb7:b92d]:40214)
        by sub3.freenet.de with esmtpsa (ID andreas.tepe@debitel.net) (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128) (port 465) (Exim 4.92 #3)
        id 1mQBmf-0001L0-Sl
        for linux-wireless@vger.kernel.org; Tue, 14 Sep 2021 18:59:50 +0200
To:     linux-wireless@vger.kernel.org
From:   Andreas Tepe <andreas.tepe@debitel.net>
Subject: Patch for Atheros QCA6174
Message-ID: <dd4aa95d-c7e6-f582-48bd-c7d6f8cdc8b2@debitel.net>
Date:   Tue, 14 Sep 2021 18:59:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="WGguIZYw7HsNRESaRi9RIUBLNX6RJJ3o8"
X-Originated-At: 2003:dd:2f14:6d00:f621:f3e1:feb7:b92d!40214
X-FNSign: v=2 s=7EF935639F3FDC9EB7AFB1C13506CBC119448FE78B5B8D38FBCCF0F03C5D4B12
X-Scan-TS: Tue, 14 Sep 2021 18:59:49 +0200
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--WGguIZYw7HsNRESaRi9RIUBLNX6RJJ3o8
Content-Type: multipart/mixed; boundary="FV6PHakEwjNY9XWdzN2wXnCw5DzQJjJeD";
 protected-headers="v1"
From: Andreas Tepe <andreas.tepe@debitel.net>
To: linux-wireless@vger.kernel.org
Message-ID: <dd4aa95d-c7e6-f582-48bd-c7d6f8cdc8b2@debitel.net>
Subject: Patch for Atheros QCA6174

--FV6PHakEwjNY9XWdzN2wXnCw5DzQJjJeD
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

Hello dear developer,

since this patch has been around for years already and mentioned
multiple times on bugzilla, I'll try this way to communicate it. I never
posted a patch before and tried to follow the rules on the
https://wireless.wiki.kernel.org/ website.

The card is build in Samsung Galaxy Books and not usable without the patc=
h.

Information about the card:

01:00.0 Network controller: Qualcomm Atheros QCA6174 802.11ac Wireless
Network Adapter (rev 32)
	Subsystem: Samsung Electronics Co Ltd QCA6174 802.11ac Wireless Network
Adapter
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort=
-
<MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 129
	Region 0: Memory at df400000 (64-bit, non-prefetchable) [size=3D2M]
	Capabilities: [40] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D375mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
	Capabilities: [50] MSI: Enable+ Count=3D1/8 Maskable+ 64bit-
		Address: fee003b8  Data: 0000
		Masking: 000000fe  Pending: 00000000
	Capabilities: [70] Express (v2) Endpoint, MSI 00
		DevCap:	MaxPayload 256 bytes, PhantFunc 0, Latency L0s unlimited, L1 <6=
4us
			ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset- SlotPowerLimit 10.000W=

		DevCtl:	CorrErr- NonFatalErr- FatalErr- UnsupReq-
			RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 256 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr+ TransPend-
		LnkCap:	Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit Latency
L0s <4us, L1 <64us
			ClockPM+ Surprise- LLActRep- BwNot- ASPMOptComp+
		LnkCtl:	ASPM L1 Enabled; RCB 64 bytes, Disabled- CommClk+
			ExtSynch- ClockPM+ AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s (ok), Width x1 (ok)
			TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
		DevCap2: Completion Timeout: Not Supported, TimeoutDis+ NROPrPrP- LTR+
			 10BitTagComp- 10BitTagReq- OBFF Via message, ExtFmt- EETLPPrefix-
			 EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
			 FRS- TPHComp- ExtTPHComp-
			 AtomicOpsCap: 32bit- 64bit- 128bitCAS-
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- LTR+ OBFF Disabl=
ed,
			 AtomicOpsCtl: ReqEn-
		LnkCap2: Supported Link Speeds: 2.5GT/s, Crosslink- Retimer-
2Retimers- DRS-
		LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance-
ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-
EqualizationPhase1-
			 EqualizationPhase2- EqualizationPhase3- LinkEqualizationRequest-
			 Retimer- 2Retimers- CrosslinkRes: unsupported
	Capabilities: [100 v2] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
MalfTLP- ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
MalfTLP- ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+
MalfTLP+ ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr-
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+
		AERCap:	First Error Pointer: 00, ECRCGenCap- ECRCGenEn- ECRCChkCap-
ECRCChkEn-
			MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
		HeaderLog: 00000000 00000000 00000000 00000000
	Capabilities: [148 v1] Virtual Channel
		Caps:	LPEVC=3D0 RefClk=3D100ns PATEntryBits=3D1
		Arb:	Fixed- WRR32- WRR64- WRR128-
		Ctrl:	ArbSelect=3DFixed
		Status:	InProgress-
		VC0:	Caps:	PATOffset=3D00 MaxTimeSlots=3D1 RejSnoopTrans-
			Arb:	Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
			Ctrl:	Enable+ ID=3D0 ArbSelect=3DFixed TC/VC=3Dff
			Status:	NegoPending- InProgress-
	Capabilities: [168 v1] Device Serial Number 00-00-00-00-00-00-00-00
	Capabilities: [178 v1] Latency Tolerance Reporting
		Max snoop latency: 3145728ns
		Max no snoop latency: 3145728ns
	Capabilities: [180 v1] L1 PM Substates
		L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+ L1_PM_Substat=
es+
			  PortCommonModeRestoreTime=3D50us PortTPowerOnTime=3D10us
		L1SubCtl1: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+
			   T_CommonMode=3D0us LTR1.2_Threshold=3D98304ns
		L1SubCtl2: T_PwrOn=3D44us
	Kernel driver in use: ath10k_pci
	Kernel modules: ath10k_pci


The patch is:

diff --git a/./linux-5.14.3/drivers/net/wireless/ath/regd_common.h
b/./regd_common.h
index c4bd26e..6d8c85d 100644
--- a/./linux-5.14.3/drivers/net/wireless/ath/regd_common.h
+++ b/./regd_common.h
@@ -76,6 +76,7 @@ enum EnumRd {
        APL7_FCCA =3D 0x5C,
        APL8_WORLD =3D 0x5D,
        APL9_WORLD =3D 0x5E,
+       APL10_WORLD =3D 0x5F,

        WOR0_WORLD =3D 0x60,
        WOR1_WORLD =3D 0x61,
@@ -204,6 +205,7 @@ static struct reg_dmn_pair_mapping regDomainPairs[] =3D=
 {
        {APL6_WORLD, CTL_ETSI, CTL_ETSI},
        {APL8_WORLD, CTL_ETSI, CTL_ETSI},
        {APL9_WORLD, CTL_ETSI, CTL_ETSI},
+       {APL10_WORLD, CTL_ETSI, CTL_ETSI},

        {APL3_FCCA, CTL_FCC, CTL_FCC},
        {APL7_FCCA, CTL_FCC, CTL_FCC},
@@ -426,6 +428,7 @@ static struct country_code_to_enum_rd allCountries[] =
=3D {
        {CTRY_KOREA_ROC, APL9_WORLD, "KR"},
        {CTRY_KOREA_ROC2, APL2_WORLD, "K2"},
        {CTRY_KOREA_ROC3, APL9_WORLD, "K3"},
+       {CTRY_KOREA_ROC, APL10_WORLD, "KR"},
        {CTRY_KUWAIT, ETSI3_WORLD, "KW"},
        {CTRY_LATVIA, ETSI1_WORLD, "LV"},
        {CTRY_LEBANON, NULL1_WORLD, "LB"},


It would be great if you could apply the patch since no Linux has
wireless on those machines without it.

Kind regards,
Andreas


--FV6PHakEwjNY9XWdzN2wXnCw5DzQJjJeD--

--WGguIZYw7HsNRESaRi9RIUBLNX6RJJ3o8
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEEvcFuJkAJt57KoGjB0LMkQvxvVJcFAmFA1QQFAwAAAAAACgkQ0LMkQvxvVJcm
LhAAolAY7wTmi1Fya+3Ihw/hJGksP9LxuJK3EQO3aIMi6DF+ZyxuSfWZhBeck5LeAL9YewIq74Ds
xFtP3+2Xvpd6WRo/G7iVpRIjvXCha/DUtgl5RlAQyJarpE2CoGbs147zZg72Lba/wNc0e77h8Q5a
ykfPC1q2X9bgETEr0LYgAV8+3NF+a1j39cQubrnOVslX3GbQLz9iWnCJUzzYdtVKPutwRmcQan+a
ZgjyPKogG6JgUz4mA5+4aQmujMTkPlM/Sa1CamLFxpuiDSk6rd7VKOUlhYpasd4oRnbjAXJomRla
30L/NXgSM/d36UISdYoTR7PtROE1Hkx3+qGKL6Vz6WxIo9tkA4Rzv2Oiymxef7HB99RNfvvglI4l
lLSPMMcg62ciC8F9vPlNW+cHItSSqdIfqGePVVL710mZVEQYTJbvVV4v+JUpnm+WKgJLL43lGDSl
qo6xBpOvQr5010bLBzvu4kvyZ9H0A68rLgn7PL0TVcJbpTbm70RzAM+mLUOCRDTEDJgx7M85w8fe
cn381Bc70IIyNLLgYowbfp+jFwCAWmya32c6JrGdjZYCXhxXO7XmADn5IGhPlDdNkKc5exSW3fv7
yzaLxAs6+tNIOdypZLBHlp1WgDSd8PQsPs9HQlq6dFlU5zBVS/Ygg4csYlJXGwgTDKGFMhcczVsg
Pfg=
=lfan
-----END PGP SIGNATURE-----

--WGguIZYw7HsNRESaRi9RIUBLNX6RJJ3o8--
