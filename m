Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 985BF35F16F
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Apr 2021 12:23:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233662AbhDNKW5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 14 Apr 2021 06:22:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22618 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233666AbhDNKWz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 14 Apr 2021 06:22:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618395753;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=w5BdzvPEYBRoBRtO1dn2+YZdxSesVz0KjPMENOCoyew=;
        b=DvMlprxFa/JWwHvefV2j/+NvVra/Wog2MPWG4az7MsU801BhgVIbLDnNI7g4CM0vqPyl0k
        cKR9pm4T1Mi0Na/VZhKrSOeYJMNtevwQMPnw6wKTDTCfmVLYQUvp15QHrtXxEE/2lntkP1
        q+Hbf/k8cPxI703S1Dr8RTix7TnuPNI=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-533-APRKqz4DM1qm8n32vGnzvQ-1; Wed, 14 Apr 2021 06:22:31 -0400
X-MC-Unique: APRKqz4DM1qm8n32vGnzvQ-1
Received: by mail-ed1-f72.google.com with SMTP id r15-20020a50aacf0000b0290381d5d3eb2fso3068160edc.7
        for <linux-wireless@vger.kernel.org>; Wed, 14 Apr 2021 03:22:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=w5BdzvPEYBRoBRtO1dn2+YZdxSesVz0KjPMENOCoyew=;
        b=WVKvIxMkN/XCqXTqiF4LMDlPxkx1z6SvdlUrPx7cs5/+i9ul743ehZHhn5YDFfu4s9
         5rC9UZOdfY4MAyMEi8bBqB2L6SYmuUa/o7v3Yl/Snvhnz2MmasXRPquONX08Wv/SqFBc
         N9sIwtIMzYJXKwlVnaM04g7vv3TsFfP8ReNTG/yF0ka5mRbJ/z3VObCLdDQZ8JZ0dSOF
         2iSSuwnS4ry9oYKd45aukh8zkuGsqgKm36u71lzwQlWalkdwRPpNCuoujYUBwL8zUUs8
         taFWFkKhhkHvFFs9TquX6sBdxVNo2Di9bfsMokBcawV8RDu7WEPsOpI7h0TizE5Z6SiQ
         YEeA==
X-Gm-Message-State: AOAM5332XINhuEPxPQ9hiPJJhcqzcqLzvB3grn2BIO06I1RJG77IiPZ9
        FE/JYr9lsqXH9hkNmEh7TGAvr6b8PHcge8FpXzR47Be7X/F8q1L153dxOpfdIY8Ulox5ic3MmMQ
        Ze1/AOK0b2ZYDGMs2XFcPpc7IJx41uUaIMdjRLeGzgUOhngkoVx2oX04Kb3Fo7Zvub4uDyn3ojK
        UkzZE=
X-Received: by 2002:a05:6402:128a:: with SMTP id w10mr39780008edv.277.1618395750389;
        Wed, 14 Apr 2021 03:22:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzYf+X2frNwAndKe/HU+5RdMRBVjcIAN9agmNHhJs2Bn7F7TiBTUN311vajKCfH+d07dxDX/g==
X-Received: by 2002:a05:6402:128a:: with SMTP id w10mr39779981edv.277.1618395750102;
        Wed, 14 Apr 2021 03:22:30 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id z17sm1436332edx.36.2021.04.14.03.22.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Apr 2021 03:22:29 -0700 (PDT)
Subject: Re: "rfkill: add a reason to the HW rfkill state" breaks userspace
To:     Johannes Berg <johannes@sipsolutions.net>,
        "Grumbach, Emmanuel" <emmanuel.grumbach@intel.com>,
        Benjamin Berg <bberg@redhat.com>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>
References: <efafa85c-c021-14ff-619c-fdd0db53ddbb@redhat.com>
 <SA0PR11MB4752FEE472EC18B6A4F376FAF24E9@SA0PR11MB4752.namprd11.prod.outlook.com>
 <2db76f5161be090f9fec2bc4fcb8973533e32564.camel@sipsolutions.net>
 <e06b4ca8-6f1f-1c49-5454-b96af9fdd7df@redhat.com>
 <e0d36b10d832d953c7cd838b6f7cd8558666dd64.camel@sipsolutions.net>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <1195435f-990c-7b0a-125f-03acca74cdee@redhat.com>
