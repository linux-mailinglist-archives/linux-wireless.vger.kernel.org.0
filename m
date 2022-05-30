Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06EF653786C
	for <lists+linux-wireless@lfdr.de>; Mon, 30 May 2022 12:06:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234722AbiE3JP0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 30 May 2022 05:15:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234791AbiE3JPS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 30 May 2022 05:15:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7292F5D188
        for <linux-wireless@vger.kernel.org>; Mon, 30 May 2022 02:15:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0EBC260FB0
        for <linux-wireless@vger.kernel.org>; Mon, 30 May 2022 09:15:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59851C385B8;
        Mon, 30 May 2022 09:15:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653902116;
        bh=Qptw3ucd/iF4o/uC03GSFoUrVR/z+tvKmFYWXG1DkSw=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=qjWu0qA9YJXxIHdYBFMRztXax0eCkB6AbzF5ftgPXAX/vBmpnLd0+7NuwZfTWxB5b
         q4VFhBq9IBI2OexgGMcsaDsGJRRT5KoLF5YfoVtXF7OmHWK0kcVsb6zJmmEo0xrTnu
         vRc40IVRnNg7BL68lgI3jn5aNSlHXMFZuAi2jxH/eYLLwcB3nxxeGJ+ZL+RGy5c05M
         7jDaD2XpZtetHUJRXOFpql3CoSjj3Js9JX+FcIgv1gfr4TI/diNeQGiJtao50FxW3l
         +xYZd1APn6hGSD2yjmn4frPAnaUbNlGioGUQ+SQ4AHt4hgtZaXAz/Z+1qYAIcX3MIY
         ZSyICGsv7o95g==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: wifi: rtw88: add a work to correct atomic scheduling warning of
 ::set_tim
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20220526051251.281905-1-pkshih@realtek.com>
References: <20220526051251.281905-1-pkshih@realtek.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <tony0620emma@gmail.com>, <linux-wireless@vger.kernel.org>,
        <megi@xff.cz>, <phhuang@realtek.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <165390211307.17496.18363951449192946491.kvalo@kernel.org>
Date:   Mon, 30 May 2022 09:15:15 +0000 (UTC)
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

> The set_tim is supposed to be atomic, but we should download beacon
> context to firmware with a mutex lock. To avoid warning, do the thing in
> another work.
> 
> BUG: scheduling while atomic: swapper/1/0/0x00000700
> Modules linked in:
> CPU: 1 PID: 0 Comm: swapper/1 Tainted: G        W         5.18.0-rc7-00703-g33b5ee09a0c1 #4
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
> Reported-by: Ondřej Jirman <megi@xff.cz>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
> Tested-by: Ondřej Jirman <megi@xff.cz>

Patch applied to wireless.git, thanks.

7711fe713a49 wifi: rtw88: add a work to correct atomic scheduling warning of ::set_tim

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20220526051251.281905-1-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

