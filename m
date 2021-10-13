Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC0DD42B606
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Oct 2021 07:48:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237803AbhJMFuo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 13 Oct 2021 01:50:44 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:47725 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230083AbhJMFun (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 13 Oct 2021 01:50:43 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1634104121; h=Date: Message-ID: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=i5yafg4zRD6t3+PHLReH7vauRhqK9uR5ARjK8dp7Nnk=;
 b=srWh0Y2SPHQTp0Q+JdHM3hh9n4BTqUzXdo868JC5iCbwcudxoonR99Cw6NwemvDThwkF1WK+
 w7fj7mVXka1MmvBybZfzAAiYWLoI8rINlHffy1ra1aGlFxNl/JMK/rS6tA8OWAqw8tNsp1/i
 SXZi51j479yHJM3Kh6KRKOovb8c=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-west-2.postgun.com with SMTP id
 6166732fff0285fb0ad6e70e (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 13 Oct 2021 05:48:31
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 59493C4360D; Wed, 13 Oct 2021 05:48:31 +0000 (UTC)
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 7B780C43460;
        Wed, 13 Oct 2021 05:48:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 7B780C43460
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath9k: fix an IS_ERR() vs NULL check
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20211011123533.GA15188@kili>
References: <20211011123533.GA15188@kili>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     ath9k-devel@qca.qualcomm.com,
        Christian Lamparter <chunkeey@gmail.com>,
        linux-wireless@vger.kernel.org, kernel-janitors@vger.kernel.org
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <163410410736.12797.1530240555231219175.kvalo@codeaurora.org>
Date:   Wed, 13 Oct 2021 05:48:31 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Dan Carpenter <dan.carpenter@oracle.com> wrote:

> The devm_kmemdup() function doesn't return error pointers, it returns
> NULL on error.
> 
> Fixes: eb3a97a69be8 ("ath9k: fetch calibration data via nvmem subsystem")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

57671351379b ath9k: fix an IS_ERR() vs NULL check

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20211011123533.GA15188@kili/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

