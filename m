Return-Path: <linux-wireless+bounces-15660-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DF079D784E
	for <lists+linux-wireless@lfdr.de>; Sun, 24 Nov 2024 22:25:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B2882B21F61
	for <lists+linux-wireless@lfdr.de>; Sun, 24 Nov 2024 21:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77289558BA;
	Sun, 24 Nov 2024 21:25:29 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from maynard.decadent.org.uk (maynard.decadent.org.uk [65.21.191.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12F0B2500AA
	for <linux-wireless@vger.kernel.org>; Sun, 24 Nov 2024 21:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.21.191.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732483529; cv=none; b=EaQQ0QaNZEuD+aSFtItLqaC8zR2R9WoiiBQFe1vWGLiPbhCgH1t0/9xfk805FPyms1Z+Fucw/lTmoJB/D3SnivudBpebk97WEmpSRboIlviqrzFs9x+4npQ/zMLxP8pQE6UvjsMESlm9IxoVrhZDwrAHxYpUlthj4I/6Mf2vovo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732483529; c=relaxed/simple;
	bh=On7qoZGbZagcLhNWwGSOnIncz3Tt7Ik2uM39Qzm1Zag=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=da+UG1wVJLa4/sDcg8HKd1TXZZumFDiFbDCrsyyvrWna7jC/29Aq8Xcg+ijbNiHri8l7qJzo8ae6KDtLclDd471hCC4LiLCE3HNX7FrL9Ja2TPYJxyMeB4db6irVaCYdtUJA+CgEcUm0Uut4V/TWjqp0liJ8g1UIQHHLN0cgL/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk; spf=pass smtp.mailfrom=decadent.org.uk; arc=none smtp.client-ip=65.21.191.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=decadent.org.uk
Received: from [2a02:578:851f:1502:391e:c5f5:10e2:b9a3] (helo=deadeye)
	by maynard with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ben@decadent.org.uk>)
	id 1tFJRs-005LOU-2c;
	Sun, 24 Nov 2024 20:43:16 +0000
Received: from ben by deadeye with local (Exim 4.98)
	(envelope-from <ben@decadent.org.uk>)
	id 1tFJRr-00000000FRZ-0h3a;
	Sun, 24 Nov 2024 21:43:15 +0100
Message-ID: <bad9ba17bfa59969152adbe01472c362cc7cfeb1.camel@decadent.org.uk>
Subject: Re: Bug#1087623: linux-image-6.11.7-amd64: WLAN device disappears
 after resume from suspend or hibernation (RTL8852CE PCIe, rtw89_8852ce)
From: Ben Hutchings <ben@decadent.org.uk>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: Vladimir K <pzs-fs@yandex.ru>, 1087623@bugs.debian.org, linux-wireless
	 <linux-wireless@vger.kernel.org>
Date: Sun, 24 Nov 2024 21:43:09 +0100
In-Reply-To: <173176088921.30312.821094110577110111.reportbug@thinker2>
References: <173176088921.30312.821094110577110111.reportbug@thinker2>
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-GQKOc/qFbyiB3F26orbn"
User-Agent: Evolution 3.54.1-1 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a02:578:851f:1502:391e:c5f5:10e2:b9a3
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on maynard); SAEximRunCond expanded to false


--=-GQKOc/qFbyiB3F26orbn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Debian received the following bug report regarding the rtw89_8852ce
driver.  We don't patch these drivers, so this is also an upstream
issue.  It looks like it may be a firmware/hardware issue, but perhaps
this is something that the driver could work around?

Ben.

On Sat, 2024-11-16 at 15:41 +0300, Vladimir K wrote:
> Package: src:linux
> Version: 6.11.7-1
> Severity: normal
>=20
> Dear Maintainer, Realtek WLAN device disappears after resume from hiberna=
tion.
>=20
> The laptop is Lenovo ThinkBook 14 G7 IML.
>=20
> Tried to work around this by unloading rtw89_8852ce before sleep, it fixe=
d the original
> problem, but caused device disappearance after resume from suspend. So th=
e valid workaround
> is to unload the module only before hibernation:
>=20
>     $ cat /usr/lib/systemd/system-sleep/hibernate_rtw89
>     #!/bin/sh
>     case "${1}_${2}" in
>     pre_hibernate) modprobe -rv rtw89_8852ce ;;
>     post_hibernate) modprobe -v rtw89_8852ce ;;
>     esac
>=20
> Errors on resume from hibernation before any workaround:
>=20
>     kernel: rtw89_8852ce 0000:44:00.0: xtal si not ready(W): offset=3D90 =
val=3D10 mask=3D10
>     kernel: rtw89_8852ce 0000:44:00.0: xtal si not ready(W): offset=3D90 =
val=3D10 mask=3D10
>     kernel: rtw89_8852ce 0000:44:00.0: mac init fail, ret:-110
>     kernel: ------------[ cut here ]------------
>     kernel: Hardware became unavailable upon resume. This could be a soft=
ware issue prior to suspend or a hardware issue.
>     kernel: WARNING: CPU: 1 PID: 28284 at net/mac80211/util.c:1828 ieee80=
211_reconfig+0xa0/0x15e0 [mac80211]
>     kernel: Modules linked in: uinput snd_seq_dummy snd_hrtimer snd_seq s=
nd_seq_device rfcomm cmac algif_hash algif_skcipher af_alg bnep btusb uvcvi=
deo btrtl btintel btbcm videobuf2_vmalloc btmtk uvc videobuf2_memops videob=
uf2_v4l2 bluetooth videodev qrtr videobuf2_common mc crc16 lz4 lz4_compress=
 zram binfmt_misc nls_ascii nls_cp437 vfat fat snd_ctl_led snd_soc_skl_hda_=
dsp snd_soc_hdac_hdmi snd_sof_probes snd_soc_intel_hda_dsp_common snd_hda_c=
odec_hdmi snd_hda_codec_realtek snd_hda_codec_generic snd_hda_scodec_compon=
ent snd_soc_dmic nft_masq snd_sof_pci_intel_mtl snd_sof_intel_hda_generic r=
tw89_8852ce soundwire_intel soundwire_generic_allocation rtw89_8852c soundw=
ire_cadence snd_sof_intel_hda_common snd_sof_intel_hda_mlink rtw89_pci snd_=
sof_intel_hda intel_uncore_frequency snd_sof_pci intel_uncore_frequency_com=
mon x86_pkg_temp_thermal snd_sof_xtensa_dsp intel_powerclamp rtw89_core snd=
_sof kvm_intel snd_sof_utils snd_soc_hdac_hda nft_reject_inet nf_reject_ipv=
4 snd_hda_ext_core nf_reject_ipv6 snd_soc_acpi_intel_match                 =
                                                    =20
>     kernel:  nft_reject snd_soc_acpi lenovo_ymc kvm mac80211 nft_ct snd_s=
oc_core snd_compress snd_pcm_dmaengine rapl soundwire_bus intel_cstate inte=
l_rapl_msr snd_hda_intel snd_intel_dspcfg snd_intel_sdw_acpi snd_hda_codec =
libarc4 snd_hda_core processor_thermal_device_pci think_lmi iTCO_wdt proces=
sor_thermal_device snd_hwdep intel_uncore cfg80211 snd_pcm wmi_bmof firmwar=
e_attributes_class nft_redir processor_thermal_wt_hint intel_pmc_bxt iTCO_v=
endor_support processor_thermal_rfim mei_me snd_timer processor_thermal_rap=
l watchdog snd intel_rapl_common mei ucsi_acpi soundcore processor_thermal_=
wt_req typec_ucsi processor_thermal_power_floor ideapad_laptop processor_th=
ermal_mbox igen6_edac typec platform_profile roles int3403_thermal rfkill i=
nt340x_thermal_zone intel_pmc_core ac joydev intel_vsec nft_chain_nat pmt_t=
elemetry nf_nat int3400_thermal acpi_tad intel_hid pmt_class acpi_pad acpi_=
thermal_rel sparse_keymap evdev nf_conntrack serio_raw nf_defrag_ipv6 nf_de=
frag_ipv4 pkcs8_key_parser coretemp msr ecryptfs i2c_dev                   =
                                                    =20
