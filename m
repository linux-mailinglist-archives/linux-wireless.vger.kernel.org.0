Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B1EC273C31
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Sep 2020 09:42:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730069AbgIVHmQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 22 Sep 2020 03:42:16 -0400
Received: from m42-4.mailgun.net ([69.72.42.4]:10488 "EHLO m42-4.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729751AbgIVHmQ (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 22 Sep 2020 03:42:16 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1600760535; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=9i2k88Y2UMhNh52PW5o5XuauMfBkl2RWDihpUR6fjl8=;
 b=XmrJq4tE2N0TJKeipxqUurnC4vmaAkYmYjic+MdnvAYWrqfpO5SHTFRiBW7w97D1RoXSVyLR
 Ph4VDHScvS5oSsFeEFrz6hvXujxeIP1TsJsnEdm5Us1qknFGH7BdphjRE+BZS6Spq+9AZfJH
 /BEuUUPl2NIUJgFvypbk5caoCMY=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-east-1.postgun.com with SMTP id
 5f69aad7cb82ff92d18a93a9 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 22 Sep 2020 07:42:15
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id EB4F0C433C8; Tue, 22 Sep 2020 07:42:14 +0000 (UTC)
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 7DC49C433CA;
        Tue, 22 Sep 2020 07:42:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7DC49C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/4] ath11k: refactor debugfs code into debugfs.c
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1600264523-12939-1-git-send-email-kvalo@codeaurora.org>
References: <1600264523-12939-1-git-send-email-kvalo@codeaurora.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20200922074214.EB4F0C433C8@smtp.codeaurora.org>
Date:   Tue, 22 Sep 2020 07:42:14 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Kalle Valo <kvalo@codeaurora.org> wrote:

> If CONFIG_ATH11K_DEBUGFS is disabled there are warnings debug.c:
> 
> drivers/net/wireless/ath/ath11k/debug.c:36:20: warning: 'htt_bp_lmac_ring' defined but not used [-Wunused-variable]
>    36 | static const char *htt_bp_lmac_ring[HTT_SW_LMAC_RING_IDX_MAX] = {
>       |                    ^~~~~~~~~~~~~~~~
> drivers/net/wireless/ath/ath11k/debug.c:15:20: warning: 'htt_bp_umac_ring' defined but not used [-Wunused-variable]
>    15 | static const char *htt_bp_umac_ring[HTT_SW_UMAC_RING_IDX_MAX] = {
>       |                    ^~~~~~~~~~~~~~~~
> 
> Fix this by refactoring debugfs code to debugfs.c. This also reduces the number
> of ifdefs in debug.c and makes it easier to maintain the code.
> 
> No functional changes. Compile tested only.
> 
> Reported-by: YueHaibing <yuehaibing@huawei.com>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

4 patches applied to ath-next branch of ath.git, thanks.

da3a9d3c1576 ath11k: refactor debugfs code into debugfs.c
cb4e57db2ff0 ath11k: debugfs: use ath11k_debugfs_ prefix
56292162b9a2 ath11k: rename debug_htt_stats.[c|h] to debugfs_htt_stats.[c|h]
568f06036ee2 ath11k: debugfs: move some function declarations to correct header files

-- 
https://patchwork.kernel.org/patch/11781017/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

