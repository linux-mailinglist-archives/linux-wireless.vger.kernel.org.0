Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E0F4E10DC4
	for <lists+linux-wireless@lfdr.de>; Wed,  1 May 2019 22:09:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726115AbfEAUJn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 1 May 2019 16:09:43 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:42793 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726077AbfEAUJn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 1 May 2019 16:09:43 -0400
Received: by mail-ot1-f68.google.com with SMTP id f23so66504otl.9
        for <linux-wireless@vger.kernel.org>; Wed, 01 May 2019 13:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=yg+6lmU7DoPv4P+NYEkJociN1O4zrJvaxxRKLQK1hP0=;
        b=ewMw6IXqQxmzJyZkLEFKnPuwFWaLiXt1toNT/dPwFQkgiGhch2HGPn0glgbJl08KK4
         mee64aEA6FdK/K2tmObq9tz1I1j7DmSpMReqiL3x8Re04jgfeNUtXz1CeREnaJ6vJchg
         sH3PVk+pRHcyyAFuzA+2QmOk6fzXQemlhR+Vkwi7dFpVip0o+hLAr9KpJNbzqLN8d9c0
         PiQ3wpwFOrw27ayDdbJvvDpSvUrSZb4KJrAv68PDT3a0rXyV/u1ejNeyDJxmxngehd1v
         sZ/Uslf7C5H63u8n3EdV8TOtQwgmSZ+bC1jvti96UCY31X0Gfs/4l+KhA8lUVdqUmvQV
         7QVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yg+6lmU7DoPv4P+NYEkJociN1O4zrJvaxxRKLQK1hP0=;
        b=VEorE7sSVndqt5vZYr4VZjAIRQ1mOjHHTduQyVi4I5UmQdw84fnzY+Zd0kG9pLeUxz
         gVDHDWdXDITO6J1D7jLWrp9sxEtbGr8RsrM1Gi6xnr/dFpAPhtdMw4uiXJY1/XpCOcqZ
         gY8y5ELt4CD9L0lFYojRkJjADkmzpiTs/bGmj52aYQ8JcStpGzy41qAT3uZv+KKKmPJV
         UxusJZGtTOY4b8crdEZK3jra7YdX4ZVa9Gq0JdUqZJpHFmRBe2qC8yg0YgkoTanJAezU
         5sDT8Qk8Q2sPJilUvl0kleDYKic++oBffL6DHG3rf5DzWeOlfiHmY4UuUcESn68lM0og
         /IUQ==
X-Gm-Message-State: APjAAAWPszc2ddc6+3PEOiTstgXeMOKfRhotHScLOQ+0ATAWKEk2vMLU
        mChsnJSu8rE3fzIqdOM7iEEVvum0
X-Google-Smtp-Source: APXvYqz6Nc9G6OYDJyh9RAStxWv59Xa5SMaEy089qgxIMF8kDunFAwdrbd8pdn/jjGP6o15IQRQ4mQ==
X-Received: by 2002:a9d:550e:: with SMTP id l14mr6063693oth.369.1556741382789;
        Wed, 01 May 2019 13:09:42 -0700 (PDT)
Received: from [192.168.1.112] (cpe-24-31-245-230.kc.res.rr.com. [24.31.245.230])
        by smtp.gmail.com with ESMTPSA id e133sm17528009oif.44.2019.05.01.13.09.41
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 May 2019 13:09:41 -0700 (PDT)
Subject: Re: [PATCH v9 04/14] rtw88: trx files
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     yhchuang@realtek.com, linux-wireless@vger.kernel.org,
        johannes@sipsolutions.net, pkshih@realtek.com, tehuang@realtek.com,
        sgruszka@redhat.com, briannorris@chromium.org,
        gregkh@linuxfoundation.org
References: <1555653004-1795-1-git-send-email-yhchuang@realtek.com>
 <1555653004-1795-5-git-send-email-yhchuang@realtek.com>
 <87bm0npsp7.fsf@kamboji.qca.qualcomm.com>
 <04c534eb-af32-adfc-62bb-90d83526af1a@lwfinger.net>
 <87a7g6ni31.fsf@kamboji.qca.qualcomm.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
Message-ID: <7a03880d-0fe9-0fdb-7df9-18560ac000c2@lwfinger.net>
Date:   Wed, 1 May 2019 15:09:39 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <87a7g6ni31.fsf@kamboji.qca.qualcomm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 5/1/19 1:30 PM, Kalle Valo wrote:
> Larry Finger <Larry.Finger@lwfinger.net> writes:
> 
>> On 4/30/19 7:45 AM, Kalle Valo wrote:
>>> I'm not really fond of these "byte macros" or whatever they should be
>>> called, you use these a lot in rtw88 but I have seen the same usage also
>>> other drivers. The upstream way of doing this is to create a struct,
>>> which also acts as a documentation, and you can pass it around different
>>> functions. And the GENMASK()s are defined close the struct.
>>>
>>> Also you could change these defines to static inline functions, which
>>> take the struct as a pointer, and that you get type checking from the
>>> compiler. And that way you would get rid of that ugly casting as well.
>>
>> Kalle,
>>
>> I have never been a fan of those complicated macros dating back to the
>> day that I had to make them endian correct. Without Sparse, I never
>> would have made it.
>>
>> I understand your comment about making them be static inline
>> functions, but I am intrigued be the struct method. Is there something
>> other than bit field constructions that could accomplish this?
> 
> My comment was about handling firmware commands and events as a byte
> array, not about bitfields. So that instead of accessing 'index + 1' and
> 'index + 4' you should create a proper struct for the command and access
> it using 'cmd->foo' and 'cmd->bar'. Sure, bitfields you still need to
> access using FIELD_GET() or similar but having a struct for commands is
> a lot cleaner approach. And most upstream drivers do this: ath10k,
> ath6kl, iwlwifi, p54 and whatnot.
> 
> Sorry, no time now to explain further now but, if needed, I can provide
> a better example tomorrow.
> 
>> If not, then this method would be very difficult to implement. My
>> basis is an E-mail by Linus that said it was almost impossible to get
>> this type of construct to be endian correct. If he thinks it is
>> difficult, then I know not to tackle it. :)
> 
> Could you please point Linus' email about this? I would like to
> understand more, I didn't understand your comment.
> 

Do not worry about giving a further answer. I'll read those other drivers and 
figure out what they are doing.

The email exchange I saw was at https://yarchive.net/comp/linux/bitfields.html.

Larry