Date:   Wed, 14 Apr 2021 12:22:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <e0d36b10d832d953c7cd838b6f7cd8558666dd64.camel@sipsolutions.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

On 4/14/21 11:47 AM, Johannes Berg wrote:
> Hi Hans,
> 
>> Adding Benjamin Berg who is one of the gnome-settings-daemon
>> maintainers to the Cc.
> 
> :)
> As you might imagine, I've talked to him ;-)
>>
>> kernel-headers-5.11.11-300.fc34.x86_64
> 
> Right, not yet.
> 
>> Meaning that basically all of Fedora 34 has been built with the "bad"
>> headers.
> 
> Yay. But still, I think in this case it wouldn't help.
> 
>>>> Userspace that is interested in the new byte will read 9 bytes.
>>>
>>> Which, unfortunately, doesn't address *this* particular case, because it
>>> uses gio and that will fill the buffer with arbitrary size?
>>>
>>> When you (Hans) say you saw in strace a read of size 8, did you mean the
>>> size passed to it, or the return size? I guess it must be the return
>>> size, and the size passed to it was way larger.
>>
>> No for some reason, for some later read calls gio was actually passing
>> 8 as size to the read() syscall. 
>>
> 
> Wait, that's weird? The (latest) gio code just calls
> g_io_channel_fill_buffer() and that doesn't care about the size you
> passed to g_io_channel_read_chars(), in fact it isn't even passed down,
> as you might expect for stream reads?

Ok, so I took another look at the strace and you are right.

There are 2 things happening here:

1. g-s-d has a private rfkill.h userspace-api copy with the old 8 byte
   rfkill_event definition, which I missed.

2. g-s-d mixes read() and g_io_channel_read_chars() usage, using
   read() to get the initial state and then later on using
   g_io_channel_read_chars() on events. The initial state read()s
   are the read(fd, buf, 8) calls which I saw in the strace.

So g-s-d was using / assuming a 8 byte struct size all the time and
my off-by-one by using buffered io theory was right, but works
differently then I expected. As you (Johannes) said, the problem is
g-s-d making read(fd, buf, 1024) calls, reading 9 bytes per event
and then returning 8 to the g_io_channel_read_chars() saving the
left over byte and pre-pending it to the next event, ruining
the next event(s).

Actually the code for getting the initial state seems to do the same
sizeof / RFKILL_EVENT_SIZE_V1 mix/match as systemd is doing
(probably copy and pasted from one to the other), but it is "saved"
somewhat by having its own rfkill.h copy:

                len = read(fd, &event, sizeof(event));
                if (len < 0) {
                        if (errno == EAGAIN)
                                break;
                        g_debug ("Reading of RFKILL events failed");
                        break;
                }

                if (len != RFKILL_EVENT_SIZE_V1) {
                        g_warning ("Wrong size of RFKILL event\n");
                        continue;
                }

