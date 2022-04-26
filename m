Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A34950F133
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Apr 2022 08:38:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243036AbiDZGlG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 26 Apr 2022 02:41:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245365AbiDZGlB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 26 Apr 2022 02:41:01 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 938CB1AF06
        for <linux-wireless@vger.kernel.org>; Mon, 25 Apr 2022 23:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1650955073; x=1682491073;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=OeYi/8Kk77U2hH80PFQD91iFV1PegCn6FuIbrzU9qz0=;
  b=X92sXiLso3By21Zpg7TOvlLnzKwM+YFQhzH3nca47xf0nuFaenlBJnpK
   dTqSY+sEGkUS/LRfFY2fuGqeFMH3PbWF+TUZ/AGOEvrpvbLML2opr1rLo
   mwT4r8wsT9HsX66cUHmlGEOqgUhxD0NSk/wY4byf8M5r5pu1UE5KUZBTe
   Q=;
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
  by alexa-out.qualcomm.com with ESMTP; 25 Apr 2022 23:37:53 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2022 23:37:53 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 25 Apr 2022 23:37:52 -0700
Received: from [10.50.24.135] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Mon, 25 Apr
 2022 23:37:49 -0700
Message-ID: <f137ca7f-8b59-3368-c666-247f83d80383@quicinc.com>
Date:   Tue, 26 Apr 2022 12:07:45 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [RFC PATCH] cfg80211: do some rework towards MLO link APIs
Content-Language: en-CA
To:     Johannes Berg <johannes@sipsolutions.net>,
        <linux-wireless@vger.kernel.org>
CC:     Johannes Berg <johannes.berg@intel.com>
References: <20220414145522.116716-1-johannes@sipsolutions.net>
From:   Vasanthakumar Thiagarajan <quic_vthiagar@quicinc.com>
In-Reply-To: <20220414145522.116716-1-johannes@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 4/14/2022 8:25 PM, Johannes Berg wrote:
 > From: Johannes Berg <johannes.berg@intel.com>
 >
 > In order to support multi-link operation with multiple links,
 > start adding some APIs. The notable addition here is to have
 > the link ID in a new nl80211 attribute, that will be used to
 > differentiate the links in many nl80211 operations. The one I
 > mostly looked at so far was start_ap and friends, but that is
 > also still incomplete.
 >
 > Mostly the idea of this is to give everyone an idea of what
 > such an API might look like and what it might result in at
 > the nl80211 level.

Thanks! At high level, we are fine with this approach. As discussed,
we need to have a mechanism to be able to set link specific 
configurations such as link STA mac addr before assoc in STA mode.
The proposal to have some sort of mapping between local and OTA link 
will work. So in AP mode, it is OTA link_id but in STA mode, it is local 
link_id which does not change the life time of the STA link
interface? Will that be still called link_id or something which means 
pseudo link_id (something like link_idx?) to avoid confusions with
OTA link_id?

With a single netdev for MLD interface, we may need to add NL options
(in NL80211_CMD_SET_INTERFACE?) to set the link mac addr in both AP and 
STA mode? Also, interface to report the mac addresses of all interfaces 
to the user space in NL80211_CMD_NEW_INTERFACE event.

I assume link_id will be added in NL80211_CMD_FRAME command/event as 
well for the application to identify the link on which the frame
is-received/to-be-transmitted?

 >
 > Note that this depends on the two patches here:
 > 
