Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5BCDC9628B
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Aug 2019 16:36:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729927AbfHTOgC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 20 Aug 2019 10:36:02 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:46319 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729260AbfHTOgC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 20 Aug 2019 10:36:02 -0400
Received: by mail-ed1-f67.google.com with SMTP id z51so6568588edz.13
        for <linux-wireless@vger.kernel.org>; Tue, 20 Aug 2019 07:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ncentric-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=OJadLMK3ar3SoE5nMcfV5jCOULU3QVNq1hrjPlAQB4A=;
        b=n4bnrgng5bjSXGTnjGIPz4lE1zLQj8REPtIZUyz52JPbS/V2OmOVM3aNtDQMaN5OOg
         hFE8B1D6YJJLuRJVF9q+sKKFkPhpXYBkz2VaS4qY2giTWdHjUChkB9o75N/rzlaIFiV3
         TKMoDA0Zh4x/HDRM8ZRXD7nTqNJ67BLKUPlOqJ93API32iJmusgxMDq4B21nWYGccuap
         A3DbrXOSYIVyLoU1IRSXeBdUK6KnAQk3DuOjhuhgjb9CU4lfhopJH9DDr9zRtuxxwizb
         NQ8muHhNrZOi1llPKoknLqIkgsB3POG9uvw8PyYX+7cdOv/vjJ/rW/NuBBtseUan1BZB
         Sh8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=OJadLMK3ar3SoE5nMcfV5jCOULU3QVNq1hrjPlAQB4A=;
        b=MSpjl4euFlR4AtoNbmOPrDG7W1qB4PeZLrLZocANdxM3O6IHQxG9ldKIHHX7A4YMJX
         EWKtNB0MJaP4KjNLPDMiHWZsBTzhss3rZpYneBKUgx2BF49hludcHxUfXddIykJi/0Xp
         S5Zv03+7uSCJS2X7pK8r/DdluXLm3L4M0w0lA/4qXGzpoqPytCrLldPc3fhF/mhelcpB
         LZu3nED5fglYf7UEujB1lWr8wIfPf9hMmJa7RAD5WBOyG3HdWeX1XAiSHDSLdpFpJuKQ
         2XBHPTV5mX/2iAKiUsaxPnH9RtElM+A6RKhHGFNpcCqrI4b4OQSfervugTisPkFClliq
         uHXg==
X-Gm-Message-State: APjAAAVQ7lr9Iw9EGHnrZFxTu6sMD1DpI96Wirw5vGKpgCn65SOJ3ffn
        yALMAcVg5kfjBqGCWwm9qAQ+pLqTQjM=
X-Google-Smtp-Source: APXvYqwD5a8ATtQP5cITdlRnIPU3ppQFwUr3HAmAklXjbpDzarPVsssIGQ+P1RMcQ5+GZnktVJgqKg==
X-Received: by 2002:a05:6402:1641:: with SMTP id s1mr30469590edx.52.1566311759193;
        Tue, 20 Aug 2019 07:35:59 -0700 (PDT)
Received: from [192.168.3.176] (d515300d8.static.telenet.be. [81.83.0.216])
        by smtp.gmail.com with ESMTPSA id h38sm3537144eda.58.2019.08.20.07.35.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Aug 2019 07:35:58 -0700 (PDT)
Subject: Re: Fwd: [PATCH] ath9k: dynack: fix possible deadlock in
 ath_dynack_node_{de}init
To:     Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>,
        linux-wireless@vger.kernel.org
References: <3c5c90cd62da2db9a661b3045391da537dccf90f.1566200274.git.lorenzo@kernel.org>
 <CAA2SeNKp9Zsofm+7MDZveR94GCDJJtz_aF+bHX_vevg9tWnGgQ@mail.gmail.com>
