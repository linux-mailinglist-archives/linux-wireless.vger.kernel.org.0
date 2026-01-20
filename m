Return-Path: <linux-wireless+bounces-31013-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A1CFDD3C37A
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Jan 2026 10:30:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C6898663661
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Jan 2026 09:09:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DD503BF2F9;
	Tue, 20 Jan 2026 09:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="IVmIsjRT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8665533D50B
	for <linux-wireless@vger.kernel.org>; Tue, 20 Jan 2026 09:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768900173; cv=none; b=kv0T8FuS/++2UvPf06H+FWPjKyEbKSQwVQfZPafS4mr1TyBTyvA8SZWmxNJeJzhwtERrWbojuV+14KKXUx6E02NDU5NlLRKnQoDkH8BXPE3Xicis7HfomPYcQmyVRPPRTjYaArRhOzu5W/TL40MaZKNqDh8jtw2hutRfbDvF4Tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768900173; c=relaxed/simple;
	bh=JV+6rrKQ9IQXrxzGdWI2nV4l8On0RbEumkFXoZ3I7PE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=F783Mu4EtgO77KRVHHy6fFRp4AyE6JSr3J7Xh7mL1YlLH6uvFxLjCpM40Tc+e8s5v/hMUc7Fz0ud3t95zTuY4I8ixs4kaDtbJlEvOYRufBibjMGXGlNkexshN0a2kl52ZOCnogfVuoYP96UHI6FhBataNAyholRwR9msCfAPdyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=IVmIsjRT; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=LKlmelLVvxQ0Ahczs5JZXsGUjMDn/JYcj1uTWGW7Vkg=;
	t=1768900171; x=1770109771; b=IVmIsjRTgJo0e1SL6w2dVUa0GJH1nrY+RF1Ywj9B+YDI51t
	V6NpP1rF1JG5JqerKYASRyoeajRtXkE33wI54oUWUPjTolKApfr3iKsIBkOTvj14wp0xs4+hvhBmr
	gmndyDF7NtSFuj+yXlsG6mWE51dC9r/KekCsd5280ZqYmDEBzOcDzhdcVpsSlmZqAh3NIWVYc9D/H
	dFVHf/tqH610oRdsSMmWse/Ay/6+GInvhNeUmppR3Y3S6yilsZy3qV1Lve40cn9wsLaP/qca5dAhf
	Gn/gbH8hD4jA89qTjju3eOq9g10ZWpPYI0sr8uz92A5rv2r01ovLETVHMf2H/QZg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vi7jm-0000000GiwU-3EbB;
	Tue, 20 Jan 2026 10:09:22 +0100
Message-ID: <a85a3aefd4a60536d68e6bbd2e6a8a2af9846aea.camel@sipsolutions.net>
Subject: Re: [PATCH iwlwifi] wifi: mac80211: ignore reserved bits in
 reconfiguration status
From: Johannes Berg <johannes@sipsolutions.net>
To: Miri Korenblit <miriam.rachel.korenblit@intel.com>, 
	linux-wireless@vger.kernel.org
Cc: Benjamin Berg <benjamin.berg@intel.com>, Ilan Peer <ilan.peer@intel.com>
Date: Tue, 20 Jan 2026 10:09:22 +0100
In-Reply-To: <20260118095410.e54a0830f697.I9aef8f4fb6f1b06671bb6cf0e2bd4ec6e4c8bda4@changeid> (sfid-20260118_085436_785820_710033D5)
References: 
	<20260118095410.e54a0830f697.I9aef8f4fb6f1b06671bb6cf0e2bd4ec6e4c8bda4@changeid>
	 (sfid-20260118_085436_785820_710033D5)
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

On Sun, 2026-01-18 at 09:54 +0200, Miri Korenblit wrote:
>=20
> +++ b/net/mac80211/mlme.c
> @@ -10243,7 +10243,7 @@ void ieee80211_process_ml_reconf_resp(struct ieee=
80211_sub_if_data *sdata,
>  	for (i =3D 0; i < mgmt->u.action.u.ml_reconf_resp.count; i++) {
>  		u16 status =3D get_unaligned_le16(pos + 1);
> =20
> -		link_id =3D *pos;
> +		link_id =3D u8_get_bits(*pos, 0xf);

Seems like there should be a constant for that? Or maybe even some kind
of struct for the "Reconfiguration Status Duple subfield", rather than
parsing the things separately?

johannes

