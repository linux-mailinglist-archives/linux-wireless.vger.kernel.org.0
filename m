Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6DC6459050
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Nov 2021 15:35:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234216AbhKVOiz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 22 Nov 2021 09:38:55 -0500
Received: from m43-7.mailgun.net ([69.72.43.7]:49152 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230406AbhKVOiy (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 22 Nov 2021 09:38:54 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1637591748; h=Date: Message-ID: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=oDco1W0yo0ZflzwxdmHUbxk06U3HPk3Nol4h3voQ7lI=;
 b=mkwlNpgSbru0bSkIewmhVowZdP8hs7wkUdKgfmFbj+yvAo7vuJyLcc8gRSWgUP5kv5jklEmo
 aVftUDz5Fi9xDkj8tQlPKkY7TwWAyyKL6BX/Y99PBtShsV0+6j+94nsLaMGb5/9k0yHk3BrQ
 4K5BII4zXyxju8+mfD3NZ2MAUJo=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-west-2.postgun.com with SMTP id
 619baac3db3ac5552ac411c3 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 22 Nov 2021 14:35:47
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 575F3C4360D; Mon, 22 Nov 2021 14:35:47 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        MISSING_DATE,SPF_FAIL autolearn=no autolearn_force=no version=3.4.0
Received: from tykki.adurom.net (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id EF9F7C4338F;
        Mon, 22 Nov 2021 14:35:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org EF9F7C4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath11k: Fix mon status ring rx tlv processing
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1637249433-10316-1-git-send-email-akolli@codeaurora.org>
References: <1637249433-10316-1-git-send-email-akolli@codeaurora.org>
To:     Anilkumar Kolli <akolli@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Anilkumar Kolli <akolli@codeaurora.org>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <163759174403.17469.952754430187601558.kvalo@codeaurora.org>
Date:   Mon, 22 Nov 2021 14:35:47 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Anilkumar Kolli <akolli@codeaurora.org> wrote:

> In HE monitor capture, HAL_TLV_STATUS_PPDU_DONE is received
> on processing multiple skb. Do not clear the ppdu_info
> till the HAL_TLV_STATUS_PPDU_DONE is received.
> 
> This fixes below warning and packet drops in monitor mode.
>  "Rate marked as an HE rate but data is invalid: MCS: 6, NSS: 0"
>  WARNING: at
>  PC is at ieee80211_rx_napi+0x624/0x840 [mac80211]
> 
> Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.4.0.1-01693-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Anilkumar Kolli <akolli@codeaurora.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

09f16f7390f3 ath11k: Fix mon status ring rx tlv processing

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/1637249433-10316-1-git-send-email-akolli@codeaurora.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

