Return-Path: <linux-wireless+bounces-31089-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IHcNFYlgcmnbjAAAu9opvQ
	(envelope-from <linux-wireless+bounces-31089-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Jan 2026 18:38:17 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E1D216B7B3
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Jan 2026 18:38:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1864F30D6BC2
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Jan 2026 17:06:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6077E366DB0;
	Thu, 22 Jan 2026 16:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="Un3WwchV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C66ED3624DB
	for <linux-wireless@vger.kernel.org>; Thu, 22 Jan 2026 16:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769100113; cv=none; b=bK/rIFx/R/NDX6mAyBBLKWuhh2erhP0wvjmjltaYSzlPk1d/PZzGweFT3iyFWreULWSxN065zgHcZoknApHF+JW8dDyAWVi6Im5/UGfw+Tz30DRmg/7XUW1HA+MYv+NtyqBuQcJrdwXwHz65VDZgpj1+cp89f7MhRuSr9Nzc4S4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769100113; c=relaxed/simple;
	bh=p0F7OtkvqeBlRUVvQNfUUbvthsVKxKCrn+F9uF8lM4Y=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Gx+XvPUrA8odXpXnjzV/GIC9dNUJmuXQeCMMv2amSp2daa69zICQ22IBI/HRuIchzXRfomIEEbAI/m3OS+6ZEvBZGhZcUdMm4Pai/RXiBqaiDKZlsJdF52GdZxYW75TAF3qmlhFVLDTyFnu5NG9USij6nNzVQGfi6bEl9G0IF1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=Un3WwchV; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=p0F7OtkvqeBlRUVvQNfUUbvthsVKxKCrn+F9uF8lM4Y=;
	t=1769100108; x=1770309708; b=Un3WwchVlUvigFJebL3O2xIbLVQctBjkyidhR9QFDw5o+rh
	sxBQOv5tgZQJ3zMz+pr4etAF1YiDRPxerynbNRxTepuK2yfhJhNgQioHPx8mofEgxdZwtcL3y2C5I
	tmw6N1U0ORDSw7Bot39ExV824M7Sg/ppVjv9GvMlG7GU+50SFuMTexjayfAAPkl6XKnTWyIto5PS5
	Iy4wYl7ppnsh3YWGqWliTRE8BKcSiELgQNdy5oDf4ylwvhNgYL2DQBb8k5zO4izv//c/fxlZokKFb
	RZFf4BMWr3kX2UGWp94oFMQjL9EcTlDZ4ljwmh3I7+Mz9uVxMR9kuPlTTP8WWp6w==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vixke-00000000wQ5-090q;
	Thu, 22 Jan 2026 17:41:44 +0100
Message-ID: <b2cc421f0416cc1ab42a937ccd78b4a8c27d47cb.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: mac80211: do not set 320MHz EHT capabilities on
 non 6GHz band
From: Johannes Berg <johannes@sipsolutions.net>
To: Nicolas Escande <nico.escande@gmail.com>, linux-wireless@vger.kernel.org
Date: Thu, 22 Jan 2026 17:41:43 +0100
In-Reply-To: <DFV9KI49QEP2.2TMVJXR5EK0B7@gmail.com> (sfid-20260122_173804_650198_DBFE758F)
References: <20260122145620.861355-1-nico.escande@gmail.com>
	 <829488acfdbf7ecfe6418bfb2c5669dae18392ed.camel@sipsolutions.net>
	 <DFV9KI49QEP2.2TMVJXR5EK0B7@gmail.com>
	 (sfid-20260122_173804_650198_DBFE758F)
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[sipsolutions.net,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWO(0.00)[2];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-31089-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.991];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,sipsolutions.net:mid,sipsolutions.net:dkim]
X-Rspamd-Queue-Id: E1D216B7B3
X-Rspamd-Action: no action

On Thu, 2026-01-22 at 17:38 +0100, Nicolas Escande wrote:
> For context I initially encountered this problem on an ath12k AP which ha=
s a
> single phy with both 5GHz & 6GHz bands available but only had a 5GHz AP s=
tarted.
> On such a platform, we set this '320MHz in 6G' operation on the 5GHz no m=
atter
> what beacause of the phy's capabilities.

But that's what I'm saying why it's a driver bug - the PHY capabilities
are advertised *per interface type* and *per band* by the driver. It
shouldn't set this one on 2.4/5 GHz bands.

johannes

