Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0546238BCFF
	for <lists+linux-wireless@lfdr.de>; Fri, 21 May 2021 05:36:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238507AbhEUDh7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 20 May 2021 23:37:59 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:27834 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236995AbhEUDh7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 20 May 2021 23:37:59 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1621568197; h=Content-Transfer-Encoding: Content-Type:
 MIME-Version: Message-ID: In-Reply-To: Date: References: Subject: Cc:
 To: From: Sender; bh=aGkK2gfptAXaHXflFcMtO/KvXDuAdLxK1/6CMuARijk=; b=H/dqIPsOmKrH4K96L24/KrUs3GbF3UfsZCLd0ZZDFW1GcGmfdu9P/GnHBzpDYQGPTwbgWSU9
 IRWex+3vwvzmebp0locMQg+R0YgA97u/X2soojspCJmlNPvO+N48K2wvLLafsas9rte9IWXt
 x1TklMERzhQGozABNaVVUIsc3hs=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-east-1.postgun.com with SMTP id
 60a72aafd1aee7698d749a40 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 21 May 2021 03:36:15
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id CDA07C433D3; Fri, 21 May 2021 03:36:14 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 7E80BC433D3;
        Fri, 21 May 2021 03:36:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7E80BC433D3
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     "tiantao \(H\)" <tiantao6@huawei.com>
Cc:     Michael =?utf-8?Q?B=C3=BCsch?= <m@bues.ch>,
        Tian Tao <tiantao6@hisilicon.com>,
        <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH] ssb: remove unreachable code
References: <1621306352-3632-1-git-send-email-tiantao6@hisilicon.com>
        <20210520185136.2cc3b32b@wiggum>
        <0a40049b-691c-c75f-ece2-a669842bedaf@huawei.com>
Date:   Fri, 21 May 2021 06:36:07 +0300
In-Reply-To: <0a40049b-691c-c75f-ece2-a669842bedaf@huawei.com> (tiantao's
        message of "Fri, 21 May 2021 08:49:42 +0800")
Message-ID: <87mtsohi6w.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

"tiantao (H)" <tiantao6@huawei.com> writes:

> =E5=9C=A8 2021/5/21 0:51, Michael B=C3=BCsch =E5=86=99=E9=81=93:
>> On Tue, 18 May 2021 10:52:32 +0800
>> Tian Tao <tiantao6@hisilicon.com> wrote:
>>
>>> The return value of ssb_bus_unregister can only be 0 or 1, so this
>>> condition if (err =3D=3D -EBUSY) will not hold, so delete it.
>>> @@ -431,9 +431,7 @@ void ssb_bus_unregister(struct ssb_bus *bus)
>>>   	int err;
>>>     	err =3D ssb_gpio_unregister(bus);
>>> -	if (err =3D=3D -EBUSY)
>>> -		pr_debug("Some GPIOs are still in use\n");
>>> -	else if (err)
>>> +	if (err)
>>>   		pr_debug("Can not unregister GPIO driver: %i\n", err);
>>>     	ssb_buses_lock();
>> Good catch.
>> Minor correction: The return value can be 0 or -1.
>
> yes, you are right. thanks again.:-)

I'll fix the commit log to match that.

--=20
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes
