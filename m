Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46922244B5E
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Aug 2020 16:50:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727905AbgHNOux (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 14 Aug 2020 10:50:53 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:60318 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726193AbgHNOuw (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 14 Aug 2020 10:50:52 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1597416651; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=pdoa35tjc7pBRBQqNeg3ep0c9In8mctpwTL5tUWw3eM=;
 b=XBEdSwO/s2ObycnKcnnreEzyheOkLoujPwn6XCfhd4Bp5d+Ww9rZwYbRIDnzXN9UIo9eJWaj
 /O2YDY3pHX7WXUivsNVZ5MbDT0Wmb9KbPN8o3fR9yIeD+c+Y9ki+/i1Y0APjusUtuyfxyCXJ
 rOisIQfUaS9zJUn9GhMhv1aqAj8=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n10.prod.us-east-1.postgun.com with SMTP id
 5f36a4cbba4c2cd367abf76d (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 14 Aug 2020 14:50:51
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 5035CC43391; Fri, 14 Aug 2020 14:50:50 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D2B86C433C9;
        Fri, 14 Aug 2020 14:50:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D2B86C433C9
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 5/6] wcn36xx: Fix software-driven scan
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1595586052-16081-6-git-send-email-loic.poulain@linaro.org>
References: <1595586052-16081-6-git-send-email-loic.poulain@linaro.org>
To:     Loic Poulain <loic.poulain@linaro.org>
Cc:     wcn36xx@lists.infradead.org, linux-wireless@vger.kernel.org,
        Loic Poulain <loic.poulain@linaro.org>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20200814145050.5035CC43391@smtp.codeaurora.org>
Date:   Fri, 14 Aug 2020 14:50:50 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Loic Poulain <loic.poulain@linaro.org> wrote:

> For software-driven scan, rely on mac80211 software scan instead
> of internal driver implementation. The internal implementation
> cause connection trouble since it keep the antenna busy during
> the entire scan duration, moreover it's only a passive scanning
> (no probe request). Therefore, let mac80211 manages sw scan.
> 
> Note: we fallback to software scan if firmware does not report
> scan offload support or if we need to scan the 5Ghz band (currently
> not supported by the offload scan...).
> 
> Signed-off-by: Loic Poulain <loic.poulain@linaro.org>
> Tested-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

I dropped this patch 5 per Bryan's comment. Please work with Bryan to
fix the issue and resend this patch.

Patch set to Changes Requested.

-- 
https://patchwork.kernel.org/patch/11682841/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

