Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CEDB373C51
	for <lists+linux-wireless@lfdr.de>; Wed,  5 May 2021 15:25:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233483AbhEEN0O (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 5 May 2021 09:26:14 -0400
Received: from mx3.wp.pl ([212.77.101.9]:29324 "EHLO mx3.wp.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231774AbhEEN0N (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 5 May 2021 09:26:13 -0400
Received: (wp-smtpd smtp.wp.pl 4388 invoked from network); 5 May 2021 15:25:13 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=1024a;
          t=1620221113; bh=gERp2+BNAjE1SfvsMM8qb78FlZtlMsKZEIy8j3LL/Gw=;
          h=From:To:Cc:Subject;
          b=UqqUShU3Lry1OsOsO/hV2yypIzQ8FEQ8DS2H3/v6IcKCAVycOzSs7vY58C3ztUegU
           kLNvkGdFZn5Pauv9UPSUBCMwRPHnv7wNDn/BlGTfK/RyOb29iw/1ecyYyb99Nli2RB
           TVDded5paDF5zjMHBHRbrQvlwAMEekJuloYltNjI=
Received: from 89-64-4-144.dynamic.chello.pl (HELO localhost) (stf_xl@wp.pl@[89.64.4.144])
          (envelope-sender <stf_xl@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <rsalvaterra@gmail.com>; 5 May 2021 15:25:13 +0200
Date:   Wed, 5 May 2021 15:25:13 +0200
From:   Stanislaw Gruszka <stf_xl@wp.pl>
To:     Rui Salvaterra <rsalvaterra@gmail.com>
Cc:     lorenzo@kernel.org, kuba@kernel.org, linux-wireless@vger.kernel.org
Subject: Re: [RFC PATCH] mt7601u: make the driver work again
Message-ID: <20210505132513.GA759295@wp.pl>
References: <20210504212828.815-1-rsalvaterra@gmail.com>
 <20210505045044.GA735251@wp.pl>
 <CALjTZvYZ8Rr-UFyqFststt+vG+Ei1avUvPVxQwHe72QU0NEeKA@mail.gmail.com>
 <20210505092542.GA757514@wp.pl>
 <CALjTZvausPmK+AubwcV71b1Vi+JxN23fM-AfUr1+jRD+NbnW1g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALjTZvausPmK+AubwcV71b1Vi+JxN23fM-AfUr1+jRD+NbnW1g@mail.gmail.com>
X-WP-MailID: 28fe733e498a21b4c4762ab40731350c
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000002 [sfHx]                               
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi

On Wed, May 05, 2021 at 10:38:58AM +0100, Rui Salvaterra wrote:
> Hi again, Stanislaw,
> 
> I was meanwhile wondering if we could try and unconditionally drop the
> DPD calibration from the driver, and see if anyone complains. You said
> it yourself [1] the vendor driver has DPD calibration under
> conditional compilation (I don't know which conditions, though, I
> haven't looked at it). As far as testing is concerned, all my devices
> are 148f:7601, so it would be nice for people with other USB IDs to
> test them.
> 
> [1] https://github.com/kuba-moo/mt7601u/issues/64#issuecomment-479801642

I don't know if it's safe to remove DPD calibration in mt7601u driver
for all supported devices. Possibly it is. I don't have my device any
longer, but as far I remember removing DPD was harmless for my device.
But can not assure that this does not break support for some other
devices or cause not easy to notice issue like performance drop on
some specific conditions.

Regards
Stanislaw
