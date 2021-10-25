Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 897734396FE
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Oct 2021 15:02:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233066AbhJYNEw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 25 Oct 2021 09:04:52 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:30013 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232941AbhJYNEv (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 25 Oct 2021 09:04:51 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1635166949; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=bNVnuQryzLAZ411TWplun3SNdrSAWKLeEU32LDW4Olg=; b=pAk/0HVqhtQraqX6BEGEbaQmOlBBOqnqs7pw0MqHbjy7amRipUpG7TugYKxJB5Cq0cHUuMTH
 tB+/QmUUSTCTiQP+KaxTsiY15CQeBLus70evLhUstNS47TTZrVEqnnRtUGSo+nEFhdfB28xq
 k+0OaqNTgQZC4UPTmCFd3a3Etmo=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-east-1.postgun.com with SMTP id
 6176aad5e29a872c214dcda3 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 25 Oct 2021 13:02:13
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id EA057C4360C; Mon, 25 Oct 2021 13:02:12 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from tykki (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 34623C4338F;
        Mon, 25 Oct 2021 13:02:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 34623C4338F
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
        <87a6jnftq9.fsf@codeaurora.org>
Date:   Mon, 25 Oct 2021 16:02:06 +0300
In-Reply-To: <87a6jnftq9.fsf@codeaurora.org> (Kalle Valo's message of "Tue, 05
        Oct 2021 17:10:06 +0300")
Message-ID: <87r1c99s1d.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Kalle Valo <kvalo@codeaurora.org> writes:

> bqiang@codeaurora.org writes:
>
>> On 2021-09-28 23:14, Kalle Valo wrote:
>>> Jouni Malinen <jouni@codeaurora.org> writes:
>>>
>>>> From: Baochen Qiang <bqiang@codeaurora.org>
>>>>
>>>> QCA6390 firmware uses HAL_RX_BUF_RBM_SW1_BM, not
>>>> HAL_RX_BUF_RBM_SW3_BM.
>>>>
>>>> Tested-on: QCA6390 hw2.0 PCI
>>>> WLAN.HST.1.0.1-01740-QCAHSTSWPLZ_V2_TO_X86-1
>>>>
>>>> Signed-off-by: Baochen Qiang <bqiang@codeaurora.org>
>>>> Signed-off-by: Jouni Malinen <jouni@codeaurora.org>
>>>
>>> Same question as in patch 1, does this fix a bug or is just a
>>> theoretical issue found during code review?
>>
>> Yes, this patch did fix a bug.
>>
>> QCA6390 firmware expects some specific packets from WBM2SW1 ring,
>> which, however, will not happen because they are routed directly to
>> host through WBM2SW3 ring due to wrong configuration of RBM.
>
> What specific packets exactly?

We discussed this internally and I now changed the commit log to:

ath11k: change return buffer manager for QCA6390

QCA6390 firmware uses HAL_RX_BUF_RBM_SW1_BM, not HAL_RX_BUF_RBM_SW3_BM. This is
needed to fix a case where an A-MSDU has an unexpected LLC/SNAP header in the
first subframe (CVE-2020-24588).

Tested-on: QCA6390 hw2.0 PCI WLAN.HST.1.0.1-01740-QCAHSTSWPLZ_V2_TO_X86-1

Signed-off-by: Baochen Qiang <bqiang@codeaurora.org>
Signed-off-by: Jouni Malinen <jouni@codeaurora.org>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
