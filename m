Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7826A4E7B4E
	for <lists+linux-wireless@lfdr.de>; Sat, 26 Mar 2022 01:20:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233355AbiCYVOB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 25 Mar 2022 17:14:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233330AbiCYVOA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 25 Mar 2022 17:14:00 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32EFB5522B
        for <linux-wireless@vger.kernel.org>; Fri, 25 Mar 2022 14:12:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=/rnBUZh249QS9CVy714VYx0x8cQHaRUj4V5HkvGMmAA=; b=dPTQoqCWYfFuU2355l4VS3DcdU
        3TSPg7fjq6c0bf97c22jrFzyXLRxDp6XMQUoaPnjVr8cxwyNLBmcW38Ret1T9KwaPN+8+dO/nsv9/
        87UU362qJ7Ps3AM24hJm0t+AM/YmVMN7qiKsPrVqVRvbtATp1D4x2Z8dtngsvaXpXkCc=;
Received: from p200300daa70ef200dc11dea3d730df97.dip0.t-ipconnect.de ([2003:da:a70e:f200:dc11:dea3:d730:df97] helo=nf.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1nXrEG-0001kk-3b; Fri, 25 Mar 2022 22:12:16 +0100
Message-ID: <e44fe14f-ca77-a4bc-7a41-cd084c3b7c77@nbd.name>
Date:   Fri, 25 Mar 2022 22:12:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.7.0
Subject: Re: [PATCH] mt76: fix use-after-free issue in mt76_txq_schedule
Content-Language: en-US
To:     sean.wang@mediatek.com, lorenzo.bianconi@redhat.com
Cc:     Soul.Huang@mediatek.com, YN.Chen@mediatek.com,
        Leon.Yen@mediatek.com, Eric-SY.Chang@mediatek.com,
        Deren.Wu@mediatek.com, km.lin@mediatek.com,
        jenhao.yang@mediatek.com, robin.chiu@mediatek.com,
        Eddie.Chen@mediatek.com, ch.yeh@mediatek.com,
        posh.sun@mediatek.com, ted.huang@mediatek.com,
        Eric.Liang@mediatek.com, Stella.Chang@mediatek.com,
        Tom.Chou@mediatek.com, steve.lee@mediatek.com, jsiuda@google.com,
        frankgor@google.com, jemele@google.com, abhishekpandit@google.com,
        shawnku@google.com, linux-wireless@vger.kernel.org,
        linux-mediatek@lists.infradead.org
References: <0635c676d886bd0a3ae1c2679e7c1d82d39cfc2d.1647560233.git.objelf@gmail.com>
From:   Felix Fietkau <nbd@nbd.name>
In-Reply-To: <0635c676d886bd0a3ae1c2679e7c1d82d39cfc2d.1647560233.git.objelf@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 18.03.22 00:40, sean.wang@mediatek.com wrote:
> From: Sean Wang <sean.wang@mediatek.com>
> 
> Fix an issue caught by KASAN about use-after-free in mt76_txq_schedule
> by protecting mtxq->wcid with rcu_lock between mt76_txq_schedule and
> sta_info_[alloc, free].
> 
> [18853.876689] ==================================================================
> [18853.876751] BUG: KASAN: use-after-free in mt76_txq_schedule+0x204/0xaf8 [mt76]
> [18853.876773] Read of size 8 at addr ffffffaf989a2138 by task mt76-tx phy0/883
> [18853.876786]
> [18853.876810] CPU: 5 PID: 883 Comm: mt76-tx phy0 Not tainted 5.10.100-fix-510-56778d365941-kasan #5 0b01fbbcf41a530f52043508fec2e31a4215
> 
> [18853.876840] Call trace:
> [18853.876861]  dump_backtrace+0x0/0x3ec
> [18853.876878]  show_stack+0x20/0x2c
> [18853.876899]  dump_stack+0x11c/0x1ac
> [18853.876918]  print_address_description+0x74/0x514
> [18853.876934]  kasan_report+0x134/0x174
> [18853.876948]  __asan_report_load8_noabort+0x44/0x50
> [18853.876976]  mt76_txq_schedule+0x204/0xaf8 [mt76 074e03e4640e97fe7405ee1fab547b81c4fa45d2]
> [18853.877002]  mt76_txq_schedule_all+0x2c/0x48 [mt76 074e03e4640e97fe7405ee1fab547b81c4fa45d2]
> [18853.877030]  mt7921_tx_worker+0xa0/0x1cc [mt7921_common f0875ebac9d7b4754e1010549e7db50fbd90a047]
> [18853.877054]  __mt76_worker_fn+0x190/0x22c [mt76 074e03e4640e97fe7405ee1fab547b81c4fa45d2]
> [18853.877071]  kthread+0x2f8/0x3b8
> [18853.877087]  ret_from_fork+0x10/0x30
> [18853.877098]
> [18853.877112] Allocated by task 941:
> [18853.877131]  kasan_save_stack+0x38/0x68
> [18853.877147]  __kasan_kmalloc+0xd4/0xfc
> [18853.877163]  kasan_kmalloc+0x10/0x1c
> [18853.877177]  __kmalloc+0x264/0x3c4
> [18853.877294]  sta_info_alloc+0x460/0xf88 [mac80211]
> [18853.877410]  ieee80211_prep_connection+0x204/0x1ee0 [mac80211]
> [18853.877523]  ieee80211_mgd_auth+0x6c4/0xa4c [mac80211]
> [18853.877635]  ieee80211_auth+0x20/0x2c [mac80211]
> [18853.877733]  rdev_auth+0x7c/0x438 [cfg80211]
> [18853.877826]  cfg80211_mlme_auth+0x26c/0x390 [cfg80211]
> [18853.877919]  nl80211_authenticate+0x6d4/0x904 [cfg80211]
> [18853.877938]  genl_rcv_msg+0x748/0x93c
> [18853.877954]  netlink_rcv_skb+0x160/0x2a8
> [18853.877969]  genl_rcv+0x3c/0x54
> [18853.877985]  netlink_unicast_kernel+0x104/0x1ec
> [18853.877999]  netlink_unicast+0x178/0x268
> [18853.878015]  netlink_sendmsg+0x3cc/0x5f0
> [18853.878030]  sock_sendmsg+0xb4/0xd8
> [18853.878043]  ____sys_sendmsg+0x2f8/0x53c
> [18853.878058]  ___sys_sendmsg+0xe8/0x150
> [18853.878071]  __sys_sendmsg+0xc4/0x1f4
> [18853.878087]  __arm64_compat_sys_sendmsg+0x88/0x9c
> [18853.878101]  el0_svc_common+0x1b4/0x390
> [18853.878115]  do_el0_svc_compat+0x8c/0xdc
> [18853.878131]  el0_svc_compat+0x10/0x1c
> [18853.878146]  el0_sync_compat_handler+0xa8/0xcc
> [18853.878161]  el0_sync_compat+0x188/0x1c0
> [18853.878171]
> [18853.878183] Freed by task 10927:
> [18853.878200]  kasan_save_stack+0x38/0x68
> [18853.878215]  kasan_set_track+0x28/0x3c
> [18853.878228]  kasan_set_free_info+0x24/0x48
> [18853.878244]  __kasan_slab_free+0x11c/0x154
> [18853.878259]  kasan_slab_free+0x14/0x24
> [18853.878273]  slab_free_freelist_hook+0xac/0x1b0
> [18853.878287]  kfree+0x104/0x390
> [18853.878402]  sta_info_free+0x198/0x210 [mac80211]
> [18853.878515]  __sta_info_destroy_part2+0x230/0x2d4 [mac80211]
> [18853.878628]  __sta_info_flush+0x300/0x37c [mac80211]
> [18853.878740]  ieee80211_set_disassoc+0x2cc/0xa7c [mac80211]
> [18853.878851]  ieee80211_mgd_deauth+0x4a4/0x10a0 [mac80211]
> [18853.878962]  ieee80211_deauth+0x20/0x2c [mac80211]
> [18853.879057]  rdev_deauth+0x7c/0x438 [cfg80211]
> [18853.879150]  cfg80211_mlme_deauth+0x274/0x414 [cfg80211]
> [18853.879243]  cfg80211_mlme_down+0xe4/0x118 [cfg80211]
> [18853.879335]  cfg80211_disconnect+0x218/0x2d8 [cfg80211]
> [18853.879427]  __cfg80211_leave+0x17c/0x240 [cfg80211]
> [18853.879519]  cfg80211_leave+0x3c/0x58 [cfg80211]
> [18853.879611]  wiphy_suspend+0xdc/0x200 [cfg80211]
> [18853.879628]  dpm_run_callback+0x58/0x408
> [18853.879642]  __device_suspend+0x4cc/0x864
> [18853.879658]  async_suspend+0x34/0xf4
> [18853.879673]  async_run_entry_fn+0xe0/0x37c
> [18853.879689]  process_one_work+0x508/0xb98
> [18853.879702]  worker_thread+0x7f4/0xcd4
> [18853.879717]  kthread+0x2f8/0x3b8
> [18853.879731]  ret_from_fork+0x10/0x30
> [18853.879741]
> [18853.879757] The buggy address belongs to the object at ffffffaf989a2000
> [18853.879757]  which belongs to the cache kmalloc-8k of size 8192
> [18853.879774] The buggy address is located 312 bytes inside of
> [18853.879774]  8192-byte region [ffffffaf989a2000, ffffffaf989a4000)
> [18853.879787] The buggy address belongs to the page:
> [18853.879807] page:000000004bda2a59 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x1d89a0
> [18853.879823] head:000000004bda2a59 order:3 compound_mapcount:0 compound_pincount:0
> [18853.879839] flags: 0x8000000000010200(slab|head)
> [18853.879857] raw: 8000000000010200 ffffffffbc89e208 ffffffffb7fb5208 ffffffaec000cc80
> [18853.879873] raw: 0000000000000000 0000000000010001 00000001ffffffff 0000000000000000
> [18853.879885] page dumped because: kasan: bad access detected
> [18853.879896]
> [18853.879907] Memory state around the buggy address:
> [18853.879922]  ffffffaf989a2000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> [18853.879935]  ffffffaf989a2080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> [18853.879948] >ffffffaf989a2100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> [18853.879961]                                         ^
> [18853.879973]  ffffffaf989a2180: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> [18853.879986]  ffffffaf989a2200: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> [18853.879998] ==================================================================
> 
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
I think a better approach to deal with this is to put the wcid index in 
struct mt76_txq instead and use that to look up the wcid pointer from 
dev->wcid. I just sent a replacement fix that does that.

Thanks,

- Felix
