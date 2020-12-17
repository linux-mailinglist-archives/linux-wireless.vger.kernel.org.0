Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A19B92DCCB1
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Dec 2020 07:47:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727145AbgLQGr0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Dec 2020 01:47:26 -0500
Received: from so254-31.mailgun.net ([198.61.254.31]:46465 "EHLO
        so254-31.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726503AbgLQGr0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Dec 2020 01:47:26 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1608187622; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=JjsO2RQXw5ni68FpX2GXNXsulFW41zzp1/gzEh8ApkY=;
 b=WTJX8kPrBWtmSw/CuEv2BIgEpsAGzD99J8mpNAMbbmcBRTOuOd+tWpJWt5GKwZMCllIK/mkg
 hELdsKr8tp4la8Tufyo2Vf0pXa0Z4PiJNYXGWXAT9rDaFqOsDEGxR2JshEVa2IoXVVxwPdCN
 +LCtNGpbk7s99U3aa+Krh3/jfZY=
X-Mailgun-Sending-Ip: 198.61.254.31
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n08.prod.us-west-2.postgun.com with SMTP id
 5fdafeca93a3d2b1cd88a872 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 17 Dec 2020 06:46:34
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 9A5B9C433ED; Thu, 17 Dec 2020 06:46:34 +0000 (UTC)
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 61CA5C433C6;
        Thu, 17 Dec 2020 06:46:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 61CA5C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath11k: fix crash caused by NULL rx_channel
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20201211055613.9310-1-cjhuang@codeaurora.org>
References: <20201211055613.9310-1-cjhuang@codeaurora.org>
To:     Carl Huang <cjhuang@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20201217064634.9A5B9C433ED@smtp.codeaurora.org>
Date:   Thu, 17 Dec 2020 06:46:34 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Carl Huang <cjhuang@codeaurora.org> wrote:

> During connect and disconnect stress test, crashed happened
> because ar->rx_channel is NULL. Fix it by checking whether
> ar->rx_channel is NULL.
> 
> Crash stack is as below:
> RIP: 0010:ath11k_dp_rx_h_ppdu+0x110/0x230 [ath11k]
> [ 5028.808963]  ath11k_dp_rx_wbm_err+0x14a/0x360 [ath11k]
> [ 5028.808970]  ath11k_dp_rx_process_wbm_err+0x41c/0x520 [ath11k]
> [ 5028.808978]  ath11k_dp_service_srng+0x25e/0x2d0 [ath11k]
> [ 5028.808982]  ath11k_pci_ext_grp_napi_poll+0x23/0x80 [ath11k_pci]
> [ 5028.808986]  net_rx_action+0x27e/0x400
> [ 5028.808990]  __do_softirq+0xfd/0x2bb
> [ 5028.808993]  irq_exit+0xa6/0xb0
> [ 5028.808995]  do_IRQ+0x56/0xe0
> [ 5028.808997]  common_interrupt+0xf/0xf
> 
> Tested-on: QCA6390 hw2.0 PCI WLAN.HST.1.0.1-01740-QCAHSTSWPLZ_V2_TO_X86-1
> 
> Signed-off-by: Carl Huang <cjhuang@codeaurora.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-current branch of ath.git, thanks.

3597010630d0 ath11k: fix crash caused by NULL rx_channel

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20201211055613.9310-1-cjhuang@codeaurora.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

