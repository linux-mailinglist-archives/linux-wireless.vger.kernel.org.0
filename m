Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0DFC516AFA0
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Feb 2020 19:47:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728068AbgBXSrd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 24 Feb 2020 13:47:33 -0500
Received: from s3.sipsolutions.net ([144.76.43.62]:42446 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727797AbgBXSrd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 24 Feb 2020 13:47:33 -0500
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1j6IlP-007P93-3k; Mon, 24 Feb 2020 19:47:31 +0100
Message-ID: <1a56c641eaa03c99dc9a90208902d8bb1ca1b0aa.camel@sipsolutions.net>
Subject: Re: [PATCH 1/2] Revert "mac80211: support
 NL80211_EXT_FEATURE_CONTROL_PORT_OVER_NL80211_MAC_ADDRS"
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Denis Kenzior <denkenz@gmail.com>, linux-wireless@vger.kernel.org
Cc:     Markus Theil <markus.theil@tu-ilmenau.de>
Date:   Mon, 24 Feb 2020 19:47:29 +0100
In-Reply-To: <6e723a78-db68-8ffb-986a-4a3961107f72@gmail.com> (sfid-20200224_194137_572776_5E2EB1D1)
References: <20200224101910.b87da63a3cd6.Ic94bc51a370c4aa7d19fbca9b96d90ab703257dc@changeid>
         <c9fba32a-6959-a93a-3119-23915053538c@gmail.com>
         <53190ece697ab7d9e83fdd667eaf9e05a4418193.camel@sipsolutions.net>
         <6e723a78-db68-8ffb-986a-4a3961107f72@gmail.com>
         (sfid-20200224_194137_572776_5E2EB1D1)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.2 (3.34.2-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, 2020-02-24 at 12:26 -0600, Denis Kenzior wrote:

> > These are two entirely different things, preauth is simply real data as
> > far as the local system is concerned. It's not related to controlled
> > port operation at all, which this nl80211 API is about.
> 
> I can understand this argument, but from what I remember, one of the 
> goals of the control port API was to make this legacy 'special data 
> packet' processing unnecessary for userspace.  In other words userspace 
> wouldn't need to establish raw sockets.  Hence my question, what is the 
> actual concern here?

That's a question of how you define "special data packet processing"...
You're defining it purely in terms of the mechanics of how you handle
them, but that's not really the point.

Preauth frames are _not_ special. They're entirely regular data packets
as far as wifi is concerned.

What _is_ special is EAPOL packets, because you may need to control
their encryption, know if they were ACKed, etc.

> > FWIW, you may have seen Markus's patch to remove preauth from the RX as
> > well, this won't work as is, but I'm still a bit on the fence as to
> > whether I'll force you into the right model or not (i.e. clear the
> > existing capability bit in mac80211, and introduce a new one that
> > doesn't report preauth over nl80211). For RX, however, the difference
> > isn't really that much of a big deal, so maybe just make it optional.
> 
> We're actually quite happy with the current model.  So I'd like to keep 
> things as they are.

I concede that on RX, there isn't actually really a _problem_, although
it's really strange to transport what really is just data frames (from a
wifi POV) over a control path ...

Depending on how much complexity it adds in the kernel (I've not tried
to fix that today) I guess we can keep this. I'd _prefer_ not to, but I
guess I cannot convince you that the preauth model is wrong, and -
mostly as a sign of how much you've worn me down - I'll probably just
keep it.

johannes

