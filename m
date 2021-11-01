Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B106D441C53
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Nov 2021 15:13:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231874AbhKAOQZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 1 Nov 2021 10:16:25 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:15584 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbhKAOQY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 1 Nov 2021 10:16:24 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1635776031; h=Date: Message-ID: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=hfPTa5dxL3T5AIUBZZwn7bV77RB+FEBII+Ne84D4g4c=;
 b=h4Am5HfJG+5Vw0do9Jwok4zE11geK4zTioXaRDaaBvE1IjpaXE95B6jHbA2yzybo7aBxoRgt
 9H0dk0TqRx/9Y111zWvVo55DK65t3pnEJsCbwWP1Ddh39Yy98h2yDI6drLV6NH43UXOaljMc
 JP7gu5O71zqxu4j0QkM7wFf2Ymk=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-east-1.postgun.com with SMTP id
 617ff61e2e144ac4d31aa288 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 01 Nov 2021 14:13:49
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id F3BA9C4360D; Mon,  1 Nov 2021 14:13:47 +0000 (UTC)
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2437DC4338F;
        Mon,  1 Nov 2021 14:13:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 2437DC4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 3/3] ath11k: set correct NL80211_FEATURE_DYNAMIC_SMPS for
 WCN6855
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20210914163726.38604-3-jouni@codeaurora.org>
References: <20210914163726.38604-3-jouni@codeaurora.org>
To:     Jouni Malinen <jouni@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Wen Gong <wgong@codeaurora.org>,
        Jouni Malinen <jouni@codeaurora.org>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <163577602395.7461.6563543942960093028.kvalo@codeaurora.org>
Date:   Mon,  1 Nov 2021 14:13:47 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Jouni Malinen <jouni@codeaurora.org> wrote:

> Commit 6f4d70308e5e ("ath11k: support SMPS configuration for 6 GHz") changed
> "if (ht_cap & WMI_HT_CAP_DYNAMIC_SMPS)" to "if (ht_cap &
> WMI_HT_CAP_DYNAMIC_SMPS || ar->supports_6ghz)" which means
> NL80211_FEATURE_DYNAMIC_SMPS is enabled for all chips which support 6 GHz.
> However, WCN6855 supports 6 GHz but it does not support feature
> NL80211_FEATURE_DYNAMIC_SMPS, and this can lead to MU-MIMO test failures for
> WCN6855.
> 
> Disable NL80211_FEATURE_DYNAMIC_SMPS for WCN6855 since its ht_cap does not
> support WMI_HT_CAP_DYNAMIC_SMPS. Enable the feature only on QCN9074 as that's
> the only other device supporting 6 GHz band.
> 
> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-01720.1-QCAHSPSWPL_V1_V2_SILICONZ_LITE-1
> 
> Signed-off-by: Wen Gong <wgong@codeaurora.org>
> Signed-off-by: Jouni Malinen <jouni@codeaurora.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

82c434c10340 ath11k: set correct NL80211_FEATURE_DYNAMIC_SMPS for WCN6855

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20210914163726.38604-3-jouni@codeaurora.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

