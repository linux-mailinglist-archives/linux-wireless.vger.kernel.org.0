Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C2BE2CC53B
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Dec 2020 19:34:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389434AbgLBSc6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 2 Dec 2020 13:32:58 -0500
Received: from a2.mail.mailgun.net ([198.61.254.61]:28749 "EHLO
        a2.mail.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729044AbgLBSc6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 2 Dec 2020 13:32:58 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1606933957; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=SHjri5Q2pKqbHfIN5HrVzVX6hwZKO5euUxxgWSJ5eSc=;
 b=ohu1tv6014MwsUzPw844egKk6h9MfzSbBMCrr8H4wsyepghojJHGXrjzkZZKVZjCbXzJCwnN
 cazUJvfXifJqKEo36gR5k94hKMQo58rPXeAbw+LnqcEVLhgVmi/bPpv90E1190jAyuDl0opy
 m3Mxpb1KDJTq5yfw5clMFGDqyx8=
X-Mailgun-Sending-Ip: 198.61.254.61
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-west-2.postgun.com with SMTP id
 5fc7ddac2ef3e1355ffcb04a (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 02 Dec 2020 18:32:12
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 13942C43462; Wed,  2 Dec 2020 18:32:12 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        MISSING_DATE,MISSING_MID,SPF_FAIL,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3E940C433ED;
        Wed,  2 Dec 2020 18:32:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3E940C433ED
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/2] ath10k: Fix an error handling path
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20201122170342.1346011-1-christophe.jaillet@wanadoo.fr>
References: <20201122170342.1346011-1-christophe.jaillet@wanadoo.fr>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     davem@davemloft.net, kuba@kernel.org, erik.stromdahl@gmail.com,
        ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20201202183212.13942C43462@smtp.codeaurora.org>
Date:   Wed,  2 Dec 2020 18:32:12 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Christophe JAILLET <christophe.jaillet@wanadoo.fr> wrote:

> If 'ath10k_usb_create()' fails, we should release some resources and report
> an error instead of silently continuing.
> 
> Fixes: 4db66499df91 ("ath10k: add initial USB support")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

2 patches applied to ath-next branch of ath.git, thanks.

ed3573bc3943 ath10k: Fix an error handling path
6364e693f4a7 ath10k: Release some resources in an error handling path

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20201122170342.1346011-1-christophe.jaillet@wanadoo.fr/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

