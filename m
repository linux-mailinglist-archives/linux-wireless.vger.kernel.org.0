Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F58F77E233
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Aug 2023 15:09:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245382AbjHPNJV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 16 Aug 2023 09:09:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235607AbjHPNIr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 16 Aug 2023 09:08:47 -0400
X-Greylist: delayed 85470 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 16 Aug 2023 06:08:45 PDT
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9600E26BA
        for <linux-wireless@vger.kernel.org>; Wed, 16 Aug 2023 06:08:45 -0700 (PDT)
Received: from [192.168.179.2] ([91.47.218.225]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1M1HqM-1qUbJ042H4-002svR; Wed, 16 Aug 2023 15:08:36 +0200
Message-ID: <96883c2f-0584-3bbf-39cc-ab50c5f1be88@online.de>
Date:   Wed, 16 Aug 2023 15:08:36 +0200
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
X-Provags-ID: V03:K1:tdfT0EdVrcXOF5vxBjaUSjWPhHlaT35twUNLRYk1U/znXG8+VIw
 HJUPEgiDrlVlMRJvMdAbDuoGTKtWTAD06t2w1boe2TzWlqkxjlcyXcGlBLMwRs+7Pu8/VRw
 LywGtYUEpt93SXg5eav684hdaCsA8lubLCHcYIB+biODlheO+FOQJWUbPyPERyxvtgXMZYO
 9eyiv4D5IXOPdMvZHGmcg==
UI-OutboundReport: notjunk:1;M01:P0:MqiSkHb6e4Q=;ktl2FF7J5d/3fT6GMcn0CQnMr4V
 J/zm3QkZYbm7aRpHa2xctiQ95y1av/rqGx9fPaJb0ndSrrlGQKoSXNbl0PYiB+MmJS09/4WSU
 MgwY0vsEYcCz2W4vDfu7GC5v/8528F09APcWXrqWCLQGoX1L/a/Z0vn1/tRmSE2sm3qM2dswN
 +2uhpgeuylSbDHD64C8hfhu29kYROGlH0IdMwzQ6b5MiyD7P4IRvVkZWTZiXkmM9YxnsZwQU9
 mRsTGVUIo3VnLK8Uq54btJhl7NzetE6qSWqYBmNqbDuDz5uYKqyStcnnQl3G6jrvmJ7NLohjb
 y/3+v9KN6AIrHGX7BleqQDQWRrSq6Fize7ORGojYhofOA69q6LhZa+mMpcjavaHsUY+kAD9Wu
 I2Z+NtyB1M4+HJ62O2sB83vCppFwMeqK6VrTM3IrRRjnyvltqP3oxxDJTMqVOmu53bhBckz43
 SprIY2v6W/yDnNjxniobFs/ffFYBrK4x6fGhz16BGnMDr6U8oqxJKdLd7oA75Y363ZhDk5nrc
 +y+8yb3jYMGH4xuC8sOxc94Ii5WYcOj7ysdTfEor68plHr8GdmVYOHqb+AbXjFxTwbabEW6ys
 m1IumxRBJ3poy72oF1CcZ6ZECu6o95ZiPwk6AFWi426pbyMiSUk1/6OfGU4NmIYcIchxPhBVI
 h4rxW9ux2+rPdg6nQC/TOyxQ5VosYjXuQuTGjg7ShhexRV4B5w6n42j/PMAn26MHsNal+bXZ1
 DoboAGHrtwtoG3PDf5jxMbnWP/2QRnTnLQBaIifBT0/732991hBjvbb6iGwWWOwAbyoEilmiP
 uHbfx1utA68fxZ/melFp6j64zmv9vTQI5Fca98TiKcpjLh1f5m94IicNE6Ci7KRa13Eal5xjX
 g1B6vGeP/8WteGoi72FsM7c+XX4b0pxw7X/w=
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Trace from the system I couldn't reach.

Looks similar to the first.

There must be something at odds with the patch.

Aug 16 09:27:03 h91 wpa_supplicant[367]: wlan0: Associated with 
xx:xx:xx:xx:a1:80
Aug 16 09:27:03 h91 wpa_supplicant[367]: wlan0: CTRL-EVENT-CONNECTED - 
Connection to xx:xx:xx:xx:a1:80 completed [id=0 id_str=]
Aug 16 09:27:03 h91 kernel: brcmfmac: brcmf_cfg80211_get_station RSSI 
-54 dBm
Aug 16 09:27:03 h91 kernel: brcmfmac: brcmf_setup_wiphybands nmode=1, 
vhtmode=1, bw_cap=(3, 7)
Aug 16 09:27:03 h91 kernel: brcmfmac: brcmf_setup_wiphybands nchain=1
Aug 16 09:27:03 h91 kernel: brcmfmac: brcmf_cfg80211_get_station RSSI 
-54 dBm
Aug 16 09:27:03 h91 wpa_supplicant[367]: wlan0: 
CTRL-EVENT-SUBNET-STATUS-UPDATE status=0
Aug 16 09:27:03 h91 wpa_supplicant[367]: wlan0: CTRL-EVENT-REGDOM-CHANGE 
init=COUNTRY_IE type=COUNTRY alpha2=US
Aug 16 09:27:03 h91 NetworkManager[342]: <info>  [1692170823.3861] 
device (wlan0): supplicant interface state: associating -> completed
Aug 16 09:27:03 h91 NetworkManager[342]: <info>  [1692170823.3862] 
device (p2p-dev-wlan0): supplicant management interface state: 
associating -> completed
Aug 16 09:27:03 h91 kernel: brcmfmac: brcmf_rx_event Enter: mmc1:0001:1: 
rxp=000000007fc0b9df
Aug 16 09:27:03 h91 kernel: brcmfmac: brcmf_fweh_event_worker event RSSI 
(56) ifidx 0 bsscfg 0 addr 00:00:00:00:00:00
Aug 16 09:27:03 h91 kernel: brcmfmac: brcmf_fweh_event_worker   version 
2 flags 0 status 0 reason 0
Aug 16 09:27:03 h91 kernel: brcmutil: event payload, len=12
Aug 16 09:27:03 h91 kernel: 00000000: ff ff ff ca 00 00 00 00 ff ff ff 
a5              ............
Aug 16 09:27:04 h91 kernel: brcmfmac: brcmf_cfg80211_get_station RSSI 
-57 dBm
Aug 16 09:27:05 h91 kernel: Unable to handle kernel NULL pointer 
dereference at virtual address 00000000000000cf
Aug 16 09:27:05 h91 kernel: Mem abort info:
Aug 16 09:27:05 h91 kernel:   ESR = 0x0000000096000005
Aug 16 09:27:05 h91 kernel:   EC = 0x25: DABT (current EL), IL = 32 bits
Aug 16 09:27:05 h91 kernel:   SET = 0, FnV = 0
Aug 16 09:27:05 h91 kernel:   EA = 0, S1PTW = 0
Aug 16 09:27:05 h91 kernel:   FSC = 0x05: level 1 translation fault
Aug 16 09:27:05 h91 kernel: Data abort info:
Aug 16 09:27:05 h91 kernel:   ISV = 0, ISS = 0x00000005
Aug 16 09:27:05 h91 kernel:   CM = 0, WnR = 0
Aug 16 09:27:05 h91 kernel: user pgtable: 4k pages, 39-bit VAs, 
pgdp=000000004b56b000
Aug 16 09:27:05 h91 kernel: [00000000000000cf] pgd=0000000000000000, 
p4d=0000000000000000, pud=0000000000000000
Aug 16 09:27:05 h91 kernel: Internal error: Oops: 0000000096000005 [#1] 
PREEMPT SMP
Aug 16 09:27:05 h91 kernel: Modules linked in: ov9281 rtc_pcf85063 
regmap_i2c vc4 snd_soc_hdmi_codec drm_display_helper cec drm_dma_helper 
v3d brcmfmac drm_kms_helper gpu_sched drm_shmem_helper brcmutil g>
Aug 16 09:27:05 h91 kernel: CPU: 3 PID: 488 Comm: Xorg Tainted: G 
 C         6.1.45-v8-gdc69f9d60872 #3
Aug 16 09:27:05 h91 kernel: Hardware name: Raspberry Pi Compute Module 4 
Rev 1.0 (DT)
Aug 16 09:27:05 h91 kernel: pstate: 80000005 (Nzcv daif -PAN -UAO -TCO 
-DIT -SSBS BTYPE=--)
Aug 16 09:27:05 h91 kernel: pc : drm_ioctl+0x284/0x440 [drm]
Aug 16 09:27:05 h91 kernel: lr : drm_ioctl+0xac/0x440 [drm]
Aug 16 09:27:05 h91 kernel: sp : ffffffc00933bca0
Aug 16 09:27:05 h91 kernel: x29: ffffffc00933bcb0 x28: ffffff8044acdd00 
x27: 0000000000000000
Aug 16 09:27:05 h91 kernel: x26: 0000000000000000 x25: ffffff804376a800 
x24: 0000000000000041
Aug 16 09:27:05 h91 kernel: x23: ffffff804e849200 x22: 00000000c0106441 
x21: 0000007ffd46ebf8
Aug 16 09:27:05 h91 kernel: x20: ffffff8040a4e000 x19: 0000000000000001 
x18: 0000000000000000
Aug 16 09:27:05 h91 kernel: x17: 0000000000000000 x16: ffffffea06d1a2d0 
x15: 0000000000000000
Aug 16 09:27:05 h91 kernel: x14: 0000000000000000 x13: 0000000000000000 
x12: 0000000000000000
Aug 16 09:27:05 h91 kernel: x11: 0000000000000000 x10: 0000000000000000 
x9 : ffffffe9a6773ed0
Aug 16 09:27:05 h91 kernel: x8 : 0000000000000000 x7 : 0000000000000000 
x6 : 000000000005e9e5
Aug 16 09:27:05 h91 kernel: x5 : 000000000005e9e5 x4 : 0000000000000000 
x3 : 0000000000000001
Aug 16 09:27:05 h91 kernel: x2 : ffffff8044acdd00 x1 : ffffff9677ec2000 
x0 : 0000000000000007
Aug 16 09:27:05 h91 kernel: Call trace:
Aug 16 09:27:05 h91 kernel:  drm_ioctl+0x284/0x440 [drm]
Aug 16 09:27:05 h91 kernel:  __arm64_sys_ioctl+0xb0/0xf4
Aug 16 09:27:05 h91 kernel:  invoke_syscall+0x50/0x120
Aug 16 09:27:05 h91 kernel:  el0_svc_common.constprop.0+0x68/0x124
Aug 16 09:27:05 h91 kernel:  do_el0_svc+0x34/0xd0
Aug 16 09:27:05 h91 kernel:  el0_svc+0x30/0x94
Aug 16 09:27:05 h91 kernel:  el0t_64_sync_handler+0xb8/0xbc
Aug 16 09:27:05 h91 kernel:  el0t_64_sync+0x18c/0x190
Aug 16 09:27:05 h91 kernel: Code: 35000455 a94673fb 17ffff7b f9401a80 
(b940c800)
Aug 16 09:27:05 h91 kernel: ---[ end trace 0000000000000000 ]---
Aug 16 09:27:10 h91 kernel: brcmfmac: brcmf_cfg80211_get_station RSSI 
-58 dBm
Aug 16 09:27:16 h91 kernel: brcmfmac: brcmf_cfg80211_get_station RSSI 
-58 dBm

