Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB7C541AD61
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Sep 2021 12:55:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239380AbhI1K5M (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 28 Sep 2021 06:57:12 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:38008 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240291AbhI1K5L (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 28 Sep 2021 06:57:11 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1632826532; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=z0OOqPlUIz2VSpoSabNQP0cl97JN4q8tbV7qWlpVx6w=;
 b=MQlwYmE6xbbOdBHk3YJvdRXKIa2+uZLxU1uJMlL3n51JL5c1AHTS+ydKDnsKaPKgw0gN/HF2
 eZsPEvfFBFobl3SvChQMTnzs2+rgJ1EAyj0JEf++0B1OQX9wwaTYeftSgPtzV0Plh8MHDc/Y
 OQGL4cwcGKwt3uQP9fAsF+7emtg=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-west-2.postgun.com with SMTP id
 6152f4a1a5a9bab6e857497d (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 28 Sep 2021 10:55:29
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 9C23DC43619; Tue, 28 Sep 2021 10:55:29 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        MISSING_DATE,MISSING_MID,SPF_FAIL autolearn=no autolearn_force=no
        version=3.4.0
Received: from tykki.adurom.net (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0C2B3C4338F;
        Tue, 28 Sep 2021 10:55:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 0C2B3C4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath11k: qmi: avoid error messages when dma allocation
 fails
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20210823063258.37747-1-aaron.ma@canonical.com>
References: <20210823063258.37747-1-aaron.ma@canonical.com>
To:     Aaron Ma <aaron.ma@canonical.com>
Cc:     aaron.ma@canonical.com, davem@davemloft.net, kuba@kernel.org,
        ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-Id: <20210928105529.9C23DC43619@smtp.codeaurora.org>
Date:   Tue, 28 Sep 2021 10:55:29 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Aaron Ma <aaron.ma@canonical.com> wrote:

> qmi tries to allocate a large contiguous dma memory at first,
> on the AMD Ryzen platform it fails, then retries with small slices.
> So set flag GFP_NOWARN to avoid flooding dmesg.
> 
> Signed-off-by: Aaron Ma <aaron.ma@canonical.com>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

b9b5948cdd7b ath11k: qmi: avoid error messages when dma allocation fails

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20210823063258.37747-1-aaron.ma@canonical.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

