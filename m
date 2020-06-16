Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 151A41FAAEE
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Jun 2020 10:17:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726464AbgFPIRJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 16 Jun 2020 04:17:09 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:48184 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726428AbgFPIRJ (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 16 Jun 2020 04:17:09 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1592295428; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=Bm8QzMHnJGEAsAsr8DiQ8WwYAPwEwB23TDKTa2Se3S4=;
 b=Rb65RZx8vQYnvXYX57jTZy8Swn7gBFbxAr22KjRTZJiecZmMSs9ekp3dw2Egfv4WKDrzABdE
 p+AFdxVvKLsfkiXGZF5LUp7Qe+IW/jGPCA5fuQKEJAm/dwfH6+3lsOkIaiTT53RwlKFBmYhP
 vpNPvW5oZTtxmrorH7DwdV7U100=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n08.prod.us-west-2.postgun.com with SMTP id
 5ee88003fe1db4db897c3558 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 16 Jun 2020 08:17:07
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 8A137C433CA; Tue, 16 Jun 2020 08:17:07 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 48597C433C8;
        Tue, 16 Jun 2020 08:17:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 48597C433C8
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wcn36xx: Add ieee80211 rx status rate information
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1591961254-10243-1-git-send-email-loic.poulain@linaro.org>
References: <1591961254-10243-1-git-send-email-loic.poulain@linaro.org>
To:     Loic Poulain <loic.poulain@linaro.org>
Cc:     wcn36xx@lists.infradead.org, linux-wireless@vger.kernel.org,
        Loic Poulain <loic.poulain@linaro.org>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20200616081707.8A137C433CA@smtp.codeaurora.org>
Date:   Tue, 16 Jun 2020 08:17:07 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Loic Poulain <loic.poulain@linaro.org> wrote:

> Packet encoding, bandwidth and bitrate can be derived from the
> wcn36xx rate_idx, part of the buffer descriptor.
> 
> Signed-off-by: Loic Poulain <loic.poulain@linaro.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

0aa90483f23e wcn36xx: Add ieee80211 rx status rate information

-- 
https://patchwork.kernel.org/patch/11601539/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

