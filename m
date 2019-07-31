Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1BAB07BD3D
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Jul 2019 11:34:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727160AbfGaJeM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 31 Jul 2019 05:34:12 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:55604 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726651AbfGaJeM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 31 Jul 2019 05:34:12 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <johannes@sipsolutions.net>)
        id 1hskzo-0004lO-Sc; Wed, 31 Jul 2019 11:34:08 +0200
Message-ID: <7aa18e9e89743f3b4a188c8e677aad203a3ef2db.camel@sipsolutions.net>
Subject: Re: [PATCHv6 6/9] mac80211: Add api to support configuring TID
 specific configuration
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Tamizh chelvam <tamizhr@codeaurora.org>, ath10k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Date:   Wed, 31 Jul 2019 11:34:07 +0200
In-Reply-To: <1560835632-17405-7-git-send-email-tamizhr@codeaurora.org>
References: <1560835632-17405-1-git-send-email-tamizhr@codeaurora.org>
         <1560835632-17405-7-git-send-email-tamizhr@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, 2019-06-18 at 10:57 +0530, Tamizh chelvam wrote:
> 
> @@ -1626,6 +1635,14 @@ struct ieee80211_vif {
>  
>  	bool txqs_stopped[IEEE80211_NUM_ACS];
>  
> +	int noack[IEEE80211_TID_MAX];
> +	int retry_short[IEEE80211_TID_MAX];
> +	int retry_long[IEEE80211_TID_MAX];
> +	int ampdu[IEEE80211_TID_MAX];
> +	u8 rate_ctrl[IEEE80211_TID_MAX];
> +	u32 rate_code[IEEE80211_TID_MAX];
> +	u8 rtscts[IEEE80211_TID_MAX];

This is quite a bit of data (176 bytes), can we make it up to the driver
to store it if supported, instead?

> @@ -2004,6 +2027,13 @@ struct ieee80211_sta {
>  
>  	struct ieee80211_txq *txq[IEEE80211_NUM_TIDS + 1];
>  
> +	int noack[IEEE80211_TID_MAX];
> +	int retry_short[IEEE80211_TID_MAX];
> +	int retry_long[IEEE80211_TID_MAX];
> +	int ampdu[IEEE80211_TID_MAX];
> +	u8 rate_ctrl[IEEE80211_TID_MAX];
> +	u8 rtscts[IEEE80211_TID_MAX];

same here.

> +static int ieee80211_set_tid_config(struct wiphy *wiphy,
> +				    struct net_device *dev,
> +				    struct ieee80211_tid_config *tid_conf)
> +{
> +	struct ieee80211_sub_if_data *sdata = IEEE80211_DEV_TO_SUB_IF(dev);
> +	struct sta_info *sta;
> +	int ret;
> +
> +	if (!sdata->local->ops->set_tid_config)
> +		return -EOPNOTSUPP;
> +
> +	if (!tid_conf->peer)
> +		return drv_set_tid_config(sdata->local, sdata, NULL, tid_conf);
> +
> +	mutex_lock(&sdata->local->sta_mtx);
> +
> +	sta = sta_info_get_bss(sdata, tid_conf->peer);
> +	if (!sta) {
> +		mutex_unlock(&sdata->local->sta_mtx);
> +		return -ENOENT;
> +	}
> +
> +	ret = drv_set_tid_config(sdata->local, sdata, &sta->sta, tid_conf);
> +	mutex_unlock(&sdata->local->sta_mtx);
> +	return ret;
> +}

and you're not actually using the data anyway?

johannes

