Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FDEC2C7295
	for <lists+linux-wireless@lfdr.de>; Sat, 28 Nov 2020 23:09:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389909AbgK1VuL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 28 Nov 2020 16:50:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387776AbgK1VM5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 28 Nov 2020 16:12:57 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0036EC0613D1
        for <linux-wireless@vger.kernel.org>; Sat, 28 Nov 2020 13:12:16 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id y22so1418474edv.1
        for <linux-wireless@vger.kernel.org>; Sat, 28 Nov 2020 13:12:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=CAfyngzaFlrMbZLSK3bS+FmvuIvTUaIUWo4EFziQgVk=;
        b=nmH+qorlm68MHAWWLye3dMLew59g/E34/rAVzpIgnkAx+6+1mbBJX3E4wA07XmjOZN
         c2H2on8Fmk0iB13UgrhIsGy5Vpqaxt2JmCVSPA9n3Xc/nkEIUZYglYjIGlS4W4eUiGQS
         hq1zgGEYDvKBucUUQIp4TcQfFawpY5S6KuLszCbRhGKOUZ9dHRHoqdhXtbIsWGLCDGRA
         HI+it7tbYNMKAXuMGYNruqBkz3RTwAwamDH5KXD1Yp4JyQlZNxYtD0u90nnyk8owLL3v
         YT26opBLoyV8768yCaw8lKkLDs5XI6eoUpjTcbaLWcgE4yn8bjYzBJ0v09d5WJHFp/uY
         z0KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=CAfyngzaFlrMbZLSK3bS+FmvuIvTUaIUWo4EFziQgVk=;
        b=Gls3QjVo1FMFGmU+K2IB7YpL8vCowlHBFWUxesxK/h1sI05upSuvME5ioP5vSEOo8K
         7d2hUbpx4ANcbKQT8GXy6w3RxbpQn2hKprr25C3PFH5l5VBlQ1XaMFQtsdkm3d6sP46q
         HmXZ73emHXC40W+qwv2mkwBUiE2hZGVGo/ZkVgaMNRlZtNE6/E/sbQWjbTMv4lHf9StF
         d5ei5XmBTVXDksrvtM+1MpKDn2uZDpzLu5eHWrDu+2iQ7hLxKS/Dwm/dKsybKswdLu3r
         ArsGvPLw0t/AG+gKrnLhhuVyR6LJbFoVmP/vY/vgrza1l7NTeZ35PDDrmXUMXsJTlYZr
         FaSg==
X-Gm-Message-State: AOAM533TH2dBnrhn2avYtCBwYSqUO63u2ZZJbH8VWJqfGxdkNo4Da1mV
        QPNi6lJt9fUiJlCXf22/JmqvVoYcemuxZw==
X-Google-Smtp-Source: ABdhPJwTF96NxK3G1mpC7Iyt310ziCDHlCy2Lyxye3ofIeKMYstgU9BKJU1UfzmGkFq12GNtob3SmA==
X-Received: by 2002:a05:6402:312c:: with SMTP id dd12mr7231091edb.327.1606597935405;
        Sat, 28 Nov 2020 13:12:15 -0800 (PST)
Received: from ?IPv6:2003:ea:8f23:2800:3447:4395:d25a:ba4a? (p200300ea8f23280034474395d25aba4a.dip0.t-ipconnect.de. [2003:ea:8f23:2800:3447:4395:d25a:ba4a])
        by smtp.googlemail.com with ESMTPSA id i21sm7035845edt.92.2020.11.28.13.12.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 Nov 2020 13:12:14 -0800 (PST)
Subject: Re: AX210 version 0024 not detected by iwlwifi
From:   Heiner Kallweit <hkallweit1@gmail.com>
To:     "Coelho, Luciano" <luciano.coelho@intel.com>,
        linuxwifi <linuxwifi@intel.com>,
        "Berg, Johannes" <johannes.berg@intel.com>,
        "Grumbach, Emmanuel" <emmanuel.grumbach@intel.com>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
References: <03e8284e-4ea8-fe3e-8da7-62a778b1a059@gmail.com>
 <ce7fab1d400a04eb31727546b99af0292a0d30f4.camel@intel.com>
 <9b5d4919-1c62-7438-3f50-18197a92a9cf@gmail.com>
Message-ID: <07e8663a-cafe-a2b7-0628-9c3643768d50@gmail.com>
Date:   Sat, 28 Nov 2020 22:12:10 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <9b5d4919-1c62-7438-3f50-18197a92a9cf@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Am 27.11.2020 um 12:55 schrieb Heiner Kallweit:
> Am 23.11.2020 um 09:17 schrieb Coelho, Luciano:
>> Hi Heiner,
>>
>> On Sun, 2020-11-22 at 22:35 +0100, Heiner Kallweit wrote:
>>> I have an AX210 card that isn't detected by iwlwifi.
>>>
>>> 01:00.0 Network controller: Intel Corporation Device 2725 (rev 1a)
>>>         Subsystem: Intel Corporation Device 0024
>>>
>>> Adding following entry seems to be sufficient.
>>>
>>>         {IWL_PCI_DEVICE(0x2725, 0x0020, iwlax210_2ax_cfg_ty_gf_a0)},
>>> +       {IWL_PCI_DEVICE(0x2725, 0x0024, iwlax210_2ax_cfg_ty_gf_a0)},
>>>         {IWL_PCI_DEVICE(0x2725, 0x0310, iwlax210_2ax_cfg_ty_gf_a0)},
>>>
>>> [  419.473140] iwlwifi 0000:01:00.0: enabling device (0000 -> 0002)
>>> [  419.486984] iwlwifi 0000:01:00.0: api flags index 2 larger than supported by driver
>>> [  419.487190] iwlwifi 0000:01:00.0: TLV_FW_FSEQ_VERSION: FSEQ Version: 93.8.63.28
>>> [  419.488828] iwlwifi 0000:01:00.0: loaded firmware version 59.601f3a66.0 ty-a0-gf-a0-59.ucode op_mode iwlmvm
>>> [  419.533136] iwlwifi 0000:01:00.0: Detected Intel(R) Wi-Fi 6 AX210 160MHz, REV=0x420
>>>
>>> Maybe there are more AX210 subversion id's to be added ..
>>>
>>> How about the api flags index warning? I saw it in several posts,
>>> is there something to be fixed in the driver?
>>
>> Good catch.  This indeed seems to be missing.  I'll add it and try to
>> send it still for the 5.10-rc series, so it propagates asap.
>>
>> --
>> Cheers,
>> Luca.
>>
> 
> I face another issue I hope you can help me with:
> Frequently on system reboot the PCI device vanishes, it's not listed
> by lspci any longer. This doesn't happen after a power-cycle.
> Not sure whether device is in D3cold or whether it doesn't react
> for another reason.
> 
Setting kernel parameter reboot=pci fixes the issue.
However I have no clue whom to blame for the issue: card or BIOS

> Rgds, Heiner
> 

