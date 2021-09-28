Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2F5941B192
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Sep 2021 16:07:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240684AbhI1OIz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 28 Sep 2021 10:08:55 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:57271 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233878AbhI1OIy (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 28 Sep 2021 10:08:54 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1632838035; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=WwNHM09Qr4p8cXcsFb6DLViXvQmDCcjJuGzRyvPrsTg=;
 b=vhVOzbe0Lb9m4/qH1Vx5UFqphKK7M6YeJADQYP1KJMRySd3JacWaBu8NNh601JtrVD5k5KeS
 us88PteUXT9jg3G6QMmDORE4yPvbVU3/ESPEC5qvVHN6N8KApuXIER04UzhhGehgpbimCGw3
 DRGjFyj1LQo5HL7DxH54+4FtePw=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-west-2.postgun.com with SMTP id
 6153213a519bd8dcf02b75ea (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 28 Sep 2021 14:05:46
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id DD463C4360D; Tue, 28 Sep 2021 14:05:45 +0000 (UTC)
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A5261C4338F;
        Tue, 28 Sep 2021 14:05:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org A5261C4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2] ath11k: Change DMA_FROM_DEVICE to DMA_TO_DEVICE when
 map
 reinjected packets
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20210916064617.20006-1-bqiang@codeaurora.org>
References: <20210916064617.20006-1-bqiang@codeaurora.org>
To:     Baochen Qiang <bqiang@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-Id: <20210928140545.DD463C4360D@smtp.codeaurora.org>
Date:   Tue, 28 Sep 2021 14:05:45 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Baochen Qiang <bqiang@codeaurora.org> wrote:

> For fragmented packets, ath11k reassembles each fragment as a normal
> packet and then reinjects it into HW ring. In this case, the DMA
> direction should be DMA_TO_DEVICE, not DMA_FROM_DEVICE, otherwise
> invalid payload will be reinjected to HW and then delivered to host.
> What is more, since arbitrary memory could be allocated to the frame, we
> don't know what kind of data is contained in the buffer reinjected.
> Thus, as a bad result, private info may be leaked.
> 
> Note that this issue is only found on Intel platform.
> 
> Tested-on: QCA6390 hw2.0 PCI WLAN.HST.1.0.1-01740-QCAHSTSWPLZ_V2_TO_X86-1
> Signed-off-by: Baochen Qiang <bqiang@codeaurora.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

86a03dad0f5a ath11k: Change DMA_FROM_DEVICE to DMA_TO_DEVICE when map reinjected packets

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20210916064617.20006-1-bqiang@codeaurora.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

