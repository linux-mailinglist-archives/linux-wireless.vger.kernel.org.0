Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D2BB35F181
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Apr 2021 12:29:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233697AbhDNK33 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 14 Apr 2021 06:29:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:37452 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232235AbhDNK31 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 14 Apr 2021 06:29:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618396146;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jSeI3oS3k1WJKNY2BdpEGkSdIsQRojykRnTnJc2ddmM=;
        b=haYr2pBYfZc8bheBqPC/65IoKKIe6/rhPiSR3Rw1SwU0cQsuWtuhYBW+hG8A480VwAv2ep
        85LGwK9bcIndHVaG9mH9QH/z+VqM/K5Wv3m2sXdKq8im9K+fU30Mc2pMlmClElwms8JxeW
        m74P6hyxuEDhEBp828UTBs/RSwPqYu0=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-303-GVEqRmDNO-qD3FQtxcoxoA-1; Wed, 14 Apr 2021 06:29:03 -0400
X-MC-Unique: GVEqRmDNO-qD3FQtxcoxoA-1
Received: by mail-ej1-f72.google.com with SMTP id di5so295410ejc.1
        for <linux-wireless@vger.kernel.org>; Wed, 14 Apr 2021 03:29:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jSeI3oS3k1WJKNY2BdpEGkSdIsQRojykRnTnJc2ddmM=;
        b=HyGXxNdEDsOJBLhg5Vto5nE4dHF1mLvGHHYFdx8HGk6MxKQ67bxoTdMsPWirq5Z9tV
         74dbBAbuRiqfG9l7IKd60rQ3JLejfZVYld1P3vGiGhvvRXIK892yDwt+aqK0rhLeSkC1
         3OBFHb5OX//CrZ6vZ2vMzlK5QrDj1diJLgYozmp4wqTGK2iyyCd2KBukoorG8DPgzE+R
         U1nLBXuKks16txRphCUM4ierMw861dkS7Vq/PJhltp+NfhDF8OoAAX3I7OakJExSOIqY
         DvaVi0A+3Xr5u3GKzdc4fH6T3Eim6dWMVHRJCwcp4bFwvOUBJzGshydAEieZDzFCZU/D
         P6ug==
X-Gm-Message-State: AOAM532Ei4OxsddQm3/soONS32AWs4+DxB7isIGUtngT6cbng67SW/b7
        ioDvWiJiiMTidDbC2+eF3dJxPtuwU7YU72ng7BeoZkILz6/1uDe2fn4lh4aIQ6xB1dRmRMVjWJz
        yT97e2HRGvcwjl59E7P1SlP+0MmhY8OdFmrolQCmSoc8sXbgUAVnWFseyGidtT9hrhZ29ldx5Oq
        35cR4=
X-Received: by 2002:a17:906:b104:: with SMTP id u4mr36522463ejy.211.1618396141606;
        Wed, 14 Apr 2021 03:29:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxEmeoHpo3ff2axwImdIYyTe7AqOuEv/23cC+rdwSgbvYwj3pcBeKK5DEskQXb00o1KVhJZSA==
X-Received: by 2002:a17:906:b104:: with SMTP id u4mr36522442ejy.211.1618396141351;
        Wed, 14 Apr 2021 03:29:01 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id e12sm11513331edv.11.2021.04.14.03.29.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Apr 2021 03:29:01 -0700 (PDT)
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
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <b3273466-7978-241f-9773-56cd87490a9b@redhat.com>
Date:   Wed, 14 Apr 2021 12:29:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <bb6eece123644f32e861456f9aa1056a9db78066.camel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

