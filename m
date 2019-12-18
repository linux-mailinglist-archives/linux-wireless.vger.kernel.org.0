Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 56796124627
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Dec 2019 12:52:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726743AbfLRLww (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 18 Dec 2019 06:52:52 -0500
Received: from mail26.static.mailgun.info ([104.130.122.26]:49844 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726551AbfLRLww (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 18 Dec 2019 06:52:52 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1576669971; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=TMT0l9tfkSs9AfqC0EUNi0voHc2lvjwSQWCTyL1O2vs=;
 b=XCW3uRlysuTPmWktJPSNMh6XKMHVwdTdFu3rusPqZznkRNkFOor8lkNliRHKqJ0hPHVVvcvN
 IFIArQm6I8dj5zr3+yrnwKDevTCkpfZt1/rNg1Lec5+YgYcDt1egqqTqMeUwTyQs0w5kEl7r
 WviiN+XGvZPOLh5gBHvG/WOcBQE=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5dfa1311.7f99678d3c38-smtp-out-n02;
 Wed, 18 Dec 2019 11:52:49 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id CE06FC43383; Wed, 18 Dec 2019 11:52:48 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 76215C433CB;
        Wed, 18 Dec 2019 11:52:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 76215C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3] ath11k: Add missing pdev rx rate stats
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <0101016ed1b43bf2-1e21d5b3-b396-446f-9f19-c7de3df29a61-000000@us-west-2.amazonses.com>
References: <0101016ed1b43bf2-1e21d5b3-b396-446f-9f19-c7de3df29a61-000000@us-west-2.amazonses.com>
To:     Bhagavathi Perumal S <bperumal@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Bhagavathi Perumal S <bperumal@codeaurora.org>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20191218115248.CE06FC43383@smtp.codeaurora.org>
Date:   Wed, 18 Dec 2019 11:52:48 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Bhagavathi Perumal S <bperumal@codeaurora.org> wrote:

> This adds missing rx rate info stats like pilot evm,
> per chain rssi, per user ul ppdu and mpdu counts and
> ul ofdma rate info etc.
> 
> And add null checks for memory alloc failures.
> 
> Signed-off-by: Bhagavathi Perumal S <bperumal@codeaurora.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

This one has warnings, please fix and resend:

drivers/net/wireless/ath/ath11k/debug_htt_stats.c:2846:59: warning: Using plain integer as NULL pointer
drivers/net/wireless/ath/ath11k/debug_htt_stats.c:3025:68: warning: Using plain integer as NULL pointer
drivers/net/wireless/ath/ath11k/debug_htt_stats.c:3026:59: warning: Using plain integer as NULL pointer
drivers/net/wireless/ath/ath11k/debug_htt_stats.c:3028:73: warning: Using plain integer as NULL pointer
drivers/net/wireless/ath/ath11k/debug_htt_stats.c:779:59: warning: Using plain integer as NULL pointer
drivers/net/wireless/ath/ath11k/debug_htt_stats.c:867:68: warning: Using plain integer as NULL pointer
drivers/net/wireless/ath/ath11k/debug_htt_stats.c:868:59: warning: Using plain integer as NULL pointer
drivers/net/wireless/ath/ath11k/debug_htt_stats.h:1294: Avoid CamelCase: <rx_pilot_evm_dB>
drivers/net/wireless/ath/ath11k/debug_htt_stats.h:1300: Avoid CamelCase: <rx_pilot_evm_dB_mean>
drivers/net/wireless/ath/ath11k/debug_htt_stats.c:3028: Avoid CamelCase: <rx_pilot_evm_dB>
drivers/net/wireless/ath/ath11k/debug_htt_stats.c:3114: Avoid CamelCase: <rx_pilot_evm_dB_mean>

-- 
https://patchwork.kernel.org/patch/11273269/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
