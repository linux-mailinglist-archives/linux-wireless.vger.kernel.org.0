Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F2163EEB06
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Aug 2021 12:33:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236511AbhHQKdl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 17 Aug 2021 06:33:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239241AbhHQKdk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 17 Aug 2021 06:33:40 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 323CDC0613C1
        for <linux-wireless@vger.kernel.org>; Tue, 17 Aug 2021 03:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=5QpFaNOvgKeipI1KszuLRUUgAUHoX5bupafqKgUMQ7Y=;
        t=1629196387; x=1630405987; b=KUI674rwemxBWrvqg7ZL6cs1NuYkeOPo+RhPOgPuT9A8cB6
        KslawXQcdZYJQMjkkUhF0DK746ZeqOK8MFH6+NqSvtIlhX0AaDzxFlWRiPdK6EErkuydvXqewTeQe
        4ErnrcI+a310vhHoFzDl7QNgX1/wNZcrYfAzGwE2rbK+bjrL4PeaNiJ6nrZPpjoj4jxLnP2KSmYRQ
        VovVUqV/XYs4nFd0sEc+SiWHhj2Xk2fOM55qNRRuBA+nP4yYEzYU3rtCNHSpRJ652jTvy7/VfYjad
        GU/r2TPh3l6Zhz8R1FCEMtULgFCI818jTob9wo6tJuNaPOZgT6hshWcloy4qIVLA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94.2)
        (envelope-from <johannes@sipsolutions.net>)
        id 1mFwP3-00CDtx-B5; Tue, 17 Aug 2021 12:33:05 +0200
Message-ID: <46cbed48d41a7200cec3d7428abe7bc6746e14fe.camel@sipsolutions.net>
Subject: Re: [PATCH v11 1/4] nl80211: MBSSID and EMA support in AP mode
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Aloka Dixit <alokad@codeaurora.org>, linux-wireless@vger.kernel.org
Date:   Tue, 17 Aug 2021 12:33:04 +0200
In-Reply-To: <20210715070745.5033-2-alokad@codeaurora.org>
References: <20210715070745.5033-1-alokad@codeaurora.org>
         <20210715070745.5033-2-alokad@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

I don't know if this issue was already present before, but it's
certainly due to the locking changes I had made with the RTNL some time
ago...

> +static int nl80211_parse_mbssid_config(struct wiphy *wiphy,
> +				       struct net_device *dev,
> +				       struct nlattr *attrs,
> +				       struct cfg80211_mbssid_config *config,
> +				       u8 num_elems)
> +{
> +	struct nlattr *tb[NL80211_MBSSID_CONFIG_ATTR_MAX + 1];
> +	struct net_device *tx_dev = dev;

Here tx_dev defaults to the dev, that's fine, it might be the
transmitting interface.

> +	if (tb[NL80211_MBSSID_CONFIG_ATTR_TRANSMITTING_IFINDEX]) {
> +		tx_ifindex =
> +			nla_get_u32(tb[NL80211_MBSSID_CONFIG_ATTR_TRANSMITTING_IFINDEX]);
> +
> +		if (!config->index && tx_ifindex != dev->ifindex)
> +			return -EINVAL;
> +
> +		tx_dev = __dev_get_by_index(wiphy_net(wiphy), tx_ifindex);

Here you try to look up the other transmitting device, and use
__dev_get_by_index() for that - but we don't hold any relevant lock
here!

This is (only) called from nl80211_start_ap(), which doesn't hold the
RTNL since commit a05829a7222e ("cfg80211: avoid holding the RTNL when
calling the driver"):

        {
                .cmd = NL80211_CMD_START_AP,
                .validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
                .flags = GENL_UNS_ADMIN_PERM,
                .doit = nl80211_start_ap,
-               .internal_flags = NL80211_FLAG_NEED_NETDEV_UP |
-                                 NL80211_FLAG_NEED_RTNL,
+               .internal_flags = NL80211_FLAG_NEED_NETDEV_UP,
        },


I'd fix this, but it's not really trivial - we'd need to use
dev_get_by_index() and ensure we dev_put() appropriately, but *only* if
it's different from the original dev ... could probably do that in this
function.

All told though this doesn't make me really very confident you tested
this recently, seems like something would've complained here?


+		if (!tx_dev || !tx_dev->ieee80211_ptr ||
+		    tx_dev->ieee80211_ptr->iftype != NL80211_IFTYPE_AP)
+			return -EINVAL;

Btw, this really should also check tx_dev->ieee80211_ptr->wiphy == wiphy
because we don't want to have a transmitting dev that's for a different
wiphy.


+	} else if (config->index &&
+		   !tb[NL80211_MBSSID_CONFIG_ATTR_TRANSMITTING_IFINDEX]) {
+		return -EINVAL;
+	}
+
+	config->tx_dev = tx_dev->ieee80211_ptr;
+	config->ema = nla_get_flag(tb[NL80211_MBSSID_CONFIG_ATTR_EMA]);
+	if (config->ema) {
+		if (!wiphy->ema_max_profile_periodicity)
+			return -EOPNOTSUPP;
+
+		if (num_elems > wiphy->ema_max_profile_periodicity)
+			return -EINVAL;
+	}
+
+	return 0;
+}

and given the structure of this code it's hard to dev_put() in the right
place.

+
+static struct cfg80211_mbssid_elems *
+nl80211_parse_mbssid_elems(struct wiphy *wiphy, struct nlattr *attrs)
+{
+	struct nlattr *nl_elems;
+	struct cfg80211_mbssid_elems *elems = NULL;
+	int rem_elems;
+	u8 i = 0, num_elems = 0;
+
+	if (!wiphy->mbssid_max_interfaces)
+		return NULL;
+
+	nla_for_each_nested(nl_elems, attrs, rem_elems)
+		num_elems++;
+
+	elems = kzalloc(struct_size(elems, elem, num_elems), GFP_KERNEL);
+	if (!elems)
+		return NULL;

This seems like something we might want to distinguish from the
unsupported case?


+	if (attrs[NL80211_ATTR_MBSSID_ELEMS]) {
+		bcn->mbssid_ies =
+			nl80211_parse_mbssid_elems(&rdev->wiphy,
+						   attrs[NL80211_ATTR_MBSSID_ELEMS]);
+		if (!bcn->mbssid_ies)
+			return -EINVAL;

and actually get -ENOMEM here, so maybe don't return pointer/NULL but
pointer/ERR_PTR?

 out:
-	kfree(params.acl);
-
+	if (!IS_ERR(params.acl))
+		kfree(params.acl);
+	kfree(params.beacon.mbssid_ies);

I guess this also gives you a place to dev_put().

johannes