>     kernel:  parport_pc ppdev nf_tables lp parport loop nvme_fabrics conf=
igfs efi_pstore nfnetlink ip_tables x_tables autofs4 btrfs blake2b_generic =
dm_crypt dm_mod efivarfs raid10 raid456 async_raid6_recov async_memcpy asyn=
c_pq async_xor async_tx xor raid6_pq libcrc32c crc32c_generic raid1 raid0 m=
d_mod i915 drm_buddy i2c_algo_bit drm_display_helper hid_multitouch cec crc=
t10dif_pclmul hid_generic crc32_pclmul rc_core crc32c_intel sdhci_pci ghash=
_clmulni_intel i2c_hid_acpi ttm cqhci i2c_hid xhci_pci sha512_ssse3 xhci_hc=
d drm_kms_helper hid sdhci nvme sha256_ssse3 thunderbolt e1000e usbcore mmc=
_core sha1_ssse3 drm nvme_core i2c_i801 intel_lpss_pci intel_lpss i2c_smbus=
 idma64 usb_common fan button video battery wmi pinctrl_meteorlake aesni_in=
tel gf128mul crypto_simd cryptd                                            =
                                                                           =
               =20
>     kernel: CPU: 1 UID: 0 PID: 28284 Comm: kworker/u57:66 Tainted: G     =
U             6.11.6-amd64 #1  Debian 6.11.6-1
>     kernel: Tainted: [U]=3DUSER
>     kernel: Hardware name: LENOVO 21MR/LNVNB161216, BIOS P3CN38WW 05/30/2=
024
>     kernel: Workqueue: async async_run_entry_fn
>     kernel: RIP: 0010:ieee80211_reconfig+0xa0/0x15e0 [mac80211]
>     kernel: Code: 03 00 00 41 c6 87 ad 05 00 00 00 4c 89 ff e8 27 82 fb f=
f 41 89 c4 85 c0 0f 84 16 03 00 00 48 c7 c7 50 10 ac c1 e8 f0 01 4d c6 <0f>=
 0b eb 31 84 c0 0f 85 aa 01 00 00 41 c6 87 ad 05 00 00 00 4c 89            =
                                                                           =
                                                      =20
>     kernel: RSP: 0000:ffffb7528d38bce0 EFLAGS: 00010286
>     kernel: RAX: 0000000000000000 RBX: ffff9d49f8300538 RCX: 000000000000=
0027
>     kernel: RDX: ffff9d511fca1788 RSI: 0000000000000001 RDI: ffff9d511fca=
1780
>     kernel: RBP: ffff9d49f83003c0 R08: 0000000000000000 R09: ffffb7528d38=
baa8
>     kernel: R10: ffffffff89a87270 R11: 0000000000000003 R12: 00000000ffff=
ff92
>     kernel: R13: 0000000000000040 R14: 0000000000000000 R15: ffff9d49f830=
0900
>     kernel: FS:  0000000000000000(0000) GS:ffff9d511fc80000(0000) knlGS:0=
000000000000000
>     kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>     kernel: CR2: 0000000000000000 CR3: 0000000590c22001 CR4: 0000000000f7=
0ef0
>     kernel: DR0: 0000000000000000 DR1: 0000000000000000 DR2: 000000000000=
0000
>     kernel: DR3: 0000000000000000 DR6: 00000000ffff07f0 DR7: 000000000000=
0400
>     kernel: PKRU: 55555554
>     kernel: Call Trace:
>     kernel:  <TASK>
>     kernel:  ? ieee80211_reconfig+0xa0/0x15e0 [mac80211]
>     kernel:  ? __warn.cold+0x8e/0xe8
>     kernel:  ? ieee80211_reconfig+0xa0/0x15e0 [mac80211]
>     kernel:  ? report_bug+0xff/0x140
>     kernel:  ? handle_bug+0x3c/0x80
>     kernel:  ? exc_invalid_op+0x17/0x70
>     kernel:  ? asm_exc_invalid_op+0x1a/0x20
>     kernel:  ? ieee80211_reconfig+0xa0/0x15e0 [mac80211]
>     kernel:  ? select_task_rq_fair+0x4db/0x1730
>     kernel:  ? __pfx_worker_thread+0x10/0x10
>     kernel:  ? wait_for_completion+0x3a/0x160
>     kernel:  wiphy_resume+0x82/0x1b0 [cfg80211]
>     kernel:  ? __pfx_wiphy_resume+0x10/0x10 [cfg80211]
>     kernel:  dpm_run_callback+0x47/0x150
>     kernel:  device_resume+0x9c/0x210
>     kernel:  async_resume+0x1d/0x30
>     kernel:  async_run_entry_fn+0x31/0x130
>     kernel:  process_one_work+0x174/0x330
>     kernel:  worker_thread+0x252/0x390
>     kernel:  ? __pfx_worker_thread+0x10/0x10
>     kernel:  kthread+0xcf/0x100
>     kernel:  ? __pfx_kthread+0x10/0x10
>     kernel:  ret_from_fork+0x31/0x50
>     kernel:  ? __pfx_kthread+0x10/0x10
>     kernel:  ret_from_fork_asm+0x1a/0x30
>     kernel:  </TASK>
>     kernel: ---[ end trace 0000000000000000 ]---
>     kernel: ------------[ cut here ]------------
>     kernel: WARNING: CPU: 1 PID: 28284 at net/mac80211/driver-ops.c:41 dr=
v_stop+0xfd/0x110 [mac80211]
>     kernel: Modules linked in: uinput snd_seq_dummy snd_hrtimer snd_seq s=
nd_seq_device rfcomm cmac algif_hash algif_skcipher af_alg bnep btusb uvcvi=
deo btrtl btintel btbcm videobuf2_vmalloc btmtk uvc videobuf2_memops videob=
uf2_v4l2 bluetooth videodev qrtr videobuf2_common mc crc16 lz4 lz4_compress=
 zram binfmt_misc nls_ascii nls_cp437 vfat fat snd_ctl_led snd_soc_skl_hda_=
dsp snd_soc_hdac_hdmi snd_sof_probes snd_soc_intel_hda_dsp_common snd_hda_c=
odec_hdmi snd_hda_codec_realtek snd_hda_codec_generic snd_hda_scodec_compon=
ent snd_soc_dmic nft_masq snd_sof_pci_intel_mtl snd_sof_intel_hda_generic r=
tw89_8852ce soundwire_intel soundwire_generic_allocation rtw89_8852c soundw=
ire_cadence snd_sof_intel_hda_common snd_sof_intel_hda_mlink rtw89_pci snd_=
sof_intel_hda intel_uncore_frequency snd_sof_pci intel_uncore_frequency_com=
mon x86_pkg_temp_thermal snd_sof_xtensa_dsp intel_powerclamp rtw89_core snd=
_sof kvm_intel snd_sof_utils snd_soc_hdac_hda nft_reject_inet nf_reject_ipv=
4 snd_hda_ext_core nf_reject_ipv6 snd_soc_acpi_intel_match                 =
                                                    =20
>     kernel:  nft_reject snd_soc_acpi lenovo_ymc kvm mac80211 nft_ct snd_s=
oc_core snd_compress snd_pcm_dmaengine rapl soundwire_bus intel_cstate inte=
l_rapl_msr snd_hda_intel snd_intel_dspcfg snd_intel_sdw_acpi snd_hda_codec =
libarc4 snd_hda_core processor_thermal_device_pci think_lmi iTCO_wdt proces=
sor_thermal_device snd_hwdep intel_uncore cfg80211 snd_pcm wmi_bmof firmwar=
e_attributes_class nft_redir processor_thermal_wt_hint intel_pmc_bxt iTCO_v=
endor_support processor_thermal_rfim mei_me snd_timer processor_thermal_rap=
l watchdog snd intel_rapl_common mei ucsi_acpi soundcore processor_thermal_=
wt_req typec_ucsi processor_thermal_power_floor ideapad_laptop processor_th=
ermal_mbox igen6_edac typec platform_profile roles int3403_thermal rfkill i=
nt340x_thermal_zone intel_pmc_core ac joydev intel_vsec nft_chain_nat pmt_t=
elemetry nf_nat int3400_thermal acpi_tad intel_hid pmt_class acpi_pad acpi_=
thermal_rel sparse_keymap evdev nf_conntrack serio_raw nf_defrag_ipv6 nf_de=
frag_ipv4 pkcs8_key_parser coretemp msr ecryptfs i2c_dev                   =
                                                    =20
