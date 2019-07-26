Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 85FED764AF
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jul 2019 13:36:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726000AbfGZLgM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 26 Jul 2019 07:36:12 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:47646 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725903AbfGZLgM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 26 Jul 2019 07:36:12 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <johannes@sipsolutions.net>)
        id 1hqyWA-0001yR-KQ; Fri, 26 Jul 2019 13:36:10 +0200
Message-ID: <90a9bd90fb2d906d6f61d56c1e36b3e6bb0388b8.camel@sipsolutions.net>
Subject: Re: [PATCH V3 2/2] mac80211: add support for the ADDBA extension
 element
From:   Johannes Berg <johannes@sipsolutions.net>
To:     John Crispin <john@phrozen.org>
Cc:     linux-wireless@vger.kernel.org,
        Shashidhar Lakkavalli <slakkavalli@datto.com>
Date:   Fri, 26 Jul 2019 13:36:08 +0200
In-Reply-To: <20190713163642.18491-3-john@phrozen.org>
References: <20190713163642.18491-1-john@phrozen.org>
         <20190713163642.18491-3-john@phrozen.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

Apologies for the late review.

I've applied patch 1, but not this one yet:

>  #define IEEE80211_HE_MAC_CAP0_DYNAMIC_FRAG_LEVEL_2		0x10
>  #define IEEE80211_HE_MAC_CAP0_DYNAMIC_FRAG_LEVEL_3		0x18
>  #define IEEE80211_HE_MAC_CAP0_DYNAMIC_FRAG_MASK			0x18
> +#define IEEE80211_HE_MAC_CAP0_DYNAMIC_FRAG_SHIFT		3

this will not be needed,
 
> -static void ieee80211_send_addba_resp(struct ieee80211_sub_if_data *sdata, u8 *da, u16 tid,
> +static void ieee80211_add_addbaext(struct ieee80211_sub_if_data *sdata,
> +				   struct sk_buff *skb,
> +				   const struct ieee80211_addba_ext_ie *req)
> +{
> +	struct ieee80211_supported_band *sband;
> +	struct ieee80211_addba_ext_ie *resp;
> +	const struct ieee80211_sta_he_cap *he_cap;
> +	u8 frag_level, cap_frag_level;
> +	u8 *pos;
> +
> +	sband = ieee80211_get_sband(sdata);
> +	he_cap = ieee80211_get_he_iftype_cap(sband, sdata->vif.type);
> +	if (!he_cap)
> +		return;
> +
> +	pos = skb_put_zero(skb, 2 + sizeof(struct ieee80211_addba_ext_ie));
> +	*pos++ = WLAN_EID_ADDBA_EXT;
> +	*pos++ = sizeof(struct ieee80211_addba_ext_ie);
> +	resp = (struct ieee80211_addba_ext_ie *)pos;
> +	resp->data = req->data & IEEE80211_ADDBA_EXT_NO_FRAG;
> +
> +	frag_level = (req->data & IEEE80211_ADDBA_EXT_FRAG_LEVEL_MASK) >>
> +		     IEEE80211_ADDBA_EXT_FRAG_LEVEL_SHIFT;
> +	cap_frag_level = (he_cap->he_cap_elem.mac_cap_info[0] &
> +			  IEEE80211_HE_MAC_CAP0_DYNAMIC_FRAG_MASK) >>
> +			 IEEE80211_HE_MAC_CAP0_DYNAMIC_FRAG_SHIFT;

if you use u32_get_bits() from bitfield.h here for these two
assignments, which is nicer anyway.

> +	if (frag_level > cap_frag_level)
> +		frag_level = cap_frag_level;
> +	resp->data |= (frag_level << IEEE80211_ADDBA_EXT_FRAG_LEVEL_SHIFT) &
> +		      IEEE80211_ADDBA_EXT_FRAG_LEVEL_MASK;

and probably that could also be u8_encode_bits()?

> -	skb = dev_alloc_skb(sizeof(*mgmt) + local->hw.extra_tx_headroom);
> +	skb = dev_alloc_skb(sizeof(*mgmt) +
> +		    (addbaext ? 2 + sizeof(struct ieee80211_addba_ext_ie) : 0) +
> +		    local->hw.extra_tx_headroom);

not much point in the if (ternary operator) for ... 3 bytes? :-)

johannes

