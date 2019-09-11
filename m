Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C767AAF84A
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Sep 2019 10:53:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726889AbfIKIxQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 11 Sep 2019 04:53:16 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:33708 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726579AbfIKIxQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 11 Sep 2019 04:53:16 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <johannes@sipsolutions.net>)
        id 1i7yNG-0001tn-MX; Wed, 11 Sep 2019 10:53:14 +0200
Message-ID: <7a089d5ec94da92fc0c1255a2afa6ae0d8b8aaa4.camel@sipsolutions.net>
Subject: Re: [PATCH] nl80211: Support mgmt frame unregistrations
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Denis Kenzior <denkenz@gmail.com>, linux-wireless@vger.kernel.org
Date:   Wed, 11 Sep 2019 10:53:13 +0200
In-Reply-To: <20190904162239.2075-1-denkenz@gmail.com> (sfid-20190904_195856_475903_CA5D028C)
References: <20190904162239.2075-1-denkenz@gmail.com>
         (sfid-20190904_195856_475903_CA5D028C)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, 2019-09-04 at 11:22 -0500, Denis Kenzior wrote:
> To state another way, it is
> currently not possible to write a userspace application that utilizes a
> single nl80211 genl socket, instead it must open multiple genl sockets
> for multiple wdevs on multiple phys.

I don't see how this is too onerous for the application, every
application is basically going to have an event loop anyway.

Thus, I don't really see any reason for us to add a bunch of code just
to make an application track fewer file descriptors - we need to have
the cleanup on close already anyway, so why not actually exercise those
code paths?

I do note that with the "unregister on iftype change" patch you could
switch to an unsupported type and reach this, but I don't think you'd
want to rely on that :-)

Possibly I could imagine a reason for this if you needed a single socket
for functional reason, but you're not really giving any such reason. I
could imagine that there might be races, but I'm having a hard time
coming up with a scenario where they actually matter ... if you really
really get a race between e.g. RX-AUTH and INTERFACE-DEL you'll try to
do some operations that will just fail, but so what?

johannes

