Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 065D01A8069
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Apr 2020 16:52:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405208AbgDNOwK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 14 Apr 2020 10:52:10 -0400
Received: from mx2.suse.de ([195.135.220.15]:54152 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405206AbgDNOwG (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 14 Apr 2020 10:52:06 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 2F0F4AC7F;
        Tue, 14 Apr 2020 14:52:03 +0000 (UTC)
Message-ID: <6e42e11cfe24f88ae1dac2ad793f9c73751e6c7d.camel@suse.de>
Subject: Re: iwlwifi won't probe with linux-next
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Johannes Berg <johannes.berg@intel.com>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>
Cc:     Intel Linux Wireless <linuxwifi@intel.com>,
        linux-wireless <linux-wireless@vger.kernel.org>
Date:   Tue, 14 Apr 2020 16:52:01 +0200
In-Reply-To: <bdb4170b21167cae89523fa688db6699539474bf.camel@suse.de>
References: <bdb4170b21167cae89523fa688db6699539474bf.camel@suse.de>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-1SaTSStqTlZL7Pl6MK8z"
User-Agent: Evolution 3.34.2 
MIME-Version: 1.0
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--=-1SaTSStqTlZL7Pl6MK8z
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2020-04-13 at 14:47 +0200, Nicolas Saenz Julienne wrote:
> Hi,
> I'm having trouble with my iwlwifi device on the latest linux-next.
> Essentially
> it fails at probe:
>=20
> 	nico@linux-9qgx:~> dmesg | grep iwl
> 	[    4.650950] iwlwifi 0000:28:00.0: enabling device (0000 -> 0002)
> 	[    4.720086] iwlwifi: probe of 0000:28:00.0 failed with error -110
>=20
> I made some research and the timeout happens after the call to iwl_poll_b=
it()
> in iwl_finish_nic_init().
>=20
> Also here is the relevant lspci output:
>=20
> 	nico@linux-9qgx:~/c/linux> sudo lspci -s 0000:28:00.0 -vvv
> 	28:00.0 Network controller: Intel Corporation Wi-Fi 6 AX200 (rev 1a)
> 		DeviceName: RTL8111EPV
> 		Subsystem: Intel Corporation Device 0084
> 		Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B- DisINTx-
> 		Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
> 		Interrupt: pin A routed to IRQ 41
> 		Region 0: Memory at fc600000 (64-bit, non-prefetchable)
> [size=3D16K]
> 		Capabilities: [c8] Power Management version 3
> 			Flags: PMEClk- DSI+ D1- D2- AuxCurrent=3D0mA PME(D0+,D1-
> ,D2-,D3hot+,D3cold+)
> 			Status: D0 NoSoftRst+ PME-Enable- DSel=3D0 DScale=3D0 PME-
> 		Capabilities: [d0] MSI: Enable- Count=3D1/1 Maskable- 64bit+
> 			Address: 0000000000000000  Data: 0000
> 		Capabilities: [40] Express (v2) Endpoint, MSI 00
> 			DevCap:	MaxPayload 128 bytes, PhantFunc 0, Latency L0s
> <512ns, L1 unlimited
> 				ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset+
> SlotPowerLimit 0.000W
> 			DevCtl:	CorrErr- NonFatalErr- FatalErr- UnsupReq-
> 				RlxdOrd+ ExtTag- PhantFunc- AuxPwr+ NoSnoop+
> FLReset-
> 				MaxPayload 128 bytes, MaxReadReq 128 bytes
> 			DevSta:	CorrErr- NonFatalErr- FatalErr- UnsupReq-
> AuxPwr+ TransPend-
> 			LnkCap:	Port #6, Speed 5GT/s, Width x1, ASPM L1, Exit
> Latency L1 <8us
> 				ClockPM+ Surprise- LLActRep- BwNot- ASPMOptComp+
> 			LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- CommClk+
> 				ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
> 			LnkSta:	Speed 5GT/s (ok), Width x1 (ok)
> 				TrErr- Train- SlotClk+ DLActive- BWMgmt-
> ABWMgmt-
> 			DevCap2: Completion Timeout: Range B, TimeoutDis+,
> NROPrPrP-, LTR+
> 				10BitTagComp-, 10BitTagReq-, OBFF Via WAKE#,
> ExtFmt-, EETLPPrefix-
> 				EmergencyPowerReduction Not Supported,
> EmergencyPowerReductionInit-
> 				FRS-, TPHComp-, ExtTPHComp-
> 				AtomicOpsCap: 32bit- 64bit- 128bitCAS-
> 			DevCtl2: Completion Timeout: 16ms to 55ms, TimeoutDis-,
> LTR+, OBFF Disabled
> 				AtomicOpsCtl: ReqEn-
> 			LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance-
> SpeedDis-
> 				Transmit Margin: Normal Operating Range,
> EnterModifiedCompliance- ComplianceSOS-
> 				Compliance De-emphasis: -6dB
> 			LnkSta2: Current De-emphasis Level: -6dB,
> EqualizationComplete-, EqualizationPhase1-
> 				EqualizationPhase2-, EqualizationPhase3-,
> LinkEqualizationRequest-
> 		Capabilities: [80] MSI-X: Enable- Count=3D16 Masked-
> 			Vector table: BAR=3D0 offset=3D00002000
> 			PBA: BAR=3D0 offset=3D00003000
> 		Capabilities: [100 v1] Advanced Error Reporting
> 			UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt-
> UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
> 			UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt-
> UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
> 			UESvrt:	DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt-
> UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
> 			CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout-
> AdvNonFatalErr-
> 			CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout-
> AdvNonFatalErr+
> 			AERCap:	First Error Pointer: 00, ECRCGenCap-
> ECRCGenEn-
> ECRCChkCap- ECRCChkEn-
> 				MultHdrRecCap- MultHdrRecEn- TLPPfxPres-
> HdrLogCap-
> 			HeaderLog: 00000000 00000000 00000000 00000000
> 		Capabilities: [14c v1] Latency Tolerance Reporting
> 			Max snoop latency: 1048576ns
> 			Max no snoop latency: 1048576ns
> 		Capabilities: [154 v1] L1 PM Substates
> 			L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+
> ASPM_L1.1+ L1_PM_Substates+
> 				 PortCommonModeRestoreTime=3D30us
> PortTPowerOnTime=3D18us
> 			L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2-
> ASPM_L1.1-
> 				  T_CommonMode=3D0us LTR1.2_Threshold=3D32768ns
> 			L1SubCtl2: T_PwrOn=3D18us
> 		Kernel modules: iwlwifi
>=20
>=20
> Note that I have a built kernel just for this, so I'll be happy to test
> anything. Also note that I updated my firmware to the last version availa=
ble
> in
> the linux-firmware repo.

Well, I updated my system's BIOS and the issue went away. Sorry for the noi=
se.

Regards,
Nicolas


--=-1SaTSStqTlZL7Pl6MK8z
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl6VzhEACgkQlfZmHno8
x/5KiAgAhP9336w/Lhnefi6yL5JuxazTgvhppM//W9Ma/3HE0lm2CSKrZtE/yP8f
19jqNfOmCNbk7fr1YsFQ9mTX9klcamzkkEX4wiInFAS+5cBDry6D1GRPfKt9J/32
Aq5+eyqFcenRFLTg4wEnrMUkUjn7Jlz+HeyUOJyxMgHhH8jiCczW1MgbUqip1qen
ScBlGnue8sAosQlBKyEALBcfvtccPHVlG8Un1vNzHC5s7fHtYNpAPQlTvklBwmO5
mWPm++W0kJVJ4e3nJeln6I4kwHVsyBlwapzzGT5nPjaWGB4CpR1EH40fP8Scuyqv
MbBSdWssCJXvE4w+LRoZfFDuHYa46w==
=hrno
-----END PGP SIGNATURE-----

--=-1SaTSStqTlZL7Pl6MK8z--

