Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D0B944E2C0
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Nov 2021 09:01:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232586AbhKLIEd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 12 Nov 2021 03:04:33 -0500
Received: from m43-7.mailgun.net ([69.72.43.7]:38054 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230464AbhKLIEc (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 12 Nov 2021 03:04:32 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1636704102; h=Date: Message-ID: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=ZNYfuiVpBKLRjlCtUhKdf7Kp+cEJqc97y/1LfVLIeW8=;
 b=NTiitia8vShSJBMtKZwB6BMn6T+NkkRd9gPSqjhPfBgLvC8QaxfBmSjc7Fdn6A0FFuQeBdt+
 KxQ1o2H2i4x3NKK06ejIr4RtXH8b+572ESbzn+bdNOuhgshDuTcjoIUMWoP9bizkhSKKbhem
 fvavAePL9isAYKIsMNMlgVO4RM4=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-east-1.postgun.com with SMTP id
 618e1f59a445961e728d1aa0 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 12 Nov 2021 08:01:29
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 93331C4360D; Fri, 12 Nov 2021 08:01:28 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        MISSING_DATE,SPF_FAIL autolearn=no autolearn_force=no version=3.4.0
Received: from tykki.adurom.net (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 9D3B1C4338F;
        Fri, 12 Nov 2021 08:01:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 9D3B1C4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 10/12] ath11k: Send PPDU_STATS_CFG with proper pdev mask
 to
 firmware
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20210721212029.142388-10-jouni@codeaurora.org>
References: <20210721212029.142388-10-jouni@codeaurora.org>
To:     Jouni Malinen <jouni@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Rameshkumar Sundaram <ramess@codeaurora.org>,
        Sathishkumar Muruganandam <murugana@codeaurora.org>,
        Jouni Malinen <jouni@codeaurora.org>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <163670408232.15262.3231560511117264919.kvalo@codeaurora.org>
Date:   Fri, 12 Nov 2021 08:01:28 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Jouni Malinen <jouni@codeaurora.org> wrote:

> HTT_PPDU_STATS_CFG_PDEV_ID bit mask for target FW PPDU stats request message
> was set as bit 8 to 15. Bit 8 is reserved for soc stats and pdev id starts from
> bit 9. Hence change the bitmask as bit 9 to 15 and fill the proper pdev id in
> the request message.
> 
> In commit 701e48a43e15 ("ath11k: add packet log support for QCA6390"), both
> HTT_PPDU_STATS_CFG_PDEV_ID and pdev_mask were changed, but this pdev_mask
> calculation is not valid for platforms which has multiple pdevs with 1 rxdma
> per pdev, as this is writing same value(i.e. 2) for all pdevs.  Hence fixed it
> to consider pdev_idx as well, to make it compatible for both single and multi
> pd cases.
> 
> Tested on: IPQ8074 hw2.0 AHB WLAN.HK.2.5.0.1-01092-QCAHKSWPL_SILICONZ-1
> Tested on: IPQ6018 hw1.0 WLAN.HK.2.5.0.1-01067-QCAHKSWPL_SILICONZ-1
> 
> Fixes: 701e48a43e15 ("ath11k: add packet log support for QCA6390")
> 
> Co-developed-by: Sathishkumar Muruganandam <murugana@codeaurora.org>
> Signed-off-by: Sathishkumar Muruganandam <murugana@codeaurora.org>
> Signed-off-by: Rameshkumar Sundaram <ramess@codeaurora.org>
> Signed-off-by: Jouni Malinen <jouni@codeaurora.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

16a2c3d5406f ath11k: Send PPDU_STATS_CFG with proper pdev mask to firmware

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20210721212029.142388-10-jouni@codeaurora.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

