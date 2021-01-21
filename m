Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CA572FE011
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Jan 2021 04:45:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727067AbhAUDfr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 20 Jan 2021 22:35:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32507 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389277AbhAUBgj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 20 Jan 2021 20:36:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611192896;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=b434st/d4UhGLE71zd3bXRuvYmRlQkOm8SFHO1G+7yM=;
        b=fmbmqY0wAU9aCUA2tKShy81dlmartSnAYFz1jRhe+O/CY5mHLyQx0LLX01bEDzoPLCRuY2
        EoTtiEFA583Sya5oaRy2s0VpQ9+Cifsmmdx/khcBiesBe1Is55gIw6DpQxCChk4wua5d7m
        4ghCH68veD2ODCmcOqZV+PHUcFErGm4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-397-PtBUzNy_NxCS2247KOVU7w-1; Wed, 20 Jan 2021 20:34:52 -0500
X-MC-Unique: PtBUzNy_NxCS2247KOVU7w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9AB661842144;
        Thu, 21 Jan 2021 01:34:50 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.10.110.18])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E0A1D5D74C;
        Thu, 21 Jan 2021 01:34:48 +0000 (UTC)
Message-ID: <82243bc066a12235099639928a271a8fe338668e.camel@redhat.com>
Subject: Re: [PATCH 17/18] net: iosm: readme file
From:   Dan Williams <dcbw@redhat.com>
To:     Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew@lunn.ch>
Cc:     =?ISO-8859-1?Q?Bj=F8rn?= Mork <bjorn@mork.no>,
        M Chetan Kumar <m.chetan.kumar@intel.com>,
        netdev@vger.kernel.org, linux-wireless@vger.kernel.org,
        johannes@sipsolutions.net, krishna.c.sudi@intel.com
Date:   Wed, 20 Jan 2021 19:34:48 -0600
In-Reply-To: <20210120153255.4fcf7e32@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
References: <20210107170523.26531-1-m.chetan.kumar@intel.com>
         <20210107170523.26531-18-m.chetan.kumar@intel.com>
         <X/eJ/rl4U6edWr3i@lunn.ch> <87turftqxt.fsf@miraculix.mork.no>
         <YAiF2/lMGZ0mPUSK@lunn.ch>
         <20210120153255.4fcf7e32@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, 2021-01-20 at 15:32 -0800, Jakub Kicinski wrote:
> On Wed, 20 Jan 2021 20:34:51 +0100 Andrew Lunn wrote:
> > On Sun, Jan 17, 2021 at 06:26:54PM +0100, Bjørn Mork wrote:
> > > I was young and stupid. Now I'm not that young anymore ;-)  
> > 
> > We all make mistakes, when we don't have the knowledge there are
> > other
> > ways. That is partially what code review is about.
> > 
> > > Never ever imagined that this would be replicated in another
> > > driver,
> > > though.  That doesn't really make much sense.  We have learned by
> > > now,
> > > haven't we?  This subject has been discussed a few times in the
> > > past,
> > > and Johannes summary is my understanding as well:
> > > "I don't think anyone likes that"  
> > 
> > So there seems to be agreement there. But what is not clear, is
> > anybody willing to do the work to fix this, and is there enough
> > ROI.
> > 
> > Do we expect more devices like this? Will 6G, 7G modems look very
> > different? 
> 
> Didn't Intel sell its 5G stuff off to Apple?

Yes, but they kept the ability to continue with 3G/4G hardware and
other stuff.

> > Be real network devices and not need any of this odd stuff?
> > Or will they be just be incrementally better but mostly the same?
> > 
> > I went into the review thinking it was an Ethernet driver, and kept
> > having WTF moments. Now i know it is not an Ethernet driver, i can
> > say
> > it is not my domain, i don't know the field well enough to say if
> > all
> > these hacks are acceptable or not.
> > 
> > It probably needs David and Jakub to set the direction to be
> > followed.
> 
> AFAIU all those cellar modems are relatively slow and FW-heavy, so
> the
> ideal solution IMO is not even a common kernel interface but actually
> a common device interface, like NVMe (or virtio for lack of better
> examples).

That was supposed to be MBIM, but unfortunately those involved didn't
iterate and MBIM got stuck. I don't think we'll see a standard as long
as some vendors are dominant and see no need for it.

Dan