>     kernel:  parport_pc ppdev nf_tables lp parport loop nvme_fabrics conf=
igfs efi_pstore nfnetlink ip_tables x_tables autofs4 btrfs blake2b_generic =
dm_crypt dm_mod efivarfs raid10 raid456 async_raid6_recov async_memcpy asyn=
c_pq async_xor async_tx xor raid6_pq libcrc32c crc32c_generic raid1 raid0 m=
d_mod i915 drm_buddy i2c_algo_bit drm_display_helper hid_multitouch cec crc=
t10dif_pclmul hid_generic crc32_pclmul rc_core crc32c_intel sdhci_pci ghash=
_clmulni_intel i2c_hid_acpi ttm cqhci i2c_hid xhci_pci sha512_ssse3 xhci_hc=
d drm_kms_helper hid sdhci nvme sha256_ssse3 thunderbolt e1000e usbcore mmc=
_core sha1_ssse3 drm nvme_core i2c_i801 intel_lpss_pci intel_lpss i2c_smbus=
 idma64 usb_common fan button video battery wmi pinctrl_meteorlake aesni_in=
tel gf128mul crypto_simd cryptd                                            =
                                                                           =
               =20
>     kernel: CPU: 1 UID: 0 PID: 28284 Comm: kworker/u57:66 Tainted: G     =
U  W          6.11.6-amd64 #1  Debian 6.11.6-1
>     kernel: Tainted: [U]=3DUSER, [W]=3DWARN
>     kernel: Hardware name: LENOVO 21MR/LNVNB161216, BIOS P3CN38WW 05/30/2=
024
>     kernel: Workqueue: async async_run_entry_fn
>     kernel: RIP: 0010:drv_stop+0xfd/0x110 [mac80211]
>     kernel: Code: 48 85 c0 74 0e 48 8b 78 08 89 ea 48 89 de e8 5a 3b 05 0=
0 65 ff 0d fb de 68 3e 0f 85 38 ff ff ff 0f 1f 44 00 00 e9 2e ff ff ff <0f>=
 0b 5b 5d c3 cc cc cc cc 66 2e 0f 1f 84 00 00 00 00 00 90 90 90            =
                                                                           =
                                                      =20
>     kernel: RSP: 0000:ffffb7528d38bbe8 EFLAGS: 00010246
>     kernel: RAX: 0000000000000000 RBX: ffff9d49f8300900 RCX: ffff9d49c429=
6468
>     kernel: RDX: 0000000000000001 RSI: 0000000000000000 RDI: ffff9d49f830=
0900
>     kernel: RBP: 0000000000000000 R08: ffffffff89ace6f0 R09: ffff9d49cac5=
e1b0
>     kernel: R10: ffff9d49f8301210 R11: 0000000000000246 R12: ffff9d49f830=
0900
>     kernel: R13: ffffb7528d38bc30 R14: ffffb7528d38bc30 R15: 000000000000=
0000
>     kernel: FS:  0000000000000000(0000) GS:ffff9d511fc80000(0000) knlGS:0=
000000000000000
>     kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>     kernel: CR2: 0000000000000000 CR3: 0000000590c22001 CR4: 0000000000f7=
0ef0
>     kernel: DR0: 0000000000000000 DR1: 0000000000000000 DR2: 000000000000=
0000
>     kernel: DR3: 0000000000000000 DR6: 00000000ffff07f0 DR7: 000000000000=
0400
>     kernel: PKRU: 55555554
>     kernel: Call Trace:
>     kernel:  <TASK>
>     kernel:  ? drv_stop+0xfd/0x110 [mac80211]
>     kernel:  ? __warn.cold+0x8e/0xe8
>     kernel:  ? drv_stop+0xfd/0x110 [mac80211]
>     kernel:  ? report_bug+0xff/0x140
>     kernel:  ? handle_bug+0x3c/0x80
>     kernel:  ? exc_invalid_op+0x17/0x70
>     kernel:  ? asm_exc_invalid_op+0x1a/0x20
>     kernel:  ? drv_stop+0xfd/0x110 [mac80211]
>     kernel:  ? drv_stop+0x15/0x110 [mac80211]
>     kernel:  ieee80211_do_stop+0x6a8/0x920 [mac80211]
>     kernel:  ieee80211_stop+0x58/0x1a0 [mac80211]
>     kernel:  __dev_close_many+0xaa/0x130
>     kernel:  dev_close_many+0xb2/0x190
>     kernel:  dev_close+0x93/0xc0
>     kernel:  cfg80211_shutdown_all_interfaces+0x4d/0xf0 [cfg80211]
>     kernel:  wiphy_resume+0xc1/0x1b0 [cfg80211]
>     kernel:  ? __pfx_wiphy_resume+0x10/0x10 [cfg80211]
>     kernel:  dpm_run_callback+0x47/0x150
>     kernel:  device_resume+0x9c/0x210
>     kernel:  async_resume+0x1d/0x30
>     kernel:  async_run_entry_fn+0x31/0x130
>     kernel:  process_one_work+0x174/0x330
>     kernel:  worker_thread+0x252/0x390
>     kernel:  ? __pfx_worker_thread+0x10/0x10
>     kernel:  kthread+0xcf/0x100
>     kernel:  ? __pfx_kthread+0x10/0x10
>     kernel:  ret_from_fork+0x31/0x50
>     kernel:  ? __pfx_kthread+0x10/0x10
>     kernel:  ret_from_fork_asm+0x1a/0x30
>     kernel:  </TASK>
>     kernel: ---[ end trace 0000000000000000 ]---
>     kernel: ieee80211 phy0: PM: dpm_run_callback(): wiphy_resume [cfg8021=
1] returns -110
>     kernel: ieee80211 phy0: PM: failed to restore async: error -110
>=20
> Errors on resume from suspend when unloading before both is applied:
>=20
>     kernel: rtw89_8852ce 0000:44:00.0: loaded firmware rtw89/rtw8852c_fw.=
bin
>     kernel: rtw89_8852ce 0000:44:00.0: Firmware version 0.27.56.14 (1942d=
927), cmd version 0, type 1
>     kernel: rtw89_8852ce 0000:44:00.0: Firmware version 0.27.56.14 (1942d=
927), cmd version 0, type 3
>     kernel: rtw89_8852ce 0000:44:00.0: xtal si not ready(W): offset=3D90 =
val=3D10 mask=3D10
>     kernel: rtw89_8852ce 0000:44:00.0: failed to setup chip information
>     kernel: rtw89_8852ce 0000:44:00.0: probe with driver rtw89_8852ce fai=
led with error -110
>=20
> -- Package-specific info:
> ** Version:
> Linux version 6.11.7-amd64 (debian-kernel@lists.debian.org) (x86_64-linux=
-gnu-gcc-14 (Debian 14.2.0-8) 14.2.0, GNU ld (GNU Binutils for Debian) 2.43=
.1) #1 SMP PREEMPT_DYNAMIC Debian 6.11.7-1 (2024-11-09)
>=20
> ** Command line:
> initrd=3D\963ee9cb563b42029c94db4f35ce99ef\6.11.7-amd64\initrd.img-6.11.7=
-amd64 root=3DUUID=3D859ba516-d84d-458c-ac5c-979ce55ca125 ro rootflags=3Dsu=
bvol=3D@ splash quiet systemd.machine_id=3D963ee9cb563b42029c94db4f35ce99ef
>=20
> ** Tainted: U (64)
>  * taint requested by userspace application
>=20
> ** Kernel log:
> [ 1929.272003] [  15758]     0 15758    64028      743      576      167 =
        0   143360        0             0 cups-browsed
> [ 1929.272005] [  15765]     0 15765     2434      378      224      154 =
        0    65536        0             0 smartd
> [ 1929.272006] [  15793]     0 15793   117554      779      768       11 =
        0   147456        0             0 udisksd
> [ 1929.272008] [  15833]     0 15833     7145      416      416        0 =
        0    81920        0         -1000 systemd-udevd
> [ 1929.272010] [  16061]     0 16061    35052      256      224       32 =
        0   241664        0          -250 systemd-journal
> [ 1929.272011] [  16103]   106 16103     9258     3090     2939      151 =
        0   118784        0             0 exim4
> [ 1929.272013] [  16119]     0 16119    80308      594      512       82 =
        0   122880        0             0 upowerd
> [ 1929.272015] [  16158]   997 16158    97008      728      664       64 =
        0   110592        0             0 polkitd
> [ 1929.272016] [  16174]     0 16174    84696     1223     1184       39 =
        0   163840        0             0 NetworkManager
> [ 1929.272018] [  16190]     0 16190    97543      562      416      146 =
        0   122880        0             0 ModemManager
> [ 1929.272019] [  16379] 65534 16379     4012      199       96      103 =
        0    69632        0             0 dnsmasq
> [ 1929.272021] [  16507]  1000 16507   609228     3511     3328       18 =
      165   540672        0           233 Web Content
