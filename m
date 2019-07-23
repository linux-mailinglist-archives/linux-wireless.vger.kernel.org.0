Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 598B27120D
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jul 2019 08:43:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387943AbfGWGnq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 23 Jul 2019 02:43:46 -0400
Received: from muru.com ([72.249.23.125]:55566 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727845AbfGWGnp (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 23 Jul 2019 02:43:45 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id C9F0C808C;
        Tue, 23 Jul 2019 06:44:10 +0000 (UTC)
Date:   Mon, 22 Jul 2019 23:43:42 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        Eyal Reizer <eyalreizer@gmail.com>,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org
Subject: Re: nl80211 wlcore regression in next
Message-ID: <20190723064342.GQ5447@atomide.com>
References: <20190625073837.GG5447@atomide.com>
 <2570f4087d6e3356df34635a0380ec8ce06c9159.camel@sipsolutions.net>
 <20190625080019.GH5447@atomide.com>
 <7f74087fef1e554e0aeb82a6cec4113727487928.camel@sipsolutions.net>
 <20190722130213.GN5447@atomide.com>
 <262fc08905febd29f9abd0870dbe674fcc5bfb3e.camel@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <262fc08905febd29f9abd0870dbe674fcc5bfb3e.camel@sipsolutions.net>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

* Johannes Berg <johannes@sipsolutions.net> [190723 05:08]:
> Hi,
> 
> > Looks like this one crept back as the fix is missing from v5.3-rc1.
> > 
> > Forgot to include in the pull request?
> 
> More like forgot to send the pull request, my bad. I eventually realized
> a couple of days ago and it'll be coming upstream soon. Sorry about
> that.

OK thanks,

Tony
