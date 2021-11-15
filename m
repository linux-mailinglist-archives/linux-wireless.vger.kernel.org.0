Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B96A45013D
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Nov 2021 10:24:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237631AbhKOJ1m (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 15 Nov 2021 04:27:42 -0500
Received: from m43-7.mailgun.net ([69.72.43.7]:58692 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237406AbhKOJ1D (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 15 Nov 2021 04:27:03 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1636968240; h=Date: Message-ID: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=Weu2P/9NYhssav+j+Glni3YWiyeayTm+DyG80/W6ZZ0=;
 b=i6eveFzBHLSg5IKf7LvmAyFi57/hSo+Oo5UjvwzYH9oPvirVPkPuCGcVgvIlUuLFLMl30Hnm
 nJxfwHbFRBQZDLj3MDyMt+59xV15SYw8yJSds7hnQLGRWNPu3I2Al5OpSyKPfJLeoH29ims9
 kOw0T/RK8PvkwwpkM7Npl15qtus=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-east-1.postgun.com with SMTP id
 6192272fa9c3e8b85b3835c0 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 15 Nov 2021 09:23:59
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 11B03C43460; Mon, 15 Nov 2021 09:23:59 +0000 (UTC)
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 70F38C4338F;
        Mon, 15 Nov 2021 09:23:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 70F38C4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath11k: fix the value of msecs_to_jiffies in
 ath11k_debugfs_fw_stats_request
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20211026032014.27010-1-quic_wgong@quicinc.com>
References: <20211026032014.27010-1-quic_wgong@quicinc.com>
To:     Wen Gong <quic_wgong@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        <quic_wgong@quicinc.com>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <163696823438.13305.3819550626057098374.kvalo@codeaurora.org>
Date:   Mon, 15 Nov 2021 09:23:59 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Wen Gong <quic_wgong@quicinc.com> wrote:

> parameter of msecs_to_jiffies should be (3 * 1000) instead of (3 * HZ)
> 
> Tested-on: QCA6390 hw2.0 PCI WLAN.HST.1.0.1-01740-QCAHSTSWPLZ_V2_TO_X86-1
> 
> Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

c8f2d41bbff6 ath11k: fix the value of msecs_to_jiffies in ath11k_debugfs_fw_stats_request

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20211026032014.27010-1-quic_wgong@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

