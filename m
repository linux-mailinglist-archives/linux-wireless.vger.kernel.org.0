Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AB70535957
	for <lists+linux-wireless@lfdr.de>; Fri, 27 May 2022 08:29:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243369AbiE0G3V (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 27 May 2022 02:29:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239283AbiE0G3U (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 27 May 2022 02:29:20 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8185A419A2
        for <linux-wireless@vger.kernel.org>; Thu, 26 May 2022 23:29:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id ED576B822A4
        for <linux-wireless@vger.kernel.org>; Fri, 27 May 2022 06:29:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86D06C385A9;
        Fri, 27 May 2022 06:29:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653632956;
        bh=QxCFhf4GrKe9zpLBv9+nnVFHuwXz/vPqHwjYl/qM7Ik=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=fS5IJDU6vw36dNkPgJ0Mkth3gnD3wOfcZ+cDjcZdTxzvkC05jCcDxqjG/dD9273t1
         Ykgj5yKaurThfonKN/IiRIQUuuPxvF/uzYVrt3GOAVdWr5KPaEiuiIziKjnx3W8qI/
         kqIZ8OFohyuun4/b1SQzmoajfWioidMhb1l2D0sDr4Sw3LwRMqyB5pNrAvTSZWS8cO
         1tiqmL0GTbV7TkJTdhe5iikqpUu8V97j0UmJY4EM96mSA43BJiZ6dIG6BOtNfMhTKI
         PrwPFJOsa2WrkoqG66H4QcfnnOXemulB7w992XLIChs+6BpVNukjwoGu+llDyXmLeF
         ivB3+hUI1dXAA==
From:   Kalle Valo <kvalo@kernel.org>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <tony0620emma@gmail.com>, <linux-wireless@vger.kernel.org>,
        <megi@xff.cz>, <phhuang@realtek.com>
Subject: Re: [PATCH] rtw88: add a work to correct atomic scheduling warning of ::set_tim
References: <20220526051251.281905-1-pkshih@realtek.com>
Date:   Fri, 27 May 2022 09:29:13 +0300
In-Reply-To: <20220526051251.281905-1-pkshih@realtek.com> (Ping-Ke Shih's
        message of "Thu, 26 May 2022 13:12:51 +0800")
Message-ID: <871qwfwksm.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> writes:

> The set_tim is supposed to be atomic, but we should download beacon
> context to firmware with a mutex lock. To avoid warning, do the thing in
> another work.
>
> BUG: scheduling while atomic: swapper/1/0/0x00000700
> Modules linked in:
> CPU: 1 PID: 0 Comm: swapper/1 Tainted: G        W         5.18.0-rc7-0070=
3-g33b5ee09a0c1 #4
> Hardware name: Pine64 RK3566 Quartz64-A Board (DT)
> Call trace:
>  dump_backtrace.part.0+0xc4/0xd0
>  show_stack+0x14/0x60
>  dump_stack_lvl+0x60/0x78
>  dump_stack+0x14/0x2c
>  __schedule_bug+0x5c/0x70
>  __schedule+0x5c4/0x630
>  schedule+0x44/0xb0
>  schedule_preempt_disabled+0xc/0x14
>  __mutex_lock.constprop.0+0x538/0x56c
>  __mutex_lock_slowpath+0x10/0x20
>  mutex_lock+0x54/0x60
>  rtw_ops_set_tim+0x20/0x40
>  __sta_info_recalc_tim+0x150/0x250
>  sta_info_recalc_tim+0x10/0x20
>  invoke_tx_handlers_early+0x4e4/0x5c0
>  ieee80211_tx+0x78/0x110
>  ieee80211_xmit+0x94/0xc0
>  __ieee80211_subif_start_xmit+0x818/0xd20
>  ieee80211_subif_start_xmit+0x44/0x2d0
>  dev_hard_start_xmit+0xd0/0x150
>  __dev_queue_xmit+0x250/0xb30
>  dev_queue_xmit+0x10/0x20
>  br_dev_queue_push_xmit+0x94/0x174
>  br_forward_finish+0x90/0xa0
>  __br_forward+0xc0/0x13c
>  br_forward+0x108/0x134
>  br_dev_xmit+0x1cc/0x3a4
>  dev_hard_start_xmit+0xd0/0x150
>  __dev_queue_xmit+0x250/0xb30
>  dev_queue_xmit+0x10/0x20
>  arp_xmit+0x6c/0x7c
>  arp_send_dst+0x8c/0xc0
>  arp_solicit+0xd4/0x1e0
>  neigh_probe+0x58/0xa0
>  neigh_timer_handler+0x27c/0x380
>  call_timer_fn.constprop.0+0x20/0x80
>  __run_timers.part.0+0x230/0x280
>  run_timer_softirq+0x38/0x70
>  _stext+0x104/0x278
>  __irq_exit_rcu+0xa4/0xdc
>  irq_exit_rcu+0xc/0x14
>  el1_interrupt+0x34/0x50
>  el1h_64_irq_handler+0x14/0x20
>  el1h_64_irq+0x64/0x68
>  arch_cpu_idle+0x14/0x20
>  do_idle+0x208/0x290
>  cpu_startup_entry+0x20/0x30
>  secondary_start_kernel+0x130/0x144
>  __secondary_switched+0x54/0x58
>
> Fixes: f2217968ffda ("rtw88: Add update beacon flow for AP mode")
> Reported-by: Ond=C5=99ej Jirman <megi@xff.cz>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

Should I queue this to v5.19 (ie. take to wireles tree)?

--=20
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes
