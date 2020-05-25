Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33A291E0F34
	for <lists+linux-wireless@lfdr.de>; Mon, 25 May 2020 15:14:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390728AbgEYNOb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 25 May 2020 09:14:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390626AbgEYNOa (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 25 May 2020 09:14:30 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABFDCC061A0E
        for <linux-wireless@vger.kernel.org>; Mon, 25 May 2020 06:14:30 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1jdCvv-002idp-D0; Mon, 25 May 2020 15:14:23 +0200
Message-ID: <9188b9f91d162146a61729b5b4fcc06530674810.camel@sipsolutions.net>
Subject: Re: [RFC PATCH] rt2800lib: unconditionally enable MFP
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Rui Salvaterra <rsalvaterra@gmail.com>,
        Stanislaw Gruszka <stf_xl@wp.pl>
Cc:     Julian Calaby <julian.calaby@gmail.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        linux-wireless@vger.kernel.org
Date:   Mon, 25 May 2020 15:14:21 +0200
In-Reply-To: <CALjTZvbNdQw4uj+n231d9R39F_MNn=nrj9_aL71am4Wy7jnh1A@mail.gmail.com> (sfid-20200525_151341_366399_6ACF85B8)
References: <20200524094730.2684-1-rsalvaterra@gmail.com>
         <20200524111751.GA914918@wp.pl>
         <CAGRGNgWuQjQzDS9-cPAx7TnDfEiGnSccw4vqPAE_gWV=QS5JVw@mail.gmail.com>
         <20200524123931.GA915983@wp.pl>
         <640c254edb9fdaec2fd8987d1f2d345bd1d9276c.camel@sipsolutions.net>
         <20200525093142.GA926004@wp.pl>
         <9a8da74898b68fb63f65567068de0fcb2b5a57b0.camel@sipsolutions.net>
         <20200525105814.GA926693@wp.pl>
         <CALjTZvY0qPXxS=VPG3Ma6CCdtWo2g2XC3Cnks6jnNSFzqz-HAQ@mail.gmail.com>
         <CALjTZvbNdQw4uj+n231d9R39F_MNn=nrj9_aL71am4Wy7jnh1A@mail.gmail.com>
         (sfid-20200525_151341_366399_6ACF85B8)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.2 (3.36.2-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, 2020-05-25 at 14:13 +0100, Rui Salvaterra wrote:
> On Mon, 25 May 2020 at 12:14, Rui Salvaterra <rsalvaterra@gmail.com> wrote:
> > Hi, Stanislaw,
> > 
> > On Mon, 25 May 2020 at 11:58, Stanislaw Gruszka <stf_xl@wp.pl> wrote:
> > > Yeah, and at least without nohwcrypt=y we can still use HW encryption
> > > for non-MFP stations.
> > > 
> > > Rui, feel free to repost your patch with additional sta->mfp check.
> > 
> > Sure, will do. :)
> 
> Wait, scratch that. The additional sta->mfp check causes a NPE, sta is
> probably null at that point.

Not at this point - but the GTK comes with null STA, so you want
	(sta && sta->mfp)

instead.

johannes

