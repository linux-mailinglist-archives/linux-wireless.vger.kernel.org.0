Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE29CAFFAE
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Sep 2019 17:12:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728367AbfIKPMP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 11 Sep 2019 11:12:15 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:42796 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727576AbfIKPMP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 11 Sep 2019 11:12:15 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <johannes@sipsolutions.net>)
        id 1i84I0-0002dk-Os; Wed, 11 Sep 2019 17:12:12 +0200
Message-ID: <0b12af1b27954f62a5ce715f95176d1f0ff393a3.camel@sipsolutions.net>
Subject: Re: [RFCv3 3/3] nl80211: Send large new_wiphy events
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Denis Kenzior <denkenz@gmail.com>, linux-wireless@vger.kernel.org
Date:   Wed, 11 Sep 2019 17:12:11 +0200
In-Reply-To: <f48bdad3-f9f8-20b7-b6ff-6248368a7ae1@gmail.com> (sfid-20190911_161324_913292_899186EF)
References: <20190906154303.9303-1-denkenz@gmail.com>
         <20190906154303.9303-3-denkenz@gmail.com>
         <127c19b1855302a467a1bdbf2f25f625a0254d9e.camel@sipsolutions.net>
         <f48bdad3-f9f8-20b7-b6ff-6248368a7ae1@gmail.com>
         (sfid-20190911_161324_913292_899186EF)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, 2019-09-11 at 07:20 -0500, Denis Kenzior wrote:

> > I'm not sure I see how the applications could do buffers that are
> > "inherently" large enough, there's no practical message size limit, is
> > there (32-bits for the size).
> 
> The kernel caps this to 32k right now if I read the code correctly.  But 
> fair point.

The kernel caps this for dumps only, no? We can allocate here ourselves
for multicasting a message as large as we like I think.

> > > +	if (WARN_ON(nl80211_send_wiphy(rdev, cmd, msg, 0, 0, 0, &state) < 0)) {
> > > +		nlmsg_free(msg);
> > > +		goto legacy;
> > > +	}
> > > +
> > > +	genlmsg_multicast_netns(&nl80211_fam, wiphy_net(&rdev->wiphy), msg, 0,
> > > +				NL80211_MCGRP_CONFIG2, GFP_KERNEL);
> > > +
> > > +legacy:
> > 
> > nit: just use "else" instead of the goto?
> 
> I'm not sure I understand?  We want to send both messages here...

It's equivalent to:

-----
if (WARN_ON(nl80211_send_wiphy(...) < 0)
   nlmsg_free(msg);
else
   genlmsg_multicast_netns(...);

... code for legacy ...
-----

no?

johannes

