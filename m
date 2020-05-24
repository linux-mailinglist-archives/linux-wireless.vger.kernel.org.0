Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB81B1DFEF3
	for <lists+linux-wireless@lfdr.de>; Sun, 24 May 2020 14:39:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728405AbgEXMjf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 24 May 2020 08:39:35 -0400
Received: from mx3.wp.pl ([212.77.101.9]:53084 "EHLO mx3.wp.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726734AbgEXMjf (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 24 May 2020 08:39:35 -0400
Received: (wp-smtpd smtp.wp.pl 18117 invoked from network); 24 May 2020 14:39:32 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=1024a;
          t=1590323972; bh=fhnoPEVd6GdDQIGObtlO6gHHRE5AYPqzJxXINQdfNmU=;
          h=From:To:Cc:Subject;
          b=BvlE8go3KcNlqDfEmTkf+daoWTtloiYwoDhkPEw7YK3vbTXHsmq1d5iNEw28UWrFn
           Rg+5qXcM62ZgSB6lHhXsI+QLyJx1dOCbydnb5ovt8bGu3m/9Nj5Fl7pYwd8KuL77qp
           QO0WmSjs2QV/F89fpfoV82w1mK3KZlLh3OS/1l7M=
Received: from ip4-46-39-164-203.cust.nbox.cz (HELO localhost) (stf_xl@wp.pl@[46.39.164.203])
          (envelope-sender <stf_xl@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <julian.calaby@gmail.com>; 24 May 2020 14:39:32 +0200
Date:   Sun, 24 May 2020 14:39:31 +0200
From:   Stanislaw Gruszka <stf_xl@wp.pl>
To:     Julian Calaby <julian.calaby@gmail.com>
Cc:     Rui Salvaterra <rsalvaterra@gmail.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        linux-wireless@vger.kernel.org
Subject: Re: [RFC PATCH] rt2800lib: unconditionally enable MFP
Message-ID: <20200524123931.GA915983@wp.pl>
References: <20200524094730.2684-1-rsalvaterra@gmail.com>
 <20200524111751.GA914918@wp.pl>
 <CAGRGNgWuQjQzDS9-cPAx7TnDfEiGnSccw4vqPAE_gWV=QS5JVw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGRGNgWuQjQzDS9-cPAx7TnDfEiGnSccw4vqPAE_gWV=QS5JVw@mail.gmail.com>
X-WP-MailID: d0e6d6040c6bd726f4ee070ee5e2c0cf
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000000 [cbM0]                               
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi

On Sun, May 24, 2020 at 09:42:51PM +1000, Julian Calaby wrote:
> Hi Stanislaw,
> 
> On Sun, May 24, 2020 at 9:27 PM Stanislaw Gruszka <stf_xl@wp.pl> wrote:
> >
> > On Sun, May 24, 2020 at 10:47:31AM +0100, Rui Salvaterra wrote:
> > > According to Larry [1] (and successfully verified on b43) mac80211
> > > transparently falls back to software for unsupported hardware cyphers. Thus,
> > > there's no reason for not unconditionally enabling MFP. This gives us WPA3
> > > support out of the box, without having to manually disable hardware crypto.
> > >
> > > Tested on an RT2790-based Wi-Fi card.
> > >
> > > [1] https://lore.kernel.org/linux-wireless/8252e6a1-b83c-64eb-2503-2686374216ae@lwfinger.net/
> >
> > AFICT more work need to be done to support MFP by HW encryption properly
> > on rt2x00. See this message and whole thread:
> > https://lore.kernel.org/linux-wireless/977a3cf4-3ec5-4aaa-b3d4-eea2e8593652@nbd.name/
> 
> Am I reading this right: rt2x00 offloads some of the processing to the
> card which interferes with MFP when using software encryption, so
> therefore we need to disable that offload when using software
> encryption with MFP.

Yes.

We offload encryption to HW based on cipher. Modern ciphers like 
GCMP, BIP_GMAC, etc, are not supported by rt2x00 HW. In such case
rt2x00mac_set_key() will return -EOPNOTSUPP and all encryption will
be done by mac80211 - MFP will work just fine.

But MFP can still be used with CCMP cipher, which we offload to HW,
and that would create problems described by Felix.

> So if mac80211 knows that this offload is happening and that we can't
> use hardware crypto for MFP, could it be smart enough to disable the
> offload itself?
> 
> And once mac80211 is smart enough to make those decisions, couldn't we
> just enable MFP by default?

If we will have indicator from mac80211 that MFP is configured, we can
just return -EOPNOTSUPP from rt2x00mac_set_key() for CCMP and that will
make MFP work without specifying nohwcrypt module parameter - software
encryption will be used anyway.

Optimal solution though would be implement similar code like in mt76, so
we will have HW encryption for MFP+CCMP, but this is not trivial, and
I think handling encryption fully in software is ok.

Stanislaw
