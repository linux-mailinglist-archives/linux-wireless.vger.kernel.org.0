Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DFE81A9568
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Apr 2020 10:01:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503232AbgDOIA4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 15 Apr 2020 04:00:56 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:52587 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2393773AbgDOIAQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 15 Apr 2020 04:00:16 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1586937615; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=ihFUfS0gGovPsymRUMR3cj63G/QgNONUbgVDmzVduGg=;
 b=PJXIYRuA6agS9OrdinWky2GkEQNx92Jh6mig2i0/BRS3PvqWKuopwMtP716dXOYTPp3KQA53
 EJ2OuGPo88mb3wl6ypcBJAQqb4nMXpl2cqgbZXJagGp2QrLl4djJiR/S6hNWQpv4tEpmK7Bf
 C60H2fYTFKS6Q/emgnlaI+EH8ZM=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e96bf06.7f8e768e63b0-smtp-out-n04;
 Wed, 15 Apr 2020 08:00:06 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 74758C432C2; Wed, 15 Apr 2020 08:00:05 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id EB986C433CB;
        Wed, 15 Apr 2020 08:00:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org EB986C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath11k: Fix fw assert by setting proper vht cap
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1586538405-16226-2-git-send-email-mkenna@codeaurora.org>
References: <1586538405-16226-2-git-send-email-mkenna@codeaurora.org>
To:     Maharaja Kennadyrajan <mkenna@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Ritesh Singh <ritesi@codeaurora.org>,
        Maharaja Kennadyrajan <mkenna@codeaurora.org>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20200415080005.74758C432C2@smtp.codeaurora.org>
Date:   Wed, 15 Apr 2020 08:00:05 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Maharaja Kennadyrajan <mkenna@codeaurora.org> wrote:

> After setting fixed vht-rate if new station is trying to
> assoc with mu_bfee cap, or if a sta is already connected
> with mu_bfee cap then set the fixed vht-rate and
> reconnecting the sta, FW assert is happening.
> 
> So to avoid this, reset the MU_BEAMFORMEE bit in vht->caps,
> if mcs_index is invalid for nss 1.
> 
> Signed-off-by: Ritesh Singh <ritesi@codeaurora.org>
> Signed-off-by: Maharaja Kennadyrajan <mkenna@codeaurora.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

40c766d4a49c ath11k: Fix fw assert by setting proper vht cap

-- 
https://patchwork.kernel.org/patch/11483471/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
