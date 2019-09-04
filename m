Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 80587A7B5B
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Sep 2019 08:14:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728236AbfIDGOr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 4 Sep 2019 02:14:47 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:59342 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726589AbfIDGOr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 4 Sep 2019 02:14:47 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 62979616B8; Wed,  4 Sep 2019 06:14:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1567577685;
        bh=fpj+p1lpfCxIg6lDAXnn/+GeQoWWFoRjvXM4U+vcW1g=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=ilpS8JxsImaYBisd9WdSBtS5XLk135IKpli2HCw1lCjgoD0GIkh8FVlCOHYq9cFLq
         PM2TTBHT49UMv725j3xs7EWSsiHMrKnCW6JZln5JTZ75K71jGFge8kZLa9v3qJOwE7
         N+vPs9X77bjypky8oQIxVto4/QPBy508XBh3lMl8=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,MISSING_DATE,MISSING_MID,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D5F8361782;
        Wed,  4 Sep 2019 06:14:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1567577679;
        bh=fpj+p1lpfCxIg6lDAXnn/+GeQoWWFoRjvXM4U+vcW1g=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=IWI+Xdp7c5oIniwuucbfraisJb8My5/GIlrbaTDPCOcUDj+qWD7QnDuIXj+UcnZ2K
         FlVEbRtaTqKX3cj2aSSN7Oneg076DZ0G11uvA9h5SHZ/ddeCmsBQ0eZRlXjV/6zhqc
         KxQOQjkjYuv5whfoWivGpzQGFqrBiH9rD7hpK0fI=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D5F8361782
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath9k: dynack: fix possible deadlock in
 ath_dynack_node_{de}init
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <3c5c90cd62da2db9a661b3045391da537dccf90f.1566200274.git.lorenzo@kernel.org>
References: <3c5c90cd62da2db9a661b3045391da537dccf90f.1566200274.git.lorenzo@kernel.org>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20190904061445.62979616B8@smtp.codeaurora.org>
Date:   Wed,  4 Sep 2019 06:14:41 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Lorenzo Bianconi <lorenzo@kernel.org> wrote:

