Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D42F1428B05
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Oct 2021 12:47:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231240AbhJKKtp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 11 Oct 2021 06:49:45 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:33936 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235985AbhJKKto (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 11 Oct 2021 06:49:44 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1633949264; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=zD0ZTFvkzSdGI4/2IPhEpqZkt0GWm5DmIuz4gsL8OjI=; b=o6YIcmtaH9Wt1dHK2L7316Qe0DGLUUrneJ/3bZSGQR3exMK37LCdso1fU7adgnyUJxKuYA91
 +S47h+UKyD/b6SHvvaoZ035dkU32xCMzu55dzfug4dECUqrAF42jr8s29kuVEayzrw6FW9O8
 KawVLXXoJY6zeLZDzIL9w74qVdI=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-west-2.postgun.com with SMTP id
 6164163f8ea00a941f7290af (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 11 Oct 2021 10:47:27
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 6A022C4360C; Mon, 11 Oct 2021 10:47:27 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from tykki (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 692A1C4338F;
        Mon, 11 Oct 2021 10:47:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 692A1C4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Arend van Spriel <arend.vanspriel@broadcom.com>
Cc:     Brian Norris <briannorris@chromium.org>,
        Ping-Ke Shih <pkshih@realtek.com>, tony0620emma@gmail.com,
        linux-wireless@vger.kernel.org, steventing@realtek.com,
        David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>
Subject: Re: wireless: guidelines for user space interfaces
References: <20210422030413.9738-1-pkshih@realtek.com>
        <20210422030413.9738-2-pkshih@realtek.com>
        <YMPqT8VH5alHQXXA@google.com> <87mtnf52z9.fsf_-_@codeaurora.org>
        <f670553b-274e-0801-50b4-a8e9d7fcf54e@broadcom.com>
Date:   Mon, 11 Oct 2021 13:47:22 +0300
In-Reply-To: <f670553b-274e-0801-50b4-a8e9d7fcf54e@broadcom.com> (Arend van
        Spriel's message of "Mon, 11 Oct 2021 11:40:40 +0200")
Message-ID: <87ee8r4z45.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Arend van Spriel <arend.vanspriel@broadcom.com> writes:

> On 10/11/2021 11:23 AM, Kalle Valo wrote:
>> (changing subject, was "Re: [PATCH v2 2/2] rtw88: add debugfs to
>> force lowest basic rate")
>>
>> Brian Norris <briannorris@chromium.org> writes:
>>
>>> BTW, if we have clear guidelines on debugfs, module parameters, etc.,
>>> maybe those should be going on the wiki? I know this came up before:
>>>
>>> https://lore.kernel.org/linux-wireless/87d09u7tyr.fsf@codeaurora.org/
>>>
>>> At this point, I'm willing to write such guidelines, if I get an ack
>>> from the relevant folks (I guess that's just Kalle?). It probably
>>> belongs somewhere in this tree:
>>>
>>> https://wireless.wiki.kernel.org/en/developers/documentation
>>>
>>> similar to this:
>>> https://wireless.wiki.kernel.org/en/developers/documentation/nl80211#vendor-specific_api
>>> except it's not really an nl80211 thing. Suggestions welcome.
>>
>> I think this is a very good idea. Having general guidelines for wireless
>> drivers using user space interfaces would help both people submitting
>> patches and also people like me reviewing the patches.
>>
>> We should try to get an ack for the guidelines at least from Johannes,
>> but I would prefer also involve Jakub and Dave (CCed) as they might have
>> some input from the network subsystem point of view.
>>
>> Just to get this started, here's a draft list I came up of different
>> user space interfaces upstream wireless drivers are using:
>>
>> * generic nl80211 (excluding testmode and vendor commands)
>>
>> * nl80211 testmode commands
>>
>> * nl80211 vendor commands
>>
>> * sysfs[1]
>>
>> * debugfs
>>
>> * relayfs
>>
>> * configfs[1]
>>
>> * module parameters
>>
>> * thermal subsystem
>>
>> * firmware_request()
>>
>> I'm not saying that we need to document all these in the first version,
>> I'm just trying to come up a comprehensive overview how wireless drivers
>> interact with the user space. And I'm sure I missed something. so please
>> do fill in.
>
> Not sure if all of the above can be considered user-space interfaces,
> but wireless driver developers could benefit from guidelines for them
> regardless.

Maybe the name should be "Guidelines for wireless drivers" without being
too specific?

> Maybe following needs to be considered as well although I think
> cfg80211 is taking care of it:
>
> * rfkill

Yeah, it would be good to include rfkill.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
