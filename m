Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10C94432946
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Oct 2021 23:48:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231938AbhJRVum (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 18 Oct 2021 17:50:42 -0400
Received: from devico.uberspace.de ([185.26.156.185]:44034 "EHLO
        devico.uberspace.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbhJRVul (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 18 Oct 2021 17:50:41 -0400
X-Greylist: delayed 401 seconds by postgrey-1.27 at vger.kernel.org; Mon, 18 Oct 2021 17:50:41 EDT
Received: (qmail 19145 invoked from network); 18 Oct 2021 21:41:36 -0000
Received: from localhost (HELO localhost) (127.0.0.1)
  by devico.uberspace.de with SMTP; 18 Oct 2021 21:41:36 -0000
From:   Leonard Lausen <leonard@lausen.nl>
To:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
Cc:     linux-wireless@vger.kernel.org
Subject: [5.15-rc4] mt76x0u warning at net/mac80211/airtime.c:456
 ieee80211_get_rate_duration.constprop.0+0xf4/0x1fc
Date:   Mon, 18 Oct 2021 21:41:11 +0000
Message-ID: <8735oyj9jc.fsf@lausen.nl>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

--=-=-=
Content-Type: text/plain

Dear Felix, Dear Lorenzo, Dear Maintainers,

please see attached dmesg excerpt for ALFA AWUS036ACHM mt76x0u warning
at net/mac80211/airtime.c:456. It occurred during night with little wifi
traffic. The adapter serves as AP. I've also observed the AP become
unresponsive upon heavy traffic a few hours later (though without any
kernel log messages) and requiring reboot to recover. If you have ideas
how to better debug the latter, please let me know.

Thank you
Leonard


--=-=-=
Content-Type: text/plain
Content-Disposition: inline; filename=dmesg_airtime_warning.txt

[23414.049292] ------------[ cut here ]------------
[23414.049314] WARNING: CPU: 0 PID: 1426 at net/mac80211/airtime.c:456 ieee80211_get_rate_duration.constprop.0+0xf4/0x1fc [mac80211]
[23414.049746] Modules linked in: cdc_ether aes_arm_bs crypto_simd cryptd ccm joydev mt76x0u mt76x0_common mt76x02_usb mt76_usb snd_usb_audio xt_MASQUERADE snd_hwdep mt76x02_lib snd_usbmidi_lib mt76 snd_rawmidi iptable_nat uvcvideo snd_seq_device nf_nat mac80211 libarc4 rpivid_mem vc4 bcm2835_codec(C) brcmfmac cec bcm2835_isp(C) v4l2_mem2mem brcmutil bcm2835_v4l2(C) drm_kms_helper bcm2835_mmal_vchiq(C) videobuf2_vmalloc videobuf2_dma_contig cfg80211 videobuf2_memops rfkill videobuf2_v4l2 snd_soc_core videobuf2_common snd_bcm2835(C) snd_compress snd_pcm_dmaengine vc_sm_cma(C) v3d videodev gpu_sched snd_pcm raspberrypi_hwmon mc snd_timer snd syscopyarea nvmem_rmem sysfillrect uio_pdrv_genirq sysimgblt fb_sys_fops uio ip6t_REJECT nf_reject_ipv6 xt_hl ip6_tables ip6t_rt ipt_REJECT nf_reject_ipv4 nft_limit xt_limit xt_addrtype xt_tcpudp xt_conntrack nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 nft_compat nft_counter nf_tables nfnetlink drm fuse drm_panel_orientation_quirks backlight
[23414.050822]  sha256_generic ip_tables x_tables ipv6
[23414.050888] CPU: 0 PID: 1426 Comm: kworker/u8:3 Tainted: G         C        5.15.0-rc4-v7l+ #1
[23414.050906] Hardware name: BCM2711
[23414.050917] Workqueue: mt76 mt76u_tx_status_data [mt76_usb]
[23414.050963] Backtrace: 
[23414.050976] [<c0bf0dcc>] (dump_backtrace) from [<c0bf1018>] (show_stack+0x20/0x24)
[23414.051019]  r7:000001c8 r6:00000000 r5:c10315e0 r4:60000013
[23414.051028] [<c0bf0ff8>] (show_stack) from [<c0bf58ec>] (dump_stack_lvl+0x70/0x94)
[23414.051056] [<c0bf587c>] (dump_stack_lvl) from [<c0bf5928>] (dump_stack+0x18/0x1c)
[23414.051086]  r7:000001c8 r6:00000009 r5:bf7c2fac r4:bf7d8fec
[23414.051094] [<c0bf5910>] (dump_stack) from [<c0221504>] (__warn+0xfc/0x158)
[23414.051121] [<c0221408>] (__warn) from [<c0bf173c>] (warn_slowpath_fmt+0x70/0xe4)
[23414.051147]  r7:bf7c2fac r6:000001c8 r5:bf7d8fec r4:00000000
[23414.051154] [<c0bf16d0>] (warn_slowpath_fmt) from [<bf7c2fac>] (ieee80211_get_rate_duration.constprop.0+0xf4/0x1fc [mac80211])
[23414.051548]  r8:00000000 r7:c5e6fe48 r6:c5e6fe40 r5:00000001 r4:00000000
[23414.051557] [<bf7c2eb8>] (ieee80211_get_rate_duration.constprop.0 [mac80211]) from [<bf7c31b8>] (ieee80211_calc_rx_airtime+0x104/0x14c [mac80211])
[23414.052273]  r5:00000001 r4:0000001c
[23414.052281] [<bf7c30b4>] (ieee80211_calc_rx_airtime [mac80211]) from [<bf7c32c4>] (ieee80211_calc_tx_airtime+0xc4/0xfc [mac80211])
[23414.053007]  r5:00000001 r4:00000000
[23414.053015] [<bf7c3200>] (ieee80211_calc_tx_airtime [mac80211]) from [<bf4a1718>] (mt76x02_send_tx_status+0x180/0x3ac [mt76x02_lib])
[23414.053456]  r10:00000001 r9:c3f91a04 r8:c2edd8a8 r7:c5e6fe40 r6:0000001c r5:00000002
[23414.053465]  r4:c3f92860
[23414.053473] [<bf4a1598>] (mt76x02_send_tx_status [mt76x02_lib]) from [<bf4a498c>] (mt76x02_tx_status_data+0x50/0x7c [mt76x02_lib])
[23414.053598]  r10:c1baed05 r9:00000100 r8:c3f92554 r7:c3f91894 r6:c5e6fedb r5:c3f91860
[23414.053607]  r4:00000001
[23414.053615] [<bf4a493c>] (mt76x02_tx_status_data [mt76x02_lib]) from [<bf3782bc>] (mt76u_tx_status_data+0x7c/0xe0 [mt76_usb])
[23414.053707]  r6:c3f93554 r5:c3f91860 r4:00000000
[23414.053715] [<bf378240>] (mt76u_tx_status_data [mt76_usb]) from [<c023fc54>] (process_one_work+0x224/0x554)
[23414.053762]  r8:00000000 r7:c1baed00 r6:c1806a00 r5:c5915400 r4:c3f93554
[23414.053770] [<c023fa30>] (process_one_work) from [<c023fff0>] (worker_thread+0x6c/0x5d0)
[23414.053797]  r10:c1806a00 r9:00000088 r8:c1403d00 r7:c1806a18 r6:c5915418 r5:c1806a00
[23414.053806]  r4:c5915400
[23414.053813] [<c023ff84>] (worker_thread) from [<c0248b58>] (kthread+0x158/0x174)
[23414.053839]  r10:c3d5cea0 r9:c60fde8c r8:c5e6e000 r7:c5915400 r6:c023ff84 r5:c3d5ce80
[23414.053847]  r4:c3d5c0c0
[23414.053855] [<c0248a00>] (kthread) from [<c02000d4>] (ret_from_fork+0x14/0x20)
[23414.053873] Exception stack(0xc5e6ffb0 to 0xc5e6fff8)
[23414.053885] ffa0:                                     ???????? ???????? ???????? ????????
[23414.053895] ffc0: ???????? ???????? ???????? ???????? ???????? ???????? ???????? ????????
[23414.053905] ffe0: ???????? ???????? ???????? ???????? ???????? ????????
[23414.053918]  r10:00000000 r9:00000000 r8:00000000 r7:00000000 r6:00000000 r5:c0248a00
[23414.053928]  r4:c3d5c0c0 r3:60000093
[23414.054035] ---[ end trace 6410ba82545406c6 ]---

--=-=-=--
