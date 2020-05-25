Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A9011E0C54
	for <lists+linux-wireless@lfdr.de>; Mon, 25 May 2020 12:58:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389897AbgEYK6S (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 25 May 2020 06:58:18 -0400
Received: from mx4.wp.pl ([212.77.101.11]:50013 "EHLO mx4.wp.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389856AbgEYK6S (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 25 May 2020 06:58:18 -0400
Received: (wp-smtpd smtp.wp.pl 27426 invoked from network); 25 May 2020 12:58:15 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=1024a;
          t=1590404295; bh=7MF1/Pl/EH+Ubq6o+1e1DNviLR2qay5k+wY58eSF9aM=;
          h=From:To:Cc:Subject;
          b=u5j0FP3pGaEM1NAMsYpPKK+vXx4crQAEBhXIs4PAH9KDqjiiIZzohR6oiiDkZYHkT
           bmElDvMfS5tK6DaAluU+AKIcrJGFFOwoj1imVQ/Z+ezs1ydtX5hAKSYDDgO4IX9F3u
           KF1rqQnd7AKAE9DED4c5An0qHF0DE4D1CpGAKV34=
Received: from ip4-46-39-164-203.cust.nbox.cz (HELO localhost) (stf_xl@wp.pl@[46.39.164.203])
          (envelope-sender <stf_xl@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <johannes@sipsolutions.net>; 25 May 2020 12:58:15 +0200
Date:   Mon, 25 May 2020 12:58:14 +0200
From:   Stanislaw Gruszka <stf_xl@wp.pl>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     Julian Calaby <julian.calaby@gmail.com>,
        Rui Salvaterra <rsalvaterra@gmail.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        linux-wireless@vger.kernel.org
Subject: Re: [RFC PATCH] rt2800lib: unconditionally enable MFP
Message-ID: <20200525105814.GA926693@wp.pl>
References: <20200524094730.2684-1-rsalvaterra@gmail.com>
 <20200524111751.GA914918@wp.pl>
 <CAGRGNgWuQjQzDS9-cPAx7TnDfEiGnSccw4vqPAE_gWV=QS5JVw@mail.gmail.com>
 <20200524123931.GA915983@wp.pl>
 <640c254edb9fdaec2fd8987d1f2d345bd1d9276c.camel@sipsolutions.net>
 <20200525093142.GA926004@wp.pl>
 <9a8da74898b68fb63f65567068de0fcb2b5a57b0.camel@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a8da74898b68fb63f65567068de0fcb2b5a57b0.camel@sipsolutions.net>
X-WP-MailID: 6610d83fe14df7a8e2fdefd7a6c7dd72
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000000 [wXNU]                               
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, May 25, 2020 at 11:49:56AM +0200, Johannes Berg wrote:
> On Mon, 2020-05-25 at 11:31 +0200, Stanislaw Gruszka wrote:
> > On Mon, May 25, 2020 at 11:15:29AM +0200, Johannes Berg wrote:
> > > On Sun, 2020-05-24 at 14:39 +0200, Stanislaw Gruszka wrote:
> > > > > And once mac80211 is smart enough to make those decisions, couldn't we
> > > > > just enable MFP by default?
> > > 
> > > For the record, I don't think we'd really want to add such a thing to
> > > mac80211 ... easier done in the driver.
> > > 
> > > > If we will have indicator from mac80211 that MFP is configured, we can
> > > > just return -EOPNOTSUPP from rt2x00mac_set_key() for CCMP and that will
> > > > make MFP work without specifying nohwcrypt module parameter - software
> > > > encryption will be used anyway.
> > > 
> > > Not sure mac80211 really knows? Hmm.
> > 
> > After looking at this a bit more, seems we have indicator of MFP being
> > used in ieee80211_sta structure.
> 
> Yeah, where's my head ... sorry.
> 
> > So maybe adding check like below
> > will allow to remove nohwcrypt rt2x00 requirement for MFP ?
> 
> Seems reasonable, but will still do _everything_ in software for such
> connections. Still better than not connecting, I guess.

Yeah, and at least without nohwcrypt=y we can still use HW encryption
for non-MFP stations.

Rui, feel free to repost your patch with additional sta->mfp check.

If someone is willing to implement mt76 approach to have HW encryption offload
for MFP+CCMP, I'll be happy to review patch. From other hand, most people will
use MFP with modern ciphers anyway, so I'm not sure how much need is for such
patch.

Stanislaw