From:   Koen Vandeputte <koen.vandeputte@ncentric.com>
Message-ID: <abd74240-f31b-0d5d-5cde-be8b3e6c1267@ncentric.com>
Date:   Tue, 20 Aug 2019 16:35:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAA2SeNKp9Zsofm+7MDZveR94GCDJJtz_aF+bHX_vevg9tWnGgQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 20.08.19 16:33, Lorenzo Bianconi wrote:
> ---------- Forwarded message ---------
> From: Lorenzo Bianconi <lorenzo@kernel.org>
> Date: Mon, Aug 19, 2019 at 9:44 AM
> Subject: [PATCH] ath9k: dynack: fix possible deadlock in
> ath_dynack_node_{de}init
> To: <kvalo@codeaurora.org>
> Cc: <lorenzo.bianconi@redhat.com>, <linux-wireless@vger.kernel.org>
>
>
> Fix following lockdep warning disabling bh in
> ath_dynack_node_init/ath_dynack_node_deinit
>
> [   75.955878] --------------------------------
> [   75.955880] inconsistent {SOFTIRQ-ON-W} -> {IN-SOFTIRQ-W} usage.
> [   75.955884] swapper/0/0 [HC0[0]:SC1[3]:HE1:SE0] takes:
> [   75.955888] 00000000792a7ee0 (&(&da->qlock)->rlock){+.?.}, at:
> ath_dynack_sample_ack_ts+0x4d/0xa0 [ath9k_hw]
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
> [   75.956196] hardirqs last  enabled at (2357092):
> [<ffffffff818c62de>] _raw_spin_unlock_irqrestore+0x3e/0x50
> [   75.956199] hardirqs last disabled at (2357091):
> [<ffffffff818c60b1>] _raw_spin_lock_irqsave+0x11/0x80
> [   75.956202] softirqs last  enabled at (2357072):
> [<ffffffff8106dc09>] irq_enter+0x59/0x60
> [   75.956204] softirqs last disabled at (2357073):
> [<ffffffff8106dcbe>] irq_exit+0xae/0xc0
> [   75.956206]
>                 other info that might help us debug this:
> [   75.956207]  Possible unsafe locking scenario:
>
> [   75.956208]        CPU0
> [   75.956209]        ----
> [   75.956210]   lock(&(&da->qlock)->rlock);
> [   75.956213]   <Interrupt>
> [   75.956214]     lock(&(&da->qlock)->rlock);
> [   75.956216]
>                  *** DEADLOCK ***
>
> [   75.956217] 1 lock held by swapper/0/0:
> [   75.956219]  #0: 000000003bb5675c
> (&(&sc->sc_pcu_lock)->rlock){+.-.}, at: ath9k_tasklet+0x55/0x240
> [ath9k]
> [   75.956225]
>                 stack backtrace:
> [   75.956228] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.3.0-rc1-wdn+ #13
> [   75.956229] Hardware name: Dell Inc. Studio XPS 1340/0K183D, BIOS
> A11 09/08/2009
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
> [   75.956308] RSP: 0018:ffffffff82203e70 EFLAGS: 00000202 ORIG_RAX:
> ffffffffffffffd7
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
> ---
>   drivers/net/wireless/ath/ath9k/dynack.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/net/wireless/ath/ath9k/dynack.c
> b/drivers/net/wireless/ath/ath9k/dynack.c
> index f112fa5b2eac..1ccf20d8c160 100644
> --- a/drivers/net/wireless/ath/ath9k/dynack.c
> +++ b/drivers/net/wireless/ath/ath9k/dynack.c
> @@ -298,9 +298,9 @@ void ath_dynack_node_init(struct ath_hw *ah,
> struct ath_node *an)
>
>          an->ackto = ackto;
>
> -       spin_lock(&da->qlock);
> +       spin_lock_bh(&da->qlock);
>          list_add_tail(&an->list, &da->nodes);
> -       spin_unlock(&da->qlock);
> +       spin_unlock_bh(&da->qlock);
>   }
>   EXPORT_SYMBOL(ath_dynack_node_init);
>
> @@ -314,9 +314,9 @@ void ath_dynack_node_deinit(struct ath_hw *ah,
> struct ath_node *an)
>   {
>          struct ath_dynack *da = &ah->dynack;
>
> -       spin_lock(&da->qlock);
> +       spin_lock_bh(&da->qlock);
>          list_del(&an->list);
> -       spin_unlock(&da->qlock);
> +       spin_unlock_bh(&da->qlock);
>   }
>   EXPORT_SYMBOL(ath_dynack_node_deinit);
>
> --
> 2.21.0
>
Tested on a large amount of devices with lockdep enabled, covering:

- single core - dual core - dual cpu

Tested-by: Koen Vandeputte <koen.vandeputte@ncentric.com>

>
