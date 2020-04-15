Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 378EF1A956F
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Apr 2020 10:02:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393772AbgDOICP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 15 Apr 2020 04:02:15 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:57483 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2393790AbgDOICG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 15 Apr 2020 04:02:06 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1586937726; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=ldv6L5av6BkoxlD+BIbdpgzjFbgm7PC0DXh6OBoGNDM=;
 b=SIIWhs8xqshzbwkBbmlyRZ73jVLgItefmrNuqzyK1dX8JAfex1bsuHYiGNYP+RulFsNdBEKA
 5FcbLbBXjfv+ALsyoHK/VXY63ShIjFF8w4Zmk6M3gxS/wuDGhUjcAsZ5cnwzKdxnASuR/b2U
 vju1UGzMornXPw4jep2Ku5KUat4=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e96bf3e.7f70bd7bd928-smtp-out-n04;
 Wed, 15 Apr 2020 08:01:02 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 6DD54C432C2; Wed, 15 Apr 2020 08:01:02 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2A8ADC433BA;
        Wed, 15 Apr 2020 08:01:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2A8ADC433BA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath11k: Fix rx_filter flags setting for per peer rx_stats
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1586538405-16226-3-git-send-email-mkenna@codeaurora.org>
References: <1586538405-16226-3-git-send-email-mkenna@codeaurora.org>
To:     Maharaja Kennadyrajan <mkenna@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Maharaja Kennadyrajan <mkenna@codeaurora.org>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20200415080102.6DD54C432C2@smtp.codeaurora.org>
Date:   Wed, 15 Apr 2020 08:01:02 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Maharaja Kennadyrajan <mkenna@codeaurora.org> wrote:

> Rx_filter flags are set with default filter flags during
> wifi up/down sequence even though the 'ext_rx_stats' debugfs
> is enabled as 1. So, that we are not getting proper per peer
> rx_stats.
> Hence, fixing this by setting the missing rx_filter when
> ext_rx_stats is already set/enabled.
> 
> Signed-off-by: Maharaja Kennadyrajan <mkenna@codeaurora.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

ec48d28ba291 ath11k: Fix rx_filter flags setting for per peer rx_stats

-- 
https://patchwork.kernel.org/patch/11483475/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
