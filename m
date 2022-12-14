Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA4B664C8F1
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Dec 2022 13:24:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238457AbiLNMX6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 14 Dec 2022 07:23:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238275AbiLNMXh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 14 Dec 2022 07:23:37 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4CBA286FD
        for <linux-wireless@vger.kernel.org>; Wed, 14 Dec 2022 04:20:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 357E9619F3
        for <linux-wireless@vger.kernel.org>; Wed, 14 Dec 2022 12:20:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF3B2C433D2;
        Wed, 14 Dec 2022 12:20:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671020454;
        bh=FIbizz3j4Isj8O3HMtFWrcONWJGGZ0kuFae3I8pYgP4=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=u2SYoj6n0Bv5mBAPZ6DmGM9KyNlYGlwwMb+ggEgWiHRL4N9eTqxQ0Pk4aQrFqlV6r
         6W9ZlQnSavLlACmh5Ux/oljW6qpZBzPBW7xtyaxFGKoJVINZ8ATNsgN6y0n8JI5Att
         rWHvuh9sDRmqjidnsn8L7Xz3DF3meE2Sq//N81guGZeZ6dFNyEHBKO8LHk8Jstuy/P
         geDt7vPYl07pQdKxjHrTBrCnSl/l0BHjCu/l9gLyazx4QYUnN7qLSu1VVhcMRkAza5
         bKc1ZoG146Wnr2j6ZdIssSg8dAmFpPZKkoXYLhmEuODkLj56w2MYdDpyI2gg2TxMgO
         gvKPMwg9yQCfw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3 1/3] wifi: rtlwifi: rtl8821ae: don't call kfree_skb()
 under
 spin_lock_irqsave()
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20221207141411.46098-2-yangyingliang@huawei.com>
References: <20221207141411.46098-2-yangyingliang@huawei.com>
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     <pkshih@realtek.com>, <linux-wireless@vger.kernel.org>,
        <yangyingliang@huawei.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <167102045149.7997.14610961603029156010.kvalo@kernel.org>
Date:   Wed, 14 Dec 2022 12:20:53 +0000 (UTC)
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
> context or with interrupts being disabled. All the SKBs have
> been dequeued from the old queue, so it's safe to enqueue these
> SKBs to a free queue, then free them after spin_unlock_irqrestore()
> at once. Compile tested only.
> 
> Fixes: 5c99f04fec93 ("rtlwifi: rtl8723be: Update driver to match Realtek release of 06/28/14")
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> Acked-by: Ping-Ke Shih <pkshih@realtek.com>

3 patches applied to wireless-next.git, thanks.

106031c1f4a8 wifi: rtlwifi: rtl8821ae: don't call kfree_skb() under spin_lock_irqsave()
2611687fa7ff wifi: rtlwifi: rtl8188ee: don't call kfree_skb() under spin_lock_irqsave()
313950c2114e wifi: rtlwifi: rtl8723be: don't call kfree_skb() under spin_lock_irqsave()

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20221207141411.46098-2-yangyingliang@huawei.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

