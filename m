Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F16E13BD65
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Jan 2020 11:28:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729714AbgAOK2w (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 15 Jan 2020 05:28:52 -0500
Received: from s3.sipsolutions.net ([144.76.43.62]:38972 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729657AbgAOK2v (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 15 Jan 2020 05:28:51 -0500
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1irfup-008ops-SR; Wed, 15 Jan 2020 11:28:47 +0100
Message-ID: <2244739a6198d56e8f3a81aaa561a0ed1f2e4a25.camel@sipsolutions.net>
Subject: Re: [PATCH] subsystem: Fix radar event during another phy CAC
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Kalle Valo <kvalo@codeaurora.org>,
        Orr Mazor <orr.mazor@tandemg.com>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Date:   Wed, 15 Jan 2020 11:28:46 +0100
In-Reply-To: <87d0bl1822.fsf@tynnyri.adurom.net>
References: <20191222145449.15792-1-Orr.Mazor@tandemg.com>
         <87d0bl1822.fsf@tynnyri.adurom.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.2 (3.34.2-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, 2020-01-15 at 09:40 +0200, Kalle Valo wrote:
> Orr Mazor <orr.mazor@tandemg.com> writes:
> 
> > In case a radar event of CAC_FINISHED or RADAR_DETECTED
> > happens during another phy is during CAC we might need
> > to cancel that CAC.
> > If we got a radar in a channel that another phy is now
> > doing CAC on then the CAC should be canceled.
> > If, for example, 2 phys doing CAC on the same channels,
> > or on comptable channels, once on of them will finish his CAC
> > the other might need to cancel his CAC, since it is no
> > longer relevant.
> > 
> > To fix that the commit adds an callback and implement it in mac80211
> > to end CAC.
> > This commit also adds a call to said callback if after a radar
> > event we see the cac is no longer relevant
> > 
> > Signed-off-by: Orr Mazor <Orr.Mazor@tandemg.com>
> 
> The title prefix should be "cfg80211: ", not "subsystem: ".

Yeah, but I fixed it when I just applied it :)

johannes

