Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FC5B4B5937
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Feb 2022 18:59:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236322AbiBNR7Y (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 14 Feb 2022 12:59:24 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357294AbiBNR7X (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 14 Feb 2022 12:59:23 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CF96652C4
        for <linux-wireless@vger.kernel.org>; Mon, 14 Feb 2022 09:59:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0F07BB80F99
        for <linux-wireless@vger.kernel.org>; Mon, 14 Feb 2022 17:59:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9468CC340E9;
        Mon, 14 Feb 2022 17:59:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644861552;
        bh=l8ZiU9lZ98STb6H5WOKdz2pVDFHNBgjIAd179NzFaLw=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=pzp8QqLuHWxt2OAPJIiIDML8Fs1+4hjaduPRfXZ8LzsUzzUv6VBCeUlO3FaJWVRC2
         4TqfxryPyJf/rCscGM6A0rw0ldAGWHeGsDtjbzFXs4iC36RwbSCHy9DE5+1qwBSb1v
         dto1DTlvSjtv2mKqyKziIkW2RkABjYju+OdRC470b68MEHlGge4nzCKMbJPbSpOdqE
         Etz6ryEqmhwCmtcYJasWu2PAtmszMk9cLqzNxNmvQjRdBFOWAeEUcIIxE1U90mg7U4
         O1rzeGqtW+fHJmyA+9RcknsPGgWJ2kGdQawRn6wAWsiWBDFehUmBgTtSkNa9GigPbS
         7WVyoIUpn4KWw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 2/6] rtw88: coex: Improve WL throughput when HFP COEX
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20220211071533.34716-3-pkshih@realtek.com>
References: <20220211071533.34716-3-pkshih@realtek.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <tony0620emma@gmail.com>, <linux-wireless@vger.kernel.org>,
        <timlee@realtek.com>, <ku920601@realtek.com>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <164486154882.6494.2693768453382904665.kvalo@kernel.org>
Date:   Mon, 14 Feb 2022 17:59:11 +0000 (UTC)
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> wrote:

> From: Ching-Te Ku <ku920601@realtek.com>
> 
> Disable power save TDMA mechanism under HFP COEX, so WL can TRx full time.
> 
> Signed-off-by: Ching-Te Ku <ku920601@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

What's WL and TRx?

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20220211071533.34716-3-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

