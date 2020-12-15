Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D98AD2DA8D2
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Dec 2020 08:57:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726627AbgLOH5V (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 15 Dec 2020 02:57:21 -0500
Received: from m43-15.mailgun.net ([69.72.43.15]:18877 "EHLO
        m43-15.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726249AbgLOH5V (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 15 Dec 2020 02:57:21 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1608019018; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=w/DmYDE2LJLOcCmATu8luhG4VxtIYbdFGkom5uX02wM=; b=PEXVX7ItzwKmFBsx372r699MAhWE0fSUgTNzGkUyacevufrLwYVheJyQU8E9TVAbezWZACs/
 Gfeq51lR6TNEpg3jZmGJEF+whiAY0iE9Deg3r+yBxdn1XauEPXWOpXnaPFIPriEVFwIF8B7j
 vAhpnyM98ptlLvYSa+qj5AjphwE=
X-Mailgun-Sending-Ip: 69.72.43.15
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-east-1.postgun.com with SMTP id
 5fd86c2a5723412e5431ef8e (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 15 Dec 2020 07:56:26
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 4C215C433CA; Tue, 15 Dec 2020 07:56:24 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 309ABC433CA;
        Tue, 15 Dec 2020 07:56:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 309ABC433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Ben Greear <greearb@candelatech.com>
Cc:     Wen Gong <wgong@codeaurora.org>, linux-wireless@vger.kernel.org,
        ath10k@lists.infradead.org
Subject: Re: [PATCH v3] ath10k: add flag to protect napi operation to avoid dead loop hang
References: <1598617348-2325-1-git-send-email-wgong@codeaurora.org>
        <87d02x1rqb.fsf@codeaurora.org>
        <010101746bd17881-819242de-7cbb-4df3-93e2-59473d281155-000000@us-west-2.amazonses.com>
        <87r1nzbadn.fsf@codeaurora.org>
        <8a97f5ba-8eba-d61b-4c92-bdfd08d388ee@candelatech.com>
Date:   Tue, 15 Dec 2020 09:56:20 +0200
In-Reply-To: <8a97f5ba-8eba-d61b-4c92-bdfd08d388ee@candelatech.com> (Ben
        Greear's message of "Wed, 9 Dec 2020 07:00:52 -0800")
Message-ID: <87y2hz1p0b.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ben Greear <greearb@candelatech.com> writes:

> On 12/9/20 1:24 AM, Kalle Valo wrote:
>> Wen Gong <wgong@codeaurora.org> writes:
>>
>>> On 2020-09-08 00:22, Kalle Valo wrote:
>>>
>>>> Just like with the recent firmware restart patch, isn't
>>>> ar->napi_enabled
>>>> racy? Wouldn't test_and_set_bit() and test_and_clear_bit() be safer?
>>>>
>>>> Or are we holding a lock? But then that should be documented with
>>>> lockdep_assert_held().
>>>
>>> yes, ath10k_hif_start is only called from ath10k_core_start, it has
>>> "lockdep_assert_held(&ar->conf_mutex)", and ath10k_hif_stop is only
>>> called from ath10k_core_stop, it also has
>>> "lockdep_assert_held(&ar->conf_mutex)". then it will not 2 thread both
>>> enter ath10k_hif_start/ath10k_hif_stop meanwhile.
>>
>> Ok, but every function depending on a lock being held should still call
>> lockdep_assert_held(), that way we can catch the bug if locking changes
>> later. So it's not enough that ath10k_core_stop() has
>> lockdep_assert_held(), also these napi functions should have it.
>>
>> I actually decided to switch using ATH10K_FLAG_NAPI_ENABLED with
>> set_bit() & co, simpler locking that way and no lockdep_assert_held()
>> needed anymore. Please check my changes in the pending branch, I have
>> only compile tested them:
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?h=pending&id=e0a466d296bd862080f7796b41349f9f586272c9
>>
>
> Why do you not need locking? You can't just check a bit is set and
> then do work and set it later without locking, two concurrent CPU
> threads can pass the first check and both get into the logic below it?

Good point, there is a race. I now fixed the patch in the pending and
documented that core_mutex needs to be held when changing the NAPI
state:

https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?h=pending&id=2fe769592ef6d4ae14260989dcbdbde4bff01cb6

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
