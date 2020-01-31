Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2BCB514E9D3
	for <lists+linux-wireless@lfdr.de>; Fri, 31 Jan 2020 09:50:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728164AbgAaIuT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 31 Jan 2020 03:50:19 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38219 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728141AbgAaIuT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 31 Jan 2020 03:50:19 -0500
Received: by mail-wr1-f67.google.com with SMTP id y17so7639670wrh.5
        for <linux-wireless@vger.kernel.org>; Fri, 31 Jan 2020 00:50:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hU5postrxd2Z+I0s97KAquQNmprVibWfKwFZYOgeXJM=;
        b=gnCcOWVf62SAeMYNgjIIGV8QhMAGm1Naxa1Ck30+I7ZgqUD+o5BylxRnHlO9o2ZiKi
         bdzTijCiA5CY0hCRfuo9nlFukR+ZEZfU80pjKGrLrHbiwHtnceO8manvwPN7ozMIrAyJ
         FupUGmuq8tSzmqnaFnTj3QrsVUFlt/HA7v6rA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hU5postrxd2Z+I0s97KAquQNmprVibWfKwFZYOgeXJM=;
        b=RNt984R2xEOzBGW4i7/YJKG3Ggug1Bgx/UmLXvBENcFuXURMeBV5+O2Vhf6IHOYqTl
         A7o0jSffk0XTGbgJnmOkujhbvgh8wTjMqha7LVCATRik9GMtrs/X3/3nmsfQfaPhpyRx
         BJOff6NGPl2q7eDgE91YG5P+i8ZI+to9Vor6xoLi62pzKtbSrXrJSKnJRep2D8gAGk1N
         tlHlpxRtIm0l5os16Z9OKC/t0Y+nVoY81+p1jArk6K9GrPQADJvk/F1YQOAinXq4iU/U
         QOgo6WUTbuGFH3dKsbfmW+kcMExj9tGL39ewKfZZ+wMS+1KhMzukAOPFkrPyGeKe8anC
         3Klw==
X-Gm-Message-State: APjAAAWqx+kZpQtXC8mEcM1lwABKxZRXjMCnmXONhUCG5zdAWKi3bDSe
        SJcqMyd2JcNoerLz66bGK86P+Q==
X-Google-Smtp-Source: APXvYqx0gMJ4oR+2H7wrLDbf1HDlffrOq+OxgT6XZWeSnpJp1MTZr+9jkxDilQjQck90LxtOoT377w==
X-Received: by 2002:a5d:4984:: with SMTP id r4mr10479452wrq.137.1580460616905;
        Fri, 31 Jan 2020 00:50:16 -0800 (PST)
Received: from [192.168.178.129] (f140230.upc-f.chello.nl. [80.56.140.230])
        by smtp.gmail.com with ESMTPSA id 5sm7017184wrc.75.2020.01.31.00.50.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Jan 2020 00:50:16 -0800 (PST)
Subject: Re: [PATCH v2] brcmfmac: add the BRCM 4364 found in MacBook Pro 15,2
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        brcm80211-dev-list@cypress.com,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Chi-Hsien Lin <chi-hsien.lin@cypress.com>,
        Wright Feng <wright.feng@cypress.com>
References: <20200126155108.7DDD7C433CB@smtp.codeaurora.org>
 <20200126193339.167346-1-sandals@crustytoothpaste.net>
 <16fe3b278d0.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <20200126230029.GI4113372@camp.crustytoothpaste.net>
 <71763ca9-ed7a-2403-b85a-d7dc624cd050@broadcom.com>
 <87a766xq4u.fsf@tynnyri.adurom.net>
From:   Arend Van Spriel <arend.vanspriel@broadcom.com>
Message-ID: <2a7409b1-df6a-4d94-6a28-d69990ba01eb@broadcom.com>
Date:   Fri, 31 Jan 2020 09:50:14 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <87a766xq4u.fsf@tynnyri.adurom.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org



On 1/29/2020 4:02 PM, Kalle Valo wrote:
> Arend Van Spriel <arend.vanspriel@broadcom.com> writes:
> 
>>> There is also precedent for users acquiring firmware themselves via the
>>> b43 and b43legacy drivers, where users have to use a script to extract
>>> the firmware from other drivers.
>>>
>>> I wish I had a better answer to this, but I don't work for Broadcom or
>>> anyone associated with it and am just trying to get the Mac I was given
>>> for $DAYJOB to work with Linux.  Perhaps since you do you'd be willing
>>> to ask them to release the firmware.
>>>
>>> The alternative is that the chip doesn't work at all (and can't be added
>>> via the new_id sysfs entry because of the rambase setting) and users
>>> have to compile a custom patched kernel to make their wireless card work
>>> at all.  I'd really prefer to avoid that if possible, since it's
>>> a strictly worse experience in every way.
>>
>> How about putting this device under some Kconfig flag. If distro
>> kernel start probing the device and fail, most users will probably
>> turn to their distro for help. Having a Kconfig with a good
>> description could avoid that. It would mean an extra step of building
>> the driver though.
> 
> I don't understand the issue you are trying to solve. If the firmware
> image is missing there's a clear error message in the log and the kernel
> continues to operate normally, right? That way users have a clear
> understanding why their wireless is not working, and hopefully push
> Broadcom to release the firmware with a suitable license :)

Hi Kalle,

Actually as there is precedent of firmwareless drivers in distros I am 
fine with the change as is.

Regards,
Arend
