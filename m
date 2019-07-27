Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6AA6377B23
	for <lists+linux-wireless@lfdr.de>; Sat, 27 Jul 2019 20:41:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387890AbfG0Slc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 27 Jul 2019 14:41:32 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:50626 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387880AbfG0Slc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 27 Jul 2019 14:41:32 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <johannes@sipsolutions.net>)
        id 1hrRdJ-0007ZO-W6; Sat, 27 Jul 2019 20:41:30 +0200
Message-ID: <8b13bfffccf363b565d00f51ce7d735f62a57135.camel@sipsolutions.net>
Subject: Re: [PATCH] cfg80211: use parallel_ops for genl
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Denis Kenzior <denkenz@gmail.com>, linux-wireless@vger.kernel.org
Date:   Sat, 27 Jul 2019 20:41:27 +0200
In-Reply-To: <fe8ef214-5d02-da36-2680-6df3c683c154@gmail.com> (sfid-20190727_173339_760130_162AF66A)
References: <20190726191621.5031-1-johannes@sipsolutions.net>
         <fe8ef214-5d02-da36-2680-6df3c683c154@gmail.com>
         (sfid-20190727_173339_760130_162AF66A)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Denis,

(huh, why did your mail make it to my inbox 3 hours ago ...? oh well)

> > +		kfree(attrbuf);
> > +		if (IS_ERR(*wdev)) {
> > +			kfree(attrbuf);
> 
> Hmm, you just freed attrbuf above?

Good catch.

I was being stupid, wrote the patch on one machine, then tested & fixed
it on another, and then sent out the original ...

> >   	if (!attrbuf[NL80211_ATTR_VENDOR_ID] ||
> > -	    !attrbuf[NL80211_ATTR_VENDOR_SUBCMD])
> > -		return -EINVAL;
> > +	    !attrbuf[NL80211_ATTR_VENDOR_SUBCMD]) {
> > +		err = -EINVAL;
> > +		goto out;
> > +	}
> 
> Might be nicer to just set err = -EINVAL before the if instead of using 
> {} here

Dunno. I don't generally like the values "leaking" out of where they're
intended, tends to hide compiler warnings when you forget to assign or
something ... I guess doing -EINVAL at least would fail safely :-)

I'll revise this then.

johannes

