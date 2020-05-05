Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A51421C4F4A
	for <lists+linux-wireless@lfdr.de>; Tue,  5 May 2020 09:38:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728114AbgEEHi0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 5 May 2020 03:38:26 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:15974 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726129AbgEEHi0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 5 May 2020 03:38:26 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1588664305; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=xLqqp3adaBmYusk8r3ljNFiKZHe6uvHtQ4bFrHiagnk=;
 b=BSqphwGPzussQ2bTwtc6WCQeuuIy480100H6NvlqbH9prvxE+RuhwF1oEgw9TvFSGZXHbZDQ
 ExfZdbFFG+xfClME47X7pcaCqR037OeQxZ/rbaqsj9AsYXLoO1ltqGN1VW1a90J/Gu3nZpQD
 niU2Nl2Bjc17Rc/RDDfo3xa4usI=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5eb117e3.7fa95922a068-smtp-out-n05;
 Tue, 05 May 2020 07:38:11 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 33F51C433BA; Tue,  5 May 2020 07:38:11 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E870CC433CB;
        Tue,  5 May 2020 07:38:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E870CC433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath11k: fix resource unavailability for htt stats after
 peer
 stats display
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1588592755-10427-1-git-send-email-ssreeela@codeaurora.org>
References: <1588592755-10427-1-git-send-email-ssreeela@codeaurora.org>
To:     Sowmiya Sree Elavalagan <ssreeela@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Sowmiya Sree Elavalagan <ssreeela@codeaurora.org>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20200505073811.33F51C433BA@smtp.codeaurora.org>
Date:   Tue,  5 May 2020 07:38:11 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Sowmiya Sree Elavalagan <ssreeela@codeaurora.org> wrote:

> htt stats are not working after htt peer stats display
> and also after htt peer stats reset. Trying to dump htt
> stats shows "Resource temporarily unavailable".
> This is because of "ar->debug.htt_stats.stats_req" member is being
> consecutively used for all htt stats without being reset
> during the previous usage. Hence assigning NULL to this member
> after freeing the allocated memory fixes the issue.
> 
> console logs below:
> # echo 9 >/sys/kernel/debug/ath11k/ipq8074/mac1/htt_stats_type
> # cat /sys/kernel/debug/ath11k/ipq8074/mac1/htt_stats_type
> 9
> # cat /sys/kernel/debug/ath11k/ipq8074/mac1/htt_stats
> cat: can't open '/sys/kernel/debug/ath11k/ipq8074/mac1/htt_stats'
> : Resource temporarily unavailable
> 
> Signed-off-by: Sowmiya Sree Elavalagan <ssreeela@codeaurora.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

52f274b51993 ath11k: fix resource unavailability for htt stats after peer stats display

-- 
https://patchwork.kernel.org/patch/11525557/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
