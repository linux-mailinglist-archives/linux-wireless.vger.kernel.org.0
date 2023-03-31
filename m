Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 770796D2709
	for <lists+linux-wireless@lfdr.de>; Fri, 31 Mar 2023 19:51:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230496AbjCaRve (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 31 Mar 2023 13:51:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231539AbjCaRv3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 31 Mar 2023 13:51:29 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 494591A453
        for <linux-wireless@vger.kernel.org>; Fri, 31 Mar 2023 10:51:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D2972B83136
        for <linux-wireless@vger.kernel.org>; Fri, 31 Mar 2023 17:51:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40892C433EF;
        Fri, 31 Mar 2023 17:51:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680285083;
        bh=mLvO3H2rYzRSMlmVUmTZPZTKHQowqWrB7KCflKGcyIs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ROCJH+IVch6405nkCItb2uN++0ibrsydQhLKlt3XFMBF/ir9U1hINZQxG4UmiDsxk
         37EYDblhVel7qe+SqcOQAy+V0342WmPMZ91/N3krczmV50WyaYOmtUS/Oii2aOmlqM
         HmSo/vDMXSvh3ZTZwv5dEC0Nu9dy8M1yUXcIo3kKI8fRiQ1j3cSvqmKqhSA5Fl5tPJ
         +jgB3mT4mGfdI6RcPvSvOyabrTJYtI9nRQlExVvYGAV9UvfkGTOyePToO+hwkcT/tD
         RMIi3aYVPXRaXyJTIgu/DNmYrF/r0npmYwIk8w/EuVVZ7/kdueyE7+ojNxmr0AKBH6
         +RsMf4gintPZg==
Date:   Fri, 31 Mar 2023 10:51:21 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     gregory.greenman@intel.com
Cc:     johannes@sipsolutions.net, linux-wireless@vger.kernel.org,
        Avraham Stern <avraham.stern@intel.com>
Subject: Re: [PATCH 03/18] wifi: iwlwifi: mvm: report hardware timestamps in
 RX/TX status
Message-ID: <20230331175121.GA3127046@dev-arch.thelio-3990X>
References: <20230320103319.1309442-1-gregory.greenman@intel.com>
 <20230320122330.e0392d498101.I9bf12c8ecfb3f17253a13dc48a48647ddd6e7855@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230320122330.e0392d498101.I9bf12c8ecfb3f17253a13dc48a48647ddd6e7855@changeid>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi all,

On Mon, Mar 20, 2023 at 12:33:04PM +0200, gregory.greenman@intel.com wrote:
> From: Avraham Stern <avraham.stern@intel.com>
>=20
> For TM/FTM frames, report the hardware timestamps reported by the
> fw as part of the RX/TX status. Since the fw reports the timestamps
> in a dedicated notification (and not as part of the RX/TX status),
> hold the frame until the fw timestamps notification is received.
> Timestamping is enabled when a station is connected and disabled
> when disconnected. For AP interface, only the first station will
> have timestamping enabled since the fw only supports timestamping
> for one peer.
>=20
> Signed-off-by: Avraham Stern <avraham.stern@intel.com>
> Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>

My apologies if this has been reported and/or fixed already, I did a
search of lore but did not see much that appeared relevant. I bisected
the following warning to this change as commit c7eca79def44 ("wifi:
iwlwifi: mvm: report hardware timestamps in RX/TX status") in -next:

[    4.843020] ------------[ cut here ]------------
[    4.843025] WARNING: CPU: 0 PID: 325 at drivers/net/wireless/intel/iwlwi=
fi/mvm/../iwl-trans.h:1083 iwl_op_mode_mvm_start+0x9aa/0x9c0 [iwlmvm]
[    4.843080] Modules linked in: asix(+) spi_nor uvcvideo(+) polyval_clmul=
ni iwlmvm(+) btbcm(+) mdio_devres i915(+) videobuf2_vmalloc snd_hda_codec_r=
ealtek btintel polyval_generic mtd phylink joydev mac80211 btmtk snd_hda_co=
dec_generic asus_nb_wmi videobuf2_memops i2c_algo_bit gf128mul drm_buddy in=
tel_gtt uvc selftests libarc4 ghash_clmulni_intel videobuf2_v4l2 snd_hda_in=
tel iTCO_wdt processor_thermal_device_pci_legacy asus_wmi snd_intel_dspcfg =
sha512_ssse3 bluetooth at24 hid_multitouch intel_soc_dts_iosf mousedev drm_=
display_helper videodev usbnet aesni_intel ledtrig_audio intel_pmc_bxt snd_=
hda_codec iwlwifi ak8975 spi_intel_platform processor_thermal_device mei_hd=
cp crypto_simd spi_intel sparse_keymap mei_pxp processor_thermal_rfim mii s=
nd_hwdep videobuf2_common drm_kms_helper intel_rapl_msr iTCO_vendor_support=
 cryptd rapl syscopyarea platform_profile intel_cstate snd_hda_core libphy =
processor_thermal_mbox vfat fat mc intel_uncore crc16 sysfillrect snd_pcm p=
rocessor_thermal_rapl ecdh_generic pcspkr i2c_i801 snd_timer
[    4.843176]  usbhid sysimgblt cfg80211 snd psmouse intel_rapl_common cec=
 lpc_ich mei_me inv_mpu6050_i2c int340x_thermal_zone soundcore mei i2c_smbu=
s rfkill ttm video i2c_mux dell_smo8800 inv_mpu6050 acpi_als wmi industrial=
io_triggered_buffer kfifo_buf int3400_thermal industrialio soc_button_array=
 acpi_thermal_rel asus_wireless mac_hid lzo_rle pkcs8_key_parser dm_mod drm=
 crypto_user loop fuse zram bpf_preload ip_tables x_tables serio_raw atkbd =
libps2 vivaldi_fmap xhci_pci xhci_pci_renesas i8042 serio btrfs blake2b_gen=
eric xor raid6_pq libcrc32c crc32c_generic crc32c_intel
[    4.843240] CPU: 0 PID: 325 Comm: modprobe Not tainted 6.3.0-rc1-debug-0=
0495-gc7eca79def44 #1 a4d5f87d096a215486e36913932219012550f685
[    4.843244] Hardware name: ASUSTeK COMPUTER INC. Q302LA/Q302LA, BIOS Q30=
2LA.203 05/15/2014
[    4.843246] RIP: 0010:iwl_op_mode_mvm_start+0x9aa/0x9c0 [iwlmvm]
[    4.843290] Code: 49 c7 c0 c8 fa c1 c1 31 d2 be 40 00 00 00 48 c7 c1 30 =
63 c1 c1 48 8b 78 40 e8 c2 1b 20 ff e9 1c fd ff ff 0f 0b e9 3a fe ff ff <0f=
> 0b e9 0e fc ff ff 0f 0b e9 2c fe ff ff e8 43 9c 6e c6 0f 1f 00
[    4.843293] RSP: 0018:ffffb72e805afc58 EFLAGS: 00010286
[    4.843296] RAX: 00000000ffffffff RBX: ffff99bc92c2a080 RCX: ffffffffc1c=
16b80
[    4.843299] RDX: 0000000000000260 RSI: 0000000000000068 RDI: ffffffffc1c=
16920
[    4.843302] RBP: ffff99bc94d2c028 R08: 0000000000000059 R09: ffffffffc1c=
16480
[    4.843304] R10: ffffffffc1c16550 R11: 0000000000000001 R12: ffff99bc92c=
2a088
[    4.843306] R13: 0000000fffffffe0 R14: ffff99bc83c7e010 R15: ffffb72e805=
afc60
[    4.843309] FS:  00007f05697f2740(0000) GS:ffff99bd96e00000(0000) knlGS:=
0000000000000000
[    4.843312] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    4.843315] CR2: 00007fba940d0c3e CR3: 0000000101da8006 CR4: 00000000001=
706f0
[    4.843318] Call Trace:
[    4.843321]  <TASK>
[    4.843328]  _iwl_op_mode_start+0x9b/0xc0 [iwlwifi 816e2f3ee29c5271f5f7b=
e3fda523a489541761f]
[    4.843368]  iwl_opmode_register+0x6c/0xe0 [iwlwifi 816e2f3ee29c5271f5f7=
be3fda523a489541761f]
[    4.843400]  ? __pfx_init_module+0x10/0x10 [iwlmvm b9e7319e6775482213302=
e32712682db1169b8ac]
[    4.843440]  iwl_mvm_init+0x26/0xff0 [iwlmvm b9e7319e6775482213302e32712=
682db1169b8ac]
[    4.843480]  ? __pfx_init_module+0x10/0x10 [iwlmvm b9e7319e6775482213302=
e32712682db1169b8ac]
[    4.843517]  do_one_initcall+0x5d/0x240
[    4.843525]  do_init_module+0x4a/0x200
[    4.843532]  __do_sys_init_module+0x17f/0x1b0
[    4.843540]  do_syscall_64+0x5f/0x90
[    4.843545]  ? ksys_read+0x6f/0xf0
[    4.843551]  ? syscall_exit_to_user_mode+0x1b/0x40
[    4.843556]  ? do_syscall_64+0x6b/0x90
[    4.843560]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
[    4.843566] RIP: 0033:0x7f0569121eee
[    4.843584] Code: 48 8b 0d 85 ee 0c 00 f7 d8 64 89 01 48 83 c8 ff c3 66 =
2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 49 89 ca b8 af 00 00 00 0f 05 <48=
> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 52 ee 0c 00 f7 d8 64 89 01 48
[    4.843587] RSP: 002b:00007fff32834278 EFLAGS: 00000246 ORIG_RAX: 000000=
00000000af
[    4.843591] RAX: ffffffffffffffda RBX: 000055de38cbbba0 RCX: 00007f05691=
21eee
[    4.843593] RDX: 000055de379efcb2 RSI: 0000000000195667 RDI: 000055de38e=
c0d00
[    4.843595] RBP: 000055de379efcb2 R08: 27d4eb2f165667c5 R09: 00000000000=
00000
[    4.843598] R10: 00000000001fd711 R11: 0000000000000246 R12: 00000000000=
40000
[    4.843600] R13: 000055de38cbbcd0 R14: 0000000000000000 R15: 000055de38c=
bdec0
[    4.843605]  </TASK>
[    4.843606] ---[ end trace 0000000000000000 ]---

The output of 'sudo lspci -vvv -s 02:00.0', in case it is helpful:

02:00.0 Network controller: Intel Corporation Wireless 7260 (rev cb)
	Subsystem: Intel Corporation Dual Band Wireless-AC 7260
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort- =
<MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 49
	Region 0: Memory at f7c00000 (64-bit, non-prefetchable) [size=3D8K]
	Capabilities: [c8] Power Management version 3
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=3D0mA PME(D0+,D1-,D2-,D3hot+,D3col=
d+)
		Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
	Capabilities: [d0] MSI: Enable+ Count=3D1/1 Maskable- 64bit+
		Address: 00000000fee04004  Data: 0024
	Capabilities: [40] Express (v2) Endpoint, MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0, Latency L0s <512ns, L1 unlimit=
ed
			ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset+ SlotPowerLimit 0W
		DevCtl:	CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
			RlxdOrd- ExtTag- PhantFunc- AuxPwr+ NoSnoop+ FLReset-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr+ NonFatalErr- FatalErr- UnsupReq+ AuxPwr+ TransPend-
		LnkCap:	Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit Latency L0s <=
4us, L1 <32us
			ClockPM+ Surprise- LLActRep- BwNot- ASPMOptComp-
		LnkCtl:	ASPM L1 Enabled; RCB 64 bytes, Disabled- CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x1
			TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
		DevCap2: Completion Timeout: Range B, TimeoutDis+ NROPrPrP- LTR+
			 10BitTagComp- 10BitTagReq- OBFF Via WAKE#, ExtFmt- EETLPPrefix-
			 EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
			 FRS- TPHComp- ExtTPHComp-
			 AtomicOpsCap: 32bit- 64bit- 128bitCAS-
		DevCtl2: Completion Timeout: 16ms to 55ms, TimeoutDis- LTR+ 10BitTagReq- =
OBFF Disabled,
			 AtomicOpsCtl: ReqEn-
		LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- Compl=
ianceSOS-
			 Compliance Preset/De-emphasis: -6dB de-emphasis, 0dB preshoot
		LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete- Equaliz=
ationPhase1-
			 EqualizationPhase2- EqualizationPhase3- LinkEqualizationRequest-
			 Retimer- 2Retimers- CrosslinkRes: unsupported
	Capabilities: [100 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- =
ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- =
ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+=
 ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr-
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+
		AERCap:	First Error Pointer: 00, ECRCGenCap- ECRCGenEn- ECRCChkCap- ECRCC=
hkEn-
			MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
		HeaderLog: 00000000 00000000 00000000 00000000
	Capabilities: [140 v1] Device Serial Number a0-a8-cd-ff-ff-7a-2c-81
	Capabilities: [14c v1] Latency Tolerance Reporting
		Max snoop latency: 3145728ns
		Max no snoop latency: 3145728ns
	Capabilities: [154 v1] Vendor Specific Information: ID=3Dcafe Rev=3D1 Len=
=3D014 <?>
	Kernel driver in use: iwlwifi
	Kernel modules: iwlwifi

If there is any additional information that I can provide or patches I
can test, I am more than happy to do so.

Cheers,
Nathan

# bad: [4b0f4525dc4fe8af17b3daefe585f0c2eb0fe0a5] Add linux-next specific f=
iles for 20230331
# good: [b2bc47e9b2011a183f9d3d3454a294a938082fb9] Merge tag 'net-6.3-rc5' =
of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
git bisect start '4b0f4525dc4fe8af17b3daefe585f0c2eb0fe0a5' 'b2bc47e9b2011a=
183f9d3d3454a294a938082fb9'
# bad: [ed5f95f3349003d74a4a11b27b0f05d6794c382a] Merge branch 'master' of =
git://git.kernel.org/pub/scm/linux/kernel/git/herbert/cryptodev-2.6.git
git bisect bad ed5f95f3349003d74a4a11b27b0f05d6794c382a
# good: [a9b4a69e674abf5612e9201c0092f3be4ea47202] Merge branch 'for-next' =
of git://git.samba.org/sfrench/cifs-2.6.git
git bisect good a9b4a69e674abf5612e9201c0092f3be4ea47202
# good: [79548b7984e4c606c6caaad72a0864a83855ebc9] Merge git://git.kernel.o=
rg/pub/scm/linux/kernel/git/netdev/net
git bisect good 79548b7984e4c606c6caaad72a0864a83855ebc9
# good: [bafe06064a0979c2955902038c7bcde9a642c919] Merge branch 'thermal/li=
nux-next' of git://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git
git bisect good bafe06064a0979c2955902038c7bcde9a642c919
# good: [a725238d9bbcc774b0561b6d10657dcee22a95c3] Merge branch 'master' of=
 git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git
git bisect good a725238d9bbcc774b0561b6d10657dcee22a95c3
# bad: [b7e39d565fe1d32c6d8253340d577cc53fad03d8] wifi: iwlwifi: mvm: use S=
TA link address
git bisect bad b7e39d565fe1d32c6d8253340d577cc53fad03d8
# good: [1595ecce1cf32688760281f40b58b7a1d4a69aa9] wifi: iwlwifi: mvm: add =
support for PTP HW clock (PHC)
git bisect good 1595ecce1cf32688760281f40b58b7a1d4a69aa9
# bad: [6cf882d9aa9e8f1f2d63182e179ac4b2e59c00db] wifi: iwlwifi: mvm: Use 6=
4-bit division helper in iwl_mvm_get_crosstimestamp_fw()
git bisect bad 6cf882d9aa9e8f1f2d63182e179ac4b2e59c00db
# bad: [e626dad92383ca16d1d71e66124a272a0cbfe7bd] wifi: mac80211: fix race =
in mesh sequence number assignment
git bisect bad e626dad92383ca16d1d71e66124a272a0cbfe7bd
# bad: [f5034bcf6868bf5c2de272819aa6de23f5d588f7] wifi: iwlwifi: mvm: Don't=
 send MAC CTXT cmd after deauthorization
git bisect bad f5034bcf6868bf5c2de272819aa6de23f5d588f7
# bad: [a5de7de7e78eddd3ae16aec01c5601ae36c1c2e8] wifi: iwlwifi: mvm: enabl=
e TX beacon protection
git bisect bad a5de7de7e78eddd3ae16aec01c5601ae36c1c2e8
# bad: [c7eca79def44f1faf024d8442044287bef749818] wifi: iwlwifi: mvm: repor=
t hardware timestamps in RX/TX status
git bisect bad c7eca79def44f1faf024d8442044287bef749818
# good: [21fb8da6ebe40ce83468d6198143b4b583b967f9] wifi: iwlwifi: mvm: read=
 synced time from firmware if supported
git bisect good 21fb8da6ebe40ce83468d6198143b4b583b967f9
# first bad commit: [c7eca79def44f1faf024d8442044287bef749818] wifi: iwlwif=
i: mvm: report hardware timestamps in RX/TX status
