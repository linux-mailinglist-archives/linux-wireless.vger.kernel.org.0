Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B7861C360
	for <lists+linux-wireless@lfdr.de>; Tue, 14 May 2019 08:43:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726143AbfENGnC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 14 May 2019 02:43:02 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54381 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726109AbfENGnC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 14 May 2019 02:43:02 -0400
Received: by mail-wm1-f65.google.com with SMTP id i3so1511221wml.4
        for <linux-wireless@vger.kernel.org>; Mon, 13 May 2019 23:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=vwQVGP4QMJolo/v2Azys7xjikuSvEhjgr8aoZ3xvWyM=;
        b=oCrzi9rPg9K49NhAOi+CVulTWPFGJ1tohB9AF7/d7QRTOOZz45dfqCFEIuiUXxwLKK
         iypZEb62/p4AqN4LXYgpVnlyvu0vK0ssc8GV/7tZga1+KUjwtQomP/6/JKHGYhWCA50d
         jApL1jUFGbblm+PjJ8rVSCNP3GFKKT8hASJ+0U2wyBg3iOkIc4+/lHvsQP7J15VgAaDi
         UqINCZr5elbkRHKumQapkd+HdTr1RJV+bIsTEOUoySN4KTUH6lPSyeZUzyiT1neLnRP3
         diFuzxeU/bRNWXlw0L95Av9Gm4dJCyw5rQoJ9lPnjBi4LD28ziFtHD7OJbnkbsvw7nHr
         la7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vwQVGP4QMJolo/v2Azys7xjikuSvEhjgr8aoZ3xvWyM=;
        b=Aa95vQRhMXbZ6j/xODaLQdsFmn3Hx7u/uQzCugE6IzZqF9wKpMsG2bS4pGjRo5Tklr
         7ObTHvRd9sAo/YPBShnuVcsPzKKvDtWa7mJYq/cItCPk9nDEl76iXvLDI24XZyzOtapF
         wP1ESvRdSGL9SCB76V/cbhMHWON4S5pYrTa1S93jQ9lk1B9NObuk0Bo4lQG3Ea8Obl0q
         1j4OYORjQrsS2avIExEeL+uteQWEj8BSmX8s6v8ecDQVS/U2cexVZKi+lx/VC2bZf5Vq
         Bt0I9jb1J8Zomj72LaeKJxuNIAAugwiwJ/l9BM1yrcSCZ64R34DF7jqrYAuC53U8C4+9
         iftg==
X-Gm-Message-State: APjAAAXm5QqxagY4Z+5IbTcOKc3a7m2rZFT8dWXZQF8umVzYF8iKs3Q+
        RXXw3mZJSnpzDJHRD4M6FUy1yw==
X-Google-Smtp-Source: APXvYqwCdlLuJ5iW9IHxxl01PuCrFJZRmBFwYI+9IRXKSHay1I3F461/+iIsYm81YJW14Q0nWxJefA==
X-Received: by 2002:a1c:ef09:: with SMTP id n9mr18185481wmh.104.1557816179945;
        Mon, 13 May 2019 23:42:59 -0700 (PDT)
Received: from [192.168.0.41] (229.78.129.77.rev.sfr.net. [77.129.78.229])
        by smtp.googlemail.com with ESMTPSA id v192sm2227083wme.24.2019.05.13.23.42.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 May 2019 23:42:59 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: NXP NFC version and ACPI
To:     sedat.dilek@gmail.com
Cc:     Samuel Ortiz <sameo@linux.intel.com>,
        linux-wireless@vger.kernel.org, linux-nfc@lists.01.org,
        robert.dolca@intel.com, oleg.zhurakivskyy@intel.com,
        clement.perrochaud@effinnov.com, charles.gorand@effinnov.com,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
References: <c2d0d19f-d814-8f41-4860-77b9cc7f9d26@linaro.org>
 <CA+icZUVz7sB6hv4fhL_rqhR_D8RePBJFXk1PaUy5tMw2z4xC_Q@mail.gmail.com>
Message-ID: <5ae87449-83a1-ecce-c72c-b4742c507497@linaro.org>
Date:   Tue, 14 May 2019 08:42:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CA+icZUVz7sB6hv4fhL_rqhR_D8RePBJFXk1PaUy5tMw2z4xC_Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 13/05/2019 22:15, Sedat Dilek wrote:
> On Wed, Dec 5, 2018 at 8:38 AM Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>>
>>
>> Hi,
>>
>> the discussion reference is on github [1].
>>
>> I acquired a Lenovo x280 with a NFC chip. It is unclear what chip is it
>> really, it is called NXP NPC300 which could be a PN7xxx chip range.
>>
>> A hacked version of an old deprecated out-of-tree module made the PN5xxx
>> to work with my laptop but I suspect it brought some subtle instability
>> on my system.
>>
>> Now it would be nice to have this correctly supported upstream.
>>
>> I dumped the ACPI DSDT table and got the id NXP1001. This one is not
>> listed in the match table of the nxp-nci driver.
>>
>>  - is the driver missing for the so called NXP NPC300 ?
>>  - should the NXP1001 matching string to be added to nxp-nci?
>>  - is my firmware sending me garbage ?
>>
>> Thanks in advance for any input
>>
> 
> [ CC Andy ]
> 
> Hi Daniel,
> 
> I was able to get a NXP NPC300 NFC device run on Lenovo ThinkPad T470.
> 
> Look at the patchset "[PATCH v2 00/12] NFC: nxp-nci: clean up and
> support new ID".
> I have tested on top of Linux v5.1.1.

Hi Sedat,

yes, I have them see. Thanks for letting me know.

> Here I have set...
> 
> scripts/config -m NFC_NCI -m NFC_NXP_NCI -m NFC_NXP_NCI_I2C -e
> PINCTRL_SUNRISEPOINT
> 
> Please give this a try and report.

My laptop is the first one I have with a NFC reader, so I'm not used to
test this as it was not working yet.

I booted the machine with a 5.1.1, the series applied on top, and the
config options set as mentioned above.

The nxp-nci kernel module is loaded and neard is installed.

I used the sniffing tool with the command libnfc -d nfc0 -n but when
passing my NFC devices on the laptop's NFC mark, nothing happens.

Is that correct?

-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

