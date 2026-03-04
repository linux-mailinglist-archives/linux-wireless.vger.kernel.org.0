Return-Path: <linux-wireless+bounces-32458-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EPKfDVkOqGk8ngAAu9opvQ
	(envelope-from <linux-wireless+bounces-32458-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 04 Mar 2026 11:50:01 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A777B1FE8B6
	for <lists+linux-wireless@lfdr.de>; Wed, 04 Mar 2026 11:50:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D357D30071CD
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Mar 2026 10:49:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F067D342535;
	Wed,  4 Mar 2026 10:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="l3a84u44"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEA87372ECA
	for <linux-wireless@vger.kernel.org>; Wed,  4 Mar 2026 10:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772621382; cv=none; b=bJZ6z9qano+Ufsn8mJvfodqpaYhggxs2MVYAmlGSD2fXZ0RWwOOLgdxll5oKYOuV9aC+q5vNMoU/zB1Z3gvVnvSFNG9X8F94MzbH9ljEKAXOlfy0ZxN73JT30nJS5COsshmFAqBZDeyPKGPwi2c/PwEfzpskBgJiT1Wyq6Y/nEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772621382; c=relaxed/simple;
	bh=eBt0hIYZwNCdbjz1sROzK94b41E1PdEEgJPIef7BZt0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nAbUFL8Ch+jS3T7FjETUSgvIVEmWdaOG0ZQvCn0gfTSNsWotABDYjRBfwBAgCK0iw+DuyH3nVk68LKOAppepG7ooUCh3UJv4trjnZ1QnhCax81NvHUgpHdHklqa8N7Myz4M6E2vCqU517Ojx4i9tFijswL++9pU0MLgh3TdxvZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=l3a84u44; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=LuD5dsiX9j+Dpr5R5z8n24aMxt10pxKsVhlen7pPwfc=;
	t=1772621381; x=1773830981; b=l3a84u44QZ5e9CCWGCyjYqCRSx0X9AbCvpvMXMQv0+cV0Ue
	ZJUxgSMwTK2zPn5cIKGzctui0vMxKaM6JEY9SQpHg9X1NfrRiNkcPqx9aZ6NW+/+8O5z+dS9RW4Dw
	PQ/Ql3FhH52TdV/XyX211x2ScZ3L/nUvMFYc/rSEl+s8UvCe3D2DM2CX8WJP0a+dVBWkDO+pC8X2X
	3YQ6LbKV9pBJ++e0SjfJmLXQh1Gdh5IeO0P+5DTQuMvjw1m1KRZ3XsmUOnAf0LkUUKAdyzZxAqLWF
	zs1rRAqd0x8evGzuBe0+sT0rKjwZJ7W+jAEYzUCYrpLYW8zVXV0OYEX8OH7TdZBg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vxjnN-000000081oe-31VZ;
	Wed, 04 Mar 2026 11:49:37 +0100
Message-ID: <f256b3e7fa9227caf0bbd6696b81aa79b145945c.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next v5 2/2] wifi: mac80211_hwsim: Add UHR
 capabilities to the driver
From: Johannes Berg <johannes@sipsolutions.net>
To: Karthikeyan Kathirvel <karthikeyan.kathirvel@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org
Date: Wed, 04 Mar 2026 11:49:36 +0100
In-Reply-To: <20260304085343.1093993-3-karthikeyan.kathirvel@oss.qualcomm.com>
References: 
	<20260304085343.1093993-1-karthikeyan.kathirvel@oss.qualcomm.com>
	 <20260304085343.1093993-3-karthikeyan.kathirvel@oss.qualcomm.com>
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
X-Rspamd-Queue-Id: A777B1FE8B6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[sipsolutions.net,none];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-32458-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,sipsolutions.net:dkim,sipsolutions.net:mid]
X-Rspamd-Action: no action

On Wed, 2026-03-04 at 14:23 +0530, Karthikeyan Kathirvel wrote:
>=20
> +++ b/drivers/net/wireless/virtual/mac80211_hwsim.c
> @@ -4478,6 +4478,43 @@ static const struct ieee80211_sband_iftype_data sb=
and_capa_2ghz[] =3D {
>  			},
>  			/* PPE threshold information is not supported */
>  		},
> +		.uhr_cap =3D {

Missing from the context, but this is non-AP side.

> +			.has_uhr =3D true,
> +			.mac =3D {
> +				.mac_cap[0] =3D
> +					IEEE80211_UHR_MAC_CAP0_DPS_SUPP |
> +					IEEE80211_UHR_MAC_CAP0_DPS_AP_STATIC_HCM_SUPP |

"Reserved for a non-AP STA."

Maybe we're just better off doing this as we implement features?

I've applied patch 1 with some minor edits.

johannes

