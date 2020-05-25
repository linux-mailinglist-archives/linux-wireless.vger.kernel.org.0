Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AF841E0E5E
	for <lists+linux-wireless@lfdr.de>; Mon, 25 May 2020 14:25:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390504AbgEYMZ4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 25 May 2020 08:25:56 -0400
Received: from mx4.wp.pl ([212.77.101.12]:13818 "EHLO mx4.wp.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390360AbgEYMZz (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 25 May 2020 08:25:55 -0400
Received: (wp-smtpd smtp.wp.pl 3716 invoked from network); 25 May 2020 14:25:51 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=1024a;
          t=1590409551; bh=VKjU/NNINRjaIcHYZSG/M+d0LaKgwPL7ZL6ZaExPofo=;
          h=From:To:Cc:Subject;
          b=EpZPyYlAoqff8DeQ52oMAD4mekfD3obWBvxXGNBTr24z3BBhKILKrWnDV+YGQbKeI
           m9/lV/gUoe26tYNBlY0fexR1FNQdjqEdMngYVWTSy7M/qHMdwzW5TzwEanyP2ho1sG
           EEtRI4wPmT3y5kEpelbTY3wcTDyrqhOX9si6mfgk=
Received: from unknown (HELO localhost) (stf_xl@wp.pl@[46.39.164.203])
          (envelope-sender <stf_xl@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <rsalvaterra@gmail.com>; 25 May 2020 14:25:51 +0200
Date:   Mon, 25 May 2020 14:25:35 +0200
From:   Stanislaw Gruszka <stf_xl@wp.pl>
To:     Rui Salvaterra <rsalvaterra@gmail.com>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        Julian Calaby <julian.calaby@gmail.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        linux-wireless@vger.kernel.org
Subject: Re: [RFC PATCH] rt2800lib: unconditionally enable MFP
Message-ID: <20200525122535.GA927343@wp.pl>
References: <20200524094730.2684-1-rsalvaterra@gmail.com>
 <20200524111751.GA914918@wp.pl>
 <CAGRGNgWuQjQzDS9-cPAx7TnDfEiGnSccw4vqPAE_gWV=QS5JVw@mail.gmail.com>
 <20200524123931.GA915983@wp.pl>
 <640c254edb9fdaec2fd8987d1f2d345bd1d9276c.camel@sipsolutions.net>
 <20200525093142.GA926004@wp.pl>
 <9a8da74898b68fb63f65567068de0fcb2b5a57b0.camel@sipsolutions.net>
 <20200525105814.GA926693@wp.pl>
 <CALjTZvY0qPXxS=VPG3Ma6CCdtWo2g2XC3Cnks6jnNSFzqz-HAQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALjTZvY0qPXxS=VPG3Ma6CCdtWo2g2XC3Cnks6jnNSFzqz-HAQ@mail.gmail.com>
X-WP-MailID: 07530c472eae7fd1a95a04893895594a
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000001 [EeKn]                               
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello

On Mon, May 25, 2020 at 12:14:54PM +0100, Rui Salvaterra wrote:
> > If someone is willing to implement mt76 approach to have HW encryption offload
> > for MFP+CCMP, I'll be happy to review patch. From other hand, most people will
> > use MFP with modern ciphers anyway, so I'm not sure how much need is for such
> > patch.
> 
> I've been having a look at how mt76 solves the problem, but I haven't
> fully understood it yet. I feel it's out of my league, since I only
> started looking at wireless drivers very recently (I don't grasp all
> the concepts and the architecture).

Yeah, it's somewhat complicated.

> But one thing that also bugs me
> about software fallbacks is that for most of the older CPUs we don't
> have SIMD implementations of the required crypto. So, not only we fall
> back to software, but we're also stuck with scalar C algorithms on
> CPUs which are already slow.

If we talk about x86, we have AES-NI instructions since 2008:
https://en.wikipedia.org/wiki/AES_instruction_set
Which make CPU crypto quite fast. Though it can be a bottleneck,
I think, if wifi encryption is performed together with other encryption
applications like SSL .

Stanislaw
