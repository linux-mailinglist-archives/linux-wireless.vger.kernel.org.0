Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A5C664C8F6
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Dec 2022 13:24:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238358AbiLNMYo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 14 Dec 2022 07:24:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238117AbiLNMYV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 14 Dec 2022 07:24:21 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00BE926AD0
        for <linux-wireless@vger.kernel.org>; Wed, 14 Dec 2022 04:21:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 1E06BCE1867
        for <linux-wireless@vger.kernel.org>; Wed, 14 Dec 2022 12:21:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42AE6C433EF;
        Wed, 14 Dec 2022 12:21:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671020494;
        bh=a5ReCZw6A9g0RhWDRWu/w5e3rqlfxW02iE6V7iVb1X0=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=L3PkEXwoJcydCVOIARyxPlHVNwO+RBOWVEA4D7wAmhrdRaERG9bujQY2t9WlCYNnb
         38+KBkQvtlggvUWEeerbuJQ2sphsgZyVSKkC53/8Bojq1TzkZJBnWRVRa/2/+bTdv3
         M8qiAS+plAlbjZQgWzLpmyF3NOy1igAdhRbJ73DXQKBi7tcSX7CwqIghg+AFw055Zy
         VzAsd+5gNa7j7cacFHncTF/I6lT46yGq+JNSrqxWNCua2vKO9cwbHyunTRaIaYINAP
         9YEmZRx5/1QdD40BLMeZ+6Hmx5wX+ezp/ztQ28Cs5BOfv4zLI5jJU2Z8zx87ObBfS0
         /x0GX5VYLLaJg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: iwlegacy: common: don't call dev_kfree_skb() under
 spin_lock_irqsave()
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20221207144013.70210-1-yangyingliang@huawei.com>
References: <20221207144013.70210-1-yangyingliang@huawei.com>
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     <stf_xl@wp.pl>, <linux-wireless@vger.kernel.org>,
        <yangyingliang@huawei.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <167102049109.7997.1710189431829876997.kvalo@kernel.org>
Date:   Wed, 14 Dec 2022 12:21:33 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Yang Yingliang <yangyingliang@huawei.com> wrote:

> It is not allowed to call consume_skb() from hardware interrupt context
> or with interrupts being disabled. So replace dev_kfree_skb() with
> dev_consume_skb_irq() under spin_lock_irqsave(). Compile tested only.
> 
> Fixes: 4bc85c1324aa ("Revert "iwlwifi: split the drivers for agn and legacy devices 3945/4965"")
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> Acked-by: Stanislaw Gruszka <stf_xl@wp.pl>

Patch applied to wireless-next.git, thanks.

0c1528675d7a wifi: iwlegacy: common: don't call dev_kfree_skb() under spin_lock_irqsave()

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20221207144013.70210-1-yangyingliang@huawei.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

