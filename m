Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D36AE3A81D1
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Jun 2021 16:06:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230463AbhFOOI1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 15 Jun 2021 10:08:27 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:55916 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230291AbhFOOIZ (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 15 Jun 2021 10:08:25 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1623765980; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=9AgMzAz+BYPyVtXVbJ/ZdRQwrE9673LawqRFb/0yWOY=;
 b=JifvmrjZM6cqbSEzd6++GEoh9+IQOZsJ14m4W9PWf6tgU+psLdxhTzZoN6KIIKnAyiXvlG58
 cw/r1tZEvayfzC6I388O9D0zRf/L4cUggnoNm0FStlcrYp+Lw2QwOix014W2xsesTyhpdkbc
 00U5ZLxkJqrEwDsM3R7cWcv1tyA=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-east-1.postgun.com with SMTP id
 60c8b3b651f29e6bae516ab6 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 15 Jun 2021 14:05:42
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 483F2C4360C; Tue, 15 Jun 2021 14:05:41 +0000 (UTC)
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 61454C43460;
        Tue, 15 Jun 2021 14:05:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 61454C43460
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath11k: send beacon template after vdev_start/restart
 during
 csa
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20210525133028.2805615-1-sven@narfation.org>
References: <20210525133028.2805615-1-sven@narfation.org>
To:     Sven Eckelmann <sven@narfation.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Seevalamuthu Mariappan <seevalam@codeaurora.org>,
        Sven Eckelmann <sven@narfation.org>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-Id: <20210615140541.483F2C4360C@smtp.codeaurora.org>
Date:   Tue, 15 Jun 2021 14:05:41 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Sven Eckelmann <sven@narfation.org> wrote:

> Firmware has added assert if beacon template is received after
> vdev_down. Firmware expects beacon template after vdev_start
> and before vdev_up. This change is needed to support MBSSID EMA
> cases in firmware.
> 
> Hence, Change the sequence in ath11k as expected from firmware.
> This new change is not causing any issues with older
> firmware.
> 
> Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.5.0.1.r3-00011-QCAHKSWPL_SILICONZ-1
> Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.5.0.1.r4-00008-QCAHKSWPL_SILICONZ-1
> 
> Fixes: d5c65159f289 ("ath11k: driver for Qualcomm IEEE 802.11ax devices")
> Signed-off-by: Seevalamuthu Mariappan <seevalam@codeaurora.org>
> [sven@narfation.org: added tested-on/fixes information]
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

979ebc54cf13 ath11k: send beacon template after vdev_start/restart during csa

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20210525133028.2805615-1-sven@narfation.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

