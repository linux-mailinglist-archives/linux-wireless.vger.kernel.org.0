Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FB152AA33E
	for <lists+linux-wireless@lfdr.de>; Sat,  7 Nov 2020 09:10:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728051AbgKGIK0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 7 Nov 2020 03:10:26 -0500
Received: from z5.mailgun.us ([104.130.96.5]:59730 "EHLO z5.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727937AbgKGIKZ (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 7 Nov 2020 03:10:25 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1604736624; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=GcSXzzns2543ADvOZ5o/O4MwVckPUvjv2DsfDlR3VpQ=;
 b=beSDYCAeEtbT6w6mJI/Q4jUBowyZdyWXHdsbOUhVps6V4ie0EjxwRhWDji/n818ychxMIGUp
 sstGDlgYCs71+ourvNqRI45aKn+MPKI4dngsvxbI/hukwQAtM8stXgSIykJTFkLCUnXULfU+
 0ynzOGuexrxlu9kBh541f3CTAZU=
X-Mailgun-Sending-Ip: 104.130.96.5
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-west-2.postgun.com with SMTP id
 5fa656439d6b206d9416d513 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sat, 07 Nov 2020 08:09:39
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 0C955C433C9; Sat,  7 Nov 2020 08:09:39 +0000 (UTC)
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E0A98C433C8;
        Sat,  7 Nov 2020 08:09:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E0A98C433C8
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 1/3] wcn36xx: Set LINK_FAIL_TX_CNT to 1000 on all
 wcn36xx
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20201103121735.291324-2-bryan.odonoghue@linaro.org>
References: <20201103121735.291324-2-bryan.odonoghue@linaro.org>
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc:     wcn36xx@lists.infradead.org, linux-wireless@vger.kernel.org,
        bryan.odonoghue@linaro.org, shawn.guo@linaro.org,
        loic.poulain@linaro.org
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20201107080939.0C955C433C9@smtp.codeaurora.org>
Date:   Sat,  7 Nov 2020 08:09:39 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Bryan O'Donoghue <bryan.odonoghue@linaro.org> wrote:

> The firmware parameter LINK_FAIL_TX_CNT maps to the prima configuration
> file parameter gLinkFailTxCnt and is described as:
> 
> quote: " If within gLinkFailTimeout period(values is mentioned in msec) if
>          FW doesn't receive acks for gLinkFailTxCnt number of packets, then
>          link will be disconnected."
> 
> The downstream description sets a minimum value of 1000 a maximum value of
> 60000 and a default value of 6000, however it appears that unless we
> actually set this value deliberately firmware defaults it to 0.
> 
> Setting this value to non-zero results in the firmware doing link
> monitoring. The working example from downstream paradoxically sets the
> value to 200, here we opt to set the value to the minimum stipulated in the
> configuration file 1000.
> 
> In conjunction with ieee80211_hw_set(wcn->hw, CONNECTION_MONITOR); this
> change effects offload of link monitoring to the firmware.
> 
> Tested with:
> 'CNSS-PR-2-0-1-2-c1-74-130449-3' wcn3620
> 'CNSS-PR-2-0-1-2-c1-00083'       wcn3680
> 
> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

3 patches applied to ath-next branch of ath.git, thanks.

e24eedc09f14 wcn36xx: Set LINK_FAIL_TX_CNT to 1000 on all wcn36xx
8def9ec46a5f wcn36xx: Enable firmware link monitoring
5336fad96e8f wcn36xx: Enable firmware offloaded keepalive

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20201103121735.291324-2-bryan.odonoghue@linaro.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