> Fix following lockdep warning disabling bh in
> ath_dynack_node_init/ath_dynack_node_deinit
> 
> [   75.955878] --------------------------------
> [   75.955880] inconsistent {SOFTIRQ-ON-W} -> {IN-SOFTIRQ-W} usage.
> [   75.955884] swapper/0/0 [HC0[0]:SC1[3]:HE1:SE0] takes:
> [   75.955888] 00000000792a7ee0 (&(&da->qlock)->rlock){+.?.}, at: ath_dynack_sample_ack_ts+0x4d/0xa0 [ath9k_hw]
> [   75.955905] {SOFTIRQ-ON-W} state was registered at:
> [   75.955912]   lock_acquire+0x9a/0x160
> [   75.955917]   _raw_spin_lock+0x2c/0x70
> [   75.955927]   ath_dynack_node_init+0x2a/0x60 [ath9k_hw]
> [   75.955934]   ath9k_sta_state+0xec/0x160 [ath9k]
> [   75.955976]   drv_sta_state+0xb2/0x740 [mac80211]
> [   75.956008]   sta_info_insert_finish+0x21a/0x420 [mac80211]
> [   75.956039]   sta_info_insert_rcu+0x12b/0x2c0 [mac80211]
> [   75.956069]   sta_info_insert+0x7/0x70 [mac80211]
> [   75.956093]   ieee80211_prep_connection+0x42e/0x730 [mac80211]
> [   75.956120]   ieee80211_mgd_auth.cold+0xb9/0x15c [mac80211]
> [   75.956152]   cfg80211_mlme_auth+0x143/0x350 [cfg80211]
> [   75.956169]   nl80211_authenticate+0x25e/0x2b0 [cfg80211]
> [   75.956172]   genl_family_rcv_msg+0x198/0x400
> [   75.956174]   genl_rcv_msg+0x42/0x90
> [   75.956176]   netlink_rcv_skb+0x35/0xf0
> [   75.956178]   genl_rcv+0x1f/0x30
> [   75.956180]   netlink_unicast+0x154/0x200
> [   75.956182]   netlink_sendmsg+0x1bf/0x3d0
> [   75.956186]   ___sys_sendmsg+0x2c2/0x2f0
> [   75.956187]   __sys_sendmsg+0x44/0x80
> [   75.956190]   do_syscall_64+0x55/0x1a0
> [   75.956192]   entry_SYSCALL_64_after_hwframe+0x49/0xbe
> [   75.956194] irq event stamp: 2357092
> [   75.956196] hardirqs last  enabled at (2357092): [<ffffffff818c62de>] _raw_spin_unlock_irqrestore+0x3e/0x50
> [   75.956199] hardirqs last disabled at (2357091): [<ffffffff818c60b1>] _raw_spin_lock_irqsave+0x11/0x80
> [   75.956202] softirqs last  enabled at (2357072): [<ffffffff8106dc09>] irq_enter+0x59/0x60
> [   75.956204] softirqs last disabled at (2357073): [<ffffffff8106dcbe>] irq_exit+0xae/0xc0
> [   75.956206]
>                other info that might help us debug this:
> [   75.956207]  Possible unsafe locking scenario:
> 
> [   75.956208]        CPU0
> [   75.956209]        ----
> [   75.956210]   lock(&(&da->qlock)->rlock);
> [   75.956213]   <Interrupt>
> [   75.956214]     lock(&(&da->qlock)->rlock);
> [   75.956216]
>                 *** DEADLOCK ***
> 
> [   75.956217] 1 lock held by swapper/0/0:
> [   75.956219]  #0: 000000003bb5675c (&(&sc->sc_pcu_lock)->rlock){+.-.}, at: ath9k_tasklet+0x55/0x240 [ath9k]
> [   75.956225]
>                stack backtrace:
> [   75.956228] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.3.0-rc1-wdn+ #13
> [   75.956229] Hardware name: Dell Inc. Studio XPS 1340/0K183D, BIOS A11 09/08/2009
> [   75.956231] Call Trace:
> [   75.956233]  <IRQ>
> [   75.956236]  dump_stack+0x67/0x90
> [   75.956239]  mark_lock+0x4c1/0x640
> [   75.956242]  ? check_usage_backwards+0x130/0x130
> [   75.956245]  ? sched_clock_local+0x12/0x80
> [   75.956247]  __lock_acquire+0x484/0x7a0
> [   75.956250]  ? __lock_acquire+0x3b9/0x7a0
> [   75.956252]  lock_acquire+0x9a/0x160
> [   75.956259]  ? ath_dynack_sample_ack_ts+0x4d/0xa0 [ath9k_hw]
> [   75.956262]  _raw_spin_lock_bh+0x34/0x80
> [   75.956268]  ? ath_dynack_sample_ack_ts+0x4d/0xa0 [ath9k_hw]
> [   75.956275]  ath_dynack_sample_ack_ts+0x4d/0xa0 [ath9k_hw]
> [   75.956280]  ath_rx_tasklet+0xd09/0xe90 [ath9k]
> [   75.956286]  ath9k_tasklet+0x102/0x240 [ath9k]
> [   75.956288]  tasklet_action_common.isra.0+0x6d/0x170
> [   75.956291]  __do_softirq+0xcc/0x425
> [   75.956294]  irq_exit+0xae/0xc0
> [   75.956296]  do_IRQ+0x8a/0x110
> [   75.956298]  common_interrupt+0xf/0xf
> [   75.956300]  </IRQ>
> [   75.956303] RIP: 0010:cpuidle_enter_state+0xb2/0x400
> [   75.956308] RSP: 0018:ffffffff82203e70 EFLAGS: 00000202 ORIG_RAX: ffffffffffffffd7
> [   75.956310] RAX: ffffffff82219800 RBX: ffffffff822bd0a0 RCX: 0000000000000000
> [   75.956312] RDX: 0000000000000046 RSI: 0000000000000006 RDI: ffffffff82219800
> [   75.956314] RBP: ffff888155a01c00 R08: 00000011af51aabe R09: 0000000000000000
> [   75.956315] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000002
> [   75.956317] R13: 00000011af51aabe R14: 0000000000000003 R15: ffffffff82219800
> [   75.956321]  cpuidle_enter+0x24/0x40
> [   75.956323]  do_idle+0x1ac/0x220
> [   75.956326]  cpu_startup_entry+0x14/0x20
> [   75.956329]  start_kernel+0x482/0x489
> [   75.956332]  secondary_startup_64+0xa4/0xb0
> 
> Fixes: c774d57fd47c ("ath9k: add dynamic ACK timeout estimation")
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> Tested-by: Koen Vandeputte <koen.vandeputte@ncentric.com>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

e1aa1a1db3b0 ath9k: dynack: fix possible deadlock in ath_dynack_node_{de}init

-- 
https://patchwork.kernel.org/patch/11100409/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

