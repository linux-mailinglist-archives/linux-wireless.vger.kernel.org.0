Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC510454317
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Nov 2021 09:56:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234725AbhKQI7c (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 17 Nov 2021 03:59:32 -0500
Received: from m43-7.mailgun.net ([69.72.43.7]:29717 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234712AbhKQI7c (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 17 Nov 2021 03:59:32 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1637139393; h=Date: Message-ID: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=Yf5qxhfCd3KnTbByiXlNJjpBDBIGBtWq45dVk6Q4nqI=;
 b=LYdZbTGtabxdx6R1LNOAfd5fRVP/8zX3QbYZdTZpkcqWxtvlgQd/l2MQkNGwJXrCYSgJ1YiX
 hR8JJBNaUezViySgyqlobj6C9paIJEtjCqXpaVzwzWZopW1Di5J8pwBWmCz6jkQGGnBOsfVO
 wNNkvDlMPvPpUjlRaqAYdAuX+Po=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-west-2.postgun.com with SMTP id
 6194c3c15bbbed1f707282ca (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 17 Nov 2021 08:56:33
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 2A95BC43460; Wed, 17 Nov 2021 08:56:33 +0000 (UTC)
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B6A48C4338F;
        Wed, 17 Nov 2021 08:56:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org B6A48C4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath11k: fix read fail for htt_stats and htt_peer_stats
 for
 single pdev
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20211028024749.15039-1-quic_wgong@quicinc.com>
References: <20211028024749.15039-1-quic_wgong@quicinc.com>
To:     Wen Gong <quic_wgong@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        <quic_wgong@quicinc.com>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <163713939005.10263.8670565853421065012.kvalo@codeaurora.org>
Date:   Wed, 17 Nov 2021 08:56:33 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Wen Gong <quic_wgong@quicinc.com> wrote:

> The pdev id is set to 0 for single pdev configured hardware, the real
> pdev id is not 0 in firmware, for example, its pdev id is 1 for 5G/6G
> phy and 2 for 2G band phy. For HTT_H2T_MSG_TYPE_EXT_STATS_CFG message,
> firmware parse the pdev_mask to its pdev id, ath11k set it to 0 for
> single pdev, it is not correct, need set it with the real pdev id of
> firmware.
> 
> Save the real pdev id report by firmware and set it correctly.
> 
> Below commands run success with this patch:
> cat /sys/kernel/debug/ieee80211/phy0/ath11k/htt_stats
> cat /sys/kernel/debug/ieee80211/phy0/netdev\:wls1/stations/00\:03\:7f\:75\:59\:85/htt_peer_stats
> 
> Tested-on: QCA6390 hw2.0 PCI WLAN.HST.1.0.1-01740-QCAHSTSWPLZ_V2_TO_X86-1
> 
> Signed-off-by: Wen Gong <quic_wgong@quicinc.com>

Fails to apply:

error: patch failed: drivers/net/wireless/ath/ath11k/mac.h:150
error: drivers/net/wireless/ath/ath11k/mac.h: patch does not apply
error: patch failed: drivers/net/wireless/ath/ath11k/wmi.h:115
error: drivers/net/wireless/ath/ath11k/wmi.h: patch does not apply
stg import: Diff does not apply cleanly

Patch set to Changes Requested.

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20211028024749.15039-1-quic_wgong@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

