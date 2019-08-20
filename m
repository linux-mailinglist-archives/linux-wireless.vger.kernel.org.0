Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B6842969F6
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Aug 2019 22:06:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730744AbfHTUGp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 20 Aug 2019 16:06:45 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:42816 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730618AbfHTUGp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 20 Aug 2019 16:06:45 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <johannes@sipsolutions.net>)
        id 1i0AOw-0007QV-W7; Tue, 20 Aug 2019 22:06:43 +0200
Message-ID: <eb4b7894434dc1e194b88f4bd1bf0b2476700a2c.camel@sipsolutions.net>
Subject: Re: [RFC 0/1] Allow MAC change on up interface
From:   Johannes Berg <johannes@sipsolutions.net>
To:     James Prestwood <prestwoj@gmail.com>,
        linux-wireless@vger.kernel.org
Date:   Tue, 20 Aug 2019 22:06:41 +0200
In-Reply-To: <661903fa345563615cb781a6d9608607a3db963d.camel@gmail.com> (sfid-20190820_215350_076033_9D62468D)
References: <20190815185702.30937-1-prestwoj@gmail.com>
         (sfid-20190815_205833_978900_86B1E73D) <645af7dad899e8eb186b3fee0f8a8a151a408557.camel@sipsolutions.net>
         <394092a2f20697c9b055166a8254a5ef888551a5.camel@gmail.com>
         (sfid-20190819_175627_344053_E33FB9B0) <4848c3a9d0b330fab4442436244387a2c127fa03.camel@sipsolutions.net>
         <c6b719d6279211bbf52443f327884d96ef63f2b2.camel@gmail.com>
         (sfid-20190819_231529_805133_AD4E6DEE) <6835732fcc59ba8dbbcda4abc6e17dad499a7d8d.camel@sipsolutions.net>
         <661903fa345563615cb781a6d9608607a3db963d.camel@gmail.com>
         (sfid-20190820_215350_076033_9D62468D)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, 2019-08-20 at 15:53 -0400, James Prestwood wrote:

> > I thought so, but I had another thought later. It might be possible
> > to
> > set LIVE_ADDR_CHANGE, but then block it in mac80211 when the
> > interface
> > is already connected (or beaconing, or whatever, using the MAC
> > address
> > in some way - even while scanning, remain-on-channel is active, etc.)
> 
> Yeah that makes sense.
> 
> > I still think you'd have to bake it into the mac80211<->driver API
> > somehow, because we normally "add_interface()" with the MAC address,
> > and
> > nothing says that the driver cannot ignore the MAC address from that
> > point on. The fact that iwlwifi just copies it into every new
> > MAC_CTXT
> > command and the firmware actually accepts the update seems rather
> > accidental and therefore fragile to rely on.
> 
> I havent looked into the actual drivers WRT add_interface so I'll take
> a look. But I think I see the separation now and why it may not work
> for all drivers/firmwares the way I did it.
> 
> So are you thinking we need another driver method:
> "change_mac/set_mac"?

Perhaps. Let's continue that in the other sub-thread, where I replied in
more detail to Denis.

johannes

