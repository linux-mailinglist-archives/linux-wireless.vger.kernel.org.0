Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B50DC49FD3E
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Jan 2022 16:57:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349746AbiA1P5f (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 28 Jan 2022 10:57:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349744AbiA1P5e (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 28 Jan 2022 10:57:34 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9736AC061747
        for <linux-wireless@vger.kernel.org>; Fri, 28 Jan 2022 07:57:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2D73A61E80
        for <linux-wireless@vger.kernel.org>; Fri, 28 Jan 2022 15:57:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D491AC340E0;
        Fri, 28 Jan 2022 15:57:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643385453;
        bh=P6uHNkEIrUWBykKbaZsab6WZUiLv+elhHNrg1UnsGxA=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=qmLIgI0bH4gGxEQDBIL/P988gj94YffG18X8IfsQVlmskdRLHUkHZ2JF4Vor9Deht
         Kql7T5TpGGX13xMGKRxqedlYrliIxdt6lhAaVZ7JMTL6BsiInPMoBvPyM0gRJARpeO
         dJphgZDD5jNG5GVfZycYGjFrEb4RcUrBV3NZDEeefWAIUEq08WlJMrVKUYIfNRJXAP
         VPMmj41bOSJKIwxD2Qd5byeyZ7FR8kSdhRZ+Us5bmb08eQ4QjQV73u8F8pJidNU1Gh
         g4BaDtRTwjroIWHaXL1uBDT4fkgxNkA4l88I537vMA8nsyXlNgHk3dYrRQwrR998II
         zy2y3TrA+CTlA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/2] rtw89: handle 6G band if supported by a chipset
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20220113011042.6705-1-pkshih@realtek.com>
References: <20220113011042.6705-1-pkshih@realtek.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <linux-wireless@vger.kernel.org>, <kevin_yang@realtek.com>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <164338545118.19531.3845805429572925107.kvalo@kernel.org>
Date:   Fri, 28 Jan 2022 15:57:32 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> wrote:

> From: Zong-Zhe Yang <kevin_yang@realtek.com>
> 
> For next chipset which can support 6G band, we add the handling
> of ieee80211_supported_band for 6G band in advance. And a bitmap,
> support_bands, is added to rtw89_chip_info to declare which
> NL80211_BAND_* are supported. With the chipset's declaration,
> we register the corresponding instances of ieee80211_supported_band
> with wiphy.
> 
> Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

2 patches applied to wireless-next.git, thanks.

0237f65aa65c rtw89: handle 6G band if supported by a chipset
e0925375b2c6 rtw89: include subband type in channel params

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20220113011042.6705-1-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

