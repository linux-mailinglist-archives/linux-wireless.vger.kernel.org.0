Return-Path: <linux-wireless+bounces-29156-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 11FD7C73155
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Nov 2025 10:19:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D466B4ECBFC
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Nov 2025 09:14:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79C5E2E7BA2;
	Thu, 20 Nov 2025 09:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="s3ibAhh2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71AAD2EFDAD
	for <linux-wireless@vger.kernel.org>; Thu, 20 Nov 2025 09:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763630013; cv=none; b=vCwQIl2+L5pX1jdQEevZcYOnlGPoODHiTKY5JL5LMquAWuip0m/ijJBgcCVtqO7yAPeuewfwIRy7bsi9lU0rGZeEESEc0HYbPDnCfauqYHMpRrhconYNUzDkLxOdIXL1UWi03lu2e2/Bg7z8zyFX3POwwLM6BwrSxPkDpGjovfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763630013; c=relaxed/simple;
	bh=HxgWjt+xTFrGbEIkbWEm8UVQGsjHCaCyAIpml5ABskw=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JB3yMJuiZ1zXgYSVpexhKOgCpw27r79tT0q63GxDwbuTVVPBnO05rVcch2S3hfFk8E9IU3jtGauMhfEyAAA6FS5aiR3me7LoWTXcUj+6bQ5LhvauoF3xIxbSpQI12qEzhXeaHzhBp6o9OYuo5e81ScnzRs2Kwpfa4pbrWKOkMy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=s3ibAhh2; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=43AeJXUm8tDnpj9NOzmGbnmUtHrxkLSyMpq2cjiAckI=;
	t=1763630011; x=1764839611; b=s3ibAhh2hdj9XCYh16o7qFg2rGXwfgVxpYRL8Cy1jVcR8kt
	hicL0m6aesLsZYhnOLKMiU5osq3hhQ+TdrpxFgVjVQMT8EP3/GfcGzJP18wxszniP8EHgib5fua8q
	YCMKo7tLbXTVJIqVajQ7SQvNWXN8GTljd/vyUIX8GCqh/AEd7G7WJ7YcHMh6TN8RmUwN+ecoLXLg9
	nyQGcO7jBTGzfW6EZRO4vpP8+ctgxncWjOyaQY3gwvdxWlIBRp8FCEMTC6lav1YMkCW8A1r0JtNQ3
	TC1ManMzO5Yb6rPb7Fp9W67OFTtpuNKqDfot0qdKLmzKNVe0HFXenbF3Kr0z/JPg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vM0jI-00000004Vad-0NFv;
	Thu, 20 Nov 2025 10:13:28 +0100
Message-ID: <c66baad64f4e1ec6c3e7350fef4d3d0b65cec26a.camel@sipsolutions.net>
Subject: Re: [RFC v3 wireless-next 1/4] wifi: cfg80211: fix background CAC
 cancellation
From: Johannes Berg <johannes@sipsolutions.net>
To: Janusz Dziedzic <janusz.dziedzic@gmail.com>, 
	linux-wireless@vger.kernel.org
Date: Thu, 20 Nov 2025 10:13:26 +0100
In-Reply-To: <20251115174230.20504-2-janusz.dziedzic@gmail.com>
References: <20251115174230.20504-1-janusz.dziedzic@gmail.com>
	 <20251115174230.20504-2-janusz.dziedzic@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Sat, 2025-11-15 at 18:33 +0100, Janusz Dziedzic wrote:
> Fixes missing CAC_ABORTED event when background
> radar is canceled.

Please phrase imperatively: "Fix ..."

> @@ -1231,6 +1228,10 @@ void cfg80211_background_cac_done_wk(struct work_s=
truct *work)
> =20
>  	rdev =3D container_of(delayed_work, struct cfg80211_registered_device,
>  			    background_cac_done_wk);
> +
> +	rdev_set_radar_background(rdev, NULL);
> +	rdev->background_radar_wdev =3D NULL; /* Release offchain ownership */

"offchain"?


Also not sure the locking here looks right to me, don't drivers usually
expect this to be called with wiphy mutex?

johannes

