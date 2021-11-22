Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E529459529
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Nov 2021 19:55:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231307AbhKVS6v (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 22 Nov 2021 13:58:51 -0500
Received: from mx4.wp.pl ([212.77.101.11]:5014 "EHLO mx4.wp.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233806AbhKVS6s (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 22 Nov 2021 13:58:48 -0500
Received: (wp-smtpd smtp.wp.pl 25075 invoked from network); 22 Nov 2021 19:55:38 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=1024a;
          t=1637607338; bh=/aiVtgsJvQemMMgznBzEJcslTpOzV+/MTlG713p8LlM=;
          h=From:To:Cc:Subject;
          b=NsbReASeJX5R49dEDoB5tanS0nFYy27Cv9UKMSGpymsgX2EzLDZeBws60BSuu8I4T
           uIIfk7fmNAxvKRTq/B6nlYA/LwKMHC+nxLSow8aAfBKz7txKzkpTB3CTAga2mv1bTR
           ulZUZaMxw0yLFciF9SROlhgq0hqYCegLZOlYPGQg=
Received: from 89-74-82-70.dynamic.chello.pl (HELO localhost) (stf_xl@wp.pl@[89.74.82.70])
          (envelope-sender <stf_xl@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <regressions@leemhuis.info>; 22 Nov 2021 19:55:38 +0100
Date:   Mon, 22 Nov 2021 19:55:37 +0100
From:   Stanislaw Gruszka <stf_xl@wp.pl>
To:     Thorsten Leemhuis <regressions@leemhuis.info>
Cc:     Robert W <rwbugreport@lost-in-the-void.net>,
        Helmut Schaa <helmut.schaa@googlemail.com>,
        linux-wireless@vger.kernel.org,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>
Subject: Re: Bug/Regression - Ralink RT2800 kernel deference issue since
 kernel 5.14
Message-ID: <20211122185515.GA289958@wp.pl>
References: <c07b4142fb725ed87a2cef530bae9ee7@lost-in-the-void.net>
 <60b9dbe3-852b-9e63-2857-0264d7093930@leemhuis.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <60b9dbe3-852b-9e63-2857-0264d7093930@leemhuis.info>
X-WP-MailID: a664ab15c8886e3e672fadde8f9c2a9a
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000001 [kXIW]                               
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sun, Nov 21, 2021 at 02:38:02PM +0100, Thorsten Leemhuis wrote:
> Hi, this is your Linux kernel regression tracker speaking.
> 
> CCing regression mailing list, which should be in the loop for all
> regressions, as explained here:
> https://www.kernel.org/doc/html/latest/admin-guide/reporting-issues.html
> 
> Also adding Helmut and Stanislaw (or just a different of his
> addresses?), as afaics nothing happened since the report.

FYI: stf_xl@wp.pl is the only valid public e-mail address currently
used by me.

> On 12.11.21 22:21, Robert W wrote:
> > 
> > I have recently tried to upgrade a system to run the 5.14 kernel and
> > noticed that I was getting hangs on the system which seem to relate to
> > this wireless dongle which I am running hostapd against to provide a
> > small AP. Since that time kernel 5.15 was released and I have tested
> > that kernel as well and the problem persists.  The issue sometimes
> > occurs within an hour and other times it takes a few hours. I have tried
> > to narrow down what is causing the issue.  I thought it might be a
> > change elsewhere outside the mac80211/driver area so I tried to run the
> > wireless backports 5.15-rc6 on top of the last stable kernel of 5.13 so
> > as to have the smallest number of changes on the system. The backports
> > crashes with the same error.  I have included below the netconsole
> > output and the gdb of the kernel module in question. The capture was
> > from when I was using the backports, but the error  is the same.  I hope
> > the pastebins are okay to use on the list.  I did try to get some
> > assistance on linux-wireless IRC and some one asked for the outputs I
> > had for the information so I am reusing them here.
> > 
> > The following pastebin is the data sent to a netconsole instance.
> > 
> > https://pastebin.com/UxRrTtUh
<snip>
> > (gdb) list *(rt2x00queue_create_tx_descriptor+0x176)
> > 0x37e6 is in rt2x00queue_create_tx_descriptor (/home/robert/backport/backports-5.15-rc6-1/drivers/net/wireless/ralink/rt2x00/rt2x00queue.c:324).
> > 319                      */
> > 320                     if (sta && txdesc->u.ht.mcs > 7 &&
> > 321                         sta->smps_mode == IEEE80211_SMPS_DYNAMIC)
> > 322                             __set_bit(ENTRY_TXD_HT_MIMO_PS, &txdesc->flags);
> > 323             } else {
> > 324                     txdesc->u.ht.mcs = rt2x00_get_rate_mcs(hwrate->mcs);
> > 325                     if (txrate->flags & IEEE80211_TX_RC_USE_SHORT_PREAMBLE)
> > 326                             txdesc->u.ht.mcs |= 0x08;
> > 327             }
> > 328

Looking at the mailing list archives, seems Felix already provided
patch for this. Hopefully patch fixes the problem. However if changes
in the rt2x00 drivers are needed further, I can look at this.

Regards
Stanislaw

