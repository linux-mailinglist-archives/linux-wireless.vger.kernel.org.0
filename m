Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A0A8097225
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Aug 2019 08:17:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727931AbfHUGQe (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 21 Aug 2019 02:16:34 -0400
Received: from dvalin.narfation.org ([213.160.73.56]:51742 "EHLO
        dvalin.narfation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726193AbfHUGQd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 21 Aug 2019 02:16:33 -0400
Received: from bentobox.localnet (p200300C5971038EC000000000000063E.dip0.t-ipconnect.de [IPv6:2003:c5:9710:38ec::63e])
        by dvalin.narfation.org (Postfix) with ESMTPSA id 20AB51FDA5;
        Wed, 21 Aug 2019 06:16:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
        s=20121; t=1566368190;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=k4//DVBJlSXUGTW5ZqV7kGgLVyVIxoMGbLM0K+vEU0s=;
        b=RC+wAhiPSvtbwpyeAG2ZTtBjr/OjQxdWTZ6uDwKtmgGk/1PDpT6VdH5wghM758ejn1Lp6t
        7xzxVdl5O2PSmP/RvSOpB6DSisypMl8/Tw5pMVctTenw9jO6bl7WzvBLA+brGMy0y+tJyu
        mOAv3H9O1wZKuPoCZl1NRS0NXTyzebo=
From:   Sven Eckelmann <sven@narfation.org>
To:     ath11k@lists.infradead.org
Cc:     Kalle Valo <kvalo@codeaurora.org>, linux-wireless@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 31/49] ath11k: add mac.c
Date:   Wed, 21 Aug 2019 08:16:27 +0200
Message-ID: <1635460.phzPRRphLd@bentobox>
In-Reply-To: <1566316095-27507-32-git-send-email-kvalo@codeaurora.org>
References: <1566316095-27507-1-git-send-email-kvalo@codeaurora.org> <1566316095-27507-32-git-send-email-kvalo@codeaurora.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2661494.foTVnLV1sx"; micalg="pgp-sha512"; protocol="application/pgp-signature"
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
        s=20121; t=1566368190;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=k4//DVBJlSXUGTW5ZqV7kGgLVyVIxoMGbLM0K+vEU0s=;
        b=s6tBhDL6MOTBzrc7Nob2aQpCEYHBKeTuhP/Vh01hxjEPhF+fyPVrfClgEdHVHmpwHzPI9A
        F8S5naZNTdvOkEV0Qz4BVfDGRJkyvhGAd8/R/EOxxbv1a5aVqqaNvY3tRhaCKph4XvKsTZ
        1TznsXH+FKbpDQzWhvQMe+qh12ti6Bw=
ARC-Seal: i=1; s=20121; d=narfation.org; t=1566368190; a=rsa-sha256;
        cv=none;
        b=A2muYssPS2gHpC7ZUulw62vCxEty0lZbBCorb1sBT2IK8VJ/qLwTfw3aHr8xHiXvveBtB8
        DTRVXnFQpNv8RF02ikaS2mHsE6Mczct72+YxpjYVFmSDognVUhcKYwRdpVSBhenIsspnr8
        NOvIMuUkcNS/Ll/+41b762BqU1vm/CE=
ARC-Authentication-Results: i=1;
        dvalin.narfation.org;
        auth=pass smtp.auth=sven smtp.mailfrom=sven@narfation.org
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

--nextPart2661494.foTVnLV1sx
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Tuesday, 20 August 2019 17:47:57 CEST Kalle Valo wrote:
> +static void ath11k_peer_assoc_h_rates(struct ath11k *ar,
> +                                     struct ieee80211_vif *vif,
> +                                     struct ieee80211_sta *sta,
> +                                     struct peer_assoc_params *arg)
> +{
> +       struct ath11k_vif *arvif = (void *)vif->drv_priv;
> +       struct wmi_rate_set_arg *rateset = &arg->peer_legacy_rates;
> +       struct cfg80211_chan_def def;
> +       const struct ieee80211_supported_band *sband;
> +       const struct ieee80211_rate *rates;
> +       enum nl80211_band band;
> +       u32 ratemask;
> +       u8 rate;

rate has to be u32 [1].

Kind regards,
	Sven

[1] https://patchwork.kernel.org/patch/11089507/
--nextPart2661494.foTVnLV1sx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAl1c4bsACgkQXYcKB8Em
e0aLmBAAhoE9lMj0hnfUTO5uRdRLBjgzTR+CAV2Bc72Q4TRzRnt/7NoWfTrViIXW
Q0MepQ/3Hs6bZc0s+IOqIEduGCGRNrJcbc6q6HlkmcYQmqfkC7cbfnZyzhDZFOLM
0HbG2wTomoKEJqshc0aDMjaV3N4i6Tj5em590kUktfYTLHoZFJs4G7AdAnIC9nB7
Kij4lbg6zmOemuenkT0LV/6D3RVjJr0MkcGNd3jsRFgdtCZCJf/5EtVu5goMASSz
yGwcnTBrp9kaXRp2XRw4j5FO8oogMxXl77neGvnrUHG9mUF23ke+5Dr6X9wOrnpe
m6zd2RI/2L1E8tKUMUnm7BaJhmqOtJaE6Jd8jcFjptHo8EUe6tr1ZkC7E46xFCER
fhOqsULieRZDBDLpuhTWCTYip7OO8E842GDTvyD3SWUCbaFVOzF9ttolvvqLKMfB
V5ntQ5KfyWB9q+3NMNMvqCQqVZnUnTVK2QvDt3JHC6uhqoZiyFGTy3RVFdBVr06x
g24bg/lEXSTV4nMFUzMlJ+9upRZ3q0H1l6x4bPfWdZNdow/jzuhejvyXv/NTQujR
iGCb9BPWictQ8QAfZI/FJdrJehlsUe68pQIstiKXVSGKGUzuhYnOhmr4q+yfuYsj
vC7uBwgqDsGEH2mzGYATTcU04cE2W7XOCckFk9pGO2UOaQIcMrY=
=8elU
-----END PGP SIGNATURE-----

--nextPart2661494.foTVnLV1sx--



