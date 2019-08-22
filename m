Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9731C98BEE
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Aug 2019 09:00:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731326AbfHVHAW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 22 Aug 2019 03:00:22 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:56386 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728605AbfHVHAV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 22 Aug 2019 03:00:21 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <johannes@sipsolutions.net>)
        id 1i0h51-0000jL-Nk; Thu, 22 Aug 2019 09:00:19 +0200
Message-ID: <5ee160209eb1f9e70f6224c393389266280d7d80.camel@sipsolutions.net>
Subject: Re: Implementing Mikrotik IE
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Josef Miegl <josef@miegl.cz>
Cc:     Sebastian Gottschall <s.gottschall@newmedia-net.de>,
        linux-wireless <linux-wireless@vger.kernel.org>
Date:   Thu, 22 Aug 2019 09:00:18 +0200
In-Reply-To: <58A25955-2A17-4DE7-82FB-3B20E00C96EC@miegl.cz>
References: <20190815152844.k5mmddvbwrohkzr6@pepin-laptop.localdomain>
         <3a079683-6f57-3b42-f909-90c46e14f14f@newmedia-net.de>
         <20190816111044.4ntizgmpa3twbzcg@pepin-laptop.localdomain>
         <e8129acb-fc32-c85c-b504-ab8777a3f1a3@newmedia-net.de>
         <20190816113818.ohktykc4fyetzyvq@pepin-laptop.localdomain>
         <9985fddfb059640f36665efc9c1ef2dc0bdb7662.camel@sipsolutions.net>
         <20190819113706.ujsz67sxcwt2ulmt@pepin-laptop.localdomain>
         <b3b7a99971f1512b4cd9c72920b699c252c1ae83.camel@sipsolutions.net>
         <A3C14EA9-BA2D-4745-BBB9-E10028B6DE13@miegl.cz>
         <6efb9b56c77cd9ea945f89c3371b49c301dc2b4e.camel@sipsolutions.net>
         <58A25955-2A17-4DE7-82FB-3B20E00C96EC@miegl.cz>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, 2019-08-21 at 23:17 +0200, Josef Miegl wrote:
> On August 21, 2019 10:12:26 PM GMT+02:00, Johannes Berg <johannes@sipsolutions.net> wrote:
> > What AP are you trying to connect to? Have you tried adding some other
> > random vendor IE, with an OUI that the AP is almost certain to not
> > know?
> > Maybe it's actually interpreting this somehow?
> > 
> > Would you be willing to show sniffer captures so we could take a look?
> > 
> > johannes
> 
> Of course it's interpreting the IE. Random vendor IE works fine. 

Ok, that wasn't really clear to me until now.

> Let me explain why I'm even bothering with sending this mikrotik IE in
> association requests. The Mikrotik IE has a flag that tells the AP if
> the station wants WDS. Setting that flag and sending the mikrotik IE
> is required for transparent bridging with a mikrotik AP.

Aha, ok.

> Sending the Mikrotik IE with the WDS bit set to 0 works fine. 

Even more curious :-)

> Now I'm sure this is a problem on Mikrotiks side, however in ubnts
> airos this works as expected, and since their airos is probably based
> on openwrt there has to be a way to make this work.
> 
> I will send you the captures, however there doesn't seem to be
> anything much interesting in them.

Indeed, it seems unlikely I could get anything from that.

Do you have a successful handshake done by a "real" client
implementation?

Perhaps it expects the 4-way-HS to already be in 4-addr frame format, or
something else special in the 4-way-HS if you have WDS?

johannes

