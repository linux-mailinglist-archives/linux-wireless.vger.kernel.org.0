Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBD783B1E2B
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Jun 2021 17:58:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231436AbhFWQAR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 23 Jun 2021 12:00:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230430AbhFWQAQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 23 Jun 2021 12:00:16 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDA1EC061574
        for <linux-wireless@vger.kernel.org>; Wed, 23 Jun 2021 08:57:58 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94.2)
        (envelope-from <johannes@sipsolutions.net>)
        id 1lw5GG-00AcMv-TX; Wed, 23 Jun 2021 17:57:57 +0200
Message-ID: <6dc09b7dcfef37a703e95e264e6ab64738560160.camel@sipsolutions.net>
Subject: Re: [PATCH v10 2/4] mac80211: multiple bssid support in interface
 handling
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Aloka Dixit <alokad@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org, John Crispin <john@phrozen.org>
Date:   Wed, 23 Jun 2021 17:57:56 +0200
In-Reply-To: <20210426190534.12667-3-alokad@codeaurora.org>
References: <20210426190534.12667-1-alokad@codeaurora.org>
         <20210426190534.12667-3-alokad@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, 2021-04-26 at 12:05 -0700, Aloka Dixit wrote:
> 
> + * @IEEE80211_HW_SUPPORTS_MBSSID_AP: Hardware supports multiple BSSID
> + *	advertisements in AP mode.
> + * @IEEE80211_HW_SUPPORTS_EMA_AP: Hardware supports enhanced multiple BSSID
> + *	advertisements in AP mode.

Is there a good reason for these - the driver can just set the extended
nl80211 flags instead and we can check, or nl80211 already checked?
> 

> +static int ieee80211_set_mbssid_options(struct ieee80211_sub_if_data *sdata,
> +					struct cfg80211_mbssid_config params)
> +{
> +	struct ieee80211_local *local = sdata->local;
> +	struct wiphy *wiphy = local->hw.wiphy;
> +	struct net_device *parent;
> +	struct ieee80211_sub_if_data *psdata;
> +
> +	if (!params.count || sdata->vif.type != NL80211_IFTYPE_AP ||
> +	    !ieee80211_hw_check(&local->hw, SUPPORTS_MBSSID_AP))
> +		return -EINVAL;
> +
> +	sdata->vif.mbssid.parent = NULL;
> +	sdata->vif.mbssid.flags = IEEE80211_VIF_MBSSID_TX;
> +	if (params.parent) {
> +		parent = __dev_get_by_index(wiphy_net(wiphy), params.parent);
> +		if (!parent || !parent->ieee80211_ptr)
> +			return -EINVAL;


Hm wait, didn't I see the same code in cfg80211 - maybe cfg80211 should
just pass the pointer?
> 
>  static int ieee80211_del_iface(struct wiphy *wiphy, struct wireless_dev *wdev)
>  {
> +	struct ieee80211_sub_if_data *sdata = IEEE80211_WDEV_TO_SUB_IF(wdev);
> +	struct ieee80211_local *local;
> +	struct ieee80211_vif *vif;
> +
> +	if (!sdata)
> +		return 0;
> +
> +	local = sdata->local;
> +	vif = &sdata->vif;
> +	if (vif->type == NL80211_IFTYPE_AP &&
> +	    ieee80211_hw_check(&local->hw, SUPPORTS_MBSSID_AP)) {
> +		if (vif->mbssid.flags & IEEE80211_VIF_MBSSID_TX) {
> +			struct ieee80211_sub_if_data *child, *tmpsdata;
> +
> +			wiphy_unlock(local->hw.wiphy);
> +			mutex_lock(&local->iflist_mtx);

I really don't think you can drop the locking like that in the middle of
something. That's almost always a recipe for disaster.

> @@ -375,6 +375,18 @@ static void ieee80211_do_stop(struct ieee80211_sub_if_data *sdata, bool going_do
>  	struct cfg80211_chan_def chandef;
>  	bool cancel_scan;
>  	struct cfg80211_nan_func *func;
> +	struct ieee80211_sub_if_data *parent;
> +
> +	if (sdata->vif.type == NL80211_IFTYPE_AP &&
> +	    ieee80211_hw_check(&local->hw, SUPPORTS_MBSSID_AP) &&
> +	    sdata->vif.mbssid.flags & IEEE80211_VIF_MBSSID_NON_TX) {
> +		parent = vif_to_sdata(sdata->vif.mbssid.parent);
> +		if (parent && ieee80211_sdata_running(parent)) {
> +			wiphy_unlock(local->hw.wiphy);
> +			dev_close(parent->wdev.netdev);
> +			wiphy_lock(local->hw.wiphy);

Same here.

johannes

