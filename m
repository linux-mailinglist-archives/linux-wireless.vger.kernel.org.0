Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFF222332C5
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Jul 2020 15:13:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727797AbgG3NNp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 30 Jul 2020 09:13:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726794AbgG3NNp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 30 Jul 2020 09:13:45 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F36AC061794
        for <linux-wireless@vger.kernel.org>; Thu, 30 Jul 2020 06:13:45 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1k18NT-00DXak-OV; Thu, 30 Jul 2020 15:13:43 +0200
Message-ID: <7f2722c9d30bb1a4715398b4f29309b1f383593b.camel@sipsolutions.net>
Subject: Re: [PATCH] mac80211: do not iterate active interfaces when in
 re-configure
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Ben Greear <greearb@candelatech.com>,
        linux-wireless@vger.kernel.org
Date:   Thu, 30 Jul 2020 15:13:42 +0200
In-Reply-To: <c53fd2d0-3ffb-3700-f12e-34c1867dded4@candelatech.com>
References: <20200525165317.2269-1-greearb@candelatech.com>
         <a3a6a9303eeaf91f83bcbc413ad0782659218966.camel@sipsolutions.net>
         <c53fd2d0-3ffb-3700-f12e-34c1867dded4@candelatech.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.4 (3.36.4-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, 2020-07-30 at 06:05 -0700, Ben Greear wrote:

> > It might even be that this can only be done subject to driver choice.
> 
> I have tested this patch hard for many years with hundreds of station vifs on ath9k radios and
> 64 station vifs on ath10k radios, probably way harder than anyone else is testing
> this sort of thing.

Yeah, I'm sure!

> Possibly you are correct about iwlwifi, I've never tested it with multi-interface,
> and as you see, have had bad luck on ax200.

Right.

> If you'd accept a patch with a new driver flag check (which I can enable for
> ath10k and ath9k), then I'll respin it thus.

My order of preference would be something like

1. track per vif whether it was re-added, and skip before it is

If that works, I can certainly get behind it for semantic reasons (the
vif isn't yet active again), although even there I'm not sure how
iwlwifi would behave - but that's something I'd look into and perhaps
even consider a bug there since it shouldn't know about that interface
yet.

2. If for some reason that doesn't work, add an iteration flag that
controls this, rather than a per-device config?

johannes

