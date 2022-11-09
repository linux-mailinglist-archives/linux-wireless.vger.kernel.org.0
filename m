Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9471622450
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Nov 2022 08:01:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbiKIHBJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 9 Nov 2022 02:01:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbiKIHBI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 9 Nov 2022 02:01:08 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2186663B1
        for <linux-wireless@vger.kernel.org>; Tue,  8 Nov 2022 23:01:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B3844618CD
        for <linux-wireless@vger.kernel.org>; Wed,  9 Nov 2022 07:01:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89950C433C1;
        Wed,  9 Nov 2022 07:01:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667977265;
        bh=IoFJ2E7NZkc7U7TYBpbz+tb+o8mpqRW/zCmCsG6TNLw=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=Jaq7rHS9WjJCEwCeW7rmDQHphlXjmjCkmgwu/twZ1EaikF5WRf23fMcr+JQS0S6+w
         Gv1+tMwPW+g+QoH9WH8G0k58tBIpktUfBb87SfKtA2rwjt2ulT9Lv+VuO0GaRHoJ6R
         4NSRjNgjp2YM4gkvAG6B1/F9xku09rCQmlC5mfFZzIjfelTktA78qlc6SzEGc+g9xD
         O2WV3XVFlpEL8r0He83eVgdUq3pQhCR0hpEoNneotL87T6arSq+RpmqUHOmkf+vnYe
         OZpLFJ/AQJlldXjDMxRhpXs8gw9T6rmxoW9ckRmTYeqGh12pgMeKq7MXrS7C+YxLoJ
         DWFKSaNAXx0Tg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2] wifi: rtw89: use u32_encode_bits() to fill MAC quota
 value
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20221108013858.10806-1-pkshih@realtek.com>
References: <20221108013858.10806-1-pkshih@realtek.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <166797725268.32472.8691659349990605066.kvalo@kernel.org>
Date:   Wed,  9 Nov 2022 07:01:04 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> wrote:

> Coverity reported shift 16 bits could cause sign extension and might get
> an unexpected value. Since the input values are predefined and no this
> kind of case, original code is safe so far. But, still changing them to
> use u32_encode_bits() will be more clear and prevent mistakes in the
> future.
> 
> The original message of Coverity is:
>   Suspicious implicit sign extension: "max_cfg->cma0_dma" with type "u16"
>   (16 bits, unsigned) is promoted in "max_cfg->cma0_dma << 16" to type
>   "int" (32 bits, signed), then sign-extended to type "unsigned long"
>   (64 bits, unsigned).  If "max_cfg->cma0_dma << 16" is greater than
>   0x7FFFFFFF, the upper bits of the result will all be 1."
> 
> Reported-by: coverity-bot <keescook+coverity-bot@chromium.org>
> Addresses-Coverity-ID: 1527095 ("Integer handling issues")
> Fixes: e3ec7017f6a2 ("rtw89: add Realtek 802.11ax driver")
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

Patch applied to wireless-next.git, thanks.

525c06c81d75 wifi: rtw89: use u32_encode_bits() to fill MAC quota value

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20221108013858.10806-1-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

