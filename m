Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F819441C92
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Nov 2021 15:25:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231370AbhKAO1z (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 1 Nov 2021 10:27:55 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:53318 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbhKAO1x (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 1 Nov 2021 10:27:53 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1635776720; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=Ca1iSqB4+cUbhZN1Yua/QMV90QwKQ0QMFKCdksG3Go4=; b=CLthbKmgCUO28RP38WVM+kyajRtlkiU5PiV464cLkVW9fefPaJIKs8IHjuUYqfuWYv7ii6KU
 mraR12+Iu1QsvFNuZUsCb4pfxdXvPRUUuJ6vt6cvE6Kf0kXTTnSgHMlFl3lup89uwjaB5eUI
 SJ9t2Q+8dqiih6Rr/+BNy1Nqa+8=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-west-2.postgun.com with SMTP id
 617ff8ccc8c1b282a5f6897f (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 01 Nov 2021 14:25:16
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id DB5C1C4360D; Mon,  1 Nov 2021 14:25:15 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from tykki (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D4B26C4338F;
        Mon,  1 Nov 2021 14:25:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org D4B26C4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Christian Lamparter <chunkeey@gmail.com>
Cc:     linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
        Ansuel Smith <ansuelsmth@gmail.com>
Subject: Re: [PATCH v2] ath10k: fetch (pre-)calibration data via nvmem subsystem
References: <20211016234609.1568317-1-chunkeey@gmail.com>
        <87ee855xwa.fsf@codeaurora.org>
        <3a8840ea-1499-950b-fb44-7546a32c586f@gmail.com>
        <875yth5pt3.fsf@codeaurora.org>
        <3aebb711-dc45-3cbf-43cb-12f59909baf0@gmail.com>
Date:   Mon, 01 Nov 2021 16:25:10 +0200
In-Reply-To: <3aebb711-dc45-3cbf-43cb-12f59909baf0@gmail.com> (Christian
        Lamparter's message of "Thu, 28 Oct 2021 20:50:13 +0200")
Message-ID: <87lf280x89.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Christian Lamparter <chunkeey@gmail.com> writes:

> On 28/10/2021 13:52, Kalle Valo wrote:
>
>>>>>
>>>>> v1 -> v2:
>>>>> 	- use %zu and %u in the format string for size_t
>>>>>             and u32 types (catched by the "kernel test robot").
>>>>> 	- reworded commit message + successfully tested on QCA9880v2
>>>>>
>>>>> I placed the nvmem code in front of the current "file" method
>>>>> (firmware_request). Reason is that this makes it easier for me
>>>>> to test it. If needed it can be moved to a different place.
>>>>
>>>> Looks good to me. Before I apply this, I want to mention to that I have
>>>> had a long in my deferred queue related two patchsets:
>>>
>>>
>>>> https://patchwork.kernel.org/project/linux-wireless/patch/20200927192515.86-1-ansuelsmth@gmail.com/
>>>> https://patchwork.kernel.org/project/linux-wireless/patch/20200927192515.86-2-ansuelsmth@gmail.com/
>>>
>>> Oh ok, serves me right for not looking thoroughly googling this first.
>>> Alban Bedel and Ansuel's work made this nvmem all possible. And indeed,
>>> the second patch here looks eerie similar.
>>>
>>> Do you want to go with his two patches instead?
>>
>> I would prefer to take your patch.
>
> Ok.
>
>>> I'll change mine, so it just consists of the cal_mode for the older
>>> QCA9880v2,QCA9887 and add the -EPROBE_DEFER handling. This
>>> -EPROBE_DEFER only ever comes up with the Meraki gear. This is because
>>> Meraki likes putting the MACs-Values into SoC-connected AT24
>>> eeproms-chips. Everyone else just have them in a proper FLASH
>>> partition. Though, this's usually nothing more than adding the
>>> following line:
>>>
>>> if (ret == -EPROBER_DEFER)
>>> 	return ret;
>>
>> So I'll drop this version and wait for v3?
>
> I guess that "waiting for v3" won't be necessary in this case.
> If @Ansuel doesn't voice any concerns, you might as well just
> apply v2.

Ok, I took the v2 now. Thanks for helping out, I appreciate it!

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
