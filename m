Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 15864E8491
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Oct 2019 10:40:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729994AbfJ2JkN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 29 Oct 2019 05:40:13 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55810 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728686AbfJ2JkM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 29 Oct 2019 05:40:12 -0400
Received: by mail-wm1-f66.google.com with SMTP id g24so1743926wmh.5
        for <linux-wireless@vger.kernel.org>; Tue, 29 Oct 2019 02:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ncentric-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=2Aa5j2eV/0WKF03bDFsIwtghRGSKb/OqNGsEyVUDvWw=;
        b=b7Wvn9TYfGj9kmhJZFlMf0XSxya4fT2WHQUdC9GD4TP99uxK3aR55urIElBfE0YGRc
         SrdjJ0UtTiQhsA0a5PXzKo1xDTLywFg8w4FbuhuEdWJvVkYXmR3mPL47gc8cGG1HL/So
         zZhhMnoQai5MOJnRY3CV0itPx0qrD53DBC0gujZ6bJYV2l4xbhLjimkVKFYU0Fem2Bv8
         I4XmrSFAFDF+K2VlY2I0OglJQKSjNP/Dag6k9dWCMctxRdXdaXRp+OvaGWlfILAkocwT
         3uCbPr5qTQcw4MYPyH5Yhgd3VreRJptew48RprMLz1kRyL6CvMA5+hm7GL1q+8UEVrVj
         F+sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=2Aa5j2eV/0WKF03bDFsIwtghRGSKb/OqNGsEyVUDvWw=;
        b=s/D4f9dcWmv46OaaeRDUMIj1wRFeP/U6VyEYdZHPERL2Ujs26V7Qjae4nMHIznSTYg
         CWcjOwJW7HqMJqkYk/f/QVatYv/OIUb0PJYvLEf9Hd72TJEVpLDksv9rynyQCuVm+T2K
         zesVL/UMgqax2XwB5FZYLMXNnS2jCZMjgVyYE0tmxkIyrT73FuDxiCYggHneewXhzmiT
         IdbGCkmvbovG+WVb3wzO0Cr954Lz2qZzzSwG+GGdfUbFWLSdyv0jECWrckeBVWE6n6Bs
         xnyi70ehn2acnZ4kclNO3Z5DD4fc5lr3zqD53GCBvVn62kvwXIw+a4/p1qFe3jCmSgeA
         IHIg==
X-Gm-Message-State: APjAAAWqKjmZC0E+oAfbZhc3VOaM2D5dxhSas17kVxqdU1gyCZCBvCsa
        3UjQnY6XB6l49SXH8aEPcuVqv9eniBk=
X-Google-Smtp-Source: APXvYqybfJwsbSSLUwelX1MCkNxRbHTiindnv/Z3xFpqXx2ui62l5VksJqY5AC/XaTjKFMQQK0R9OA==
X-Received: by 2002:a1c:ed0e:: with SMTP id l14mr3125989wmh.102.1572342008103;
        Tue, 29 Oct 2019 02:40:08 -0700 (PDT)
Received: from [192.168.3.176] (d515300d8.static.telenet.be. [81.83.0.216])
        by smtp.gmail.com with ESMTPSA id v8sm16115329wra.79.2019.10.29.02.40.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Oct 2019 02:40:07 -0700 (PDT)
Subject: Re: [PATCH v2] 802.11n IBSS: wlan0 stops receiving packets due to
 aggregation after sender reboot
To:     Sebastian Gottschall <s.gottschall@newmedia-net.de>,
        Johannes Berg <johannes@sipsolutions.net>,
        =?UTF-8?Q?Krzysztof_Ha=c5=82asa?= <khalasa@piap.pl>
Cc:     "David S. Miller" <davem@davemloft.net>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <m34l02mh71.fsf@t19.piap.pl> <m37e4tjfbu.fsf@t19.piap.pl>
 <e5b07b4ce51f806ce79b1ae06ff3cbabbaa4873d.camel@sipsolutions.net>
 <30465e05-3465-f496-d57f-5e115551f5cb@ncentric.com>
 <b51030e8-7c56-0e24-4454-ff70f83d5ae8@newmedia-net.de>
