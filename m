Return-Path: <linux-wireless+bounces-34640-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 1hFbEwRf2WlCpAgAu9opvQ
	(envelope-from <linux-wireless+bounces-34640-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Apr 2026 22:35:16 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F4883DC7F5
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Apr 2026 22:35:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C34343006B42
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Apr 2026 20:35:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD41939A7FA;
	Fri, 10 Apr 2026 20:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="pP81kg9O"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8099E37FF58
	for <linux-wireless@vger.kernel.org>; Fri, 10 Apr 2026 20:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775853311; cv=none; b=rOrFMCx5o3RBgpT2eIgT37TXtwaTSkFvMkjAr/Vslrd7zpzm0Uj98biCfYDtlakaMZSNca/VYZo1r0yxgTxWYNZee+oTcKRMJTmLTmwV384yYr2+wwVWHm7Mjf2e3fmOeSTxk/PXHyIxMSD9Rnca/Dz3qbPDHZZ9KKZ+AA2wZB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775853311; c=relaxed/simple;
	bh=jgOsQyXVr7A5bgyPhYyjytbo4HPYYm9WFPKmAYU08E8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=POqBmvud7zihmgGN+cSQutVq8dnyJcZyROS1+Fg7eOPjw7mqt2JsWmuSXI6E8OEt4fYxIutKZso3Kj5u/Oke86St2O+h3YBfOmZLjBbEjcnnoj1RZXfIixPTfSNGEn7BGq8A5+8kQtO5yqso56xoVqnGCyduqknrruT92Br4fZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=pP81kg9O; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=0s1TC+eOb/fwGzrMLxG/BYC7iVbhF4ZYk7ETlx7mpGE=;
	t=1775853310; x=1777062910; b=pP81kg9OnQRNI4QXAPLm3iQ4hn7QrO0cA9HLRN3hZWSzTBK
	9nKU0bktETXm8woj9Npm0daZHKDYfwOEC2qtMGRphMSaNp4Fg90dLzRH1lz8qBHeEuSW4Z35zqu/s
	Jii5o8If9RMehj6kQH1tW0zYNtqxKSU7IzaxkpFXI39JPE4kXtvRYJxhhaRCT5q47WyQtUYQ2UGYO
	vhFrpqSn2IzkJyyHBmougxkFpo6nmwWm7gQw2w7XntOMfY72W5x+CZAnCMqzMgC1U0/sNf14f6/+N
	yEPxgnbOLBlZG54s6AmkNxHmLbAMGnqaimV318c96D8swBuG4aYJhuFEhR+DZXzw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wBIZI-00000000sOG-0g8j;
	Fri, 10 Apr 2026 22:35:08 +0200
Message-ID: <2d8d1edeeefb720acfdfcc595a7fca615ae64a64.camel@sipsolutions.net>
Subject: Re: [RFC PATCH 2/7] wifi: make EHT capa size check not read
 reserved bits
From: Johannes Berg <johannes@sipsolutions.net>
To: Pablo Martin-Gomez <pmartin-gomez@freebox.fr>
Cc: linux-wireless@vger.kernel.org
Date: Fri, 10 Apr 2026 22:35:07 +0200
In-Reply-To: <20260410190354.394742-3-pmartin-gomez@freebox.fr> (sfid-20260410_210402_706482_E2BE5CC8)
References: <20260410190354.394742-1-pmartin-gomez@freebox.fr>
	 <20260410190354.394742-3-pmartin-gomez@freebox.fr>
	 (sfid-20260410_210402_706482_E2BE5CC8)
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
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[sipsolutions.net,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-34640-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 8F4883DC7F5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, 2026-04-10 at 21:03 +0200, Pablo Martin-Gomez wrote:
>=20
>  drivers/net/wireless/ath/ath12k/mac.c |  3 +-
>  include/linux/ieee80211-eht.h         | 58 ++++++++++++++++-----------
>  net/mac80211/eht.c                    |  3 +-
>  net/mac80211/util.c                   |  8 ++--
>  net/wireless/nl80211.c                | 13 ++++--
>=20

>  static inline bool
>  ieee80211_eht_capa_size_ok(const u8 *he_capa, const u8 *data, u8 len,
> -			   bool from_ap)
> +			   bool from_ap, enum nl80211_band band)

I don't see how this can build without adjusting net/mac80211/parse.c?

johannes

