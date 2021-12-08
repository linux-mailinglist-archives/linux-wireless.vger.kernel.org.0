Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0D6D46D740
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Dec 2021 16:44:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233885AbhLHPsO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 8 Dec 2021 10:48:14 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:46372 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233650AbhLHPsN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 8 Dec 2021 10:48:13 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 10D8EB82138
        for <linux-wireless@vger.kernel.org>; Wed,  8 Dec 2021 15:44:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4C50C341CA;
        Wed,  8 Dec 2021 15:44:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638978279;
        bh=8ywbSsmMTnCb0bYAOFTzp+UZJcVTRDUeHz5n/MuFm34=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=KHDiUPKiWOLM55/3Yw8e4cELX/ius5cnT4xTYfUYv8s2t5BL9tp7WMc4eJgVt+137
         3oAUQGeMzVe8+EeXIUo16JceG7hUa1vnrENIH3i9BfSnn4tRPbNUUPlVnR+7hYxUYm
         q9wdILgXIYNzx5bNmE98ZHV9BQ0Q8WsNsha53JO1LvHjgZ+XW/LtP3TAj2eRPKyl88
         yOyuOJ9Oh7/QUAOfJDv8+LXPrvjBwAJnILpRt1B/AzAfDUdZ7oX8Wla21X7pdnULfY
         LoB/xovXZ2PLPyNiYOMe8Sr2AMnbKyohVVUIMlKzLU6nt6Ly+8MhWFeq2HsJ13PEG4
         OZWgXYoQX5wVw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath11k: Add HE UL MU fixed rate setting
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <1627597558-25144-1-git-send-email-msinada@codeaurora.org>
References: <1627597558-25144-1-git-send-email-msinada@codeaurora.org>
To:     Muna Sinada <msinada@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Muna Sinada <msinada@codeaurora.org>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <163897827714.29276.8873042028382760166.kvalo@kernel.org>
Date:   Wed,  8 Dec 2021 15:44:38 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Muna Sinada <msinada@codeaurora.org> wrote:

> This patch adds ath11k support for setting HE UL MU fixed rate.
> HE UL MU fixed rate is informed to HE STA by HE Basic Trigger frame.
> The added code is reusing parts of the existing code path used for
> HE fixed rate.
> 
> Utilizing iw command, HE UL MU fixed rate can be set:
> 	iw dev wlanX set bitrates he-ul-mcs-<5/2.4> <NSS:MCS>
> 
> 	Example: iw dev wlan0 set bitrates he-ul-mcs-5 2:5
> 
> Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.4.0.1-00356-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Muna Sinada <msinada@codeaurora.org>

Doesn't apply anymore, please rebase.

error: patch failed: drivers/net/wireless/ath/ath11k/mac.c:6029
error: drivers/net/wireless/ath/ath11k/mac.c: patch does not apply
error: patch failed: drivers/net/wireless/ath/ath11k/wmi.h:1047
error: drivers/net/wireless/ath/ath11k/wmi.h: patch does not apply
stg import: Diff does not apply cleanly

Patch set to Changes Requested.

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/1627597558-25144-1-git-send-email-msinada@codeaurora.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

