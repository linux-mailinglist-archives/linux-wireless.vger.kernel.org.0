Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6175A1E460F
	for <lists+linux-wireless@lfdr.de>; Wed, 27 May 2020 16:37:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389337AbgE0OhE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 27 May 2020 10:37:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389335AbgE0OhD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 27 May 2020 10:37:03 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 380D8C05BD1E
        for <linux-wireless@vger.kernel.org>; Wed, 27 May 2020 07:37:03 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1jdxAz-004A8x-H2; Wed, 27 May 2020 16:37:01 +0200
Message-ID: <80dbbfa0c72b92d4b30e234215f7978c3cbe433e.camel@sipsolutions.net>
Subject: Re: [PATCH v3 07/11] mac80211: add HE 6 GHz Band Capability IE in
 Assoc. Request
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Rajkumar Manoharan <rmanohar@codeaurora.org>, kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org, ath11k@lists.infradead.org
Date:   Wed, 27 May 2020 16:37:00 +0200
In-Reply-To: <1589399105-25472-7-git-send-email-rmanohar@codeaurora.org>
References: <1589399105-25472-1-git-send-email-rmanohar@codeaurora.org>
         <1589399105-25472-7-git-send-email-rmanohar@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.2 (3.36.2-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, 2020-05-13 at 12:45 -0700, Rajkumar Manoharan wrote:

> +int mesh_add_he_6ghz_cap_ie(struct ieee80211_sub_if_data *sdata,
> +			    struct sk_buff *skb)
> +{
> +	const struct ieee80211_sta_he_cap *he_cap;
> +	struct ieee80211_supported_band *sband;
> +	u8 ie_len;
> +	u8 *pos;
> +
> +	sband = ieee80211_get_sband(sdata);
> +	if (!sband)
> +		return -EINVAL;
> +
> +	he_cap = ieee80211_get_he_iftype_cap(sband, NL80211_IFTYPE_MESH_POINT);
> +
> +	if (!he_cap ||
> +	    sdata->vif.bss_conf.chandef.width == NL80211_CHAN_WIDTH_20_NOHT ||
> +	    sdata->vif.bss_conf.chandef.width == NL80211_CHAN_WIDTH_5 ||
> +	    sdata->vif.bss_conf.chandef.width == NL80211_CHAN_WIDTH_10)
> +		return 0;
> +
> +	if (!he_cap->has_he_6ghz)
> +		return 0;

I saw this before and thought it may actually exist, but it doesn't?

Like I said before though, there doesn't seem much point in this, if you
don't have 6 GHz then don't advertise those channels ...

>  static void ieee80211_send_assoc(struct ieee80211_sub_if_data *sdata)
> @@ -4803,7 +4809,8 @@ static int ieee80211_prep_channel(struct ieee80211_sub_if_data *sdata,
>  	if (!sband->ht_cap.ht_supported) {
>  		ifmgd->flags |= IEEE80211_STA_DISABLE_HT;
>  		ifmgd->flags |= IEEE80211_STA_DISABLE_VHT;
> -		ifmgd->flags |= IEEE80211_STA_DISABLE_HE;
> +		if (sband->band != NL80211_BAND_6GHZ)
> +			ifmgd->flags |= IEEE80211_STA_DISABLE_HE;
>  	}
>  
>  	if (!sband->vht_cap.vht_supported)
> @@ -5493,7 +5500,8 @@ int ieee80211_mgd_assoc(struct ieee80211_sub_if_data *sdata,
>  	if (req->flags & ASSOC_REQ_DISABLE_HT) {
>  		ifmgd->flags |= IEEE80211_STA_DISABLE_HT;
>  		ifmgd->flags |= IEEE80211_STA_DISABLE_VHT;
> -		ifmgd->flags |= IEEE80211_STA_DISABLE_HE;
> +		if (sband->band != NL80211_BAND_6GHZ)
> +			ifmgd->flags |= IEEE80211_STA_DISABLE_HE;
>  	}

These changes really sort of belong more into the next patch, I guess?
Not sure.


>  	if (req->flags & ASSOC_REQ_DISABLE_VHT)
> diff --git a/net/mac80211/util.c b/net/mac80211/util.c
> index 5a33755c22f4..2bcebe672c0d 100644
> --- a/net/mac80211/util.c
> +++ b/net/mac80211/util.c
> @@ -2839,6 +2839,21 @@ u8 *ieee80211_ie_build_he_cap(u8 *pos,
>  	return pos;
>  }
>  
> +u8 *ieee80211_ie_build_he_6ghz_band_cap(u8 *pos, u16 he_6ghz_cap)
> +{
> +	__le16 cap = cpu_to_le16(he_6ghz_cap);
> +
> +	*pos++ = WLAN_EID_EXTENSION;
> +	*pos++ = 3;
> +	*pos++ = WLAN_EID_EXT_HE_6GHZ_BAND_CAP;
> +
> +	/* Fixed data */
> +	memcpy(pos, &cap, sizeof(cap));
> +	pos += sizeof(cap);
> +
> +	return pos;
> +}

You forgot SMPS, so this needs to be a bit different, but it's probably
better as a separate function since it's in multiple places, I guess
I'll combine our two patches.

johannes

