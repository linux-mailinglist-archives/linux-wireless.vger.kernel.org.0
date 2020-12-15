Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B61932DA8E4
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Dec 2020 09:07:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726789AbgLOIGb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 15 Dec 2020 03:06:31 -0500
Received: from so254-31.mailgun.net ([198.61.254.31]:32314 "EHLO
        so254-31.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726636AbgLOIGb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 15 Dec 2020 03:06:31 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1608019573; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=EiS56InFbNrrErINtWma1P8wVuX8T9P+uncV9L2GfGc=; b=jMqjs3BpsEp+pP+QDXEpcFpG7tKKRAB9tlmHCe0xVYnaP6RJmCCDPt6Td1scs8pewFGdQ8D5
 eiCCb0ajvMteiX7CtOlZkqT4GsDGY4W7w4t+RaFPdgRsibOFmZx2JWr3O6sv6r3/5zthp0pz
 +u6maHAz0VJwlzWwBAWzUa1u8sc=
X-Mailgun-Sending-Ip: 198.61.254.31
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-west-2.postgun.com with SMTP id
 5fd86e53f4cc8c621a064f8f (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 15 Dec 2020 08:05:39
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 5F77AC433C6; Tue, 15 Dec 2020 08:05:39 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A036EC433ED;
        Tue, 15 Dec 2020 08:05:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A036EC433ED
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Wen Gong <wgong@codeaurora.org>
Cc:     Ben Greear <greearb@candelatech.com>,
        linux-wireless@vger.kernel.org, ath10k@lists.infradead.org
Subject: Re: [PATCH v3] ath10k: add flag to protect napi operation to avoid dead loop hang
References: <1598617348-2325-1-git-send-email-wgong@codeaurora.org>
        <87d02x1rqb.fsf@codeaurora.org>
        <010101746bd17881-819242de-7cbb-4df3-93e2-59473d281155-000000@us-west-2.amazonses.com>
        <87r1nzbadn.fsf@codeaurora.org>
        <8a97f5ba-8eba-d61b-4c92-bdfd08d388ee@candelatech.com>
        <e4b4f4d1fadd4d691729ef422e8732d7@codeaurora.org>
Date:   Tue, 15 Dec 2020 10:05:35 +0200
In-Reply-To: <e4b4f4d1fadd4d691729ef422e8732d7@codeaurora.org> (Wen Gong's
        message of "Thu, 10 Dec 2020 10:29:35 +0800")
Message-ID: <87tusn1okw.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Wen Gong <wgong@codeaurora.org> writes:

> On 2020-12-09 23:00, Ben Greear wrote:
>> On 12/9/20 1:24 AM, Kalle Valo wrote:
>>> Wen Gong <wgong@codeaurora.org> writes:
>>>
>>>> On 2020-09-08 00:22, Kalle Valo wrote:
>>>>
>>>>> Just like with the recent firmware restart patch, isn't
>>>>> ar->napi_enabled
>>>>> racy? Wouldn't test_and_set_bit() and test_and_clear_bit() be safer?
>>>>>
>>>>> Or are we holding a lock? But then that should be documented with
>>>>> lockdep_assert_held().
>>>>
>>>> yes, ath10k_hif_start is only called from ath10k_core_start, it has
>>>> "lockdep_assert_held(&ar->conf_mutex)", and ath10k_hif_stop is only
>>>> called from ath10k_core_stop, it also has
>>>> "lockdep_assert_held(&ar->conf_mutex)". then it will not 2 thread
>>>> both
>>>> enter ath10k_hif_start/ath10k_hif_stop meanwhile.
>>>
>>> Ok, but every function depending on a lock being held should still
>>> call
>>> lockdep_assert_held(), that way we can catch the bug if locking
>>> changes
>>> later. So it's not enough that ath10k_core_stop() has
>>> lockdep_assert_held(), also these napi functions should have it.
>>>
>>> I actually decided to switch using ATH10K_FLAG_NAPI_ENABLED with
>>> set_bit() & co, simpler locking that way and no lockdep_assert_held()
>>> needed anymore. Please check my changes in the pending branch, I have
>>> only compile tested them:
>>>
>>> https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?h=pending&id=e0a466d296bd862080f7796b41349f9f586272c9
>>>
>>
>> Why do you not need locking?  You can't just check a bit is set and
>> then do work and set
>> it later without locking, two concurrent CPU threads can pass the
>> first check and both get into
>> the logic below it?
>>
> maybe because which I said before:
>
> ath10k_hif_start is only called from ath10k_core_start, it has
> "lockdep_assert_held(&ar->conf_mutex)", and ath10k_hif_stop is only
> called from ath10k_core_stop, it also has
> "lockdep_assert_held(&ar->conf_mutex)". then it will not 2 thread both
> enter ath10k_hif_start/ath10k_hif_stop meanwhile.

Yeah, but that was not visible from the code. I now changed the patch in
pending branch that this is clearly documented with
lockdep_assert_held() and lockdep will warn if someone breaks the
locking later on.

If a function relies on a lock being held, lockdep_assert_held() needs
to be _always_ used to make the locking dependencies clearly visible.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
