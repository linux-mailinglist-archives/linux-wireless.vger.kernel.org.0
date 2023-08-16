Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DEF677E2B8
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Aug 2023 15:37:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245579AbjHPNgs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 16 Aug 2023 09:36:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245580AbjHPNgm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 16 Aug 2023 09:36:42 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C55BB123
        for <linux-wireless@vger.kernel.org>; Wed, 16 Aug 2023 06:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=8jtHqQpmVWgSHJYBaqo9Xp/2soWaFrb2AmoKLrI+u54=;
        t=1692193001; x=1693402601; b=YO7jHwOmig7L3s7nR3q1eA9cL9GDUF5hkAXBt0LcD1FE7/8
        5GDjmDkJm9zmOKTYEZwR9V9V+NBe0kU+sHapYnf+53gNlNSOHWx4fYFboMZmITL1Ug6eKWLmkk5R2
        18j+cwuiXjbaMUCSjdmp8Ke4yuxuoPLfRsGCLN6sjNfiV9dds5HJE/HlXtv9THKSt80BuuPQpuv/y
        4LVrtZC7GySJsKu/RHXzch26fV2S+1Za54h0pS4vuvA//9j1+XvArpZZ89BprH8bzoZkvri9XMR1T
        J57H8UmMxCltBDxcaakAasDf/SrjGkjg43TYuXehAwEj36YKdtIjbijhINmollyQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qWGhT-00AyDY-2d;
        Wed, 16 Aug 2023 15:36:40 +0200
Message-ID: <7bef5ebb985dacc7d497f2ab6d24a0f3402ce39a.camel@sipsolutions.net>
Subject: Re: [RFC PATCH v3 6.1] wifi: cfg80211: fix cqm_config access race
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Max Schulze <max.schulze@online.de>
Date:   Wed, 16 Aug 2023 15:36:38 +0200
In-Reply-To: <20230816153202.07a31b651a28.I1a1bb102329fc88e4712eaf394cba3025ada0dc7@changeid>
References: <ac96309a-8d8d-4435-36e6-6d152eb31876@online.de>
         <20230816153202.07a31b651a28.I1a1bb102329fc88e4712eaf394cba3025ada0dc7@changeid>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Oh, wait, there's another bug here ... One that makes more sense.

On Wed, 2023-08-16 at 15:32 +0200, Johannes Berg wrote:
>=20
> @@ -12629,6 +12630,7 @@ static int nl80211_set_cqm_rssi(struct genl_info =
*info,
>  				u32 hysteresis)
>  {
>  	struct cfg80211_registered_device *rdev =3D info->user_ptr[0];
> +	struct cfg80211_cqm_config *cqm_config =3D NULL, *old;
>  	struct net_device *dev =3D info->user_ptr[1];
>  	struct wireless_dev *wdev =3D dev->ieee80211_ptr;
>  	int i, err;
> @@ -12646,10 +12648,6 @@ static int nl80211_set_cqm_rssi(struct genl_info=
 *info,
>  	    wdev->iftype !=3D NL80211_IFTYPE_P2P_CLIENT)
>  		return -EOPNOTSUPP;
> =20
> -	wdev_lock(wdev);
> -	cfg80211_cqm_config_free(wdev);

This used to NULL out the value on freeing

> -	wdev_unlock(wdev);
> -
>  	if (n_thresholds <=3D 1 && rdev->ops->set_cqm_rssi_config) {
>  		if (n_thresholds =3D=3D 0 || thresholds[0] =3D=3D 0) /* Disabling */
>  			return rdev_set_cqm_rssi_config(rdev, dev, 0, 0);
> @@ -12666,9 +12664,9 @@ static int nl80211_set_cqm_rssi(struct genl_info =
*info,
>  		n_thresholds =3D 0;
> =20
>  	wdev_lock(wdev);
> +	old =3D rcu_dereference_protected(wdev->cqm_config,
> +					lockdep_is_held(&wdev->mtx));
>  	if (n_thresholds) {
> -		struct cfg80211_cqm_config *cqm_config;
> -
>  		cqm_config =3D kzalloc(struct_size(cqm_config, rssi_thresholds,
>  						 n_thresholds),
>  				     GFP_KERNEL);
> @@ -12683,10 +12681,16 @@ static int nl80211_set_cqm_rssi(struct genl_inf=
o *info,
>  		       flex_array_size(cqm_config, rssi_thresholds,
>  				       n_thresholds));
> =20
> -		wdev->cqm_config =3D cqm_config;
> +		rcu_assign_pointer(wdev->cqm_config, cqm_config);
>  	}
> =20
> -	err =3D cfg80211_cqm_rssi_update(rdev, dev);
> +	err =3D cfg80211_cqm_rssi_update(rdev, dev, cqm_config);
> +	if (err) {
> +		rcu_assign_pointer(wdev->cqm_config, old);
> +		kfree_rcu(cqm_config, rcu_head);
> +	} else {
> +		kfree_rcu(old, rcu_head);

But I didn't put that here! So you obviously have UAF when removing a
CQM config.

johannes

