Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EDDB1396FF
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Jun 2019 22:45:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730242AbfFGUpr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 7 Jun 2019 16:45:47 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:39174 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729640AbfFGUpr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 7 Jun 2019 16:45:47 -0400
Received: by mail-ot1-f66.google.com with SMTP id r21so3083860otq.6;
        Fri, 07 Jun 2019 13:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zKQpC28+fMaUKoMpAL7IKWkXUs1nFaBz+Nb/D2b3P3o=;
        b=pqSDWULiFsTxWfzL9w8OimC9UdfvQ0PNUb1Ux0bW5bYVFoi3tqqBHCBIdTQG4xloSG
         Gd600djS7C8797Kao2fgUJJYyN/da7spO1Pb4KSY3+EsZ/3WcM/yyBxGNn9dHy6Wmd7c
         gDjcoj5YoDbn4Q4wpCAPfiwB99IhQ58l4VXzEAGBnXeA/2uVi2Og7JcfPF5HSFImZF6O
         h8EZqlitXzZBxL9AvYNhtQgDElcpLMfnz/pkiZvUMShXjw6SMj3kcxymPqkJNlpaGW4r
         MCPm4/lFkjsekr+tsia9eLFWP07rBDvPZDKk3fwIxidWKOPkkJLA5iB4j2y7yx3IhikH
         kHmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zKQpC28+fMaUKoMpAL7IKWkXUs1nFaBz+Nb/D2b3P3o=;
        b=by5N0ByVFJZlWP/wnpPbe6Ym3s3ByS8Z13zYVaXqqcikMgWYnelJROXhaYnvphAc2b
         e1pwmBQq0Tr9jj80yjhNPaMVNQZEEwEMySFoDzhWmeNLhUVBVzHPFToLpxVZXiniEaaz
         vTI5lkKcbmAZogAgv/OSXBg7NtcjdogxQ20sLgt1sIjfKlL+vAvMcasQAW8I17QCYMxK
         MsAURUUt8OGknywSiua4A7C398EHPXmepjvqVACYtnHwFCSVjLF1513kUR6I9DRZgokF
         SopRqrvIyxJ3AeW+nW5he4GCsztEmpWLeiqy8U4tBEn5v4jGe2SG5CViofy75zXLMmR8
         hXgg==
X-Gm-Message-State: APjAAAWnxQYdIi3CgzKWY48jo2YiREq6mmMKRq/bsMHdJ1+FXhtSXVyz
        AMOty95/PLcTJweG5/t5MHrJl6To
X-Google-Smtp-Source: APXvYqxqVkHo+7S7GIasg4NEBRa6Ov1AdrlChjsdnFREOZ8hrDudGm/dUU/H21QPN2sWrr1X9SxUwA==
X-Received: by 2002:a9d:6a92:: with SMTP id l18mr8864877otq.294.1559940346474;
        Fri, 07 Jun 2019 13:45:46 -0700 (PDT)
Received: from [192.168.1.249] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id x204sm1119197oig.9.2019.06.07.13.45.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Jun 2019 13:45:46 -0700 (PDT)
Subject: Re: [RFC PATCH 0/3] move WEP implementation to skcipher interface
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Marcel Holtmann <marcel@holtmann.org>
Cc:     Eric Biggers <ebiggers@kernel.org>,
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
From:   Denis Kenzior <denkenz@gmail.com>
Message-ID: <f40ad169-93b9-636f-9656-634ff331ee2b@gmail.com>
Date:   Fri, 7 Jun 2019 15:45:45 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <CAKv+Gu-ek4nK+cACx5QZTbp=ciQq_Fvtn9y3g-wFWSOabyczZg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Ard,

> 
> Ah ok, good to know. That does imply that the driver is not entirely
> broken, which is good news I suppose.
> 

Not entirely, but we did have to resort to using multiple sockets, 
otherwise parallel encrypt/decrypt operations on the socket would result 
in invalid behavior.  Probably due to the issue Eric already pointed out.

No such issue with any other ciphers that we use.

Regards,
-Denis