From:   Koen Vandeputte <koen.vandeputte@ncentric.com>
Message-ID: <8c4325e2-6ec6-59f1-89df-36392f674530@ncentric.com>
Date:   Tue, 29 Oct 2019 10:40:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <b51030e8-7c56-0e24-4454-ff70f83d5ae8@newmedia-net.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


On 29.10.19 09:58, Sebastian Gottschall wrote:
> 35 km? for 802.11n with ht40 this is out of the ack timing range the 
> chipset supports. so this should be considered at any troubles with 
> connections
>
(Please don't top-post)

When we know a link can exceed ~ 21km, it's set to HT20 for this reason.

Koen

> Am 29.10.2019 um 09:41 schrieb Koen Vandeputte:
>>
>> On 28.10.19 13:21, Johannes Berg wrote:
>>> On Fri, 2019-10-25 at 12:21 +0200, Krzysztof Hałasa wrote:
>>>> Fix a bug where the mac80211 RX aggregation code sets a new 
>>>> aggregation
>>>> "session" at the remote station's request, but the head_seq_num
>>>> (the sequence number the receiver expects to receive) isn't reset.
>>>>
>>>> Spotted on a pair of AR9580 in IBSS mode.
>>>>
>>>> Signed-off-by: Krzysztof Halasa <khalasa@piap.pl>
>>>>
>>>> diff --git a/net/mac80211/agg-rx.c b/net/mac80211/agg-rx.c
>>>> index 4d1c335e06e5..67733bd61297 100644
>>>> --- a/net/mac80211/agg-rx.c
>>>> +++ b/net/mac80211/agg-rx.c
>>>> @@ -354,10 +354,13 @@ void ___ieee80211_start_rx_ba_session(struct 
>>>> sta_info *sta,
>>>>                */
>>>>               rcu_read_lock();
>>>>               tid_rx = rcu_dereference(sta->ampdu_mlme.tid_rx[tid]);
>>>> -            if (tid_rx && tid_rx->timeout == timeout)
>>>> +            if (tid_rx && tid_rx->timeout == timeout) {
>>>> +                tid_rx->ssn = start_seq_num;
>>>> +                tid_rx->head_seq_num = start_seq_num;
>>>>                   status = WLAN_STATUS_SUCCESS;
>>> This is wrong, this is the case of *updating an existing session*, we
>>> must not reset the head SN then.
>>>
>>> I think you just got very lucky (or unlucky) to have the same dialog
>>> token, because we start from 0 - maybe we should initialize it to a
>>> random value to flush out such issues.
>>>
>>> Really what I think probably happened is that one of your stations lost
>>> the connection to the other, and didn't tell it about it in any way 
>>> - so
>>> the other kept all the status alive.
>>>
>>> I suspect to make all this work well we need to not only have the fixes
>>> I made recently to actually send and parse deauth frames, but also to
>>> even send an auth and reset the state when we receive that, so if we
>>> move out of range and even the deauth frame is lost, we can still reset
>>> properly.
>>>
>>> In any case, this is not the right approach - we need to handle the
>>> "lost connection" case better I suspect, but since you don't say what
>>> really happened I don't really know that that's what you're seeing.
>>>
>>> johannes
>>
>> Hi all,
>>
>> I can confirm the issue as I'm also seeing this sometimes in the 
>> field here.
>>
>> Sometimes when a devices goes out of range and then re-enters,
>> the link refuses to "come up", as in rx looks to be "stuck" without 
>> any reports in system log or locking issues (lockdep enabled)
>>
>> I have dozens of devices installed offshore (802.11n based), both on 
>> static and moving assets,
>> which cover from short (250m) up to very long distances (~35km)
>>
>> So .. while there is some momentum for this issue,
>> I'm more than happy to provide extensive testing should fixes be 
>> posted regarding IBSS in general.
>>
>> Regards,
>>
>> Koen
>>
>>