https://lore.kernel.org/linux-wireless/20220414140402.70ddf8af3eb0.I2cc38cb6a10bb4c3863ec9ee97edbcc70a07aa4b@changeid/T/#u
 >
 > Change-Id: I023f35d382282691d7e2cbc607fb11691355cd63
 > Signed-off-by: Johannes Berg <johannes.berg@intel.com>
 > ---
 >   include/linux/ieee80211.h    |   3 +
 >   include/net/cfg80211.h       |  47 +++++-
 >   include/uapi/linux/nl80211.h |  23 +++
 >   net/mac80211/cfg.c           |   2 +-
 >   net/mac80211/mlme.c          |   2 +-
 >   net/wireless/ap.c            |  42 ++++-
 >   net/wireless/chan.c          |  80 +++++----
 >   net/wireless/core.c          |   2 +-
 >   net/wireless/core.h          |   6 +-
 >   net/wireless/ibss.c          |   4 +-
 >   net/wireless/mesh.c          |  19 ++-
 >   net/wireless/mlme.c          |   5 +-
 >   net/wireless/nl80211.c       | 317 +++++++++++++++++++++++++++--------
 >   net/wireless/ocb.c           |   5 +-
 >   net/wireless/reg.c           | 127 ++++++++------
 >   net/wireless/sme.c           |   4 +-
 >   net/wireless/trace.h         |  11 +-
 >   net/wireless/util.c          |  17 +-
 >   18 files changed, 516 insertions(+), 200 deletions(-)
 >
 > diff --git a/include/linux/ieee80211.h b/include/linux/ieee80211.h
 > index 313aabb2d511..934c58d042b0 100644
 > --- a/include/linux/ieee80211.h
 > +++ b/include/linux/ieee80211.h
 > @@ -4399,4 +4399,7 @@ enum ieee80211_range_params_max_total_ltf {
 >   	IEEE80211_RANGE_PARAMS_MAX_TOTAL_LTF_UNSPECIFIED,
 >   };
 >
 > +/* multi-link device */
 > +#define IEEE80211_MLD_MAX_NUM_LINKS	15
 > +
 >   #endif /* LINUX_IEEE80211_H */
 > diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
 > index 1d9e240e1a69..32e4848b5749 100644
 > --- a/include/net/cfg80211.h
 > +++ b/include/net/cfg80211.h
 > @@ -5600,6 +5600,7 @@ struct wireless_dev {
 >   	u8 address[ETH_ALEN] __aligned(sizeof(u16));
 >
 >   	/* currently used for IBSS and SME - might be rearranged later */
 > +	// FIXME: move SSID to link?

It seems all the links affiliated to an MLD should have the same SSID,
may be SSID is not link specific?

 >   	u8 ssid[IEEE80211_MAX_SSID_LEN];
 >   	u8 ssid_len, mesh_id_len, mesh_id_up_len;
 >   	struct cfg80211_conn *conn;
 > @@ -5613,20 +5614,18 @@ struct wireless_dev {
 >   	struct list_head event_list;
 >   	spinlock_t event_lock;
 >
 > +	// FIXME: move to link, I think
 >   	struct cfg80211_internal_bss *current_bss; /* associated / joined */
 > -	struct cfg80211_chan_def preset_chandef;
 > -	struct cfg80211_chan_def chandef;
 >
 >   	bool ps;
 >   	int ps_timeout;
 >
 > -	int beacon_interval;
 > -
 >   	u32 ap_unexpected_nlportid;
 >
 >   	u32 owner_nlportid;
 >   	bool nl_owner_dead;
 >
 > +	// FIXME: move to link?

Correct, all the cac related data will most likely be link specific.

 >   	bool cac_started;
 >   	unsigned long cac_start_time;
 >   	unsigned int cac_time_ms;
 > @@ -5654,6 +5653,15 @@ struct wireless_dev {
 >   	struct work_struct pmsr_free_wk;
 >
 >   	unsigned long unprot_beacon_reported;
 > +
 > +	struct {
 > +		u8 addr[ETH_ALEN];
 > +		int beacon_interval;
 > +		struct cfg80211_chan_def preset_chandef;
 > +		struct cfg80211_chan_def chandef;
 > +	} links[IEEE80211_MLD_MAX_NUM_LINKS];
 > +	u16 valid_links;
 > +	u16 active_links>   };
 >
 >   static inline const u8 *wdev_address(struct wireless_dev *wdev)
 > @@ -5682,6 +5690,33 @@ static inline void *wdev_priv(struct 
wireless_dev *wdev)
 >   	return wiphy_priv(wdev->wiphy);
 >   }
 >
 > +static inline void WARN_INVALID_LINK_ID(struct wireless_dev *wdev,
 > +					unsigned int link_id)
 > +{
 > +	WARN_ON(link_id && !wdev->valid_links);
 > +	WARN_ON(wdev->valid_links &&
 > +		!(wdev->valid_links & BIT(link_id)));
 > +}
 > +
 > +#define for_each_valid_link(wdev, link_id)					\
 > +	for (unsigned int link_id = 0;						\
 > +	     link_id < ((wdev)->valid_links ? ARRAY_SIZE((wdev)->links) : 1);	\
 > +	     link_id++)								\
 > +		if (!(wdev)->valid_links ||					\
 > +		    ((wdev)->valid_links & BIT(link_id)))
 > +
 > +#define for_each_active_link(wdev, link_id)					\
 > +	for (unsigned int link_id = 0;						\
 > +	     link_id < ((wdev)->valid_links ? ARRAY_SIZE((wdev)->links) : 1);	\
 > +	     link_id++)								\
 > +		if (!(wdev)->valid_links ||					\
 > +		    ((wdev)->active_links & BIT(link_id)))
 > +
 > +static inline unsigned int wdev_num_active_links(struct wireless_dev 
*wdev)
 > +{
 > +	return wdev->active_links ? hweight16(wdev->active_links) : 1;
 > +}
 > +
 >   /**
 >    * DOC: Utility functions
 >    *
 > @@ -7996,12 +8031,14 @@ bool cfg80211_reg_can_beacon_relax(struct 
wiphy *wiphy,
 >    * cfg80211_ch_switch_notify - update wdev channel and notify userspace
 >    * @dev: the device which switched channels
 >    * @chandef: the new channel definition
 > + * @link_id: the link ID for MLO, must be 0 for non-MLO
 >    *
 >    * Caller must acquire wdev_lock, therefore must only be called 
from sleepable
 >    * driver context!
 >    */
 >   void cfg80211_ch_switch_notify(struct net_device *dev,
 > -			       struct cfg80211_chan_def *chandef);
 > +			       struct cfg80211_chan_def *chandef,
 > +			       unsigned int link_id);
 >
 >   /*
 >    * cfg80211_ch_switch_started_notify - notify channel switch start
 > diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
 > index f63f9fa80c30..06d93f298cf7 100644
 > --- a/include/uapi/linux/nl80211.h
 > +++ b/include/uapi/linux/nl80211.h
 > @@ -323,6 +323,17 @@
 >    * Once the association is done, the driver cleans the FILS AAD data.
 >    */
 >
 > +/**
 > + * DOC: Multi-Link Operation
 > + *
 > + * In Multi-Link Operation, a connection between to MLDs utilizes 
multiple
 > + * links. To use this in nl80211, various commands and responses now 
need
 > + * to or will include the new %NL80211_ATTR_MLO_LINKS attribute.
 > + * Additionally, various commands that need to operate on a specific 
link
 > + * now need to be given the %NL80211_ATTR_MLO_LINK_ID attribute, e.g. to
 > + * use %NL80211_CMD_START_AP or similar functions.
 > + */
 > +
 >   /**
 >    * enum nl80211_commands - supported nl80211 commands
 >    *
 > @@ -1244,6 +1255,12 @@
 >    *      to describe the BSSID address of the AP and 
%NL80211_ATTR_TIMEOUT to
 >    *      specify the timeout value.
 >    *
 > + * @NL80211_CMD_ADD_LINK: Add a new link to an interface. The
 > + *	%NL80211_ATTR_MLO_LINK_ID attribute is used for the new link.
 > + * @NL80211_CMD_REMOVE_LINK: Remove a link from an interface. This 
may come
 > + *	without %NL80211_ATTR_MLO_LINK_ID as an easy way to remove all links
 > + *	in preparation for e.g. roaming to a regular (non-MLO) AP.
 > + *
 >    * @NL80211_CMD_MAX: highest used command number
 >    * @__NL80211_CMD_AFTER_LAST: internal use
 >    */
 > @@ -1488,6 +1505,9 @@ enum nl80211_commands {
 >
 >   	NL80211_CMD_ASSOC_COMEBACK,
 >
 > +	NL80211_CMD_ADD_LINK,
 > +	NL80211_CMD_REMOVE_LINK,
 > +
 >   	/* let this always be before all commands we haven't upstreamed yet */
 >   	__NL80211_CMD_NONUPSTREAM_START,
 >
 > @@ -3199,6 +3219,9 @@ enum nl80211_attrs {
 >   	NL80211_ATTR_TX_HW_TIMESTAMP,
 >   	NL80211_ATTR_RX_HW_TIMESTAMP,
 >
 > +	NL80211_ATTR_MLO_LINKS,
 > +	NL80211_ATTR_MLO_LINK_ID,
 > +
 >   	/* add attributes here, update the policy in nl80211.c */
 >
 >   	__NL80211_ATTR_AFTER_LAST,
 > diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
 > index 7303543c2741..9f0f4ed827fe 100644
 > --- a/net/mac80211/cfg.c
 > +++ b/net/mac80211/cfg.c
 > @@ -3293,7 +3293,7 @@ static int __ieee80211_csa_finalize(struct 
ieee80211_sub_if_data *sdata)
 >   	if (err)
 >   		return err;
 >
 > -	cfg80211_ch_switch_notify(sdata->dev, &sdata->csa_chandef);
 > +	cfg80211_ch_switch_notify(sdata->dev, &sdata->csa_chandef, 0);
 >
 >   	return 0;
 >   }
 > diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
 > index b75eb9c28791..18040109eefb 100644
 > --- a/net/mac80211/mlme.c
 > +++ b/net/mac80211/mlme.c
 > @@ -1424,7 +1424,7 @@ static void 
ieee80211_chswitch_post_beacon(struct ieee80211_sub_if_data *sdata)
 >   		return;
 >   	}
 >
 > -	cfg80211_ch_switch_notify(sdata->dev, &sdata->reserved_chandef);
 > +	cfg80211_ch_switch_notify(sdata->dev, &sdata->reserved_chandef, 0);
 >   }
 >
 >   void ieee80211_chswitch_done(struct ieee80211_vif *vif, bool success)
 > diff --git a/net/wireless/ap.c b/net/wireless/ap.c
 > index 550ac9d827fe..7691395c1f84 100644
 > --- a/net/wireless/ap.c
 > +++ b/net/wireless/ap.c
 > @@ -1,4 +1,8 @@
 >   // SPDX-License-Identifier: GPL-2.0
 > +/*
 > + * Portions
 > + * Copyright (C) 2022 Intel Corporation
 > + */
 >   #include <linux/ieee80211.h>
 >   #include <linux/export.h>
 >   #include <net/cfg80211.h>
 > @@ -7,8 +11,9 @@
 >   #include "rdev-ops.h"
 >
 >
 > -int __cfg80211_stop_ap(struct cfg80211_registered_device *rdev,
 > -		       struct net_device *dev, bool notify)
 > +static int ___cfg80211_stop_ap(struct cfg80211_registered_device *rdev,
 > +			       struct net_device *dev, unsigned int link_id,
 > +			       bool notify)
 >   {
 >   	struct wireless_dev *wdev = dev->ieee80211_ptr;
 >   	int err;
 > @@ -22,14 +27,16 @@ int __cfg80211_stop_ap(struct 
cfg80211_registered_device *rdev,
 >   	    dev->ieee80211_ptr->iftype != NL80211_IFTYPE_P2P_GO)
 >   		return -EOPNOTSUPP;
 >
 > -	if (!wdev->beacon_interval)
 > +	if (!wdev->links[link_id].beacon_interval)
 >   		return -ENOENT;
 >
 > +	// FIXME - pass link id
 >   	err = rdev_stop_ap(rdev, dev);
 >   	if (!err) {
 >   		wdev->conn_owner_nlportid = 0;
 > -		wdev->beacon_interval = 0;
 > -		memset(&wdev->chandef, 0, sizeof(wdev->chandef));
 > +		wdev->links[link_id].beacon_interval = 0;
 > +		memset(&wdev->links[link_id].chandef, 0,
 > +		       sizeof(wdev->links[link_id].chandef));
 >   		wdev->ssid_len = 0;
 >   		rdev_set_qos_map(rdev, dev, NULL);
 >   		if (notify)
 > @@ -46,14 +53,35 @@ int __cfg80211_stop_ap(struct 
cfg80211_registered_device *rdev,
 >   	return err;
 >   }
 >
 > +int __cfg80211_stop_ap(struct cfg80211_registered_device *rdev,
 > +		       struct net_device *dev, int link_id,
 > +		       bool notify)
 > +{
 > +	int ret;
 > +
 > +	if (link_id >= 0)
 > +		return ___cfg80211_stop_ap(rdev, dev, link_id, notify);
 > +
 > +	for_each_valid_link(dev->ieee80211_ptr, link) {
 > +		int ret1 = ___cfg80211_stop_ap(rdev, dev, link, notify);
 > +
 > +		if (ret1)
 > +			ret = ret1;
 > +		/* try the next one also if one errored */
 > +	}
 > +
 > +	return ret;
 > +}
 > +
 >   int cfg80211_stop_ap(struct cfg80211_registered_device *rdev,
 > -		     struct net_device *dev, bool notify)
 > +		     struct net_device *dev, int link_id,
 > +		     bool notify)
 >   {
 >   	struct wireless_dev *wdev = dev->ieee80211_ptr;
 >   	int err;
 >
 >   	wdev_lock(wdev);
 > -	err = __cfg80211_stop_ap(rdev, dev, notify);
 > +	err = __cfg80211_stop_ap(rdev, dev, link_id, notify);
 >   	wdev_unlock(wdev);
 >
 >   	return err;
 > diff --git a/net/wireless/chan.c b/net/wireless/chan.c
 > index 3a5bce5e422a..3a176f3e415d 100644
 > --- a/net/wireless/chan.c
 > +++ b/net/wireless/chan.c
 > @@ -704,40 +704,57 @@ bool cfg80211_is_sub_chan(struct 
cfg80211_chan_def *chandef,
 >
 >   bool cfg80211_beaconing_iface_active(struct wireless_dev *wdev)
 >   {
 > -	bool active = false;
 > -
 >   	ASSERT_WDEV_LOCK(wdev);
 >
 > -	if (!wdev->chandef.chan)
 > -		return false;
 > +	for_each_valid_link(wdev, link_id) {
 > +		if (!wdev->links[link_id].chandef.chan)
 > +			continue;
 >
 > -	switch (wdev->iftype) {
 > -	case NL80211_IFTYPE_AP:
 > -	case NL80211_IFTYPE_P2P_GO:
 > -		active = wdev->beacon_interval != 0;
 > -		break;
 > -	case NL80211_IFTYPE_ADHOC:
 > -		active = wdev->ssid_len != 0;
 > -		break;
 > -	case NL80211_IFTYPE_MESH_POINT:
 > -		active = wdev->mesh_id_len != 0;
 > -		break;
 > -	case NL80211_IFTYPE_STATION:
 > -	case NL80211_IFTYPE_OCB:
 > -	case NL80211_IFTYPE_P2P_CLIENT:
 > -	case NL80211_IFTYPE_MONITOR:
 > -	case NL80211_IFTYPE_AP_VLAN:
 > -	case NL80211_IFTYPE_P2P_DEVICE:
 > -	/* Can NAN type be considered as beaconing interface? */
 > -	case NL80211_IFTYPE_NAN:
 > -		break;
 > -	case NL80211_IFTYPE_UNSPECIFIED:
 > -	case NL80211_IFTYPE_WDS:
 > -	case NUM_NL80211_IFTYPES:
 > -		WARN_ON(1);
 > +		switch (wdev->iftype) {
 > +		case NL80211_IFTYPE_AP:
 > +		case NL80211_IFTYPE_P2P_GO:
 > +			if (wdev->links[link_id].beacon_interval)
 > +				return true;
 > +			break;
 > +		case NL80211_IFTYPE_ADHOC:
 > +			if (wdev->ssid_len)
 > +				return true;
 > +			break;
 > +		case NL80211_IFTYPE_MESH_POINT:
 > +			if (wdev->mesh_id_len)
 > +				return true;
 > +			break;
 > +		case NL80211_IFTYPE_STATION:
 > +		case NL80211_IFTYPE_OCB:
 > +		case NL80211_IFTYPE_P2P_CLIENT:
 > +		case NL80211_IFTYPE_MONITOR:
 > +		case NL80211_IFTYPE_AP_VLAN:
 > +		case NL80211_IFTYPE_P2P_DEVICE:
 > +		/* Can NAN type be considered as beaconing interface? */
 > +		case NL80211_IFTYPE_NAN:
 > +			break;
 > +		case NL80211_IFTYPE_UNSPECIFIED:
 > +		case NL80211_IFTYPE_WDS:
 > +		case NUM_NL80211_IFTYPES:
 > +			WARN_ON(1);
 > +		}
 >   	}
 >
 > -	return active;
 > +	return false;
 > +}
 > +
 > +static bool cfg80211_wdev_on_sub_chan(struct wireless_dev *wdev,
 > +				      struct ieee80211_channel *chan)
 > +{
 > +	for_each_valid_link(wdev, link_id) {
 > +		if (!wdev->links[link_id].chandef.chan)
 > +			continue;
 > +
 > +		if (cfg80211_is_sub_chan(&wdev->links[link_id].chandef, chan))
 > +			return true;
 > +	}
 > +
 > +	return false;
 >   }
 >
 >   static bool cfg80211_is_wiphy_oper_chan(struct wiphy *wiphy,
 > @@ -752,7 +769,7 @@ static bool cfg80211_is_wiphy_oper_chan(struct 
wiphy *wiphy,
 >   			continue;
 >   		}
 >
 > -		if (cfg80211_is_sub_chan(&wdev->chandef, chan)) {
 > +		if (cfg80211_wdev_on_sub_chan(wdev, chan)) {
 >   			wdev_unlock(wdev);
 >   			return true;
 >   		}
 > @@ -1189,6 +1206,7 @@ static bool cfg80211_ir_permissive_chan(struct 
wiphy *wiphy,
 >   					enum nl80211_iftype iftype,
 >   					struct ieee80211_channel *chan)
 >   {
 > +#if 0
 >   	struct wireless_dev *wdev;
 >   	struct cfg80211_registered_device *rdev = wiphy_to_rdev(wiphy);
 >
 > @@ -1273,7 +1291,7 @@ static bool cfg80211_ir_permissive_chan(struct 
wiphy *wiphy,
 >   			return true;
 >   		}
 >   	}
 > -
 > +#endif
 >   	return false;
 >   }
 >
 > diff --git a/net/wireless/core.c b/net/wireless/core.c
 > index cb3039fd8dbf..bc3e73f2a1be 100644
 > --- a/net/wireless/core.c
 > +++ b/net/wireless/core.c
 > @@ -1240,7 +1240,7 @@ void __cfg80211_leave(struct 
cfg80211_registered_device *rdev,
 >   		break;
 >   	case NL80211_IFTYPE_AP:
 >   	case NL80211_IFTYPE_P2P_GO:
 > -		__cfg80211_stop_ap(rdev, dev, true);
 > +		__cfg80211_stop_ap(rdev, dev, -1, true);
 >   		break;
 >   	case NL80211_IFTYPE_OCB:
 >   		__cfg80211_leave_ocb(rdev, dev);
 > diff --git a/net/wireless/core.h b/net/wireless/core.h
 > index b67179126a55..433db44e6a39 100644
 > --- a/net/wireless/core.h
 > +++ b/net/wireless/core.h
 > @@ -354,9 +354,11 @@ int cfg80211_leave_ocb(struct 
cfg80211_registered_device *rdev,
 >
 >   /* AP */
 >   int __cfg80211_stop_ap(struct cfg80211_registered_device *rdev,
 > -		       struct net_device *dev, bool notify);
 > +		       struct net_device *dev, int link_id,
 > +		       bool notify);
 >   int cfg80211_stop_ap(struct cfg80211_registered_device *rdev,
 > -		     struct net_device *dev, bool notify);
 > +		     struct net_device *dev, int link_id,
 > +		     bool notify);
 >
 >   /* MLME */
 >   int cfg80211_mlme_auth(struct cfg80211_registered_device *rdev,
 > diff --git a/net/wireless/ibss.c b/net/wireless/ibss.c
 > index 02f45128049d..64c919860e08 100644
 > --- a/net/wireless/ibss.c
 > +++ b/net/wireless/ibss.c
 > @@ -131,7 +131,7 @@ int __cfg80211_join_ibss(struct 
cfg80211_registered_device *rdev,
 >   		kfree_sensitive(wdev->connect_keys);
 >   	wdev->connect_keys = connkeys;
 >
 > -	wdev->chandef = params->chandef;
 > +	wdev->links[0].chandef = params->chandef;
 >   	if (connkeys) {
 >   		params->wep_keys = connkeys->params;
 >   		params->wep_tx_key = connkeys->def;
 > @@ -180,7 +180,7 @@ static void __cfg80211_clear_ibss(struct 
net_device *dev, bool nowext)
 >
 >   	wdev->current_bss = NULL;
 >   	wdev->ssid_len = 0;
 > -	memset(&wdev->chandef, 0, sizeof(wdev->chandef));
 > +	memset(&wdev->links[0].chandef, 0, sizeof(wdev->links[0].chandef));
 >   #ifdef CPTCFG_CFG80211_WEXT
 >   	if (!nowext)
 >   		wdev->wext.ibss.ssid_len = 0;
 > diff --git a/net/wireless/mesh.c b/net/wireless/mesh.c
 > index e4e363138279..0df4fe633e64 100644
 > --- a/net/wireless/mesh.c
 > +++ b/net/wireless/mesh.c
 > @@ -1,4 +1,8 @@
 >   // SPDX-License-Identifier: GPL-2.0
 > +/*
 > + * Portions
 > + * Copyright (C) 2022 Intel Corporation
 > + */
 >   #include <linux/ieee80211.h>
 >   #include <linux/export.h>
 >   #include <net/cfg80211.h>
 > @@ -125,7 +129,7 @@ int __cfg80211_join_mesh(struct 
cfg80211_registered_device *rdev,
 >
 >   	if (!setup->chandef.chan) {
 >   		/* if no channel explicitly given, use preset channel */
 > -		setup->chandef = wdev->preset_chandef;
 > +		setup->chandef = wdev->links[0].preset_chandef;
 >   	}
 >
 >   	if (!setup->chandef.chan) {
 > @@ -211,8 +215,8 @@ int __cfg80211_join_mesh(struct 
cfg80211_registered_device *rdev,
 >   	if (!err) {
 >   		memcpy(wdev->ssid, setup->mesh_id, setup->mesh_id_len);
 >   		wdev->mesh_id_len = setup->mesh_id_len;
 > -		wdev->chandef = setup->chandef;
 > -		wdev->beacon_interval = setup->beacon_interval;
 > +		wdev->links[0].chandef = setup->chandef;
 > +		wdev->links[0].beacon_interval = setup->beacon_interval;
 >   	}
 >
 >   	return err;
 > @@ -241,7 +245,7 @@ int cfg80211_set_mesh_channel(struct 
cfg80211_registered_device *rdev,
 >   		err = rdev_libertas_set_mesh_channel(rdev, wdev->netdev,
 >   						     chandef->chan);
 >   		if (!err)
 > -			wdev->chandef = *chandef;
 > +			wdev->links[0].chandef = *chandef;
 >
 >   		return err;
 >   	}
 > @@ -249,7 +253,7 @@ int cfg80211_set_mesh_channel(struct 
cfg80211_registered_device *rdev,
 >   	if (wdev->mesh_id_len)
 >   		return -EBUSY;
 >
 > -	wdev->preset_chandef = *chandef;
 > +	wdev->links[0].preset_chandef = *chandef;
 >   	return 0;
 >   }
 >
 > @@ -274,8 +278,9 @@ int __cfg80211_leave_mesh(struct 
cfg80211_registered_device *rdev,
 >   	if (!err) {
 >   		wdev->conn_owner_nlportid = 0;
 >   		wdev->mesh_id_len = 0;
 > -		wdev->beacon_interval = 0;
 > -		memset(&wdev->chandef, 0, sizeof(wdev->chandef));
 > +		wdev->links[0].beacon_interval = 0;
 > +		memset(&wdev->links[0].chandef, 0,
 > +		       sizeof(wdev->links[0].chandef));
 >   		rdev_set_qos_map(rdev, dev, NULL);
 >   		cfg80211_sched_dfs_chan_update(rdev);
 >   	}
 > diff --git a/net/wireless/mlme.c b/net/wireless/mlme.c
 > index 1d2e1af19ab8..1cde5207ed19 100644
 > --- a/net/wireless/mlme.c
 > +++ b/net/wireless/mlme.c
 > @@ -944,8 +944,9 @@ void cfg80211_cac_event(struct net_device *netdev,
 >   	if (WARN_ON(!wdev->cac_started && event != NL80211_RADAR_CAC_STARTED))
 >   		return;
 >
 > -	if (WARN_ON(!wdev->chandef.chan))
 > -		return;
 > +// FIXME - what was this for? not trusting drivers?
 > +//	if (WARN_ON(!wdev->chandef.chan))
 > +//		return;
 >
 >   	switch (event) {
 >   	case NL80211_RADAR_CAC_FINISHED:
 > diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
 > index d782df482ee4..a812533c5506 100644
 > --- a/net/wireless/nl80211.c
 > +++ b/net/wireless/nl80211.c
 > @@ -809,6 +809,10 @@ static const struct nla_policy 
nl80211_policy[NUM_NL80211_ATTR] = {
 >   	[NL80211_ATTR_EHT_CAPABILITY] =
 >   		NLA_POLICY_BINARY_RANGE(NL80211_EHT_MIN_CAPABILITY_LEN,
 >   					NL80211_EHT_MAX_CAPABILITY_LEN),
 > +	[NL80211_ATTR_MLO_LINKS] =
 > +		NLA_POLICY_NESTED_ARRAY(nl80211_policy),
 > +	[NL80211_ATTR_MLO_LINK_ID] =
 > +		NLA_POLICY_RANGE(NLA_U8, 0, IEEE80211_MLD_MAX_NUM_LINKS),
 >   };
 >
 >   /* policy for the key attributes */
 > @@ -1242,6 +1246,27 @@ static bool nl80211_put_txq_stats(struct 
sk_buff *msg,
 >
 >   /* netlink command implementations */
 >
 > +/**
 > + * nl80211_link_id - return link ID
 > + * @attrs: attributes to look at
 > + *
 > + * Returns: the link ID or 0 if not given
 > + *
 > + * Note this function doesn't do any validation of the link
 > + * ID validity wrt. links that were actually added, so it must
 > + * be called only from ops with %NL80211_FLAG_MLO_VALID_LINK_ID
 > + * or if additional validation is done.
 > + */
 > +static unsigned int nl80211_link_id(struct nlattr **attrs)
 > +{
 > +	struct nlattr *linkid = attrs[NL80211_ATTR_MLO_LINK_ID];
 > +
 > +	if (!linkid)
 > +		return 0;
 > +
 > +	return nla_get_u8(linkid);
 > +}
 > +
 >   struct key_parse {
 >   	struct key_params p;
 >   	int idx;
 > @@ -3240,7 +3265,8 @@ int nl80211_parse_chandef(struct 
cfg80211_registered_device *rdev,
 >
 >   static int __nl80211_set_channel(struct cfg80211_registered_device 
*rdev,
 >   				 struct net_device *dev,
 > -				 struct genl_info *info)
 > +				 struct genl_info *info,
 > +				 int link_id)
 >   {
 >   	struct cfg80211_chan_def chandef;
 >   	int result;
 > @@ -3261,12 +3287,22 @@ static int __nl80211_set_channel(struct 
cfg80211_registered_device *rdev,
 >   	switch (iftype) {
 >   	case NL80211_IFTYPE_AP:
 >   	case NL80211_IFTYPE_P2P_GO:
 > +		if (link_id < 0) {
 > +			if (wdev->valid_links) {
 > +				result = -EINVAL;
 > +				break;
 > +			}
 > +			link_id = 0;
 > +		}
 > +
 >   		if (!cfg80211_reg_can_beacon_relax(&rdev->wiphy, &chandef,
 >   						   iftype)) {
 >   			result = -EINVAL;
 >   			break;
 >   		}
 > -		if (wdev->beacon_interval) {
 > +		if (wdev->links[link_id].beacon_interval) {
 > +			struct ieee80211_channel *preset_chan;
 > +
 >   			if (!dev || !rdev->ops->set_ap_chanwidth ||
 >   			    !(rdev->wiphy.features &
 >   			      NL80211_FEATURE_AP_MODE_CHAN_WIDTH_CHANGE)) {
 > @@ -3275,15 +3311,18 @@ static int __nl80211_set_channel(struct 
cfg80211_registered_device *rdev,
 >   			}
 >
 >   			/* Only allow dynamic channel width changes */
 > -			if (chandef.chan != wdev->preset_chandef.chan) {
 > +			preset_chan = wdev->links[link_id].preset_chandef.chan;
 > +			if (chandef.chan != preset_chan) {
 >   				result = -EBUSY;
 >   				break;
 >   			}
 > +
 > +			// FIXME: pass link_id!!
 >   			result = rdev_set_ap_chanwidth(rdev, dev, &chandef);
 >   			if (result)
 >   				break;
 >   		}
 > -		wdev->preset_chandef = chandef;
 > +		wdev->links[link_id].preset_chandef = chandef;
 >   		result = 0;
 >   		break;
 >   	case NL80211_IFTYPE_MESH_POINT:
 > @@ -3302,9 +3341,10 @@ static int __nl80211_set_channel(struct 
cfg80211_registered_device *rdev,
 >   static int nl80211_set_channel(struct sk_buff *skb, struct 
genl_info *info)
 >   {
 >   	struct cfg80211_registered_device *rdev = info->user_ptr[0];
 > +	unsigned int link_id = nl80211_link_id(info->attrs);
 >   	struct net_device *netdev = info->user_ptr[1];
 >
 > -	return __nl80211_set_channel(rdev, netdev, info);
 > +	return __nl80211_set_channel(rdev, netdev, info, link_id);
 >   }
 >
 >   static int nl80211_set_wiphy(struct sk_buff *skb, struct genl_info 
*info)
 > @@ -3419,7 +3459,7 @@ static int nl80211_set_wiphy(struct sk_buff 
*skb, struct genl_info *info)
 >   		result = __nl80211_set_channel(
 >   			rdev,
 >   			nl80211_can_set_dev_channel(wdev) ? netdev : NULL,
 > -			info);
 > +			info, -1);
 >   		if (result)
 >   			goto out;
 >   	}
 > @@ -4669,8 +4709,12 @@ static int nl80211_set_mac_acl(struct sk_buff 
*skb, struct genl_info *info)
 >   	    dev->ieee80211_ptr->iftype != NL80211_IFTYPE_P2P_GO)
 >   		return -EOPNOTSUPP;
 >
 > -	if (!dev->ieee80211_ptr->beacon_interval)
 > -		return -EINVAL;
 > +// FIXME: do we consider this to be on the MLD? I guess so?
 > +//	  then what about legacy stations? or should we have
 > +//	  ACL on each link? seems odd ...

I think it makes sense to have this for MLD rather than individual link
interfaces, it is unlikely to have different policies for link and MLD
interfaces in terms of blocking/allowing a particular station mac.

 > +//
 > +//	if (!dev->ieee80211_ptr->beacon_interval)
 > +//		return -EINVAL;
 >
 >   	acl = parse_acl_data(&rdev->wiphy, info);
 >   	if (IS_ERR(acl))
 > @@ -4825,14 +4869,14 @@ static void he_build_mcs_mask(u16 he_mcs_map,
 >   	}
 >   }
 >
 > -static u16 he_get_txmcsmap(struct genl_info *info,
 > +static u16 he_get_txmcsmap(struct genl_info *info, unsigned int link_id,
 >   			   const struct ieee80211_sta_he_cap *he_cap)
 >   {
 >   	struct net_device *dev = info->user_ptr[1];
 >   	struct wireless_dev *wdev = dev->ieee80211_ptr;
 >   	__le16	tx_mcs;
 >
 > -	switch (wdev->chandef.width) {
 > +	switch (wdev->links[link_id].chandef.width) {
 >   	case NL80211_CHAN_WIDTH_80P80:
 >   		tx_mcs = he_cap->he_mcs_nss_supp.tx_mcs_80p80;
 >   		break;
 > @@ -4850,7 +4894,8 @@ static bool he_set_mcs_mask(struct genl_info *info,
 >   			    struct wireless_dev *wdev,
 >   			    struct ieee80211_supported_band *sband,
 >   			    struct nl80211_txrate_he *txrate,
 > -			    u16 mcs[NL80211_HE_NSS_MAX])
 > +			    u16 mcs[NL80211_HE_NSS_MAX],
 > +			    unsigned int link_id)
 >   {
 >   	const struct ieee80211_sta_he_cap *he_cap;
 >   	u16 tx_mcs_mask[NL80211_HE_NSS_MAX] = {};
 > @@ -4863,7 +4908,7 @@ static bool he_set_mcs_mask(struct genl_info *info,
 >
 >   	memset(mcs, 0, sizeof(u16) * NL80211_HE_NSS_MAX);
 >
 > -	tx_mcs_map = he_get_txmcsmap(info, he_cap);
 > +	tx_mcs_map = he_get_txmcsmap(info, link_id, he_cap);
 >
 >   	/* Build he_mcs_mask from HE capabilities */
 >   	he_build_mcs_mask(tx_mcs_map, tx_mcs_mask);
 > @@ -4883,7 +4928,8 @@ static int nl80211_parse_tx_bitrate_mask(struct 
genl_info *info,
 >   					 enum nl80211_attrs attr,
 >   					 struct cfg80211_bitrate_mask *mask,
 >   					 struct net_device *dev,
 > -					 bool default_all_enabled)
 > +					 bool default_all_enabled,
 > +					 unsigned int link_id)
 >   {
 >   	struct nlattr *tb[NL80211_TXRATE_MAX + 1];
 >   	struct cfg80211_registered_device *rdev = info->user_ptr[0];
 > @@ -4920,7 +4966,7 @@ static int nl80211_parse_tx_bitrate_mask(struct 
genl_info *info,
 >   		if (!he_cap)
 >   			continue;
 >
 > -		he_tx_mcs_map = he_get_txmcsmap(info, he_cap);
 > +		he_tx_mcs_map = he_get_txmcsmap(info, link_id, he_cap);
 >   		he_build_mcs_mask(he_tx_mcs_map, mask->control[i].he_mcs);
 >
 >   		mask->control[i].he_gi = 0xFF;
 > @@ -4985,7 +5031,8 @@ static int nl80211_parse_tx_bitrate_mask(struct 
genl_info *info,
 >   		if (tb[NL80211_TXRATE_HE] &&
 >   		    !he_set_mcs_mask(info, wdev, sband,
 >   				     nla_data(tb[NL80211_TXRATE_HE]),
 > -				     mask->control[band].he_mcs))
 > +				     mask->control[band].he_mcs,
 > +				     link_id))
 >   			return -EINVAL;
 >
 >   		if (tb[NL80211_TXRATE_HE_GI])
 > @@ -5474,10 +5521,14 @@ static bool nl80211_get_ap_channel(struct 
cfg80211_registered_device *rdev,
 >   		    wdev->iftype != NL80211_IFTYPE_P2P_GO)
 >   			continue;
 >
 > -		if (!wdev->preset_chandef.chan)
 > +		/* let this method only work for non-MLD */
 > +		if (wdev->valid_links)
 > +			continue;
 > +
 > +		if (!wdev->links[0].preset_chandef.chan)
 >   			continue;
 >
 > -		params->chandef = wdev->preset_chandef;
 > +		params->chandef = wdev->links[0].preset_chandef;
 >   		ret = true;
 >   		break;
 >   	}
 > @@ -5540,6 +5591,7 @@ static bool nl80211_valid_auth_type(struct 
cfg80211_registered_device *rdev,
 >   static int nl80211_start_ap(struct sk_buff *skb, struct genl_info 
*info)
 >   {
 >   	struct cfg80211_registered_device *rdev = info->user_ptr[0];
 > +	unsigned int link_id = nl80211_link_id(info->attrs);
 >   	struct net_device *dev = info->user_ptr[1];
 >   	struct wireless_dev *wdev = dev->ieee80211_ptr;
 >   	struct cfg80211_ap_settings *params;
 > @@ -5552,7 +5604,7 @@ static int nl80211_start_ap(struct sk_buff 
*skb, struct genl_info *info)
 >   	if (!rdev->ops->start_ap)
 >   		return -EOPNOTSUPP;
 >
 > -	if (wdev->beacon_interval)
 > +	if (wdev->links[link_id].beacon_interval)
 >   		return -EALREADY;
 >
 >   	/* these are required for START_AP */
 > @@ -5661,8 +5713,8 @@ static int nl80211_start_ap(struct sk_buff 
*skb, struct genl_info *info)
 >   		err = nl80211_parse_chandef(rdev, info, &params->chandef);
 >   		if (err)
 >   			goto out;
 > -	} else if (wdev->preset_chandef.chan) {
 > -		params->chandef = wdev->preset_chandef;
 > +	} else if (wdev->links[link_id].preset_chandef.chan) {
 > +		params->chandef = wdev->links[link_id].preset_chandef;
 >   	} else if (!nl80211_get_ap_channel(rdev, params)) {
 >   		err = -EINVAL;
 >   		goto out;
 > @@ -5678,7 +5730,7 @@ static int nl80211_start_ap(struct sk_buff 
*skb, struct genl_info *info)
 >   		err = nl80211_parse_tx_bitrate_mask(info, info->attrs,
 >   						    NL80211_ATTR_TX_RATES,
 >   						    &params->beacon_rate,
 > -						    dev, false);
 > +						    dev, false, link_id);
 >   		if (err)
 >   			goto out;
 >
 > @@ -5785,12 +5837,18 @@ static int nl80211_start_ap(struct sk_buff 
*skb, struct genl_info *info)
 >   	else if (info->attrs[NL80211_ATTR_EXTERNAL_AUTH_SUPPORT])
 >   		params->flags |= NL80211_AP_SETTINGS_EXTERNAL_AUTH_SUPPORT;
 >
 > +	/* FIXME: check that SSID(len) didn't change!
 > +	 * or - ugh - can it? what about multi-BSSID
 > +	 * where the transmitting BSSID/SSID might be
 > +	 * different on different links?
 > +	 */

May be this is not an issue? With mBSSID, start_ap will be called for 
each BSS part of the mBSSID group. Configurations like SSID will be for 
that particular BSS irrespective of whether that is transmitting or 
non-transmitting BSS.

 > +
 >   	wdev_lock(wdev);
 >   	err = rdev_start_ap(rdev, dev, params);
 >   	if (!err) {
 > -		wdev->preset_chandef = params->chandef;
 > -		wdev->beacon_interval = params->beacon_interval;
 > -		wdev->chandef = params->chandef;
 > +		wdev->links[link_id].preset_chandef = params->chandef;
 > +		wdev->links[link_id].beacon_interval = params->beacon_interval;
 > +		wdev->links[link_id].chandef = params->chandef;
 >   		wdev->ssid_len = params->ssid_len;
 >   		memcpy(wdev->ssid, params->ssid, wdev->ssid_len);
 >
 > @@ -5814,6 +5872,7 @@ out:
 >   static int nl80211_set_beacon(struct sk_buff *skb, struct genl_info 
*info)
 >   {
 >   	struct cfg80211_registered_device *rdev = info->user_ptr[0];
 > +	unsigned int link_id = nl80211_link_id(info->attrs);
 >   	struct net_device *dev = info->user_ptr[1];
 >   	struct wireless_dev *wdev = dev->ieee80211_ptr;
 >   	struct cfg80211_beacon_data params;
 > @@ -5826,7 +5885,7 @@ static int nl80211_set_beacon(struct sk_buff 
*skb, struct genl_info *info)
 >   	if (!rdev->ops->change_beacon)
 >   		return -EOPNOTSUPP;
 >
 > -	if (!wdev->beacon_interval)
 > +	if (!wdev->links[link_id].beacon_interval)
 >   		return -EINVAL;
 >
 >   	err = nl80211_parse_beacon(rdev, info->attrs, &params);
 > @@ -5845,9 +5904,10 @@ out:
 >   static int nl80211_stop_ap(struct sk_buff *skb, struct genl_info *info)
 >   {
 >   	struct cfg80211_registered_device *rdev = info->user_ptr[0];
 > +	unsigned int link_id = nl80211_link_id(info->attrs);
 >   	struct net_device *dev = info->user_ptr[1];
 >
 > -	return cfg80211_stop_ap(rdev, dev, false);
 > +	return cfg80211_stop_ap(rdev, dev, link_id, false);
 >   }
 >
 >   static const struct nla_policy 
sta_flags_policy[NL80211_STA_FLAG_MAX + 1] = {
 > @@ -8471,16 +8531,49 @@ int nl80211_parse_random_mac(struct nlattr 
**attrs,
 >   	return 0;
 >   }
 >
 > -static bool cfg80211_off_channel_oper_allowed(struct wireless_dev *wdev)
 > +static bool cfg80211_have_free_link(struct wiphy *wiphy,
 > +				    struct ieee80211_channel *target)
 > +{
 > +	// FIXME: use interface combinations data to check if we have the
 > +	//	  ability to use a separate HW resource for the given target
 > +	//	  channel, be it for scan, remain-on-channel, or operation
 > +	return false;
 > +}
 > +
 > +// FIXME: maybe rename to "on_same_resource" or something?
 > +static bool cfg80211_on_same_freq_range(struct wiphy *wiphy,
 > +					struct ieee80211_channel *chan1,
 > +					struct ieee80211_channel *chan2)
 > +{
 > +	// FIXME: use interface combinations data to check if the two
 > +	//	  channels are on the same hardware resource and can be
 > +	//	  (temporarily) committed to a new operation, or e.g.
 > +	//	  for channel switch
 > +
 > +	return true;
 > +}
 > +
 > +static bool cfg80211_off_channel_oper_allowed(struct wireless_dev *wdev,
 > +					      struct ieee80211_channel *chan)
 >   {
 >   	ASSERT_WDEV_LOCK(wdev);
 >
 >   	if (!cfg80211_beaconing_iface_active(wdev))
 >   		return true;
 >
 > -	if (!(wdev->chandef.chan->flags & IEEE80211_CHAN_RADAR))
 > +	if (cfg80211_have_free_link(wdev->wiphy, chan))
 >   		return true;
 >
 > +	for_each_active_link(wdev, l) {
 > +		/* we cannot leave radar channels */
 > +		if (wdev->links[l].chandef.chan->flags & IEEE80211_CHAN_RADAR)
 > +			continue;
 > +
 > +		if (cfg80211_on_same_freq_range(wdev->wiphy, chan,
 > +						wdev->links[l].chandef.chan))
 > +			return true;
 > +	}
 > +
 >   	return regulatory_pre_cac_allowed(wdev->wiphy);
 >   }
 >
 > @@ -8698,17 +8791,23 @@ static int nl80211_trigger_scan(struct 
sk_buff *skb, struct genl_info *info)
 >   	request->n_channels = i;
 >
 >   	wdev_lock(wdev);
 > -	if (!cfg80211_off_channel_oper_allowed(wdev)) {
 > -		struct ieee80211_channel *chan;
 > +	for (i = 0; i < request->n_channels; i++) {
 > +		struct ieee80211_channel *chan = request->channels[i];
 > +		bool found = false;
 >
 > -		if (request->n_channels != 1) {
 > -			wdev_unlock(wdev);
 > -			err = -EBUSY;
 > -			goto out_free;
 > +		/* if we can go off-channel to the target channel we're good */
 > +		if (cfg80211_off_channel_oper_allowed(wdev, chan))
 > +			continue;
 > +
 > +		/* otherwise see if we have a link on the target channel */
 > +		for_each_active_link(wdev, link_id) {
 > +			if (wdev->links[link_id].chandef.chan == chan) {
 > +				found = true;
 > +				break;
 > +			}
 >   		}
 >
 > -		chan = request->channels[0];
 > -		if (chan->center_freq != wdev->chandef.chan->center_freq) {
 > +		if (!found) {
 >   			wdev_unlock(wdev);
 >   			err = -EBUSY;
 >   			goto out_free;
 > @@ -9453,7 +9552,8 @@ static int nl80211_start_radar_detection(struct 
sk_buff *skb,
 >
 >   	err = rdev_start_radar_detection(rdev, dev, &chandef, cac_time_ms);
 >   	if (!err) {
 > -		wdev->chandef = chandef;
 > +// FIXME
 > +//		wdev->chandef = chandef;
 >   		wdev->cac_started = true;
 >   		wdev->cac_start_time = jiffies;
 >   		wdev->cac_time_ms = cac_time_ms;
 > @@ -9521,6 +9621,7 @@ static int 
nl80211_notify_radar_detection(struct sk_buff *skb,
 >   static int nl80211_channel_switch(struct sk_buff *skb, struct 
genl_info *info)
 >   {
 >   	struct cfg80211_registered_device *rdev = info->user_ptr[0];
 > +	unsigned int link_id = nl80211_link_id(info->attrs);
 >   	struct net_device *dev = info->user_ptr[1];
 >   	struct wireless_dev *wdev = dev->ieee80211_ptr;
 >   	struct cfg80211_csa_settings params;
 > @@ -9547,7 +9648,7 @@ static int nl80211_channel_switch(struct 
sk_buff *skb, struct genl_info *info)
 >   		need_handle_dfs_flag = false;
 >
 >   		/* useless if AP is not running */
 > -		if (!wdev->beacon_interval)
 > +		if (!wdev->links[link_id].beacon_interval)
 >   			return -ENOTCONN;
 >   		break;
 >   	case NL80211_IFTYPE_ADHOC:
 > @@ -11597,7 +11698,6 @@ static int nl80211_remain_on_channel(struct 
sk_buff *skb,
 >   	struct cfg80211_registered_device *rdev = info->user_ptr[0];
 >   	struct wireless_dev *wdev = info->user_ptr[1];
 >   	struct cfg80211_chan_def chandef;
 > -	const struct cfg80211_chan_def *compat_chandef;
 >   	struct sk_buff *msg;
 >   	void *hdr;
 >   	u64 cookie;
 > @@ -11627,11 +11727,29 @@ static int nl80211_remain_on_channel(struct 
sk_buff *skb,
 >   		return err;
 >
 >   	wdev_lock(wdev);
 > -	if (!cfg80211_off_channel_oper_allowed(wdev) &&
 > -	    !cfg80211_chandef_identical(&wdev->chandef, &chandef)) {
 > -		compat_chandef = cfg80211_chandef_compatible(&wdev->chandef,
 > -							     &chandef);
 > -		if (compat_chandef != &chandef) {
 > +	if (!cfg80211_off_channel_oper_allowed(wdev, chandef.chan)) {
 > +		bool have_matching_link = false;
 > +
 > +		/* Check if there's a link (must be active!) that has
 > +		 * the right chandef - actually the notion of active is
 > +		 * a bit redundant here, since we only get here for a
 > +		 * beaconing interface, where mostly active == valid
 > +		 * links, except perhaps during the phase where a new
 > +		 * link is added.
 > +		 */
 > +		for_each_active_link(wdev, link_id) {
 > +			/* note: returns first one if identical chandefs */
 > +			const struct cfg80211_chan_def *compat_chandef =
 > +				cfg80211_chandef_compatible(&chandef,
 > +							    &wdev->links[0].chandef);
 > +
 > +			if (compat_chandef == &chandef) {
 > +				have_matching_link = true;
 > +				break;
 > +			}
 > +		}
 > +
 > +		if (!have_matching_link) {
 >   			wdev_unlock(wdev);
 >   			return -EBUSY;
 >   		}
 > @@ -11692,6 +11810,7 @@ static int nl80211_set_tx_bitrate_mask(struct 
sk_buff *skb,
 >   				       struct genl_info *info)
 >   {
 >   	struct cfg80211_bitrate_mask mask;
 > +	unsigned int link_id = nl80211_link_id(info->attrs);
 >   	struct cfg80211_registered_device *rdev = info->user_ptr[0];
 >   	struct net_device *dev = info->user_ptr[1];
 >   	int err;
 > @@ -11701,10 +11820,11 @@ static int 
nl80211_set_tx_bitrate_mask(struct sk_buff *skb,
 >
 >   	err = nl80211_parse_tx_bitrate_mask(info, info->attrs,
 >   					    NL80211_ATTR_TX_RATES, &mask,
 > -					    dev, true);
 > +					    dev, true, link_id);
 >   	if (err)
 >   		return err;
 >
 > +	// FIXME: pass link_id!
 >   	return rdev_set_bitrate_mask(rdev, dev, NULL, &mask);
 >   }
 >
 > @@ -11827,7 +11947,8 @@ static int nl80211_tx_mgmt(struct sk_buff 
*skb, struct genl_info *info)
 >   		return -EINVAL;
 >
 >   	wdev_lock(wdev);
 > -	if (params.offchan && !cfg80211_off_channel_oper_allowed(wdev)) {
 > +	if (params.offchan &&
 > +	    !cfg80211_off_channel_oper_allowed(wdev, chandef.chan)) {
 >   		wdev_unlock(wdev);
 >   		return -EBUSY;
 >   	}
 > @@ -12313,7 +12434,7 @@ static int nl80211_join_mesh(struct sk_buff 
*skb, struct genl_info *info)
 >   		err = nl80211_parse_tx_bitrate_mask(info, info->attrs,
 >   						    NL80211_ATTR_TX_RATES,
 >   						    &setup.beacon_rate,
 > -						    dev, false);
 > +						    dev, false, 0);
 >   		if (err)
 >   			return err;
 >
 > @@ -14908,12 +15029,14 @@ static int 
nl80211_get_ftm_responder_stats(struct sk_buff *skb,
 >   	struct net_device *dev = info->user_ptr[1];
 >   	struct wireless_dev *wdev = dev->ieee80211_ptr;
 >   	struct cfg80211_ftm_responder_stats ftm_stats = {};
 > +	unsigned int link_id = nl80211_link_id(info->attrs);
 >   	struct sk_buff *msg;
 >   	void *hdr;
 >   	struct nlattr *ftm_stats_attr;
 >   	int err;
 >
 > -	if (wdev->iftype != NL80211_IFTYPE_AP || !wdev->beacon_interval)
 > +	if (wdev->iftype != NL80211_IFTYPE_AP ||
 > +	    !wdev->links[link_id].beacon_interval)
 >   		return -EOPNOTSUPP;
 >
 >   	err = rdev_get_ftm_responder_stats(rdev, dev, &ftm_stats);
 > @@ -15043,7 +15166,8 @@ static int nl80211_probe_mesh_link(struct 
sk_buff *skb, struct genl_info *info)
 >   static int parse_tid_conf(struct cfg80211_registered_device *rdev,
 >   			  struct nlattr *attrs[], struct net_device *dev,
 >   			  struct cfg80211_tid_cfg *tid_conf,
 > -			  struct genl_info *info, const u8 *peer)
 > +			  struct genl_info *info, const u8 *peer,
 > +			  unsigned int link_id)
 >   {
 >   	struct netlink_ext_ack *extack = genl_info_extack(info);
 >   	u64 mask;
 > @@ -15118,7 +15242,7 @@ static int parse_tid_conf(struct 
cfg80211_registered_device *rdev,
 >   			attr = NL80211_TID_CONFIG_ATTR_TX_RATE;
 >   			err = nl80211_parse_tx_bitrate_mask(info, attrs, attr,
 >   						    &tid_conf->txrate_mask, dev,
 > -						    true);
 > +						    true, link_id);
 >   			if (err)
 >   				return err;
 >
 > @@ -15145,6 +15269,7 @@ static int nl80211_set_tid_config(struct 
sk_buff *skb,
 >   {
 >   	struct cfg80211_registered_device *rdev = info->user_ptr[0];
 >   	struct nlattr *attrs[NL80211_TID_CONFIG_ATTR_MAX + 1];
 > +	unsigned int link_id = nl80211_link_id(info->attrs);
 >   	struct net_device *dev = info->user_ptr[1];
 >   	struct cfg80211_tid_config *tid_config;
 >   	struct nlattr *tid;
 > @@ -15182,7 +15307,7 @@ static int nl80211_set_tid_config(struct 
sk_buff *skb,
 >
 >   		ret = parse_tid_conf(rdev, attrs, dev,
 >   				     &tid_config->tid_conf[conf_idx],
 > -				     info, tid_config->peer);
 > +				     info, tid_config->peer, link_id);
 >   		if (ret)
 >   			goto bad_tid_conf;
 >
 > @@ -15333,6 +15458,7 @@ static int nl80211_set_fils_aad(struct 
sk_buff *skb,
 >   					 NL80211_FLAG_CHECK_NETDEV_UP)
 >   #define NL80211_FLAG_CLEAR_SKB		0x20
 >   #define NL80211_FLAG_NO_WIPHY_MTX	0x40
 > +#define NL80211_FLAG_MLO_VALID_LINK_ID	0x80
 >
 >   #define INTERNAL_FLAG_SELECTORS(__sel)			\
 >   	SELECTOR(__sel, NONE, 0) /* must be first */	\
 > @@ -15342,6 +15468,9 @@ static int nl80211_set_fils_aad(struct 
sk_buff *skb,
 >   		 NL80211_FLAG_NEED_WDEV)		\
 >   	SELECTOR(__sel, NETDEV,				\
 >   		 NL80211_FLAG_NEED_NETDEV)		\
 > +	SELECTOR(__sel, NETDEV_LINK,			\
 > +		 NL80211_FLAG_NEED_NETDEV |		\
 > +		 NL80211_FLAG_MLO_VALID_LINK_ID)	\
 >   	SELECTOR(__sel, WIPHY_RTNL,			\
 >   		 NL80211_FLAG_NEED_WIPHY |		\
 >   		 NL80211_FLAG_NEED_RTNL)		\
 > @@ -15357,6 +15486,9 @@ static int nl80211_set_fils_aad(struct 
sk_buff *skb,
 >   		 NL80211_FLAG_NEED_RTNL)		\
 >   	SELECTOR(__sel, NETDEV_UP,			\
 >   		 NL80211_FLAG_NEED_NETDEV_UP)		\
 > +	SELECTOR(__sel, NETDEV_UP_LINK,			\
 > +		 NL80211_FLAG_NEED_NETDEV_UP |		\
 > +		 NL80211_FLAG_MLO_VALID_LINK_ID)	\
 >   	SELECTOR(__sel, NETDEV_UP_NOTMX,		\
 >   		 NL80211_FLAG_NEED_NETDEV_UP |		\
 >   		 NL80211_FLAG_NO_WIPHY_MTX)		\
 > @@ -15388,9 +15520,10 @@ static int nl80211_pre_doit(const struct 
genl_ops *ops, struct sk_buff *skb,
 >   			    struct genl_info *info)
 >   {
 >   	struct cfg80211_registered_device *rdev = NULL;
 > -	struct wireless_dev *wdev;
 > -	struct net_device *dev;
 > +	struct wireless_dev *wdev = NULL;
 > +	struct net_device *dev = NULL;
 >   	u32 internal_flags;
 > +	int err;
 >
 >   	if (WARN_ON(ops->internal_flags >= 
ARRAY_SIZE(nl80211_internal_flags)))
 >   		return -EINVAL;
 > @@ -15406,8 +15539,8 @@ static int nl80211_pre_doit(const struct 
genl_ops *ops, struct sk_buff *skb,
 >   	if (internal_flags & NL80211_FLAG_NEED_WIPHY) {
 >   		rdev = cfg80211_get_dev_from_info(genl_info_net(info), info);
 >   		if (IS_ERR(rdev)) {
 > -			rtnl_unlock();
 > -			return PTR_ERR(rdev);
 > +			err = PTR_ERR(rdev);
 > +			goto out_unlock;
 >   		}
 >   		info->user_ptr[0] = rdev;
 >   	} else if (internal_flags & NL80211_FLAG_NEED_NETDEV ||
 > @@ -15415,8 +15548,8 @@ static int nl80211_pre_doit(const struct 
genl_ops *ops, struct sk_buff *skb,
 >   		wdev = __cfg80211_wdev_from_attrs(NULL, genl_info_net(info),
 >   						  info->attrs);
 >   		if (IS_ERR(wdev)) {
 > -			rtnl_unlock();
 > -			return PTR_ERR(wdev);
 > +			err = PTR_ERR(wdev);
 > +			goto out_unlock;
 >   		}
 >
 >   		dev = wdev->netdev;
 > @@ -15424,8 +15557,8 @@ static int nl80211_pre_doit(const struct 
genl_ops *ops, struct sk_buff *skb,
 >
 >   		if (internal_flags & NL80211_FLAG_NEED_NETDEV) {
 >   			if (!dev) {
 > -				rtnl_unlock();
 > -				return -EINVAL;
 > +				err = -EINVAL;
 > +				goto out_unlock;
 >   			}
 >
 >   			info->user_ptr[1] = dev;
 > @@ -15435,14 +15568,37 @@ static int nl80211_pre_doit(const struct 
genl_ops *ops, struct sk_buff *skb,
 >
 >   		if (internal_flags & NL80211_FLAG_CHECK_NETDEV_UP &&
 >   		    !wdev_running(wdev)) {
 > -			rtnl_unlock();
 > -			return -ENETDOWN;
 > +			err = -ENETDOWN;
 > +			goto out_unlock;
 >   		}
 >
 >   		dev_hold(dev);
 >   		info->user_ptr[0] = rdev;
 >   	}
 >
 > +	if (internal_flags & NL80211_FLAG_MLO_VALID_LINK_ID) {
 > +		struct nlattr *link_id = info->attrs[NL80211_ATTR_MLO_LINK_ID];
 > +
 > +		if (!wdev) {
 > +			err = -EINVAL;
 > +			goto out_unlock;
 > +		}
 > +
 > +		/* MLO -> require valid link ID */
 > +		if (wdev->valid_links &&
 > +		    (!link_id ||
 > +		     !(wdev->valid_links & BIT(nla_get_u16(link_id))))) {
 > +			err = -EINVAL;
 > +			goto out_unlock;
 > +		}
 > +
 > +		/* non-MLO -> no link ID attribute accepted */
 > +		if (!wdev->valid_links && link_id) {

Isn't that we hit this condition when adding the very first link to the 
MLD using NL80211_CMD_ADD_LINK?

Vasanth
