Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B573F4541E3
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Nov 2021 08:32:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233673AbhKQHfQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 17 Nov 2021 02:35:16 -0500
Received: from m43-7.mailgun.net ([69.72.43.7]:22869 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233408AbhKQHfP (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 17 Nov 2021 02:35:15 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1637134337; h=Date: Message-ID: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=P+xmMnDeuVV3fcpmiQ/qL5HdNAPrSn0rNUls7jb9utY=;
 b=t+zDoAFOBuNFUBhAiU66xpmV3TXRSvfqmDoLwPtodD1LClyIi0IfsoqFPUpY3uopLu/CHo1M
 UEkJJPm3jz6OXBn4vrud9rygripv0d5htWGgE6YMKlNGAwRv8fINGsWlhPBzhF61dWvUOWZl
 +qavPd0M5g6Np0PLrzRXlf5766w=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-west-2.postgun.com with SMTP id
 6194b0001e1d2f5233b63254 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 17 Nov 2021 07:32:16
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id AF74AC43460; Wed, 17 Nov 2021 07:32:16 +0000 (UTC)
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 47C2CC4338F;
        Wed, 17 Nov 2021 07:32:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 47C2CC4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath11k: add support for BSS color change
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1635178254-17732-1-git-send-email-quic_ramess@quicinc.com>
References: <1635178254-17732-1-git-send-email-quic_ramess@quicinc.com>
To:     Rameshkumar Sundaram <quic_ramess@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        <lavaks@codeaurora.org>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <163713433344.31320.15507831510169875119.kvalo@codeaurora.org>
Date:   Wed, 17 Nov 2021 07:32:16 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Rameshkumar Sundaram <quic_ramess@quicinc.com> wrote:

> Whenever the MAC detects a color collision, or any of
> its associated stations detects one, the firmware will
> send out an event. Add the code to parse and handle
> this event and pass the data up to mac80211.
> 
> The firmware does not provide an offload feature such
> as the one used for CSA. The color change process is
> hence triggered via the beacon offload tx completion
> events sent out by firmware.
> 
> BSS color feature is enabled depending on service flag
> advertised by firmware, based on which color change
> functionality is invoked.
> 
> Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.5.0.1-00680-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: John Crispin <john@phrozen.org>
> Co-developed-by: Lavanya Suresh <lavaks@codeaurora.org>
> Signed-off-by: Lavanya Suresh <lavaks@codeaurora.org>
> Signed-off-by: Rameshkumar Sundaram <quic_ramess@quicinc.com>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

886433a98425 ath11k: add support for BSS color change

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/1635178254-17732-1-git-send-email-quic_ramess@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

