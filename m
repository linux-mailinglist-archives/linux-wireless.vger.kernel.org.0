Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 32CDF11763F
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Dec 2019 20:49:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726538AbfLITtt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 9 Dec 2019 14:49:49 -0500
Received: from s3.sipsolutions.net ([144.76.43.62]:37268 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726673AbfLITts (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 9 Dec 2019 14:49:48 -0500
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92.3)
        (envelope-from <johannes@sipsolutions.net>)
        id 1ieP2N-00GSvl-LA; Mon, 09 Dec 2019 20:49:43 +0100
Message-ID: <a6bde585ee108c57f8201f6d73249ac8f9b8b368.camel@sipsolutions.net>
Subject: Re: debugging TXQs being empty
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Ben Greear <greearb@candelatech.com>, Kan Yan <kyan@google.com>
Cc:     Toke =?ISO-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>,
        linux-wireless <linux-wireless@vger.kernel.org>
Date:   Mon, 09 Dec 2019 20:49:42 +0100
In-Reply-To: <ed9ae122-7573-a15e-7c42-7ae1fe3d123d@candelatech.com>
References: <bbc516f28782175b27ac5e19dcdeac13cd6ee76a.camel@sipsolutions.net>
         <fd23a26dea59128ede8c1c4d02fb2f3514ffb5e9.camel@sipsolutions.net>
         <CA+iem5tjTpO_2MKL_pEu7enTa-8=g5vY3=2WJKjg9f=JA2eCEw@mail.gmail.com>
         <9b89b3b294295063aec045b9e863a44ad20b8782.camel@sipsolutions.net>
         <bf0cced86a1466285f74eb845e73fbaea1dff1c0.camel@sipsolutions.net>
         <9bcbab4b562669b96198c632f476b1b74956ca09.camel@sipsolutions.net>
         <336996e4-d9fe-bf3a-72fb-6919bd0adcbf@candelatech.com>
         <c2004c4d9defd9c391e072b2703a845185bd395e.camel@sipsolutions.net>
         <ed9ae122-7573-a15e-7c42-7ae1fe3d123d@candelatech.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.2 (3.34.2-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sun, 2019-12-08 at 09:26 -0800, Ben Greear wrote:
> 
> > Yeah, that was an oversight for HE, it should work for HT/VHT. I have a
> > patch in the works to report the TX rate properly in iw.
> 
> I'm connecting to an /AC AP, so it should only be using VHT rates.  I'm on 5.2-ish
> kernel, so maybe it is already fixed in more recent ones?

I think I just saw that VHT has a similar issue. I thought it didn't,
but maybe also in VHT we don't report properly to mac80211?

Anyway, the patch I had fixes it, except the Mbps calculation was
garbage ... We'll send it out soon. It's purely cosmetic anyway, in a
sense.

> > > For reference, we have previously seen about 1.1Gbps upload between QCA9984 station and 4x4 /AC APs
> > > (and about 1.3Gbps download goodput), so in general, wifi upload can run faster.
> > 
> > Yes, for sure it can. Would be interesting to find out what the limiting
> > factor is for you.
> > 
> > Then again, I doubt we've released updated firmware recently - what
> > version are you using?
> 
> It is 48-something, whatever comes with Fedora-30.  We'd be happy to test more
> recent firmware...maybe you could make them available somewhere?

I just tried with this one (48.4fa0041f.0) and it seems OK-ish, at least
for UDP. TCP is much lower than I'd expect though, but both TX and RX,
which is strange.

> And if you can provide release notes for the firmware, you get +1 damage vs QCA :P

Heh :)

johannes

