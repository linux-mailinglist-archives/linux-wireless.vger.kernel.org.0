Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EACE2397C1
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Jun 2019 23:29:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729982AbfFGV3C (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 7 Jun 2019 17:29:02 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:35682 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729125AbfFGV3B (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 7 Jun 2019 17:29:01 -0400
Received: by mail-ot1-f65.google.com with SMTP id j19so3189240otq.2;
        Fri, 07 Jun 2019 14:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=PXtJCf/u3aaG77BbB4kjKVPDWerY/m2GOEswYNOPNa8=;
        b=jZ4ud1m/Sm87Fur1JYuakDSoD3CBD1Mwo9NCJj9Kkol+x76U7pj69m835XOKnX/hQB
         nWcxtjjzd7dqgevvUQQ1LSJsrnHSfMk/px4b4gpLXSSRF8RcmTS7aVcGY0I33g4IU90m
         jc3YReN3PAMJyZus79Ei6NmlxvE2ByZPqTPBOpRsCQX70+3qjGVstdx0+v+xGkt7QK1C
         SaHT75cp2Kl/XwZXqNz69XKSHmXVmC55DA7wna3Ukt8SsVWQsbYwysEv4GNToYYoiTea
         FPZmoBZK+LvB1HwwoZS0VUBYvFdQ4trZPmeeUa7GUzbsitQsUgIbiEbl2tlLuOTruC6k
         1Prg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PXtJCf/u3aaG77BbB4kjKVPDWerY/m2GOEswYNOPNa8=;
        b=DktF+Sk0qnONgrOpsiqadcJw5muo65WLHBNNq4bopXN+fACd7LHFFzmO6tTU78czkZ
         pshwXdOfQcA19fYCig6L2oJESw8C3byFmAnUhryYwk/eTYoW68XuNVbfUzLdHHLZNsRB
         +jBNY7oE/mw9v3RalkI0hPAXtFC15r2dZ1man03X0bfxqjKo/SgR9K8+IdCaJ3fXbNv6
         hVrylOrpIFKACeeeRNy3zI23fgzdmuOSCDw4k2Tk1bNkYW9cQRd1Rfkd6u9LYZSONH9S
         yVbFMufF4cagfnNMwJbnAORXga7rfIKubmxmfV5+VGv6b1EVQOtbrEschbEuvutFOfru
         m6Aw==
X-Gm-Message-State: APjAAAX6FQbYva0cOZ/Shd9/tv1hO+uR0K6gilh7XUF9F4Y0CvtAIXsv
        Ofx55y1pZzgLVQnl2yVxWnA=
X-Google-Smtp-Source: APXvYqwvZpsybsQXbLEXeYkX7aEPi3et/Duytf7kUjZqmPd80fCulpvRbttRlc210RpqoXeBhY0MQA==
X-Received: by 2002:a9d:2f0:: with SMTP id 103mr11515767otl.182.1559942941161;
        Fri, 07 Jun 2019 14:29:01 -0700 (PDT)
Received: from [192.168.1.249] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id h2sm1124875otk.25.2019.06.07.14.29.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Jun 2019 14:29:00 -0700 (PDT)
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
From:   Denis Kenzior <denkenz@gmail.com>
Message-ID: <d394b421-799d-2019-fcf0-97ba0b2abb5f@gmail.com>
Date:   Fri, 7 Jun 2019 16:28:59 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20190607211514.GD648@sol.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Eric,

On 06/07/2019 04:15 PM, Eric Biggers wrote:
> On Fri, Jun 07, 2019 at 03:45:45PM -0500, Denis Kenzior wrote:
>> Hi Ard,
>>
>>>
>>> Ah ok, good to know. That does imply that the driver is not entirely
>>> broken, which is good news I suppose.
>>>
>>
>> Not entirely, but we did have to resort to using multiple sockets, otherwise
>> parallel encrypt/decrypt operations on the socket would result in invalid
>> behavior.  Probably due to the issue Eric already pointed out.
>>
>> No such issue with any other ciphers that we use.
>>
>> Regards,
>> -Denis
> 
> Okay, that sucks, so we do have to keep "ecb(arc4)" in the crypto API then.  And
> we can't fix its name to be just "arc4".  It's odd that someone would choose to
> use AF_ALG over writing a 20 line arc4_crypt() in userspace, but whatever.
> 
> Yes, "ecb(arc4)" isn't currently thread safe.  ARC4 uses a single key whereas
> modern stream ciphers use a key + IV.  To comply with the crypto API it would
> have to copy the key to a stack buffer for each encryption/decryption.  But it
> doesn't; it just updates the key instead, making it non thread safe.  If users
> are actually relying on that, we'll have to settle for adding a mutex instead.

Well the issue isn't even about being thread safe.  We run a single 
thread in iwd.  The details are a bit fuzzy now due to time elapsed, but 
if I recall correctly, even behavior like:

fd = socket();
bind(fd, ecb(arc4));
setsockopt(fd, ...key...);

sendmsg(fd, OP_ENCRYPT, ...);
sendmsg(fd, OP_DECRYPT, ...);
sendmsg(fd, OP_ENCRYPT, ...);

would produce different (incorrect) encrypted results compared to

sendmsg(fd, OP_ENCRYPT, ...)
sendmsg(fd, OP_ENCRYPT, ...)

Regards,
-Denis
