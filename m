Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE07E77DB11
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Aug 2023 09:23:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242381AbjHPHXW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 16 Aug 2023 03:23:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242430AbjHPHXP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 16 Aug 2023 03:23:15 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BF1BC1
        for <linux-wireless@vger.kernel.org>; Wed, 16 Aug 2023 00:23:13 -0700 (PDT)
Received: from [192.168.179.5] ([91.47.193.150]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1M9nEJ-1qQw4U00bV-005sBy; Wed, 16 Aug 2023 09:23:07 +0200
Message-ID: <98456a69-d597-505c-6a1b-f33b5f6343e9@online.de>
Date:   Wed, 16 Aug 2023 09:23:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [RFC PATCH v2 6.1] wifi: cfg80211: fix cqm_config access race
Content-Language: en-US
To:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
References: <20230815134247.4b4bd52ea708.I1a1bb102329fc88e4712eaf394cba3025ada0dc7@changeid>
 <20230815153741.cc51cb52a296.I1a1bb102329fc88e4712eaf394cba3025ada0dc7@changeid>
From:   Max Schulze <max.schulze@online.de>
In-Reply-To: <20230815153741.cc51cb52a296.I1a1bb102329fc88e4712eaf394cba3025ada0dc7@changeid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:nGLeEd0RvgcQj0q5Pf+wC3yfIk2n2yErRc0CjtMWOXGYVKt/CpI
 xxWBHaiG24XOEAoSdAn3O6f0JbLLr2glNCwRFmwx4ZnAwb4zkcMOgFrwuerW+HGQ7LcpEyA
 p4AhBmptXU6TnoT5x+EHXZYz0HBA9EHfkSKljHfo7iqWqWkv4OlYzsGL/wEGRP+dq6h8KL5
 YfV8skqEZhW3lP+v5ZjtQ==
UI-OutboundReport: notjunk:1;M01:P0:TIpu8NeBg+I=;+dM9L1Ejlih5s5NJZ4+y0Knc0ey
 DQGyJmTaRwDls+ooEjKULvEFdoMlH7SykV5ZJMl3vx9ml8K1IHueIzjvRe2L6iUT1kNxRoCVu
 SezWuLErzGwhO3+Jg0sisKCgqiKJd+iC8ihuYN6iBE2RPl6Hit/O3c0BvP9Cmf9O05OsmrJgJ
 aFYyEmIZdTW0VmVAC02GbqCcuUFMEwFUto8vGmGis+iIvkc4OlIZ0xroe3x7aoiOXQrG3zDlx
 fhl7BqY4zr6iE63KiYlnEUHZ8PRlMBzQznsExiS9Kz1/ia6rJISbwJy50DbmBnc5tQerCK32o
 lMAHjxYzmrwYQnVw7dZkwWocSDJH99cE9Le1ITiTaXLc6gD4dzKQ2SbsrNzptd0iHIK/Gho7t
 zdKlI2KdL1A28YXOH90tDw9CP0P2Y1N88IwNrWDvvAJrTtR2dzDdfwX6UP3usujtU4D9WElWy
 DsPuaRYUB79iJFQB6hR2ZyA3N7wKm2V9kpvJOLXwEOfh6IVXFms+eQqxekmFGA93Vn4876EYW
 ZI1bhE4yUgp/bcno1GbZkHhgjge1v1UAtfbCbpCYJzaAmNd0ye87BdtTqp8qOzfO/wd67Aili
 YB8h5xBYikQietklu9x9vJzc6iys09BlMFZ/NW4QATJmXiOb3Q2bcoHodLQzZUVfv6jGl4eHW
 /B/BMb2LG3JnUFHGD1df0+WnhnYQjpK7XGvKEHWJwM2HNpPNJ17Vm03iPucC58D7ibkzlkRty
 gFG/Ed9sp9khMS5Y0iY11SXlutKiagFOZLw8o4C0HxnBnCTa9DA7eH5icOmzXh3B6O+G8Adob
 +koyuoFUMejVZmNWqVnRdAJlZig/ozgH/+wdY6jgTlE/0LeOJ+UC+u6oLJVskmdLoBEWs02ei
 nUJoHJCfzSlB6rw==
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Johannes, thank you very much.

However, bad luck again, I get the following crash. Scouring the logs, this time I have no "rcu notice" or any other error beforehand.

But the timing again suggest a strong connection with RSSI update in progress.


h63 wpa_supplicant[433]: wlan0: CTRL-EVENT-CONNECTED - Connection to xx:xx:xx:xx:00:91 completed [id=0 id_str=]
h63 kernel: brcmfmac: brcmf_cfg80211_get_station RSSI -57 dBm
h63 kernel: brcmfmac: brcmf_cfg80211_get_station RSSI -57 dBm
h63 wpa_supplicant[433]: wlan0: CTRL-EVENT-SUBNET-STATUS-UPDATE status=0
h63 NetworkManager[429]: <info>  [1692169608.6737] device (wlan0): supplicant interface state: associating -> completed
h63 NetworkManager[429]: <info>  [1692169608.6764] device (p2p-dev-wlan0): supplicant management interface state: associating -> completed
h63 kernel: brcmfmac: brcmf_cfg80211_get_station RSSI -57 dBm
h63 kernel: brcmfmac: brcmf_rx_event Enter: mmc1:0001:1: rxp=00000000414022d6
h63 kernel: brcmfmac: brcmf_fweh_event_worker event RSSI (56) ifidx 0 bsscfg 0 addr 00:00:00:00:00:00
h63 kernel: brcmfmac: brcmf_fweh_event_worker   version 2 flags 0 status 0 reason 0
h63 kernel: brcmutil: event payload, len=12
h63 kernel: 00000000: ff ff ff c6 00 00 00 00 ff ff ff a5 ............
h63 kernel: brcmfmac: brcmf_netdev_start_xmit wlan0: insufficient headroom (0)
h63 kernel: Unable to handle kernel paging request at virtual address ffff8061d9850028
h63 kernel: Mem abort info:
h63 kernel:   ESR = 0x0000000096000004
h63 kernel:   EC = 0x25: DABT (current EL), IL = 32 bits
h63 kernel:   SET = 0, FnV = 0
h63 kernel:   EA = 0, S1PTW = 0
h63 kernel:   FSC = 0x04: level 0 translation fault
h63 kernel: Data abort info:
h63 kernel:   ISV = 0, ISS = 0x00000004
h63 kernel:   CM = 0, WnR = 0
h63 kernel: [ffff8061d9850028] address between user and kernel address ranges
h63 kernel: Internal error: Oops: 0000000096000004 [#1] PREEMPT SMP
h63 kernel: Modules linked in: rtc_pcf85063 regmap_i2c ov9281 v3d brcmfmac vc4 gpu_sched raspberrypi_hwmon drm_shmem_helper binfmt_misc brcmutil gpio_keys snd_soc_hdmi_codec i2c_mux_pinctrl>
h63 kernel: CPU: 3 PID: 493 Comm: Xorg Tainted: G         C 6.1.45-v8-gdc69f9d60872 #3
h63 kernel: Hardware name: Raspberry Pi Compute Module 4 Rev 1.0 (DT)
h63 kernel: pstate: 80000005 (Nzcv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
h63 kernel: pc : dma_resv_add_fence+0x80/0x260
h63 kernel: lr : v3d_attach_fences_and_unlock_reservation+0x6c/0x1c0 [v3d]
h63 kernel: sp : ffffffc0093abb00
h63 kernel: x29: ffffffc0093abb00 x28: 0000000000000048 x27: ffffffc0093abd38
h63 kernel: x26: 0000000000000001 x25: ffffff80481e8e00 x24: ffffffc0093abc08
h63 kernel: x23: 0000000000000001 x22: ffffff805701ac40 x21: ffffffc0093abc20
h63 kernel: x20: ffffff804b995200 x19: ffff8061d9850000 x18: 0000000000000000
h63 kernel: x17: 0000000000000000 x16: ffffffdcdd1b9ba0 x15: 00000055b7e860c0
h63 kernel: x14: 0000000000000000 x13: 0000000000000202 x12: 0000000000000202
h63 kernel: x11: 0000000000000202 x10: 0000000000001a90 x9 : ffffffdc7c7bdecc
h63 kernel: x8 : 0000000000000228 x7 : ffffff804416caa8 x6 : 0000000000000000
h63 kernel: x5 : ffffff805701ac40 x4 : ffffff805701ac78 x3 : 0000000000000000
h63 kernel: x2 : ffffffdc7c685478 x1 : ffffffdcdd680ce8 x0 : ffffffdcdd680d30
h63 kernel: Call trace:
h63 kernel:  dma_resv_add_fence+0x80/0x260
h63 kernel:  v3d_attach_fences_and_unlock_reservation+0x6c/0x1c0 [v3d]
h63 kernel:  v3d_submit_cl_ioctl+0x540/0x70c [v3d]
h63 kernel:  drm_ioctl_kernel+0xcc/0x180 [drm]
h63 kernel:  drm_ioctl+0x210/0x440 [drm]
h63 kernel:  __arm64_sys_ioctl+0xb0/0xf4
h63 kernel:  invoke_syscall+0x50/0x120
h63 kernel:  el0_svc_common.constprop.0+0x68/0x124
h63 kernel:  do_el0_svc+0x34/0xd0
h63 kernel:  el0_svc+0x30/0x94
h63 kernel:  el0t_64_sync_handler+0xb8/0xbc
h63 kernel:  el0t_64_sync+0x18c/0x190
h63 kernel: Code: fa401044 54000061 d4210000 d503201f (f9401678)
h63 kernel: ---[ end trace 0000000000000000 ]---
