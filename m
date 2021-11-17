Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAEA84542F2
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Nov 2021 09:49:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234613AbhKQIvy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 17 Nov 2021 03:51:54 -0500
Received: from m43-7.mailgun.net ([69.72.43.7]:14534 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234606AbhKQIvu (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 17 Nov 2021 03:51:50 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1637138930; h=Date: Message-ID: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=Va4OnKJJNqeV+RT0nY6jUwSah1RO4b+0ZmF3us1G63E=;
 b=nokJyB74I/l2AmfqtCQWvZHD9ic0HpbWKx7KhBCVStcG0t3xK/NUDm4N46PIiHNRTCn10cEQ
 LrHCCeBBG+l+N2HtoXwNosEf6OWuaL1J5x7yNGwDEyTLBS6IfzDDeMrBw5bvJaQrtQdj9xyr
 5T5o3ZQ9WOc8Is1+vSvIHzVp5EA=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-east-1.postgun.com with SMTP id
 6194c1f1638a2f4d6141fae3 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 17 Nov 2021 08:48:49
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id CD348C43460; Wed, 17 Nov 2021 08:48:48 +0000 (UTC)
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 33E47C4338F;
        Wed, 17 Nov 2021 08:48:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 33E47C4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v4 1/4] ath11k: add ath11k_qmi_free_resource() for
 recovery
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20211116041522.23529-2-quic_wgong@quicinc.com>
References: <20211116041522.23529-2-quic_wgong@quicinc.com>
To:     Wen Gong <quic_wgong@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        <quic_wgong@quicinc.com>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <163713892498.10263.2312396236754200205.kvalo@codeaurora.org>
Date:   Wed, 17 Nov 2021 08:48:48 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Wen Gong <quic_wgong@quicinc.com> wrote:

> ath11k_qmi_free_target_mem_chunk() and ath11k_qmi_m3_free() is static
> in qmi.c, they are needed for recovery, export them in a new function.
> 
> Tested-on: QCA6390 hw2.0 PCI WLAN.HST.1.0.1-01740-QCAHSTSWPLZ_V2_TO_X86-1
> 
> Signed-off-by: Wen Gong <quic_wgong@quicinc.com>

Wen mentioned me privately that some extra features are needed to get
this working, so dropping the patchset.

4 patches set to Changes Requested.

12621327 [v4,1/4] ath11k: add ath11k_qmi_free_resource() for recovery
12621331 [v4,2/4] ath11k: fix invalid m3 buffer address
12621329 [v4,3/4] ath11k: add support for device recovery for QCA6390
12621333 [v4,4/4] ath11k: add synchronization operation between reconfigure of mac80211 and ath11k_base

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20211116041522.23529-2-quic_wgong@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

