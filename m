Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF8442CC4EA
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Dec 2020 19:21:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728569AbgLBSUW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 2 Dec 2020 13:20:22 -0500
Received: from a2.mail.mailgun.net ([198.61.254.61]:13382 "EHLO
        a2.mail.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726485AbgLBSUW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 2 Dec 2020 13:20:22 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1606933203; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=NiFwrQPOVHKDRXObfWwk8zeZXK0CrJb1qJLwu7JF1kc=;
 b=G+u1UrQ+YBfiHmQmUSCfwl9J9bd1qvzwgRh7+213okNyFIwfAXdRHdgkgmb1oHbT+fsqH65N
 B/PYJY4eAuyN7brXuP26ubN5uJusSkxaEP8z/C4RiiKWePiBW+7cdHBpjyUyob90jo3N56aZ
 clW3Ct2U2ANChOsTssb2cE3e8jo=
X-Mailgun-Sending-Ip: 198.61.254.61
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-west-2.postgun.com with SMTP id
 5fc7dab67463e149b4b0f68c (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 02 Dec 2020 18:19:34
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 4108AC43460; Wed,  2 Dec 2020 18:19:34 +0000 (UTC)
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A2D4CC433C6;
        Wed,  2 Dec 2020 18:19:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A2D4CC433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 1/3] ath11k: Don't cast ath11k_skb_cb to
 ieee80211_tx_info.control
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20201119154235.263250-1-sven@narfation.org>
References: <20201119154235.263250-1-sven@narfation.org>
To:     Sven Eckelmann <sven@narfation.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Sven Eckelmann <sven@narfation.org>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20201202181934.4108AC43460@smtp.codeaurora.org>
Date:   Wed,  2 Dec 2020 18:19:34 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Sven Eckelmann <sven@narfation.org> wrote:

> The driver_data area of ieee80211_tx_info is used in ath11k for
> ath11k_skb_cb. The first function in the TX patch which rewrites it to
> ath11k_skb_cb is already ath11k_mac_op_tx. No one else in the code path
> must use it for something else before it reinitializes it. Otherwise the
> data has to be considered uninitialized or corrupt.
> 
> But the ieee80211_tx_info.control shares exactly the same area as
> ieee80211_tx_info.driver_data and ath11k is still using it. This results in
> best case in a
> 
>   ath11k c000000.wifi1: no vif found for mgmt frame, flags 0x0
> 
> or (slightly worse) in a kernel oops.
> 
> Instead, the interesting data must be moved first into the ath11k_skb_cb
> and ieee80211_tx_info.control must then not be used anymore.
> 
> Tested-on: IPQ8074 hw2.0 WLAN.HK.2.4.0.1.r1-00026-QCAHKSWPL_SILICONZ-2
> 
> Fixes: d5c65159f289 ("ath11k: driver for Qualcomm IEEE 802.11ax devices")
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

3 patches applied to ath-next branch of ath.git, thanks.

f4d291b43f80 ath11k: Don't cast ath11k_skb_cb to ieee80211_tx_info.control
5da7acfec5ec ath11k: Reset ath11k_skb_cb before setting new flags
d35d1375493b ath11k: Build check size of ath11k_skb_cb

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20201119154235.263250-1-sven@narfation.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

