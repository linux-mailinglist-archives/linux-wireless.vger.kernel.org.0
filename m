Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4023A2A9387
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Nov 2020 11:00:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726600AbgKFKAX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 6 Nov 2020 05:00:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726074AbgKFKAX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 6 Nov 2020 05:00:23 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CF6AC0613CF
        for <linux-wireless@vger.kernel.org>; Fri,  6 Nov 2020 02:00:23 -0800 (PST)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1kayXd-002DDq-BR; Fri, 06 Nov 2020 11:00:21 +0100
Message-ID: <b07e4f654a090b6b721f8c474eae58426569cbfa.camel@sipsolutions.net>
Subject: Re: [PATCH V6 2/3] mac80211: add support for BSS color change
From:   Johannes Berg <johannes@sipsolutions.net>
To:     John Crispin <john@phrozen.org>
Cc:     linux-wireless@vger.kernel.org
Date:   Fri, 06 Nov 2020 11:00:20 +0100
In-Reply-To: <20201103092244.1925158-3-john@phrozen.org>
References: <20201103092244.1925158-1-john@phrozen.org>
         <20201103092244.1925158-3-john@phrozen.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, 2020-11-03 at 10:22 +0100, John Crispin wrote:
> 
> @@ -6805,4 +6822,15 @@ struct sk_buff *ieee80211_get_fils_discovery_tmpl(struct ieee80211_hw *hw,
>  struct sk_buff *
>  ieee80211_get_unsol_bcast_probe_resp_tmpl(struct ieee80211_hw *hw,
>  					  struct ieee80211_vif *vif);
> +/**
> + * ieeee80211_obss_color_collision_notify notify userland about a BSS color
> + * collision.

missing a "-" here

> +static void ieee80211_color_change_bss_config_notify(struct ieee80211_sub_if_data *sdata,
> +						     u8 color, int enable, u32 changed)
> +{
> +	sdata->vif.bss_conf.he_bss_color.color = color;
> +	sdata->vif.bss_conf.he_bss_color.enabled = enable;
> +	changed |= BSS_CHANGED_HE_BSS_COLOR;
> +
> +	ieee80211_bss_info_change_notify(sdata, changed);
> +
> +	if (ieee80211_hw_check(&sdata->local->hw, SUPPORTS_MULTI_BSSID_AP) &&
> +	    !sdata->vif.multiple_bssid.parent) {
> +		struct ieee80211_sub_if_data *child;
> +
> +		rcu_read_lock();
> +		list_for_each_entry_rcu(child, &sdata->local->interfaces, list) {
> +			if (child->vif.multiple_bssid.parent != &sdata->vif)
> +				continue;
> +			sdata_lock(child);

Err, you can't lock a mutex in an atomic context opened by
rcu_read_lock().

I guess you can just take the iflist_mtx or something, but this
certainly doesn't seem right.

Also, since it's being called under sdata_lock(parent), it'll need some
lockdep annotations to be able to do this.

> +			child->vif.bss_conf.he_bss_color.color = color;
> +			child->vif.bss_conf.he_bss_color.enabled = enable;
> +			ieee80211_bss_info_change_notify(child, BSS_CHANGED_HE_BSS_COLOR);

And the driver is also allowed to sleep in this IIRC, so you can't call
it under rcu_read_lock().

johannes

