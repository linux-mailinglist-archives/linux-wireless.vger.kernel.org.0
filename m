Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 26CC970073
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Jul 2019 15:02:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729895AbfGVNCR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 22 Jul 2019 09:02:17 -0400
Received: from muru.com ([72.249.23.125]:55500 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727594AbfGVNCR (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 22 Jul 2019 09:02:17 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 5709980FA;
        Mon, 22 Jul 2019 13:02:42 +0000 (UTC)
Date:   Mon, 22 Jul 2019 06:02:13 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        Eyal Reizer <eyalreizer@gmail.com>,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org
Subject: Re: nl80211 wlcore regression in next
Message-ID: <20190722130213.GN5447@atomide.com>
References: <20190625073837.GG5447@atomide.com>
 <2570f4087d6e3356df34635a0380ec8ce06c9159.camel@sipsolutions.net>
 <20190625080019.GH5447@atomide.com>
 <7f74087fef1e554e0aeb82a6cec4113727487928.camel@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7f74087fef1e554e0aeb82a6cec4113727487928.camel@sipsolutions.net>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

* Johannes Berg <johannes@sipsolutions.net> [190625 08:03]:
> On Tue, 2019-06-25 at 01:00 -0700, Tony Lindgren wrote:
> > Hi,
> > 
> > * Johannes Berg <johannes@sipsolutions.net> [190625 07:47]:
> > > On Tue, 2019-06-25 at 00:38 -0700, Tony Lindgren wrote:
> > > > Hi,
> > > > 
> > > > Looks like at least drivers/net/wireless/ti wlcore driver has stopped
> > > > working in Linux next with commit 901bb9891855 ("nl80211: require and
> > > > validate vendor command policy"). Reverting the commit above makes it
> > > > work again.
> > > > 
> > > > It fails with the warning below, any ideas what goes wrong?
> > > 
> > > Oops. For some reason, I neglected to check the vendor command usage
> > > beyond hwsim.
> > > 
> > > The patch below should work?
> > 
> > Yeah thanks that fixes the issue for me:
> > 
> > Tested-by: Tony Lindgren <tony@atomide.com>
> 
> Thanks, I'll drop that into my tree and hopefully will remember to send
> it on soon.

Looks like this one crept back as the fix is missing from v5.3-rc1.

Forgot to include in the pull request?

Regards,

Tony
