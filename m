Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 03E44525D8
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Jun 2019 10:03:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727446AbfFYIDE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 25 Jun 2019 04:03:04 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:53578 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726419AbfFYIDE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 25 Jun 2019 04:03:04 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <johannes@sipsolutions.net>)
        id 1hfgPs-0003fI-0C; Tue, 25 Jun 2019 10:03:00 +0200
Message-ID: <7f74087fef1e554e0aeb82a6cec4113727487928.camel@sipsolutions.net>
Subject: Re: nl80211 wlcore regression in next
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        Eyal Reizer <eyalreizer@gmail.com>,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org
Date:   Tue, 25 Jun 2019 10:02:59 +0200
In-Reply-To: <20190625080019.GH5447@atomide.com>
References: <20190625073837.GG5447@atomide.com>
         <2570f4087d6e3356df34635a0380ec8ce06c9159.camel@sipsolutions.net>
         <20190625080019.GH5447@atomide.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-3.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, 2019-06-25 at 01:00 -0700, Tony Lindgren wrote:
> Hi,
> 
> * Johannes Berg <johannes@sipsolutions.net> [190625 07:47]:
> > On Tue, 2019-06-25 at 00:38 -0700, Tony Lindgren wrote:
> > > Hi,
> > > 
> > > Looks like at least drivers/net/wireless/ti wlcore driver has stopped
> > > working in Linux next with commit 901bb9891855 ("nl80211: require and
> > > validate vendor command policy"). Reverting the commit above makes it
> > > work again.
> > > 
> > > It fails with the warning below, any ideas what goes wrong?
> > 
> > Oops. For some reason, I neglected to check the vendor command usage
> > beyond hwsim.
> > 
> > The patch below should work?
> 
> Yeah thanks that fixes the issue for me:
> 
> Tested-by: Tony Lindgren <tony@atomide.com>

Thanks, I'll drop that into my tree and hopefully will remember to send
it on soon.

johannes

