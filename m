Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5991942B5F7
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Oct 2021 07:47:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230396AbhJMFte (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 13 Oct 2021 01:49:34 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:26632 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229514AbhJMFtd (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 13 Oct 2021 01:49:33 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1634104050; h=Date: Message-ID: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=a1HfOCtIMRXaZW1IUD3cf4eoXu+DtmiWmpf2hTFZPcE=;
 b=JvYAKYyVjyUdGOuA0z6q7CEnf27h4CNUqMomwoUDFg6ApVSFzbCgA33M7zj3YjyFHRg1RNHM
 mLOOqShB5GfSnVV+SFH9pquxqra1dKH+rAQtHWFYQTcrc+O1PLz0p5pcU1qGVk91YGek0rhG
 cAJWce7DRlPT1OJYpV8yVKS8NFE=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-east-1.postgun.com with SMTP id
 616672f2ab9da96e64965979 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 13 Oct 2021 05:47:30
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 7A54CC4360D; Wed, 13 Oct 2021 05:47:28 +0000 (UTC)
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 39E92C4338F;
        Wed, 13 Oct 2021 05:47:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 39E92C4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath11k: Identify DFS channel when sending scan channel
 list
 command
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20211011054919.77071-1-bqiang@codeaurora.org>
References: <20211011054919.77071-1-bqiang@codeaurora.org>
To:     Baochen Qiang <bqiang@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <163410404522.12797.13953089628773555081.kvalo@codeaurora.org>
Date:   Wed, 13 Oct 2021 05:47:28 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Baochen Qiang <bqiang@codeaurora.org> wrote:

> WMI_CHAN_INFO_DFS flag should be set when configuring a DFS channel
> included in scan channel list. Without it, firmware will not send a
> probe request frame which is needed in connection to an AP configured
> with hidden SSID/network_id. So fix this to allow probe request frames
> to be sent in cases where a beacon frame has been seen on the channel
> first.
> 
> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-01720.1-QCAHSPSWPL_V1_V2_SILICONZ_LITE-1
> 
> Signed-off-by: Baochen Qiang <bqiang@codeaurora.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

8cd5c0847160 ath11k: Identify DFS channel when sending scan channel list command

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20211011054919.77071-1-bqiang@codeaurora.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

