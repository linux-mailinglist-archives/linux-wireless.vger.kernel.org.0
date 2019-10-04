Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B8289CB98F
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Oct 2019 13:56:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729379AbfJDL4z (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 4 Oct 2019 07:56:55 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:38776 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726002AbfJDL4z (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 4 Oct 2019 07:56:55 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92.2)
        (envelope-from <johannes@sipsolutions.net>)
        id 1iGMCb-00079s-Od; Fri, 04 Oct 2019 13:56:53 +0200
Message-ID: <c6835b5c5d2a97fa82b0fb21f7b7f0056aa42e1b.camel@sipsolutions.net>
Subject: Re: [PATCH 2/2] mac80211: Support LIVE_ADDRESS_CHANGE feature
From:   Johannes Berg <johannes@sipsolutions.net>
To:     James Prestwood <prestwoj@gmail.com>,
        linux-wireless@vger.kernel.org
Date:   Fri, 04 Oct 2019 13:56:52 +0200
In-Reply-To: <20190913195908.7871-2-prestwoj@gmail.com> (sfid-20190913_220113_985031_7C3A66BD)
References: <20190913195908.7871-1-prestwoj@gmail.com>
         <20190913195908.7871-2-prestwoj@gmail.com>
         (sfid-20190913_220113_985031_7C3A66BD)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

I was tempted to apply this (sans the feature advertisement part that I
don't think should be in nl80211), but:

> 
> Signed-off-by: James Prestwood <prestwoj@gmail.com>

Please add a commit log.

> +static int ieee80211_can_live_addr_change(struct ieee80211_sub_if_data *sdata)
> +{
> +	if (netif_carrier_ok(sdata->dev))
> +		return -EBUSY;
> +
> +	switch (sdata->vif.type) {
> +	case NL80211_IFTYPE_AP:
> +	case NL80211_IFTYPE_P2P_GO:
> +	case NL80211_IFTYPE_AP_VLAN:
> +	case NL80211_IFTYPE_WDS:
> +	case NL80211_IFTYPE_MESH_POINT:
> +	case NL80211_IFTYPE_MONITOR:
> +	case NL80211_IFTYPE_OCB:
> +		/* No further checking required, when started or UP these
> +		 * interface types set carrier
> +		 */
> +		break;
> +	case NL80211_IFTYPE_ADHOC:
> +		if (sdata->u.ibss.ssid_len != 0)
> +			return -EBUSY;

Can you please document why this is there? Maybe all of the conditions,
for that matter.

I'm not even entirely sure it _is_ needed - if we've still not created
the IBSS but are scanning for it or trying to merge the MAC address
won't really matter yet? Probably?

> +		break;
> +	case NL80211_IFTYPE_STATION:
> +	case NL80211_IFTYPE_P2P_CLIENT:
> +		if (!list_empty(&sdata->local->roc_list) ||
> +					!sdata->local->scanning)
> +			return -EBUSY;

AP, mesh and other interfaces *can* scan, so that test should be pulled
out to be generic - but then in fact all of them should probably be
generic - ROC maybe can't be done on other interfaces yet, but unless
you're going to check *which* interface is actually doing the ROC, you
should just make that a generic check that applies to all interfaces.

If you do care about this being more granular then you should check
*which* interface is scanning, and then you can still switch the MAC
address for *other* interfaces - but I'd still argue it should be
independent of interface type.

And, I'm confused, but isn't the polarity of the scanning check wrong?

johannes

