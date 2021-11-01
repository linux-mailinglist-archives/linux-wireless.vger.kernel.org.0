Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E9F6441C81
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Nov 2021 15:19:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232146AbhKAOW0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 1 Nov 2021 10:22:26 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:50643 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231922AbhKAOWZ (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 1 Nov 2021 10:22:25 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1635776392; h=Date: Message-ID: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=PPfpIjvBNczivB4XNJKiXXTGHKNAAJpU2D/YIyugjXk=;
 b=WIkUdBPj0yZ6j2fkmITML7Dpke4urZ8OB1ADYH/exSyg2SXr1QU1x5hOv16eqJfa4DM1ADnN
 MgCo24anh4WThJEqh65SsT6uRkwVs3REDBsgULqsr3xXC3PBr60AyWzoaBuA8iZUHNPa2IYa
 xzWU4sxMut1jyoQun6em+aGgQ5w=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-east-1.postgun.com with SMTP id
 617ff77a2e144ac4d32453bd (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 01 Nov 2021 14:19:38
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id AD3FEC43616; Mon,  1 Nov 2021 14:19:37 +0000 (UTC)
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 50C4AC4338F;
        Mon,  1 Nov 2021 14:19:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 50C4AC4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wcn36xx: Indicate beacon not connection loss on
 MISSED_BEACON_IND
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20211027232529.657764-1-bryan.odonoghue@linaro.org>
References: <20211027232529.657764-1-bryan.odonoghue@linaro.org>
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc:     linux-wireless@vger.kernel.org, wcn36xx@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, loic.poulain@linaro.org,
        benl@squareup.com, bryan.odonoghue@linaro.org
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <163577637326.7461.17837845723571403340.kvalo@codeaurora.org>
Date:   Mon,  1 Nov 2021 14:19:37 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Bryan O'Donoghue <bryan.odonoghue@linaro.org> wrote:

> Firmware can trigger a missed beacon indication, this is not the same as a
> lost signal.
> 
> Flag to Linux the missed beacon and let the WiFi stack decide for itself if
> the link is up or down by sending its own probe to determine this.
> 
> We should only be signalling the link is lost when the firmware indicates
> 
> Fixes: 8e84c2582169 ("wcn36xx: mac80211 driver for Qualcomm WCN3660/WCN3680 hardware")
> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

588b45c88ae1 wcn36xx: Indicate beacon not connection loss on MISSED_BEACON_IND

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20211027232529.657764-1-bryan.odonoghue@linaro.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

