Return-Path: <linux-wireless+bounces-33188-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mJatLRK5s2nbaAAAu9opvQ
	(envelope-from <linux-wireless+bounces-33188-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Mar 2026 08:13:22 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 62BDE27E9B9
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Mar 2026 08:13:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6F30D3028B59
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Mar 2026 07:12:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78C30365A13;
	Fri, 13 Mar 2026 07:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="kC7YnIan"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BEBF3659E0;
	Fri, 13 Mar 2026 07:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773385967; cv=none; b=PRfdDD33SGxPeQJK386wi+0xr/d0u/yLAvrNqojOqYJk0Txn3C9pdOH90ZbbJ++k2+K9hdgv3rL897xjyGHTzQi9T0iVjP/gOS9dU15smCoYUENnTGLMz0yjpdWZqpRBvxyq8kUnZzlZ0j4Cpq4Z1N4tkdBCFTo/ydFiCxEOaVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773385967; c=relaxed/simple;
	bh=OhLfeHTAadTVuXB1MC45XSgW0SYGaOnJQ/Lz3vnYClM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XviBAFtDYhhdLDTT2680dXWczz2gsN4eg3usvpW9YuONC394PDM6U6sCfrnrj7fz+Uu2qmp95RBEfSE1KXq6WB4NP+YMyxO50+0rjiKhlMQPOhxUP2oyASHi+E7dpz0Wet/Ti/Kummhv1ZwRUvwDztxDiGCu5PBvZd5xBSEVpuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=kC7YnIan; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=llOWcWbfVoHqUkpws6uG45xBYs8atVA0Jk2++iH0g0Y=;
	t=1773385966; x=1774595566; b=kC7YnIancwtGCNpFcpYejqaeWLktZ/flRWQ/i1FPQpSA6mk
	UwJpW5/VlEPO1PS+cKbcSbz8grmyibqj4jxbZl30+FpeKk5wIGO7HjaJsObaJifAXWNtV36f3UM88
	Q1TxkKUFDXZ3LVEN0q4K/jZ47UuLRjGcZCcnhts8onPDMvBjeFpzKx7dE5ns43IMJUMGfcFkee0JT
	NdNTxq48HfTxsIQm8EJJTc8raqZy0I48eKCbjQYXzJ6opX05NpsX+sHqMgLuI05v4ZxH80vYnrTmF
	YokSXPAa8WIxN026UGveVGIWh5zyf3UZWu/cjmyplB2Qd0KvL2nOSCA+3yvwSsZQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1w0whK-0000000Gmph-290j;
	Fri, 13 Mar 2026 08:12:38 +0100
Message-ID: <b1c14b931bf62b114ca44c18f2724a601efa76f5.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: mac80211: fix WARN_ON_ONCE in ieee80211_tdls_oper
From: Johannes Berg <johannes@sipsolutions.net>
To: Deepanshu Kartikey <kartikey406@gmail.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+56b6a844a4ea74487b7b@syzkaller.appspotmail.com
Date: Fri, 13 Mar 2026 08:12:37 +0100
In-Reply-To: <20260310160013.515096-1-kartikey406@gmail.com> (sfid-20260310_170025_576156_E5C4B1FB)
References: <20260310160013.515096-1-kartikey406@gmail.com>
	 (sfid-20260310_170025_576156_E5C4B1FB)
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-33188-lists,linux-wireless=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,56b6a844a4ea74487b7b];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,sipsolutions.net:dkim,sipsolutions.net:mid]
X-Rspamd-Queue-Id: 62BDE27E9B9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 2026-03-10 at 21:30 +0530, Deepanshu Kartikey wrote:
> =20
> -		WARN_ON_ONCE(is_zero_ether_addr(sdata->u.mgd.tdls_peer) ||
> -			     !ether_addr_equal(sdata->u.mgd.tdls_peer, peer));
> +		if (is_zero_ether_addr(sdata->u.mgd.tdls_peer) ||
> +		    !ether_addr_equal(sdata->u.mgd.tdls_peer, peer))
> +			return -ENOLINK;
>=20

I think that check needs to be earlier, otherwise side effects happen
(TDLS_PEER_AUTH flag).

Also, I'm a bit confused, how is it possible the sta_info_get() worked,
but there's no TDLS? Maybe really what it needs is

                sta =3D sta_info_get(sdata, peer);
-               if (!sta)
+               if (!sta || !sta->sta.tdls)
                        return -ENOLINK;

instead?

johannes

