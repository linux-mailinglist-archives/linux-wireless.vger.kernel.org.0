Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8CD8D1974BD
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Mar 2020 08:56:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729233AbgC3G4j (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 30 Mar 2020 02:56:39 -0400
Received: from mx.sdf.org ([205.166.94.20]:65413 "EHLO mx.sdf.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729099AbgC3G4j (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 30 Mar 2020 02:56:39 -0400
Received: from sdf.org (IDENT:lkml@sdf.lonestar.org [205.166.94.16])
        by mx.sdf.org (8.15.2/8.14.5) with ESMTPS id 02U6p8D4025450
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits) verified NO);
        Mon, 30 Mar 2020 06:51:08 GMT
Received: (from lkml@localhost)
        by sdf.org (8.15.2/8.12.8/Submit) id 02U6p5rX014028;
        Mon, 30 Mar 2020 06:51:05 GMT
Date:   Mon, 30 Mar 2020 06:51:05 +0000
From:   George Spelvin <lkml@SDF.ORG>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        linux-kernel@vger.kernel.org, Hannes Reinecke <hare@suse.de>,
        linux-scsi@vger.kernel.org,
        Marek Lindner <mareklindner@neomailbox.ch>,
        Simon Wunderlich <sw@simonwunderlich.de>,
        Antonio Quartulli <a@unstable.cc>,
        Sven Eckelmann <sven@narfation.org>,
        b.a.t.m.a.n@diktynna.open-mesh.org,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        lkml@sdf.org
Subject: Re: [RFC PATCH v1 13/50] Avoid some useless msecs/jiffies conversions
Message-ID: <20200330065105.GB9333@SDF.ORG>
References: <202003281643.02SGhBrh000992@sdf.org>
 <s5ho8sfd2dk.wl-tiwai@suse.de>
 <20200329121129.GC11951@SDF.ORG>
 <s5h7dz3ccea.wl-tiwai@suse.de>
 <20200329175032.GE4675@SDF.ORG>
 <1585505807.4510.1.camel@HansenPartnership.com>
 <s5hzhbybbnu.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5hzhbybbnu.wl-tiwai@suse.de>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, Mar 30, 2020 at 08:27:01AM +0200, Takashi Iwai wrote:
> On Sun, 29 Mar 2020 20:16:47 +0200, James Bottomley wrote:
>> We all assume that msecs_to_jiffies is properly optimized so there
>> should be no need to open code it like you're proposing.
> 
> Yes, it'd be best if the compiler can handle it properly.

I've tried, and can't figure out how to get the compiler to detect this 
special case and not invoke the general code.  In particular, for a 
variable x, __builtin_constant_p(x * 1000 % 1000) is false.  Even if x is 
signed and ANSI lets the compiler assume that overflow doesn't happen.

If you can do it, I'm most curious how!

> But also I meant to keep using the macro for consistency reason.
> IIRC, we wanted to eliminate the explicit use of HZ in the past, and
> it's how many lines have been converted with *_to_jiffies() calls.
> I don't know whether the eliminate of HZ is still wished, but
> reverting to the open code is a step backward for that.

Well, you could always add a secs_to_jiffies(x) wrapper.  But given
that it expands to basically x * HZ, some people might wonder why
you're bothering.

I assumed that open-coding x * HZ was the preferred style, so that's
what I did.
