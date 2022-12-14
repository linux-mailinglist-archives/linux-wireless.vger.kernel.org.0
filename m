Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02ECC64C90B
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Dec 2022 13:29:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238304AbiLNM3V (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 14 Dec 2022 07:29:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238340AbiLNM2z (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 14 Dec 2022 07:28:55 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E27DB28E0E
        for <linux-wireless@vger.kernel.org>; Wed, 14 Dec 2022 04:25:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id B9FFFCE1916
        for <linux-wireless@vger.kernel.org>; Wed, 14 Dec 2022 12:25:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A10AC433EF;
        Wed, 14 Dec 2022 12:25:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671020752;
        bh=OZCFLt8i3CSiG7B43dO5ess0QbVwV85pnPp23s/rF1g=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=N/dyHsvWhAyfYf72qz/HnD21ibIZdUMdItxBcFfVrt/eKFPenQAsHPu8a42/otmuo
         YgVTAF/ODWuhF7CpYuQ4vyg33Mt9CkBYrHMqhI7sPEY0+74Cn5fC0cnGTLVjqAA4cg
         zMogT00lR4Dtr9NkbdnPHG3q7iiPtslNEqWa6gJU3wbUPG9wKcxHyV3CCdw2N0FXis
         wPrx/BooiOsWjcGKjCdOU2RTa85WMb+1i+8ygXgjZJSs5dLyHc2HipOYuTspkvhWoA
         tc6Ne+S/y5CUxBneSxDhXWJKYEPzfRpQAM+1XfzsVCrLlM3XcVc/FOElEUjf0xW7ma
         WhBBgVnqfDyTw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: rtw89: fw: adapt to new firmware format of security
 section
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20221209012215.7342-1-pkshih@realtek.com>
References: <20221209012215.7342-1-pkshih@realtek.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <167102074961.7997.9899989038956204219.kvalo@kernel.org>
Date:   Wed, 14 Dec 2022 12:25:51 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> wrote:

> Normally, system image should ensure firmware integrity, but we provide
> an advance feature to ensure this by security section along with firmware.
> To enable this feature, custom ID is programmed into efuse, and driver
> will download proper security section to firmware.
> 
> Since I don't have this kind hardware modules on hand yet, but new format
> is used by newer firmware. Therefore, I prepare this patch in advance to
> consider size of security section as a factor of checking rule of firmware
> size, but don't actually download security section to firmware.
> 
> This patch is backward compatible, so it will be safe to have this change
> before adding an new format firmware to linux-firmware repository.
> 
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

Patch applied to wireless-next.git, thanks.

18ddf102d4b8 wifi: rtw89: fw: adapt to new firmware format of security section

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20221209012215.7342-1-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