On 4/14/21 11:52 AM, Benjamin Berg wrote:
> Hi,
> 
> On Wed, 2021-04-14 at 10:17 +0200, Hans de Goede wrote:
>> Hi,
>>
>> Adding Benjamin Berg who is one of the gnome-settings-daemon
>> maintainers to the Cc.
>>
>> On 4/14/21 9:07 AM, Johannes Berg wrote:
>>> On Wed, 2021-04-14 at 05:12 +0000, Grumbach, Emmanuel wrote:
>>>>>
>>>>> Hi,
>>>>>
>>>>> I've been debugging a userspace rfkill issue today which boils
>>>>> down
>>>>> to the
>>>>> "rfkill: add a reason to the HW rfkill state" patch:
>>>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?i
>>>>> d=14486c82612a177cb910980c70ba900827ca0894
>>>>> breaking userspace.
>>>>
>>>> This has been rolled back by:
>>>> https://git.kernel.org/pub/scm/linux/kernel/git/jberg/mac80211.git/commit/?id=71826654ce40112f0651b6f4e94c422354f4adb6
>>>> Other userspace broke (systemd) so Johannes rolled this back by
>>>> default.
>>
>> I see, but this change is not in:
>>
>> kernel-headers-5.11.11-300.fc34.x86_64
>>
>> Meaning that basically all of Fedora 34 has been built with the "bad"
>> headers.
>>
>>>> Userspace that is interested in the new byte will read 9 bytes.
>>>
>>> Which, unfortunately, doesn't address *this* particular case, because
>>> it
>>> uses gio and that will fill the buffer with arbitrary size?
>>>
>>> When you (Hans) say you saw in strace a read of size 8, did you mean
>>> the
>>> size passed to it, or the return size? I guess it must be the return
>>> size, and the size passed to it was way larger.
>>
>> No for some reason, for some later read calls gio was actually passing
>> 8 as size to the read() syscall. And g-s-d was compiled with headers
>> where sizeof(struct rfkill_event) was 9. This is/was the issue, g-s-d
>> would do 2 read(fd, buf, 8) calls and then take the first 9 bytes read
>> out of the 16 bytes it got to fill a single rfkill_event which is fine,
>> except that it uses the remaining 7 bytes as the first 7 bytes of the
>> next rfkill_event which it processes making that next event be
>> completely bogus.
>>
>> I do believe this really is a g-s-d bug though, it should not have
>> been using a "buffered" gio-channel on a /dev/foo node; and so far it
>> only got away with this by the rfkill_event size being a nice power of
>> 2 value.
>>
>> As I mentioned in an email to Benjamin, g-s-d should really switch
>> to making direct read() calls on the fd circumventing the gio-channel
>> read code all together:
>>
>> "Right, notice I just realized that even after my fix there still is an
>> issue, when running code compiled against new kernel headers gsd-rfkill
>> will now always expect 9 bytes per event. But when running on an older
>> kernel that will not be true.
> 
> This confuses me. i.e. if g-s-d is compiled against headers where the
> struct is 9 bytes long, then we should just be getting a short read of
> 8 bytes. And that should be the same, whether we use plain read() or
> g_io_channel_read_chars().
> 
> I was under the impression that with
>   https://gitlab.gnome.org/GNOME/gnome-settings-daemon/-/merge_requests/232
> merged, the read should be fine on the GNOME side.
> 
> That said, the g-s-d event handler is checking the size of the read
> against the struct size. This is obviously wrong, it should only check
> that the read was successful (or check for >= V1 size).

Right this is what I was referring to a g-s-d compiled against the
new headers with a struct size of 9 will read 8 bytes on an old kernel
and that will fail the len check, so it won't work.

But this will actually never happen as I just noticed that g-s-d
uses a private rfkill.h copy with the old 8 bytes struct definition.

So with the buffered-io disabled everything should work fine,
see my other email in this thread.

We should probably still fix / clean the code a bit though, as
you are working on in:
https://gitlab.gnome.org/GNOME/gnome-settings-daemon/-/merge_requests/234

Regards,

Hans




> 
> Benjamin
> 
>> To fix this the code should probably just directly call read() itself
>> on the fd (only using g_io_channel for the polling) and then accept
>> anything
>> between 8 bytes and sizeof(struct rfkill_event) as valid return value
>> from the
>> read() call..."
>>
>> Notice that the problem which I described there will go away when
>> compiled
>> against even newer kernel-headers where sizeof(struct rfkill_event) is
>> back to 8 again.
>>
>> So question, for code like g-s-d, which does not care about the new
>> hard_block_reasons field. What would be the preferred / max
>> compatibility
>> way to do the reads. Also keeping in mind that there are "bad" kernel
>> headers out there where sizeof(struct rfkill_event) == 9 ?
>>
>> I think that this would be best:
>>
>>         ret = read(fd, &event, RFKILL_EVENT_SIZE_V1);
>>         if (ret == RFKILL_EVENT_SIZE_V1) {
>>                 /* Valid event process it */
>>         }
>>
>> This should produce the same code regardless of the kernel-headers
>> version
>> and should work on both old and new kernels, correct ?
>>
>>> The commit Emmanuel linked to fixes cases such as systemd that were
>>> just
>>> completely garbage (reading with one size, and then checking they got
>>> another), but it wouldn't fix this case.
>>>
>>> Unfortunately, as you also said, it does seem a bit late now - it's
>>> been
>>> released in various kernels since 5.10, and while the default
>>> rollback
>>> will improve the situation somewhat, read(..., size>8) will still
>>> return
>>> 9 bytes rather than 8 as it used to. Switching that *also* back
>>> *should*
>>> be safe, but who knows what other bugs were introduced in the
>>> meantime?
>>>
>>> I certainly don't really have a major objection to rolling that also
>>> back, but would it really help that much at this point? I guess it
>>> could
>>> be going into 5.10/5.11 stable kernels though.
>>
>> I don't think that rolling back the new extended-event support
>> altogether
>> will help. Since this has been out there for 2 released kernel versions
>> now, I believe the best way to fix this is to fix userspace; and to fix
>> userspace in such a way (at least g-s-d) that this problem cannot
>> happen again.
>>
>> Regards,
>>
>> Hans
>>
> 