> [ 1929.272023] [  16626]  1000 16626   169107     5838     3680        0 =
     2158   528384        0           200 qterminal
> [ 1929.272024] [  16685]  1000 16685     3622     1164     1131       33 =
        0    65536        0           200 bash
> [ 1929.272026] [  17183]  1000 17183   609228     3512     3328       19 =
      165   540672        0           233 Web Content
> [ 1929.272028] [  18024]  1000 18024  6982122  6977600  6977600        0 =
        0 56004608        0           200 python
> [ 1929.272030] [  18047]  1000 18047     1237       10        0       10 =
        0    40960        0           200 free
> [ 1929.272032] [  18055]  1000 18055      691        0        0        0 =
        0    40960        0           200 sh
> [ 1929.272033] oom-kill:constraint=3DCONSTRAINT_NONE,nodemask=3D(null),cp=
uset=3D/,mems_allowed=3D0,global_oom,task_memcg=3D/user.slice/user-1000.sli=
ce/user@1000.service/app.slice/app-graphical.slice/app-Hyprland-qterminal@0=
2f77be1.service,task=3Dpython,pid=3D18024,uid=3D1000
> [ 1929.272050] Out of memory: Killed process 18024 (python) total-vm:2792=
8488kB, anon-rss:27910400kB, file-rss:0kB, shmem-rss:0kB, UID:1000 pgtables=
:54692kB oom_score_adj:200
> [ 1929.273134] Purging GPU memory, 0 pages freed, 0 pages still pinned, 3=
190 pages left available.
> [ 1929.274566] Purging GPU memory, 0 pages freed, 0 pages still pinned, 3=
190 pages left available.
> [ 1929.274809] Purging GPU memory, 0 pages freed, 0 pages still pinned, 3=
190 pages left available.
> [ 1929.277919] Purging GPU memory, 0 pages freed, 0 pages still pinned, 3=
190 pages left available.
> [ 1929.278327] Purging GPU memory, 0 pages freed, 0 pages still pinned, 3=
190 pages left available.
> [ 1929.283677] Purging GPU memory, 0 pages freed, 0 pages still pinned, 3=
190 pages left available.
> [ 1929.287164] Purging GPU memory, 0 pages freed, 0 pages still pinned, 3=
190 pages left available.
> [ 1929.569978] systemd[1]: systemd-journald.service: Main process exited,=
 code=3Dkilled, status=3D6/ABRT
> [ 1929.570114] systemd[1]: systemd-journald.service: Failed with result '=
watchdog'.
> [ 1929.573254] systemd[1]: systemd-journald.service: Consumed 2min 18.930=
s CPU time, 6.6M memory peak.
> [ 1929.579749] systemd[1]: systemd-journald.service: Scheduled restart jo=
b, restart counter is at 1.
> [ 1929.584640] systemd[1]: Starting systemd-journald.service - Journal Se=
rvice...
> [ 1929.729540] systemd-journald[18118]: Collecting audit messages is disa=
bled.
> [ 1929.779488] systemd[1]: Started systemd-journald.service - Journal Ser=
vice.
> [ 1929.779728] systemd-journald[18118]: File /var/log/journal/963ee9cb563=
b42029c94db4f35ce99ef/user-1000.journal corrupted or uncleanly shut down, r=
enaming and replacing.
> [ 7734.586767] wlan0: deauthenticated from ac:3b:77:4c:8a:f5 (Reason: 7=
=3DCLASS3_FRAME_FROM_NONASSOC_STA)
> [ 7735.011416] wlan0: authenticate with ac:3b:77:4c:8a:f5 (local address=
=3Dc0:35:32:09:59:2d)
> [ 7735.011422] wlan0: send auth to ac:3b:77:4c:8a:f5 (try 1/3)
> [ 7735.012234] wlan0: authenticated
> [ 7735.015663] wlan0: associate with ac:3b:77:4c:8a:f5 (try 1/3)
> [ 7735.016960] wlan0: RX AssocResp from ac:3b:77:4c:8a:f5 (capab=3D0x1011=
 status=3D0 aid=3D1)
