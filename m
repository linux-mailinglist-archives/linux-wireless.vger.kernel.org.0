Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A3FD1E5B3E
	for <lists+linux-wireless@lfdr.de>; Thu, 28 May 2020 10:55:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727983AbgE1IzN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 28 May 2020 04:55:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727981AbgE1IzN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 28 May 2020 04:55:13 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C978EC05BD1E
        for <linux-wireless@vger.kernel.org>; Thu, 28 May 2020 01:55:12 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1jeEJi-004krY-BI; Thu, 28 May 2020 10:55:10 +0200
Message-ID: <f9a764eaf9f0898c257b6c98346536c2c0f5d6f8.camel@sipsolutions.net>
Subject: Re: [PATCH v3 06/11] mac80211: handle HE 6 GHz Capability in HE STA
 processing
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Rajkumar Manoharan <rmanohar@codeaurora.org>, kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org, ath11k@lists.infradead.org
Date:   Thu, 28 May 2020 10:55:09 +0200
In-Reply-To: <1589399105-25472-6-git-send-email-rmanohar@codeaurora.org>
References: <1589399105-25472-1-git-send-email-rmanohar@codeaurora.org>
         <1589399105-25472-6-git-send-email-rmanohar@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.2 (3.36.2-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


> +++ b/include/net/cfg80211.h
> @@ -332,15 +332,25 @@ struct ieee80211_sta_vht_cap {
>   * to describe 802.11ax HE capabilities for a STA.
>   *
>   * @has_he: true iff HE data is valid.
> + * @has_he_6ghz: true iff HE 6 GHz data is valid.
>   * @he_cap_elem: Fixed portion of the HE capabilities element.
>   * @he_mcs_nss_supp: The supported NSS/MCS combinations.
>   * @ppe_thres: Holds the PPE Thresholds data.
> + * @ampdu_factor: Maximum A-MPDU length factor used in 6 GHz.
> + * @ampdu_density: Minimum A-MPDU spacing used in 6 GHz.
> + * @cap: HE 6 GHz Band capability.
>   */
>  struct ieee80211_sta_he_cap {
>  	bool has_he;
> +	bool has_he_6ghz;
>  	struct ieee80211_he_cap_elem he_cap_elem;
>  	struct ieee80211_he_mcs_nss_supp he_mcs_nss_supp;
>  	u8 ppe_thres[IEEE80211_HE_PPE_THRES_MAX_LEN];
> +	struct {
> +		u8 ampdu_factor;
> +		u8 ampdu_density;
> +		u16 cap;
> +	} he_6ghz;
>  };

So ... I'm a bit unsure about this now. What I had done was this (well,
I adjusted it slightly now):

https://p.sipsolutions.net/2d0eb7c7e23a1b92.txt


But it's only half related? Maybe you're also using that for the
associated stations, not just for "self"? But then again, you *already*
added 

@@ -1270,6 +1271,7 @@ struct station_parameters {
        u8 he_capa_len;
        u16 airtime_weight;
        struct sta_txpwr txpwr;
+       const struct ieee80211_he_6ghz_capa *he_6ghz_capa;
 };

right?


But no ... that's different. We still have a need to store the station's
capabilities.

But even then,

> +	struct {
> +		u8 ampdu_factor;
> +		u8 ampdu_density;
> +		u16 cap;
> +	} he_6ghz;

doesn't really make sense, does it? "cap' already includes the
ampdu_factor and ampdu_density flags, so that's doubled...


I think I would prefer to have this separate. We need it as I put into
my patch that I linked to above, and we also need it in the station in
mac80211 for AP, but we don't really need it for cfg80211 as you put it
here.

I'll continue with my other patches, and then maybe see how this fits in
later.

johannes

