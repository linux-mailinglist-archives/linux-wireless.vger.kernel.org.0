Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 432B3435A6D
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Oct 2021 07:44:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbhJUFrH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 21 Oct 2021 01:47:07 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:53609 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbhJUFrG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 21 Oct 2021 01:47:06 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1634795091; h=Content-Type: MIME-Version: Message-ID: Date:
 References: In-Reply-To: Subject: Cc: To: From: Sender;
 bh=gKWSbCXtOMCYa1zk/V70afMmHLAKVljvFD6faTNFv+g=; b=QWN3PXrBmbzqmFXv+HjAliwW03ARVZLFfTP3aVMfvjmRM98U1vP+zrLn4UYnoMxRAIdF6ews
 2N6Hp0Ylkkka9dtfjhQ6l9rJFffPQSLkWv7mkWQw37/y50tJz1hb8+qw5GZ86Z1Xm36e4yFu
 P1DsELDATlP+/WhpJJrMo5yTjxs=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-east-1.postgun.com with SMTP id
 6170fe4159612e01002cc007 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 21 Oct 2021 05:44:33
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 83824C4360D; Thu, 21 Oct 2021 05:44:32 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from tykki (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id BB3AAC4338F;
        Thu, 21 Oct 2021 05:44:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org BB3AAC4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc:     Loic Poulain <loic.poulain@linaro.org>,
        wcn36xx@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH 1/2] wcn36xx: Correct band/freq reporting on RX
In-Reply-To: <574368d8-ebfa-7765-ea0d-def99b855719@linaro.org> (Bryan
        O'Donoghue's message of "Wed, 20 Oct 2021 17:28:25 +0100")
References: <1634554678-7993-1-git-send-email-loic.poulain@linaro.org>
        <d2128789-646f-1e02-0dd2-a9ac14b37cf7@linaro.org>
        <5a325d84-0d02-237b-a0a3-9eddd2e481de@linaro.org>
        <CAMZdPi8Mh+pN=xExhY1TFYJYTKCDJmVApNG3oOMFtF5nLu770A@mail.gmail.com>
        <574368d8-ebfa-7765-ea0d-def99b855719@linaro.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
Date:   Thu, 21 Oct 2021 08:44:27 +0300
Message-ID: <8735ovextw.fsf@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Bryan O'Donoghue <bryan.odonoghue@linaro.org> writes:

> On 20/10/2021 14:54, Loic Poulain wrote:
>> Hi Bryan, Kalle,
>>
>> On Tue, 19 Oct 2021 at 02:26, Bryan O'Donoghue
>> <bryan.odonoghue@linaro.org> wrote:
>>>
>>> On 18/10/2021 23:51, Bryan O'Donoghue wrote:
>>>> On 18/10/2021 11:57, Loic Poulain wrote:
>>>>>            ieee80211_is_probe_resp(hdr->frame_control))
>>>>>            status.boottime_ns = ktime_get_boottime_ns();
>>>>
>>>> I think this is dangling in your tree, doesn't apply cleanly for me anyway
>>>>
>>>> Other than that
>>>>
>>>> Tested-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
>>>
>>> Hmm.
>>>
>>> I'm told by a colleague with access to a router that has channel 144 - I
>>> do not BTW - that 144 is not showing up with the firmware offload scan.
>>>
>>> We should probably hold off on applying for the time being :(
>>
>> So the missing channel 144 is due to a different problem, and is now fixed
>> in a subsequent patch:
>>      wcn36xx: Channel list update before hardware scan
>>
>> So I think we can go with this change :-).
>>
>> Regards,
>> Loic
>>
>
> Cool, nice job

I had already dropped this patch from my queue, but added it back now.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
