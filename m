Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C5CC40D6F7
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Sep 2021 12:02:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235520AbhIPKDi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 16 Sep 2021 06:03:38 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:23747 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235287AbhIPKDi (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 16 Sep 2021 06:03:38 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1631786538; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=8e7o0uD19m0JH0RLYxasicySgpEqt6t3RqCtcKR3flc=; b=W10VkJV+3F4gB0UBW++8juakF4X1uzBXrt77hs7EDB6MR+qpY82b8YxZkF7iDL8Dn+r6pJTi
 hM1t7WkYOMIMaPJbJ9UDyD420xQKRya7n7OMBDEZ+LR7vf/LX9UeTzVTjn7f5jMlm1pk3b+a
 dOm8oV4eq+Zj7w4xh3xZQfJ3jyc=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-west-2.postgun.com with SMTP id
 61431623e0f78151d6b5b5ed (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 16 Sep 2021 10:02:11
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id BC55EC43460; Thu, 16 Sep 2021 10:02:10 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from tykki (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0F7FDC4338F;
        Thu, 16 Sep 2021 10:02:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 0F7FDC4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Jouni Malinen <jouni@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Baochen Qiang <bqiang@codeaurora.org>
Subject: Re: [PATCH 2/3] ath11k: change return buffer manager for QCA6390
References: <20210914163726.38604-1-jouni@codeaurora.org>
        <20210914163726.38604-2-jouni@codeaurora.org>
Date:   Thu, 16 Sep 2021 13:02:04 +0300
In-Reply-To: <20210914163726.38604-2-jouni@codeaurora.org> (Jouni Malinen's
        message of "Tue, 14 Sep 2021 19:37:25 +0300")
Message-ID: <87ilz0zvmr.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Jouni Malinen <jouni@codeaurora.org> writes:

> From: Baochen Qiang <bqiang@codeaurora.org>
>
> QCA6390 firmware uses HAL_RX_BUF_RBM_SW1_BM, not HAL_RX_BUF_RBM_SW3_BM.
>
> Tested-on: QCA6390 hw2.0 PCI WLAN.HST.1.0.1-01740-QCAHSTSWPLZ_V2_TO_X86-1
>
> Signed-off-by: Baochen Qiang <bqiang@codeaurora.org>
> Signed-off-by: Jouni Malinen <jouni@codeaurora.org>

There were checkpatch warnings, I fixex them in the pending branch:

drivers/net/wireless/ath/ath11k/dp.c:825: line length of 97 exceeds 90 columns
drivers/net/wireless/ath/ath11k/hal_rx.c:375: line length of 95 exceeds 90 columns
drivers/net/wireless/ath/ath11k/dp_rx.c:3073: line length of 94 exceeds 90 columns
drivers/net/wireless/ath/ath11k/dp_rx.c:3083: line length of 94 exceeds 90 columns
drivers/net/wireless/ath/ath11k/dp_rx.c:3472: line length of 100 exceeds 90 columns
drivers/net/wireless/ath/ath11k/dp_rx.c:5104: line length of 93 exceeds 90 columns
drivers/net/wireless/ath/ath11k/dp_rx.c:5109: line length of 93 exceeds 90 columns

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
