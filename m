Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45D89297043
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Oct 2020 15:20:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S464525AbgJWNUH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 23 Oct 2020 09:20:07 -0400
Received: from m42-4.mailgun.net ([69.72.42.4]:47523 "EHLO m42-4.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S464523AbgJWNUF (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 23 Oct 2020 09:20:05 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1603459204; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=q4fCeaIVxrqKM26HyZutm1+Ob7EPy4ub2dyXa+njdMQ=; b=tC5kk4v69Ve70McUzYT2Rarz+bq8QBAetdKFl8gVkSeledotYs3ODMCHzlt1Hk8albjvlpxo
 2gTui1HzqIMnybKgQ9puRGsrSb/Wdtw3zi9pgKz/13B5Vw9bJDBawsOP+u5+Dm3VFAXBm9m5
 uI8HwHjZMhmZCGb72XLN5OOrbOA=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-east-1.postgun.com with SMTP id
 5f92d882c6b781f7537a9afe (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 23 Oct 2020 13:20:02
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 69DCAC433A1; Fri, 23 Oct 2020 13:20:01 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5AE7AC43387;
        Fri, 23 Oct 2020 13:19:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5AE7AC43387
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Luca Coelho <luca@coelho.fi>
Cc:     linux-wireless@vger.kernel.org
Subject: Re: [PATCH] iwlwifi: pcie: limit memory read spin time
References: <iwlwifi.20201022165103.45878a7e49aa.I3b9b9c5a10002915072312ce75b68ed5b3dc6e14@changeid>
Date:   Fri, 23 Oct 2020 16:19:55 +0300
In-Reply-To: <iwlwifi.20201022165103.45878a7e49aa.I3b9b9c5a10002915072312ce75b68ed5b3dc6e14@changeid>
        (Luca Coelho's message of "Thu, 22 Oct 2020 16:51:03 +0300")
Message-ID: <87o8kt5bb8.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Luca Coelho <luca@coelho.fi> writes:

> From: Johannes Berg <johannes.berg@intel.com>
>
> When we read device memory, we lock a spinlock, write the address we
> want to read from the device and then spin in a loop reading the data
> in 32-bit quantities from another register.
>
> As the description makes clear, this is rather inefficient, incurring
> a PCIe bus transaction for every read. In a typical device today, we
> want to read 786k SMEM if it crashes, leading to 192k register reads.
> Occasionally, we've seen the whole loop take over 20 seconds and then
> triggering the soft lockup detector.
>
> Clearly, it is unreasonable to spin here for such extended periods of
> time.
>
> To fix this, break the loop down into an outer and an inner loop, and
> break out of the inner loop if more than half a second elapsed. To
> avoid too much overhead, check for that only every 128 reads, though
> there's no particular reason for that number. Then, unlock and relock
> to obtain NIC access again, reprogram the start address and continue.
>
> This will keep (interrupt) latencies on the CPU down to a reasonable
> time.
>
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> Signed-off-by: Mordechay Goodstein <mordechay.goodstein@intel.com>
> Signed-off-by: Luca Coelho <luciano.coelho@intel.com>

I'll queue this to v5.10.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
