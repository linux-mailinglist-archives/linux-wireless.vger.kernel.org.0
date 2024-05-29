Return-Path: <linux-wireless+bounces-8262-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E10F68D3780
	for <lists+linux-wireless@lfdr.de>; Wed, 29 May 2024 15:23:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C4E7284426
	for <lists+linux-wireless@lfdr.de>; Wed, 29 May 2024 13:23:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1941D17BA3;
	Wed, 29 May 2024 13:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="oaMqzzbr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FEE117BA0
	for <linux-wireless@vger.kernel.org>; Wed, 29 May 2024 13:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716989000; cv=none; b=JYqiDwJo+CbWaQhh2FGu+ThBwe8d9+V8sY/J+8noslHCXGa6Rdu6sCu5Rs7zzFnkRYZ+w3XZYFN9C2LDsErVC1TajAuJlhQf/xCNbWq8VPqdvw4V1ZMhBAFDHGI6xqiIJ8DPCIZYFFD7oJ+tX80rYC+Zos4WgdlmPFCQ8o3Zw3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716989000; c=relaxed/simple;
	bh=Jvj+FiGU0VAkGKQvgUc7+jBTVYNPmWD6JlIV6XmdAAs=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Y8wx4CXZuedVpJGx+qENwOOPkobePYO+vKcHjQ2iyQyKqdLflrbJHpnKZDAJvpyBOeLIZyJNv+xWa6eiYj01B1hUMbdyDEUwOKG8lqgvAOwcK7/V0r7nQWv2w57/MDF+7JrGDsIfdnmEfC7vdR/cbB4m5i1Ph4SuhN2SZo7gSnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=oaMqzzbr; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=uJgmhnHfpXRArzWZMxr9trqneJLphfazjm2ZPyQ1l4s=;
	t=1716988987; x=1718198587; b=oaMqzzbrDoGtAww1fussLOdGkmZYaYhWKdvMLY4sQoLpVac
	qrGPAqDrKO6qzt9ZXoGuxdm6YrXZ82J7NV2IVbtpjrKcEyRwvgS3XSsjRD1gTrKHJcOKoy4w7j69w
	Yzws+M2/YYbFBiZQ9hZywBe0W9ROPGB6CemDT/haDd40NXvdjlwZsoiaQ+QND7doxyJr4AdsK9MSs
	u5QjIG7x5hYg/ssUpWSP3FJIysZQHKicfdb4TZgXu2t/oR12HHlyWRnL7Vd5VpdGApIGCj4HbaPfo
	BF+Be+W3ylWlP0YcKT3+5IiZ+f39ESqQuLDuRR/tLMS0qHX7UFALIc9Eg0dl6Zpg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sCJGX-0000000GxXU-1ykx;
	Wed, 29 May 2024 15:22:53 +0200
Message-ID: <173a8af7e9b544c496f2aee2bb47fca99279873c.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: mac80211: fix NULL dereference at band check in
 starting tx ba session
From: Johannes Berg <johannes@sipsolutions.net>
To: kevin_yang@realtek.com, linux-wireless@vger.kernel.org
Date: Wed, 29 May 2024 15:22:52 +0200
In-Reply-To: <20240523082200.15544-1-kevin_yang@realtek.com>
References: <20240523082200.15544-1-kevin_yang@realtek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Thu, 2024-05-23 at 16:22 +0800, kevin_yang@realtek.com wrote:
>=20
> -	if (!pubsta->deflink.ht_cap.ht_supported &&
> -	    sta->sdata->vif.bss_conf.chanreq.oper.chan->band !=3D NL80211_BAND_=
6GHZ)
> -		return -EINVAL;

I can see how this fixes the crash, and I can also see why we didn't
notice (TX agg sessions offloaded to FW), but ...

> +	if (!pubsta->deflink.ht_cap.ht_supported) {
> +		struct ieee80211_vif *vif =3D &sta->sdata->vif;
> +		struct ieee80211_bss_conf *bss_conf;
> +
> +		rcu_read_lock();
> +
> +		bss_conf =3D rcu_dereference(vif->link_conf[pubsta->deflink.link_id]);
> +		if (unlikely(!bss_conf) ||
> +		    bss_conf->chanreq.oper.chan->band !=3D NL80211_BAND_6GHZ) {
> +			rcu_read_unlock();
> +			return -EINVAL;
>=20

is this really right?

This checks that the *first* link the STA used isn't 6 GHz, but maybe it
should be *any* link?

But then again, we don't really need this check for an MLO STA since it
will have HT supported unless it associated on 6 GHz. Maybe we should
just not do the check this way, but check if it has HT or VHT or HE or
something like that?

johannes

