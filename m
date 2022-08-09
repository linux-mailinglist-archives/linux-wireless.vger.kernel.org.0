Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D89DE58D376
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Aug 2022 08:00:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235135AbiHIGAN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 9 Aug 2022 02:00:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234583AbiHIGAG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 9 Aug 2022 02:00:06 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D219C1F614
        for <linux-wireless@vger.kernel.org>; Mon,  8 Aug 2022 23:00:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8B8E2B81071
        for <linux-wireless@vger.kernel.org>; Tue,  9 Aug 2022 06:00:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2EEBC433D6;
        Tue,  9 Aug 2022 06:00:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660024803;
        bh=e04cgMv3jq2XN98bllzzP5Geh38BzRMDNIYAw80RZyA=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=MtkXZpKPFeDBgvuA3D2s8uBVit79rRlD1lmXRCWd57a//S8jYOx9p4WZ8ylFfnfYx
         +1awtoyJ3SdSr4h9TqGRIeobmgxM0WAE0B/yiJ0WXWG3ZWwyDQuyWtiFNLYhTzmpP8
         Il87q9vDCdMCYX2SPMKFtNjv29SWE8leRuvrg5cGmq3Fnt3UdkAMZ57EGHpZppSBNE
         FA2b+UhXNcJHfklzdWjdBoSrX8jA4cDputRbQLGu11ECtOfsA99GYUlSYdYzyRwnnZ
         0pVYIi0gev0WdOCgx2hW/YIGxBOU6CHHXU1Rofy0tVy61dXPraWkaXCqY4as2NFAfN
         yp4YoO30YRKYw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3] wifi: rtlwifi: 8192de: correct checking of IQK reload
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20220801113345.42016-1-pkshih@realtek.com>
References: <20220801113345.42016-1-pkshih@realtek.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <166002480066.8958.6976882122569958583.kvalo@kernel.org>
Date:   Tue,  9 Aug 2022 06:00:02 +0000 (UTC)
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> wrote:

> Since IQK could spend time, we make a cache of IQK result matrix that looks
> like iqk_matrix[channel_idx].val[x][y], and we can reload the matrix if we
> have made a cache. To determine a cache is made, we check
> iqk_matrix[channel_idx].val[0][0].
> 
> The initial commit 7274a8c22980 ("rtlwifi: rtl8192de: Merge phy routines")
> make a mistake that checks incorrect iqk_matrix[channel_idx].val[0] that
> is always true, and this mistake is found by commit ee3db469dd31
> ("wifi: rtlwifi: remove always-true condition pointed out by GCC 12"), so
> I recall the vendor driver to find fix and apply the correctness.
> 
> Fixes: 7274a8c22980 ("rtlwifi: rtl8192de: Merge phy routines")
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

Patch applied to wireless-next.git, thanks.

93fbc1ebd978 wifi: rtlwifi: 8192de: correct checking of IQK reload

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20220801113345.42016-1-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

