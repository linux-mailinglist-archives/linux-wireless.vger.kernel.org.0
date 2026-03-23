Return-Path: <linux-wireless+bounces-33711-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UGcUG3kewWmTQwQAu9opvQ
	(envelope-from <linux-wireless+bounces-33711-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Mar 2026 12:05:29 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C05C22F0CD6
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Mar 2026 12:05:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2A55D30193A7
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Mar 2026 10:55:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A49B037E2E6;
	Mon, 23 Mar 2026 10:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="G6kWTQ8q"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7226932D7C7
	for <linux-wireless@vger.kernel.org>; Mon, 23 Mar 2026 10:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774263313; cv=none; b=Q2UktsxndIhkSYOmxlDwViMkuQXy4f87kJu3+PTXFKGgLHQWGXFq2JV7YlXfzkB3L7DBcizXDDy6DFmBJ7oinWcMIpOxIzrH2X/tJWSORkjvPr+5mGgJ85Xh6JIXrOWY5i3adxj8FaYu1voLeflo1Yt2A1vIbD0kKhJTpdOHU80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774263313; c=relaxed/simple;
	bh=GnYxp243Yqqae4eYxesQG0t32Ur10J7RnTwruI0EB+o=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mcOXGlMhXmV0z4cOOxwwoyRPFYZN6wxylIdi14S0amwBtdG+cV8gk1bnbpMHfCOwE17My/FdNE0VlUO9Ffd8e52zhFbpK1GSXGlZeW2maQpwDQJKGXvYDQ9f9cg3Kb8JCcEOrK7sL9mlkU9V9uc23ZYtppdrEL+1mGtd8vqWnoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=G6kWTQ8q; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=+rtJEMZzW+gcodCKGrHHsBvjctr2FqosgqoQqchbBjQ=;
	t=1774263312; x=1775472912; b=G6kWTQ8q78p/xwX7pLZ808C2bhQR8acQRnOYl9FfIC9i96p
	l+KPgqLqCffaZc61muB92nd0VHVsG8mLjX+0UuY9AO/LQhCzaGzWaBu6Cmc/okR1NrI0RRV2q0Q1F
	9iMJ8I4zBfPJlsA5kuu7W00Rvw7PEra3WJog9r6tNBBRLgEI+pTF4Y8V1WuDHB/7FgDBtBbTnbUnh
	w0uwtC8eQU9SsB6CFbI9c5QCJg7bhbvs2CHNwT+g4HSPsB/v/AjVkMrDFXSci/bV+vkg0lPoHm2TP
	y5FkD3LpG9aHaGRNggt40NW2xOs8nEVHqaH9EDsOjAjwKudHDpjVjv4NwiBhAloQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1w4cwA-00000009igj-1EfH;
	Mon, 23 Mar 2026 11:55:10 +0100
Message-ID: <cfbedb0dded5917d35e62936013a387285520645.camel@sipsolutions.net>
Subject: Re: [PATCH 4/4] wifi: mac80211: add ieee80211_txq_aql_pending()
From: Johannes Berg <johannes@sipsolutions.net>
To: Felix Fietkau <nbd@nbd.name>, linux-wireless@vger.kernel.org
Date: Mon, 23 Mar 2026 11:55:09 +0100
In-Reply-To: <20260323101954.874299-4-nbd@nbd.name>
References: <20260323101954.874299-1-nbd@nbd.name>
	 <20260323101954.874299-4-nbd@nbd.name>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-33711-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C05C22F0CD6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 2026-03-23 at 10:19 +0000, Felix Fietkau wrote:
>=20
> +u32 ieee80211_txq_aql_pending(struct ieee80211_hw *hw,
> +			      struct ieee80211_txq *txq)
> +{
> +	struct ieee80211_local *local =3D hw_to_local(hw);
> +	struct sta_info *sta;
> +
> +	if (!txq->sta)
> +		return atomic_read(&local->aql_bc_pending_airtime);
> +
> +	sta =3D container_of(txq->sta, struct sta_info, sta);
> +
> +	if (unlikely(txq->tid =3D=3D IEEE80211_NUM_TIDS))
> +		return 0;

I think better to put that check before the !txq->sta check. I don't
think it's there yet, but I think NAN is adding a per-interface mgmt
queue or so. Better to just cover all the cases here now.

johannes

