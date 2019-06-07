Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA5D339819
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Jun 2019 23:54:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731503AbfFGVyH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 7 Jun 2019 17:54:07 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:45874 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730523AbfFGVyH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 7 Jun 2019 17:54:07 -0400
Received: by mail-oi1-f196.google.com with SMTP id m206so2444978oib.12;
        Fri, 07 Jun 2019 14:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=BTq3UDvMDxHefcWQxSqSVwm/O7Z2U4bL736xUIMRRcQ=;
        b=gDLd4ZS7J8n1zNzxC5s7wKY+B0u/ULaapnaV/qpGqVQqItwjIjht2PS4kunRgIky4U
         xx/Ao9YMOudGqaRLza8EBkS5M+vJeBtK9IkxkfXKntaegua8nBfOA8vM7q2LGBg/hjvP
         1y0GW7i+Eh0eoUg8iqI1tZ8CG+qCrVB0LHNw2S8GFcR5vtrSusPoGSu22PcNLHFJBznL
         2SVJmMbPAYQnNkQJ6E0KDUflhizBhUXgs2/lSbXXMa0E8DvsIKsW6bTStzZFjUHl2vxv
         61qlToT4OhZ+CFVy3rLzdVx/Jds192mw9bAu7FpJPQ4S8zueb1H7mdVlBypJu6Ki1fkc
         rzZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BTq3UDvMDxHefcWQxSqSVwm/O7Z2U4bL736xUIMRRcQ=;
        b=NJCkOd2E4ksisRnvj9n0L1267BFXTv0qKF6kgEDyeC3cY9NBzVRZdSgD0WUAQwAcdN
         MDAgaBdNTKZZS2PaMA80j5GhyIhztmAyU5WJdn8+knXP4DPhmfSPF+pUeBgq0qwZCel4
         O6mnBE1CH+L1eFg2GT1ObUdLtHHiXg6k9ej/E5vS1B8UcLzbx9YrMRcNjo2xATHLZY3T
         iRP/vLjPjxlNMtAJOnFKkgNCwjXS9E4XH1pNOLDwxtI2rqYnnuCgl8tqTxhlrK9IEGZ2
         8+vA3EC0N3qzCs1Vb2cNbmEO9yafMwmt8GvFHs8ENqpSdTCjcPknbQOH/+64Hpu6b/l4
         jEMg==
X-Gm-Message-State: APjAAAUjxj+jznR9Ycha7jwfEiXc/SO8vzM6uvrDqH/UmjWjv87F/sde
        N+Ur9l9bFNeVol9uwlIS5Mg=
X-Google-Smtp-Source: APXvYqyyupJope+WTrF9MQ7KJmBrRBosIMdEZtxUlD7TICzP7fn9UAWBPAzqemauKv0VafKxeWmSGg==
X-Received: by 2002:aca:b58b:: with SMTP id e133mr5090909oif.49.1559944446145;
        Fri, 07 Jun 2019 14:54:06 -0700 (PDT)
Received: from [192.168.1.249] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id k11sm691030oic.6.2019.06.07.14.54.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Jun 2019 14:54:05 -0700 (PDT)
Subject: Re: [RFC PATCH 0/3] move WEP implementation to skcipher interface
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Johannes Berg <johannes@sipsolutions.net>,
        "open list:NFC SUBSYSTEM" <linux-wireless@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>
References: <20190607144944.13485-1-ard.biesheuvel@linaro.org>
 <20190607175947.GB648@sol.localdomain>
 <97BB95F6-4A4C-4984-9EAB-6069E19B4A4F@holtmann.org>
 <CAKv+Gu-ek4nK+cACx5QZTbp=ciQq_Fvtn9y3g-wFWSOabyczZg@mail.gmail.com>
 <f40ad169-93b9-636f-9656-634ff331ee2b@gmail.com>
 <20190607211514.GD648@sol.localdomain>
 <d394b421-799d-2019-fcf0-97ba0b2abb5f@gmail.com>
 <20190607214120.GE648@sol.localdomain>
From:   Denis Kenzior <denkenz@gmail.com>
Message-ID: <78298612-a36b-deaa-1510-94cf0001af9d@gmail.com>
Date:   Fri, 7 Jun 2019 16:54:04 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20190607214120.GE648@sol.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Eric,

On 06/07/2019 04:41 PM, Eric Biggers wrote:
> On Fri, Jun 07, 2019 at 04:28:59PM -0500, Denis Kenzior wrote:
>> Hi Eric,
>>
>> On 06/07/2019 04:15 PM, Eric Biggers wrote:
>>> On Fri, Jun 07, 2019 at 03:45:45PM -0500, Denis Kenzior wrote:
>>>> Hi Ard,
>>>>
>>>>>
>>>>> Ah ok, good to know. That does imply that the driver is not entirely
>>>>> broken, which is good news I suppose.
>>>>>
>>>>
>>>> Not entirely, but we did have to resort to using multiple sockets, otherwise
>>>> parallel encrypt/decrypt operations on the socket would result in invalid
>>>> behavior.  Probably due to the issue Eric already pointed out.
>>>>
>>>> No such issue with any other ciphers that we use.
>>>>
>>>> Regards,
>>>> -Denis
>>>
>>> Okay, that sucks, so we do have to keep "ecb(arc4)" in the crypto API then.  And
>>> we can't fix its name to be just "arc4".  It's odd that someone would choose to
>>> use AF_ALG over writing a 20 line arc4_crypt() in userspace, but whatever.
>>>
>>> Yes, "ecb(arc4)" isn't currently thread safe.  ARC4 uses a single key whereas
>>> modern stream ciphers use a key + IV.  To comply with the crypto API it would
>>> have to copy the key to a stack buffer for each encryption/decryption.  But it
>>> doesn't; it just updates the key instead, making it non thread safe.  If users
>>> are actually relying on that, we'll have to settle for adding a mutex instead.
>>
>> Well the issue isn't even about being thread safe.  We run a single thread
>> in iwd.  The details are a bit fuzzy now due to time elapsed, but if I
>> recall correctly, even behavior like:
>>
>> fd = socket();
>> bind(fd, ecb(arc4));
>> setsockopt(fd, ...key...);
>>
>> sendmsg(fd, OP_ENCRYPT, ...);
>> sendmsg(fd, OP_DECRYPT, ...);
>> sendmsg(fd, OP_ENCRYPT, ...);
>>
>> would produce different (incorrect) encrypted results compared to
>>
>> sendmsg(fd, OP_ENCRYPT, ...)
>> sendmsg(fd, OP_ENCRYPT, ...)
>>
> 
> That's because currently each operation uses the next bytes from the keystream,
> and a new keystream is started only by setsockopt(..., ALG_SET_KEY, ...).
> There's no difference between ARC4 encryption and decryption; both just XOR the
> keystream with the data.  Are you saying you expected each encryption to be a
> continuation of the previous encryption, but decryptions to be independent?
> 

 From a userspace / api perspective, yes I would have expected the 
encrypt and decrypt to work independently.  No biggie now, but I 
remember being surprised when this bit me as no other cipher had this 
behavior.  E.g. interleaving of operations seemed to only affect arc4 
results.

Are the exact semantics spelled out somewhere?

Regards,
-Denis
