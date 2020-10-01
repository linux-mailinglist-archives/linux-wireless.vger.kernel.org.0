Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FF182807CD
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Oct 2020 21:34:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732864AbgJATe1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 1 Oct 2020 15:34:27 -0400
Received: from m42-4.mailgun.net ([69.72.42.4]:37916 "EHLO m42-4.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729993AbgJATe0 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 1 Oct 2020 15:34:26 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1601580866; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=fZVFK2LeU+DEVUSPMEHcmvf6UgaK7cjbH75I1oUanCk=;
 b=kijEteyEfF5Li3xGj3oOMBtnv0Ha0hZ7Z6sSldfFr/FNdAjHCEvyo9a+emTGmk8wLFiPlBUB
 bbHKcw0D+6qDomz5MMoeLshdlWbpNlE0YwpnWrin89UTYB905zwK1N7wMqOdcb4w+5Xj0b0i
 FBxfFwo40Ogt9Q3Nx2Rms+eEFss=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-east-1.postgun.com with SMTP id
 5f762f41d90823fe0fba3a02 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 01 Oct 2020 19:34:25
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 4FC40C433CA; Thu,  1 Oct 2020 19:34:24 +0000 (UTC)
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 59820C433F1;
        Thu,  1 Oct 2020 19:34:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 59820C433F1
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 2/2] wcn36xx: Advertise beacon filtering support in bmps
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1592471863-31402-2-git-send-email-loic.poulain@linaro.org>
References: <1592471863-31402-2-git-send-email-loic.poulain@linaro.org>
To:     Loic Poulain <loic.poulain@linaro.org>
Cc:     johannes@sipsolutions.net, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org,
        Loic Poulain <loic.poulain@linaro.org>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20201001193424.4FC40C433CA@smtp.codeaurora.org>
Date:   Thu,  1 Oct 2020 19:34:24 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Loic Poulain <loic.poulain@linaro.org> wrote:

> In bmps mode, beacons are filtered, and firmware is in charge
> of monitoring the beacons and report changes or loss.
> 
> mac80211 must be advertised about such change to prevent it's
> internal timer based beacon monitor to report beacon loss.
> 
> Fix that by setting/clearing the IEEE80211_VIF_BEACON_FILTER
> vif flag on bmps entry/exit.
> 
> Signed-off-by: Loic Poulain <loic.poulain@linaro.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

fd5ad4d1e980 wcn36xx: Advertise beacon filtering support in bmps

-- 
https://patchwork.kernel.org/patch/11611661/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

