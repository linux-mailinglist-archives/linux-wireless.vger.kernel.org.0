Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 982D11F9A0C
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Jun 2020 16:25:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730110AbgFOOZ5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 15 Jun 2020 10:25:57 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:18293 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728510AbgFOOZ4 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 15 Jun 2020 10:25:56 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1592231156; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=8r3UdeXD215NHPMMUZifG8mfLcqsOfG3YE8uGeNLI9M=;
 b=EB0Sc9dcMcFSMfuUvD4aZzospYwoxNhlnjshnzcEnIpFXWkFj8JxNzAYF58LRgWA45hTpKUM
 P8o6WyRrVxPzDeVaLQkv5D3WzG2czdv/ZlGG/3nb1UGTc1sCMHhl1YntH3ujPaISwzS5fr0C
 QvQaQ7PoDHckrhcTHw4kaGFTYQs=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n12.prod.us-east-1.postgun.com with SMTP id
 5ee784e7bfb34e631cd399d8 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 15 Jun 2020 14:25:43
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 915E5C43387; Mon, 15 Jun 2020 14:25:42 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 05E53C433CA;
        Mon, 15 Jun 2020 14:25:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 05E53C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 1/2] ath11k: Add direct buffer ring support
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1591688014-26441-1-git-send-email-periyasa@codeaurora.org>
References: <1591688014-26441-1-git-send-email-periyasa@codeaurora.org>
To:     Karthikeyan Periyasamy <periyasa@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Karthikeyan Periyasamy <periyasa@codeaurora.org>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20200615142542.915E5C43387@smtp.codeaurora.org>
Date:   Mon, 15 Jun 2020 14:25:42 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Karthikeyan Periyasamy <periyasa@codeaurora.org> wrote:

> Add direct buffer ring (dbring) with helper API, which is used by the
> spectral scan. Initialise the direct buffer ring based on the dma ring
> capability, which get announced in the wmi service ready extended event.
> This ring is slightly changed from data path rings. Compare to data path
> ring this ring shares the hp and tp address to firmware though WMI commands.
> Also the replenish buffer size is derived from firmware announcement.
> driver receive indication through WMI event
> WMI_PDEV_DMA_RING_BUF_RELEASE_EVENTID.
> 
> Tested-on: IPQ8074 WLAN.HK.2.1.0.1-01228-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Karthikeyan Periyasamy <periyasa@codeaurora.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

2 patches applied to ath-next branch of ath.git, thanks.

bd6478559e27 ath11k: Add direct buffer ring support
9d11b7bff950 ath11k: add support for spectral scan

-- 
https://patchwork.kernel.org/patch/11594695/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

