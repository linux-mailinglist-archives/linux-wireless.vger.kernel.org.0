Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24F1D35EF62
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Apr 2021 10:24:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350043AbhDNIRa (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 14 Apr 2021 04:17:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51662 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1350031AbhDNIRa (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 14 Apr 2021 04:17:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618388229;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=t4mcakpl6D33+OTsO/RIezYbFLVYR/NnP+hj8syw1UQ=;
        b=igBRAKRrzAUrWPKxj4nJbHfDzjnFZ+M8p3CfDxXM0zeSKQRgqou4mo8S/qc38lqDgjG8U+
        WiLNA/Ng7Pa0G897fhFi8p4YLfqrmrr+BLAod0BNHFjvDs6POmWrBaqdEecZzKqDGEEc0G
        l2sokU+1GwpDtn9IG8zOCgkfjqV+ttM=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-147-Z-d7kQeHOxea08UkP11WTQ-1; Wed, 14 Apr 2021 04:17:06 -0400
X-MC-Unique: Z-d7kQeHOxea08UkP11WTQ-1
Received: by mail-ed1-f70.google.com with SMTP id m2-20020aa7c4820000b0290382b0bad9e7so2881948edq.9
        for <linux-wireless@vger.kernel.org>; Wed, 14 Apr 2021 01:17:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=t4mcakpl6D33+OTsO/RIezYbFLVYR/NnP+hj8syw1UQ=;
        b=l0wz2TLIb7AzoGfG8MdNBDdQ5E8vuwPiIo784lx3xxNeEez4zpmizzb8Z3FK6QzXeX
         eKnv9K1NOdKfZ8bpkH5bvJLeJYIQXFnWQ7nGeNsl2aocrt+iRM3sq87N6HdLjCVHAivM
         DMv5gpdins0y1u4FWQR/2xlYeAyiiVzmXwQINZzVrMolM5iwTxljdl9buDCBQvyttIbl
         5rV44T8DX7MQhgCBRad1p5xxcsj4oLocAYmaCjSPHKxxdsipZNFg0uZcKUATbCL4aAbx
         NpJKpYp3wIxq66imT0fl1lnSezZmZcYPmuYJ/aQBrtfxH9Q/eiuKtIkwXZbCNt39bWWq
         VYYw==
X-Gm-Message-State: AOAM533CtTqJ/LIGEYqHK2iO64bDrFEoVgrhhAhD7aqpJxaBtGn4cL5C
        84riY2HSNki3Y8Vk3ImWT4toewnes9uRzAlBMxcebEibpPxlU2iZvMghp8mLydeb2ZO03+GRWTW
        2J7Ew0+WIG1rmn+Q7UJvr9OO0n8DUZBA0mEUgsidvO3o7kY+Mh+48sntnua7RQpYoOHTdTfJ/d7
        1bQdI=
X-Received: by 2002:a17:906:3684:: with SMTP id a4mr34954463ejc.316.1618388225167;
        Wed, 14 Apr 2021 01:17:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwzRwKB6/U8JW5/FMXWWnS+9bBBn9hvhDMnfNjvaCqlalAGYg8sPswFdLJaZhFAURfGApcZGA==
X-Received: by 2002:a17:906:3684:: with SMTP id a4mr34954436ejc.316.1618388224809;
        Wed, 14 Apr 2021 01:17:04 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id dh27sm11055431edb.28.2021.04.14.01.17.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Apr 2021 01:17:04 -0700 (PDT)
Subject: Re: "rfkill: add a reason to the HW rfkill state" breaks userspace
To:     Johannes Berg <johannes@sipsolutions.net>,
        "Grumbach, Emmanuel" <emmanuel.grumbach@intel.com>,
        Benjamin Berg <bberg@redhat.com>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>
References: <efafa85c-c021-14ff-619c-fdd0db53ddbb@redhat.com>
 <SA0PR11MB4752FEE472EC18B6A4F376FAF24E9@SA0PR11MB4752.namprd11.prod.outlook.com>
 <2db76f5161be090f9fec2bc4fcb8973533e32564.camel@sipsolutions.net>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <e06b4ca8-6f1f-1c49-5454-b96af9fdd7df@redhat.com>
Date:   Wed, 14 Apr 2021 10:17:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <2db76f5161be090f9fec2bc4fcb8973533e32564.camel@sipsolutions.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

Adding Benjamin Berg who is one of the gnome-settings-daemon
maintainers to the Cc.

On 4/14/21 9:07 AM, Johannes Berg wrote:
> On Wed, 2021-04-14 at 05:12 +0000, Grumbach, Emmanuel wrote:
>>>
>>> Hi,
>>>
>>> I've been debugging a userspace rfkill issue today which boils down
>>> to the
>>> "rfkill: add a reason to the HW rfkill state" patch:
>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?i
>>> d=14486c82612a177cb910980c70ba900827ca0894
>>> breaking userspace.
>>
>> This has been rolled back by:
>> https://git.kernel.org/pub/scm/linux/kernel/git/jberg/mac80211.git/commit/?id=71826654ce40112f0651b6f4e94c422354f4adb6
>> Other userspace broke (systemd) so Johannes rolled this back by
>> default.

I see, but this change is not in:

kernel-headers-5.11.11-300.fc34.x86_64

Meaning that basically all of Fedora 34 has been built with the "bad"
headers.

>> Userspace that is interested in the new byte will read 9 bytes.
> 
> Which, unfortunately, doesn't address *this* particular case, because it
> uses gio and that will fill the buffer with arbitrary size?
> 
> When you (Hans) say you saw in strace a read of size 8, did you mean the
> size passed to it, or the return size? I guess it must be the return
> size, and the size passed to it was way larger.

No for some reason, for some later read calls gio was actually passing
8 as size to the read() syscall. And g-s-d was compiled with headers
where sizeof(struct rfkill_event) was 9. This is/was the issue, g-s-d
would do 2 read(fd, buf, 8) calls and then take the first 9 bytes read
out of the 16 bytes it got to fill a single rfkill_event which is fine,
except that it uses the remaining 7 bytes as the first 7 bytes of the
next rfkill_event which it processes making that next event be completely
bogus.

I do believe this really is a g-s-d bug though, it should not have
been using a "buffered" gio-channel on a /dev/foo node; and so far it
only got away with this by the rfkill_event size being a nice power of 2
value.

As I mentioned in an email to Benjamin, g-s-d should really switch
to making direct read() calls on the fd circumventing the gio-channel
read code all together:

"Right, notice I just realized that even after my fix there still is an issue,
when running code compiled against new kernel headers gsd-rfkill will now
always expect 9 bytes per event. But when running on an older kernel that
will not be true.

To fix this the code should probably just directly call read() itself
on the fd (only using g_io_channel for the polling) and then accept anything
between 8 bytes and sizeof(struct rfkill_event) as valid return value from the
read() call..."

Notice that the problem which I described there will go away when compiled
against even newer kernel-headers where sizeof(struct rfkill_event) is
back to 8 again.

So question, for code like g-s-d, which does not care about the new
hard_block_reasons field. What would be the preferred / max compatibility
way to do the reads. Also keeping in mind that there are "bad" kernel
headers out there where sizeof(struct rfkill_event) == 9 ?

I think that this would be best:

	ret = read(fd, &event, RFKILL_EVENT_SIZE_V1);
	if (ret == RFKILL_EVENT_SIZE_V1) {
		/* Valid event process it */
	}

This should produce the same code regardless of the kernel-headers version
and should work on both old and new kernels, correct ?

> The commit Emmanuel linked to fixes cases such as systemd that were just
> completely garbage (reading with one size, and then checking they got
> another), but it wouldn't fix this case.
> 
> Unfortunately, as you also said, it does seem a bit late now - it's been
> released in various kernels since 5.10, and while the default rollback
> will improve the situation somewhat, read(..., size>8) will still return
> 9 bytes rather than 8 as it used to. Switching that *also* back *should*
> be safe, but who knows what other bugs were introduced in the meantime?
> 
> I certainly don't really have a major objection to rolling that also
> back, but would it really help that much at this point? I guess it could
> be going into 5.10/5.11 stable kernels though.

I don't think that rolling back the new extended-event support altogether
will help. Since this has been out there for 2 released kernel versions
now, I believe the best way to fix this is to fix userspace; and to fix
userspace in such a way (at least g-s-d) that this problem cannot
happen again.

Regards,

Hans

