Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03E4A1D93DE
	for <lists+linux-wireless@lfdr.de>; Tue, 19 May 2020 11:57:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726504AbgESJ5s (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 19 May 2020 05:57:48 -0400
Received: from mail1.protonmail.ch ([185.70.40.18]:29625 "EHLO
        mail1.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726121AbgESJ5r (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 19 May 2020 05:57:47 -0400
Date:   Tue, 19 May 2020 09:57:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hyperfekt.net;
        s=protonmail; t=1589882264;
        bh=T3DJ45U1ZJiPFcVfOMMYCzfb7aBAyWhqRTqAJE0t3YE=;
        h=Date:To:From:Cc:Reply-To:Subject:From;
        b=heF5OGj1g7hTXx0ScK10HkNy6yIZ0ypBYMOOhQCfwnZ5S2e5mOCNEX1RWvhX8Ky0y
         O3RFOaBeE8RgjJ8MHXiM9ytnmZ+e7Y5vWEoDCgglQrF6KC6PHEInSOSionS204H5WM
         oI0dihgJ274W0O8CqdN9FmObiResz7iVMF53jiac=
To:     luca@coelho.fi
From:   linux-wireless@hyperfekt.net
Cc:     johannes@sipsolutions.net, linux-wireless@vger.kernel.org
Reply-To: linux-wireless@hyperfekt.net
Subject: Re: [PATCH 8/8] mac80211: IBSS: send deauth when expiring inactive STAs
Message-ID: <20200519095732.16268-1-linux-wireless@hyperfekt.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=7.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF shortcircuit=no
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on mail.protonmail.ch
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

I have good reason to believe that this patch is causing lockups on my mach=
ine.

This is because of what I believe to be a very unreliable PCIe connection t=
o
my wireless adapter, which means that it has to be reconfigured regularly.

On kernels with this patch applied however, the kernel seems to get stuck i=
n a
loop doing so, meanwhile spamming the journal with 'Failed
check-sdata-in-driver check' warnings at an astonishing rate.

By instructing the kernel to panic when it detects a hung task, I have been
able to obtain the following stack traces from the persistent store (ignore=
 the
'Tainted' flag, that's just because I omitted a large number of identical
'Failed check-sdata-in-driver check' oopses before this final one):

[ 2227.321477] ------------[ cut here ]------------
[ 2227.321477] wlan0:  Failed check-sdata-in-driver check, flags: 0x0
[ 2227.321486] WARNING: CPU: 3 PID: 6972 at net/mac80211/driver-ops.h:17 dr=
v_sta_state+0x241/0x3e0 [mac80211]
[ 2227.321486] Modules linked in: rfcomm af_packet ctr ccm algif_aead cbc d=
es_generic libdes ecb bnep arc4 algif_skcipher cmac sha512_ssse3 sha512_gen=
eric msr md4 algif_hash af_alg nls_iso8859_1 nls_cp437 vfat fat joydev mous=
edev uvcvideo videobuf2_vmalloc snd_hda_codec_hdmi videobuf2_memops snd_hda=
_codec_realtek snd_hda_codec_generic videobuf2_v4l2 videobuf2_common btusb =
x86_pkg_temp_thermal intel_powerclamp coretemp btrtl btbcm iwlmvm crc32_pcl=
mul dell_laptop ledtrig_audio ghash_clmulni_intel videodev dell_wmi btintel=
 mc sparse_keymap mac80211 bluetooth i915 intel_wmi_thunderbolt libarc4 mei=
_hdcp mei_wdt iTCO_wdt lz4 watchdog dell_smm_hwmon dell_smbios dcdbas intel=
_rapl_msr ecdh_generic ecc crc16 dell_wmi_descriptor wmi_bmof aesni_intel p=
pdev cec libaes drm_kms_helper crypto_simd iwlwifi cryptd glue_helper drm i=
ntel_cstate intel_gtt e1000e agpgart deflate intel_uncore evdev input_leds =
efi_pstore tpm_tis pstore tpm_tis_core intel_rapl_perf i2c_algo_bit i2c_i80=
1 snd_hda_intel cfg80211
[ 2227.321497]  fb_sys_fops led_class ptp efivars psmouse mac_hid snd_intel=
_dspcfg syscopyarea mei_me sysfillrect snd_hda_codec serio_raw sysimgblt sn=
d_hda_core pps_core mei tpm snd_hwdep i2c_core processor_thermal_device 825=
0_pci intel_rapl_common intel_pch_thermal thermal battery rng_core wmi inte=
l_soc_dts_iosf parport_pc parport video dell_smo8800 backlight int3400_ther=
mal int3403_thermal intel_pmc_core int340x_thermal_zone acpi_thermal_rel ac=
pi_pad ac dell_rbtn ip6table_nat rfkill button iptable_nat nf_nat zra xt_co=
nntrack zsmalloc nf_conntrack nf_defrag_ipv4 ip6t_rpfilter ipt_rpfilter ip6=
table_raw iptable_raw xt_pkttype nf_log_ipv6 nf_log_ipv4 nf_log_common xt_L=
OG xt_tcpudp ip6table_filter ip6_tables iptable_filter sch_fq_codel snd_pcm=
_oss snd_mixer_oss snd_pcm snd_timer snd soundcore loop cpufreq_powersave t=
un tap macvlan bridge stp llc kvm_intel kvm irqbypass efivarfs ip_tables x_=
tables ipv6 nf_defrag_ipv6 crc_ccitt autofs4 poly1305_generic libpoly1305 p=
oly1305_x86_64 chacha_generic
[ 2227.321510]  chacha_x86_64 libchacha bcachefs libcrc32c crc32c_generic z=
std_compress xor lz4_compress zstd_decompress crc64 raid6_pq sd_mod t10_pi =
crc_t10dif crct10dif_generic ahci libahci libata rtsx_pci_sdmmc xhci_pci mm=
c_core scsi_mod xhci_hcd atkbd libps2 usbcore crct10dif_pclmul crct10dif_co=
mmon rtsx_pci crc32c_intel usb_common rtc_cmos i8042 serio dm_mod
[ 2227.321516] CPU: 3 PID: 6972 Comm: kworker/3:2 Tainted: G        W      =
   5.6.13 #1-NixOS
[ 2227.321517] Hardware name: Dell Inc. Latitude E5470/0C8FKJ, BIOS 1.19.3 =
08/20/2018
[ 2227.321520] Workqueue: events_freezable ieee80211_restart_work [mac80211=
]
[ 2227.321524] RIP: 0010:drv_sta_state+0x241/0x3e0 [mac80211]
[ 2227.321525] Code: 00 45 31 e4 e9 70 fe ff ff 48 8b 83 78 04 00 00 48 8d =
b3 98 04 00 00 48 c7 c7 d8 0c 40 c1 48 85 c0 48 0f 45 f0 e8 c1 08 8e ec <0f=
> 0b 41 bc fb ff ff ff e9 47 fe ff ff 65 8b 05 7b 4f c7 3e 89 c0
[ 2227.321526] RSP: 0018:ffffb1255eb43a88 EFLAGS: 00010282
[ 2227.321526] RAX: 0000000000000000 RBX: ffffa088030b28c0 RCX: 00000000000=
00007
[ 2227.321527] RDX: 0000000000000007 RSI: 0000000000000092 RDI: ffffa0886dd=
99980
[ 2227.321528] RBP: ffffa0880cdd07c0 R08: 00000000001ce0a4 R09: 00000000000=
00045
[ 2227.321528] R10: ffffb1255eb43938 R11: ffffb1255eb4393d R12: ffffa0880cd=
d07c0
[ 2227.321529] R13: 0000000000000004 R14: 0000000000000001 R15: 00000000000=
00003
[ 2227.321530] FS:  0000000000000000(0000) GS:ffffa0886dd80000(0000) knlGS:=
0000000000000000
[ 2227.321531] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 2227.321531] CR2: 00007fbf74e2d000 CR3: 000000064abca002 CR4: 00000000003=
606e0
[ 2227.321532] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000000000=
00000
[ 2227.321533] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 00000000000=
00400
[ 2227.321533] Call Trace:
[ 2227.321538]  sta_info_move_state+0x18f/0x2b0 [mac80211]
[ 2227.321542]  __sta_info_destroy_part2+0x28/0x150 [mac80211]
[ 2227.321546]  __sta_info_flush+0x123/0x180 [mac80211]
[ 2227.321552]  ieee80211_set_disassoc+0xba/0x5b0 [mac80211]
[ 2227.321557]  ieee80211_mgd_deauth.cold+0x4a/0x1c2 [mac80211]
[ 2227.321562]  cfg80211_mlme_deauth+0xb3/0x1d0 [cfg80211]
[ 2227.321563]  ? mpihelp_addmul_1+0x23/0xc0
[ 2227.321568]  cfg80211_disconnect+0x98/0x1e0 [cfg80211]
[ 2227.321572]  cfg80211_leave+0x27/0x40 [cfg80211]
[ 2227.321576]  cfg80211_netdev_notifier_call+0x171/0x4e0 [cfg80211]
[ 2227.321578]  notifier_call_chain+0x4c/0x70
[ 2227.321579]  __dev_close_many+0x5f/0x110
[ 2227.321581]  dev_close_many+0x81/0x130
[ 2227.321581] Kernel panic - not syncing: hung_task: blocked tasks
[ 2227.321583] CPU: 0 PID: 32 Comm: khungtaskd Tainted: G        W         =
5.6.13 #1-NixOS
[ 2227.321583] Hardware name: Dell Inc. Latitude E5470/0C8FKJ, BIOS 1.19.3 =
08/20/2018
[ 2227.321584] Call Trace:
[ 2227.321586]  dump_stack+0x66/0x90
[ 2227.321587]  panic+0x101/0x2d7
[ 2227.321589]  watchdog+0x2c4/0x440
[ 2227.321590]  dev_close.part.0+0x3e/0x70
[ 2227.321593]  cfg80211_shutdown_all_interfaces+0x71/0xd0 [cfg80211]
[ 2227.321599]  ieee80211_reconfig+0xa2/0x1480 [mac80211]
[ 2227.321600]  ? try_to_del_timer_sync+0x4f/0x80
[ 2227.321602]  kthread+0xfb/0x130
[ 2227.321603]  ? hungtask_pm_notify+0x40/0x40
[ 2227.321604]  ? kthread_park+0x90/0x90
[ 2227.321605]  ret_from_fork+0x35/0x40
[ 2227.321610]  ieee80211_restart_work+0xb7/0xe0 [mac80211]
[ 2227.321612]  process_one_work+0x1e4/0x390
[ 2227.321613]  worker_thread+0x4d/0x3f0
[ 2227.321615]  kthread+0xfb/0x130
[ 2227.321616]  ? process_one_work+0x390/0x390
[ 2227.321617]  ? kthread_park+0x90/0x90
[ 2227.321619]  ret_from_fork+0x35/0x40
[ 2227.321620] ---[ end trace f9f5d799afd5a59f ]---
[ 2227.321623] Kernel Offset: 0x2cc00000 from 0xffffffff81000000 (relocatio=
n range: 0xffffffff80000000-0xffffffffbfffffff)
