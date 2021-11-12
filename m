Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84C9E44E715
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Nov 2021 14:08:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235010AbhKLNK5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 12 Nov 2021 08:10:57 -0500
Received: from so254-9.mailgun.net ([198.61.254.9]:40610 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235007AbhKLNK4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 12 Nov 2021 08:10:56 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1636722486; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=idTeMM7ZAuNiYybOeMEMu2LLBS1k4AQg85DiyOvbLmI=; b=Pbo9EPlHWRvIg4D3uQxXSPS9pHImjgwEMGwReqddypTN66xrHsdOO/KS9j81TgmU4gCojgR3
 l8VtDXfaGOnPjV0ifktBgCkU06lzNYEy0JwZD9Bxqa4rDJMgi1PlzYKCR0+lq0J7hX88EGF2
 YpOhdu7Ipa/fyg9ZsDcWXZDSzM0=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-west-2.postgun.com with SMTP id
 618e6733facd20d795373c3a (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 12 Nov 2021 13:08:03
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id F38D8C43460; Fri, 12 Nov 2021 13:08:02 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from tykki (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 67F4DC4338F;
        Fri, 12 Nov 2021 13:08:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 67F4DC4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     P Praneesh <ppranees@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH v3 00/12] ath11k: optimizations in data path
References: <1630560820-21905-1-git-send-email-ppranees@codeaurora.org>
Date:   Fri, 12 Nov 2021 15:07:56 +0200
In-Reply-To: <1630560820-21905-1-git-send-email-ppranees@codeaurora.org> (P.
        Praneesh's message of "Thu, 2 Sep 2021 11:03:28 +0530")
Message-ID: <87sfw1iksz.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

P Praneesh <ppranees@codeaurora.org> writes:

> This patchset covers optimizations in rx (first 7 patches)
> and tx (remaining 5 patches) data path.
>
> Running UDP DL/UL traffic on IPQ8074 5G radio showed an average 5-10%
> improvement on a 4 core platform

These had multiple conflicts but luckily they were relatively easy to
fix. But please do check my changes in the pending branch:

https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/log/?h=pending

Here's where I had conflicts:

Applying: ath11k: allocate dst ring descriptors from cacheable memory
Using index info to reconstruct a base tree...
M	drivers/net/wireless/ath/ath11k/core.c
M	drivers/net/wireless/ath/ath11k/dp.c
M	drivers/net/wireless/ath/ath11k/dp.h
M	drivers/net/wireless/ath/ath11k/hw.h
Falling back to patching base and 3-way merge...
Auto-merging drivers/net/wireless/ath/ath11k/hw.h
CONFLICT (content): Merge conflict in drivers/net/wireless/ath/ath11k/hw.h
Auto-merging drivers/net/wireless/ath/ath11k/dp.h
Auto-merging drivers/net/wireless/ath/ath11k/dp.c
Auto-merging drivers/net/wireless/ath/ath11k/core.c
CONFLICT (content): Merge conflict in drivers/net/wireless/ath/ath11k/core.c
Recorded preimage for 'drivers/net/wireless/ath/ath11k/core.c'
Recorded preimage for 'drivers/net/wireless/ath/ath11k/hw.h'
error: Failed to merge in the changes.
Patch failed at 0002 ath11k: allocate dst ring descriptors from cacheable memory


Applying: ath11k: modify dp_rx desc access wrapper calls inline
Using index info to reconstruct a base tree...
M	drivers/net/wireless/ath/ath11k/dp_rx.c
Falling back to patching base and 3-way merge...
Auto-merging drivers/net/wireless/ath/ath11k/dp_rx.c
CONFLICT (content): Merge conflict in drivers/net/wireless/ath/ath11k/dp_rx.c
Recorded preimage for 'drivers/net/wireless/ath/ath11k/dp_rx.c'
error: Failed to merge in the changes.
Patch failed at 0003 ath11k: modify dp_rx desc access wrapper calls inline

Applying: ath11k: avoid additional access to ath11k_hal_srng_dst_num_free
Using index info to reconstruct a base tree...
M	drivers/net/wireless/ath/ath11k/dp_rx.c
Falling back to patching base and 3-way merge...
Auto-merging drivers/net/wireless/ath/ath11k/dp_rx.c
Applying: ath11k: avoid active pdev check for each msdu
Using index info to reconstruct a base tree...
M	drivers/net/wireless/ath/ath11k/dp_rx.c
Falling back to patching base and 3-way merge...
Auto-merging drivers/net/wireless/ath/ath11k/dp_rx.c
CONFLICT (content): Merge conflict in drivers/net/wireless/ath/ath11k/dp_rx.c
Recorded preimage for 'drivers/net/wireless/ath/ath11k/dp_rx.c'
error: Failed to merge in the changes.
Patch failed at 0005 ath11k: avoid active pdev check for each msdu

Applying: ath11k: remove usage quota while processing rx packets
Using index info to reconstruct a base tree...
M	drivers/net/wireless/ath/ath11k/dp_rx.c
Falling back to patching base and 3-way merge...
Auto-merging drivers/net/wireless/ath/ath11k/dp_rx.c
CONFLICT (content): Merge conflict in drivers/net/wireless/ath/ath11k/dp_rx.c
Recorded preimage for 'drivers/net/wireless/ath/ath11k/dp_rx.c'
error: Failed to merge in the changes.
Patch failed at 0006 ath11k: remove usage quota while processing rx packets

Applying: ath11k: add branch predictors in process_rx
Using index info to reconstruct a base tree...
M	drivers/net/wireless/ath/ath11k/dp_rx.c
Falling back to patching base and 3-way merge...
Auto-merging drivers/net/wireless/ath/ath11k/dp_rx.c
CONFLICT (content): Merge conflict in drivers/net/wireless/ath/ath11k/dp_rx.c
Recorded preimage for 'drivers/net/wireless/ath/ath11k/dp_rx.c'
error: Failed to merge in the changes.
Patch failed at 0007 ath11k: add branch predictors in process_rx

Applying: ath11k: avoid while loop in ring selection of tx completion interrupt
error: sha1 information is lacking or useless (drivers/net/wireless/ath/ath11k/dp.c).
error: could not build fake ancestor
Patch failed at 0010 ath11k: avoid while loop in ring selection of tx completion interrupt

Applying: ath11k: add branch predictors in dp_tx path
Using index info to reconstruct a base tree...
M	drivers/net/wireless/ath/ath11k/dp_tx.c
M	drivers/net/wireless/ath/ath11k/mac.c
Falling back to patching base and 3-way merge...
Auto-merging drivers/net/wireless/ath/ath11k/mac.c
CONFLICT (content): Merge conflict in drivers/net/wireless/ath/ath11k/mac.c
Auto-merging drivers/net/wireless/ath/ath11k/dp_tx.c
CONFLICT (content): Merge conflict in drivers/net/wireless/ath/ath11k/dp_tx.c
Recorded preimage for 'drivers/net/wireless/ath/ath11k/dp_tx.c'
Recorded preimage for 'drivers/net/wireless/ath/ath11k/mac.c'
error: Failed to merge in the changes.
Patch failed at 0011 ath11k: add branch predictors in dp_tx path

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
