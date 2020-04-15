Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EDA41A955C
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Apr 2020 10:00:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393757AbgDOH7M (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 15 Apr 2020 03:59:12 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:62996 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390630AbgDOH7K (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 15 Apr 2020 03:59:10 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1586937548; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=pohxK7Uz5mkCWq+/9GGvgvtGMM/5cPXomYfxTw6Gx4M=;
 b=GFK0dNFLo8yLSZE527N7VVLcYL1tHPpGEpoi0txvkUacbH6Dg25vbjVFoYx69mGipJk6dWog
 r5/tZyCFeogG7fbSk3WDPglsoFh2ZqeD4+iVAkoDJVXFL8jdol4wd8OAou82F5fsnUJViRtz
 YxSFjpMRYoZu7KgFWZyDfopVkrs=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e96becc.7f727d289618-smtp-out-n03;
 Wed, 15 Apr 2020 07:59:08 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 1DFF2C433BA; Wed, 15 Apr 2020 07:59:08 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D2928C433F2;
        Wed, 15 Apr 2020 07:59:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D2928C433F2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath11k: Cleanup in pdev destroy and mac register during
 crash on recovery
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1586538405-16226-1-git-send-email-mkenna@codeaurora.org>
References: <1586538405-16226-1-git-send-email-mkenna@codeaurora.org>
To:     Maharaja Kennadyrajan <mkenna@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Maharaja Kennadyrajan <mkenna@codeaurora.org>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20200415075908.1DFF2C433BA@smtp.codeaurora.org>
Date:   Wed, 15 Apr 2020 07:59:08 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Maharaja Kennadyrajan <mkenna@codeaurora.org> wrote:

> Debugfs pdev entries should be cleaned up during the crash
> on recovery. If not, mac register will fail for the reason
> that it is already registered during core reconfigure.
> 
> Signed-off-by: Maharaja Kennadyrajan <mkenna@codeaurora.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

6fc3b94ef596 ath11k: Cleanup in pdev destroy and mac register during crash on recovery

-- 
https://patchwork.kernel.org/patch/11483477/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
