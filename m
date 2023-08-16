Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FA1C77E2A9
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Aug 2023 15:34:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245222AbjHPNeD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 16 Aug 2023 09:34:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245240AbjHPNdn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 16 Aug 2023 09:33:43 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E57BF2136
        for <linux-wireless@vger.kernel.org>; Wed, 16 Aug 2023 06:33:40 -0700 (PDT)
Received: from [192.168.179.2] ([91.47.218.225]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1M3mHT-1qX5zx1q0x-000qGe; Wed, 16 Aug 2023 15:33:34 +0200
Message-ID: <f5cc3eb9-815d-db28-bce4-eaeb626b701a@online.de>
Date:   Wed, 16 Aug 2023 15:33:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [RFC PATCH v2 6.1] wifi: cfg80211: fix cqm_config access race
Content-Language: en-US
From:   Max Schulze <max.schulze@online.de>
To:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
References: <20230815134247.4b4bd52ea708.I1a1bb102329fc88e4712eaf394cba3025ada0dc7@changeid>
 <20230815153741.cc51cb52a296.I1a1bb102329fc88e4712eaf394cba3025ada0dc7@changeid>
 <98456a69-d597-505c-6a1b-f33b5f6343e9@online.de>
In-Reply-To: <98456a69-d597-505c-6a1b-f33b5f6343e9@online.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:DROJfoMxPSN23OCzo/Nm+0bctxnXK5w2gz5PS0n+0L7seq2KHXQ
 exmoPTOX5kdCIrIbBtBkE0+9slYa4lQvzGldMNX1L2tjyHfOc7mlKtA3gn6IZCQtUu0wuUR
 u2mEF37paobIHODC3lSR6HHNGNOxyDUnkNsnHRE/66YrU44tQbrpYNAWuDZxQD/c1F/M2g3
 2zpg/T3Bxx75QEsoA3ZNQ==
UI-OutboundReport: notjunk:1;M01:P0:4UxB9duKsPg=;ctaRGyf4+n4MvLUlwEPbSgxk/HE
 asK9946CAIxGf6YsEENYdILpbL3UwjfimUTL66D8k6ogw2RL5yQWxb+5MgpgW4IxE1pRODPGP
 3iFeUvYxvEijN0uBgpBm+fMwa+ivEy93oQlTPhxIz0kBMC7kyY91GqknCLWITskjdmeZCa2+k
 fgfqHrXC2UZz2ekYAlrtjOq3hlwVnXMimpxsN7dxHXgeX1l9MbwNlp/2nv03sukOivhC7uJVN
 dcLSEkeiebnm2b/rQ4mLNpIIfTHMHmaGT/PABsGR8LfabLLoss+mEuM1MDxOI8hxeZIdjQtAF
 f0YXNhPxGJ5lFWsWG73Z+3b5OifO4r5BXCSEhbmuMs7T8M0pm9z1cnwt9v3Q+zgb+Yw3UFVn/
 KDdUhrrC+kUJ3Ud9M7rnz5q3lqvznaYB+mormamgTqC5PV795xYgQ4srb/4H6WdrRGLk50haj
 RsghKONSPGPaYkPBxCAXv9perDX2i2qNgM9+GdxwTCZSFjmxbXU7z3ABh+rTnlaV1Z/0QReVd
 Sc2hhKd5mufWmPQDl51golGFdjrL5gPlLWtD3nsFd6sONy4BbOeYntR5eo1zSqYMFmOvfb7Kl
 0gEwcPNmIq+lGtrEV8nUZh1QXJbdfpCpj0rJemtfGTX6Y4tLzSm1B/YuUoOACZMR+IEEfaxo8
 F6nlPW1BALc7fM3UDVJl9GwVFUYaOp7ukI4rDDot3xjty5Vb+C49HVbs+5K/ch5+s7kUlUpZe
 M1Y8Jk1VP0ucXw6TFAcGwdCJk956y49x87tXIe9m20VPUDJaYc9DwcuuxdoYTyFOJdPImOrDg
 xmeyxBJ32Ys5mzgnH0N9MNN8gVYnLKuAEFEYlCJ1aAKClO3RCKutKz+gWGzC8I7+yFy6qV9mr
 u4bgMmCFR5myEVQ==
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Look, this trace points to something in the worker structure/mm:

14:04:50 h63 wpa_supplicant[376]: wlan0: CTRL-EVENT-CONNECTED - Connection to xx:xx:xx:xx:c7:a8 completed [id=0 id_str=]

14:04:50 h63 kernel: brcmfmac: brcmf_wifi_prioritize_acparams ACI 0 aifsn 3 acm 0 ecwmin 4 ecwmax 10

14:04:50 h63 kernel: brcmfmac: brcmf_wifi_prioritize_acparams ACI 1 aifsn 7 acm 0 ecwmin 4 ecwmax 10

14:04:50 h63 kernel: brcmfmac: brcmf_wifi_prioritize_acparams ACI 2 aifsn 2 acm 0 ecwmin 3 ecwmax 4

14:04:50 h63 kernel: brcmfmac: brcmf_wifi_prioritize_acparams ACI 3 aifsn 2 acm 0 ecwmin 2 ecwmax 3

14:04:50 h63 kernel: brcmfmac: brcmf_wifi_prioritize_acparams Adj prio BE 0->1, BK 1->0, BK 2->0, BE 3->1

14:04:50 h63 kernel: brcmfmac: brcmf_wifi_prioritize_acparams Adj prio VI 4->2, VI 5->2, VO 6->3, VO 7->3

14:04:50 h63 kernel: brcmfmac: brcmf_get_assoc_ies req len (76) resp len (33)

14:04:50 h63 kernel: brcmfmac: brcmf_inform_single_bss bssid: xx:xx:xx:xx:c7:a8

14:04:50 h63 kernel: brcmfmac: brcmf_inform_single_bss Channel: 3(2422)

14:04:50 h63 kernel: brcmfmac: brcmf_inform_single_bss Capability: 431

14:04:50 h63 kernel: brcmfmac: brcmf_inform_single_bss Beacon interval: 100

14:04:50 h63 kernel: brcmfmac: brcmf_inform_single_bss Signal: -5400

14:04:50 h63 kernel: brcmfmac: brcmf_bss_connect_done Report connect result - connection succeeded

14:04:50 h63 kernel: brcmfmac: brcmf_cfg80211_get_station RSSI -54 dBm

14:04:50 h63 kernel: brcmfmac: brcmf_cfg80211_get_station RSSI -54 dBm

14:04:50 h63 wpa_supplicant[376]: wlan0: CTRL-EVENT-SUBNET-STATUS-UPDATE status=0

14:04:50 h63 NetworkManager[362]: <info>  [1692187490.4879] device (wlan0): supplicant interface state: associating -> completed

14:04:50 h63 kernel: brcmfmac: brcmf_cfg80211_get_station RSSI -54 dBm

14:04:50 h63 NetworkManager[362]: <info>  [1692187490.4907] device (p2p-dev-wlan0): supplicant management interface state: associating -> completed

14:04:50 h63 kernel: brcmfmac: brcmf_rx_event Enter: mmc1:0001:1: rxp=00000000f4393a20

14:04:50 h63 kernel: brcmfmac: brcmf_fweh_event_worker event RSSI (56) ifidx 0 bsscfg 0 addr 00:00:00:00:00:00

14:04:50 h63 kernel: brcmfmac: brcmf_fweh_event_worker   version 2 flags 0 status 0 reason 0

14:04:50 h63 kernel: brcmutil: event payload, len=12

14:04:50 h63 kernel: 00000000: ff ff ff ca 00 00 00 00 ff ff ff a5              ............

14:04:55 h63 kernel: brcmfmac: brcmf_cfg80211_get_station RSSI -47 dBm

14:04:59 h63 kernel: Unable to handle kernel NULL pointer dereference at virtual address 0000000000000070

14:04:59 h63 kernel: Mem abort info:

14:04:59 h63 kernel:   ESR = 0x0000000096000005

14:04:59 h63 kernel:   EC = 0x25: DABT (current EL), IL = 32 bits

14:04:59 h63 kernel:   SET = 0, FnV = 0

14:04:59 h63 kernel:   EA = 0, S1PTW = 0

14:04:59 h63 kernel:   FSC = 0x05: level 1 translation fault

14:04:59 h63 kernel: Data abort info:

14:04:59 h63 kernel:   ISV = 0, ISS = 0x00000005

14:04:59 h63 kernel:   CM = 0, WnR = 0

14:04:59 h63 kernel: user pgtable: 4k pages, 39-bit VAs, pgdp=00000000465b3000

14:04:59 h63 kernel: [0000000000000070] pgd=0000000000000000, p4d=0000000000000000, pud=0000000000000000

14:04:59 h63 kernel: Internal error: Oops: 0000000096000005 [#1] PREEMPT SMP

14:04:59 h63 kernel: Modules linked in: ov9281 rtc_pcf85063 regmap_i2c vc4 brcmfmac snd_soc_hdmi_codec brcmutil drm_display_helper cec drm_dma_helper v3d cfg80211 gpio_keys i2c_mux_pinctrl drm_kms_helper i2c_mux gpu_sched drm_shmem_helper bcm2835_unicam bcm2835_codec(C) rpivid_hevc(C) snd_soc_core v4l2_dv_timings raspberrypi_hwmon v4l2_fwnode bcm2835_v4l2(C) v4l2_async v4l2_mem2mem bcm2835_isp(C) bcm2835_mmal_vchiq(C) videobuf2_vmalloc i2c_brcmstb videobuf2_dma_contig snd_compress videobuf2_memops snd_bcm2835(C) videobuf2_v4l2 videobuf2_common binfmt_misc snd_pcm_dmaengine videodev snd_pcm rfkill snd_timer i2c_bcm2835 snd vc_sm_cma(C) mc syscopyarea sysfillrect sysimgblt fb_sys_fops nvmem_rmem uio_pdrv_genirq uio drm dm_mod fuse drm_panel_orientation_quirks backlight ip_tables x_tables ipv6

14:04:59 h63 kernel: CPU: 0 PID: 1184 Comm: kworker/0:0 Tainted: G         C         6.1.45-v8-gdc69f9d60872 #3

14:04:59 h63 kernel: Hardware name: Raspberry Pi Compute Module 4 Rev 1.0 (DT)

14:04:59 h63 kernel: pstate: 00000005 (nzcv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)

14:04:59 h63 kernel: pc : wq_worker_running+0x20/0x94

14:04:59 h63 kernel: lr : wq_worker_running+0x1c/0x94

14:04:59 h63 kernel: sp : ffffffc00a8c3dd0

14:04:59 h63 kernel: x29: ffffffc00a8c3dd0 x28: 0000000000000000 x27: 0000000000000000

14:04:59 h63 kernel: x26: ffffffdf40bfe498 x25: ffffffdf40a060f0 x24: ffffffdf409e6000

14:04:59 h63 kernel: x23: ffffffdf409e69c0 x22: ffffff807fb5dc28 x21: ffffff80445c9630

14:04:59 h63 kernel: x20: ffffff8045395d00 x19: 0000000000000000 x18: 0000000000000000

14:04:59 h63 kernel: x17: 0000000000000001 x16: 0000000000000001 x15: 00cddc74a125b114

14:04:59 h63 kernel: x14: 006cbf5eacfa360a x13: ffffffdf401fbc00 x12: 00000000fa83b2da

14:04:59 h63 kernel: x11: 00000000000003f3 x10: 0000000000001a90 x9 : ffffffdf3f6ae7ac

14:04:59 h63 kernel: x8 : ffffff80453977f0 x7 : 0000000000000001 x6 : 0000000000000000

14:04:59 h63 kernel: x5 : ffffffdf409ee000 x4 : ffffffdf409ee118 x3 : 0000000000000000

14:04:59 h63 kernel: x2 : 0000000000000001 x1 : 0000000004208060 x0 : 0000000000000000

14:04:59 h63 kernel: Call trace:

14:04:59 h63 kernel:  wq_worker_running+0x20/0x94

14:04:59 h63 kernel:  schedule+0x8c/0x100

14:04:59 h63 kernel:  worker_thread+0x1d0/0x450

14:04:59 h63 kernel:  kthread+0x104/0x110

14:04:59 h63 kernel:  ret_from_fork+0x10/0x20

14:04:59 h63 kernel: Code: 910003fd f9000bf3 940018bb aa0003f3 (b9407000)

14:04:59 h63 kernel: ---[ end trace 0000000000000000 ]---

14:04:59 h63 kernel: Unable to handle kernel paging request at virtual address fffffffffffffff8

14:04:59 h63 kernel: Mem abort info:

14:04:59 h63 kernel:   ESR = 0x0000000096000005

14:04:59 h63 kernel:   EC = 0x25: DABT (current EL), IL = 32 bits

14:05:00 h63 kernel:   SET = 0, FnV = 0

14:05:00 h63 kernel:   EA = 0, S1PTW = 0

14:05:00 h63 kernel:   FSC = 0x05: level 1 translation fault

14:05:00 h63 kernel: Data abort info:

14:05:00 h63 kernel:   ISV = 0, ISS = 0x00000005

14:05:00 h63 kernel:   CM = 0, WnR = 0

14:05:00 h63 kernel: swapper pgtable: 4k pages, 39-bit VAs, pgdp=00000000011d6000

14:05:00 h63 kernel: [fffffffffffffff8] pgd=0000000000000000, p4d=0000000000000000, pud=0000000000000000

14:05:00 h63 kernel: Internal error: Oops: 0000000096000005 [#2] PREEMPT SMP

14:05:00 h63 kernel: Modules linked in: ov9281 rtc_pcf85063 regmap_i2c vc4 brcmfmac snd_soc_hdmi_codec brcmutil drm_display_helper cec drm_dma_helper v3d cfg80211 gpio_keys i2c_mux_pinctrl drm_kms_helper i2c_mux gpu_sched drm_shmem_helper bcm2835_unicam bcm2835_codec(C) rpivid_hevc(C) snd_soc_core v4l2_dv_timings raspberrypi_hwmon v4l2_fwnode bcm2835_v4l2(C) v4l2_async v4l2_mem2mem bcm2835_isp(C) bcm2835_mmal_vchiq(C) videobuf2_vmalloc i2c_brcmstb videobuf2_dma_contig snd_compress videobuf2_memops snd_bcm2835(C) videobuf2_v4l2 videobuf2_common binfmt_misc snd_pcm_dmaengine videodev snd_pcm rfkill snd_timer i2c_bcm2835 snd vc_sm_cma(C) mc syscopyarea sysfillrect sysimgblt fb_sys_fops nvmem_rmem uio_pdrv_genirq uio drm dm_mod fuse drm_panel_orientation_quirks backlight ip_tables x_tables ipv6

14:05:00 h63 kernel: CPU: 0 PID: 1184 Comm: kworker/0:0 Tainted: G      D  C         6.1.45-v8-gdc69f9d60872 #3

14:05:00 h63 kernel: Hardware name: Raspberry Pi Compute Module 4 Rev 1.0 (DT)

14:05:00 h63 kernel: pstate: 000000c5 (nzcv daIF -PAN -UAO -TCO -DIT -SSBS BTYPE=--)

14:05:00 h63 kernel: pc : complete+0x58/0x94

14:05:00 h63 kernel: lr : complete+0x2c/0x94

14:05:00 h63 kernel: sp : ffffffc00a8c3930

14:05:00 h63 kernel: x29: ffffffc00a8c3930 x28: ffffffc00a8c3ac3 x27: ffffffdf40489dc0

14:05:00 h63 kernel: x26: ffffffdf40489db8 x25: 0000000000000001 x24: ffffffdf3f6ae7b4

14:05:00 h63 kernel: x23: 0000000000000000 x22: 000000000000000b x21: 0000000000000000

14:05:00 h63 kernel: x20: ffffff8040b55ac8 x19: 0000000000000000 x18: 0000000000000000

14:05:00 h63 kernel: x17: 3030303030303030 x16: 3030303030303020 x15: 0000000000000030

14:05:00 h63 kernel: x14: 0000000000000000 x13: 2d2d2d5d20303030 x12: 3030303030303030

14:05:00 h63 kernel: x11: fffffffffffecd58 x10: fffffffffffecd08 x9 : ffffffdf401bbb5c

14:05:00 h63 kernel: x8 : ffffffdf40a0c788 x7 : ffffffdf40a64788 x6 : 0000000000000000

14:05:00 h63 kernel: x5 : ffffffc00a8c4000 x4 : ffffffc00a8c0000 x3 : 0000000000000000

14:05:00 h63 kernel: x2 : 0000000000000001 x1 : 0000000000000000 x0 : ffffff8040b55ad0

14:05:00 h63 kernel: Call trace:

14:05:00 h63 kernel:  complete+0x58/0x94

14:05:00 h63 kernel:  mm_release+0x58/0xd0

14:05:00 h63 kernel:  exit_mm_release+0x30/0x40

14:05:00 h63 kernel:  do_exit+0x214/0x9d0

14:05:00 h63 kernel:  make_task_dead+0xa8/0x1b0

14:05:00 h63 kernel:  die+0x1dc/0x218

14:05:00 h63 kernel:  die_kernel_fault+0x280/0x338

14:05:00 h63 kernel:  __do_kernel_fault+0x14c/0x1f4

14:05:00 h63 kernel:  do_page_fault+0xd8/0x3f4

14:05:00 h63 kernel:  do_translation_fault+0xb4/0xdc

14:05:00 h63 kernel:  do_mem_abort+0x4c/0xa0

14:05:00 h63 kernel:  el1_abort+0x44/0x74

14:05:00 h63 kernel:  el1h_64_sync_handler+0xd8/0xe4

14:05:00 h63 kernel:  el1h_64_sync+0x64/0x68

14:05:00 h63 kernel:  wq_worker_running+0x20/0x94

14:05:00 h63 kernel:  schedule+0x8c/0x100

14:05:00 h63 kernel:  worker_thread+0x1d0/0x450

14:05:00 h63 kernel:  kthread+0x104/0x110

14:05:00 h63 kernel:  ret_from_fork+0x10/0x20

14:05:00 h63 kernel: Code: 91002280 eb00003f 54000120 f9400a73 (f85f8260)

14:05:00 h63 kernel: ---[ end trace 0000000000000000 ]---

14:05:00 h63 kernel: note: kworker/0:0[1184] exited with irqs disabled

14:05:00 h63 kernel: note: kworker/0:0[1184] exited with preempt_count 2

14:05:00 h63 kernel: Fixing recursive fault but reboot is needed!

14:05:04 h63 kernel: brcmfmac: brcmf_sdio_bus_rxctl: resumed on timeout

14:05:04 h63 kernel: brcmfmac: brcmf_sdio_readshared sdpcm_shared address 0x00206A70

14:05:04 h63 kernel: brcmfmac: brcmf_sdio_checkdied firmware not built with -assert

14:05:04 h63 kernel: ieee80211 phy0: brcmf_cfg80211_dump_station: BRCMF_C_GET_ASSOCLIST failed, err=-110

14:05:10 h63 kernel: brcmfmac: brcmf_sdio_bus_rxctl: resumed on timeout

14:05:10 h63 kernel: brcmfmac: brcmf_sdio_readshared sdpcm_shared address 0x00206A70

14:05:10 h63 kernel: brcmfmac: brcmf_sdio_checkdied firmware not built with -assert

14:05:10 h63 kernel: ieee80211 phy0: brcmf_cfg80211_dump_station: BRCMF_C_GET_ASSOCLIST failed, err=-110

14:05:16 h63 kernel: brcmfmac: brcmf_sdio_bus_rxctl: resumed on timeout

14:05:16 h63 kernel: brcmfmac: brcmf_sdio_readshared sdpcm_shared address 0x00206A70

14:05:16 h63 kernel: brcmfmac: brcmf_sdio_checkdied firmware not built with -assert

14:05:16 h63 kernel: ieee80211 phy0: brcmf_cfg80211_dump_station: BRCMF_C_GET_ASSOCLIST failed, err=-110

14:05:22 h63 kernel: brcmfmac: brcmf_sdio_bus_rxctl: resumed on timeout

14:05:22 h63 kernel: brcmfmac: brcmf_sdio_readshared sdpcm_shared address 0x00206A70

14:05:22 h63 kernel: brcmfmac: brcmf_sdio_checkdied firmware not built with -assert

14:05:22 h63 kernel: ieee80211 phy0: brcmf_cfg80211_dump_station: BRCMF_C_GET_ASSOCLIST failed, err=-110

14:05:28 h63 kernel: brcmfmac: brcmf_sdio_bus_rxctl: resumed on timeout

14:05:28 h63 kernel: brcmfmac: brcmf_sdio_readshared sdpcm_shared address 0x00206A70

14:05:28 h63 kernel: brcmfmac: brcmf_sdio_checkdied firmware not built with -assert

14:05:28 h63 kernel: ieee80211 phy0: brcmf_cfg80211_dump_station: BRCMF_C_GET_ASSOCLIST failed, err=-110

14:05:34 h63 kernel: brcmfmac: brcmf_sdio_bus_rxctl: resumed on timeout

14:05:34 h63 kernel: brcmfmac: brcmf_sdio_readshared sdpcm_shared address 0x00206A70

14:05:34 h63 kernel: brcmfmac: brcmf_sdio_checkdied firmware not built with -assert

14:05:34 h63 kernel: ieee80211 phy0: brcmf_cfg80211_dump_station: BRCMF_C_GET_ASSOCLIST failed, err=-110

14:05:40 h63 kernel: brcmfmac: brcmf_sdio_bus_rxctl: resumed on timeout

14:05:40 h63 kernel: brcmfmac: brcmf_sdio_readshared sdpcm_shared address 0x00206A70

14:05:40 h63 kernel: brcmfmac: brcmf_sdio_checkdied firmware not built with -assert

14:05:40 h63 kernel: ieee80211 phy0: brcmf_cfg80211_dump_station: BRCMF_C_GET_ASSOCLIST failed, err=-110

14:05:46 h63 kernel: brcmfmac: brcmf_sdio_bus_rxctl: resumed on timeout

14:05:46 h63 kernel: brcmfmac: brcmf_sdio_readshared sdpcm_shared address 0x00206A70

14:05:46 h63 kernel: brcmfmac: brcmf_sdio_checkdied firmware not built with -assert

14:05:46 h63 kernel: ieee80211 phy0: brcmf_cfg80211_dump_station: BRCMF_C_GET_ASSOCLIST failed, err=-110

14:05:52 h63 kernel: brcmfmac: brcmf_sdio_bus_rxctl: resumed on timeout

14:05:52 h63 kernel: brcmfmac: brcmf_sdio_readshared sdpcm_shared address 0x00206A70

14:05:52 h63 kernel: brcmfmac: brcmf_sdio_checkdied firmware not built with -assert

14:05:52 h63 kernel: ieee80211 phy0: brcmf_cfg80211_dump_station: BRCMF_C_GET_ASSOCLIST failed, err=-110

14:05:58 h63 kernel: brcmfmac: brcmf_sdio_bus_rxctl: resumed on timeout

14:05:58 h63 kernel: brcmfmac: brcmf_sdio_readshared sdpcm_shared address 0x00206A70

14:05:58 h63 kernel: brcmfmac: brcmf_sdio_checkdied firmware not built with -assert

14:05:58 h63 kernel: ieee80211 phy0: brcmf_cfg80211_dump_station: BRCMF_C_GET_ASSOCLIST failed, err=-110

14:06:04 h63 kernel: ieee80211 phy0: brcmf_proto_bcdc_query_dcmd: brcmf_proto_bcdc_msg failed w/status -110
