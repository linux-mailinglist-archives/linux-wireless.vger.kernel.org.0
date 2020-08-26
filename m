Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC7C725329B
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Aug 2020 16:58:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727768AbgHZO6k (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 26 Aug 2020 10:58:40 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:40431 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727851AbgHZO6e (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 26 Aug 2020 10:58:34 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1598453914; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=4QYJHA8j36hmM1qubYJJUUghDF4BBmmo7EiJkXavmoE=;
 b=q4XgrYnE8bWEzdE/yEIF/S5AypYE3hE4IOUDUZ7tdAZ+bQ+ATjQX1ITHnY7ILbGxUBuQX2bF
 qWwBEtwsNq1+4YaPYkXUWnXt5s1tl7y/5O0PxcyNy8Wf5Zm2udx+VEnj875eURYKIJP32N2j
 JoZjaX2Bk5gOyIvJI151fzsGLP8=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-east-1.postgun.com with SMTP id
 5f46788f222038607a7a6b19 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 26 Aug 2020 14:58:23
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 496D1C433C6; Wed, 26 Aug 2020 14:58:22 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id EB788C433A1;
        Wed, 26 Aug 2020 14:58:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org EB788C433A1
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH V6 1/2] ath11k: switch to using ieee80211_tx_status_ext()
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20200803145444.473810-1-john@phrozen.org>
References: <20200803145444.473810-1-john@phrozen.org>
To:     John Crispin <john@phrozen.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        John Crispin <john@phrozen.org>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20200826145822.496D1C433C6@smtp.codeaurora.org>
Date:   Wed, 26 Aug 2020 14:58:22 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

John Crispin <john@phrozen.org> wrote:

> This allows us to pass HE rates down into the stack.
> 
> Signed-off-by: John Crispin <john@phrozen.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Dropping the per and expecting Miles will address the issues. Miles, as I did
some changes to the patches in pending branch please incorporate my changes in
v7:

https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?h=pending&id=52a632ec5dd0eab7e82051164d42bd35fe06af00

https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?h=pending&id=0ed5b5fc10d08b565183008a14267779d6da4bd4

2 patches set to Changes Requested.

11698305 [V6,1/2] ath11k: switch to using ieee80211_tx_status_ext()
11698303 [V6,2/2] ath11k: add more HE fields into radiotap header

-- 
https://patchwork.kernel.org/patch/11698305/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

