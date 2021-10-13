Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97D8F42B607
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Oct 2021 07:49:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230514AbhJMFvQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 13 Oct 2021 01:51:16 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:24842 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230083AbhJMFvP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 13 Oct 2021 01:51:15 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1634104153; h=Date: Message-ID: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=V8zlMIoGO8Qmr2pOGAUAk9gFpxGsFFrsRVmNv+nGpbE=;
 b=VQrXlLcjDYJrMrgoTplgC9BjtXGAvBKSAHW3QbPWp2woa8gIeOjLc9B2tvY4mhm3EY1x4ZCy
 0HrWfmqtIp1jNBiAjXtsX2zbUDdmOkJYVAj1+JYblsq8CLZgFFCR9Tjmz2JrIFUxGajLy70c
 9hYQfMOgiyMCc5sDQtWIHpI7W/A=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-east-1.postgun.com with SMTP id
 6166734ba45ca753070e2497 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 13 Oct 2021 05:48:59
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 5C6FEC4360D; Wed, 13 Oct 2021 05:48:58 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        MISSING_DATE,SPF_FAIL,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.0
Received: from tykki.adurom.net (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 92856C4338F;
        Wed, 13 Oct 2021 05:48:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 92856C4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2] ath10k: fix max antenna gain unit
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20190611172131.6064-1-sven@narfation.org>
References: <20190611172131.6064-1-sven@narfation.org>
To:     Sven Eckelmann <sven@narfation.org>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Sven Eckelmann <seckelmann@datto.com>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <163410413435.12797.8692375433554922203.kvalo@codeaurora.org>
Date:   Wed, 13 Oct 2021 05:48:58 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Sven Eckelmann <sven@narfation.org> wrote:

> Most of the txpower for the ath10k firmware is stored as twicepower (0.5 dB
> steps). This isn't the case for max_antenna_gain - which is still expected
> by the firmware as dB.
> 
> The firmware is converting it from dB to the internal (twicepower)
> representation when it calculates the limits of a channel. This can be seen
> in tpc_stats when configuring "12" as max_antenna_gain. Instead of the
> expected 12 (6 dB), the tpc_stats shows 24 (12 dB).
> 
> Tested on QCA9888 and IPQ4019 with firmware 10.4-3.5.3-00057.
> 
> Fixes: 02256930d9b8 ("ath10k: use proper tx power unit")
> Signed-off-by: Sven Eckelmann <seckelmann@datto.com>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

0a491167fe0c ath10k: fix max antenna gain unit

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20190611172131.6064-1-sven@narfation.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

