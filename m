Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39BF046CF20
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Dec 2021 09:34:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244985AbhLHIiQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 8 Dec 2021 03:38:16 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:47734 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244979AbhLHIhz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 8 Dec 2021 03:37:55 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id A340DCE2034
        for <linux-wireless@vger.kernel.org>; Wed,  8 Dec 2021 08:34:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B11A9C00446;
        Wed,  8 Dec 2021 08:34:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638952460;
        bh=K7uDAbw+b8HgvAJI1RQOymvhNbtlelntHf5F3LizyRA=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=jIK9jdKz9o+OUyAYuqtSDt0YFk7+fYQxBdhCiuGo2/IG5eEWh15iO7oNwiJeDFU7+
         kDdS01ls+ukT8jLbHOeEZ60+GdPjjPk1UYC22JKs456xiV3Aceok7XW2rW88sEhfbo
         MBzcPKyFk2rYZED9fdr2E7ik/+KPPzbakAXXbtmUqR2CkylZugiC1L/iN9B3QVeKqf
         zgBAiYI+inXycs6mewsJNOFBOuf5iD9D/AtXku0PfgtgVezY8BbhSRSB/TP45/C3YD
         9lawKM1yJI3nPJcWedlZyJrEEUPg0A9zCObZarvTO6kkb62FW88RTFWbXGsV+ACRmS
         3wbx+XyV/rKJg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wcn36xx: Fix max channels retrieval
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <1638435732-14657-1-git-send-email-loic.poulain@linaro.org>
References: <1638435732-14657-1-git-send-email-loic.poulain@linaro.org>
To:     Loic Poulain <loic.poulain@linaro.org>
Cc:     kvalo@codeaurora.org, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org,
        Loic Poulain <loic.poulain@linaro.org>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <163895245805.29041.12821453158667159636.kvalo@kernel.org>
Date:   Wed,  8 Dec 2021 08:34:19 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Loic Poulain <loic.poulain@linaro.org> wrote:

> Kernel test robot reported:drivers/net/wireless/ath/wcn36xx/smd.c:943:33:
>    sparse: sparse: cast truncates bits from constant value (780 becomes 80)
> 
> The 'channels' field is not a simple u8 array but an array of
> channel_params. Using sizeof for retrieving the max number of
> channels is then wrong.
> 
> In practice, it was not an issue, because the sizeof returned
> value is 780, which is truncated in min_t (u8) to 80, which is
> the value we expect...
> 
> Fix that properly using ARRAY_SIZE instead of sizeof.
> 
> Fixes: d707f812bb05 ("wcn36xx: Channel list update before hardware scan")
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Loic Poulain <loic.poulain@linaro.org>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

09cab4308bf9 wcn36xx: Fix max channels retrieval

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/1638435732-14657-1-git-send-email-loic.poulain@linaro.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

