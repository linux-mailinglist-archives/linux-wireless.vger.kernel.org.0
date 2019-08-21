Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B1D09854D
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Aug 2019 22:13:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727316AbfHUUMd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 21 Aug 2019 16:12:33 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:45472 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726330AbfHUUMd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 21 Aug 2019 16:12:33 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <johannes@sipsolutions.net>)
        id 1i0Wy6-0004YW-Nc; Wed, 21 Aug 2019 22:12:31 +0200
Message-ID: <6efb9b56c77cd9ea945f89c3371b49c301dc2b4e.camel@sipsolutions.net>
Subject: Re: Implementing Mikrotik IE
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Josef Miegl <josef@miegl.cz>
Cc:     Sebastian Gottschall <s.gottschall@newmedia-net.de>,
        linux-wireless <linux-wireless@vger.kernel.org>
Date:   Wed, 21 Aug 2019 22:12:26 +0200
In-Reply-To: <A3C14EA9-BA2D-4745-BBB9-E10028B6DE13@miegl.cz>
References: <20190815152844.k5mmddvbwrohkzr6@pepin-laptop.localdomain>
         <3a079683-6f57-3b42-f909-90c46e14f14f@newmedia-net.de>
         <20190816111044.4ntizgmpa3twbzcg@pepin-laptop.localdomain>
         <e8129acb-fc32-c85c-b504-ab8777a3f1a3@newmedia-net.de>
         <20190816113818.ohktykc4fyetzyvq@pepin-laptop.localdomain>
         <9985fddfb059640f36665efc9c1ef2dc0bdb7662.camel@sipsolutions.net>
         <20190819113706.ujsz67sxcwt2ulmt@pepin-laptop.localdomain>
         <b3b7a99971f1512b4cd9c72920b699c252c1ae83.camel@sipsolutions.net>
         <A3C14EA9-BA2D-4745-BBB9-E10028B6DE13@miegl.cz>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, 2019-08-21 at 22:04 +0200, Josef Miegl wrote:
> 
> The vendor elements are added at the very end of the frame. In fact I
> tried moving the RSN IE to the end of the frame so that the frame is
> similar to the one ubnt airos produces. No luck either. One thing I've
> learned is that ubnt airos assoc req frames have the WMM/WME IE placed
> before HT Capabilities. But I'm not sure how to move it and also not
> sure if it would actually work.
> 
> I am getting 4WAY_HANDSHAKE_TIMEOUT. From capturing I can see the
> station sends Key (msg 2 of 4) and a bunch of acknowledgements, but it
> never sends Key (msg 4 of 4) afterwards.
> 
> I feel like I'm stuck.. What could be the reason for this behaviour?

What AP are you trying to connect to? Have you tried adding some other
random vendor IE, with an OUI that the AP is almost certain to not know?
Maybe it's actually interpreting this somehow?

Would you be willing to show sniffer captures so we could take a look?

johannes

