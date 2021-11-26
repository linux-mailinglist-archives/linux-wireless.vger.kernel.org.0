Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7405945EB37
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Nov 2021 11:21:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376716AbhKZKYT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 26 Nov 2021 05:24:19 -0500
Received: from so254-9.mailgun.net ([198.61.254.9]:40122 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353474AbhKZKWS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 26 Nov 2021 05:22:18 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1637921944; h=Date: Message-ID: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=9w6CUHr3DnghWuXieLVzyi3+m3hj9sDLHN8VY6VfoAU=;
 b=MRFAob1qTCkqiQ5o+BaNne6QzHQWqg50TZ5UL/TrPmTJ/lVuMVAKp52VwBoe5A/rQJcLrD7g
 TfI7wobgj6bw7uOyBLMLtgT656WOJeqw7kKC7JE02M6yI0weuWps8qMtiWtzHpl6MlcwKS1i
 VfwuJk0lxteg4J1wfdssa3hd1mY=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-west-2.postgun.com with SMTP id
 61a0b4984fca5da46d47d09e (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 26 Nov 2021 10:19:04
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 14A2BC43617; Fri, 26 Nov 2021 10:19:04 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        MISSING_DATE,SPF_FAIL autolearn=no autolearn_force=no version=3.4.0
Received: from tykki.adurom.net (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 9CC81C4338F;
        Fri, 26 Nov 2021 10:19:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 9CC81C4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath11k: Use host CE parameters for CE interrupts
 configuration
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1637249558-12793-1-git-send-email-akolli@codeaurora.org>
References: <1637249558-12793-1-git-send-email-akolli@codeaurora.org>
To:     Anilkumar Kolli <akolli@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Anilkumar Kolli <akolli@codeaurora.org>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <163792194060.23943.15273022078446639620.kvalo@codeaurora.org>
Date:   Fri, 26 Nov 2021 10:19:04 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Anilkumar Kolli <akolli@codeaurora.org> wrote:

> CE interrupt configuration uses host ce parameters to assign/free
> interrupts. Use host ce parameters to enable/disable interrupts.
> This patch fixes below BUG,
> 
> BUG: KASAN: global-out-of-bounds in 0xffffffbffdfb035c at addr
> ffffffbffde6eeac
>  Read of size 4 by task kworker/u8:2/132
>  Address belongs to variable ath11k_core_qmi_firmware_ready+0x1b0/0x5bc [ath11k]
> 
> OOB is due to ath11k_ahb_ce_irqs_enable() iterates ce_count(which is 12)
> times and accessing 12th element in target_ce_config
> (which has only 11 elements) from ath11k_ahb_ce_irq_enable().
> 
> With this change host ce configs are used to enable/disable interrupts.
> 
> Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.5.0.1-00471-QCAHKSWPL_SILICONZ-1
> 
> Fixes: 967c1d1131fa ("ath11k: move target ce configs to hw_params")
> Signed-off-by: Anilkumar Kolli <akolli@codeaurora.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

b689f091aafd ath11k: Use host CE parameters for CE interrupts configuration

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/1637249558-12793-1-git-send-email-akolli@codeaurora.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

