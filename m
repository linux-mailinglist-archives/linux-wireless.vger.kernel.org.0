Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6CF4C19FD92
	for <lists+linux-wireless@lfdr.de>; Mon,  6 Apr 2020 20:52:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726310AbgDFSwt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 6 Apr 2020 14:52:49 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:36766 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725928AbgDFSwt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 6 Apr 2020 14:52:49 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1jLWrW-00AbyI-19; Mon, 06 Apr 2020 20:52:46 +0200
Message-ID: <962a24ee0e07aeb0937490368413f33bbfd502d9.camel@sipsolutions.net>
Subject: Re: [PATCH] rtw88: add more check for wowlan pattern
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Brian Norris <briannorris@chromium.org>,
        Tony Chuang <yhchuang@realtek.com>
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        timlee@realtek.com
Date:   Mon, 06 Apr 2020 20:52:44 +0200
In-Reply-To: <CA+ASDXM3ZBB53LWWdZQj+adi0LZ4bN5=R1yRju4HV9K+3NLMOQ@mail.gmail.com> (sfid-20200406_203233_188368_CC497BE9)
References: <20200406074705.25022-1-yhchuang@realtek.com>
         <CA+ASDXM3ZBB53LWWdZQj+adi0LZ4bN5=R1yRju4HV9K+3NLMOQ@mail.gmail.com>
         (sfid-20200406_203233_188368_CC497BE9)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


> > +       /* Each pattern is divided into different kinds by DA address
> > +        *  a. DA is broadcast address
> > +        *  b. DA is multicast address
> > +        *  c. DA is unicast address same as dev's mac address
> > +        *  d. DA is unmasked. Also called wildcard type.
> > +        *  e. Others is invalid type.
> > +        */
> 
> So I take it that (e) is "looks like unicast, but the user didn't
> provide the whole DA, or the DA isn't ours"? It feels to me like
> that's still something actionable, in some cases. Cases:
> (1) partial mask, matching
> (2) partial mask, non-matching
> (3) full mask, non-matching
> I'm not totally sure about (2) and (3), but that feels to me like
> something we don't really expect to accept anyway -- should this be
> rejected in the higher-level API?
> For (1), it seems like it would probably be reasonable to still
> interpret this as unicast? I know that might not strictly follow what
> the user asked, but it feels pretty close -- and I also don't believe
> that it's wise to mostly-silently (yes, you added kernel logging; but
> this still doesn't get fed back to the user-space caller) drop the
> wake-pattern request.
> 
> Alternatively, if you're going to strictly reject stuff like this,
> then maybe you need to add a cfg80211 driver validity callback, so you
> can reject patterns up front. I think Johannes suggested this was a
> possibility before.

Yeah, I don't see why not.

Really the API wasn't built in mind with something this "smart" in mind,
it was kinda for a dumb "oh hey here's a frame, we converted it to
ethernet format, and then we match on it".

I'm not really sure why you'd even _want_ to do anything beyond that,
but if that's the firmware you're stuck with, well, what can we do?

johannes