> [ 7735.132218] wlan0: associated
> [ 8284.992867] warning: `telegram-deskto' uses wireless extensions which =
will stop working for Wi-Fi 7 hardware; use nl80211
> [ 8913.380951] atkbd serio0: Unknown key pressed (translated set 2, code =
0xf8 on isa0060/serio0).
> [ 8913.380968] atkbd serio0: Use 'setkeycodes e078 <keycode>' to make it =
known.
> [ 8913.389151] atkbd serio0: Unknown key released (translated set 2, code=
 0xf8 on isa0060/serio0).
> [ 8913.389167] atkbd serio0: Use 'setkeycodes e078 <keycode>' to make it =
known.
> [ 9766.895968] e1000e 0000:00:1f.6 eno0: NIC Link is Down
> [ 9766.943094] wlan0: deauthenticating from ac:3b:77:4c:8a:f5 by local ch=
oice (Reason: 3=3DDEAUTH_LEAVING)
> [ 9767.820179] PM: suspend entry (s2idle)
> [ 9768.014227] Filesystems sync: 0.194 seconds
> [ 9768.017254] Freezing user space processes
> [ 9768.018722] Freezing user space processes completed (elapsed 0.001 sec=
onds)
> [ 9768.018725] OOM killer disabled.
> [ 9768.018726] Freezing remaining freezable tasks
> [ 9768.019899] Freezing remaining freezable tasks completed (elapsed 0.00=
1 seconds)
> [ 9768.019903] printk: Suspending console(s) (use no_console_suspend to d=
ebug)
> [ 9768.081423] e1000e: EEE TX LPI TIMER: 00000011
> [ 9769.229386] ACPI: EC: interrupt blocked
> [ 9779.341395] ACPI: EC: interrupt unblocked
> [ 9779.399343] pci 0000:00:08.0: Setting to D3hot
> [ 9779.411369] pci 0000:00:0b.0: Setting to D3hot
> [ 9779.430532] i915 0000:00:02.0: [drm] GT0: GuC firmware i915/mtl_guc_70=
.bin version 70.29.2
> [ 9779.439314] nvme nvme1: 14/0/0 default/read/poll queues
> [ 9779.439966] nvme nvme0: 14/0/0 default/read/poll queues
> [ 9779.441708] i915 0000:00:02.0: [drm] GT0: GUC: submission enabled
> [ 9779.441710] i915 0000:00:02.0: [drm] GT0: GUC: SLPC enabled
> [ 9779.441964] i915 0000:00:02.0: [drm] GT0: GUC: RC enabled
> [ 9779.442394] i915 0000:00:02.0: [drm] GT1: GuC firmware i915/mtl_guc_70=
.bin version 70.29.2
> [ 9779.442396] i915 0000:00:02.0: [drm] GT1: HuC firmware i915/mtl_huc_gs=
c.bin version 8.5.4
> [ 9779.456082] i915 0000:00:02.0: [drm] GT1: GUC: submission enabled
> [ 9779.456083] i915 0000:00:02.0: [drm] GT1: GUC: SLPC enabled
> [ 9779.456156] i915 0000:00:02.0: [drm] GT1: GUC: RC enabled
> [ 9779.637448] usb 1-10: reset full-speed USB device number 4 using xhci_=
hcd
> [ 9780.631959] OOM killer enabled.
> [ 9780.631960] Restarting tasks ... done.
> [ 9780.632502] random: crng reseeded on system resumption
> [ 9780.633739] Bluetooth: hci0: RTL: examining hci_ver=3D0c hci_rev=3D000=
c lmp_ver=3D0c lmp_subver=3D8852
> [ 9780.634725] Bluetooth: hci0: RTL: rom_version status=3D0 version=3D1
> [ 9780.634729] Bluetooth: hci0: RTL: loading rtl_bt/rtl8852cu_fw_v2.bin
> [ 9780.634824] Bluetooth: hci0: RTL: loading rtl_bt/rtl8852cu_config.bin
> [ 9780.635780] Bluetooth: hci0: RTL: cfg_sz 6, total sz 71983
> [ 9780.638786] PM: suspend exit
> [ 9781.001032] Bluetooth: hci0: RTL: fw version 0x040d7225
> [ 9781.098344] Bluetooth: MGMT ver 1.23
> [ 9781.110560] Bluetooth: hci0: Invalid link address type 1 for 2c:6d:c1:=
93:a3:c2
> [ 9785.052632] wlan0: authenticate with ac:3b:77:4c:8a:f5 (local address=
=3Dc0:35:32:09:59:2d)
> [ 9785.052642] wlan0: send auth to ac:3b:77:4c:8a:f5 (try 1/3)
> [ 9785.053443] wlan0: authenticated
> [ 9785.056991] wlan0: associate with ac:3b:77:4c:8a:f5 (try 1/3)
> [ 9785.058354] wlan0: RX AssocResp from ac:3b:77:4c:8a:f5 (capab=3D0x1011=
 status=3D0 aid=3D1)
> [ 9785.173506] wlan0: associated
> [ 9898.247863] atkbd serio0: Unknown key pressed (translated set 2, code =
0xf8 on isa0060/serio0).
> [ 9898.247879] atkbd serio0: Use 'setkeycodes e078 <keycode>' to make it =
known.
> [ 9898.257878] atkbd serio0: Unknown key released (translated set 2, code=
 0xf8 on isa0060/serio0).
> [ 9898.257895] atkbd serio0: Use 'setkeycodes e078 <keycode>' to make it =
known.
> [ 9898.284180] atkbd serio0: Unknown key pressed (translated set 2, code =
0xf8 on isa0060/serio0).
> [ 9898.284196] atkbd serio0: Use 'setkeycodes e078 <keycode>' to make it =
known.
> [ 9898.293497] atkbd serio0: Unknown key released (translated set 2, code=
 0xf8 on isa0060/serio0).
> [ 9898.293514] atkbd serio0: Use 'setkeycodes e078 <keycode>' to make it =
known.
>=20
> ** Model information
> sys_vendor: LENOVO
> product_name: 21MR
> product_version: ThinkBook 14 G7 IML
> chassis_vendor: LENOVO
> chassis_version: ThinkBook 14 G7 IML
> bios_vendor: LENOVO
> bios_version: P3CN38WW
> board_vendor: LENOVO
> board_name: LNVNB161216
> board_version: NO DPK
>=20
> ** Loaded modules:
> snd_seq_dummy
> snd_hrtimer
> snd_seq
> snd_seq_device
> ccm
> qrtr
> rfcomm
> cmac
> algif_hash
> algif_skcipher
> af_alg
> bnep
> lz4
> lz4_compress
> zram
> binfmt_misc
> btusb
> btrtl
> btintel
> btbcm
> btmtk
> uvcvideo
> bluetooth
> videobuf2_vmalloc
> uvc
> videobuf2_memops
> videobuf2_v4l2
> videodev
> videobuf2_common
> mc
> crc16
> nls_ascii
> nls_cp437
> vfat
> fat
> snd_ctl_led
> snd_soc_skl_hda_dsp
> snd_soc_hdac_hdmi
> snd_soc_intel_hda_dsp_common
> snd_sof_probes
> snd_hda_codec_hdmi
> snd_hda_codec_realtek
> snd_hda_codec_generic
> snd_hda_scodec_component
> snd_soc_dmic
> snd_sof_pci_intel_mtl
> snd_sof_intel_hda_generic
> soundwire_intel
> soundwire_generic_allocation
> soundwire_cadence
> snd_sof_intel_hda_common
> snd_sof_intel_hda_mlink
> snd_sof_intel_hda
> snd_sof_pci
> snd_sof_xtensa_dsp
> rtw89_8852ce
> snd_sof
> rtw89_8852c
> snd_sof_utils
> rtw89_pci
> snd_soc_hdac_hda
> snd_hda_ext_core
> intel_uncore_frequency
> snd_soc_acpi_intel_match
> intel_uncore_frequency_common
> snd_soc_acpi
> x86_pkg_temp_thermal
> intel_powerclamp
> rtw89_core
> snd_soc_core
> kvm_intel
> snd_compress
> snd_pcm_dmaengine
> nft_masq
> soundwire_bus
> snd_hda_intel
> kvm
> mac80211
> snd_intel_dspcfg
> snd_intel_sdw_acpi
> intel_rapl_msr
> lenovo_ymc
> snd_hda_codec
> nft_reject_inet
> nf_reject_ipv4
> nf_reject_ipv6
> nft_reject
> snd_hda_core
> rapl
> libarc4
> snd_hwdep
> intel_cstate
> snd_pcm
> processor_thermal_device_pci
> cfg80211
> iTCO_wdt
> intel_pmc_bxt
> processor_thermal_device
> intel_uncore
> think_lmi
> iTCO_vendor_support
> nft_ct
> processor_thermal_wt_hint
> wmi_bmof
> firmware_attributes_class
> snd_timer
> processor_thermal_rfim
> watchdog
> processor_thermal_rapl
> snd
> mei_me
> ucsi_acpi
> mei
> typec_ucsi
> intel_rapl_common
> soundcore
> processor_thermal_wt_req
> typec
> processor_thermal_power_floor
> processor_thermal_mbox
> igen6_edac
> roles
> ideapad_laptop
> platform_profile
> rfkill
> intel_pmc_core
> ac
> int3403_thermal
> int340x_thermal_zone
> intel_vsec
> pmt_telemetry
> joydev
> pmt_class
> intel_hid
> acpi_tad
> int3400_thermal
> acpi_thermal_rel
> sparse_keymap
> acpi_pad
> nft_redir
> serio_raw
> evdev
> nft_chain_nat
> nf_nat
> nf_conntrack
> nf_defrag_ipv6
> nf_defrag_ipv4
> pkcs8_key_parser
> coretemp
> msr
> ecryptfs
> i2c_dev
> parport_pc
> ppdev
> nf_tables
> lp
> parport
> loop
> nvme_fabrics
> configfs
> efi_pstore
> nfnetlink
> ip_tables
> x_tables
> autofs4
> btrfs
> blake2b_generic
> dm_crypt
> dm_mod
> efivarfs
> raid10
> raid456
> async_raid6_recov
> async_memcpy
> async_pq
> async_xor
> async_tx
> xor
> raid6_pq
> libcrc32c
> crc32c_generic
> raid1
> raid0
> md_mod
> i915
> crct10dif_pclmul
> crc32_pclmul
> crc32c_intel
> drm_buddy
> i2c_algo_bit
> drm_display_helper
> hid_multitouch
> cec
> hid_generic
> ghash_clmulni_intel
> rc_core
> sdhci_pci
> i2c_hid_acpi
> ttm
> i2c_hid
> sha512_ssse3
> cqhci
> xhci_pci
> xhci_hcd
> drm_kms_helper
> hid
> sdhci
> nvme
> sha256_ssse3
> usbcore
> thunderbolt
> e1000e
> mmc_core
> drm
> intel_lpss_pci
> i2c_i801
> sha1_ssse3
> nvme_core
> i2c_smbus
> intel_lpss
> usb_common
> idma64
> fan
> button
> video
> battery
> wmi
> pinctrl_meteorlake
> aesni_intel
> gf128mul
> crypto_simd
> cryptd
>=20
> ** PCI devices:
> 00:00.0 Host bridge [0600]: Intel Corporation Device [8086:7d02] (rev 04)
> 	Subsystem: Lenovo Device [17aa:3801]
> 	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Step=
ping- SERR- FastB2B- DisINTx-
> 	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dfast >TAbort- <TAbort=
- <MAbort- >SERR- <PERR- INTx-
> 	Latency: 0
> 	IOMMU group: 1
> 	Capabilities: <access denied>
> 	Kernel driver in use: igen6_edac
> 	Kernel modules: igen6_edac
>=20
> 00:02.0 VGA compatible controller [0300]: Intel Corporation Meteor Lake-P=
 [Intel Graphics] [8086:7d45] (rev 08) (prog-if 00 [VGA controller])
> 	DeviceName: To Be Filled by O.E.M.
> 	Subsystem: Lenovo Device [17aa:3fa0]
> 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Step=
ping- SERR- FastB2B- DisINTx-
> 	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort=
- <MAbort- >SERR- <PERR- INTx-
> 	Latency: 0
> 	Interrupt: pin ? routed to IRQ 192
> 	IOMMU group: 0
> 	Region 0: Memory at 4818000000 (64-bit, prefetchable) [size=3D16M]
> 	Region 2: Memory at 4000000000 (64-bit, prefetchable) [size=3D256M]
> 	Expansion ROM at 000c0000 [virtual] [disabled] [size=3D128K]
> 	Capabilities: <access denied>
> 	Kernel driver in use: i915
> 	Kernel modules: i915
>=20
> 00:04.0 Signal processing controller [1180]: Intel Corporation Meteor Lak=
e-P Dynamic Tuning Technology [8086:7d03] (rev 04)
> 	Subsystem: Lenovo Device [17aa:3809]
> 	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Step=
ping- SERR- FastB2B- DisINTx-
> 	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dfast >TAbort- <TAbort=
- <MAbort- >SERR- <PERR- INTx-
> 	Latency: 0
> 	Interrupt: pin A routed to IRQ 16
> 	IOMMU group: 2
> 	Region 0: Memory at 4819280000 (64-bit, non-prefetchable) [size=3D128K]
> 	Capabilities: <access denied>
> 	Kernel driver in use: proc_thermal_pci
> 	Kernel modules: processor_thermal_device_pci
>=20
> 00:06.0 PCI bridge [0604]: Intel Corporation Device [8086:7eca] (rev 10) =
(prog-if 00 [Normal decode])
> 	Subsystem: Lenovo Device [17aa:3802]
> 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Step=
ping- SERR+ FastB2B- DisINTx+
> 	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort=
- <MAbort- >SERR- <PERR- INTx-
> 	Latency: 0
> 	Interrupt: pin B routed to IRQ 122
> 	IOMMU group: 3
> 	Bus: primary=3D00, secondary=3D01, subordinate=3D01, sec-latency=3D0
> 	I/O behind bridge: [disabled] [16-bit]
> 	Memory behind bridge: 90300000-903fffff [size=3D1M] [32-bit]
> 	Prefetchable memory behind bridge: [disabled] [64-bit]
> 	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort=
- <MAbort- <SERR- <PERR-
> 	BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16- MAbort- >Reset- FastB2B-
> 		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
> 	Capabilities: <access denied>
> 	Kernel driver in use: pcieport
>=20
> 00:06.2 PCI bridge [0604]: Intel Corporation Device [8086:7ecb] (rev 10) =
(prog-if 00 [Normal decode])
> 	Subsystem: Lenovo Device [17aa:3803]
> 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Step=
ping- SERR+ FastB2B- DisINTx+
> 	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort=
- <MAbort- >SERR- <PERR- INTx-
> 	Latency: 0
> 	Interrupt: pin C routed to IRQ 123
> 	IOMMU group: 4
> 	Bus: primary=3D00, secondary=3D02, subordinate=3D02, sec-latency=3D0
> 	I/O behind bridge: [disabled] [16-bit]
> 	Memory behind bridge: 90200000-902fffff [size=3D1M] [32-bit]
> 	Prefetchable memory behind bridge: [disabled] [64-bit]
> 	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort=
- <MAbort- <SERR- <PERR-
> 	BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16- MAbort- >Reset- FastB2B-
> 		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
> 	Capabilities: <access denied>
> 	Kernel driver in use: pcieport
>=20
> 00:07.0 PCI bridge [0604]: Intel Corporation Meteor Lake-P Thunderbolt 4 =
PCI Express Root Port #2 [8086:7ec6] (rev 10) (prog-if 00 [Normal decode])
> 	Subsystem: Lenovo Device [17aa:3807]
> 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Step=
ping- SERR- FastB2B- DisINTx+
> 	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort=
- <MAbort- >SERR- <PERR- INTx-
> 	Latency: 0
> 	Interrupt: pin C routed to IRQ 124
> 	IOMMU group: 5
> 	Bus: primary=3D00, secondary=3D03, subordinate=3D43, sec-latency=3D0
> 	I/O behind bridge: 3000-3fff [size=3D4K] [16-bit]
> 	Memory behind bridge: 80000000-8fffffff [size=3D256M] [32-bit]
> 	Prefetchable memory behind bridge: 4010000000-480fffffff [size=3D32G] [3=
2-bit]
> 	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort=
- <MAbort- <SERR- <PERR-
> 	BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16- MAbort- >Reset- FastB2B-
> 		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
> 	Capabilities: <access denied>
> 	Kernel driver in use: pcieport
>=20
> 00:08.0 System peripheral [0880]: Intel Corporation Meteor Lake-P Gaussia=
n & Neural-Network Accelerator [8086:7e4c] (rev 20)
> 	Subsystem: Lenovo Device [17aa:3810]
> 	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Step=
ping- SERR- FastB2B- DisINTx-
> 	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort=
- <MAbort- >SERR- <PERR- INTx-
> 	Interrupt: pin A routed to IRQ 255
> 	IOMMU group: 6
> 	Region 0: Memory at 48192d0000 (64-bit, non-prefetchable) [disabled] [si=
ze=3D4K]
> 	Capabilities: <access denied>
>=20
> 00:0a.0 Signal processing controller [1180]: Intel Corporation Meteor Lak=
e-P Platform Monitoring Technology [8086:7d0d] (rev 01)
> 	Subsystem: Lenovo Device [17aa:3803]
> 	Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Step=
ping- SERR- FastB2B- DisINTx-
> 	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort=
- <MAbort- >SERR- <PERR- INTx-
> 	IOMMU group: 7
> 	Region 0: Memory at 4819240000 (64-bit, non-prefetchable) [size=3D256K]
> 	Capabilities: <access denied>
> 	Kernel driver in use: intel_vsec
> 	Kernel modules: intel_vsec
>=20
> 00:0b.0 Processing accelerators [1200]: Intel Corporation Meteor Lake NPU=
 [8086:7d1d] (rev 04)
> 	Subsystem: Lenovo Device [17aa:3802]
> 	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Step=
ping- SERR- FastB2B- DisINTx-
> 	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort=
- <MAbort- >SERR- <PERR- INTx-
> 	IOMMU group: 8
> 	Region 0: Memory at 4810000000 (64-bit, non-prefetchable) [disabled] [si=
ze=3D128M]
> 	Region 4: Memory at 48192cf000 (64-bit, non-prefetchable) [disabled] [si=
ze=3D4K]
> 	Capabilities: <access denied>
>=20
> 00:0d.0 USB controller [0c03]: Intel Corporation Meteor Lake-P Thunderbol=
t 4 USB Controller [8086:7ec0] (rev 10) (prog-if 30 [XHCI])
> 	Subsystem: Lenovo Device [17aa:3801]
> 	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Step=
ping- SERR- FastB2B- DisINTx+
> 	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbo=
rt- <MAbort- >SERR- <PERR- INTx-
> 	Latency: 0, Cache Line Size: 64 bytes
> 	Interrupt: pin ? routed to IRQ 184
> 	IOMMU group: 9
> 	Region 0: Memory at 48192b0000 (64-bit, non-prefetchable) [size=3D64K]
> 	Capabilities: <access denied>
> 	Kernel driver in use: xhci_hcd
> 	Kernel modules: xhci_pci
>=20
> 00:0d.3 USB controller [0c03]: Intel Corporation Meteor Lake-P Thunderbol=
t 4 NHI #1 [8086:7ec3] (rev 10) (prog-if 40 [USB4 Host Interface])
> 	Subsystem: Lenovo Device [17aa:380d]
> 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Step=
ping- SERR- FastB2B- DisINTx+
> 	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort=
- <MAbort- >SERR- <PERR- INTx-
> 	Latency: 0
> 	Interrupt: pin A routed to IRQ 16
> 	IOMMU group: 9
> 	Region 0: Memory at 4819200000 (64-bit, non-prefetchable) [size=3D256K]
> 	Region 2: Memory at 48192ce000 (64-bit, non-prefetchable) [size=3D4K]
> 	Capabilities: <access denied>
> 	Kernel driver in use: thunderbolt
> 	Kernel modules: thunderbolt
>=20
> 00:14.0 USB controller [0c03]: Intel Corporation Meteor Lake-P USB 3.2 Ge=
n 2x1 xHCI Host Controller [8086:7e7d] (rev 20) (prog-if 30 [XHCI])
> 	Subsystem: Lenovo Device [17aa:380f]
> 	Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Step=
ping- SERR- FastB2B- DisINTx+
> 	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbo=
rt- <MAbort- >SERR- <PERR- INTx-
> 	Interrupt: pin A routed to IRQ 174
> 	IOMMU group: 10
> 	Region 0: Memory at 48192a0000 (64-bit, non-prefetchable) [size=3D64K]
> 	Capabilities: <access denied>
> 	Kernel driver in use: xhci_hcd
> 	Kernel modules: xhci_pci
>=20
> 00:14.2 RAM memory [0500]: Intel Corporation Device [8086:7e7f] (rev 20)
> 	Subsystem: Lenovo Device [17aa:3811]
> 	Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Step=
ping- SERR- FastB2B- DisINTx-
> 	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort=
- <MAbort- >SERR- <PERR- INTx-
> 	IOMMU group: 10
> 	Region 0: Memory at 48192c4000 (64-bit, non-prefetchable) [size=3D16K]
> 	Region 2: Memory at 48192cd000 (64-bit, non-prefetchable) [size=3D4K]
> 	Capabilities: <access denied>
>=20
> 00:15.0 Serial bus controller [0c80]: Intel Corporation Meteor Lake-P Ser=
ial IO I2C Controller #0 [8086:7e78] (rev 20)
> 	Subsystem: Lenovo Device [17aa:3813]
> 	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Step=
ping- SERR- FastB2B- DisINTx-
> 	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort=
- <MAbort- >SERR- <PERR- INTx-
> 	Latency: 0, Cache Line Size: 64 bytes
> 	Interrupt: pin A routed to IRQ 32
> 	IOMMU group: 11
> 	Region 0: Memory at 48192ca000 (64-bit, non-prefetchable) [size=3D4K]
> 	Capabilities: <access denied>
> 	Kernel driver in use: intel-lpss
> 	Kernel modules: intel_lpss_pci
>=20
> 00:15.1 Serial bus controller [0c80]: Intel Corporation Meteor Lake-P Ser=
ial IO I2C Controller #1 [8086:7e79] (rev 20)
> 	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Step=
ping- SERR- FastB2B- DisINTx-
> 	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort=
- <MAbort- >SERR- <PERR- INTx-
> 	Latency: 0, Cache Line Size: 64 bytes
> 	Interrupt: pin B routed to IRQ 33
> 	IOMMU group: 11
> 	Region 0: Memory at 48192cb000 (64-bit, non-prefetchable) [size=3D4K]
> 	Capabilities: <access denied>
> 	Kernel driver in use: intel-lpss
> 	Kernel modules: intel_lpss_pci
>=20
> 00:15.2 Serial bus controller [0c80]: Intel Corporation Meteor Lake-P Ser=
ial IO I2C Controller #2 [8086:7e7a] (rev 20)
> 	Subsystem: Lenovo Device [17aa:3815]
> 	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Step=
ping- SERR- FastB2B- DisINTx-
> 	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort=
- <MAbort- >SERR- <PERR- INTx-
> 	Latency: 0, Cache Line Size: 64 bytes
> 	Interrupt: pin C routed to IRQ 34
> 	IOMMU group: 11
> 	Region 0: Memory at 48192cc000 (64-bit, non-prefetchable) [size=3D4K]
> 	Capabilities: <access denied>
> 	Kernel driver in use: intel-lpss
> 	Kernel modules: intel_lpss_pci
>=20
> 00:16.0 Communication controller [0780]: Intel Corporation Meteor Lake-P =
CSME HECI #1 [8086:7e70] (rev 20)
> 	Subsystem: Lenovo Device [17aa:3814]
> 	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Step=
ping- SERR- FastB2B- DisINTx+
> 	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort=
- <MAbort- >SERR- <PERR- INTx-
> 	Latency: 0
> 	Interrupt: pin A routed to IRQ 143
> 	IOMMU group: 12
> 	Region 0: Memory at 48192c9000 (64-bit, non-prefetchable) [size=3D4K]
> 	Capabilities: <access denied>
> 	Kernel driver in use: mei_me
> 	Kernel modules: mei_me
>=20
> 00:1c.0 PCI bridge [0604]: Intel Corporation Device [8086:7e3d] (rev 20) =
(prog-if 00 [Normal decode])
> 	Subsystem: Lenovo Device [17aa:3816]
> 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Step=
ping- SERR+ FastB2B- DisINTx+
> 	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort=
- <MAbort- >SERR- <PERR- INTx-
> 	Latency: 0
> 	Interrupt: pin B routed to IRQ 125
> 	IOMMU group: 13
> 	Bus: primary=3D00, secondary=3D44, subordinate=3D44, sec-latency=3D0
> 	I/O behind bridge: 2000-2fff [size=3D4K] [16-bit]
> 	Memory behind bridge: 90100000-901fffff [size=3D1M] [32-bit]
> 	Prefetchable memory behind bridge: [disabled] [64-bit]
> 	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort=
- <MAbort- <SERR- <PERR-
> 	BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16- MAbort- >Reset- FastB2B-
> 		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
> 	Capabilities: <access denied>
> 	Kernel driver in use: pcieport
>=20
> 00:1c.6 PCI bridge [0604]: Intel Corporation Device [8086:7e3e] (rev 20) =
(prog-if 00 [Normal decode])
> 	Subsystem: Lenovo Device [17aa:3817]
> 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Step=
ping- SERR+ FastB2B- DisINTx+
> 	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort=
- <MAbort- >SERR- <PERR- INTx-
> 	Latency: 0
> 	Interrupt: pin C routed to IRQ 126
> 	IOMMU group: 14
> 	Bus: primary=3D00, secondary=3D45, subordinate=3D45, sec-latency=3D0
> 	I/O behind bridge: [disabled] [16-bit]
> 	Memory behind bridge: 90000000-900fffff [size=3D1M] [32-bit]
> 	Prefetchable memory behind bridge: [disabled] [64-bit]
> 	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort=
- <MAbort- <SERR- <PERR-
> 	BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16- MAbort- >Reset- FastB2B-
> 		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
> 	Capabilities: <access denied>
> 	Kernel driver in use: pcieport
>=20
> 00:1f.0 ISA bridge [0601]: Intel Corporation Device [8086:7e03] (rev 20)
> 	Subsystem: Lenovo Device [17aa:3801]
> 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Step=
ping- SERR- FastB2B- DisINTx+
> 	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort=
- <MAbort- >SERR- <PERR- INTx-
> 	Latency: 0
> 	IOMMU group: 15
>=20
> 00:1f.3 Multimedia audio controller [0401]: Intel Corporation Meteor Lake=
-P HD Audio Controller [8086:7e28] (rev 20)
> 	Subsystem: Lenovo Device [17aa:381b]
> 	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Step=
ping- SERR- FastB2B- DisINTx+
> 	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort=
- <MAbort- >SERR- <PERR- INTx-
> 	Latency: 64
> 	Interrupt: pin A routed to IRQ 194
> 	IOMMU group: 15
> 	Region 0: Memory at 48192c0000 (64-bit, non-prefetchable) [size=3D16K]
> 	Region 4: Memory at 4819000000 (64-bit, non-prefetchable) [size=3D2M]
> 	Capabilities: <access denied>
> 	Kernel driver in use: sof-audio-pci-intel-mtl
> 	Kernel modules: snd_hda_intel, snd_sof_pci_intel_mtl
>=20
> 00:1f.4 SMBus [0c05]: Intel Corporation Meteor Lake-P SMBus Controller [8=
086:7e22] (rev 20)
> 	Subsystem: Lenovo Device [17aa:381a]
> 	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Step=
ping- SERR- FastB2B- DisINTx-
> 	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbo=
rt- <MAbort- >SERR- <PERR- INTx-
> 	Interrupt: pin C routed to IRQ 18
> 	IOMMU group: 15
> 	Region 0: Memory at 48192c8000 (64-bit, non-prefetchable) [size=3D256]
> 	Region 4: I/O ports at efa0 [size=3D32]
> 	Kernel driver in use: i801_smbus
> 	Kernel modules: i2c_i801
>=20
> 00:1f.5 Serial bus controller [0c80]: Intel Corporation Meteor Lake-P SPI=
 Controller [8086:7e23] (rev 20)
> 	Subsystem: Lenovo Device [17aa:381e]
> 	Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Step=
ping- SERR- FastB2B- DisINTx+
> 	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort=
- <MAbort- >SERR- <PERR- INTx-
> 	IOMMU group: 15
> 	Region 0: Memory at 90420000 (32-bit, non-prefetchable) [size=3D4K]
>=20
> 00:1f.6 Ethernet controller [0200]: Intel Corporation Device [8086:550b] =
(rev 20)
> 	DeviceName: To Be Filled by O.E.M.
> 	Subsystem: Lenovo Device [17aa:3820]
> 	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Step=
ping- SERR- FastB2B- DisINTx+
> 	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort=
- <MAbort- >SERR- <PERR- INTx-
> 	Latency: 0
> 	Interrupt: pin D routed to IRQ 193
> 	IOMMU group: 15
> 	Region 0: Memory at 90400000 (32-bit, non-prefetchable) [size=3D128K]
> 	Capabilities: <access denied>
> 	Kernel driver in use: e1000e
> 	Kernel modules: e1000e
>=20
> 01:00.0 Non-Volatile memory controller [0108]: Sandisk Corp SanDisk Ultra=
 3D / WD Blue SN570 NVMe SSD (DRAM-less) [15b7:501a] (prog-if 02 [NVM Expre=
ss])
> 	Subsystem: Sandisk Corp SanDisk Ultra 3D / WD Blue SN570 NVMe SSD (DRAM-=
less) [15b7:501a]
> 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Step=
ping- SERR- FastB2B- DisINTx+
> 	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort=
- <MAbort- >SERR- <PERR- INTx-
> 	Latency: 0
> 	Interrupt: pin A routed to IRQ 16
> 	IOMMU group: 16
> 	Region 0: Memory at 90300000 (64-bit, non-prefetchable) [size=3D16K]
> 	Region 4: Memory at 90304000 (64-bit, non-prefetchable) [size=3D256]
> 	Capabilities: <access denied>
> 	Kernel driver in use: nvme
> 	Kernel modules: nvme
>=20
> 02:00.0 Non-Volatile memory controller [0108]: Sandisk Corp SanDisk Ultra=
 3D / WD Blue SN550 NVMe SSD [15b7:5009] (rev 01) (prog-if 02 [NVM Express]=
)
> 	Subsystem: Sandisk Corp WD Blue SN550 NVMe SSD [15b7:5009]
> 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Step=
ping- SERR- FastB2B- DisINTx+
> 	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort=
- <MAbort- >SERR- <PERR- INTx-
> 	Latency: 0
> 	Interrupt: pin A routed to IRQ 16
> 	IOMMU group: 17
> 	Region 0: Memory at 90200000 (64-bit, non-prefetchable) [size=3D16K]
> 	Region 4: Memory at 90204000 (64-bit, non-prefetchable) [size=3D256]
> 	Capabilities: <access denied>
> 	Kernel driver in use: nvme
> 	Kernel modules: nvme
>=20
> 44:00.0 Network controller [0280]: Realtek Semiconductor Co., Ltd. RTL885=
2CE PCIe 802.11ax Wireless Network Controller [10ec:c852] (rev 01)
> 	Subsystem: Lenovo Device [17aa:5852]
> 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Step=
ping- SERR- FastB2B- DisINTx+
> 	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort=
- <MAbort- >SERR- <PERR- INTx-
> 	Latency: 0
> 	Interrupt: pin A routed to IRQ 195
> 	IOMMU group: 18
> 	Region 0: I/O ports at 2000 [size=3D256]
> 	Region 2: Memory at 90100000 (64-bit, non-prefetchable) [size=3D1M]
> 	Capabilities: <access denied>
> 	Kernel driver in use: rtw89_8852ce
> 	Kernel modules: rtw89_8852ce
>=20
> 45:00.0 SD Host controller [0805]: O2 Micro, Inc. SD/MMC Card Reader Cont=
roller [1217:8621] (rev 01) (prog-if 01)
> 	Subsystem: Lenovo Device [17aa:38ca]
> 	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Step=
ping- SERR- FastB2B- DisINTx+
> 	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort=
- <MAbort- >SERR- <PERR- INTx-
> 	Latency: 0
> 	Interrupt: pin A routed to IRQ 182
> 	IOMMU group: 19
> 	Region 0: Memory at 90001000 (32-bit, non-prefetchable) [size=3D4K]
> 	Region 1: Memory at 90000000 (32-bit, non-prefetchable) [size=3D2K]
> 	Capabilities: <access denied>
> 	Kernel driver in use: sdhci-pci
> 	Kernel modules: sdhci_pci
>=20
>=20
> ** USB devices:
> Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
> Bus 001 Device 002: ID 04f2:b808 Chicony Electronics Co., Ltd Integrated =
Camera
> Bus 001 Device 003: ID 27c6:659a Shenzhen Goodix Technology Co.,Ltd. Good=
ix USB2.0 MISC
> Bus 001 Device 004: ID 0bda:5852 Realtek Semiconductor Corp. Bluetooth Ra=
dio
> Bus 002 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
> Bus 003 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
> Bus 004 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
>=20
>=20
> -- System Information:
> Debian Release: trixie/sid
>   APT prefers unstable
>   APT policy: (500, 'unstable'), (200, 'experimental')
> Architecture: amd64 (x86_64)
> Foreign Architectures: i386
>=20
> Kernel: Linux 6.11.7-amd64 (SMP w/14 CPU threads; PREEMPT)
> Kernel taint flags: TAINT_USER
> Locale: LANG=3Dru_RU.UTF-8, LC_CTYPE=3Dru_RU.UTF-8 (charmap=3DUTF-8), LAN=
GUAGE not set
> Shell: /bin/sh linked to /usr/bin/dash
> Init: systemd (via /run/systemd/system)
> LSM: AppArmor: enabled
>=20
> Versions of packages linux-image-6.11.7-amd64 depends on:
> ii  initramfs-tools [linux-initramfs-tool]  0.145
> ii  kmod                                    33+20240816-2
> ii  linux-base                              4.10.1
>=20
> Versions of packages linux-image-6.11.7-amd64 recommends:
> ii  apparmor  3.1.7-1+b3
>=20
> Versions of packages linux-image-6.11.7-amd64 suggests:
> pn  debian-kernel-handbook               <none>
> ii  firmware-linux-free                  20240610-1
> pn  grub-pc | grub-efi-amd64 | extlinux  <none>
> pn  linux-doc-6.11                       <none>
>=20
> Versions of packages linux-image-6.11.7-amd64 is related to:
> ii  firmware-amd-graphics     20240909-2
> ii  firmware-atheros          20240909-2
> ii  firmware-bnx2             20240909-2
> ii  firmware-bnx2x            20240909-2
> ii  firmware-brcm80211        20240909-2
> pn  firmware-cavium           <none>
> ii  firmware-intel-sound      20240909-2
> pn  firmware-intelwimax       <none>
> ii  firmware-ipw2x00          20240909-2
> ii  firmware-ivtv             20240909-2
> ii  firmware-iwlwifi          20240909-2
> ii  firmware-libertas         20240909-2
> ii  firmware-linux-nonfree    20240909-2
> ii  firmware-misc-nonfree     20240909-2
> ii  firmware-myricom          20240909-2
> ii  firmware-netxen           20240909-2
> ii  firmware-qlogic           20240909-2
> ii  firmware-realtek          20240909-2
> ii  firmware-samsung          20240909-2
> pn  firmware-siano            <none>
> ii  firmware-ti-connectivity  20240909-2
> pn  xen-hypervisor            <none>
>=20
> -- no debconf information
>=20

--=20
Ben Hutchings
Any smoothly functioning technology is indistinguishable
from a rigged demo.


--=-GQKOc/qFbyiB3F26orbn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAmdDj90ACgkQ57/I7JWG
EQmpmxAAs1VJBnPWm1pxCgGKPMLfim2sxuoGyCg+UBr5SalorkkrlOINsJdx8mPd
xX1SjmazjdMQmzJDkt/BSG1527PeIBiAMBlU0npl5qbOpolxXLBT1qjRYBYH8Qlm
rBGH5xJVQkAgJMpEZk/H4ip9h+vxG9Ijzn1QqeOiDujEjHw9+/BEAGS5TrmG9i8+
Ztba9xk7mjIc384CsdoD675l1Q6TPk8co7IY/oMR9nTqsxG7gkDch2r1tcIINUIH
6cm5zcdBOhe0mCWatrEtS6C4W8P/Vacdvat5yF1u9JKKViwVxppvOCyy7aDA2cGo
VrF+goeIgVQRYxpKaFIzcF8WXb7SFSBf0qj5V2d2VlcYbwBSO/K0+FkMakWrADyy
C/lmnXrq8OUQv72vBgq460q/RFqA8liB+gjUBz3CttqDBd1TapRXW1bLF74d5/rP
QDy/4ZwgSi9kbPOT+KnTlhqxyBEXKU7M4Pl3RDILpBsXIsGD7FvxP1TYpqrb6zVS
4seYEGOtFzvGfg2Fvlutv16cwZurNDvQzm1KcE/fdtAoc3fqEaA3NYxCeSp435xY
2o205PI3yrXRO3ZF+oFd6we7LvtwUAkJfI0s4qLjgXAzaZ55vWgVUBZnNINMvai+
W18VeP6OfiDDzYe2shPhwbeWTgo3vvrRRsZsBPYGHzsCuZLMpkI=
=cB7R
-----END PGP SIGNATURE-----

--=-GQKOc/qFbyiB3F26orbn--

