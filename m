Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB5C0456F57
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Nov 2021 14:08:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235357AbhKSNLn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 19 Nov 2021 08:11:43 -0500
Received: from so254-9.mailgun.net ([198.61.254.9]:17141 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234542AbhKSNLn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 19 Nov 2021 08:11:43 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1637327321; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=peudzCRJza4nfYgRJiGKF6At1OyLtmPHdPcnrXolSWU=; b=KSvINIgE3EigTj+ZXsiyNfkKsxsbgW4OAM4rhdUVVhBei+p8PUfLnVSLEJhGQz81Ord+a/S8
 k+ojiCklItAh0GwqRhJNf4ULYSpHo333RakwTZ5suihNYZf9MMoRL/uXJrnyQYrgH+B8Z/A7
 Hi5ZZ174bRBmmcaAP3pqq7TT+Ik=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-west-2.postgun.com with SMTP id
 6197a1c75bbbed1f705bf82c (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 19 Nov 2021 13:08:23
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 0F320C43616; Fri, 19 Nov 2021 13:08:23 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from tykki (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 16162C4338F;
        Fri, 19 Nov 2021 13:08:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 16162C4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Anilkumar Kolli <akolli@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        devicetree@vger.kernel.org, robh@kernel.org
Subject: Re: [PATCH v2 2/2] ath11k: Use reserved host DDR addresses from DT for PCI devices
References: <1637082058-6398-1-git-send-email-akolli@codeaurora.org>
        <1637082058-6398-2-git-send-email-akolli@codeaurora.org>
        <87wnl7dx69.fsf@codeaurora.org>
        <b1617fc74da2d65d663a82e4a4f538e2@codeaurora.org>
Date:   Fri, 19 Nov 2021 15:08:17 +0200
In-Reply-To: <b1617fc74da2d65d663a82e4a4f538e2@codeaurora.org> (Anilkumar
        Kolli's message of "Thu, 18 Nov 2021 16:05:21 +0530")
Message-ID: <878rxkcmym.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Anilkumar Kolli <akolli@codeaurora.org> writes:

> On 2021-11-17 13:35, Kalle Valo wrote:
>> Anilkumar Kolli <akolli@codeaurora.org> writes:
>>
>>> Host DDR memory (contiguous 45 MB in mode-0 or 15 MB in mode-2)
>>> is reserved through DT entries for firmware usage. Send the base
>>> address and size from DT entries.
>>>
>>> If DT entry is available, PCI devices work with
>>> fixed_mem_region else host allocates multiple segments.
>>>
>>> IPQ8074 on HK10 board supports multiple PCI devices.
>>> IPQ8074 + QCN9074 is tested with this patch.
>>>
>>> Tested-on: QCN9074 hw1.0 PCI
>>> WLAN.HK.2.4.0.1-01838-QCAHKSWPL_SILICONZ-1
>>>
>>> Signed-off-by: Anilkumar Kolli <akolli@codeaurora.org>

[...]

>>> +		goto no_dt_entry;
>>> +	}
>>> +
>>> +	reg_end = reg + len / (aw * sw);
>>> +
>>> +	do {
>>> +		start = of_read_number(reg, aw);
>>> +		reg += aw;
>>> +		size = of_read_number(reg, sw);
>>
>> of_read_number() takes 'const __be32 *cell' but reg is 'u32 *'?
>>
> Yes.

My point here was that doesn't this mixing of __be32 and u32 when cause
a sparse warning?

>
>>> +		reg += sw;
>>> +	} while (reg < reg_end);
>>> +
>>> +no_dt_entry:
>>> +	if (no_dt_entry) {
>>> +		mhi_ctrl->iova_start = 0;
>>> +		mhi_ctrl->iova_stop = 0xFFFFFFFF;
>>> +	} else {
>>> +		mhi_ctrl->iova_start = (dma_addr_t)(start + 0x1000000);
>>> +		mhi_ctrl->iova_stop = (dma_addr_t)(start + size);
>>
>> I don't like casts, they hide bugs like the const issue above. Is there
>> any way to do this without casts?
>>
>
> u64 start, size;
>
>     if (of_property_read_u32_array(np, "reg", reg, 4)) {
>          ath11k_dbg(ab, ATH11K_DBG_QMI,
>                     "qmi fail to get reg from hremote\n");
>          return 0;
>     }
>     start = reg[0] + reg[1];
>     size = reg[2] + reg[3];
>
> I will this code in next patch. still needs typecast form u64 to
> dma_addr_t. no ?

I suspect that a cast is not needed, but not sure. No time to check either.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
