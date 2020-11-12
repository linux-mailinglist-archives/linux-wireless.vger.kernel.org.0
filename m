Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 357232B0330
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Nov 2020 11:55:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726107AbgKLKzL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 12 Nov 2020 05:55:11 -0500
Received: from z5.mailgun.us ([104.130.96.5]:21630 "EHLO z5.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725902AbgKLKzL (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 12 Nov 2020 05:55:11 -0500
X-Mailgun-Sending-Ip: 104.130.96.5
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-east-1.postgun.com with SMTP id
 5fad148ef2d9c8cbca569baf (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 12 Nov 2020 10:55:10
 GMT
Sender: wgong=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id D7ECDC433F0; Thu, 12 Nov 2020 10:55:09 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: wgong)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id AC67FC433C8;
        Thu, 12 Nov 2020 10:55:08 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Thu, 12 Nov 2020 18:55:08 +0800
From:   Wen Gong <wgong@codeaurora.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org, kirtika@google.com,
        Johannes Berg <johannes.berg@intel.com>,
        linux-wireless-owner@vger.kernel.org, ath11k@lists.infradead.org,
        ath10k@lists.infradead.org
Subject: Re: [PATCH v2] mac80211: reject/clear user rate mask if not usable
In-Reply-To: <20170308132022.4216-1-johannes@sipsolutions.net>
 (sfid-20170308_142122_587641_AAD67C42)
References: <20170308132022.4216-1-johannes@sipsolutions.net>
 (sfid-20170308_142122_587641_AAD67C42)
Message-ID: <07179008e9369bc81e152009ca85191d@codeaurora.org>
X-Sender: wgong@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2017-03-08 21:20, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> If the user rate mask results in no (basic) rates being usable,
> clear it. Also, if we're already operating when it's set, reject
> it instead.
> 
> Technically, selecting basic rates as the criterion is a bit too
> restrictive, but calculating the usable rates over all stations
> (e.g. in AP mode) is harder, and all stations must support the
> basic rates. Similarly, in client mode, the basic rates will be
> used anyway for control frames.
> 
> This fixes the "no supported rates (...) in rate_mask ..." warning
> that occurs on TX when you've selected a rate mask that's not
> compatible with the connection (e.g. an AP that enables only the
> rates 36, 48, 54 and you've selected only 6, 9, 12.)
> 
> Reported-by: Kirtika Ruchandani <kirtika@google.com>
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> ---
>  net/mac80211/cfg.c  | 18 +++++++++++++++++-
>  net/mac80211/mlme.c |  2 ++
>  net/mac80211/rate.c | 27 +++++++++++++++++++++++++++
>  net/mac80211/rate.h |  2 ++
>  4 files changed, 48 insertions(+), 1 deletion(-)
> 
> diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
> index 9c7490cb2243..8bc3d3669348 100644
> --- a/net/mac80211/cfg.c
> +++ b/net/mac80211/cfg.c
> @@ -3,7 +3,7 @@
>   *
>   * Copyright 2006-2010	Johannes Berg <johannes@sipsolutions.net>
>   * Copyright 2013-2015  Intel Mobile Communications GmbH
> - * Copyright (C) 2015-2016 Intel Deutschland GmbH
> + * Copyright (C) 2015-2017 Intel Deutschland GmbH
>   *
>   * This file is GPLv2 as found in COPYING.
>   */
> @@ -2042,6 +2042,7 @@ static int ieee80211_change_bss(struct wiphy 
> *wiphy,
>  					 params->basic_rates_len,
>  					 &sdata->vif.bss_conf.basic_rates);
>  		changed |= BSS_CHANGED_BASIC_RATES;
> +		ieee80211_check_rate_mask(sdata);
>  	}
> 
>  	if (params->ap_isolate >= 0) {
> @@ -2685,6 +2686,21 @@ static int ieee80211_set_bitrate_mask(struct
> wiphy *wiphy,
>  			return ret;
>  	}
> 
> +	/*
> +	 * If active validate the setting and reject it if it doesn't leave
> +	 * at least one basic rate usable, since we really have to be able
> +	 * to send something, and if we're an AP we have to be able to do
> +	 * so at a basic rate so that all clients can receive it.
> +	 */
> +	if (rcu_access_pointer(sdata->vif.chanctx_conf) &&
> +	    sdata->vif.bss_conf.chandef.chan) {
> +		u32 basic_rates = sdata->vif.bss_conf.basic_rates;
> +		enum nl80211_band band = sdata->vif.bss_conf.chandef.chan->band;
> +
> +		if (!(mask->control[band].legacy & basic_rates))
> +			return -EINVAL;
If user want to use “iw wlan0 set bitrates legacy-5 54” to set it to 
fixed in 54M and 54M is
not basic rate in AP's becaon as example of below, then the iw command 
will fail.

Tag: Supported Rates 6(B), 9, 12(B), 18, 24(B), 36, 48, 54, [Mbit/sec]
     Tag Number: Supported Rates (1)
     Tag length: 8
     Supported Rates: 6(B) (0x8c)
     Supported Rates: 9 (0x12)
     Supported Rates: 12(B) (0x98)
     Supported Rates: 18 (0x24)
     Supported Rates: 24(B) (0xb0)
     Supported Rates: 36 (0x48)
     Supported Rates: 48 (0x60)
     Supported Rates: 54 (0x6c)

> +	}
> +
>  	for (i = 0; i < NUM_NL80211_BANDS; i++) {
>  		struct ieee80211_supported_band *sband = wiphy->bands[i];
>  		int j;
...
