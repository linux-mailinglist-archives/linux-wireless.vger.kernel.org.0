Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD5786544C3
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Dec 2022 17:04:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229847AbiLVQES (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 22 Dec 2022 11:04:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbiLVQER (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 22 Dec 2022 11:04:17 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4779A102A
        for <linux-wireless@vger.kernel.org>; Thu, 22 Dec 2022 08:04:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D68A161C32
        for <linux-wireless@vger.kernel.org>; Thu, 22 Dec 2022 16:04:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F4C4C433EF;
        Thu, 22 Dec 2022 16:04:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671725055;
        bh=hrjYdujnbJG4kdVSR5oN2+Zy91kENom+NYLTQlqqONQ=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=fu1VQkaskbCaFdFvEwUN1PAN8rvRCvO9fMbdkvyMYD4RjbjBCn3+lIKZ+ejHjxKRb
         azkppfuOta9AkVpVWTOz2uxUDgIdpV9CULiR72Eq+xZ9cumgnuob/pXip7Frb5c1BM
         ByQycHhoPIqNs01N9Tv2Jz+KzwM7hwfDsyp2HoPjftaXf4QXAreXs1NLQn3cP/08na
         kSbPYGOvi+ETsyGXYUUwnaF2Kqj7UeZdzZVudbwLmD0+q8H+QQVPsyjO6BkKU8oCJZ
         BBtKun0bg7KSOi62IF0CbpnseQM+wIjCdCtXtqd/Sb9JqHj0Mc8D0FQKNh3Cfbwmrk
         xvGnTRgCsAb0Q==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2] wifi: ipw2x00: don't call dev_kfree_skb() under
 spin_lock_irqsave()
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20221208143826.2385218-1-yangyingliang@huawei.com>
References: <20221208143826.2385218-1-yangyingliang@huawei.com>
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     <stas.yakovlev@gmail.com>, <linux-wireless@vger.kernel.org>,
        <yangyingliang@huawei.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <167172505228.8231.3608734087606438304.kvalo@kernel.org>
Date:   Thu, 22 Dec 2022 16:04:14 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Yang Yingliang <yangyingliang@huawei.com> wrote:

> It is not allowed to call kfree_skb() or consume_skb() from hardware
> interrupt context or with hardware interrupts being disabled.
> 
> It should use dev_kfree_skb_irq() or dev_consume_skb_irq() instead.
> The difference between them is free reason, dev_kfree_skb_irq() means
> the SKB is dropped in error and dev_consume_skb_irq() means the SKB
> is consumed in normal.
> 
> In this case, dev_kfree_skb() is called to free and drop the SKB when
> it's reset, so replace it with dev_kfree_skb_irq(). Compile tested
> only.
> 
> Fixes: 43f66a6ce8da ("Add ipw2200 wireless driver.")
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>

Patch applied to wireless-next.git, thanks.

45fc6d7461f1 wifi: ipw2x00: don't call dev_kfree_skb() under spin_lock_irqsave()

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20221208143826.2385218-1-yangyingliang@huawei.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

