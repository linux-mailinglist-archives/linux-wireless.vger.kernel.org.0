Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A060F5239
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Nov 2019 18:07:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727412AbfKHRHo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 8 Nov 2019 12:07:44 -0500
Received: from s3.sipsolutions.net ([144.76.43.62]:36312 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726095AbfKHRHn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 8 Nov 2019 12:07:43 -0500
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92.3)
        (envelope-from <johannes@sipsolutions.net>)
        id 1iT7jW-0007xb-J0; Fri, 08 Nov 2019 18:07:38 +0100
Message-ID: <c95e9e9f5539150459f97f811b784a6e9af163cf.camel@sipsolutions.net>
Subject: Re: [PATCHv8 0/6] cfg80211/mac80211: Add support for TID specific
 configuration
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>
Cc:     Tamizh chelvam <tamizhr@codeaurora.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Date:   Fri, 08 Nov 2019 18:07:34 +0100
In-Reply-To: <20191108160121.tbatmqwx64aoqqai@bars>
References: <1572957714-16085-1-git-send-email-tamizhr@codeaurora.org>
         <20191108093207.uv4j44xpm2qvtsv5@bars>
         <84ca3a8b61757360ab9898afcdd3f2f63c770f86.camel@sipsolutions.net>
         <20191108120504.ptl25hacxcftb7tw@bars>
         <1c553c457024b295c7d0a6b118c3848eec28bcbd.camel@sipsolutions.net>
         <20191108160121.tbatmqwx64aoqqai@bars>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, 2019-11-08 at 16:01 +0000, Sergey Matyukevich wrote:

> > I think we still need NL80211_TID_CONFIG_ATTR_OVERRIDE in some way
> > (maybe only as a flag attribute), since you could have
> > 
> >  * change all stations (some subset of TIDs) *including* already
> >    configured stations
> >  * or *excluding* already configured stations
> 
> Hmmm... Logic is straightforwad without this flag:
> - settings are applied to bitmasked TIDs of a single peer if address is specifed
> - settings are applied to bitmasked TIDs of all the peers if no address is specified

Sure, this is obvious, but what exactly does "all the peers" mean?

Say I do

set_tid_config(tids=0x1, peer=02:11:22:33:44:55, noack=yes)
set_tid_config(tids=0x1, peer=NULL, noack=no)

Does that reset peer 02:11:22:33:44:55, or not? This is not documented
right now, and one could argue both ways - the override for that
particular peer should stick, or should be removed. Which one is it?

> It looks like you want to infer too much from a single flag. Why keep this logic in
> cfg80211/mac80211/driver ?

I just want to disambiguate what "all the peers" means. Not sure what
you mean by keeping the logic?

johannes

