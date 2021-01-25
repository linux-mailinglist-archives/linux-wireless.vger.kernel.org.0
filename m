Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BDBB3047E6
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Jan 2021 20:13:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388922AbhAZFyQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 26 Jan 2021 00:54:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:25655 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728960AbhAYNh2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 25 Jan 2021 08:37:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611581762;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ieo53MrhB0DlhB3f9/rLaNtbHFyYe3WXEfXl867bltM=;
        b=AQ79UbFb9shl3sjjbpV1eUmczeTtaKy6i1uBc1mroKBcuWmLq8/wEIPoWQg9fJ+h+QyoD9
        34np3W3D9a9j6+PubhS4i2TA3p5MVWh8f3ueekZN/V9vs/ItEHOX1/7SHAnb4k34Ui+BXH
        M5P0+CNs7jfcx2omkhWb7HmwrwSc568=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-32-CE1idn3eNoWT9Eli2vOB2A-1; Mon, 25 Jan 2021 06:18:44 -0500
X-MC-Unique: CE1idn3eNoWT9Eli2vOB2A-1
Received: by mail-ed1-f69.google.com with SMTP id k5so7167134edk.15
        for <linux-wireless@vger.kernel.org>; Mon, 25 Jan 2021 03:18:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Ieo53MrhB0DlhB3f9/rLaNtbHFyYe3WXEfXl867bltM=;
        b=tRYnVBE05oOLzRalr2MER0Dbydugaizl9nNub9hY9nurGi1P6nz+IJCuQuuXkdgqCM
         2nHrQFCI9mQknCUn90qnfv9PjVJHFKugL+B+zM94dNgXNWCnQkewLuApSHmm40MaK5s7
         o9pHWAmXvEzh0FdciP8t8rC7feAa8Ls9BALSPMUdm0c6jga8bftuTvVL0/WYYrFCR9LG
         bQI03ADn5qguVtYwOX149Kp0mWCSHpieNkdNU0VtPVD1Np3IugQiMvLAUzvAAUz/5iCV
         W7XKfnFEMVAvAuBkYaVkt/nJSQlve3fYo0/fI9A2/xArATBmBd1qOz7e5qAcppZLq//V
         /ZBA==
X-Gm-Message-State: AOAM531YwVnfCRXysTxKlcBcHoW12s2ESrrWiZ1+mCGj0SU/lNPe9nAW
        lkxsBjIhFLebA21Z82GF287r/v/xkSxHM7zyjuQBvYlESy/aQpwvLU8g8Gxr9DJCC11dF+HSGqb
        kK/otnBJOAvLngdOKOwaszt0m9io=
X-Received: by 2002:a50:b223:: with SMTP id o32mr5766edd.79.1611573523206;
        Mon, 25 Jan 2021 03:18:43 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx8HAVnk/PyijwPWMiW80/gD6wbKT49kWql+0z9pRRz87cGGKxWoTMm1/kZmFGpTjDq0CibAg==
X-Received: by 2002:a50:b223:: with SMTP id o32mr5755edd.79.1611573523028;
        Mon, 25 Jan 2021 03:18:43 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-37a3-353b-be90-1238.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:37a3:353b:be90:1238])
        by smtp.gmail.com with ESMTPSA id b26sm10471159eds.48.2021.01.25.03.18.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Jan 2021 03:18:42 -0800 (PST)
Subject: Re: pull-request: mac80211 2021-01-18.2
To:     Johannes Berg <johannes@sipsolutions.net>,
        "Peer, Ilan" <ilan.peer@intel.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "Coelho, Luciano" <luciano.coelho@intel.com>
References: <20210118204750.7243-1-johannes@sipsolutions.net>
 <77c606d4-a78a-1fa3-5937-b270c3d0bbd3@redhat.com>
 <b83f6cf001c4e3df97eeaed710b34fda0a08265f.camel@sipsolutions.net>
 <BN7PR11MB2610052E380E676ED5CCCC67E9BE9@BN7PR11MB2610.namprd11.prod.outlook.com>
 <348210d8-6940-ca8d-e3b1-f049330a2087@redhat.com>
 <666b3449fe33d34123255cc69da3aa46fc276dcb.camel@sipsolutions.net>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <6c949dbe-5593-2274-7099-c2768b770aad@redhat.com>
Date:   Mon, 25 Jan 2021 12:18:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <666b3449fe33d34123255cc69da3aa46fc276dcb.camel@sipsolutions.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

On 1/25/21 10:47 AM, Johannes Berg wrote:
> Hi,
> 
> Sorry, apparently we have two threads.
> 
>> Great, thank you for looking into this. Let me know if you have a patch
>> which you want me to test on a RTL8723BS adapter.
> 
> Could you test this instead?
> 
> https://p.sipsolutions.net/235c352b8ae5db88.txt
> 
> 
> I don't have that much sympathy for a staging driver that's clearly
> doing things differently than it was intended (the documentation states
> that the function should be called only before wiphy_register(), not
> during ndo_open). :-)

I completely understand and I already was worried that this might be
a staging-driver issue, which is why I mentioned this was with a
staging driver in the more detailed bug-report email.

> But OTOH, that fix to the driver is simple and looks correct to me since
> it only ever has a static regdomain, and the notifier does the work of
> applying it to the channels as well.

So I've given your fix a quick try and it leads to a NULL pointer deref.

But now that you've given me a lead on how to fix this (network/wifi
drivers are not really me expertise) I can take a shot at seeing if I
can fix the NULL pointer deref. I Hope to get back to you on that later
today.

Regards,

Hans

