Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9FA0661CB9
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Jul 2019 12:07:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729295AbfGHKHs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 8 Jul 2019 06:07:48 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40330 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728766AbfGHKHr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 8 Jul 2019 06:07:47 -0400
Received: by mail-wm1-f68.google.com with SMTP id v19so15718089wmj.5
        for <linux-wireless@vger.kernel.org>; Mon, 08 Jul 2019 03:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=lS1oKZfuH2fVYb9h+hELkwrZLo3acanxQpzb134tZn4=;
        b=WwZnSOzWX3t1njV8wfY7AknIOx2HyTcuvw7EBefy2eIukFr4/qc6B5ZgIqpyBQa/B7
         YODGpY3V2vytiXu16XvyCxuAPebAKz+6f3YZj5kxQFxKg9lY5SS34SNTq9IR9JUkYxVh
         Sn1ZH7AJOpTjGp2sd8eDEOWB1hlhSuDxsd36s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lS1oKZfuH2fVYb9h+hELkwrZLo3acanxQpzb134tZn4=;
        b=t+sKVGT0tPVpL82Z+9jwDQ8JDBfqDBSoJMeWF1xF2CcPDo+2KYEbqh9tcjvRtQAFyI
         DcZOoiEwb/lRQd1j+4paAoA76SRuvgETkldTwW2oB6ScNy6pnvFT/66RX7XwRZC75T3w
         HNiPqwCEFNLpDK+xTFLoVA8+V3WZ7Hb8rzhuA/atsd3FJTVqMnQBa89cpXiQWqiisIj/
         efSwEBlqbm0bHMgHcNM2uP1DGuXU7fMjaEbQZXEFZ6Livv+VG9i3KKaWQTWLrZ1mfe5e
         r5ORaL8lw04H+nv9X/awd+CFehcTJwB45vaAZX38ITO3jvqgxqSGUBxzLBjagF3ok/0N
         VoXA==
X-Gm-Message-State: APjAAAXPC7oSS+WqxMyduPp6eF6qAgyUOAgQbyMnV8VczLilOLn0uCfK
        RUAsDT4ySYUWFv0pu8R5pP/dIw==
X-Google-Smtp-Source: APXvYqxDtDchJp/KeyqZXK3I0wHWJUSLwX6KZNblQStS7DCpJ6Erk952J3X3qeE7zbPweE/XPEOXSA==
X-Received: by 2002:a7b:c383:: with SMTP id s3mr16144470wmj.44.1562580465423;
        Mon, 08 Jul 2019 03:07:45 -0700 (PDT)
Received: from [10.176.68.244] ([192.19.248.250])
        by smtp.gmail.com with ESMTPSA id v4sm15727633wmg.22.2019.07.08.03.07.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Jul 2019 03:07:44 -0700 (PDT)
Subject: Re: [PATCH 3/7] brcmsmac: switch source files to using SPDX license
 identifier
To:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, alan@lxorguk.ukuu.org.uk
References: <1558008251-13692-1-git-send-email-arend.vanspriel@broadcom.com>
 <1558008251-13692-4-git-send-email-arend.vanspriel@broadcom.com>
 <20190516173113.GA540@kroah.com>
 <a5d32b2f-a99b-a248-1acd-9de532732e30@broadcom.com>
 <20190516200131.GA15814@kroah.com>
 <eeebea29-4237-6e49-7578-8d3b1ad7df85@broadcom.com>
 <CACna6rxuSFWN8eib7FpJiVQqLwdD5GOTaAFr7msJa01rBSTLKA@mail.gmail.com>
From:   Arend Van Spriel <arend.vanspriel@broadcom.com>
Message-ID: <34aa04e4-9ddd-b6aa-721f-a20398f7740d@broadcom.com>
Date:   Mon, 8 Jul 2019 12:07:43 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <CACna6rxuSFWN8eib7FpJiVQqLwdD5GOTaAFr7msJa01rBSTLKA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

+ Alan

On 5/17/2019 8:07 PM, Rafał Miłecki wrote:
>>>> Another option could be MIT license which is in the preferred folder.
>>>> Will have to consult our legal department about it though.
>>> Hey, if your legal department is going to get asked this, why not just
>>> switch it to GPLv2?  That would make everything much simpler.
>> Hah. Because I already know the answer to that.;-)
> It's not that obvious to me, sorry. Does your legal department require
> something more permissive than GPLv2? Is that worth asking them about
> dual-licensing? Something like
> GPL-2.0 OR MIT
> ? That assures driver is compatible with Linux, no matter what's the
> current lawyers interpretation of MIT vs. GPL 2.0. I believe Alan Cox
> once told/suggested that dual-licensing is safer for legal reasons.

Hi Alan,

Rafał mentioned your name a while ago when I was struggling with the 
SPDX identifiers. The drivers sources I want to modify for this 
originally had a license text in the header that matches ISC. However,
one of the files did not have that and it was marked in bulk to GPLv2. 
So now the question is whether I can change it to ISC like the rest or 
should I make it dual like Rafał suggested.

Can you elaborate the pros and cons of dual license?

Regards,
Arend
