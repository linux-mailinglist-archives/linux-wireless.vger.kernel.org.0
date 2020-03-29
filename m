Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B35C9196F2A
	for <lists+linux-wireless@lfdr.de>; Sun, 29 Mar 2020 20:16:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728501AbgC2SQv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 29 Mar 2020 14:16:51 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:41566 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727506AbgC2SQv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 29 Mar 2020 14:16:51 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 1A29F8EE3FB;
        Sun, 29 Mar 2020 11:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1585505810;
        bh=rBvSkEZqenHlElaAoaY3uIGBSF/hz4P4ALj5BPOQHd8=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=AwaSoiQmg6hmeQbTt1xr9B09pgLQ+Iw5OlB8ltxyEVnlGLh4SbRra2jPM9eAS1c6S
         lfjJiFM0YxHdA2lBgT5uYEEyqRZWKIjYYyLFwYaLLc4bzYJYL9HJVgSv+NLuamKgUJ
         dxWeLxccmARVeoKF+pAsxaPsYfGYzRPTQS4U35EA=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 7D53_2EYtwap; Sun, 29 Mar 2020 11:16:49 -0700 (PDT)
Received: from [153.66.254.194] (unknown [50.35.76.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 148728EE109;
        Sun, 29 Mar 2020 11:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1585505809;
        bh=rBvSkEZqenHlElaAoaY3uIGBSF/hz4P4ALj5BPOQHd8=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=scU+UulmbouSY9Sirt+FkSSwoV2JzDPqQb5aY8N7+68p+LrjSRWQBBN9KuxCOebLV
         +6mt2oJZ14HHJRPk5MJFc0M9sByCZGG5CpOYWRuhMzuQ3xO0YKMOTudmKzZKFQG25Y
         JENhpDxxEfju16KggGq6CkHEh1lNAM325v+r6Czg=
Message-ID: <1585505807.4510.1.camel@HansenPartnership.com>
Subject: Re: [RFC PATCH v1 13/50] Avoid some useless msecs/jiffies
 conversions
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     George Spelvin <lkml@SDF.ORG>, Takashi Iwai <tiwai@suse.de>
Cc:     linux-kernel@vger.kernel.org, Hannes Reinecke <hare@suse.de>,
        linux-scsi@vger.kernel.org,
        Marek Lindner <mareklindner@neomailbox.ch>,
        Simon Wunderlich <sw@simonwunderlich.de>,
        Antonio Quartulli <a@unstable.cc>,
        Sven Eckelmann <sven@narfation.org>,
        b.a.t.m.a.n@diktynna.open-mesh.org,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org
Date:   Sun, 29 Mar 2020 11:16:47 -0700
In-Reply-To: <20200329175032.GE4675@SDF.ORG>
References: <202003281643.02SGhBrh000992@sdf.org>
         <s5ho8sfd2dk.wl-tiwai@suse.de> <20200329121129.GC11951@SDF.ORG>
         <s5h7dz3ccea.wl-tiwai@suse.de> <20200329175032.GE4675@SDF.ORG>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sun, 2020-03-29 at 17:50 +0000, George Spelvin wrote:
> On Sun, Mar 29, 2020 at 07:13:33PM +0200, Takashi Iwai wrote:
> > On Sun, 29 Mar 2020 14:11:29 +0200, George Spelvin wrote:
> > > On Sun, Mar 29, 2020 at 09:52:23AM +0200, Takashi Iwai wrote:
> > > > I thought the compiler already optimizes to the constant
> > > > calculation
> > > > for the above case?
> > > 
> > > It optimizes that if the entire argument, including "seconds", is
> > > a compile-time constant.
> > > 
> > > However, given "msecs_to_jiffies(hdev->rpa_timeout * 1000);",
> > > the computatin is non-trivial.
> > 
> > Fair enough.  But it's still a question whether an open code X * HZ
> > is
> > good at all...
> 
> I'm sorry, I don't understand what you mean by "good at all" here.
> The value computed is exactly the same.

I think he means what the compiler does with it.

We all assume that msecs_to_jiffies is properly optimized so there
should be no need to open code it like you're proposing.  So firstly
can you produce the assembly that shows the worse output from
msecs_to_jiffies?  If there is a problem, then we should be fixing it
in msecs_to_jiffies, not adding open coding.

James

