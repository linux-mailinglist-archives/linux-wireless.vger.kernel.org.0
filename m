Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 051E22D50E2
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Dec 2020 03:33:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728591AbgLJCa0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 9 Dec 2020 21:30:26 -0500
Received: from m43-15.mailgun.net ([69.72.43.15]:32394 "EHLO
        m43-15.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726194AbgLJCa0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 9 Dec 2020 21:30:26 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1607567402; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=40LTHRRiwpmO9r5XbxQfhELyIQmQt7dPKdao3F8ry0I=;
 b=lO+QrZHjjHh01dWH9iEVvqY6c3q/1zYfOD0s293VBO25TT0/Dg1lzcaurVKfmfK0A77RMnWC
 SApSiRSbedqNKkq1XNkBnHEBv0EBjulqjZcug4Ao7kCDmJJxpfoI7T8TBbWBMwrrQJE8of0a
 5qxXnaZvWWtmISDdkrsUGXEomT4=
X-Mailgun-Sending-Ip: 69.72.43.15
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-east-1.postgun.com with SMTP id
 5fd1881189cdd9db9084418b (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 10 Dec 2020 02:29:37
 GMT
Sender: wgong=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 55EB3C43462; Thu, 10 Dec 2020 02:29:36 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: wgong)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A60FCC433C6;
        Thu, 10 Dec 2020 02:29:35 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 10 Dec 2020 10:29:35 +0800
From:   Wen Gong <wgong@codeaurora.org>
To:     Ben Greear <greearb@candelatech.com>
Cc:     Kalle Valo <kvalo@codeaurora.org>, linux-wireless@vger.kernel.org,
        ath10k@lists.infradead.org
Subject: Re: [PATCH v3] ath10k: add flag to protect napi operation to avoid
 dead loop hang
In-Reply-To: <8a97f5ba-8eba-d61b-4c92-bdfd08d388ee@candelatech.com>
References: <1598617348-2325-1-git-send-email-wgong@codeaurora.org>
 <87d02x1rqb.fsf@codeaurora.org>
 <010101746bd17881-819242de-7cbb-4df3-93e2-59473d281155-000000@us-west-2.amazonses.com>
 <87r1nzbadn.fsf@codeaurora.org>
 <8a97f5ba-8eba-d61b-4c92-bdfd08d388ee@candelatech.com>
Message-ID: <e4b4f4d1fadd4d691729ef422e8732d7@codeaurora.org>
X-Sender: wgong@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2020-12-09 23:00, Ben Greear wrote:
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
>>> "lockdep_assert_held(&ar->conf_mutex)". then it will not 2 thread 
>>> both
>>> enter ath10k_hif_start/ath10k_hif_stop meanwhile.
>> 
>> Ok, but every function depending on a lock being held should still 
>> call
>> lockdep_assert_held(), that way we can catch the bug if locking 
>> changes
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
> Why do you not need locking?  You can't just check a bit is set and
> then do work and set
> it later without locking, two concurrent CPU threads can pass the
> first check and both get into
> the logic below it?
> 
maybe because which I said before:
ath10k_hif_start is only called from ath10k_core_start, it has
"lockdep_assert_held(&ar->conf_mutex)", and ath10k_hif_stop is only
called from ath10k_core_stop, it also has
"lockdep_assert_held(&ar->conf_mutex)". then it will not 2 thread both
enter ath10k_hif_start/ath10k_hif_stop meanwhile.

> Thanks,
> Ben
