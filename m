Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 54BE4196F0C
	for <lists+linux-wireless@lfdr.de>; Sun, 29 Mar 2020 19:56:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728393AbgC2R4G (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 29 Mar 2020 13:56:06 -0400
Received: from mx.sdf.org ([205.166.94.20]:54745 "EHLO mx.sdf.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728358AbgC2R4F (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 29 Mar 2020 13:56:05 -0400
Received: from sdf.org (IDENT:lkml@sdf.lonestar.org [205.166.94.16])
        by mx.sdf.org (8.15.2/8.14.5) with ESMTPS id 02THoYVV027072
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits) verified NO);
        Sun, 29 Mar 2020 17:50:34 GMT
Received: (from lkml@localhost)
        by sdf.org (8.15.2/8.12.8/Submit) id 02THoW6w010257;
        Sun, 29 Mar 2020 17:50:32 GMT
Date:   Sun, 29 Mar 2020 17:50:32 +0000
From:   George Spelvin <lkml@SDF.ORG>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     linux-kernel@vger.kernel.org, Hannes Reinecke <hare@suse.de>,
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
Message-ID: <20200329175032.GE4675@SDF.ORG>
References: <202003281643.02SGhBrh000992@sdf.org>
 <s5ho8sfd2dk.wl-tiwai@suse.de>
 <20200329121129.GC11951@SDF.ORG>
 <s5h7dz3ccea.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5h7dz3ccea.wl-tiwai@suse.de>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sun, Mar 29, 2020 at 07:13:33PM +0200, Takashi Iwai wrote:
> On Sun, 29 Mar 2020 14:11:29 +0200, George Spelvin wrote:
>> On Sun, Mar 29, 2020 at 09:52:23AM +0200, Takashi Iwai wrote:
>>> I thought the compiler already optimizes to the constant calculation
>>> for the above case?
>> 
>> It optimizes that if the entire argument, including "seconds", is
>> a compile-time constant.
>> 
>> However, given "msecs_to_jiffies(hdev->rpa_timeout * 1000);",
>> the computatin is non-trivial.
> 
> Fair enough.  But it's still a question whether an open code X * HZ is
> good at all...

I'm sorry, I don't understand what you mean by "good at all" here.
The value computed is exactly the same.

msecs_to_jiffies(x) is basically (x * HZ + 999) / 1000, so
  msecs_to_jiffies(s * 1000)
= (s * 1000 * HZ + 999) / 1000
= s * HZ + 999/1000
= s * HZ.
