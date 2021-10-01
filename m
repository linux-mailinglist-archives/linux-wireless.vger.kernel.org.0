Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B89841E77A
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Oct 2021 08:27:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352115AbhJAG2s (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 1 Oct 2021 02:28:48 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:11032 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230397AbhJAG2r (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 1 Oct 2021 02:28:47 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1633069624; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=RfG9ID86HZzLxpbltn2M0RQuxe4ZDrqWD5fcitSRBvY=; b=BJMDKnCF8oap1szTUGCaJGbkhmJTld4bNFfYK0p/LhMSb6L24m0oDMo+fFufFTEWys4j8FWt
 +W8vLJut/mQHXio3WKZVmY4QtNLqM8z35h0kRoJSK+fdFpxYWDgeENvPgrYlmDo1VAMgOO7q
 zEntpo2eyLjdA3zbvpk8wusRfeY=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-east-1.postgun.com with SMTP id
 6156aa2d63b1f1865825c630 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 01 Oct 2021 06:26:53
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 3CCC3C4338F; Fri,  1 Oct 2021 06:26:52 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from tykki (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 6A5E7C4338F;
        Fri,  1 Oct 2021 06:26:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 6A5E7C4338F
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
Date:   Fri, 01 Oct 2021 09:26:47 +0300
In-Reply-To: <43fd66ccc28fe80b3ef00e5f1c7e6fbb@codeaurora.org> (bqiang's
        message of "Wed, 29 Sep 2021 10:42:43 +0800")
Message-ID: <87k0ixmfa0.fsf@codeaurora.org>
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

Ok, please always describe the bug you are fixing in the commit log.
This is documented in the wiki pages which you definitely should read
very carefully, links below.

> QCA6390 firmware expects some specific packets from WBM2SW1 ring,
> which, however, will not happen because they are routed directly to
> host through WBM2SW3 ring due to wrong configuration of RBM.

Can you give higher level description of the bug (from user's
perspective)? For example, what test case was failing or how did you
notice this? I'll then add it to the commit log.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
