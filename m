Return-Path: <linux-wireless+bounces-32613-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oLK4A8WZqmkxUQEAu9opvQ
	(envelope-from <linux-wireless+bounces-32613-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 06 Mar 2026 10:09:25 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7201521DA23
	for <lists+linux-wireless@lfdr.de>; Fri, 06 Mar 2026 10:09:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EC89C307BDB7
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Mar 2026 09:07:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 637EA33DEFC;
	Fri,  6 Mar 2026 09:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="m/GZVrT1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E79333B6D1;
	Fri,  6 Mar 2026 09:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772788032; cv=none; b=Iep053brKJvEJcfZjVkIFNxl3XYZNm7KVdB1teh8B0bofwKKXMoHnKLj0GwCIUxzO1LbnCGSQoCxiXTIZghF35ZhORgIqbyz7OU3XyB41u58VniwE54QTxXH0THxCSFRSK073r/9aiGdzAHCZM42n/fl/y575eq897lE/H+LThI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772788032; c=relaxed/simple;
	bh=NBwbVilvUb4AHPANdxHrqDWuVkLIseBvlHc6oT/oIl0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Tl7Eq0sErJX2CoI/CkPSMKlJamhkbN6wjNiaa4Rkwsfh8/Qzp6TKmmIX3cfPLc57VQJGH0JhUZRWS2iRLQ+RHaP00tV3sIttD3xOJgjfkc73oOH5hcFVp6MlAAqKo+3FDKv0+r9p9biYH68beJK72RMi6jgbaTBwLv96g2hsJq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=m/GZVrT1; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=ThycKsEKWTTRPXuKgeYYjrxaMJPEIwjYvYV5WdtJgIM=;
	t=1772788029; x=1773997629; b=m/GZVrT13tLxV1Gp8/ki/75bR7He21/vH+pIaeXfbwhIybb
	1DHNb/KnV9YdFSlpbTgoEJ4FtSpA6PZUMrmF5+vjTmApKQvuAk4EeLUiySGWoXgVaViqim9Cgwj32
	RYUuWoovYxFGtzDj1WgqKs7IG/kt69QTumCwpvAc+LIJYG2O3NbrCDAkiyj2xeYvPtEn4iJfiuNdz
	N9zKxjpp8HyDnl+RgW0gYrgO67ea0jvqBRicQYyKJYuuNjm/swu++f366I/uiM5wKEkxqKwvzCoHx
	FJvw/luO/Uk4xc+u5fvwKgkHtLVoMzK8KI3/e7FPct3g6QkcrB589m1AvXLwjY8Q==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vyR9H-0000000A0Ac-0RNk;
	Fri, 06 Mar 2026 10:07:07 +0100
Message-ID: <d3918fe7fbce9517038a85980b5b58ef95a5cdfe.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next 17/35] wifi: mm81x: add mmrc.h
From: Johannes Berg <johannes@sipsolutions.net>
To: Lachlan Hodges <lachlan.hodges@morsemicro.com>, Dan Callaghan
	 <dan.callaghan@morsemicro.com>, Arien Judge <arien.judge@morsemicro.com>
Cc: ayman.grais@morsemicro.com, linux-wireless@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Fri, 06 Mar 2026 10:07:06 +0100
In-Reply-To: <20260227041108.66508-18-lachlan.hodges@morsemicro.com> (sfid-20260227_051337_652822_A8290BE6)
References: <20260227041108.66508-1-lachlan.hodges@morsemicro.com>
	 <20260227041108.66508-18-lachlan.hodges@morsemicro.com>
	 (sfid-20260227_051337_652822_A8290BE6)
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
X-Rspamd-Queue-Id: 7201521DA23
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[sipsolutions.net,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32613-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,sipsolutions.net:dkim,sipsolutions.net:mid]
X-Rspamd-Action: no action

On Fri, 2026-02-27 at 15:10 +1100, Lachlan Hodges wrote:
>=20
> +#define BIT_COUNT(_x) (hweight_long(_x))

Is that really worth having?

> +/* Used to spehify supported features when initialising a STA */
> +#define MMRC_MASK(x) (1u << (x))

typo, but is that even better than BIT()?

> +struct mmrc_sta_capabilities {
> +	u8 max_rates : 3;
> +	u8 max_retries : 3;
> +	u8 bandwidth : 5;
> +	u8 spatial_streams : 4;
> +	u16 rates : 11;
> +	u8 guard : 2;
> +	u8 sta_flags : 4;
> +	u8 sgi_per_bw : 5;

I think this packs better if you use a bigger type?

johannes

