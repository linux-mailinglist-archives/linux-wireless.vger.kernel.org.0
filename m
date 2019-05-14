Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0EB3D1CD1B
	for <lists+linux-wireless@lfdr.de>; Tue, 14 May 2019 18:36:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726109AbfENQgE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 14 May 2019 12:36:04 -0400
Received: from mail-wr1-f46.google.com ([209.85.221.46]:46553 "EHLO
        mail-wr1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726036AbfENQgE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 14 May 2019 12:36:04 -0400
Received: by mail-wr1-f46.google.com with SMTP id r7so2137167wrr.13
        for <linux-wireless@vger.kernel.org>; Tue, 14 May 2019 09:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=XveLFzCb5KHPyye9JOs96NPh1yJsNROqoUari4A22f4=;
        b=W0mtepiRX95RHyP1+6mzs1OABESMcQl6C2JwbmSF1CTn7BXzoNNKIEv9KgrPFy13K6
         ZwG3xFotsCBpaaVJfuvmt1X1rJDByICesO8VkguK+4Wgo2TOxk5G7ujBd4z0AuT1FG/K
         /o3R7hQca5HAXrJAbIW7SeiaAiX83UhL2zY3FNuKBCZBUuNAgaqlwUbiLsk5wvh/Iar3
         777yjQAQlRlmc+DRIT6HOCARz0ttbxnJAEcI9MckzwjQt4kGEwYmaSxKhTHTToekSXFg
         bWj6xRpHfsWVYdN9vzHqKctcw0LIifIaNEml7DjkhNNfsEf4Soz7/fieOn/X8coKO9Id
         lrpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XveLFzCb5KHPyye9JOs96NPh1yJsNROqoUari4A22f4=;
        b=dS7RBRfMsfiLdF75SVhKVZUbXn0sfXnks0K2YuNNbJO5L7r2QJSFOETqMV/JzcM6WV
         nRN5zu0qIz9UBbNIvuga9L7L+fNOVBdoeLkRqxcOf/4gdUDY0PvrUuC/62PXB+OpwDA3
         GxLDDVcsfuokb0Y7kC9UdRz3ReGRrf2+nCNec9Zt6Cm8Bh9lDo20X0OgEPiYp8xNETT2
         TQcJX/QEWsDjXKjm4X/0SYfQEN5XQnQKb/Ho3Q4E5fmvH0EI9UczxSbO7XOqR1wc+utu
         oFyA8ntMnPSKoQoVE5Jno23V+Ezc+no1pC/JfA5omFIzf9HysVwjUfRHnH/ak6LqjNYN
         OicQ==
X-Gm-Message-State: APjAAAXOHkEu2gCrf6H+aJMKHLPrHMHJVEzmcPwinFWpB2JojgT57TEX
        /H7big6XnZf6yHb6Nh2kDkwWGQ==
X-Google-Smtp-Source: APXvYqwzu9DXFh7MRoFOA1+bogimnRcdJNLazl0C3QmsrUD2jWawVP8Eo1nxf//2+gHBMSOeO4j1AQ==
X-Received: by 2002:a5d:4308:: with SMTP id h8mr1844962wrq.22.1557851762202;
        Tue, 14 May 2019 09:36:02 -0700 (PDT)
Received: from [192.168.0.41] (sju31-1-78-210-255-2.fbx.proxad.net. [78.210.255.2])
        by smtp.googlemail.com with ESMTPSA id s22sm4995768wmh.45.2019.05.14.09.36.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 May 2019 09:36:01 -0700 (PDT)
Subject: Re: NXP NFC version and ACPI
To:     sedat.dilek@gmail.com
Cc:     Samuel Ortiz <sameo@linux.intel.com>,
        linux-wireless@vger.kernel.org, linux-nfc@lists.01.org,
        oleg.zhurakivskyy@intel.com, clement.perrochaud@effinnov.com,
        charles.gorand@effinnov.com,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
References: <c2d0d19f-d814-8f41-4860-77b9cc7f9d26@linaro.org>
 <CA+icZUVz7sB6hv4fhL_rqhR_D8RePBJFXk1PaUy5tMw2z4xC_Q@mail.gmail.com>
 <5ae87449-83a1-ecce-c72c-b4742c507497@linaro.org>
 <CA+icZUXDLQKyTH-_pPi7A2=Bu5ratwab930Fcecrdr4NtMnFcw@mail.gmail.com>
 <27f2ce02-8deb-384f-af10-7737b703770a@linaro.org>
 <CA+icZUVaBdswfmRfbRtdVJY8ymeDOwDSFEf7G6jneqEmpW84bg@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <a44f7d09-a0f0-6e3b-c097-f736cfa28444@linaro.org>
Date:   Tue, 14 May 2019 18:36:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CA+icZUVaBdswfmRfbRtdVJY8ymeDOwDSFEf7G6jneqEmpW84bg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 14/05/2019 16:59, Sedat Dilek wrote:
> On Tue, May 14, 2019 at 10:17 AM Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
> [...]
> 
> Just for the records:
> 
> root@iniza:~# rfkill --output ID,TYPE
> ID TYPE
>  0 bluetooth
>  1 nfc
>  2 wlan
>  3 bluetooth
> 
> root@iniza:~# rfkill list nfc
> 1: nfc0: NFC
>         Soft blocked: no
>         Hard blocked: no
> 

Thanks, I have checked and it is the same values.
-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

