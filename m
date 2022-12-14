Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BA3B64C905
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Dec 2022 13:27:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237912AbiLNM1g (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 14 Dec 2022 07:27:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238327AbiLNM1M (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 14 Dec 2022 07:27:12 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D59EC5E
        for <linux-wireless@vger.kernel.org>; Wed, 14 Dec 2022 04:23:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 8F5A5CE1867
        for <linux-wireless@vger.kernel.org>; Wed, 14 Dec 2022 12:23:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1931C433D2;
        Wed, 14 Dec 2022 12:23:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671020619;
        bh=sIl/JCq+O0fFRHqKyakkpnsW4D89TGFf9d8pIX64nig=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=HRshy/Vi4YFqw2L7AXV7/3AgCd+sj7A4mLQKIx/+ORBgSizacuR4VL6HWsoOz/o2N
         iBA7PALy6V3cv15kE1BmlRmjo+Rv47V4fzKlpSGR4d4ka7/hdV1GMIRXAkEcdXzKpA
         cGXCsBE9XA3CASmucZ6xT93aBDoKTqksZoiylIKI/mZPaIZfmIUJmeWuEpObQURmO8
         b7hri8Q+BQm2gAcjQo8qdOAG0HpVYTU38WgwC6sbI/g1oN7H0aPWaHbOdoMDu/zm2Z
         2nxLAJGHlBFMzMxcc3SKoMAOJxKvWsSfaeFhriu8g/JbLHKET5Bw82QwL5njAjyvoX
         N2p95X79W+HSQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2] wifi: rtl8xxxu: don't call dev_kfree_skb() under
 spin_lock_irqsave()
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20221208143517.2383424-1-yangyingliang@huawei.com>
References: <20221208143517.2383424-1-yangyingliang@huawei.com>
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     <Jes.Sorensen@gmail.com>, <pkshih@realtek.com>,
        <linux-wireless@vger.kernel.org>, <yangyingliang@huawei.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <167102061678.7997.5606872513286042862.kvalo@kernel.org>
Date:   Wed, 14 Dec 2022 12:23:38 +0000 (UTC)
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
> it's shutdown, so replace it with dev_kfree_skb_irq(). Compile tested
> only.
> 
> Fixes: 26f1fad29ad9 ("New driver: rtl8xxxu (mac80211)")
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> Reviewed-by: Ping-Ke Shih <pkshih@realtek.com>

Patch applied to wireless-next.git, thanks.

4c2005ac8768 wifi: rtl8xxxu: don't call dev_kfree_skb() under spin_lock_irqsave()

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20221208143517.2383424-1-yangyingliang@huawei.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

