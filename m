Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E245D25436F
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Aug 2020 12:16:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728857AbgH0KP7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 27 Aug 2020 06:15:59 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:50491 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728671AbgH0KOw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 27 Aug 2020 06:14:52 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1598523292; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=E9clqFvY5f4iEFBnpGzj5ZugZtSJo9tL+jaebHQ6mRM=;
 b=PquWN8D4pEthstqKkutQfrDN8sZia2pfj6UaAdin9VgowrlcZ6FE0MTz096Q+uAuK57fdo6I
 vtaaqLe+j4S1Zr7yyovIETjDwYjhKWxgA5W76UHWOjNpYAfYYh9OVla9wIRGWJ+FkK5u+U0c
 2kkZD6fQFlD8WkpWQCRwlwlHa2o=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-east-1.postgun.com with SMTP id
 5f47878f797ad9909bb8d12f (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 27 Aug 2020 10:14:39
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 75C57C43387; Thu, 27 Aug 2020 10:14:38 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 10268C433C6;
        Thu, 27 Aug 2020 10:14:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 10268C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wcn36xx: Setup starting bitrate to MCS-5
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1598345341-4505-1-git-send-email-loic.poulain@linaro.org>
References: <1598345341-4505-1-git-send-email-loic.poulain@linaro.org>
To:     Loic Poulain <loic.poulain@linaro.org>
Cc:     wcn36xx@lists.infradead.org, linux-wireless@vger.kernel.org,
        bryan.odonoghue@linaro.org, Loic Poulain <loic.poulain@linaro.org>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20200827101438.75C57C43387@smtp.codeaurora.org>
Date:   Thu, 27 Aug 2020 10:14:38 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Loic Poulain <loic.poulain@linaro.org> wrote:

> By default, after associated to an AP, the wcn36xx bitrate adjustment
> algorithm starts sending data at 1Mbps, and increases the rate slowly
> (1Mbps, 2Mbps, 6Mbps...) over the further TX packets.
> 
> Starting at 1Mbps usually causes the initial throughput to be really
> low and the maximum possible bitrate to be reached after about hundreed
> of TX packets.
> 
> That can be improved by setting a different initial bitrate for data
> packets via the ENABLE_DYNAMIC_RA_START_RATE configuration value, this
> value can be a legacy or MCS rate.
> 
> This patch sets the starting bitrate value to MCS-5, which seems to be
> a good compromise given it can be quickly adjusted low or up if necessary.
> (and based on what I observed in the wild with some mobile devices)
> 
> Signed-off-by: Loic Poulain <loic.poulain@linaro.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

1fcdb567df1b wcn36xx: Setup starting bitrate to MCS-5

-- 
https://patchwork.kernel.org/patch/11735209/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

