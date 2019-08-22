Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C3FB898BDC
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Aug 2019 08:58:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731156AbfHVG6v (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 22 Aug 2019 02:58:51 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:56364 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731064AbfHVG6u (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 22 Aug 2019 02:58:50 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <johannes@sipsolutions.net>)
        id 1i0h3X-0000g0-Qr; Thu, 22 Aug 2019 08:58:47 +0200
Message-ID: <a4df85e6c9ff221e89b970ecf3c39960f2b4cd56.camel@sipsolutions.net>
Subject: Re: Implementing Mikrotik IE
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Josef Miegl <josef@miegl.cz>,
        Sebastian Gottschall <s.gottschall@newmedia-net.de>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>
Date:   Thu, 22 Aug 2019 08:58:47 +0200
In-Reply-To: <E28FAC24-4B21-48FB-A010-770BCEF4CCA1@miegl.cz>
References: <20190815152844.k5mmddvbwrohkzr6@pepin-laptop.localdomain>
         <3a079683-6f57-3b42-f909-90c46e14f14f@newmedia-net.de>
         <20190816111044.4ntizgmpa3twbzcg@pepin-laptop.localdomain>
         <e8129acb-fc32-c85c-b504-ab8777a3f1a3@newmedia-net.de>
         <20190816113818.ohktykc4fyetzyvq@pepin-laptop.localdomain>
         <9985fddfb059640f36665efc9c1ef2dc0bdb7662.camel@sipsolutions.net>
         <b8009787-a182-d5f2-6dde-ee540c65a03b@newmedia-net.de>
         <bb0d7dd87a7821df245919c86458bd50a3d1a81e.camel@sipsolutions.net>
         <8ec8202e-ca07-3594-5873-5b282d553711@newmedia-net.de>
         <E28FAC24-4B21-48FB-A010-770BCEF4CCA1@miegl.cz>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, 2019-08-22 at 01:57 +0200, Josef Miegl wrote:
> On August 20, 2019 2:36:21 PM GMT+02:00, Sebastian Gottschall <s.gottschall@newmedia-net.de> wrote:
> > i know. thats why i never even tried to contribute it upstream. but
> > from 
> > hostapd side it was more complicated than just hacking mac80211
> > and from stations a second mod for wpa_supplicant would be needed and 
> > since the dd-wrt webgui just uses nl80211 to show the station table
> > its more comportable and takes less code just todo it within the driver
> > i there is special interest in it i could of course try to clean it up 
> > and make a upstream patch out of it
> 
> I don't think something like Mikrotiks IE belongs to hostapd. The
> cleanest solution is probably parsing the IE and generating the IE for
> hostapd with an external tool, that can the dd-wrt GUI then use. I've
> made a simple C program for this, can share if you want.

Sebastian was talking about yet another case - namely recording it for
the stations, to be able to show it.

I guess hostapd could be made to just generally record *all* the
association request IEs that a station sent and make those available
over the control interface.

Alternatively, you could have another application just listen to nl80211
events, I guess.

Or even the kernel could capture *all*, but I don't see why we'd waste
unpageable kernel memory for it.

johannes

