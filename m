Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A9B0459046
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Nov 2021 15:33:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239732AbhKVOg1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 22 Nov 2021 09:36:27 -0500
Received: from m43-7.mailgun.net ([69.72.43.7]:60915 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229542AbhKVOg0 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 22 Nov 2021 09:36:26 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1637591600; h=Date: Message-ID: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=ZHpkgoNKWuKGIQ5C01H85WdRGNvZkXSL+ZCzdACppfY=;
 b=GmaSBqtn6/NoaEjO7Z2upHph3/56W1c2xNnpvamV/1zZMJ9Wm9PhCvyk96JVLvnC45zFlt5W
 nySVGjYGjMF1JGe6KdArrCXyVGheXQAFfhEj+dhW2miLrW8Hw7g7S0LaNeTvaYlqVn723sHi
 iyHnD36uCnGwl2B4KCxrhQNjZxU=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-east-1.postgun.com with SMTP id
 619baa30e7d68470af8f526a (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 22 Nov 2021 14:33:19
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 40A2BC43617; Mon, 22 Nov 2021 14:33:19 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        MISSING_DATE,SPF_FAIL autolearn=no autolearn_force=no version=3.4.0
Received: from tykki.adurom.net (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 950A3C4338F;
        Mon, 22 Nov 2021 14:33:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 950A3C4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2] ath11k: calculate the correct NSS of peer for HE
 capabilities
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20211118095453.8030-1-quic_wgong@quicinc.com>
References: <20211118095453.8030-1-quic_wgong@quicinc.com>
To:     Wen Gong <quic_wgong@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        <quic_wgong@quicinc.com>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <163759159549.17469.13861131586880509051.kvalo@codeaurora.org>
Date:   Mon, 22 Nov 2021 14:33:19 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Wen Gong <quic_wgong@quicinc.com> wrote:

> When connected to 6G mode AP, it does not have VHT/HT capabilities,
> so the NSS is not set, then it is 1 by default.
> 
> This patch is to calculate the NSS with supported HE-MCS and NSS set
> of HE capabilities.
> 
> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-01280-QCAHSPSWPL_V1_V2_SILICONZ_LITE-1
> 
> Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

3db26ecf7114 ath11k: calculate the correct NSS of peer for HE capabilities

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20211118095453.8030-1-quic_wgong@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

