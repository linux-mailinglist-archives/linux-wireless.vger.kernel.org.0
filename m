Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76B6D6544F3
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Dec 2022 17:13:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235095AbiLVQNe (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 22 Dec 2022 11:13:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235438AbiLVQNX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 22 Dec 2022 11:13:23 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62917266C
        for <linux-wireless@vger.kernel.org>; Thu, 22 Dec 2022 08:13:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EFAFA61C28
        for <linux-wireless@vger.kernel.org>; Thu, 22 Dec 2022 16:13:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F590C433D2;
        Thu, 22 Dec 2022 16:13:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671725601;
        bh=wfOifAYYGqgOmGTia5Xq6EcB6FEEfOOZFhaJkuEe9L4=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=tEGO9JFTe052VnLPjoApdHFgZp9upX5lL4Ty0G41PR5BefdUDacyHagf95wSMqF2W
         cQYk63aRNBup8fS9i/d92eAcVGR/uF7e4jTBMSy4XE3xfP4ahVDVjAZAtZmCsSO/fa
         4kMh5q/tJDaVu0fvGgnrc9Mh6f33HfLGIyJlqJqDPiNYEhKjpMRj2fQiruqCV+7vzo
         gDSV68VJHJSfSYx+qkNoYpF64Kgn9/7605p+50FPXQny28LmB5uzjZGANKe4Jke8w5
         uCwgmLv3TrPgv6enTpJH3faeDeLmtoyn6kNoGhUrxAxiuaPtV0X1IzrVuMNucaYk6i
         MslWxHrCI/y/g==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [v2,1/4] wifi: libertas_tf: don't call kfree_skb() under
 spin_lock_irqsave()
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20221207150008.111743-2-yangyingliang@huawei.com>
References: <20221207150008.111743-2-yangyingliang@huawei.com>
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     <libertas-dev@lists.infradead.org>,
        <linux-wireless@vger.kernel.org>, <yangyingliang@huawei.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <167172559861.8231.3944096616079868507.kvalo@kernel.org>
Date:   Thu, 22 Dec 2022 16:13:20 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Yang Yingliang <yangyingliang@huawei.com> wrote:

> It is not allowed to call kfree_skb() from hardware interrupt
> context or with interrupts being disabled. So replace kfree_skb()
> with dev_kfree_skb_irq() under spin_lock_irqsave(). Compile
> tested only.
> 
> Fixes: fc75122fabb5 ("libertas_tf: use irqsave() in USB's complete callback")
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>

4 patches applied to wireless-next.git, thanks.

9388ce97b982 wifi: libertas_tf: don't call kfree_skb() under spin_lock_irqsave()
3968e81ba644 wifi: libertas: if_usb: don't call kfree_skb() under spin_lock_irqsave()
f393df151540 wifi: libertas: main: don't call kfree_skb() under spin_lock_irqsave()
708a49a64237 wifi: libertas: cmdresp: don't call kfree_skb() under spin_lock_irqsave()

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20221207150008.111743-2-yangyingliang@huawei.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

