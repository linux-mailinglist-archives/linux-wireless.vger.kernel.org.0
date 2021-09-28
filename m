Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55A3C41AD6C
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Sep 2021 12:58:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239917AbhI1K7y (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 28 Sep 2021 06:59:54 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:25146 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239306AbhI1K7x (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 28 Sep 2021 06:59:53 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1632826694; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=m8CTrL7XG7v1AOE4JfUqqcNOP2MpWjihu+TTfoSDjfA=;
 b=EfG1B+Kj9s5Zt0a9Roin6vo7A4xudc+gBHtNfN21dx5ldHZWhYNYwxmPXwI2ITWSBSz2Vbtw
 bjhvXQA0wcAdUSKCCgGgDh9ir0j5g89nJ5FozfdTdzvbjH9tLXYQMxql9/6qGbBMd64HcXla
 ow5bzou/v2rrB4hPWGxvjQBuu4Q=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-west-2.postgun.com with SMTP id
 6152f53d47d64efb6dfa9295 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 28 Sep 2021 10:58:05
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id A4DBEC43460; Tue, 28 Sep 2021 10:58:05 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        MISSING_DATE,MISSING_MID,SPF_FAIL autolearn=no autolearn_force=no
        version=3.4.0
Received: from tykki.adurom.net (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E6F41C4338F;
        Tue, 28 Sep 2021 10:58:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org E6F41C4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 01/12] ath11k: Fix pktlog lite rx events
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20210721212029.142388-1-jouni@codeaurora.org>
References: <20210721212029.142388-1-jouni@codeaurora.org>
To:     Jouni Malinen <jouni@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Anilkumar Kolli <akolli@codeaurora.org>,
        Jouni Malinen <jouni@codeaurora.org>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-Id: <20210928105805.A4DBEC43460@smtp.codeaurora.org>
Date:   Tue, 28 Sep 2021 10:58:05 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Jouni Malinen <jouni@codeaurora.org> wrote:

> Fix sending rx_buf_sz to ath11k_dp_tx_htt_rx_filter_setup()
> to enable pktlog full or lite mode. Depending on mode update the
> trace buffer with log type full/lite.
> 
> Pktlog lite is a lighter version of pktlog. This can be used to capture
> PPDU stats. These are useful for firmware performance debugging.
> 
> pktlog lite dumps are enabled using,
>   echo "0x0 1" > ath11k/IPQ8074 hw2.0/mac0/pktlog_filter
> 
> Tested On: IPQ8074 hw2.0 AHB WLAN.HK.2.1.0.1-01233-QCAHKSWPL_SILICONZ-1 v2
> 
> Signed-off-by: Anilkumar Kolli <akolli@codeaurora.org>
> Signed-off-by: Jouni Malinen <jouni@codeaurora.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

9 patches applied to ath-next branch of ath.git, thanks.

ab18e3bc1c13 ath11k: Fix pktlog lite rx events
f394e4eae8e2 ath11k: Update pdev tx and rx firmware stats
69a0fcf8a9f2 ath11k: Avoid reg rules update during firmware recovery
1db2b0d0a391 ath11k: Avoid race during regd updates
8717db7ee802 ath11k: Add vdev start flag to disable hardware encryption
3c79cb4d63c0 ath11k: Assign free_vdev_map value before ieee80211_register_hw
8ee8d38ca472 ath11k: Fix crash during firmware recovery on reo cmd ring access
79feedfea779 ath11k: Avoid "No VIF found" warning message
94a6df31dcf0 ath11k: Add wmi peer create conf event in wmi_tlv_event_id

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20210721212029.142388-1-jouni@codeaurora.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

