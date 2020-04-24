Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF1931B71FC
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Apr 2020 12:30:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726614AbgDXKaD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 24 Apr 2020 06:30:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726193AbgDXKaC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 24 Apr 2020 06:30:02 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2A9DC09B045
        for <linux-wireless@vger.kernel.org>; Fri, 24 Apr 2020 03:30:02 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1jRvap-00FSyW-6U; Fri, 24 Apr 2020 12:30:00 +0200
Message-ID: <0ae5ad298361f94c58d21233a4aea6f5a18e9522.camel@sipsolutions.net>
Subject: Re: [RFC PATCH 0/4] cfg80211: updates and fixes for TID specific
 configuration
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>
Cc:     linux-wireless@vger.kernel.org,
        Tamizh Chelvam <tamizhr@codeaurora.org>
Date:   Fri, 24 Apr 2020 12:29:57 +0200
In-Reply-To: <20200424102636.lua5qdeaw2fkl7kn@bars>
References: <20200420113437.16998-1-sergey.matyukevich.os@quantenna.com>
         <db1081861ba7e7ee334c3e50494ff3cd34d9963d.camel@sipsolutions.net>
         <20200424102636.lua5qdeaw2fkl7kn@bars>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, 2020-04-24 at 13:26 +0300, Sergey Matyukevich wrote:
> > > This patch series contains several minor fixes and enhancements for TID
> > > specific configuration functionality. The first three patches include
> > > minor fixes and TID specific AMSDU configuration.
> > 
> > Looks good, though I just saw you noticed a small bug :)
> > 
> > > The last patch is somewhat controversial, so the series is marked as RFC.
> > > The last patch simplifies current override logic. It suggests to make no
> > > difference between 'specific peer' and 'all peers' cases and to apply
> > > new TID configuration immediately after resetting the previous one.
> > 
> > Yeah, I tend to agree.
> > 
> > Can you resend with the small fix?
> 
> Sure, will do. Is it ok if I add a patch supporting this feature in iw tool ?
> Or you would prefer to review it separately after this series lands in
> mac80211-next ?

That's fine. Not sure how you could possibly send them in the same
series with git, but go ahead :)

FWIW, I will always ignore nl80211.h update patches, I do those myself,
so no need to send that.

johannes

