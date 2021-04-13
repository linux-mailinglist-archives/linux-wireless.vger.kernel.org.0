Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91B0F35E79B
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Apr 2021 22:31:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230209AbhDMUbe (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 13 Apr 2021 16:31:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:31757 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229589AbhDMUbd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 13 Apr 2021 16:31:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618345872;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=wdSnhmRpBp/yc7lmQIEv18dixZ4BRwZjOm1rh9PuvKk=;
        b=VBWJ3m3acwpzCmWrgTH21gTtDaLdZ3lN4CjgdcF+UtAbs3NPm8cKj2aShaAxul2ri5VuL/
        /XMCEHV8Jr6995NIaqgy3ADjAJzJnqid0WhHvl5TSqK4j4F0nj/2jMCRpy8dKtZsOCUNps
        PrJC7kUBgwdXq+cmT7dTC2B+FrWO8Bk=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-320-XNiiHlS6PYa2I94Y54Toaw-1; Tue, 13 Apr 2021 16:31:10 -0400
X-MC-Unique: XNiiHlS6PYa2I94Y54Toaw-1
Received: by mail-ed1-f72.google.com with SMTP id a1-20020aa7d7410000b0290378239baa9fso1895153eds.14
        for <linux-wireless@vger.kernel.org>; Tue, 13 Apr 2021 13:31:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:cc:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=wdSnhmRpBp/yc7lmQIEv18dixZ4BRwZjOm1rh9PuvKk=;
        b=F2jNpl61vnh8XoCimV8KAedeN6tjJvjHhymx5TfKX4T6nEZ4emwhccoP6Y0aISzLLD
         ijy8drq2x4I11ejOO8O/d1EoOF3su+2Z/8ghaRqgd6qXHNgkr7tvFgMobgIwJu2TQcsC
         k3KMGThzBG7kOmkwE6YvA41ytiI3UWRSEh5yOG4A8lWmfGNTzfYim8iUcnqqm93qxK6a
         zEuw4nVItB5iOd8EoQPdLSkAFde1cmPI7965/6coEIPnButAgHkTqEDpgc3+/ChI+2XJ
         21qovEeqfnuK23NW3u02SrOhUyiZM+bcSTs+/sEN9pkPIxAowHY2z++Y+dL2W1x7Imwj
         2kSQ==
X-Gm-Message-State: AOAM531P+FqzD/xVtkv4En3S2N9NTQXKimoSOlG9NZx8VPw3fMgzlsct
        7nR5vHsIYl3tO1cnR6jZHl2COmt6bainA1FjBi9V9WfogdhAazRVwWlgZE0j+3dkwUFr65g6jAc
        bk226uKqpzyBVTHPm6sMpzLMM6bj6a7ETxMlJ7oAGCx91TgrBjI4MCrspbaEiN3ZDxKr8/qRKVZ
        opI6I=
X-Received: by 2002:a17:906:dbd5:: with SMTP id yc21mr15690638ejb.29.1618345869090;
        Tue, 13 Apr 2021 13:31:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzq4A7VqeRx/Kmgau+laUFhrn0P1G1uQOXAbKe2g3J/QFIzW4hTJgFEU2dS+WW6Xc/MUttQxg==
X-Received: by 2002:a17:906:dbd5:: with SMTP id yc21mr15690613ejb.29.1618345868774;
        Tue, 13 Apr 2021 13:31:08 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id g11sm10216801edt.35.2021.04.13.13.31.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Apr 2021 13:31:08 -0700 (PDT)
To:     Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Johannes Berg <johannes.berg@intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>
Subject: "rfkill: add a reason to the HW rfkill state" breaks userspace
Message-ID: <efafa85c-c021-14ff-619c-fdd0db53ddbb@redhat.com>
Date:   Tue, 13 Apr 2021 22:31:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

I've been debugging a userspace rfkill issue today which boils down
to the "rfkill: add a reason to the HW rfkill state" patch:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=14486c82612a177cb910980c70ba900827ca0894
breaking userspace.

It is too late to fix this now since we likely also have new
userspace depending on the new API, but I still thought I
should report this.

I've submitted a fix for the problematic userspace bits here:
https://gitlab.gnome.org/GNOME/gnome-settings-daemon/-/merge_requests/232

Let me quote the commit msg which explains the problem:

"""
Access to a /dev/foo device should never use buffered mode.

While debugging a gsd-rfkill issue I noticed in the g_debug output
that the rfkill-glib.c code now seems to be receiving bogus events.
Doing a strace I noticed some read(dev_rfkill_fd, buf, 8) calls,
even though we call:
g_io_channel_read_chars(..., sizeof(struct rfkill_event, ...)
Which requests 9 bytes.

The problem is the kernel expects us to read 1 event per read() system-call
and it will throw away excess data. The idea is here that the rfkill_event
struct can be extended by adding new fields at the end and then userspace
code compiled against older kernel headers will still work since it
will only read the fields it knows in a single call and the
extra fields are thrown away.

Since the rfkill-glib.c code was using buffered-io and asking
g_io_channel_read_chars for 9 bytes when compiled against recent
kernel headers, what would happen is that 2 events would be consumed
in 2 read(fd, buf, 8) syscalls and then the first byte of the
second event read would be appended to the previous event and
the remaining 7 bytes would be used as the first 7 bytes for the
next event (and eventually completed with the first 2 bytes of
the next event, etc.). Leading to completely bogus events.

Enabling unbuffered mode fixes this.

(before the kernel change the rfkill_event struct was 8 bytes large
which allowed us to get away with using buffered io here.)
"""

Note this is new userspace on a new kernel actually being broken.

I believe that the new userspace (expecting 9 bytes) on old kernel
will also be broken, since a naive userspace implementation will do:

	if (read(fd, buf, sizeof(struct rfkill_event)) != sizeof(struct rfkill_event))
		/* Do error */

Which means that after a recompile on a new kernel it will expect 9
bytes from a read call an if it gets only 8 then it will consider
that an error (or worse it could try to do a second read to make-up
for the missing byte). Note that gnome-settings-daemon still has
the new-userspace on old-kernel issue even after my fix...

I believe that all that we can do now is fix userspace where necessary :|
but this is something to keep in mind for future fixes.

Regards,

Hans

