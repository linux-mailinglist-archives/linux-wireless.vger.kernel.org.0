Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7ED8924822A
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Aug 2020 11:47:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726357AbgHRJrj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 18 Aug 2020 05:47:39 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:33332 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726145AbgHRJri (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 18 Aug 2020 05:47:38 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1597744058; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=uvgRNmual5KG/vYZSGpRJAR0wBaFvr9HvDKCNaTaZ2I=;
 b=xCZTc6VsMwh6aIeBTPzpqI39mNpeW8l6M4BKo1aK2Z3sTNEmtTSEhSrT7K3fiNHyTyWj6XNW
 UmnH3nOCwoq4i3xzj2J1LPyzn6muFc3hW17VCAsfLmwin/0UiJsEGCGEM1sFU6xLS6jF7GXM
 iyOn6MpTe3Jt+Zsl+ZsltvIzjDM=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-east-1.postgun.com with SMTP id
 5f3ba3b9ba4c2cd3676672a1 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 18 Aug 2020 09:47:37
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 3E792C433CA; Tue, 18 Aug 2020 09:47:37 +0000 (UTC)
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 28956C43387;
        Tue, 18 Aug 2020 09:47:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 28956C43387
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/9] ath11k: enable DP interrupt setup for QCA6390
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1597555891-26112-2-git-send-email-kvalo@codeaurora.org>
References: <1597555891-26112-2-git-send-email-kvalo@codeaurora.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20200818094737.3E792C433CA@smtp.codeaurora.org>
Date:   Tue, 18 Aug 2020 09:47:37 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Kalle Valo <kvalo@codeaurora.org> wrote:

> QCA6390 uses MSI interrupt, so need to configure msi_add and
> msi_data to dp srngs. As there are so many DP srngs, so need
> to group them. Each group shares one MSI interrupt.
> 
> Tested-on: QCA6390 hw2.0 PCI WLAN.HST.1.0.1-01740-QCAHSTSWPLZ_V2_TO_X86-1
> Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.1.0.1-01238-QCAHKSWPL_SILICONZ-2
> 
> Signed-off-by: Carl Huang <cjhuang@codeaurora.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

9 patches applied to ath-next branch of ath.git, thanks.

d4ecb90b3857 ath11k: enable DP interrupt setup for QCA6390
7f6fc1ebf5b1 ath11k: don't initialize rxdma1 related ring
4152e4206cc5 ath11k: setup QCA6390 rings for both rxdmas
84eee3c845d3 ath11k: refine the phy_id check in ath11k_reg_chan_list_event
e7495035286a ath11k: delay vdev_start for QCA6390
a6275302c370 ath11k: assign correct search flag and type for QCA6390
454a97217283 ath11k: process both lmac rings for QCA6390
065f5f683ea6 ath11k: use TCL_DATA_RING_0 for QCA6390
f3c603d412b3 ath11k: reset MHI during power down and power up

-- 
https://patchwork.kernel.org/patch/11715971/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

