Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 800F7552AE9
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Jun 2022 08:16:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245457AbiFUGQu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 21 Jun 2022 02:16:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238120AbiFUGQt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 21 Jun 2022 02:16:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AB1D19C33
        for <linux-wireless@vger.kernel.org>; Mon, 20 Jun 2022 23:16:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 27814611D6
        for <linux-wireless@vger.kernel.org>; Tue, 21 Jun 2022 06:16:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B098C3411D;
        Tue, 21 Jun 2022 06:16:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655792207;
        bh=oJlTk7dvuzPVtaSSvi516ukFqZLhbMQ/L0BB9/Oxtww=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=uXBVcMg0p2cUF85R62cpuzwkpLBDO29Fl9nOFh5YG4h8jMdJcdUKUXF1wPX3y00RJ
         9Pe8Oab2fE6PVqWHI1Hf7WFk04KR0bk49UGHKahMehO489L4iJVBwznVNBu/FvUt0l
         rkmgNnvvsF65NvTmP4bvCI2bOyCErFJdkwPhgK6FasbmZ82ooX3gabt5RSBYccu/+f
         qkXdXuAF1ungjEEHSTKDihJR5Y2oTHFDaEBNT5kraPpgrE7jlBdOhy55YYNc+s8647
         rfAy5jSpo/aXO4U4nuZtem3t6JQ4kcSE1G/CBKGo4+R8CbLtTu4kQ3g9yXXO4mk5Xo
         RKNbI+KULDCEg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: wifi: rtw89: 8852a: rfk: fix div 0 exception
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20220613065144.15647-1-pkshih@realtek.com>
References: <20220613065144.15647-1-pkshih@realtek.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <165579220516.12213.14557341646439132321.kvalo@kernel.org>
Date:   Tue, 21 Jun 2022 06:16:46 +0000 (UTC)
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> wrote:

> The DPK is a kind of RF calibration whose algorithm is to fine tune
> parameters and calibrate, and check the result. If the result isn't good
> enough, it could adjust parameters and try again.
> 
> This issue is to read and show the result, but it could be a negative
> calibration result that causes divisor 0 and core dump. So, fix it by
> phy_div() that does division only if divisor isn't zero; otherwise,
> zero is adopted.
> 
>   divide error: 0000 [#1] PREEMPT SMP NOPTI
>   CPU: 1 PID: 728 Comm: wpa_supplicant Not tainted 5.10.114-16019-g462a1661811a #1 <HASH:d024 28>
>   RIP: 0010:rtw8852a_dpk+0x14ae/0x288f [rtw89_core]
>   RSP: 0018:ffffa9bb412a7520 EFLAGS: 00010246
>   RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
>   RDX: 0000000000000000 RSI: 00000000000180fc RDI: ffffa141d01023c0
>   RBP: ffffa9bb412a76a0 R08: 0000000000001319 R09: 00000000ffffff92
>   R10: ffffffffc0292de3 R11: ffffffffc00d2f51 R12: 0000000000000000
>   R13: ffffa141d01023c0 R14: ffffffffc0290250 R15: ffffa141d0102638
>   FS:  00007fa99f5c2740(0000) GS:ffffa142e5e80000(0000) knlGS:0000000000000000
>   CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>   CR2: 0000000013e8e010 CR3: 0000000110d2c000 CR4: 0000000000750ee0
>   PKRU: 55555554
>   Call Trace:
>    rtw89_core_sta_add+0x95/0x9c [rtw89_core <HASH:d239 29>]
>    rtw89_ops_sta_state+0x5d/0x108 [rtw89_core <HASH:d239 29>]
>    drv_sta_state+0x115/0x66f [mac80211 <HASH:81fe 30>]
>    sta_info_insert_rcu+0x45c/0x713 [mac80211 <HASH:81fe 30>]
>    sta_info_insert+0xf/0x1b [mac80211 <HASH:81fe 30>]
>    ieee80211_prep_connection+0x9d6/0xb0c [mac80211 <HASH:81fe 30>]
>    ieee80211_mgd_auth+0x2aa/0x352 [mac80211 <HASH:81fe 30>]
>    cfg80211_mlme_auth+0x160/0x1f6 [cfg80211 <HASH:00cd 31>]
>    nl80211_authenticate+0x2e5/0x306 [cfg80211 <HASH:00cd 31>]
>    genl_rcv_msg+0x371/0x3a1
>    ? nl80211_stop_sched_scan+0xe5/0xe5 [cfg80211 <HASH:00cd 31>]
>    ? genl_rcv+0x36/0x36
>    netlink_rcv_skb+0x8a/0xf9
>    genl_rcv+0x28/0x36
>    netlink_unicast+0x27b/0x3a0
>    netlink_sendmsg+0x2aa/0x469
>    sock_sendmsg_nosec+0x49/0x4d
>    ____sys_sendmsg+0xe5/0x213
>    __sys_sendmsg+0xec/0x157
>    ? syscall_enter_from_user_mode+0xd7/0x116
>    do_syscall_64+0x43/0x55
>    entry_SYSCALL_64_after_hwframe+0x44/0xa9
>   RIP: 0033:0x7fa99f6e689b
> 
> Fixes: e3ec7017f6a2 ("rtw89: add Realtek 802.11ax driver")
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

Patch applied to wireless-next.git, thanks.

683a4647a7a3 wifi: rtw89: 8852a: rfk: fix div 0 exception

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20220613065144.15647-1-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

