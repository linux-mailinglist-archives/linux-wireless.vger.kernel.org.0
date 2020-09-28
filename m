Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5F6C27ADA7
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Sep 2020 14:18:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726500AbgI1MSG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 28 Sep 2020 08:18:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726409AbgI1MSG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 28 Sep 2020 08:18:06 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA1B2C061755
        for <linux-wireless@vger.kernel.org>; Mon, 28 Sep 2020 05:18:05 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1kMs6V-00CTLy-FA; Mon, 28 Sep 2020 14:18:03 +0200
Message-ID: <1a2ed6b74cf7604c717791bd6cb9e65b49f4a654.camel@sipsolutions.net>
Subject: Re: [PATCH v4 14/17] mac80211: support S1G association
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Thomas Pedersen <thomas@adapt-ip.com>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>
Date:   Mon, 28 Sep 2020 14:17:57 +0200
In-Reply-To: <20200922022818.15855-15-thomas@adapt-ip.com>
References: <20200922022818.15855-1-thomas@adapt-ip.com>
         <20200922022818.15855-15-thomas@adapt-ip.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


> @@ -176,6 +177,15 @@ ieee80211_determine_chantype(struct ieee80211_sub_if_data *sdata,
>  	memcpy(&sta_ht_cap, &sband->ht_cap, sizeof(sta_ht_cap));
>  	ieee80211_apply_htcap_overrides(sdata, &sta_ht_cap);
>  
> +	if (s1g_oper && sband->band == NL80211_BAND_S1GHZ) {
> +		ieee80211_chandef_s1g_oper(s1g_oper, chandef);
> +		ret = IEEE80211_STA_DISABLE_HT | IEEE80211_STA_DISABLE_40MHZ |
> +		      IEEE80211_STA_DISABLE_VHT |
> +		      IEEE80211_STA_DISABLE_80P80MHZ |
> +		      IEEE80211_STA_DISABLE_160MHZ;
> +		goto out;
> +	}

I've applied this now (and made some changes in a few patches, please
check), but this particular thing seems a bit odd, in that it looks for
HT/VHT elements even on an S1G channel if the s1g oper element isn't
present? That seems like it shouldn't be the case, can you take a look?

johannes

