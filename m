Return-Path: <linux-wireless+bounces-31781-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AFdGJioPjmkG/AAAu9opvQ
	(envelope-from <linux-wireless+bounces-31781-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Feb 2026 18:34:34 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 469CC12FF71
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Feb 2026 18:34:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6AE3B3014FFE
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Feb 2026 17:34:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1481C2459DC;
	Thu, 12 Feb 2026 17:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="xPYbgxHN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C13FB224234
	for <linux-wireless@vger.kernel.org>; Thu, 12 Feb 2026 17:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770917672; cv=none; b=UXUKni4NeXMTJvfppNDGb3bt+e++QE9VQocRQDOZiFiHbHYkb9BXTHSapa/WnNn6CiuVR9p7TSv1u6UK1BcqycXXCG7c7Q7RX28IdXih0ElSY/mNmCrbmisLk1OJHSMH7xr2ydjj/22nK6H4O5M4NYZC0/0cnwtPFDXu43EOWDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770917672; c=relaxed/simple;
	bh=ZzEghETUHCmPyrnNEm8rUuMHgeJVnXu2MTdsHXqM6oI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GN5yDve8vEJd4nyLYCTfvhzTYnqOX0VP2Uq3ASfB3EnL7i+yIULFAaQ8qQ+B1r+dOl/5imy1Oh1f+2+HwJwFstt0HQRJj3Ghx7Iwna3UFLUmGzxIXgYUqUuQ1gkYAuwiGvHNyazsSRidVWChwG746y2513yNsZWQo7X6v+9yGxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=xPYbgxHN; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=4aWW69o5XEKE6uKONq0Boob7BmGNpR2tVxxb7IxJa40=;
	t=1770917670; x=1772127270; b=xPYbgxHNV/p/8s5n9qbR5NkKZeLLj+3vi9ejpBEqwbYulO9
	6ZPZ+m5ppSRygiaXKKqc2DV0ItZpl+IOSzTJO83murXzmn9bbCtAh9fWPFLe6yiUUjWidqUs6gphP
	DV2T3M7i0ltdBtxmYoylHCXwsYw45r2SziU4GtaIdK0b3w5gU2cXpvp49hXSPlBuQzf8iW7gO6DRG
	KIL1ZavbYnsvqpsKMrIAC68/zuko3Hj7jIQkOU6Ln/9K+v5cV3YxFJBqNij/Uhc5y24w/KHvn3qCs
	WG7u6Lg2Giamjom3wd3epAN4JHp/4tzlwzbT0U8F6BTwV7TpH4MgYFA1T3MuBOGA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vqaa5-00000006Sud-2617;
	Thu, 12 Feb 2026 18:34:21 +0100
Message-ID: <7ac00be5cfa6a31b91d72db027030b89195f25a2.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next v2 1/2] wifi: UHR: define DPS/DBE/P-EDCA
 elements and fix size parsing
From: Johannes Berg <johannes@sipsolutions.net>
To: Karthikeyan Kathirvel <karthikeyan.kathirvel@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org
Date: Thu, 12 Feb 2026 18:34:20 +0100
In-Reply-To: <20260212172401.234059-2-karthikeyan.kathirvel@oss.qualcomm.com>
References: <20260212172401.234059-1-karthikeyan.kathirvel@oss.qualcomm.com>
	 <20260212172401.234059-2-karthikeyan.kathirvel@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[sipsolutions.net,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-31781-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 469CC12FF71
X-Rspamd-Action: no action

Hi,

Nice, thanks for sending this.

> + * subclause 9.4.1.87. Refer Figure 9-207u.

> + * Please refer IEEE80211_UHR_DPS*

"refer to"? Or "See Figure ..."?

> +#define IEEE80211_UHR_DPS_PADDING_DELAY			0x0000003F
> +#define IEEE80211_UHR_DPS_RESERVED1			0x000000C0
> +#define IEEE80211_UHR_DPS_TRANSITION_DELAY		0x00003F00
> +#define IEEE80211_UHR_DPS_RESERVED2			0x0000C000
> +#define IEEE80211_UHR_DPS_ICF_REQUIRED			0x00010000
> +#define IEEE80211_UHR_DPS_PARAMETERIZED_FLAG		0x00020000
> +#define IEEE80211_UHR_DPS_LC_MODE_BW			0x001C0000
> +#define IEEE80211_UHR_DPS_LC_MODE_NSS			0x01E00000
> +#define IEEE80211_UHR_DPS_LC_MODE_MCS			0x1E000000
> +#define IEEE80211_UHR_DPS_MOBILE_AP_DPS_STATIC_HCM	0x20000000
> +#define IEEE80211_UHR_DPS_RESERVED3			0xC0000000

Not sure I'd defined the ..._RESERVED* ones at all? There's no way we'd
ever use them really unless they get defined to something else.

> + * subclause 9.4.1.87. Refer Figure 9-207u.
> + *
> + * Please refer IEEE80211_UHR_DPS*

Also here as well.

> +#define IEEE80211_UHR_DBE_OPER_BANDWIDTH			0x07
> +#define IEEE80211_UHR_DBE_OPER_DIS_SUBCHANNEL_BITMAP_PRES	0x08
> +#define IEEE80211_UHR_DBE_OPER_RESERVED				0xF0

same comment about reserved

> +#define IEEE80211_UHR_DBE_OPER_DIS_SUBCHANNEL_BITMAP		0xFFFF

And this ... I think should just not be there? When would we ever mask a
16 bit value with an all 16 bits mask?

> +#define IEEE80211_UHR_P_EDCA_RESERVED		0x7800
> +/**

reserved again, don't think it makes sense - and probably should have a
blank line before the /**

>  static inline const struct ieee80211_uhr_npca_info *
>  ieee80211_uhr_npca_info(const struct ieee80211_uhr_operation *oper)
>  {
> +	const u8 *pos;
> +
>  	if (!(oper->params & cpu_to_le16(IEEE80211_UHR_OPER_PARAMS_NPCA_ENA)))
>  		return NULL;
> =20
> -	/* FIXME: DPS */
> +	pos =3D oper->variable;

I'd probably have directly put 'const u8 *pos =3D oper->variable;', but
doesn't really matter.

johannes

