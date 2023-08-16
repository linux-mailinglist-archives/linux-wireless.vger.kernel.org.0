Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CABB77E03A
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Aug 2023 13:25:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244549AbjHPLZP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 16 Aug 2023 07:25:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244492AbjHPLYj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 16 Aug 2023 07:24:39 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C1262112
        for <linux-wireless@vger.kernel.org>; Wed, 16 Aug 2023 04:24:36 -0700 (PDT)
Received: from [192.168.179.2] ([91.47.218.225]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1M9Evp-1qRY4U3kIR-006RyF; Wed, 16 Aug 2023 13:24:33 +0200
Message-ID: <afaf7b61-3883-3ffd-6dec-d9b68150293d@online.de>
Date:   Wed, 16 Aug 2023 13:24:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [RFC PATCH v2 6.1] wifi: cfg80211: fix cqm_config access race
Content-Language: en-US
To:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org
References: <20230815134247.4b4bd52ea708.I1a1bb102329fc88e4712eaf394cba3025ada0dc7@changeid>
 <20230815153741.cc51cb52a296.I1a1bb102329fc88e4712eaf394cba3025ada0dc7@changeid>
 <98456a69-d597-505c-6a1b-f33b5f6343e9@online.de>
 <dd3c90b687a933f3b2d467a0e3a2f918c26201f4.camel@sipsolutions.net>
From:   Max Schulze <max.schulze@online.de>
In-Reply-To: <dd3c90b687a933f3b2d467a0e3a2f918c26201f4.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:k1gKmJ4glNxpy6QM4iS1lR16ODIQ2LYfY1xcSY0zfNHWWYmIhMA
 9z96JsNtXj8LgsOPPCp8rjNN8/OyQj7XjJuvVEVSGe4MMGADak048Rs//TEQ6DAQnDF5wIk
 sLqRarVEpvY7/XZO+9jylzBx2YDoKgpbLmQn0i8q6dVEvCbBLS9GdmpSlA/QH848c6nil8d
 e1efXRLBVWWryJ/bdKeZg==
UI-OutboundReport: notjunk:1;M01:P0:cSo/jq/z+mQ=;q3XTqOzNcZRXatI2L9HxceKMBiQ
 HVqKN4Sz+hv602WFRdYLACZKOOarAgk/yFooeuxxE0DDz8P/IB1/3mAoj7gi6uEEXzKScJfNq
 FMX0INKFR7L54L0IUm9DGvSJQTgJ7d43QxPWL/T4fcy+4a2NQMC5cflmKQasHmysLv/Lm5tqz
 jOf/rJKqQY0nTmaXg9tW1FjH6Lnrh+4AhQ2li0I5xDmqHx2ODDk6Iby5ECdKLHQoOb4Ev4O3a
 pc6C2LzvAl4yPFdLrQL5kEmGXl7fheO2rlHClE4HWtJNjHcqgYzrwJAV7gAOzYFXo1HliR0b7
 5eNFv+x3Y8DN8h3rrN5OfJqPHWv+Wt6Jvp2V+sXgfxFRkTXUoHbCSprGjNF2NQgpcwN1ICOBd
 aU2z6PijrIWlcLJqxTDhXtjqm35KOlLlvQGjiR07F3epFf4RDnHG5hQ6J0eOKoVjkq+5u1gAT
 lWE6EIgh2DEUo1z3CtGzoxziKDXu9c6eJsjvTvdPbwanSmOTKtitz1JbXaM2oN+m6mpWHvpnJ
 4tzhFficj6RCRTkhwwquDsd9OiYjug19ixIup1pSJEtUcqAzh4K6v7PrLl176VEAFBsiHn1sg
 81u0MneAqpFRLEEjo0KV7kZi3DTLscYb4DYMVbuWA9w8rlZULW1Gr1KpjlxyEq6rWeTZUUnQr
 WeV0WGM2EkejKkE144WrLmFbTUqYX7bkx8/y6QMH02I6FrYPdr8RPoFG3nWYjzuRLANO7Qv61
 CQIhSbiERMNIgGUcAqnucrD1/L9vE73QShj2/W0Gjq/uVpezwhX0CoPVFTj9ZjI7yh6Qmh7SM
 gmr7+xzFxJfAS2afQhE3QIkviYmBSmZxn803o93UslIMadT+G9IZ0zGZwNc10CKmbzcGyNUvm
 FQvo/2NqNPksADQ==
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

You are right, I have no clear proof.

However, here is a second trace from the same system.
Another system has crashed, I have not recovered the trace yet.

The context, that there is a RSSI notification just beforehand, is exactly the same (as the initial bug report).

You have a clue?


Aug 16 11:03:32 h63 wpa_supplicant[389]: wlan0: Associated with 
xx:xx:xx:xx:00:91
Aug 16 11:03:32 h63 wpa_supplicant[389]: wlan0: CTRL-EVENT-CONNECTED - 
Connection to xx:xx:xx:xx:00:91 completed [id=0 id_str=]
Aug 16 11:03:32 h63 wpa_supplicant[389]: wlan0: 
CTRL-EVENT-SUBNET-STATUS-UPDATE status=0
Aug 16 11:03:32 h63 NetworkManager[373]: <info>  [1692176612.2898] 
device (wlan0): supplicant interface state: associating -> completed
Aug 16 11:03:32 h63 NetworkManager[373]: <info>  [1692176612.2933] 
device (p2p-dev-wlan0): supplicant management interface state: 
associating -> completed
Aug 16 11:03:32 h63 kernel: brcmfmac: brcmf_cfg80211_get_station RSSI 
-63 dBm
Aug 16 11:03:32 h63 kernel: brcmfmac: brcmf_rx_event Enter: mmc1:0001:1: 
rxp=00000000b1aa24a9
Aug 16 11:03:32 h63 kernel: brcmfmac: brcmf_fweh_event_worker event RSSI 
(56) ifidx 0 bsscfg 0 addr 00:00:00:ab:c0:c1
Aug 16 11:03:32 h63 kernel: brcmfmac: brcmf_fweh_event_worker   version 
2 flags 0 status 0 reason 0
Aug 16 11:03:32 h63 kernel: brcmutil: event payload, len=12
Aug 16 11:03:32 h63 kernel: 00000000: ff ff ff c1 00 00 00 00 ff ff ff 
a5              ............
Aug 16 11:03:35 h63 kernel: brcmfmac: brcmf_cfg80211_get_station RSSI 
-63 dBm
Aug 16 11:03:40 h63 kernel: Unable to handle kernel NULL pointer 
dereference at virtual address 00000000000000cc
Aug 16 11:03:40 h63 kernel: Mem abort info:
Aug 16 11:03:41 h63 kernel:   ESR = 0x0000000096000005
Aug 16 11:03:41 h63 kernel:   EC = 0x25: DABT (current EL), IL = 32 bits
Aug 16 11:03:41 h63 kernel:   SET = 0, FnV = 0
Aug 16 11:03:41 h63 kernel:   EA = 0, S1PTW = 0
Aug 16 11:03:41 h63 kernel:   FSC = 0x05: level 1 translation fault
Aug 16 11:03:41 h63 kernel: Data abort info:
Aug 16 11:03:41 h63 kernel:   ISV = 0, ISS = 0x00000005
Aug 16 11:03:41 h63 kernel:   CM = 0, WnR = 0
Aug 16 11:03:41 h63 kernel: user pgtable: 4k pages, 39-bit VAs, 
pgdp=0000000049427000
Aug 16 11:03:41 h63 kernel: [00000000000000cc] pgd=0000000000000000, 
p4d=0000000000000000, pud=0000000000000000
Aug 16 11:03:41 h63 kernel: Internal error: Oops: 0000000096000005 [#1] 
PREEMPT SMP
Aug 16 11:03:41 h63 kernel: Modules linked in: rtc_pcf85063 ov9281 
regmap_i2c brcmfmac vc4 brcmutil cfg80211 snd_soc_hdmi_codec 
drm_display_helper cec drm_dma_helper drm_kms_helper v3d gpu_sched 
binfmt_mis>
Aug 16 11:03:41 h63 kernel: CPU: 2 PID: 491 Comm: Xorg Tainted: G 
 C         6.1.45-v8-gdc69f9d60872 #3
Aug 16 11:03:41 h63 kernel: Hardware name: Raspberry Pi Compute Module 4 
Rev 1.0 (DT)
Aug 16 11:03:41 h63 kernel: pstate: 80000005 (Nzcv daif -PAN -UAO -TCO 
-DIT -SSBS BTYPE=--)
Aug 16 11:03:41 h63 kernel: pc : drm_ioctl+0x284/0x440 [drm]
Aug 16 11:03:41 h63 kernel: lr : drm_ioctl+0xac/0x440 [drm]
Aug 16 11:03:41 h63 kernel: sp : ffffffc00935bca0
Aug 16 11:03:41 h63 kernel: x29: ffffffc00935bcb0 x28: ffffff8045499f00 
x27: 0000000000000000
Aug 16 11:03:41 h63 kernel: x26: 0000000000000000 x25: ffffff804806a800 
x24: 0000000000000041
Aug 16 11:03:41 h63 kernel: x23: ffffff804946d900 x22: 00000000c0106441 
x21: 0000007fc2a766f8
Aug 16 11:03:41 h63 kernel: x20: ffffff8040370000 x19: 0000000000000001 
x18: 0000000000000000
Aug 16 11:03:41 h63 kernel: x17: 0000000000000000 x16: ffffffe34ff1a2d0 
x15: 0000000000000000
Aug 16 11:03:41 h63 kernel: x14: 0000000000000000 x13: 0000000000000000 
x12: 0000000000000000
Aug 16 11:03:41 h63 kernel: x11: 0000000000000000 x10: 0000000000000000 
x9 : ffffffe315a9eed0
Aug 16 11:03:41 h63 kernel: x8 : 0000000000000000 x7 : 0000000000000000 
x6 : 0000000000159ba4
Aug 16 11:03:41 h63 kernel: x5 : 0000000000159ba5 x4 : 0000000000000000 
x3 : 0000000000000001
Aug 16 11:03:41 h63 kernel: x2 : ffffff8045499f00 x1 : ffffff9d2eca5000 
x0 : 0000000000000004
Aug 16 11:03:41 h63 kernel: Call trace:
Aug 16 11:03:41 h63 kernel:  drm_ioctl+0x284/0x440 [drm]
Aug 16 11:03:41 h63 kernel:  __arm64_sys_ioctl+0xb0/0xf4
Aug 16 11:03:41 h63 kernel:  invoke_syscall+0x50/0x120
Aug 16 11:03:41 h63 kernel:  el0_svc_common.constprop.0+0x68/0x124
Aug 16 11:03:41 h63 kernel:  do_el0_svc+0x34/0xd0
Aug 16 11:03:41 h63 kernel:  el0_svc+0x30/0x94
Aug 16 11:03:41 h63 kernel:  el0t_64_sync_handler+0xb8/0xbc
Aug 16 11:03:41 h63 kernel:  el0t_64_sync+0x18c/0x190
Aug 16 11:03:41 h63 kernel: Code: 35000455 a94673fb 17ffff7b f9401a80 
(b940c800)
Aug 16 11:03:41 h63 kernel: ---[ end trace 0000000000000000 ]---
Aug 16 11:03:41 h63 kernel: brcmfmac: brcmf_cfg80211_get_station RSSI 
-67 dBm
Aug 16 11:03:45 h63 kernel: brcmfmac: brcmf_netdev_start_xmit wlan0: 
insufficient headroom (0)
Aug 16 11:03:45 h63 kernel: brcmfmac: brcmf_netdev_start_xmit wlan0: 
insufficient headroom (0)
