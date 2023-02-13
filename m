Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 168D3694DB0
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Feb 2023 18:06:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230243AbjBMRG3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 Feb 2023 12:06:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230236AbjBMRG2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 Feb 2023 12:06:28 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B0A81E5F6
        for <linux-wireless@vger.kernel.org>; Mon, 13 Feb 2023 09:06:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AA24A611B4
        for <linux-wireless@vger.kernel.org>; Mon, 13 Feb 2023 17:06:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CE21C433D2;
        Mon, 13 Feb 2023 17:06:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676307987;
        bh=40pJoKgCY3VvIRKRPAYP6xqpb+RplKBWTsZFEuemD68=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=pyXDyVc7I0YXmtrLPMN8YdurtM8/BZspKxHL5M/qCxp/VR85B6x+/9dbkZVGW5RjT
         R+Jav028EjNn21fFZ4qsOaN/4RfEFL4c5+/ScCpEEgocLpI/Z5UJ159HYdXTwtOd0R
         xAsaNBRy/5vxf7SZYP5WYvxDjt4Ld6jknZ3j3UjY0RMDHvHL61vvYYd5O76U9CS7nC
         u2uj3NzOQpv4uFbHQNzFGP6PvVrOez7CA39lYp9OFuYDKhs6ga7jbh+3pETzPIKa7X
         nkiGoHVt995ITn8ZU7Wwrcos1/RidgBZsr36+fuPWLOVN+G3z9wC88HPGsYr4Qh7wR
         8VlcPA+PB761Q==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/2] wifi: rtw89: fix parsing offset for MCC C2H
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230119064342.65391-1-pkshih@realtek.com>
References: <20230119064342.65391-1-pkshih@realtek.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <kevin_yang@realtek.com>, <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <167630798450.12830.10828357074770660188.kvalo@kernel.org>
Date:   Mon, 13 Feb 2023 17:06:26 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> wrote:

> From: Zong-Zhe Yang <kevin_yang@realtek.com>
> 
> A 8-byte offset is missed during parsing C2Hs (chip to host packets)
> of MCC (multi-channel concurrent) series.
> So, we fix it.
> 
> Fixes: ef9dff4cb491 ("wifi: rtw89: mac: process MCC related C2H")
> Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

2 patches applied to wireless-next.git, thanks.

24d72944d79e wifi: rtw89: fix parsing offset for MCC C2H
214a98b151b1 wifi: rtw89: refine MCC C2H debug logs

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230119064342.65391-1-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

