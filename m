Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5BC57E5CFA
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Nov 2023 19:13:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbjKHSNz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 8 Nov 2023 13:13:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjKHSNx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 8 Nov 2023 13:13:53 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 410891FEE
        for <linux-wireless@vger.kernel.org>; Wed,  8 Nov 2023 10:13:51 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29E48C433C7;
        Wed,  8 Nov 2023 18:13:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699467230;
        bh=QEosC7zDq8NrzLBB+Sc0+MIn6qzh9laKqIyMsdoEGJ8=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=CIomZPj7ehjBPM0Vd5/HfyEkt5gOIVXeYY5PBrPHDF6DGi5i3USeagrM8u4aX8Ypq
         dPzaKBC47Zqk6S6CnPn3LtjKjcTLdF/I9oPTGAtVXTou1w6neDmSQp+HgQIc+n+zWX
         BIzmvnfUHQwDtCJRz4EFzvvlWtleWzZu384pUg0g3Wcgfz5UNaxfI/CCODTbfavmdg
         V/Om5ZPmoyVpppKqKSq3kIDKxhdz3sC08bFhxD+XDnbnxFv29dygC6u7to/5RUbnPj
         RNShbUnGdPXz3j9Rfh9KO/evTjUB9ZSQ0BWczdEcti639lWyHnCvUVA8PvNm7+ZmDQ
         CNznc5zcvQ/1w==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: rtw88: fix RX filter in FIF_ALLMULTI flag
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20231103020851.102238-1-pkshih@realtek.com>
References: <20231103020851.102238-1-pkshih@realtek.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <gary.chang@realtek.com>, <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169946722828.2821494.12296317001185368066.kvalo@kernel.org>
Date:   Wed,  8 Nov 2023 18:13:49 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> wrote:

> From: Chih-Kang Chang <gary.chang@realtek.com>
> 
> The broadcast packets will be filtered in the FIF_ALLMULTI flag in
> the original code, which causes beacon packets to be filtered out
> and disconnection. Therefore, we fix it.
> 
> Fixes: e3037485c68e ("rtw88: new Realtek 802.11ac driver")
> Signed-off-by: Chih-Kang Chang <gary.chang@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

Patch applied to wireless-next.git, thanks.

53ee0b3b99ed wifi: rtw88: fix RX filter in FIF_ALLMULTI flag

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20231103020851.102238-1-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

