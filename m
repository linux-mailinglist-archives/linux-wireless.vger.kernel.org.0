Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ECD31196D39
	for <lists+linux-wireless@lfdr.de>; Sun, 29 Mar 2020 14:16:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728080AbgC2MQA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 29 Mar 2020 08:16:00 -0400
Received: from mx.sdf.org ([205.166.94.20]:64164 "EHLO mx.sdf.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727901AbgC2MP7 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 29 Mar 2020 08:15:59 -0400
Received: from sdf.org (IDENT:lkml@sdf.lonestar.org [205.166.94.16])
        by mx.sdf.org (8.15.2/8.14.5) with ESMTPS id 02TCBVww020963
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits) verified NO);
        Sun, 29 Mar 2020 12:11:32 GMT
Received: (from lkml@localhost)
        by sdf.org (8.15.2/8.12.8/Submit) id 02TCBTk2014576;
        Sun, 29 Mar 2020 12:11:29 GMT
Date:   Sun, 29 Mar 2020 12:11:29 +0000
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
Message-ID: <20200329121129.GC11951@SDF.ORG>
References: <202003281643.02SGhBrh000992@sdf.org>
 <s5ho8sfd2dk.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5ho8sfd2dk.wl-tiwai@suse.de>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sun, Mar 29, 2020 at 09:52:23AM +0200, Takashi Iwai wrote:
> On Thu, 22 Aug 2019 02:25:10 +0200, George Spelvin wrote:
>> Likewise, "msecs_to_jiffies(seconds * 1000)" is more
>> conveniently written "seconds * HZ".
> 
> I thought the compiler already optimizes to the constant calculation
> for the above case?

It optimizes that if the entire argument, including "seconds", is
a compile-time constant.

However, given "msecs_to_jiffies(hdev->rpa_timeout * 1000);",
the computatin is non-trivial.
