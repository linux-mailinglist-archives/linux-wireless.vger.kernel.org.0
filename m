Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4AC2739919
	for <lists+linux-wireless@lfdr.de>; Sat,  8 Jun 2019 00:47:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729981AbfFGWra (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 7 Jun 2019 18:47:30 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:37420 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729629AbfFGWra (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 7 Jun 2019 18:47:30 -0400
Received: by mail-io1-f68.google.com with SMTP id e5so2651905iok.4;
        Fri, 07 Jun 2019 15:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=x1N+1j3185njJEKd7t0avtMttiYY52tbAqSWPNX3l+c=;
        b=mkRxlQ+FtejDTRDsOkAKDb/+6XJzWXwfwOtVVXb8b+EWafcIbHTerLEqR0vwCS/d2C
         Bld36mEdkvE7pk2mtI4qSXK9Ozv1pOYcHRaVEQG39UPsuRHnRZJEaC+CSYgKhBI0jgpG
         Vr7tviy1nX7fZb8UCxwr0EljzJpcbRB1uo1BU2BTUTsbu3z7YOvtXWni34UaiahS5AL2
         2vUKKm6CCbM24U2Z/6oKRQOqBlU+D934AnZLIuSPLTKCoKcYBSJe/qwed+37CKrN58VY
         gG2kk/gzFlCzqZayA61c+tWkjb4Mhi8qhq7CddtaUXr7tAUc9foGp3hB66HDh/7lEGci
         xxNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=x1N+1j3185njJEKd7t0avtMttiYY52tbAqSWPNX3l+c=;
        b=qQhixt00E7iLnZxI9Q9iXPR4WUbL0O+c6mr3M/CkAmifQSweWp4bDJrMV/lKS7+2eZ
         h+lVfPnn4EnS8qyjn78fNA8gg/0pj+KtkyZEK8IEOMUueZUkbD2gk+na8OPWUud5pQ0F
         8OHzvVbfhCo4GawSfSNnKy4gSJ+g2QS3Q59sQwJUlNQD64hyqJ57o01NCiyKS9HqODJ6
         1IcPrxyEt66uz8DEe19tPsJ7Nkxl8+te+0YzCkXCk3Tpx/D2owJycyffHdV3H5Q+oqBV
         JBR229zmIAbvSeRWs7QcBWn6xzh6Pij0WX5j/e2RTZLAmdolJrd27ZlCwvkXfhh9MJaa
         ge7A==
X-Gm-Message-State: APjAAAVUA/uKreN/GcMMYVeXB0ybS2fOz3y2BObSWmgSZ/BgeqfV99ft
        Cx9GvLZn87h3kTclh4PbKuk=
X-Google-Smtp-Source: APXvYqwq5rh9tiAUwo+BYjXjYSD6lhsDgGcLR6utVidC9qv/H+tGb0bnE/Ez8yhomyJmXCQBs5EMZA==
X-Received: by 2002:a5e:8505:: with SMTP id i5mr5762195ioj.101.1559947649086;
        Fri, 07 Jun 2019 15:47:29 -0700 (PDT)
Received: from [192.168.1.249] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id b3sm1209045iot.23.2019.06.07.15.47.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Jun 2019 15:47:28 -0700 (PDT)
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
 <78298612-a36b-deaa-1510-94cf0001af9d@gmail.com>
 <20190607224040.GG648@sol.localdomain>
From:   Denis Kenzior <denkenz@gmail.com>
Message-ID: <61e1cd8a-4891-4e37-417e-1c31cd95a278@gmail.com>
Date:   Fri, 7 Jun 2019 17:47:27 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20190607224040.GG648@sol.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Eric,

On 06/07/2019 05:40 PM, Eric Biggers wrote:
> On Fri, Jun 07, 2019 at 04:54:04PM -0500, Denis Kenzior wrote:
>> Hi Eric,
>>
>> On 06/07/2019 04:41 PM, Eric Biggers wrote:
>>> On Fri, Jun 07, 2019 at 04:28:59PM -0500, Denis Kenzior wrote:
>>>> Hi Eric,
>>>>
>>>> On 06/07/2019 04:15 PM, Eric Biggers wrote:
>>>>> On Fri, Jun 07, 2019 at 03:45:45PM -0500, Denis Kenzior wrote:
>>>>>> Hi Ard,
>>>>>>
>>>>>>>
>>>>>>> Ah ok, good to know. That does imply that the driver is not entirely
>>>>>>> broken, which is good news I suppose.
>>>>>>>
>>>>>>
>>>>>> Not entirely, but we did have to resort to using multiple sockets, otherwise
>>>>>> parallel encrypt/decrypt operations on the socket would result in invalid
>>>>>> behavior.  Probably due to the issue Eric already pointed out.
>>>>>>
>>>>>> No such issue with any other ciphers that we use.
>>>>>>
>>>>>> Regards,
>>>>>> -Denis
>>>>>
>>>>> Okay, that sucks, so we do have to keep "ecb(arc4)" in the crypto API then.  And
>>>>> we can't fix its name to be just "arc4".  It's odd that someone would choose to
>>>>> use AF_ALG over writing a 20 line arc4_crypt() in userspace, but whatever.
>>>>>
>>>>> Yes, "ecb(arc4)" isn't currently thread safe.  ARC4 uses a single key whereas
>>>>> modern stream ciphers use a key + IV.  To comply with the crypto API it would
>>>>> have to copy the key to a stack buffer for each encryption/decryption.  But it
>>>>> doesn't; it just updates the key instead, making it non thread safe.  If users
>>>>> are actually relying on that, we'll have to settle for adding a mutex instead.
>>>>
>>>> Well the issue isn't even about being thread safe.  We run a single thread
>>>> in iwd.  The details are a bit fuzzy now due to time elapsed, but if I
>>>> recall correctly, even behavior like:
>>>>
>>>> fd = socket();
>>>> bind(fd, ecb(arc4));
>>>> setsockopt(fd, ...key...);
>>>>
>>>> sendmsg(fd, OP_ENCRYPT, ...);
>>>> sendmsg(fd, OP_DECRYPT, ...);
>>>> sendmsg(fd, OP_ENCRYPT, ...);
>>>>
>>>> would produce different (incorrect) encrypted results compared to
>>>>
>>>> sendmsg(fd, OP_ENCRYPT, ...)
>>>> sendmsg(fd, OP_ENCRYPT, ...)
>>>>
>>>
>>> That's because currently each operation uses the next bytes from the keystream,
>>> and a new keystream is started only by setsockopt(..., ALG_SET_KEY, ...).
>>> There's no difference between ARC4 encryption and decryption; both just XOR the
>>> keystream with the data.  Are you saying you expected each encryption to be a
>>> continuation of the previous encryption, but decryptions to be independent?
>>>
>>
>>  From a userspace / api perspective, yes I would have expected the encrypt
>> and decrypt to work independently.  No biggie now, but I remember being
>> surprised when this bit me as no other cipher had this behavior.  E.g.
>> interleaving of operations seemed to only affect arc4 results.
>>
>> Are the exact semantics spelled out somewhere?
>>
> 
> For all other skcipher algorithms, every operation is independent and depends
> only on the key which was set previously on the algorithm socket, plus the IV
> provided for the operation.  There is no way to perform a single encryption or
> decryption incrementally in multiple parts, unless the algorithm supports it
> naturally by updating the IV (e.g. CBC mode).

Right, that is what I thought.

> 
> As I am attempting to explain, ecb(arc4) does not implement this API correctly
> because it updates the *key* after each operation, not the IV.  I doubt this is
> documented anywhere, but this can only be changed if people aren't relying on it
> already.

It sounds to me like it was broken and should be fixed.  So our vote / 
preference is to have ARC4 fixed to follow the proper semantics.  We can 
deal with the kernel behavioral change on our end easily enough; the 
required workarounds are the worse evil.

Regards,
-Denis
