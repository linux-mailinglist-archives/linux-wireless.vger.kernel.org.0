Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C36A335F217
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Apr 2021 13:18:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348850AbhDNLSA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 14 Apr 2021 07:18:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:20973 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229886AbhDNLR7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 14 Apr 2021 07:17:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618399058;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1ATAMsRpLHlB8fK2azocZ6Fl83mzfd2zov1aeD5yZ5w=;
        b=dEltqNwFdsPcScpTGISeMtzYsvhRuSzckI5GuWlxfEZJ14rQnvatMzC4u5ajpLIZt+kG6b
        NMwdon8sItgV46qbIQ8g+WfiTIsJ661JrKxF9d7D2DS15Lx03oaL4gKt/HO1uYhxPO8TBH
        A3X+8cP542CiME26Qak/S25BeoDyUj4=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-290-GRVxyLSHNi-2EYccqz0KjQ-1; Wed, 14 Apr 2021 07:17:36 -0400
X-MC-Unique: GRVxyLSHNi-2EYccqz0KjQ-1
Received: by mail-ed1-f69.google.com with SMTP id l2-20020a50e8c20000b02903825413b3e0so3122906edn.10
        for <linux-wireless@vger.kernel.org>; Wed, 14 Apr 2021 04:17:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1ATAMsRpLHlB8fK2azocZ6Fl83mzfd2zov1aeD5yZ5w=;
        b=pmDgSFHkwzVCXSZREjFxM7Qmro5fcfNIUUqHBzErEmnGAdEjEUOojnsb/7zPi7wn2n
         XA4VlcX6TnV2lWEMmClISc1pKU1TdtnKYw85JZch++KYZcxjPZvD5zDEkoSo0wAmaAZK
         lQvdyEVebgvt/z+mveaP/wEMk6wOZ3GbCCqsz9fP+LkvI1iRXntufA7BdKV+u9y+vavz
         A1aGPip9C28afn3iK/E/OVkiYPfVu+E/W8mvIvN3X5OAf9S3u9TuztjF0yjAgL+jfIvZ
         h6EtOfLhrGf3elc/74mCr4WmOAzUGpPhXHp82jFcH4ePqzZDPi+vPZgm1NRCh9z0ZaYi
         MXLA==
X-Gm-Message-State: AOAM5305iTOYmrIui58mqFZTTOI5ra/2C9dogbwG8YQTwptpb+8z1dmn
        v0j0BOuFhT3pEXjSZySeemfTuTmfY8bWPGN6TaUQBWeNEyJypCsL8Si0bL4CqX2YwTNaMfrh6VT
        XNsrC9D17EoFdClXCBoTuUdXQa9KYqKHm++NHOIB3NDIuR1hhegfC/j65JnaCyik62jKirhHqPT
        Akv50=
X-Received: by 2002:aa7:dcc7:: with SMTP id w7mr39734869edu.255.1618399055074;
        Wed, 14 Apr 2021 04:17:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwoTu9Z2o/0yu/KSv0ENGQe2jM4doWSVCRbI8X8i7fm4gZJr/efOXDcgsUe2V6BuHCP4Aih2Q==
X-Received: by 2002:aa7:dcc7:: with SMTP id w7mr39734856edu.255.1618399054947;
        Wed, 14 Apr 2021 04:17:34 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id dh27sm11415347edb.28.2021.04.14.04.17.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Apr 2021 04:17:34 -0700 (PDT)
Subject: Re: "rfkill: add a reason to the HW rfkill state" breaks userspace
To:     Benjamin Berg <bberg@redhat.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        "Grumbach, Emmanuel" <emmanuel.grumbach@intel.com>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>
References: <efafa85c-c021-14ff-619c-fdd0db53ddbb@redhat.com>
 <SA0PR11MB4752FEE472EC18B6A4F376FAF24E9@SA0PR11MB4752.namprd11.prod.outlook.com>
 <2db76f5161be090f9fec2bc4fcb8973533e32564.camel@sipsolutions.net>
 <e06b4ca8-6f1f-1c49-5454-b96af9fdd7df@redhat.com>
 <bb6eece123644f32e861456f9aa1056a9db78066.camel@redhat.com>
 <b3273466-7978-241f-9773-56cd87490a9b@redhat.com>
 <e9e7425cf7bbbf20f0dac74e222d28f747216804.camel@redhat.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <5064e714-1e1e-237a-b2e4-00123f95e8bf@redhat.com>
Date:   Wed, 14 Apr 2021 13:17:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <e9e7425cf7bbbf20f0dac74e222d28f747216804.camel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

On 4/14/21 12:46 PM, Benjamin Berg wrote:
> Hi,
> 
> On Wed, 2021-04-14 at 12:29 +0200, Hans de Goede wrote:
>> On 4/14/21 11:52 AM, Benjamin Berg wrote:
>>> [SNIP]
>>>
>>> That said, the g-s-d event handler is checking the size of the read
>>> against the struct size. This is obviously wrong, it should only
>>> check
>>> that the read was successful (or check for >= V1 size).
>>
>> Right this is what I was referring to a g-s-d compiled against the
>> new headers with a struct size of 9 will read 8 bytes on an old
>> kernel
>> and that will fail the len check, so it won't work.
>>
>> But this will actually never happen as I just noticed that g-s-d
>> uses a private rfkill.h copy with the old 8 bytes struct definition.
>>
>> So with the buffered-io disabled everything should work fine,
>> see my other email in this thread.
> 
> OK, so at least that part of the fix should be backported to older
> release branches.

Ack, that fix should be backported to fix issues with newer
kernels and then everything should work fine.

Regards,

Hans

