Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 803DE35E380
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Apr 2021 18:09:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346887AbhDMQJc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 13 Apr 2021 12:09:32 -0400
Received: from mail-ed1-f41.google.com ([209.85.208.41]:34355 "EHLO
        mail-ed1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346856AbhDMQJV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 13 Apr 2021 12:09:21 -0400
Received: by mail-ed1-f41.google.com with SMTP id ba6so20050906edb.1
        for <linux-wireless@vger.kernel.org>; Tue, 13 Apr 2021 09:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=UKSESlM+e60K9Wg7URXWmk4jqdAToab/jHgnga6DUbg=;
        b=ZE1axSseju6idrZ603MV4m6m6A9BFbEgCu0wg6tJj2Dgw72v7uiAbm7cLzathHuRLO
         xAEPtWQTnCDPFqai9OHrg00+kBCZhRjacPtuXtVeMQTKg6LnXA9hflqDTQBm6R/yj8Jj
         witpidQ2UaxDugqjo215Ufi+CTmUz5vPvcg1kTvWw035cDx5RQonKC3GOW80cBaSOFzs
         8J6Y7SLn8lBDCL89WfsU4KI5NIT4wXI/Jqic2U1S48m2u1ijZaXT3whrAkBdCLymbgwQ
         soQIG+H/libMo/WhCZVd9lrtjwqLcW/cSSUO9NLjfYP8+DDkINts2lmbAiShmNRh4dAh
         8YNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=UKSESlM+e60K9Wg7URXWmk4jqdAToab/jHgnga6DUbg=;
        b=A6d0epfxTnCY1bTUR+VUN6ezCy26W/ghmaNaSkWBa1g0hu/JrLWUmhASlZ4fKKjoTo
         vNswyO60QkVZhzIyXIV5Wn4aA/a1om5aRm03DKW5g0jDRR9782eRyVdamTjbEViEeg1p
         i5nGRY1LVh4pod7oa5Hd2XgNx5gqKneFOPBMTza+7fYzQtIE4bc9SM++hF3pZ5BinwOG
         Le87X7aAAf/U7yGlFhHNOWIzZwx9XmRbbvpWe/wkrJq8gfiIOrgxZ1FiHCj5Tg51G6Wr
         KewU1ohHjfWkfBO3fX80jW9HKYdS4qKOqEA+gZtwRbfbFTnDUcSQq5qJ6VmizebZgQ0F
         8BVQ==
X-Gm-Message-State: AOAM5306JER7KUIY2A4eRtp488GbDgXrAsiCDRz0S8qaXrTpPyorKpyW
        ghtMdLINfV2ZM0257TKLzi7zbXEOe80hdA==
X-Google-Smtp-Source: ABdhPJz6T7zy6Xx3f5TOXQZLi0oZj7tvV0iAJUZb2ujZz3KBbfREOW/I3IgYwbyEt0hMwndOSF5DgQ==
X-Received: by 2002:a50:d0d8:: with SMTP id g24mr22667942edf.290.1618330080207;
        Tue, 13 Apr 2021 09:08:00 -0700 (PDT)
Received: from [10.0.0.2] (94-210-190-100.cable.dynamic.v4.ziggo.nl. [94.210.190.100])
        by smtp.gmail.com with ESMTPSA id y26sm4578841ejj.98.2021.04.13.09.07.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Apr 2021 09:07:59 -0700 (PDT)
Subject: Re: iwlwifi: failed to load firmware chunk
From:   Friso Smit <fw.smit01@gmail.com>
To:     Chris Murphy <lists@colorremedies.com>
Cc:     linux-wireless@vger.kernel.org
References: <40bb3a55-a872-414d-ed7f-6548beecd236@gmail.com>
 <CAJCQCtTxroboAeQgByCG0zfNK=Rda=2cOGW4i2_kqxu2Saqqsg@mail.gmail.com>
 <b606a193-3e4d-cdd7-a2e4-c5b801e2f8fc@gmail.com>
Message-ID: <aef9af7e-9a5b-4eb4-e130-e5ee11d76891@gmail.com>
Date:   Tue, 13 Apr 2021 18:05:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <b606a193-3e4d-cdd7-a2e4-c5b801e2f8fc@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Okay, this is weird. Right now it's still messed up in Windows, but not 
anymore in Linux (even though it started while running linux). Dmesg 
currently doesn't show any errors for iwlwifi. Does anyone have an idea 
what part of the wifi chip could be broken here (driver, firmware, etc.)?

On 4/11/21 10:56 PM, Friso Smit wrote:
> On 4/11/21 10:11 PM, Chris Murphy wrote:
>> On Sun, Apr 11, 2021 at 2:24 AM Friso Smit <fw.smit01@gmail.com> wrote:
>>> Hi,
>>>
>>> After upgrading to linux 5.11.12.arch1-1 I suddenly had no wifi
>>> connection. I immediately tried downgrading again, but to no avail.
>> Did only kernel version change? 5.11.12 has one iwlwifi related commit:
>>
>> commit 6159f947fb047fd8ecbfbcbcc86a8337e801bd10
>>      iwlwifi: pcie: don't disable interrupts for reg_lock
>>
> It's not the only thing that changed, but this one stood out to me as 
> the possible cause. Some other things to note are that I sometimes 
> have to force shutdown my laptop, because of a long time issue in 
> nouveau. I don't know if this can cause these kinds of issues. And I 
> want to stress as well that the issue persisted even on another 
> operating system, so something must have been thoroughly messed up 
> somehow.
>
> Here's a full list of (Arch) packages that were upgraded:
>
> expat (2.2.10-2 -> 2.3.0-1)
> glib2 (2.68.0-5 -> 2.68.1-1)
> libcups (1:2.3.3op2-1 -> 1:2.3.3op2-2)
> cups (1:2.3.3op2-1 -> 1:2.3.3op2-2)
> dleyna-core (0.6.0+2+g1c6853f-2 -> 0.7.0-1)
> dleyna-connector-dbus (0.3.0-3 -> 0.4.0-1)
> libdrm (2.4.104-1 -> 2.4.105-1)
> mesa (21.0.1-1 -> 21.0.2-1)
> dleyna-renderer (0.6.0-4 -> 0.7.0-1)
> dleyna-server (0.6.0+2+geb895ae-2 -> 0.7.0-1)
> gdk-pixbuf2 (2.42.4-1 -> 2.42.6-1)
> geoclue (2.5.7-2 -> 2.5.7-3)
> glib2-docs (2.68.0-5 -> 2.68.1-1)
> gtk-update-icon-cache (1:4.2.0-2 -> 1:4.2.0-3)
> gtk3 (1:3.24.28-1 -> 1:3.24.28-2)
> lib32-expat (2.2.10-1 -> 2.3.0-2)
> lib32-glib2 (2.68.0-5 -> 2.68.1-1)
> lib32-gdk-pixbuf2 (2.42.4-1 -> 2.42.6-1)
> lib32-libva-mesa-driver (21.0.1-2 -> 21.0.2-1)
> lib32-mesa (21.0.1-2 -> 21.0.2-1)
> lib32-vulkan-intel (21.0.1-2 -> 21.0.2-1)
> libmwaw (0.3.17-1 -> 0.3.18-1)
> libva-mesa-driver (21.0.1-1 -> 21.0.2-1)
> linux (5.11.11.arch1-1 -> 5.11.12.arch1-1)
> linux-headers (5.11.11.arch1-1 -> 5.11.12.arch1-1)
> lua (5.4.2-1 -> 5.4.3-1)
> mesa-vdpau (21.0.1-1 -> 21.0.2-1)
> meson (0.57.1-1 -> 0.57.2-1)
> npm (7.8.0-1 -> 7.9.0-1)
> opera-ffmpeg-codecs (88.0.4324.192-1 -> 89.0.4389.90-1)
> proj (6.3.2-1 -> 8.0.0-1)
> qt5-base (5.15.2+kde+r171-2 -> 5.15.2+kde+r171-3)
> wlroots (0.12.0-1 -> 0.13.0-1)
> sway (1:1.5.1-2 -> 1:1.6-1)
> vulkan-headers (1:1.2.173-1 -> 1:1.2.174-1)
> vulkan-intel (21.0.1-1 -> 21.0.2-1)
> wine (6.5-2 -> 6.6-1)
> wine-mono (6.0.0-1 -> 6.1.1-1)
>
