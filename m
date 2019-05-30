Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E89952EAE1
	for <lists+linux-wireless@lfdr.de>; Thu, 30 May 2019 04:57:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726530AbfE3C5H (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 29 May 2019 22:57:07 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:33336 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726376AbfE3C5H (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 29 May 2019 22:57:07 -0400
Received: by mail-oi1-f193.google.com with SMTP id q186so3850727oia.0
        for <linux-wireless@vger.kernel.org>; Wed, 29 May 2019 19:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=CJcpP1rLFBsObgR5RxK+hUY26N1N8itOh6IqhtHPNhw=;
        b=rL9R/AwFppzyJHNd0ZQddwsgBG8A92iGlcQUMnuf3GdaChfRUtP9YN3xxU3SnM6exu
         adzWibbK1mfcI6DUioNRXo6dN/GUCWKlWQvLS544x128BWt43SJISLjTZ8O906qNQGVN
         cRcT+fziyORuAl4dT9rc5XUn0UXOD43gCZOVDhMZh36lvuYY6jOurBvLj5UbZyPDkmhE
         D3dtFb/S80n3kbqA1FhQ4E7lwjVloTb1UUni7+mEIp2nb+/xXt/L85Fx0lQLwnEjdLEi
         ModQM4UjHVKQJk2l91y0m1vUSik3OIVGwwnZpgsrEVt8apADkdJ9GowmZXFTBe91MnHS
         Fa1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CJcpP1rLFBsObgR5RxK+hUY26N1N8itOh6IqhtHPNhw=;
        b=QMmHHOkj216YEA+Q60ZhbNIeWHGPFZED9C+sn6VxbzBo+AKlkfSzar2tE2HV5cKMQG
         vLh5zPCQUgK1Jwu26Sekpk1NDLcaBgqxtrsfOmMq+26mLfGMog5V7ezEsGgD2qRVArLZ
         SGN2i20NBZOqrVS8k/FYKvBKnn20z7VEYH9QZXFrfxa8JkRG0kUKrqqODkaZWM4t9erJ
         sf8Lp0oGL4umaHnhl6u7jTxdoumLY//ObHlwSR54R055UCBfYr1rrZdF1fYt8k+tv0Wr
         u7uK9KvBSoqqqVZFG1VMhgtASw/1bBT7wI5ajqEm+PZoP1vkzj+33+fVGb9WhfU4yp0M
         gD8w==
X-Gm-Message-State: APjAAAUMWg6Rp9pk4vHBo7qF64pb5Tbhgm4yTDuu49b04V4UJDbg4aS8
        V/VnfW4nHKdX020YnyOxkmJjg6S5
X-Google-Smtp-Source: APXvYqxGCHt039a9TFREhX609qyvjGrjszbjzWaaL+LXiidOH7PiMh1nkgaWHhgEB5trA4GnunNQiw==
X-Received: by 2002:aca:3fc6:: with SMTP id m189mr967977oia.124.1559185026634;
        Wed, 29 May 2019 19:57:06 -0700 (PDT)
Received: from [192.168.1.112] (cpe-24-31-245-230.kc.res.rr.com. [24.31.245.230])
        by smtp.gmail.com with ESMTPSA id q3sm584144oig.7.2019.05.29.19.57.04
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 May 2019 19:57:05 -0700 (PDT)
Subject: Re: [PATCH 01/11] rtw88: resolve order of tx power setting routines
To:     Tony Chuang <yhchuang@realtek.com>,
        "kvalo@codeaurora.org" <kvalo@codeaurora.org>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
References: <1559116487-5244-1-git-send-email-yhchuang@realtek.com>
 <1559116487-5244-2-git-send-email-yhchuang@realtek.com>
 <f5bd9ab0-c32c-dcc6-9451-09e6b7f50a96@lwfinger.net>
 <F7CD281DE3E379468C6D07993EA72F84D17FABBF@RTITMBSVM04.realtek.com.tw>
From:   Larry Finger <Larry.Finger@lwfinger.net>
Message-ID: <857dd30c-5a69-a41e-1561-23db103dc822@lwfinger.net>
Date:   Wed, 29 May 2019 21:57:03 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <F7CD281DE3E379468C6D07993EA72F84D17FABBF@RTITMBSVM04.realtek.com.tw>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 5/29/19 9:29 PM, Tony Chuang wrote:
> 
> 
>> -----Original Message-----
>> From: Larry Finger [mailto:larry.finger@gmail.com] On Behalf Of Larry Finger
>> Sent: Wednesday, May 29, 2019 11:17 PM
>> To: Tony Chuang; kvalo@codeaurora.org
>> Cc: linux-wireless@vger.kernel.org
>> Subject: Re: [PATCH 01/11] rtw88: resolve order of tx power setting routines
>>
>> On 5/29/19 2:54 AM, yhchuang@realtek.com wrote:
>>> From: Yan-Hsuan Chuang <yhchuang@realtek.com>
>>>
>>> Some functions that should be static are unnecessarily exposed, remove
>>> their declaration in header file phy.h.
>>>
>>> After resolving their declaration order, they can be declared as static.
>>> So this commit changes nothing except the order and marking them static.
>>>
>>> Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
>>
>> This patch does not apply. Using quilt to see what is wrong, there are 6
>> changes
>> that have already been applied.
>>
>> Larry
>>
> 
> 
> These patches are based on
> 
> https://kernel.googlesource.com/pub/scm/linux/kernel/git/kvalo/wireless-drivers
> branch master
> 
> commit 6aca09771db4277a78853d6ac680d8d5f0d915e3
> Author: YueHaibing <yuehaibing@huawei.com>
> Date:   Sat May 4 18:32:24 2019 +0800
> 
>      rtw88: Make some symbols static
> 
> 
> It should apply, did I miss something?

I was trying to apply the patch to wireless-drivers-next. That may be my 
problem. The other 10 applied OK.

Larry

