Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 123342A922F
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Nov 2020 10:13:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726506AbgKFJNC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 6 Nov 2020 04:13:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726447AbgKFJM7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 6 Nov 2020 04:12:59 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B527C0613CF
        for <linux-wireless@vger.kernel.org>; Fri,  6 Nov 2020 01:12:59 -0800 (PST)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1kaxnl-002BuI-6A; Fri, 06 Nov 2020 10:12:57 +0100
Message-ID: <02802f0fc1b3e4941ce137fcf6a637c32a756a4a.camel@sipsolutions.net>
Subject: Re: [PATCH] iw: add optional argument to parse 6G band channel
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Arend Van Spriel <arend.vanspriel@broadcom.com>,
        Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org
Date:   Fri, 06 Nov 2020 10:12:56 +0100
In-Reply-To: <4bbc1e91-ba41-7e05-cb53-baa74232388d@broadcom.com> (sfid-20201106_101217_822925_451FF8D7)
References: <1602283770-8026-1-git-send-email-pradeepc@codeaurora.org>
         <5c39eaec897af4d7b1005d1f7cb80552c3404e54.camel@sipsolutions.net>
         <e0ba2a4d-3f82-22f6-e928-1ac25eb1448b@broadcom.com>
         <f25189bb18fe0d4e9a70f5468eab74b209b83054.camel@sipsolutions.net>
         <4bbc1e91-ba41-7e05-cb53-baa74232388d@broadcom.com>
         (sfid-20201106_101217_822925_451FF8D7)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, 2020-11-06 at 10:12 +0100, Arend Van Spriel wrote:
> On 11/6/2020 10:06 AM, Johannes Berg wrote:
> > On Fri, 2020-11-06 at 10:05 +0100, Arend Van Spriel wrote:
> > > On 11/6/2020 9:55 AM, Johannes Berg wrote:
> > > > On Fri, 2020-10-09 at 15:49 -0700, Pradeep Kumar Chitrapu wrote:
> > > > > Channel numbers of 6G band overlaps with those of 2G or 5G bands.
> > > > > Therefore, an optional argument "6G" is added and expected next
> > > > > to channel number to map it to correct 6GHz frequency. If not
> > > > > specified, defaults to matching 2G or 5G frequency.
> > > > > 
> > > > > example:
> > > > > iw wlanX set channel 149 6G 80MHz  --> maps to 6695 MHz
> > > > > iw wlanX set channel 149 80MHz     --> maps to 5745 MHz
> > > > 
> > > > Hm. I can't really say I like this much.
> > > > 
> > > > Is it _really_ needed? I mean, we mostly specify the frequency today, so
> > > > ... why not just always do that for 6 GHz?
> > > 
> > > I suspect there are people preferring channel numbers as much as there
> > > are people preferring frequencies. Personally, I think it is acceptable
> > > to put this limitation on 6G.
> > 
> > :)
> > 
> > After I sent the message I figured maybe then we should have different
> > syntax, where we say prefix the channel number by the band?
> > 
> >   iw wlanX set channel 6:149 ...
> >   iw wlanX set channel 5:149 ...
> >   iw wlanX set channel 2.4:11 ...
> 
> Do you want to make that band: prefix required or optional.

That's a good question. Probably should be optional, otherwise
everything breaks ...

> btw. starts 
> to look like the format we use with our wl utility ;-)

Hah! Maybe you have a better idea there? :)

johannes

