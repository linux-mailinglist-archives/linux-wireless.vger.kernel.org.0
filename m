Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D601A340474
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Mar 2021 12:17:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230243AbhCRLRP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 18 Mar 2021 07:17:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231229AbhCRLQ7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 18 Mar 2021 07:16:59 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 443A5C06174A;
        Thu, 18 Mar 2021 04:16:59 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1lMqe7-0008Rq-9w; Thu, 18 Mar 2021 12:16:55 +0100
Message-ID: <9db9d9ae751a50c9fd1da1ee3bd4c564546ce1c5.camel@sipsolutions.net>
Subject: Re: systemd-rfkill regression on 5.11 and later kernels
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 18 Mar 2021 12:16:54 +0100
In-Reply-To: <s5hczvwiumf.wl-tiwai@suse.de>
References: <s5ha6r0kgt5.wl-tiwai@suse.de>
         <54859a03b8789a2800596067e06c8adb49a107f5.camel@sipsolutions.net>
         <s5ho8fgixl9.wl-tiwai@suse.de>
         <c196f9cb7ba2487fb5aceceedf860cc24c6843f2.camel@sipsolutions.net>
         <s5hczvwiumf.wl-tiwai@suse.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, 2021-03-18 at 12:11 +0100, Takashi Iwai wrote:
> > That said, we can "fix" this like this, and hope we'll not get this
> > again? And if we do get it again ... well, we keep renaming the structs
> > and add "struct rfkill_event_v3" next time?
> 
> Yeah, that's a dilemma.  An oft-seen trick is to add more bytes for
> the future use, e.g. extend to 16 bytes and fill 0 for the remaining.

Yeah, I guess I could stick a reserved[15] there, it's small enough.

> In the sound driver, we introduced an ioctl to inform from user-space
> which API protocol it can speak, and the kernel falls back to the old
> API/ABI if it's a lower version or it's not told at all.  But I'm not
> sure whether such an implementation is optimal for rfkill.

I thought about it, but it ... doesn't really help.

Somebody's going to do

	ioctl(..., sizeof(ev)) == sizeof(ev)

and break on older kernels, or == my_fixed_size, or ... something. It's
not really going to address the issue entirely.

And it's more complexity.

johannes

