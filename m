Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58BE135F107
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Apr 2021 11:48:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343683AbhDNJsX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 14 Apr 2021 05:48:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233066AbhDNJsW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 14 Apr 2021 05:48:22 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C836BC061574
        for <linux-wireless@vger.kernel.org>; Wed, 14 Apr 2021 02:48:00 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1lWc7m-00BZwX-3u; Wed, 14 Apr 2021 11:47:54 +0200
Message-ID: <e0d36b10d832d953c7cd838b6f7cd8558666dd64.camel@sipsolutions.net>
Subject: Re: "rfkill: add a reason to the HW rfkill state" breaks userspace
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Hans de Goede <hdegoede@redhat.com>,
        "Grumbach, Emmanuel" <emmanuel.grumbach@intel.com>,
        Benjamin Berg <bberg@redhat.com>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>
Date:   Wed, 14 Apr 2021 11:47:53 +0200
In-Reply-To: <e06b4ca8-6f1f-1c49-5454-b96af9fdd7df@redhat.com>
References: <efafa85c-c021-14ff-619c-fdd0db53ddbb@redhat.com>
         <SA0PR11MB4752FEE472EC18B6A4F376FAF24E9@SA0PR11MB4752.namprd11.prod.outlook.com>
         <2db76f5161be090f9fec2bc4fcb8973533e32564.camel@sipsolutions.net>
         <e06b4ca8-6f1f-1c49-5454-b96af9fdd7df@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Hans,

> Adding Benjamin Berg who is one of the gnome-settings-daemon
> maintainers to the Cc.

:)
As you might imagine, I've talked to him ;-)
> 
> kernel-headers-5.11.11-300.fc34.x86_64

Right, not yet.

> Meaning that basically all of Fedora 34 has been built with the "bad"
> headers.

Yay. But still, I think in this case it wouldn't help.

> > > Userspace that is interested in the new byte will read 9 bytes.
> > 
> > Which, unfortunately, doesn't address *this* particular case, because it
> > uses gio and that will fill the buffer with arbitrary size?
> > 
> > When you (Hans) say you saw in strace a read of size 8, did you mean the
> > size passed to it, or the return size? I guess it must be the return
> > size, and the size passed to it was way larger.
> 
> No for some reason, for some later read calls gio was actually passing
> 8 as size to the read() syscall. 
> 

Wait, that's weird? The (latest) gio code just calls
g_io_channel_fill_buffer() and that doesn't care about the size you
passed to g_io_channel_read_chars(), in fact it isn't even passed down,
as you might expect for stream reads?

> And g-s-d was compiled with headers
> where sizeof(struct rfkill_event) was 9. This is/was the issue, g-s-d
> would do 2 read(fd, buf, 8) calls and then take the first 9 bytes read
> out of the 16 bytes it got to fill a single rfkill_event which is fine,
> except that it uses the remaining 7 bytes as the first 7 bytes of the
> next rfkill_event which it processes making that next event be completely
> bogus.

I understand the issue. I just didn't expect it would get solved when
the headers contain a struct rkfill_event of size 8 again, since the
kernel would still return 9 bytes. In effect, you'd still get the same
issue, because the read in g_io_channel_fill_buffer() is 1024
(G_IO_NICE_BUF_SIZE).

> 
> I do believe this really is a g-s-d bug though, it should not have
> been using a "buffered" gio-channel on a /dev/foo node; and so far it
> only got away with this by the rfkill_event size being a nice power of 2
> value.

I agree, but ... kernel regressions and all that, right?

> As I mentioned in an email to Benjamin, g-s-d should really switch
> to making direct read() calls on the fd circumventing the gio-channel
> read code all together:
> 
> "Right, notice I just realized that even after my fix there still is an issue,
> when running code compiled against new kernel headers gsd-rfkill will now
> always expect 9 bytes per event. But when running on an older kernel that
> will not be true.
> 
> To fix this the code should probably just directly call read() itself
> on the fd (only using g_io_channel for the polling) and then accept anything
> between 8 bytes and sizeof(struct rfkill_event) as valid return value from the
> read() call..."

I don't think this is related to gio, you can still use
g_io_channel_read_chars() since that just does the read for you:

  if (!channel->use_buffer)
    {
      gsize tmp_bytes;

      g_assert (!channel->read_buf || channel->read_buf->len == 0);

      status = channel->funcs->io_read (channel, buf, count, &tmp_bytes, error);

      if (bytes_read)
        *bytes_read = tmp_bytes;

      return status;
    }


but checking that you actually got the *exact* size that you wanted is
indeed wrong (as well).

Sounds like I made the wrong call here - I was discussing this with
Benjamin a while ago and decided *not* to add an ioctl to opt in to the
new event type ... sounds like I should have.


Notice that the problem which I described there will go away when compiled
against even newer kernel-headers where sizeof(struct rfkill_event) is
back to 8 again.

Yes.

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


I believe so, yes.

I don't think that rolling back the new extended-event support altogether
will help. Since this has been out there for 2 released kernel versions
now, I believe the best way to fix this is to fix userspace; and to fix
userspace in such a way (at least g-s-d) that this problem cannot
happen again.

Fair enough.

Thanks,
johannes

