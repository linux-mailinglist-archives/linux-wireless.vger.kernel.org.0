Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F2444EF92
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Jun 2019 21:41:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726121AbfFUTlx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 21 Jun 2019 15:41:53 -0400
Received: from mail-ed1-f53.google.com ([209.85.208.53]:39545 "EHLO
        mail-ed1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725985AbfFUTlx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 21 Jun 2019 15:41:53 -0400
Received: by mail-ed1-f53.google.com with SMTP id m10so11624553edv.6
        for <linux-wireless@vger.kernel.org>; Fri, 21 Jun 2019 12:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hAjXOZhm2c44kFapovUCqNuX7Ydkacwf5G78ZIFbs8s=;
        b=O44YAdYnDJaAgsBQi7Q9KxGt1Z9JgJrxcnpCxgTVyxnIXqAnGdSbrn5a9NyQkaAhq6
         n6R4ecLKrJXs451cbKGWMXi1eq6egdGP+vx6ceJMm92L1vp40YdbJm1aDcO5gRqp6Kfp
         HZrg976JrHVGAMJ2QcpsI7tqqCoGW2ut1EDmY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hAjXOZhm2c44kFapovUCqNuX7Ydkacwf5G78ZIFbs8s=;
        b=fyP9fa9n5Ox7EaJj3s8sSu8+HK0j8Z49+74utGTjGBy2J65BPOWtmbBjjKZuAEMi32
         yAX/otfTRc5ayx6nvN7iw/O/AwUtcCwUSNUt3W6oqxOj8UypODEkXYCeqGUxwVOqT/Kt
         nDcKRIFgwGAiwHG+GHkbstpi6b3iaadXW+rHS36Sr1icc+jjvk8e8F+oDqON3g0Wr5a6
         ZjRK1BjxsaUzpenJA4x8OA3k6k4sG7IEcPY104ELBB9kAsf1lKMyoiyr2pM/3Mkk8h2D
         D6TPtI+X55VhtxNd7m7yxANKbX8a2bYTGmtDLc0+cjuI5hUlgAnjxsrHbm7AgFYun1Fa
         hpew==
X-Gm-Message-State: APjAAAXVvfnUJIunb4AOvRK/0l0Nb8W9rwGliSKng4GcR5QxcV3KdwFj
        yOe4YLSpDWQUC9KLREBR58f2STYI+VJWg1xgEleqZHGrnZCvSC6mxvf2kp2mtVaTzb0OnPh8hd7
        D66x3qkZgtguPzykevU0n5FaxXAkQL41U8Km1+D/KUZehXUz9t+GDzEozh/KpmZlyRQZkFXodMB
        KNkrt49zzrzAig/Q==
X-Google-Smtp-Source: APXvYqweGR7f1WrSgFO7c62iwtMTFs8w6fVV3dXtrFj0QGk9wR71N8jv3AlXcRh0DnnGjMdC0fcrLQ==
X-Received: by 2002:aa7:cf90:: with SMTP id z16mr35511982edx.228.1561146111492;
        Fri, 21 Jun 2019 12:41:51 -0700 (PDT)
Received: from [192.168.178.129] (f140230.upc-f.chello.nl. [80.56.140.230])
        by smtp.gmail.com with ESMTPSA id t13sm575639ejo.45.2019.06.21.12.41.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Jun 2019 12:41:50 -0700 (PDT)
Subject: Re: [RFC 0/8] nl80211: add 6GHz band support
From:   Arend Van Spriel <arend.vanspriel@broadcom.com>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org
References: <1558353645-18119-1-git-send-email-arend.vanspriel@broadcom.com>
 <df53f969297fea1f3c8101cd2c1571a957985d2a.camel@sipsolutions.net>
 <16aeb2310e8.2764.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <9ba78df6-18a3-5c1c-6c57-3fa71531b460@broadcom.com>
 <6d40e69c-0cea-cc92-7974-c54d0f70812e@broadcom.com>
Message-ID: <e4a1c4af-d019-8b11-eb33-b3ae439c6649@broadcom.com>
Date:   Fri, 21 Jun 2019 21:41:49 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <6d40e69c-0cea-cc92-7974-c54d0f70812e@broadcom.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 6/3/2019 12:39 PM, Arend Van Spriel wrote:
> On 5/27/2019 10:46 PM, Arend Van Spriel wrote:
>> On 5/24/2019 8:38 PM, Arend Van Spriel wrote:
>>> On May 24, 2019 1:56:43 PM Johannes Berg <johannes@sipsolutions.net> 
>>> wrote:
>>>
>>>> Hi Arend,
>>>>
>>>> On Mon, 2019-05-20 at 14:00 +0200, Arend van Spriel wrote:
>>>>> In 802.11ax D4.0 a new band has been proposed. This series contains
>>>>> changes to cfg80211 for supporting this band. With 2GHz and 5GHz there
>>>>> was no overlap in channel number. However, this new band has channel
>>>>> numbers with a range from 1 up to 253.
>>>>
>>>> At the wireless workshop in Prague, we looked at this and sort of
>>>> decided that it'd be better to put all the 6 GHz channels into the 5 
>>>> GHz
>>>> "band" in nl80211, to avoid all the "5 || 6" since they're really the
>>>> same except for very specific places like scanning.
>>>
>>> Would have liked to be there, but attending is no longer an option 
>>> for me. We now have two autistic, non-verbal children and I am the 
>>> primary caregiver for the oldest because my wife can't handle him. 
>>> Guess I should have checked the workshop notes before working on this 
>>> :-) Do you have URL?
>>
>> Found the netdev wifi workshop page and looked over the slides 
>> quickly, but the notes page is pretty empty ;-)
>>
>>> Agree that most functional requirements for 6 GHz are same as 5 GHz. 
>>> There are some 6 GHz specifics about beaconing as well.
>>
>> This came up in discussion with my colleagues today and I would say 
>> from mac80211 perspective there is more to it than just scanning. In 
>> short the 6GHz band is for HE-only operation so for example only HE 
>> rates may be used. As the bitrates are in ieee80211_supported_band 
>> having a separate 6GHz band seems to have a (slight?) advantage.
> 
> Hi, Johannes
> 
> Any thoughts on this?

Hi Johannes,

It has been a while so maybe your thoughts are more concrete? ;-p

I really would like this to move forward as I also noticed hostapd 
changes being posted for 6GHz support yesterday.

Thanks,
Arend
