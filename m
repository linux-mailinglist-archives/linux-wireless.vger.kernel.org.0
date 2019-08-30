Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EDE3BA3354
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Aug 2019 11:03:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727234AbfH3JDy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 30 Aug 2019 05:03:54 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:33232 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725780AbfH3JDx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 30 Aug 2019 05:03:53 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92.1)
        (envelope-from <johannes@sipsolutions.net>)
        id 1i3cox-00026D-St; Fri, 30 Aug 2019 11:03:51 +0200
Message-ID: <f7c98da178677cbb0cad3568f4ea4ab85171edd8.camel@sipsolutions.net>
Subject: Re: [RFCv2 1/4] nl80211: Fix broken non-split wiphy dumps
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Denis Kenzior <denkenz@gmail.com>, linux-wireless@vger.kernel.org
Date:   Fri, 30 Aug 2019 11:03:51 +0200
In-Reply-To: <20190816192703.12445-1-denkenz@gmail.com> (sfid-20190816_212729_636741_39C4CEB6)
References: <20190816192703.12445-1-denkenz@gmail.com>
         (sfid-20190816_212729_636741_39C4CEB6)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, 2019-08-16 at 14:27 -0500, Denis Kenzior wrote:
> If a (legacy) client requested a wiphy dump but did not provide the
> NL80211_ATTR_SPLIT_WIPHY_DUMP attribute, the dump was supposed to be
> composed of purely non-split NEW_WIPHY messages, with 1 wiphy per
> message.  At least this was the intent after commit:
> 3713b4e364ef ("nl80211: allow splitting wiphy information in dumps")
> 
> However, in reality the non-split dumps were broken very shortly after.
> Perhaps around commit:
> fe1abafd942f ("nl80211: re-add channel width and extended capa advertising")

Fun. I guess we updated all userspace quickly enough to not actually
have any issues there. As far as I remember, nobody ever complained, so
I guess people just updated their userspace.

Given that it's been 6+ years, maybe we're better off just removing the
whole non-split thing then, instead of fixing it. Seems even less likely
now that somebody would run a 6+yo supplicant (from before its commit
c30a4ab045ce ("nl80211: Fix mode settings with split wiphy dump")).

OTOH, this is a simple fix, would removing the non-split mode result in
any appreciable cleanups? Perhaps not, and we'd have to insert something
instead to reject non-split and log a warning, or whatnot.

johannes

