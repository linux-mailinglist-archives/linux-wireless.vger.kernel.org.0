Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47AC4422A48
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Oct 2021 16:10:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235176AbhJEOMD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 5 Oct 2021 10:12:03 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:24140 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233705AbhJEOMC (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 5 Oct 2021 10:12:02 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1633443012; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=sAflXWHFCtPcPvvfMZVY7wWrYE1ggRKCVsd3OOu3EpA=; b=qk4dj3A8BNOSNAepw1+VYnNbdaFX4RDVeFuqZYIsc+1mqbKH4JnwArx2kDM8/jvr7uRO9Oik
 LUGUm4gpWRMR8cHNyZ+JPwAFhYBdHmhlhx8evD+eXXMgrHBW9BM7P+DMa/vKADIzPXD5HVi2
 sVCpugRhgs3sODnBFGL2pm9bgxU=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-west-2.postgun.com with SMTP id
 615c5cc28ea00a941f5d23d3 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 05 Oct 2021 14:10:10
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 64F7AC43635; Tue,  5 Oct 2021 14:10:10 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from tykki (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id ED045C4360D;
        Tue,  5 Oct 2021 14:10:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org ED045C4360D
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     bqiang@codeaurora.org
Cc:     Jouni Malinen <jouni@codeaurora.org>, ath11k@lists.infradead.org,
        linux-wireless@vger.kernel.org
Subject: Re: [PATCH 2/3] ath11k: change return buffer manager for QCA6390
References: <20210914163726.38604-1-jouni@codeaurora.org>
        <20210914163726.38604-2-jouni@codeaurora.org>
        <87pmsspwa9.fsf@codeaurora.org>
        <43fd66ccc28fe80b3ef00e5f1c7e6fbb@codeaurora.org>
Date:   Tue, 05 Oct 2021 17:10:06 +0300
In-Reply-To: <43fd66ccc28fe80b3ef00e5f1c7e6fbb@codeaurora.org> (bqiang's
        message of "Wed, 29 Sep 2021 10:42:43 +0800")
Message-ID: <87a6jnftq9.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

bqiang@codeaurora.org writes:

> On 2021-09-28 23:14, Kalle Valo wrote:
>> Jouni Malinen <jouni@codeaurora.org> writes:
>>
>>> From: Baochen Qiang <bqiang@codeaurora.org>
>>>
>>> QCA6390 firmware uses HAL_RX_BUF_RBM_SW1_BM, not
>>> HAL_RX_BUF_RBM_SW3_BM.
>>>
>>> Tested-on: QCA6390 hw2.0 PCI
>>> WLAN.HST.1.0.1-01740-QCAHSTSWPLZ_V2_TO_X86-1
>>>
>>> Signed-off-by: Baochen Qiang <bqiang@codeaurora.org>
>>> Signed-off-by: Jouni Malinen <jouni@codeaurora.org>
>>
>> Same question as in patch 1, does this fix a bug or is just a
>> theoretical issue found during code review?
>
> Yes, this patch did fix a bug.
>
> QCA6390 firmware expects some specific packets from WBM2SW1 ring,
> which, however, will not happen because they are routed directly to
> host through WBM2SW3 ring due to wrong configuration of RBM.

What specific packets exactly?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
