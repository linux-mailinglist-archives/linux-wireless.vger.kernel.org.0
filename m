Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED5A11A758C
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Apr 2020 10:10:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407033AbgDNIKf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 14 Apr 2020 04:10:35 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:21438 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2407026AbgDNIK2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 14 Apr 2020 04:10:28 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1586851828; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=5Szi0RatQytgj21EVQDea5s7a5JI+FZQeIvITZtAM4g=;
 b=We94/MAqllTkhD1ipmVjhAkD4fVV//SS1mvJw9t4i756e+CyiNktRSlmcNVdDGiqGM8AwCPq
 DntNy0gUyiB5ptJ0Lm3nKQ77ZpidqtfXSqrAe8gd/ox143fgsmNHsu7bW8Vo/U5xLnw7XeEL
 6ooqlbBm4G9ziUOVFj2ifr7c9hM=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e956fe1.7f93486dd308-smtp-out-n05;
 Tue, 14 Apr 2020 08:10:09 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id D80B3C433BA; Tue, 14 Apr 2020 08:10:08 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 961DEC433F2;
        Tue, 14 Apr 2020 08:10:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 961DEC433F2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath11k: fix duplication peer create on same radio
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1586343795-21422-1-git-send-email-periyasa@codeaurora.org>
References: <1586343795-21422-1-git-send-email-periyasa@codeaurora.org>
To:     Karthikeyan Periyasamy <periyasa@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Karthikeyan Periyasamy <periyasa@codeaurora.org>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20200414081008.D80B3C433BA@smtp.codeaurora.org>
Date:   Tue, 14 Apr 2020 08:10:08 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Karthikeyan Periyasamy <periyasa@codeaurora.org> wrote:

> Add the pdev index information in the peer object to validate
> the peer creation. Ignore the peer creation request, if the given
> MAC address is already present in the peer list with same radio.
> If we allow the peer creation in above scenario, FW assert will happen.
> Above scenario occurred in two cases, where Multiple AP VAP created in
> the same radio.
> 
> 1. when testing tool sends association request to two AP with same
>    MAC address
> 2. when a station do roaming from one AP VAP to another AP VAP.
> 
> Signed-off-by: Karthikeyan Periyasamy <periyasa@codeaurora.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

1e744bf218b5 ath11k: fix duplication peer create on same radio

-- 
https://patchwork.kernel.org/patch/11479785/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
