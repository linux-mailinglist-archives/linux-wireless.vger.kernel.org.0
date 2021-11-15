Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E5FA450142
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Nov 2021 10:24:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236795AbhKOJ1o (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 15 Nov 2021 04:27:44 -0500
Received: from so254-9.mailgun.net ([198.61.254.9]:23415 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236726AbhKOJ0x (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 15 Nov 2021 04:26:53 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1636968218; h=Date: Message-ID: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=51ZJd/BR9naZgNiUMYvpRqSj1Wh4i31hMiePREeDHEs=;
 b=Oi4a9p+EGTwhLrJ9SQDHBM1kZc1XyMKoDtUjRNzz0GRo92P6bIApT4zKegr7IIU4JiA36Fi+
 x5omCMXtA79K3AeacQLSR6P+JgaPUsFBPaR5mtsFjoBv+tEhzJN/d6yDERlVW8vouPMS8plB
 4hkcdnP8ydCg+IWyJCnG6PnGvWU=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-east-1.postgun.com with SMTP id
 6192271ae10f164c25e3ce13 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 15 Nov 2021 09:23:38
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 98FB6C43617; Mon, 15 Nov 2021 09:23:37 +0000 (UTC)
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2F8B7C4360D;
        Mon, 15 Nov 2021 09:23:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 2F8B7C4360D
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath11k: remove return for empty tx bitrate in
 mac_op_sta_statistics
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20211011084957.31024-1-wgong@codeaurora.org>
References: <20211011084957.31024-1-wgong@codeaurora.org>
To:     Wen Gong <wgong@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        wgong@codeaurora.org
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <163696821403.13305.6349062465191543646.kvalo@codeaurora.org>
Date:   Mon, 15 Nov 2021 09:23:37 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Wen Gong <wgong@codeaurora.org> wrote:

> Currently in ath11k_mac_op_sta_statistics() there is the following
> logic:
> 
>     if (!arsta->txrate.legacy && !arsta->txrate.nss)
>         return;
> 
> Unfortunately if this condition is true then the function returns without
> setting parameters that follow the txrate. To address this issue remove the
> return and instead invert the logic to set the txrate logic if
> (arsta->txrate.legacy || arsta->txrate.nss).
> 
> The same was done also in ath10k in commit 1cd6ba8ae33e ("ath10k: remove return
> for NL80211_STA_INFO_TX_BITRATE").
> 
> Tested-on: QCA6390 hw2.0 PCI WLAN.HST.1.0.1-01740-QCAHSTSWPLZ_V2_TO_X86-1
> 
> Signed-off-by: Wen Gong <wgong@codeaurora.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

1d795645e1ee ath11k: remove return for empty tx bitrate in mac_op_sta_statistics

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20211011084957.31024-1-wgong@codeaurora.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

