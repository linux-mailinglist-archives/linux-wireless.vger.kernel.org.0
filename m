Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 16D25A342C
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Aug 2019 11:40:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727729AbfH3JkH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 30 Aug 2019 05:40:07 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:33772 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726480AbfH3JkG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 30 Aug 2019 05:40:06 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92.1)
        (envelope-from <johannes@sipsolutions.net>)
        id 1i3dO1-0002r9-7W; Fri, 30 Aug 2019 11:40:05 +0200
Message-ID: <ec3b9fd84fb8c5d333445d872bb0f864a4655a6b.camel@sipsolutions.net>
Subject: Re: [RFCv2 1/4] nl80211: Fix broken non-split wiphy dumps
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Denis Kenzior <denkenz@gmail.com>, linux-wireless@vger.kernel.org
Date:   Fri, 30 Aug 2019 11:40:04 +0200
In-Reply-To: <00161d6069cda67dbd8b918dd987e01dc1a3dab3.camel@sipsolutions.net> (sfid-20190830_111018_535326_C90DC0EB)
References: <20190816192703.12445-1-denkenz@gmail.com>
         (sfid-20190816_212729_636741_39C4CEB6) <f7c98da178677cbb0cad3568f4ea4ab85171edd8.camel@sipsolutions.net>
         (sfid-20190830_110356_499003_5F22B3F6) <00161d6069cda67dbd8b918dd987e01dc1a3dab3.camel@sipsolutions.net>
         (sfid-20190830_111018_535326_C90DC0EB)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, 2019-08-30 at 11:10 +0200, Johannes Berg wrote:
> On Fri, 2019-08-30 at 11:03 +0200, Johannes Berg wrote:
> > On Fri, 2019-08-16 at 14:27 -0500, Denis Kenzior wrote:
> > > If a (legacy) client requested a wiphy dump but did not provide the
> > > NL80211_ATTR_SPLIT_WIPHY_DUMP attribute, the dump was supposed to be
> > > composed of purely non-split NEW_WIPHY messages, with 1 wiphy per
> > > message.  At least this was the intent after commit:
> > > 3713b4e364ef ("nl80211: allow splitting wiphy information in dumps")
> > > 
> > > However, in reality the non-split dumps were broken very shortly after.
> > > Perhaps around commit:
> > > fe1abafd942f ("nl80211: re-add channel width and extended capa advertising")
> > 
> > Fun. I guess we updated all userspace quickly enough to not actually
> > have any issues there. As far as I remember, nobody ever complained, so
> > I guess people just updated their userspace.
> 
> Actually, going back in time to the code there (e.g. iw and hostap), it
> seems that it quite possibly never was a userspace issue, just an issue
> with netlink allocating a 4k SKB by default for dumps.
> 
> Even then, libnl would've defaulted to a 16k recvmsg() buffer size, and
> we didn't override that anywhere.

Ah, also not quite true, at the time it still had a 4k default, until
commit 807fddc4cd9e ("nl: Increase receive buffer size to 4 pages")
dated May 8, 2013.

johannes

