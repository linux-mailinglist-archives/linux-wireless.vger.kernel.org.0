Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DED54340230
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Mar 2021 10:37:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbhCRJgc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 18 Mar 2021 05:36:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbhCRJgX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 18 Mar 2021 05:36:23 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 449F4C06174A;
        Thu, 18 Mar 2021 02:36:23 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1lMp4m-0006Ym-56; Thu, 18 Mar 2021 10:36:20 +0100
Message-ID: <54859a03b8789a2800596067e06c8adb49a107f5.camel@sipsolutions.net>
Subject: Re: systemd-rfkill regression on 5.11 and later kernels
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Takashi Iwai <tiwai@suse.de>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 18 Mar 2021 10:36:19 +0100
In-Reply-To: <s5ha6r0kgt5.wl-tiwai@suse.de> (sfid-20210318_092815_512625_74D8A8A5)
References: <s5ha6r0kgt5.wl-tiwai@suse.de>
         (sfid-20210318_092815_512625_74D8A8A5)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Takashi,

Oh yay :-(

> we've received a bug report about rfkill change that was introduced in
> 5.11.  While the systemd-rfkill expects the same size of both read and
> write, the kernel rfkill write cuts off to the old 8 bytes while read
> gives 9 bytes, hence it leads the error:
>   https://github.com/systemd/systemd/issues/18677
>   https://bugzilla.opensuse.org/show_bug.cgi?id=1183147

> As far as I understand from the log in the commit 14486c82612a, this
> sounds like the intended behavior.

Not really? I don't even understand why we get this behaviour.

The code is this:

rfkill_fop_write():

...
        /* we don't need the 'hard' variable but accept it */
        if (count < RFKILL_EVENT_SIZE_V1 - 1)
                return -EINVAL;

# this is actually 7 - RFKILL_EVENT_SIZE_V1 is 8
# (and obviously we get past this if and don't get -EINVAL

        /*
         * Copy as much data as we can accept into our 'ev' buffer,
         * but tell userspace how much we've copied so it can determine
         * our API version even in a write() call, if it cares.
         */
        count = min(count, sizeof(ev));

# sizeof(ev) should be 9 since 'ev' is the new struct

        if (copy_from_user(&ev, buf, count))
                return -EFAULT;

...
	ret = 0;
...
	return ret ?: count;




Ah, no, I see. The bug says:

	EDIT: above is with kernel-core-5.10.16-200.fc33.x86_64.

So you've recompiled systemd with 5.11 headers, but are running against
5.10 now, where the short write really was intentional - it lets you
detect that the new fields weren't handled by the kernel. If 


The other issue is basically this (pre-fix) systemd code:

l = read(c.rfkill_fd, &event, sizeof(event));
...
if (l != RFKILL_EVENT_SIZE_V1) /* log/return error */



So ... honestly, I don't have all that much sympathy, when the uapi
header explicitly says we want to be able to change the size. But I
guess "no regressions" rules are hard, so ... dunno. I guess we can add
a version/size ioctl and keep using 8 bytes unless you send that?

johannes

