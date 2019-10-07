Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D2AF1CEE3D
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Oct 2019 23:16:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728723AbfJGVQX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 7 Oct 2019 17:16:23 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:46922 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728330AbfJGVQX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 7 Oct 2019 17:16:23 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92.2)
        (envelope-from <johannes@sipsolutions.net>)
        id 1iHaMf-0001nD-Mv; Mon, 07 Oct 2019 23:16:21 +0200
Message-ID: <f468a8d573ddf401d2084b76eb625fef5950f265.camel@sipsolutions.net>
Subject: Re: [PATCH 2/2] mac80211: Support LIVE_ADDRESS_CHANGE feature
From:   Johannes Berg <johannes@sipsolutions.net>
To:     James Prestwood <prestwoj@gmail.com>,
        linux-wireless@vger.kernel.org
Date:   Mon, 07 Oct 2019 23:16:20 +0200
In-Reply-To: <0b57c1288016310050ccd6233dda886fc4a89b02.camel@gmail.com> (sfid-20191004_184518_081867_8D6E941B)
References: <20190913195908.7871-1-prestwoj@gmail.com>
         <20190913195908.7871-2-prestwoj@gmail.com>
         (sfid-20190913_220113_985031_7C3A66BD) <c6835b5c5d2a97fa82b0fb21f7b7f0056aa42e1b.camel@sipsolutions.net>
         <90ae00044bc0834d87d3f9fb75ce63dce4cfadd5.camel@gmail.com>
         <0b57c1288016310050ccd6233dda886fc4a89b02.camel@gmail.com>
         (sfid-20191004_184518_081867_8D6E941B)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

> > > If you do care about this being more granular then you should check
> > > *which* interface is scanning, and then you can still switch the
> > > MAC
> > > address for *other* interfaces - but I'd still argue it should be
> > > independent of interface type.
> 
> So yes these can scan, but this should be covered by the
> netif_carrier_ok check which is done first.

Not sure what you mean by that.

You could have two interfaces, one which is scanning right now, right?
And then theoretically you don't care about the other one - it *should*
be OK to remove/re-add (with new MAC address) the one that *isn't*
scanning, right?

But we don't have that granularity here for anything - you're just
checking "sdata->local->something", and by going from sdata to local
you've now checked the whole NIC, not just a single interface on that
NIC.

Which is fine, no complaint from me, just in that case you end up
failing when really there isn't much need to fail. In fact, in a case
like this, actually clearing IFF_UP, changing address and setting IFF_UP
would work, concurrently with another interface scanning.

>  We can just remove the
> switch entirely, but the roc_list/scanning check only matters for
> station/p2p_client so checking for the other interface types is kinda
> pointless and redundant.

But it's also completely confusing to do it this way because you go from
"sdata" to "local", and at that point the data that you're working on is
no longer specific to that one interface, it's actually for the whole
NIC.

Basically what I'm saying is this: it's confusing and makes no sense to
do something like

	if (this_is_a_certain_netdev_type)
		check_some_global_data();

> Also I am not sure what you mean by *which* interface. This function is
> called on a single interface, so checking what other interfaces are
> doing seems strange...

My point exactly - but that's what you're doing here in the code. Now I
think perhaps without even realizing?

johannes

