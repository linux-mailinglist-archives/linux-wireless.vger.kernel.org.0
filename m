Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69C374347F9
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Oct 2021 11:32:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbhJTJes (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 20 Oct 2021 05:34:48 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:49867 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbhJTJel (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 20 Oct 2021 05:34:41 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1634722347; h=Date: Message-ID: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=jYR6KS5eDp3lpVQnxJL2uWkWNd+fNs2em1l4cSPYDIU=;
 b=lVIKo2JPoB3tu949vefX8s6iUy0mn5Aa4ArTiRCx1mfzejYvUZoV39EDAFZOu1DvFVCGXzDF
 R6x9XvdIE5mfioD35D/th/doOgH8zxlZMwDkkm1S8bIzRks+plFpEzr7l0y//Kh6LiWKKW5D
 Mvl04XCUL8jbx8ivIsg58KGiBtQ=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-west-2.postgun.com with SMTP id
 616fe20d321f240051461797 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 20 Oct 2021 09:31:57
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 39C89C4360C; Wed, 20 Oct 2021 09:31:57 +0000 (UTC)
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id EF522C4338F;
        Wed, 20 Oct 2021 09:31:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org EF522C4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH for v5.15 1/5] iwlwifi: mvm: reset PM state on
 unsuccessful
 resume
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <iwlwifi.20211016114029.7ceb9eaca9f6.If0cbef38c6d07ec1ddce125878a4bdadcb35d2c9@changeid>
References: <iwlwifi.20211016114029.7ceb9eaca9f6.If0cbef38c6d07ec1ddce125878a4bdadcb35d2c9@changeid>
To:     Luca Coelho <luca@coelho.fi>
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <163472231083.20863.4884048064570800740.kvalo@codeaurora.org>
Date:   Wed, 20 Oct 2021 09:31:57 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Luca Coelho <luca@coelho.fi> wrote:

> From: Johannes Berg <johannes.berg@intel.com>
> 
> If resume fails for some reason, we need to set the PM state
> back to normal so we're able to send commands during firmware
> reset, rather than failing all of them because we're in D3.
> 
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> Fixes: 708a39aaca22 ("iwlwifi: mvm: don't send commands during suspend\resume transition")
> Signed-off-by: Luca Coelho <luciano.coelho@intel.com>

5 patches applied to wireless-drivers-next.git, thanks.

2f629a7772e2 iwlwifi: mvm: reset PM state on unsuccessful resume
70382b0897ee iwlwifi: change all JnP to NO-160 configuration
0f892441d8c3 iwlwifi: pnvm: don't kmemdup() more than we have
e864a77f51d0 iwlwifi: pnvm: read EFI data only if long enough
8bf26aa10a8e iwlwifi: cfg: set low-latency-xtal for some integrated So devices

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/iwlwifi.20211016114029.7ceb9eaca9f6.If0cbef38c6d07ec1ddce125878a4bdadcb35d2c9@changeid/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

