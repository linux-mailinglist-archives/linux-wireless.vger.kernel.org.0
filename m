Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1177B77621B
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Aug 2023 16:11:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233160AbjHIOL2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 9 Aug 2023 10:11:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233163AbjHIOL1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 9 Aug 2023 10:11:27 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 070E11FD8;
        Wed,  9 Aug 2023 07:11:25 -0700 (PDT)
Received: from [192.168.151.20] ([84.160.50.47]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MUGRh-1qKDUW0amp-00RG1U; Wed, 09 Aug 2023 16:11:07 +0200
Message-ID: <ac96309a-8d8d-4435-36e6-6d152eb31876@online.de>
Date:   Wed, 9 Aug 2023 16:11:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
Content-Language: en-US
To:     Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Kalle Valo <kvalo@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        SHA-cyfmac-dev-list@infineon.com, netdev@vger.kernel.org
From:   Max Schulze <max.schulze@online.de>
Subject: BCM43455: brcmf_notify_rssi / cfg80211_cqm_rssi_notify : Unable to
 handle kernel NULL pointer dereference
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:uSXs/MXnNaTK03B2n2PJe8JSbpO0UIJJ8+AgMWhwViXGfptymJ6
 r/rRvCQCB19Iv+nI7IxHy8HH0wBBUuYUnpFaLhpfokSkSG7+EGU/4KBQa1jZl7l2X3VuECC
 HMvgAQnGRfHWuHa+6Z8khyc7Z7++lYotif6/agiwrMrGNc/mRmYZcwduPcOK2xolsnrgSGD
 /4EGYUvUCx5bqqAB2oMEQ==
UI-OutboundReport: notjunk:1;M01:P0:MunnY7ohMK0=;I7cgtBGt6IO+MRL2tmsBTSZ/K8m
 iiT7L4udNfhhvO+sauSvOx2nweFtg3KI0t3ZIRmdbuUtdKRKtbk11hMNf1hkiiquZTXpwiODB
 h1TAapVlHTTgGgZwL9bvfdZ8+kUeMm1Nwy23Z6dvqDTPgMLCtsBmz825k+AEfCqAOHmp4rMYV
 6VntCh0okRIOMYwkWlPJ8FOrmx5iILgzYk/aspmjBT5aQyr92YCtyB6cqgA3Y1AAWlh8C2UgE
 RWGq8YZWySibv0jXujB2vGgxKDl66dCdX835XaQxLNQbFoDZ1+/f4xuT0cK99i9o2Dv38+rCD
 uqFr2tT+0GhglDkt3il+NGCOe8sRbh9x6Clqr5KkUaYgnuqnbzEQgg8z81gIDibGQ9RCsHzYl
 hxI/J5qk3ir3gLTTvr5RyaMVFbXOBq9oO86OrB5autCIQ3oMKo0QLTJfAT5GzS44pD4HijMHG
 XOd53XcqF4fqLZq9LThR6PQpSd6fvLyxPlD6Qyc1DNYVSwvZtxKt7hCAG0j4WmXLlqOBBEq+4
 5mXrsteABt9cGrFjVeRTr/JuDbBpP8CjtGct4yYvSAsPSz71rdmMptNll3nmv4i7VTUXnaWev
 JmmMiXUaeyoXY++TdczxgOAJKhznLzv5QVPW5IBbBzAOh136Ww39S/X2D9ZTY2pX1xEHaXkYD
 1Ib3sqpxhfIcpYpzF4ylKbZAdDTa1gkA+kZKk6fKoWJiYF8c+Q6G7wU9g1azXNPuTCxkoWJkU
 yfDGZS5DW9EITzAKSDNM7v/rDSENMUDOVdZcz4QeowQQqMqElhLI15rrgveGeeKwq+uCKboTQ
 goWNGOKirFQp6EFrYW/nYaoc7yhdDH6zvWry+h37hLTFh5w8hdFoi6RUK3kD+P2CF3X54KV3F
 T94HviB4ALyFdEQ==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello,

I have a recurring kernel crash with the wifi device driver on kernel 6.1.42 and 6.1.44 . Hardware is a raspberry pi cm4 on the original CM4IO Board. The wifi chip is soldered on. From the datasheet, the chip is a BCM43455/CYW43455.

This crash happens roughly every 60 hours on devices in the field, and I have observed it every ~30th reboot on my homelab.

It seems that it is related to disconnecting from a station right beforehand. Same on reboot, seems to be just after disconnection.

I am using wpa_supplicant and NetworkManager on userspace. Due to roaming problems, I am running the module with parameters

options brcmfmac p2pon=0 debug=50180 roamoff=1

I am attaching a crash from the field today, because it has some output after the kernel trace.

Thanks,
Max





Aug 09 11:28:33 pch8i: brcmfmac: brcmf_cfg80211_get_station RSSI -66 dBm
Aug 09 11:28:37 pch8i: brcmfmac: brcmf_rx_event Enter: mmc1:0001:1: rxp=0000000088524b81
Aug 09 11:28:37 pch8i: brcmfmac: brcmf_fweh_event_worker event RSSI (56) ifidx 0 bsscfg 0 addr 00:00:00:00:00:00
Aug 09 11:28:37 pch8i: brcmfmac: brcmf_fweh_event_worker   version 2 flags 0 status 0 reason 0
Aug 09 11:28:37 pch8i: brcmutil: event payload, len=12
Aug 09 11:28:37 pch8i: 00000000: ff ff ff b6 00 00 00 00 ff ff ff ab          ............
Aug 09 11:28:37 pch8i: brcmfmac: brcmf_notify_rssi LOW rssi=-74
Aug 09 11:28:37 pch8i: brcmfmac: brcmf_cfg80211_get_station RSSI -74 dBm
Aug 09 11:28:37 pch8i wpa_supplicant[391]: wlan0: CTRL-EVENT-SIGNAL-CHANGE above=0 signal=-74 noise=9999 txrate=24000
[...to show normal behaviour...]

Aug 09 11:28:57 pch8i: brcmfmac: brcmf_cfg80211_get_station RSSI -80 dBm
Aug 09 11:29:03 pch8i: brcmfmac: brcmf_cfg80211_get_station RSSI -81 dBm
Aug 09 11:29:07 pch8i wpa_supplicant[391]: wlan0: CTRL-EVENT-DISCONNECTED bssid=00:01:XX:XX:a1:70 reason=0 locally_generated=1
Aug 09 11:29:07 pch8i: brcmfmac: brcmf_rx_event Enter: mmc1:0001:1: rxp=00000000203d6aae
Aug 09 11:29:07 pch8i: brcmfmac: brcmf_rx_event Enter: mmc1:0001:1: rxp=00000000203d6aae
Aug 09 11:29:07 pch8i: brcmfmac: brcmf_fweh_event_worker event LINK (16) ifidx 0 bsscfg 0 addr 00:01:XX:XX:a1:70
Aug 09 11:29:07 pch8i: brcmfmac: brcmf_fweh_event_worker   version 2 flags 0 status 0 reason 1
Aug 09 11:29:07 pch8i: brcmutil: event payload, len=22
Aug 09 11:29:07 pch8i: 00000000: 30 14 01 00 00 0f ac 04 01 00 00 0f ac 04 01 00  0...............
Aug 09 11:29:07 pch8i: 00000010: 00 0f ac 02 00 00          ......
Aug 09 11:29:07 pch8i: brcmfmac: brcmf_is_linkdown Processing link down
Aug 09 11:29:07 pch8i: brcmfmac: brcmf_notify_connect_status Linkdown
Aug 09 11:29:07 pch8i: brcmfmac: brcmf_link_down Call WLC_DISASSOC to stop excess roaming
Aug 09 11:29:07 pch8i: brcmfmac: brcmf_rx_event Enter: mmc1:0001:1: rxp=00000000203d6aae
Aug 09 11:29:07 pch8i: brcmfmac: brcmf_btcoex_set_mode DHCP session ends
Aug 09 11:29:07 pch8i: brcmfmac: brcmf_fweh_event_worker event RSSI (56) ifidx 0 bsscfg 0 addr 00:00:00:00:00:00
Aug 09 11:29:07 pch8i: brcmfmac: brcmf_fweh_event_worker   version 2 flags 0 status 0 reason 0
Aug 09 11:29:07 pch8i: brcmutil: event payload, len=12
Aug 09 11:29:07 pch8i: 00000000: 00 00 00 00 00 00 00 00 00 00 00 00          ............
Aug 09 11:29:07 pch8i: brcmfmac: brcmf_notify_rssi LOW rssi=0
Aug 09 11:29:07 pch8i: brcmfmac: brcmf_cfg80211_del_key key index (0)
Aug 09 11:29:07 pch8i: brcmfmac: brcmf_cfg80211_del_key Ignore clearing of (never configured) key
Aug 09 11:29:07 pch8i: brcmfmac: brcmf_cfg80211_del_key key index (1)
Aug 09 11:29:07 pch8i: brcmfmac: brcmf_cfg80211_del_key Ignore clearing of (never configured) key
Aug 09 11:29:07 pch8i: brcmfmac: brcmf_cfg80211_del_key key index (2)
Aug 09 11:29:07 pch8i: brcmfmac: brcmf_cfg80211_del_key Ignore clearing of (never configured) key
Aug 09 11:29:07 pch8i: brcmfmac: brcmf_cfg80211_del_key key index (3)
Aug 09 11:29:07 pch8i: brcmfmac: brcmf_cfg80211_del_key Ignore clearing of (never configured) key
Aug 09 11:29:07 pch8i: brcmfmac: brcmf_cfg80211_del_key key index (4)
Aug 09 11:29:07 pch8i: brcmfmac: brcmf_cfg80211_del_key Ignore clearing of (never configured) key
Aug 09 11:29:07 pch8i: brcmfmac: brcmf_cfg80211_del_key key index (5)
Aug 09 11:29:07 pch8i: brcmfmac: brcmf_cfg80211_del_key Ignore clearing of (never configured) key
Aug 09 11:29:07 pch8i: ieee80211 phy0: brcmf_cfg80211_get_station: GET STA INFO failed, -52
Aug 09 11:29:07 pch8i: Unable to handle kernel NULL pointer dereference at virtual address 0000000000000004
Aug 09 11:29:07 pch8i: Mem abort info:
Aug 09 11:29:07 pch8i:   ESR = 0x0000000096000005
Aug 09 11:29:07 pch8i:   EC = 0x25: DABT (current EL), IL = 32 bits
Aug 09 11:29:07 pch8i:   SET = 0, FnV = 0
Aug 09 11:29:07 pch8i:   EA = 0, S1PTW = 0
Aug 09 11:29:07 pch8i:   FSC = 0x05: level 1 translation fault
Aug 09 11:29:07 pch8i: Data abort info:
Aug 09 11:29:07 pch8i:   ISV = 0, ISS = 0x00000005
Aug 09 11:29:07 pch8i:   CM = 0, WnR = 0
Aug 09 11:29:07 pch8i: user pgtable: 4k pages, 39-bit VAs, pgdp=00000000470bc000
Aug 09 11:29:07 pch8i: [0000000000000004] pgd=0000000000000000, p4d=0000000000000000, pud=0000000000000000
Aug 09 11:29:07 pch8i: Internal error: Oops: 0000000096000005 [#1] PREEMPT SMP
Aug 09 11:29:07 pch8i: Modules linked in: ov9281 rtc_pcf85063 regmap_i2c brcmfmac brcmutil cfg80211 vc4 v3d gpu_sched gpio_keys rfkill drm_shmem_helper i2c_mux_pinctrl snd_soc_hdmi_codec i2c_mux raspberrypi_hwmon i2c_brcmstb drm_display_helper bcm2835_codec(C) bcm2835_v4l2(C) bcm2835_isp(C) snd_bcm2835(C) cec bcm2835_mmal_vchiq(C) drm_dma_helper bcm2835_unicam drm_kms_helper v4l2_dv_timings v4l2_fwnode v4l2_async rpivid_hevc(C) v4l2_mem2mem snd_soc_core videobuf2_vmalloc videobuf2_dma_contig i2c_bcm2835 videobuf2_memops videobuf2_v4l2 snd_compress videobuf2_common snd_pcm_dmaengine snd_pcm videodev snd_timer vc_sm_cma(C) snd syscopyarea mc sysfillrect sysimgblt uio_pdrv_genirq fb_sys_fops nvmem_rmem uio drm fuse drm_panel_orientation_quirks backlight ip_tables x_tables ipv6
Aug 09 11:29:08 pch8i: CPU: 0 PID: 1792 Comm: kworker/0:0 Tainted: G     C         6.1.42-v8+ #1
Aug 09 11:29:08 pch8i: Hardware name: Raspberry Pi Compute Module 4 Rev 1.0 (DT)
Aug 09 11:29:08 pch8i: Workqueue: events brcmf_fweh_event_worker [brcmfmac]
Aug 09 11:29:08 pch8i: pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
Aug 09 11:29:08 pch8i: pc : cfg80211_cqm_rssi_notify+0x78/0x1b0 [cfg80211]
Aug 09 11:29:08 pch8i: lr : cfg80211_cqm_rssi_notify+0x70/0x1b0 [cfg80211]
Aug 09 11:29:08 pch8i: sp : ffffffc00c37bc40
Aug 09 11:29:08 pch8i: x29: ffffffc00c37bc40 x28: ffffff8001e2ddd0 x27: ffffff8001e2dd80
Aug 09 11:29:08 pch8i: x26: ffffff80437b4a48 x25: dead000000000100 x24: ffffff80437b43a0
Aug 09 11:29:08 pch8i: x23: ffffff80434f6008 x22: 0000000000000cc0 x21: 0000000000000000
Aug 09 11:29:08 pch8i: x20: 0000000000000000 x19: ffffff8040890000 x18: ffffffffffffffff
Aug 09 11:29:08 pch8i: x17: 2c64656c69616620 x16: 4f464e4920415453 x15: 20544547203a6e6f
Aug 09 11:29:08 pch8i: x14: 69746174735f7465 x13: 32352d202c64656c x12: 696166204f464e49
Aug 09 11:29:08 pch8i: x11: 2041545320544547 x10: ffffffec638568a0 x9 : ffffffec16093000
Aug 09 11:29:08 pch8i: x8 : ffffff8042de3e00 x7 : 0000000000000000 x6 : ffffffc00c37b8c8
Aug 09 11:29:08 pch8i: x5 : ffffffc00c37b8f0 x4 : 00000000ffffffd8 x3 : 000000000000c404
Aug 09 11:29:08 pch8i: x2 : 0000000000000000 x1 : 0000000000000000 x0 : 0000000000000000
Aug 09 11:29:08 pch8i: Call trace:
Aug 09 11:29:08 pch8i:  cfg80211_cqm_rssi_notify+0x78/0x1b0 [cfg80211]
Aug 09 11:29:08 pch8i:  brcmf_notify_rssi+0x10c/0x1b0 [brcmfmac]
Aug 09 11:29:08 pch8i:  brcmf_fweh_call_event_handler+0x40/0xa0 [brcmfmac]
Aug 09 11:29:08 pch8i:  brcmf_fweh_event_worker+0x1e4/0x4f0 [brcmfmac]
Aug 09 11:29:08 pch8i:  process_one_work+0x1dc/0x450
Aug 09 11:29:08 pch8i:  worker_thread+0x154/0x450
Aug 09 11:29:08 pch8i:  kthread+0x104/0x110
Aug 09 11:29:08 pch8i:  ret_from_fork+0x10/0x20
Aug 09 11:29:08 pch8i: Code: d10e8300 97fffee9 35000074 f941bae0 (b9400414)
Aug 09 11:29:08 pch8i: ---[ end trace 0000000000000000 ]---
Aug 09 11:29:10 pch8i: brcmfmac: brcmf_sdio_bus_rxctl: resumed on timeout
Aug 09 11:29:10 pch8i: brcmfmac: brcmf_sdio_readshared sdpcm_shared address 0x00206A70
Aug 09 11:29:10 pch8i: brcmfmac: brcmf_sdio_checkdied firmware not built with -assert
Aug 09 11:29:10 pch8i: ieee80211 phy0: brcmf_cfg80211_reg_notifier: Country code iovar returned err = -110
Aug 09 11:29:12 pch8i: brcmfmac: brcmf_sdio_bus_rxctl: resumed on timeout
Aug 09 11:29:12 pch8i: brcmfmac: brcmf_sdio_readshared sdpcm_shared address 0x00206A70
Aug 09 11:29:12 pch8i: brcmfmac: brcmf_sdio_checkdied firmware not built with -assert
Aug 09 11:29:15 pch8i: brcmfmac: brcmf_sdio_bus_rxctl: resumed on timeout
Aug 09 11:29:15 pch8i: brcmfmac: brcmf_sdio_readshared sdpcm_shared address 0x00206A70
Aug 09 11:29:15 pch8i: brcmfmac: brcmf_sdio_checkdied firmware not built with -assert
Aug 09 11:29:15 pch8i: ieee80211 phy0: brcmf_cfg80211_reg_notifier: Country code iovar returned err = -110
Aug 09 11:29:18 pch8i wpa_supplicant[391]: wlan0: CTRL-EVENT-REGDOM-CHANGE init=CORE type=WORLD
Aug 09 11:29:18 pch8i wpa_supplicant[391]: wlan0: CTRL-EVENT-REGDOM-CHANGE init=USER type=COUNTRY alpha2=DE
Aug 09 11:29:18 pch8i: brcmfmac: brcmf_sdio_bus_rxctl: resumed on timeout
Aug 09 11:29:18 pch8i: brcmfmac: brcmf_sdio_readshared sdpcm_shared address 0x00206A70
Aug 09 11:29:18 pch8i: brcmfmac: brcmf_sdio_checkdied firmware not built with -assert
Aug 09 11:29:18 pch8i: ieee80211 phy0: brcmf_cfg80211_get_tx_power: error (-110)
Aug 09 11:29:20 pch8i NetworkManager[347]: <info>  [1691573360.5820] device (wlan0): supplicant interface state: completed -> disconnected
Aug 09 11:29:20 pch8i NetworkManager[347]: <info>  [1691573360.5822] device (p2p-dev-wlan0): supplicant management interface state: completed -> disconnected
Aug 09 11:29:20 pch8i: brcmfmac: brcmf_sdio_bus_rxctl: resumed on timeout
Aug 09 11:29:20 pch8i: brcmfmac: brcmf_sdio_readshared sdpcm_shared address 0x00206A70
Aug 09 11:29:20 pch8i: brcmfmac: brcmf_sdio_checkdied firmware not built with -assert
Aug 09 11:29:20 pch8i: ieee80211 phy0: brcmf_cfg80211_dump_station: BRCMF_C_GET_ASSOCLIST failed, err=-110
Aug 09 11:29:20 pch8i: brcmfmac: brcmf_cfg80211_scan START ESCAN
Aug 09 11:29:23 pch8i wpa_supplicant[391]: wlan0: CTRL-EVENT-SCAN-FAILED ret=-110 retry=1
Aug 09 11:29:23 pch8i: brcmfmac: brcmf_sdio_bus_rxctl: resumed on timeout
Aug 09 11:29:23 pch8i: brcmfmac: brcmf_sdio_readshared sdpcm_shared address 0x00206A70
Aug 09 11:29:23 pch8i: brcmfmac: brcmf_sdio_checkdied firmware not built with -assert
Aug 09 11:29:23 pch8i: ieee80211 phy0: brcmf_vif_set_mgmt_ie: vndr ie set error : -110
Aug 09 11:29:23 pch8i: ieee80211 phy0: brcmf_cfg80211_scan: scan error (-110)
Aug 09 11:29:24 pch8i: brcmfmac: brcmf_cfg80211_scan START ESCAN
Aug 09 11:29:24 pch8i: brcmfmac: brcmf_do_escan Enter

