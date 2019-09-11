Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9BD92AF962
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Sep 2019 11:47:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbfIKJr4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 11 Sep 2019 05:47:56 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:34724 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726579AbfIKJr4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 11 Sep 2019 05:47:56 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <johannes@sipsolutions.net>)
        id 1i7zEA-00039c-CF; Wed, 11 Sep 2019 11:47:54 +0200
Message-ID: <127c19b1855302a467a1bdbf2f25f625a0254d9e.camel@sipsolutions.net>
Subject: Re: [RFCv3 3/3] nl80211: Send large new_wiphy events
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Denis Kenzior <denkenz@gmail.com>, linux-wireless@vger.kernel.org
Date:   Wed, 11 Sep 2019 11:47:53 +0200
In-Reply-To: <20190906154303.9303-3-denkenz@gmail.com> (sfid-20190906_174917_479938_EE3E136C)
References: <20190906154303.9303-1-denkenz@gmail.com>
         <20190906154303.9303-3-denkenz@gmail.com>
         (sfid-20190906_174917_479938_EE3E136C)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, 2019-09-06 at 10:43 -0500, Denis Kenzior wrote:
> 
> + *	There are no limits (outside of netlink protocol limits) on
> + *	message sizes that can be sent over the "config2" multicast group. It
> + *	is assumed that applications utilizing "config2" multicast group
> + *	utilize buffers that are inherently large enough or can utilize
> + *	MSG_PEEK/MSG_TRUNC in the netlink transport in order to allocate big
> + *	enough buffers.

I'm not sure I see how the applications could do buffers that are
"inherently" large enough, there's no practical message size limit, is
there (32-bits for the size).

I'd argue this should just say that applications should use large
buffers and still use MSG_PEEK/handle MSG_TRUNC, but I can also edit it
later.

> +	msg = nlmsg_new(alloc_size, GFP_KERNEL);
> +	if (!msg)
> +		goto legacy;
> +
> +	if (WARN_ON(nl80211_send_wiphy(rdev, cmd, msg, 0, 0, 0, &state) < 0)) {
> +		nlmsg_free(msg);
> +		goto legacy;
> +	}
> +
> +	genlmsg_multicast_netns(&nl80211_fam, wiphy_net(&rdev->wiphy), msg, 0,
> +				NL80211_MCGRP_CONFIG2, GFP_KERNEL);
> +
> +legacy:

nit: just use "else" instead of the goto?

johannes

