Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 46F54B9F74
	for <lists+linux-wireless@lfdr.de>; Sat, 21 Sep 2019 20:49:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732285AbfIUStw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 21 Sep 2019 14:49:52 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:38351 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732266AbfIUStv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 21 Sep 2019 14:49:51 -0400
Received: by mail-ed1-f65.google.com with SMTP id l21so4434795edr.5
        for <linux-wireless@vger.kernel.org>; Sat, 21 Sep 2019 11:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=OYg+GgK21c3ph+YkOlit6xhWBcBo2+QjQCwp/0iYbEo=;
        b=Zrw+sKSzaBihHwT5BrfWKEHian998wodFrV9nk+Sfu72GA/KAwI+F4rG6DkuQwqzRo
         tLQt1b3JoO2mmZyqZKnyAamqFZLLZRVA4XA2sGyxHCXzjbTO0XaNKyL+fE//PUaEuvbY
         tItSeq3VmPP2f7jQ8wDvTo9wQxvV7K/RWWHKQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OYg+GgK21c3ph+YkOlit6xhWBcBo2+QjQCwp/0iYbEo=;
        b=PHOKPsoU4pu4NhYWCdxRxmyc+i4XOGI3ftLOp5aLU6ktP/nPniWYYlsJuHr//kLg4l
         Q48XLv/dvzQWIwURcCXT3puJvr6Bbtd0HWURQSmXMNr7sKfLP1j9JP34AL6S4QyNlBHz
         dVtMrHHtN+8CN5rdftr4IJoIWaLaf86BfKCoLPxWLJKQQP3YXHIP9y2+xr3FbgYuUL43
         vycBkEZlea47w1thGpONviorU/oxA9TONSExcnq3i8L617F2qH9+Ch1POyvZ7zOdQ57p
         cMpR84IsFcELJDZT7EvY2+96ubXBhXVZhUNQUod+CJ20GFmiVWSMMvtibbNjoCUDVKfo
         ThnQ==
X-Gm-Message-State: APjAAAWBp5kw9JsxhEhcDNFpBjUt/GGdk3BBs9nlSRMzKxLIt0b5xVIf
        U5ENENJPFXINuJfvs7K71+8AsUIoM99HJtZsaqz/L1nqjb86H7dH0mZ9Q2Zj9+g5oUwKzv1YoMj
        iHL15um2+uoL/0HfHETKzKLLIgB8x4otlAwqCFC/XrfcCUWgZ6/w15PVjVvIC95nvNXc6EtSCj/
        AJZE5TnyeC2u5zOg==
X-Google-Smtp-Source: APXvYqwyplr1WG3BBVCuTux1fq0/hbES71ZnhZz1+O0EOIaSKqRYlx0rcdtcD86+Q9bpGfw31ylAIQ==
X-Received: by 2002:a50:8a21:: with SMTP id i30mr14131270edi.229.1569091789683;
        Sat, 21 Sep 2019 11:49:49 -0700 (PDT)
Received: from [192.168.178.129] (f140230.upc-f.chello.nl. [80.56.140.230])
        by smtp.gmail.com with ESMTPSA id a3sm405811edk.51.2019.09.21.11.49.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Sep 2019 11:49:49 -0700 (PDT)
From:   Arend Van Spriel <arend.vanspriel@broadcom.com>
Subject: Re: [PATCH V3 0/8] nl80211: add 6GHz band support
To:     Jeff Johnson <jjohnson@codeaurora.org>
Cc:     asinghal@codeaurora.org,
        linux-wireless <linux-wireless@vger.kernel.org>
References: <1564745465-21234-1-git-send-email-arend.vanspriel@broadcom.com>
 <eddfd4e1abbd1dc57858fff61ee2523b@codeaurora.org>
Message-ID: <dc4fbf4f-8393-a185-2136-6978535dc8fb@broadcom.com>
Date:   Sat, 21 Sep 2019 20:49:49 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <eddfd4e1abbd1dc57858fff61ee2523b@codeaurora.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

+ linux-wireless

On September 19, 2019 8:25:57 PM Jeff Johnson <jjohnson@codeaurora.org> 
wrote:

> On 2019-08-02 04:30, Arend van Spriel wrote:
>> Changing to formal patch series instead of RFC.
>>
>>
>> In 802.11ax D4.0 a new band has been proposed. This series contains
>> changes to cfg80211 for supporting this band. With 2GHz and 5GHz there
>> was no overlap in channel number. However, this new band has channel
>> numbers with a range from 1 up to 253. The only place I could find an
>> issue with this is in cfg80211_wext_freq(). Not sure how to deal with
>> that so it is not part of this series.
>>
>>
>> The series applies to the master branch of the mac80211-next
>> repository.
>>
>>
>> Arend van Spriel (8):
>> nl80211: add 6GHz band definition to enum nl80211_band
>> cfg80211: add 6GHz UNII band definitions
>> cfg80211: util: add 6GHz channel to freq conversion and vice versa
>> cfg80211: extend ieee80211_operating_class_to_band() for 6GHz
>> cfg80211: add 6GHz in code handling array with NUM_NL80211_BANDS
>> entries
>> cfg80211: use same IR permissive rules for 6GHz band
>> cfg80211: ibss: use 11a mandatory rates for 6GHz band operation
>> cfg80211: apply same mandatory rate flags for 5GHz and 6GHz
>>
>>
>> include/uapi/linux/nl80211.h |  2 ++
>> net/mac80211/tx.c            |  1 +
>> net/wireless/chan.c          |  3 ++-
>> net/wireless/ibss.c          | 16 +++++++++++-----
>> net/wireless/nl80211.c       |  1 +
>> net/wireless/reg.c           | 21 +++++++++++++++++++--
>> net/wireless/trace.h         |  3 ++-
>> net/wireless/util.c          | 14 +++++++++++++-
>> 8 files changed, 51 insertions(+), 10 deletions(-)
>
> Curious how you are populating the wiphy->bands[6 GHz].
> If we don't set ht_cap.ht_supported and/or vht_cap.vht_supported then
> cfg80211_chandef_usable() fails, but setting those flags on 6 GHz seems
> broken.

Hi Jeff,

Good point. Actually, for 6GHz a couple of (v)ht capabilities are still 
applicable and exchanged using HE extended capabilities element. My idea 
was that these (v)ht capabilities would be reported to user-space same 
as for the other bands so that would imply those flags are also set for 
6GHz. This may look odd as the statement "6G is HE only" applies, but 
still some (v)ht functionality is used in HE. Despite this it may be 
good to extend the cfg80211_chandef_usable() for HE in general and cover 
the 6G case as well. The intended driver implementation in brcmfmac is 
still being worked on so issues might arise.

Regards,
Arend
