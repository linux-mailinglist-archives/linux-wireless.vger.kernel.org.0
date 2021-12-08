Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06AC046D051
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Dec 2021 10:49:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbhLHJw3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 8 Dec 2021 04:52:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbhLHJw0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 8 Dec 2021 04:52:26 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE8E2C061746
        for <linux-wireless@vger.kernel.org>; Wed,  8 Dec 2021 01:48:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 83696B81FEF
        for <linux-wireless@vger.kernel.org>; Wed,  8 Dec 2021 09:48:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05F78C00446;
        Wed,  8 Dec 2021 09:48:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638956932;
        bh=XHcDxJiV3Kg/Mwj39DHnaFrw/vR6P0Z7HjIW/2ngatw=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=hDaWjZwyg8eyJGxbHOeditX6AljVyoUzbXoyC+5OAo5Tc2ki+Dhiefh01ZWXEcxev
         LCxkuv5WE7KY8u7FlskvHPyc/MuT7p3UL6srXTVgxEU45HhDtleTOwVkKxJfPHCue7
         P6NSkzzIcQ8scN+RLm1hSZ1ApWUZ+rogIxtLA/f2xnNTAMgw+Z9yWmMeNVIzEN3uiE
         vrtawyu3gm8ZjYTv+f5GeNNEL5kr+DnXt1Rsd0ZtAMVf8JYBzIxjdzS1WarKI0Luu/
         X8eXeyjfKycpAj5y7iCs5oQsOJTjD/IrexJAGf8l5gHC5iVRujZnKFHK+Q8qdErcQe
         s8R1HWaZHf2rQ==
From:   Kalle Valo <kvalo@kernel.org>
To:     Sven Eckelmann <sven@narfation.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Wen Gong <quic_wgong@quicinc.com>
Subject: Re: [PATCH] ath11k: enable IEEE80211_HW_SINGLE_SCAN_ON_ALL_BANDS for WCN6855
References: <20211129101309.2931-1-quic_wgong@quicinc.com>
        <163895135713.29041.4980786229647025244.kvalo@kernel.org>
        <463b4075-e98f-d51a-d305-a7adadc8a585@quicinc.com>
        <2239044.ZpX2dJDJjJ@ripper>
Date:   Wed, 08 Dec 2021 11:48:45 +0200
In-Reply-To: <2239044.ZpX2dJDJjJ@ripper> (Sven Eckelmann's message of "Wed, 08
        Dec 2021 10:12:59 +0100")
Message-ID: <87lf0vfmv6.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Sven Eckelmann <sven@narfation.org> writes:

> On Wednesday, 8 December 2021 09:19:28 CET Wen Gong wrote:
>> On 12/8/2021 4:16 PM, Kalle Valo wrote:
>> > Wen Gong <quic_wgong@quicinc.com> wrote:
>> ...
>> > Sven, after your memory corruption fix is this good to take?
>> 
>> After Sven's fix "ath11k: Fix buffer overflow when scanning with 
>> extraie", it will not happen kernel crash.
>> 
>> But it need Sven's confirm.
>
> Correct, it is not causing any problems anymore when the other fix was applied 
> before this change.
>
> Tested-by: Sven Eckelmann <sven@narfation.org>

Very good, thanks. I included your Tested-by.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
