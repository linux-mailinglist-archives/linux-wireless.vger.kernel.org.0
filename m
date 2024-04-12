Return-Path: <linux-wireless+bounces-6255-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A43068A2EA2
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Apr 2024 14:55:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D129284A7E
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Apr 2024 12:55:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0746655C3B;
	Fri, 12 Apr 2024 12:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="KGY6kajR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D4E56443
	for <linux-wireless@vger.kernel.org>; Fri, 12 Apr 2024 12:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712926537; cv=none; b=nuFrWJ+grF/ExejCHP/ByWoNeVO8jXLnxstbbdugfSZFFqP8jOALn1+8e1WUc+QE/s0kG/ggO2epcozTilPPpmUJuoug/5bcyz7RTmV8oYhFL9GhLaroKMpfFO0iZHykIwrdFhga/EU5lWuIFglEcmCdILm0PIjqWKi5X2W7hw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712926537; c=relaxed/simple;
	bh=sLLSuqzDeadadhrpOPlHNnwH6VbQcoKnVqb12ma8bcI=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MT+1crJXluZQBPjvdrK+8f5q3/G9nAnhSAN7ynY2tTVOYuGp74zpwQukgXDqXaSAVuC8GnxfVkLGJxErw1LWLN7dOwCrViAb83EAg9q3GhEUEgGD9G+Jg/mvILhc80hcudeL4YN+cS6OlHifzH4BdVleye/HDkXHeTJUkPCQXRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=KGY6kajR; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=Q2Q5oexKChOJsHREgyUydwQTcT4MafNv0i0HOD9th0o=;
	t=1712926534; x=1714136134; b=KGY6kajRHlK1slErcX0bogQMY2M+Byi9pLtH12z7dcHr0kr
	/vOioZnOHPmdXDioTta4s7Wwoj+yrdb2EQxMUV74W3uXYOGoNHZMF3sbWUh60Mt0xRytE52Z0PBZD
	jKWb8ZxVp3Pksy/uSojB74UkaTOzAardBAbq9FNf2DHx5YxcOmyha9zbQt8vigUNTu3F2lcaZ9cnD
	kba65qFkwaOl6qb51N2nsp1ZD30wcBp8Qvt/ERtR7wOno95NViCceAgR9HRqyLpR+k1nDj0XLbuQC
	+KnOqo/YN03W30EPOayc44jtFuXMyNdWYcIBjtFMfZgsoa9V8YIiu3IPRT3voACw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rvGRC-0000000442M-2aSy;
	Fri, 12 Apr 2024 14:55:26 +0200
Message-ID: <893ca115e668c6778344bcbd30168fe37bd5c80d.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: mac80211: split mesh fast tx cache into
 local/proxied/forwarded
From: Johannes Berg <johannes@sipsolutions.net>
To: Felix Fietkau <nbd@nbd.name>, linux-wireless@vger.kernel.org
Date: Fri, 12 Apr 2024 14:55:25 +0200
In-Reply-To: <20240412120634.88972-1-nbd@nbd.name>
References: <20240412120634.88972-1-nbd@nbd.name>
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

On Fri, 2024-04-12 at 14:06 +0200, Felix Fietkau wrote:
>=20
> +struct ieee80211_mesh_fast_tx_key {
> +	u8 addr[ETH_ALEN] __aligned(2);
> +	enum ieee80211_mesh_fast_tx_type type;
> +};

Does it make sense to hash a bunch of zeroes there if the compiler
allocates more than a single byte for "type"? It's uglier, but maybe
makes more sense to not do that? There's also padding in there in that
case.

> @@ -646,12 +653,18 @@ void mesh_fast_tx_flush_addr(struct ieee80211_sub_i=
f_data *sdata,
>  			     const u8 *addr)
>  {
>  	struct mesh_tx_cache *cache =3D &sdata->u.mesh.tx_cache;
> +	struct ieee80211_mesh_fast_tx_key key =3D {};
>  	struct ieee80211_mesh_fast_tx *entry;
> +	int i;
> =20
> +	ether_addr_copy(key.addr, addr);
>  	spin_lock_bh(&cache->walk_lock);
> -	entry =3D rhashtable_lookup_fast(&cache->rht, addr, fast_tx_rht_params)=
;
> -	if (entry)
> -		mesh_fast_tx_entry_free(cache, entry);
> +	for (i =3D MESH_FAST_TX_TYPE_LOCAL; i < MESH_FAST_TX_TYPE_FORWARDED; i+=
+) {

Seems that should be "i <=3D ...FORWARDED".

Maybe better then to add a NUM_MESH_FAST_TX_TYPES or so to the enum and
then use "i < NUM_MESH_FAST_TX_TYPES", so new additions won't have to
update this, if they ever happen.

johannes

