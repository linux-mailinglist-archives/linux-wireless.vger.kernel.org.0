Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D4716544FD
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Dec 2022 17:18:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235149AbiLVQSA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 22 Dec 2022 11:18:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbiLVQR6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 22 Dec 2022 11:17:58 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EE212228B
        for <linux-wireless@vger.kernel.org>; Thu, 22 Dec 2022 08:17:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4E774B802C7
        for <linux-wireless@vger.kernel.org>; Thu, 22 Dec 2022 16:17:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34CAAC433D2;
        Thu, 22 Dec 2022 16:17:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671725874;
        bh=QCms9H0ToEeePecTBPF4EKUW5Q9CaBl7VGTx7ekYma4=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=huV/1uhkGEQ8foO5E1lozmmgDihohsXFNLUgEF52tgoJ5IYTr8GrSk/yi7fXrMsJ/
         bKgfSB60vRKdX4MnMLbUOPw/H32hl4xLibz3oU+BVqvrMO1NMap4BD3O3Lk9lsX/Rd
         JMK/RQLpDT1wWOcA36FlH1TaCxu/P2KLFLnVN4Qs9tlu+cJLkGLGjWjh4X4jz/lnq/
         Gt/FndB3ZfVQIeuj0624euJkrx0uVrn5txhwtsFXm9HpFNub8GgfGiyim2pQGIJ3W1
         WlZGTAifGuBXm82rF8xJZ/TzV1Q5kiYaNKBww2RUqpblT62FtYbni9C2HVXYdKs3Zg
         NVwmNqJKr8GiA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [v2] wifi: wl3501_cs: don't call kfree_skb() under
 spin_lock_irqsave()
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20221207150453.114742-1-yangyingliang@huawei.com>
References: <20221207150453.114742-1-yangyingliang@huawei.com>
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     <linux-wireless@vger.kernel.org>, <yangyingliang@huawei.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <167172587248.8231.1000881782979758530.kvalo@kernel.org>
Date:   Thu, 22 Dec 2022 16:17:54 +0000 (UTC)
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
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>

Patch applied to wireless-next.git, thanks.

44bacbdf9066 wifi: wl3501_cs: don't call kfree_skb() under spin_lock_irqsave()

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20221207150453.114742-1-yangyingliang@huawei.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

