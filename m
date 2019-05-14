Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0DFC91C389
	for <lists+linux-wireless@lfdr.de>; Tue, 14 May 2019 08:58:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726525AbfENG6A (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 14 May 2019 02:58:00 -0400
Received: from mail-wm1-f54.google.com ([209.85.128.54]:51778 "EHLO
        mail-wm1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726148AbfENG57 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 14 May 2019 02:57:59 -0400
Received: by mail-wm1-f54.google.com with SMTP id o189so1568542wmb.1
        for <linux-wireless@vger.kernel.org>; Mon, 13 May 2019 23:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=I0rBrXLg5VRcd0C8hroYvLC3dED5HBq3ulgFWJfT7NM=;
        b=Dfg9NpyRo9vu9s7Zdf9JK26sw3flcmt5i/OrYSz/H9MOS5quJdGSa4b+/7ptWv1KAE
         8xOQ4Qmc+7IpD9hFy45jtKR8pTY9SayZ5qN7puz0es4KpivdsYPpL8GAL+EIW3D33wDq
         zWt+yqDD0GNNWlBlV3IeNhEfOoYEq6IcnNUNj5Ellmj4QZd2fcYCLqlx+wrYax7v9z31
         TDNdK5QmOYEMgtJaMkFa1ToqQ3A7YLq/dal975L+B0LSm2xp4LrLErN6zJkWrPr6LXC0
         EBFeu6kXxhQBeAKAT4uPyGdd296jSF/+OTYaybOSczQ5k1/kgCF1JG5fqOuq5PvmUOXK
         LdIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=I0rBrXLg5VRcd0C8hroYvLC3dED5HBq3ulgFWJfT7NM=;
        b=M46KtBLHfVohR0ADxyMz7/cWwrIUeZ3iBx2lL+NNUd3u1SuwUmBh7WebpgP+Ix6nsW
         i9/nA6zqHI/7g1luTJdRh/KCA5g7ts9KUvS8sf6/aj5BPl0KilIdOh+oAAvOteX+SeSZ
         ELkAs+2aAEiFru9T4qcHul6kXVJcwv8/JPA//+tp/wgvXYu+d+A5YaE2poKIig8XnYuA
         yBnK64HpP76sCXnZXiuL3tnMTzz59Uhx55+X3XHRmwOf+A+7S9cJOTvCLJIw2d5W/Rkc
         9zWPHSn7S76+bUz1LEOWjamIVfejr1kZz5dUeUDfQ2L0Pj+tZG6OSq2+sBBdwJvPi6tQ
         krUQ==
X-Gm-Message-State: APjAAAXxXZfbeh0aqrljzMYLTlpz3EH7cQSSgrCKC4nkijMjpruoETu7
        1dIVMuPlpE1qfXx871RkbMQNeg==
X-Google-Smtp-Source: APXvYqxxGzNACTGLieUiUb0+plIRdIlRJVeIm2nbCILHxOl6bXyAdLvsze24o58FAW52dYCnsY3yVQ==
X-Received: by 2002:a1c:6783:: with SMTP id b125mr18759584wmc.41.1557817077715;
        Mon, 13 May 2019 23:57:57 -0700 (PDT)
Received: from [192.168.0.41] (229.78.129.77.rev.sfr.net. [77.129.78.229])
        by smtp.googlemail.com with ESMTPSA id d3sm2363713wmf.46.2019.05.13.23.57.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 May 2019 23:57:57 -0700 (PDT)
Subject: Re: NXP NFC version and ACPI
To:     sedat.dilek@gmail.com
Cc:     Samuel Ortiz <sameo@linux.intel.com>,
        linux-wireless@vger.kernel.org, linux-nfc@lists.01.org,
        robert.dolca@intel.com, oleg.zhurakivskyy@intel.com,
        clement.perrochaud@effinnov.com, charles.gorand@effinnov.com,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
References: <c2d0d19f-d814-8f41-4860-77b9cc7f9d26@linaro.org>
 <CA+icZUVz7sB6hv4fhL_rqhR_D8RePBJFXk1PaUy5tMw2z4xC_Q@mail.gmail.com>
 <5ae87449-83a1-ecce-c72c-b4742c507497@linaro.org>
 <CA+icZUWLBjTtcFS0Fo8M5gSb90GbEUpetUgwr3fy=NxGAVqCyw@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <ecfdf017-59b0-dcb8-f684-1e4ba3d82a28@linaro.org>
Date:   Tue, 14 May 2019 08:57:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CA+icZUWLBjTtcFS0Fo8M5gSb90GbEUpetUgwr3fy=NxGAVqCyw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 14/05/2019 08:52, Sedat Dilek wrote:

[ ... ]

>>> Please give this a try and report.
>>
>> My laptop is the first one I have with a NFC reader, so I'm not used to
>> test this as it was not working yet.
>>
>> I booted the machine with a 5.1.1, the series applied on top, and the
>> config options set as mentioned above.
>>
>> The nxp-nci kernel module is loaded and neard is installed.
>>
>> I used the sniffing tool with the command libnfc -d nfc0 -n but when
>> passing my NFC devices on the laptop's NFC mark, nothing happens.
>>
>> Is that correct?
>>
> 
> Hi Daniel,
> 
> I am new to the topic Linux NFC.
> 
> I have installed neard (daemon) v0.16 and neard-tools from Debian/buster AMD64.
> 
> root@iniza:~# systemctl is-active neard.service
> active

Same for me

> root@iniza:~# nfctool --list
> nfc0:
>           Tags: [ ]
>           Devices: [ ]
>           Protocols: [ Felica MIFARE Jewel ISO-DEP NFC-DEP ]
>           Powered: No
>           RF Mode: None
>           lto: 150
>           rw: 15
>           miux: 2047

I have:

nfc0:
          Tags: [ ]
          Devices: [ ]
          Protocols: [ Felica MIFARE Jewel ISO-DEP NFC-DEP ]
          Powered: Yes
          RF Mode: None
          lto: 150
          rw: 15
          miux: 2047

The powered field is different.

> root@iniza:~# nfctool --poll -d nfc0

> Start polling on nfc0 as initiator
> 

I have:

Protocol error


And the dmesg show me the errors related to nci:

[  343.056021] nci: nci_ntf_packet: unknown ntf opcode 0x0
...
[31611.394308] nci: nci_start_poll: failed to set local general bytes




-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