And then later on, when poll says there is new data:

                status = g_io_channel_read_chars (source,
                                                  (char *) &event,
                                                  sizeof(event),
                                                  &read,
                                                  NULL);

                while (status == G_IO_STATUS_NORMAL && read == sizeof(event)) {

So with my fix to turn off buffering all should be well now, but we
(g-s-d folks) should consider doing a follow-up patch to

plugins/rfkill/rfkill-glib.c

Replacing all the sizeof(event) occurences with RFKILL_EVENT_SIZE_V1 for
future proofing against rfkill.h changes (e.g. if someone syncs
the private copy with the kernel) although this should be safe with
the recent kernel-header change...

Benjamin, what is your take on doing a  s/sizeof(event)/RFKILL_EVENT_SIZE_V1/ ?

At a minimum that would be good to do because it fixes this weirdness:

                len = read(fd, &event, sizeof(event));
                if (len < 0) {
                        if (errno == EAGAIN)
                                break;
                        g_debug ("Reading of RFKILL events failed");
                        break;
                }

                if (len != RFKILL_EVENT_SIZE_V1) {
                        g_warning ("Wrong size of RFKILL event\n");
                        continue;
                }

Where the len param passed to read() and the one checked for are
not necessarily the same.

Regards,

Hans







> 
>> And g-s-d was compiled with headers
>> where sizeof(struct rfkill_event) was 9. This is/was the issue, g-s-d
>> would do 2 read(fd, buf, 8) calls and then take the first 9 bytes read
>> out of the 16 bytes it got to fill a single rfkill_event which is fine,
>> except that it uses the remaining 7 bytes as the first 7 bytes of the
>> next rfkill_event which it processes making that next event be completely
>> bogus.
> 
> I understand the issue. I just didn't expect it would get solved when
> the headers contain a struct rkfill_event of size 8 again, since the
> kernel would still return 9 bytes. In effect, you'd still get the same
> issue, because the read in g_io_channel_fill_buffer() is 1024
> (G_IO_NICE_BUF_SIZE).
> 
>>
>> I do believe this really is a g-s-d bug though, it should not have
>> been using a "buffered" gio-channel on a /dev/foo node; and so far it
>> only got away with this by the rfkill_event size being a nice power of 2
>> value.
> 
> I agree, but ... kernel regressions and all that, right?
> 
>> As I mentioned in an email to Benjamin, g-s-d should really switch
>> to making direct read() calls on the fd circumventing the gio-channel
>> read code all together:
>>
>> "Right, notice I just realized that even after my fix there still is an issue,
>> when running code compiled against new kernel headers gsd-rfkill will now
>> always expect 9 bytes per event. But when running on an older kernel that
>> will not be true.
>>
>> To fix this the code should probably just directly call read() itself
>> on the fd (only using g_io_channel for the polling) and then accept anything
>> between 8 bytes and sizeof(struct rfkill_event) as valid return value from the
>> read() call..."
> 
> I don't think this is related to gio, you can still use
> g_io_channel_read_chars() since that just does the read for you:
> 
>   if (!channel->use_buffer)
>     {
>       gsize tmp_bytes;
> 
>       g_assert (!channel->read_buf || channel->read_buf->len == 0);
> 
>       status = channel->funcs->io_read (channel, buf, count, &tmp_bytes, error);
> 
>       if (bytes_read)
>         *bytes_read = tmp_bytes;
> 
>       return status;
>     }
> 
> 
> but checking that you actually got the *exact* size that you wanted is
> indeed wrong (as well).
> 
> Sounds like I made the wrong call here - I was discussing this with
> Benjamin a while ago and decided *not* to add an ioctl to opt in to the
> new event type ... sounds like I should have.
> 
> 
> Notice that the problem which I described there will go away when compiled
> against even newer kernel-headers where sizeof(struct rfkill_event) is
> back to 8 again.
> 
> Yes.
> 
> So question, for code like g-s-d, which does not care about the new
> hard_block_reasons field. What would be the preferred / max compatibility
> way to do the reads. Also keeping in mind that there are "bad" kernel
> headers out there where sizeof(struct rfkill_event) == 9 ?
> 
> I think that this would be best:
> 
> 	ret = read(fd, &event, RFKILL_EVENT_SIZE_V1);
> 	if (ret == RFKILL_EVENT_SIZE_V1) {
> 		/* Valid event process it */
> 	}
> 
> This should produce the same code regardless of the kernel-headers version
> and should work on both old and new kernels, correct ?
> 
> 
> I believe so, yes.
> 
> I don't think that rolling back the new extended-event support altogether
> will help. Since this has been out there for 2 released kernel versions
> now, I believe the best way to fix this is to fix userspace; and to fix
> userspace in such a way (at least g-s-d) that this problem cannot
> happen again.
> 
> Fair enough.
> 
> Thanks,
> johannes
> 

