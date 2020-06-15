Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5767A1F9A55
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Jun 2020 16:33:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730189AbgFOOd4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 15 Jun 2020 10:33:56 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:59123 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728510AbgFOOdz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 15 Jun 2020 10:33:55 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1592231635; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=5gOH39UPn4MmMZoopGjYLJypJG/Wy5zUL/cyYsnAS30=;
 b=Kxr5sMMlKUM4SEVRtE+Qtdnm91vY2mFb5S0G9xxbPYAd9W1QZMlt/Ea1xoP+xvJ5rtZWiw7+
 hsDxWuJ7GxPw++AGuaGlOvSoQ8lOakQK/PYXXtJp74RXem2x7nXabP71XyiYbV0x2H68WW0a
 7wx9/uNVrGQV/yB8vY2Pit6eD0k=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-east-1.postgun.com with SMTP id
 5ee786c7356bcc26ab134128 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 15 Jun 2020 14:33:43
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id CBBFAC433A0; Mon, 15 Jun 2020 14:33:42 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 6DC7CC43395;
        Mon, 15 Jun 2020 14:33:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6DC7CC43395
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/2] ath11k: Add dp tx err stats
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1591768308-32005-2-git-send-email-srirrama@codeaurora.org>
References: <1591768308-32005-2-git-send-email-srirrama@codeaurora.org>
To:     Sriram R <srirrama@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Sriram R <srirrama@codeaurora.org>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20200615143342.CBBFAC433A0@smtp.codeaurora.org>
Date:   Mon, 15 Jun 2020 14:33:42 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Sriram R <srirrama@codeaurora.org> wrote:

> Add support for dp tx error stats which logs tx failure reasons due
> to ring full condition, etc. This stats is added in soc_dp_stats
> which was earlier used as soc_rx_stats so that all dp related info
> are logged in same file.
> 
> Below is an example usage,
> 
> root@OpenWrt:/# cat /sys/kernel/debug/ath11k/ipq8074/soc_dp_stats
> SOC RX STATS:
> 
> err ring pkts: 0
> Invalid RBM: 0
> <snip>
> 
> SOC TX STATS:
> 
> Ring Full Failures:
> ring0: 4
> ring1: 3
> ring2: 5
> 
> Misc Transmit Failures: 2
> 
> Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.1.0.1-01213-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Sriram R <srirrama@codeaurora.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

2 patches applied to ath-next branch of ath.git, thanks.

0dd6392ac2c0 ath11k: Add dp tx err stats
71fbc847978f ath11k: Add support for ring backpressure stats

-- 
https://patchwork.kernel.org/patch/11597089/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

