Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 483FC1E0A97
	for <lists+linux-wireless@lfdr.de>; Mon, 25 May 2020 11:31:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389517AbgEYJbr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 25 May 2020 05:31:47 -0400
Received: from mx3.wp.pl ([212.77.101.9]:24513 "EHLO mx3.wp.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389477AbgEYJbq (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 25 May 2020 05:31:46 -0400
Received: (wp-smtpd smtp.wp.pl 37954 invoked from network); 25 May 2020 11:31:43 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=1024a;
          t=1590399103; bh=Og4Osuthk/T+kCAqEy64KeD1zO4XYNZ3iKqWkK4kO+w=;
          h=From:To:Cc:Subject;
          b=SJEHqbmw9Qdb+nAtgG3c/R7yYPJSNfPsqnN+mnZvSW9iJBtXxb+6qMhZOtYjjYJ/u
           o5XRA1U+JAmL9YyIQkTWID3/AuubsKYrCBWejKylhlcqQLMeds4yeO3Uja/tUB72EY
           0EFzb8aFM2H2PSZ9XLv7pOB3dnt+jt+xQuy7mBRo=
Received: from ip4-46-39-164-203.cust.nbox.cz (HELO localhost) (stf_xl@wp.pl@[46.39.164.203])
          (envelope-sender <stf_xl@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <johannes@sipsolutions.net>; 25 May 2020 11:31:43 +0200
Date:   Mon, 25 May 2020 11:31:42 +0200
From:   Stanislaw Gruszka <stf_xl@wp.pl>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     Julian Calaby <julian.calaby@gmail.com>,
        Rui Salvaterra <rsalvaterra@gmail.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        linux-wireless@vger.kernel.org
Subject: Re: [RFC PATCH] rt2800lib: unconditionally enable MFP
Message-ID: <20200525093142.GA926004@wp.pl>
References: <20200524094730.2684-1-rsalvaterra@gmail.com>
 <20200524111751.GA914918@wp.pl>
 <CAGRGNgWuQjQzDS9-cPAx7TnDfEiGnSccw4vqPAE_gWV=QS5JVw@mail.gmail.com>
 <20200524123931.GA915983@wp.pl>
 <640c254edb9fdaec2fd8987d1f2d345bd1d9276c.camel@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <640c254edb9fdaec2fd8987d1f2d345bd1d9276c.camel@sipsolutions.net>
X-WP-MailID: 9dbe79948063971c9a050e20b7ee3791
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000000 [gQMU]                               
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, May 25, 2020 at 11:15:29AM +0200, Johannes Berg wrote:
> On Sun, 2020-05-24 at 14:39 +0200, Stanislaw Gruszka wrote:
> > 
> > > And once mac80211 is smart enough to make those decisions, couldn't we
> > > just enable MFP by default?
> 
> For the record, I don't think we'd really want to add such a thing to
> mac80211 ... easier done in the driver.
> 
> > If we will have indicator from mac80211 that MFP is configured, we can
> > just return -EOPNOTSUPP from rt2x00mac_set_key() for CCMP and that will
> > make MFP work without specifying nohwcrypt module parameter - software
> > encryption will be used anyway.
> 
> Not sure mac80211 really knows? Hmm.

After looking at this a bit more, seems we have indicator of MFP being
used in ieee80211_sta structure. So maybe adding check like below
will allow to remove nohwcrypt rt2x00 requirement for MFP ?

diff --git a/drivers/net/wireless/ralink/rt2x00/rt2x00mac.c b/drivers/net/wireless/ralink/rt2x00/rt2x00mac.c
index 32efbc8e9f92..241e42bb0fd2 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2x00mac.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt2x00mac.c
@@ -468,7 +468,7 @@ int rt2x00mac_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 	if (!test_bit(DEVICE_STATE_PRESENT, &rt2x00dev->flags))
 		return 0;
 
-	if (!rt2x00_has_cap_hw_crypto(rt2x00dev))
+	if (!rt2x00_has_cap_hw_crypto(rt2x00dev) || sta->mfp)
 		return -EOPNOTSUPP;
 
 	/*

Stanislaw
