Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD1C731E63A
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Feb 2021 07:21:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229594AbhBRGPj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 18 Feb 2021 01:15:39 -0500
Received: from m42-2.mailgun.net ([69.72.42.2]:52095 "EHLO m42-2.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231861AbhBRGBW (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 18 Feb 2021 01:01:22 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1613628041; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=kbmqQ+rrzKPwhcJLQHPBo8hn1qn/ROLkdbr/KDtl24k=;
 b=LD88hA0xw5HGYd2OrWBxXVxwYdYO1fbi6ft/SEl/2HpGKztqc+EEqPnU8E7xgVWMv6iH22mH
 XUQiKJneEGI/aKIfCHplBzjxr/dF/hNWeJwoDv8p2i0xx7K02Ji/THhj6JpWXduZR4MmN6Ar
 3Kgr2iZd32j33+y+OfnrWdidACU=
X-Mailgun-Sending-Ip: 69.72.42.2
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-east-1.postgun.com with SMTP id
 602e02653af8a93304f76678 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 18 Feb 2021 06:00:05
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id ECEBBC433ED; Thu, 18 Feb 2021 06:00:04 +0000 (UTC)
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 6CBD4C433CA;
        Thu, 18 Feb 2021 06:00:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6CBD4C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath11k: Fix sounding dimension config in HE cap
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1613460136-7170-1-git-send-email-lavaks@codeaurora.org>
References: <1613460136-7170-1-git-send-email-lavaks@codeaurora.org>
To:     Lavanya Suresh <lavaks@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Lavanya Suresh <lavaks@codeaurora.org>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20210218060004.ECEBBC433ED@smtp.codeaurora.org>
Date:   Thu, 18 Feb 2021 06:00:04 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Lavanya Suresh <lavaks@codeaurora.org> wrote:

> Number of Sounding dimensions config received from firmware for
> bandwidth above 80MHz is cleared, and proper value is not set again.
> So not resetting it to accept the config from firmware.
> 
> Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.4.0.1-01689-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Lavanya Suresh <lavaks@codeaurora.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

096b625fab8f ath11k: Fix sounding dimension config in HE cap

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/1613460136-7170-1-git-send-email-lavaks@codeaurora.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

