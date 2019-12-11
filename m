Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4706611A5E1
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Dec 2019 09:32:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727829AbfLKIch (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 11 Dec 2019 03:32:37 -0500
Received: from s3.sipsolutions.net ([144.76.43.62]:46230 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726845AbfLKIch (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 11 Dec 2019 03:32:37 -0500
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92.3)
        (envelope-from <johannes@sipsolutions.net>)
        id 1iexQ2-003Uuv-G0; Wed, 11 Dec 2019 09:32:26 +0100
Message-ID: <4cf0c2a4a2d1cd92dff4f1a791d74523e446cf01.camel@sipsolutions.net>
Subject: Re: Correct radiotap header for 802.11ad
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Guy Harris <guy@alum.mit.edu>
Cc:     "radiotap@netbsd.org" <radiotap@netbsd.org>,
        Simon Barber <simon@superduper.net>,
        Richard Sharpe <realrichardsharpe@gmail.com>,
        linux-wireless@vger.kernel.org, Maya Erez <merez@codeaurora.org>,
        wil6210@qti.qualcomm.com
Date:   Wed, 11 Dec 2019 09:32:25 +0100
In-Reply-To: <C5FF46C6-BDEE-41D8-B7E1-1EFFE9411DE3@alum.mit.edu>
References: <CACyXjPzq-ePB1ux6wi_Rv3onPKXomcJcm15XJwA51u0E4W2txw@mail.gmail.com>
         <38F46E1D-1C4A-48DC-A906-9522006E8474@alum.mit.edu>
         <1606812C-649C-4C06-ABE0-AE2F4474BCD0@alum.mit.edu>
         <1440402013.3735.1.camel@sipsolutions.net>
         <CACyXjPwSZPV+U_=zQpDBpeBnhMntzEFhyJnBOw3-N8qPfyHc1A@mail.gmail.com>
         <55DE44EB.6080603@superduper.net>
         <126B842D-05EA-4510-BC9B-DB1A4AABEC12@alum.mit.edu>
         <1135A126-6A5A-4C84-A52D-13C0387609CC@alum.mit.edu>
         <1442507879.2821.9.camel@sipsolutions.net>
         <C5FF46C6-BDEE-41D8-B7E1-1EFFE9411DE3@alum.mit.edu>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.2 (3.34.2-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

++ for the DMG discussion

On Tue, 2019-12-10 at 15:51 -0800, Guy Harris wrote:
> On Sep 17, 2015, at 9:37 AM, Johannes Berg <johannes@sipsolutions.net> wrote:

Reviving an old thread :-)

> > Not being familiar with DMG, I can't really comment on this.
> > 
> > It does sound like we need *some* new field though, be it either a DMG
> > field or a PLCP SIGNAL field, or perhaps even both.
> > 
> > Going back to the original thread though, I think using the MCS field
> > is quite wrong.
> 
> But a presumably-Linux system does appear to use it; see Wireshark bug
> 
> 	https://bugs.wireshark.org/bugzilla/show_bug.cgi?id=16272
> 
> For now, I'll throw a hack into Wireshark to treat a signal >= 60 GHz
> as meaning 11ad, 

I don't think that's quite right - you'll need to do something like >=
56 GHz.

> but, again, should there be additional fields for 11ad?

I would think so.

On the one hand I think (and looking at the spec seems to confirm this)
that basically DMG uses an MCS index. Now, the MCS radiotap field was
designed for HT and has a lot of things that are not applicable (GI,
STBC, etc.)

OTOH, there are DMG-specific things that probably ought to be captured
by a proper sniffer, like the PPDU type, training length, etc. Also,
there's the thing with the "Extended SC MCS Indication field", which
really also ought to be captured.

Sadly, the only Linux implementation didn't bother adjusting any of this
even in the Linux general stack (and I didn't pay enough attention to it
at the beginning), so even the rate reporting to userspace is just the
MCS index. This might actually be sufficient for the current uses
(there's a conversion function to bandwidth too), though it doesn't seem
quite applicable to the whole spec.

For both the Linux userspace reporting and radiotap then, this
completely ignores the existence of the MCSes 9.1 and 12.1-12.6, which
cannot be captured in either format right now. Maybe the extended SC
MCSes are just not used by equipment in the field?


In any case, to capture DMG properly I'd say we need a new radiotap
field with at least
 * (base) MCS
 * Extended SC MCS bit
and it should probably optionally cover the other possible fields as
well
 * Scrambler Initialization
 * Length (?)
 * Additional PPDU bit
 * PPDU type bit
 * Training Length
 * Beam Tracking Request
 * Last RSSI
 * Turnaround

johannes

