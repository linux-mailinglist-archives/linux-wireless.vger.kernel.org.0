Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D7D81BE0F9
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Apr 2020 16:31:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726516AbgD2Obn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 29 Apr 2020 10:31:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726484AbgD2Obn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 29 Apr 2020 10:31:43 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE9E8C03C1AD
        for <linux-wireless@vger.kernel.org>; Wed, 29 Apr 2020 07:31:42 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1jTnkT-001x2m-2J; Wed, 29 Apr 2020 16:31:41 +0200
Message-ID: <8e55825d2c399dc926dacdc799fc64851d2fc4fb.camel@sipsolutions.net>
Subject: Re: [PATCH 05/10] mac80211: handle HE 6 GHz Capability in HE STA
 processing
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Rajkumar Manoharan <rmanohar@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org
Date:   Wed, 29 Apr 2020 16:31:39 +0200
In-Reply-To: <1587768108-25248-6-git-send-email-rmanohar@codeaurora.org>
References: <1587768108-25248-1-git-send-email-rmanohar@codeaurora.org>
         <1587768108-25248-6-git-send-email-rmanohar@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, 2020-04-24 at 15:41 -0700, Rajkumar Manoharan wrote:
> 
>   * @has_he: true iff HE data is valid.
> + * @has_he_6ghz: true iff HE 6 GHz data is valid.
>   * @he_cap_elem: Fixed portion of the HE capabilities element.
>   * @he_mcs_nss_supp: The supported NSS/MCS combinations.
>   * @ppe_thres: Holds the PPE Thresholds data.
> + * @ampdu_factor: Maximum A-MPDU length factor used in 6 GHz.
> + * @ampdu_density: Minimum A-MPDU spacing used in 6 GHz.
> + * @he_6gz_cap: HE 6 GHz Band capability.

typo

>   */
>  struct ieee80211_sta_he_cap {
>  	bool has_he;
> +	bool has_he_6ghz;
>  	struct ieee80211_he_cap_elem he_cap_elem;
>  	struct ieee80211_he_mcs_nss_supp he_mcs_nss_supp;
>  	u8 ppe_thres[IEEE80211_HE_PPE_THRES_MAX_LEN];
> +	u8 ampdu_factor;
> +	u8 ampdu_density;
> +	u16 he_6ghz_cap;

Maybe these should be in some kind of sub-struct so it's clear what the
"has_he_6ghz" applies to?

>  };
>  
>  /**
> @@ -1272,7 +1280,7 @@ struct station_parameters {
>  	u8 he_capa_len;
>  	u16 airtime_weight;
>  	struct sta_txpwr txpwr;
> -	const struct ieee80211_he_6ghz_band_cap *he_6ghz_capa;
> +	const u8 *he_6ghz_capa;

hm?

johannes

