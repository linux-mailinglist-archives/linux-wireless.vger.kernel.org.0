Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C30E93EEBC9
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Aug 2021 13:34:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236792AbhHQLem (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 17 Aug 2021 07:34:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231515AbhHQLel (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 17 Aug 2021 07:34:41 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F728C061764
        for <linux-wireless@vger.kernel.org>; Tue, 17 Aug 2021 04:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=due7ziju01rtb98wwFf4NAjAb1qaKyv7ZY7KzUweqjA=;
        t=1629200048; x=1630409648; b=IkcTeH6UDcUyZ4MgM2L2b3METw6ui3SlMM0ZDcx4PjRU+pZ
        6vL5uQq4S7fSOAHhuQjlBDfye4VSxiZFylSu7kvh8uVV11V7vn5YyRtbvHr5gqt5wey/33+3v/zyt
        GALl252Jvz2rvp7AmRfXBoUj6WAhF7pIyP1g6bq3RNjnOrYGv8DgjTQXcaJZ/aSjW4DE+yRz6obkA
        2k5YxeC4dm76UCmrKIUBcdK4jRZ12dpV9dfK+EfoxaqF5rDAor9a4obQArOh9mQvwm206QJxwiO+h
        AeqAn9liqB27EtgEmF/yXbr+YKOEMSDPhYCvWEZ42+RU0AdSTm0cNyTT715hFp+g==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94.2)
        (envelope-from <johannes@sipsolutions.net>)
        id 1mFxM1-00CF1d-QF; Tue, 17 Aug 2021 13:34:01 +0200
Message-ID: <ece8459373db3b76d38a583ec43f73e65d62a6c0.camel@sipsolutions.net>
Subject: Re: [PATCH v2 mac80211-next 2/7] mac80211: introduce individual TWT
 support in AP mode.
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Lorenzo Bianconi <lorenzo@kernel.org>, nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        ryder.lee@mediatek.com, chui-hao.chiu@mediatek.com
Date:   Tue, 17 Aug 2021 13:34:00 +0200
In-Reply-To: <e3b70c37cb366399e944a0aa02f0d7cac25b4bb6.1628529781.git.lorenzo@kernel.org>
References: <cover.1628529781.git.lorenzo@kernel.org>
         <e3b70c37cb366399e944a0aa02f0d7cac25b4bb6.1628529781.git.lorenzo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

> 
> +static inline void drv_add_twt_setup(struct ieee80211_local *local,
> +				     struct ieee80211_sub_if_data *sdata,
> +				     struct ieee80211_sta *sta,
> +				     struct ieee80211_twt_params *agrt_req,
> +				     struct ieee80211_twt_params *agrt_resp)
> +{
> +	might_sleep();
> +	check_sdata_in_driver(sdata);
> +
> +	local->ops->add_twt_setup(&local->hw, sta, agrt_req, agrt_resp);
> +}
> +
> +static inline void drv_twt_teardown_request(struct ieee80211_local *local,
> +					    struct ieee80211_sub_if_data *sdata,
> +					    struct ieee80211_sta *sta,
> +					    u8 flowid)
> +{
> +	might_sleep();
> +	check_sdata_in_driver(sdata);
> +
> +	if (local->ops->twt_teardown_request)
> +		local->ops->twt_teardown_request(&local->hw, sta, flowid);
> +}

These should have tracing.

> +++ b/net/mac80211/iface.c
> @@ -1381,6 +1381,19 @@ static void ieee80211_iface_process_skb(struct ieee80211_local *local,
>  			WARN_ON(1);
>  			break;
>  		}
> +	} else if (ieee80211_is_action(mgmt->frame_control) &&
> +		   mgmt->u.action.category == WLAN_CATEGORY_S1G) {
> +		switch (mgmt->u.action.u.s1g.action_code) {
> +		case WLAN_S1G_TWT_TEARDOWN:
> +		case WLAN_S1G_TWT_SETUP:
> +			if (skb->pkt_type == IEEE80211_TX_STATUS_MSG)
> +				ieee80211_s1g_status_h_twt(sdata, skb);
> +			else
> +				ieee80211_s1g_rx_h_twt(sdata, skb);


I *really* don't like what you're doing here with the sdata->skb_queue,
which we only ever use for RX today.

We have today ieee80211_mgd_conn_tx_status() that gets called at the
right place, so you should add stuff there, and perhaps it needs to
queue things, or mark a separate TWT data structure before queueing the
work, or something else - but please don't use the RX skb_queue.

> 
> +static ieee80211_rx_result debug_noinline
> +ieee80211_rx_h_twt(struct ieee80211_rx_data *rx)

Please rename this - it's not actually an rx_h_ that's called through
the normal RX handler stuff, it's just a sub-function for the action RX
handler.

It also doesn't need the rx_result, it can just be bool/int.

> +	case WLAN_CATEGORY_S1G:
> +		switch (mgmt->u.action.u.s1g.action_code) {
> +		case WLAN_S1G_TWT_SETUP:
> +		case WLAN_S1G_TWT_TEARDOWN:
> +			if (ieee80211_rx_h_twt(rx) != RX_CONTINUE)
> +				goto queue;


(see here)

> +		default:

Also missing a "fallthrough" annotation or such.

> +
> +static int
> +ieee80211_s1g_rx_h_twt_teardown(struct ieee80211_sub_if_data *sdata,
> +				struct sta_info *sta, struct sk_buff *skb)
> +{
> +	struct ieee80211_mgmt *mgmt = (struct ieee80211_mgmt *)skb->data;
> +
> +	drv_twt_teardown_request(sdata->local, sdata, &sta->sta,
> +				 mgmt->u.action.u.s1g.variable[0]);
> +
> +	return 0;

Evidently, this cannot fail, so needs no return value.

> +void ieee80211_s1g_rx_h_twt(struct ieee80211_sub_if_data *sdata,
> +			    struct sk_buff *skb)

again, not a real RX handler

> +{
> +	struct ieee80211_mgmt *mgmt = (struct ieee80211_mgmt *)skb->data;
> +	struct ieee80211_local *local = sdata->local;
> +	struct sta_info *sta;
> +
> +	mutex_lock(&local->sta_mtx);
> +
> +	sta = sta_info_get_bss(sdata, mgmt->sa);
> +	if (!sta)
> +		goto out;
> +
> +	switch (mgmt->u.action.u.s1g.action_code) {
> +	case WLAN_S1G_TWT_SETUP:
> +		ieee80211_s1g_rx_h_twt_setup(sdata, sta, skb);

You're completely ignoring the return value. That's probably fine in the
-ENOMEM case, but the other cases you should still send a response. Just
like the driver callback is void because it should just fill in the
response to the other side (even in the failure cases).

johannes

