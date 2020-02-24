Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 132B716B054
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Feb 2020 20:34:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727187AbgBXTeX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 24 Feb 2020 14:34:23 -0500
Received: from s3.sipsolutions.net ([144.76.43.62]:43246 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725860AbgBXTeW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 24 Feb 2020 14:34:22 -0500
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1j6JUj-007V0w-BH; Mon, 24 Feb 2020 20:34:21 +0100
Message-ID: <366b1599374240ef194bf7eb6e1e47a8b675f474.camel@sipsolutions.net>
Subject: Re: [PATCH 1/2] Revert "mac80211: support
 NL80211_EXT_FEATURE_CONTROL_PORT_OVER_NL80211_MAC_ADDRS"
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Denis Kenzior <denkenz@gmail.com>, linux-wireless@vger.kernel.org
Cc:     Markus Theil <markus.theil@tu-ilmenau.de>
Date:   Mon, 24 Feb 2020 20:34:19 +0100
In-Reply-To: <048b81db-8e92-7fe0-1f5c-3b6f9ea1a1f1@gmail.com> (sfid-20200224_201247_630416_7C0C1E38)
References: <20200224101910.b87da63a3cd6.Ic94bc51a370c4aa7d19fbca9b96d90ab703257dc@changeid>
         <c9fba32a-6959-a93a-3119-23915053538c@gmail.com>
         <53190ece697ab7d9e83fdd667eaf9e05a4418193.camel@sipsolutions.net>
         <6e723a78-db68-8ffb-986a-4a3961107f72@gmail.com>
         <1a56c641eaa03c99dc9a90208902d8bb1ca1b0aa.camel@sipsolutions.net>
         <048b81db-8e92-7fe0-1f5c-3b6f9ea1a1f1@gmail.com>
         (sfid-20200224_201247_630416_7C0C1E38)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.2 (3.34.2-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, 2020-02-24 at 12:57 -0600, Denis Kenzior wrote:
> 
> Why isn't it the point?  These are the only data packets userspace 
> management daemon(s) actually care about and has to setup raw sockets + 
> bpf filters for every interface it manages.  The current control port 
> makes all of that unnecessary.

Sure.

> So from a holistic point of view, taking kernel + userspace into 
> account, what is wrong with letting control port transport preauth 
> frames if that saves a bunch of resources (and possibly wakeups if the 
> bpf is setup badly) on the system?

If you paint it that way, it doesn't seem like there's anything wrong
with it, does it?

But not sure that's the right color - you could apply that precise same
argument to, say, transporting DHCP packets over the same path? I think
you'd agree that doesn't make it right?

Just because preauth is a wifi related protocol doesn't mean we should
treat it in a wifi control path.

> Also, the question is what changed your mind?  I asked you specifically 
> if preauth should be included in the control port API and you thought it 
> was a good idea at the time?

I don't really remember that, but perhaps? Mostly I guess the discussion
on the hostap list now, I suppose.

johannes

