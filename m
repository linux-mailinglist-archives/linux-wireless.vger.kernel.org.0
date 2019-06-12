Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC49E41F75
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Jun 2019 10:43:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731609AbfFLInA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 12 Jun 2019 04:43:00 -0400
Received: from durin.narfation.org ([79.140.41.39]:50016 "EHLO
        durin.narfation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726196AbfFLInA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 12 Jun 2019 04:43:00 -0400
Received: from bentobox.localnet (p200300C5971631EEDD38BA8B24095BBE.dip0.t-ipconnect.de [IPv6:2003:c5:9716:31ee:dd38:ba8b:2409:5bbe])
        by durin.narfation.org (Postfix) with ESMTPSA id DEE491100ED;
        Wed, 12 Jun 2019 10:42:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
        s=20121; t=1560328978;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UHNnaKwNczZhSuiywRRpj7DEoRLrXN+90soLckeQ1jw=;
        b=jqZh1wyYfrFIYfDMmVxiwGF4SZnezrUmViHi4WTi+FPiofzxhucbW7EOrkya1S12X3sMtj
        tF3/l3WzJhOR/V6wu47kAa9WrvTAqT+YK4fHgsGNYQ1ZAyZrtLSvDjAt9yc/DGRTjDFxE9
        6XMsZaNpnXA5l5DF1w1FwGWTO9mMhJo=
From:   Sven Eckelmann <sven@narfation.org>
To:     ath11k@lists.infradead.org
Cc:     Bob Copeland <me@bobcopeland.com>, linux-wireless@vger.kernel.org
Subject: Re: [RFC PATCH v2 3/3] ath11k: register HE mesh capabilities
Date:   Wed, 12 Jun 2019 10:42:49 +0200
Message-ID: <1614431.vQLKkJHT2m@bentobox>
In-Reply-To: <1919330.hVZVHELXip@bentobox>
References: <20190611180247.19524-1-sven@narfation.org> <20190611180247.19524-4-sven@narfation.org> <1919330.hVZVHELXip@bentobox>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4254098.4Ndc6H3f2e"; micalg="pgp-sha512"; protocol="application/pgp-signature"
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
        s=20121; t=1560328978;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UHNnaKwNczZhSuiywRRpj7DEoRLrXN+90soLckeQ1jw=;
        b=jOskFH9uZieb6FQXqBiVoJW3LRNODBL6YiGTeyfB83kttH0yzJ8MxuU0Rb4Kepa5HEe905
        oQZ96ltD5Mq61GjCpuDZFDnykv6O+/7d3lmdoItM+a98nmz3YLw8YrnRog0SZDNw52OPf7
        Ks/PaTt4ox5/dJ4tef+IqlPSVEkvxHE=
ARC-Seal: i=1; s=20121; d=narfation.org; t=1560328978; a=rsa-sha256;
        cv=none;
        b=fZIylFh5H1e0qODp+KNI5pn4adGnpurX7HOCygNl2CI+h25z7Pf75z29pIo90X7sMGRCID
        CHQaOHtB8+zzkvCTSH77DogYV14sxO5wUAC6csUQiVNnKIUe0fINO6fXSB9y6O9ol7AAxa
        C10nXcGCh4ktv4xxWbCHgv0iomPUxUM=
ARC-Authentication-Results: i=1;
        durin.narfation.org;
        auth=pass smtp.auth=sven smtp.mailfrom=sven@narfation.org
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

--nextPart4254098.4Ndc6H3f2e
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Tuesday, 11 June 2019 21:52:20 CEST Sven Eckelmann wrote:
[...]
> 	if (!test_sta_flag(sta, WLAN_STA_RATE_CONTROL))
> 		rate_control_rate_init(sta);
> 
>    /* inform drivers about changes */
> 	rate_control_rate_update(local, sband, sta, changed);
> 
> Both will at least cause a call to ath11k_peer_assoc_prepare + 
> ath11k_wmi_send_peer_assoc_cmd but unfortunately the ath11k firmware hangs 
> afterwards.

The fw hang seems to be related to the not set bss_conf.he_support in 
ath11k_mac_vdev_start_restart. This has to be set when ieee80211_join_mesh 
calls ieee80211_vif_use_channel. Otherwise the firmware will set a HT/VHT mode 
in the firmware. Any sta with an higher phy mode will just hang the firmware.

So the two main problems right now are:

* set bss_conf.he_support during mesh_join before 
  ath11k_mac_vdev_start_restart is called

   - no clue what the best approach is

* let ath11k redo the association procedure with he_cap->has_he set to true 
  when wpa_supplicant is in control of the peers.

Kind regards,
	Sven
--nextPart4254098.4Ndc6H3f2e
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAl0AuwkACgkQXYcKB8Em
e0YPPxAAnX5qB+eKAtJXohO+ZMzRklrbhMuJUYYQwyXf21xuwNpoQKLPZ5YHBvus
a5Oq5tInf4/potjT9Xwq5NbkN8kotuec9Rt+NaDcsh6z470QyUCrEEO9TjkIs8Fk
xMuSLu/3IHYbRyfD2i4K/ai5VDcAPq6Pjz6yXHnZHz/umQTVRQidjoV72ZSFFvhK
s2ZXLzOPe5PYUgLDh45SwIEuFhMMXW81eqrodc9Y7lTy8F8yra1ZaqrpGCQCIEPo
JVv0q0iFS7KSMsbUM5SuROBZu0TfIVXFqIxfZX8/mQaSu6aK5DJl8v6o0Ci9tUo+
boHDLclvsY3qVsvLe0SGtjxTaMZker1gQPKaXEyzhiBDo5moo6s+jZKogL+xvGlv
JpDexQGBGwohurKjTlPax2djlibdIODfKfZKMNUU+UnOmuBwm+lkV9pTy3oJuGQ1
zMkUrp2hugvT/L3PT/4M1KnpKtJ7kGNfKyj5d0iHwzeFRCSqvEO2iFcovvKmfUM2
pHzpXOaXFRXWFO7jLrl14mOLjj+pxiulf0CxSH6ld/rnmC6ZGsXjn0umGbVwd6fh
H2rUx6PrhqmCLKrTcfojXvSMQLUIF9IzywtGa2cB2Ru0QKW1zPHvOBCj+4sA/4Zl
BYa6ULsi7c0u6ZWf9I0ODgKaXBV80nHBq0c7Qqv7fJXiSaoxI1w=
=Spr6
-----END PGP SIGNATURE-----

--nextPart4254098.4Ndc6H3f2e--



