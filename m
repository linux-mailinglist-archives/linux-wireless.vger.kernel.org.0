Return-Path: <linux-wireless+bounces-36569-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KGTqLjS1Cmpp6AQAu9opvQ
	(envelope-from <linux-wireless+bounces-36569-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 18 May 2026 08:44:04 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F442566E0D
	for <lists+linux-wireless@lfdr.de>; Mon, 18 May 2026 08:44:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C75F3301BA5E
	for <lists+linux-wireless@lfdr.de>; Mon, 18 May 2026 06:43:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6894A3CCFB2;
	Mon, 18 May 2026 06:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="xNaGhJlp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72DC43C0607;
	Mon, 18 May 2026 06:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779086589; cv=none; b=NHUpi7RxSKUFGoYbutth/X14FLYhcAzgiV7QPHPK3NGmrYpcY5n5VgJmn4ygte0ziPlpRkxRct1VVEhxZgoYw+pilVcLiSJw6wn4vcU8QOcOGuZIApxlzxRgN/kE/DC0iZ6Tmgqj9JdE2RkaJA01m1MwbUYF1lMWk84/sHGMdhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779086589; c=relaxed/simple;
	bh=LzyWqK2a2l76NqDKIgymD2VMEvN/3ogFGShDejxrBoo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=t+hYr2b8jYJ1GealIhPMYPUJziMQOSeUSZorsMfTW5qu0vLfedsJN6lJeNgWRIuhJj5CCmS3XoZBIAnbgITZHJnxle7cJjiJTz1WLcS4misbRX+9c5ZZ2LCtJMACz2XJwmCfuAeDKXOvs/cwuvP5rPQDiiSD83D3nSFBlatSxT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net; spf=none smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=xNaGhJlp; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=cAvxYdufMeTTk1yCF3GHUN//4l+thtVu6Qm67/h0zss=;
	t=1779086584; x=1780296184; b=xNaGhJlpWu3q/109cK+tke58wrxh5CFHDVuKEdqG0ZkGQHa
	3iGUruU87OeoiKr2O6WFCwzwPm2IdhK0IHpSOUkEzK5Ubzv8ZG6hriG6aSHIyflPCQbvKrL1x8gUd
	2heVr1pR2Tl+ZVhXNWMIbwc85XdNFbXjUURIOYrlG7xG+9zh1HuK8UskYJpumozUZVtdI1cqP3j3V
	dYvacJHkJVA1AV7bP2+68s3UiBh8Wg4w1jDpJiSI7NNHN4MgDhr1V1PsomoTdz+vn82SH7V9CN3N8
	QvG8fa4pLcx5OOOaYjPPAUiP24hGH6gI7Fb1WLvT+4SsJYMP8A45eZI4Q6LVFyKw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wOrgl-00000001qDo-1U6p;
	Mon, 18 May 2026 08:42:55 +0200
Message-ID: <70c49e598ffba2864c8168c7185c0abec76b59dd.camel@sipsolutions.net>
Subject: Re: [PATCH v2 1/1] wifi: mac80211: fix monitor mode frame capture
 for real chanctx drivers
From: Johannes Berg <johannes@sipsolutions.net>
To: Devin Wittmayer <lucid_duck@justthetip.ca>, 
	linux-wireless@vger.kernel.org
Cc: Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, Oscar Alfonso Diaz
	 <oscar.alfonso.diaz@gmail.com>, fjhhz1997@gmail.com
Date: Mon, 18 May 2026 08:42:54 +0200
In-Reply-To: <20260518064025.96792-1-lucid_duck@justthetip.ca>
References: <20260518063853.96384-1-lucid_duck@justthetip.ca>
	 <20260518064025.96792-1-lucid_duck@justthetip.ca>
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
X-Rspamd-Queue-Id: 3F442566E0D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-36569-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[sipsolutions.net: no valid DMARC record];
	FREEMAIL_CC(0.00)[nbd.name,kernel.org,vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sipsolutions.net:email,sipsolutions.net:mid,sipsolutions.net:dkim,justthetip.ca:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Sun, 2026-05-17 at 23:40 -0700, Devin Wittmayer wrote:
> From: =E5=82=85=E7=BB=A7=E6=99=97 <fjhhz1997@gmail.com>
>=20
> Commit d594cc6f2c58 ("wifi: mac80211: restore non-chanctx injection
> behaviour") restored the monitor injection fallback for drivers using
> chanctx emulation but explicitly deferred the harder case of drivers
> that transitioned to real chanctx ops. mt76 falls in that category
> and still drops every injected frame when monitor coexists with
> another interface.
>=20
> When the monitor has no chanctx of its own and exactly one chanctx is
> in flight, fall back to that one. Otherwise refuse: picking
> arbitrarily across multiple chanctxs would inject onto an unrelated
> channel.
>=20
> Reran the airgeddon evil-twin flow (hostapd AP + coexisting monitor
> VIF on the same phy + aireplay-ng deauth from the monitor) against
> this patch on mt7921e PCIe and mt7921u USB, across both 2.4 GHz and
> 5 GHz, and again on a Kali Linux VM with MT7921U USB-passthrough as
> the closest match to the original reporter's setup. None of those
> reproduced the hang reported against the earlier attempt at the same
> fix (<20251216111909.25076-2-johannes@sipsolutions.net>) or against
> v1 on lore in March 2026.
>=20
> Cc: stable@vger.kernel.org # 6.9+
> Reported-by: Oscar Alfonso Diaz <oscar.alfonso.diaz@gmail.com>
> Tested-by: Devin Wittmayer <lucid_duck@justthetip.ca>
> Fixes: 0a44dfc07074 ("wifi: mac80211: simplify non-chanctx drivers")
> Link: https://github.com/morrownr/USB-WiFi/issues/682
> Signed-off-by: =E5=82=85=E7=BB=A7=E6=99=97 <fjhhz1997@gmail.com>
> Signed-off-by: Devin Wittmayer <lucid_duck@justthetip.ca>
> ---
>  net/mac80211/tx.c | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
> --- a/net/mac80211/tx.c
> +++ b/net/mac80211/tx.c
> @@ -2402,6 +2402,10 @@ netdev_tx_t ieee80211_monitor_start_xmit(struct sk=
_buff *skb,
>  		chandef =3D &chanctx_conf->def;
>  	else if (local->emulate_chanctx)
>  		chandef =3D &local->hw.conf.chandef;
> +	else if (list_is_singular(&local->chanctx_list))
> +		chandef =3D &list_first_entry(&local->chanctx_list,
> +					    struct ieee80211_chanctx,
> +					    list)->conf.def;


Quoting include/linux/rculist.h:

 * Where are list_empty_rcu() and list_first_entry_rcu()?
 *
 * They do not exist because they would lead to subtle race conditions:
 *
 * if (!list_empty_rcu(mylist)) {
 *      struct foo *bar =3D list_first_entry_rcu(mylist, struct foo, list_m=
ember);
 *      do_something(bar);
 * }
 *
 * The list might be non-empty when list_empty_rcu() checks it, but it
 * might have become empty by the time that list_first_entry_rcu() rereads
 * the ->next pointer, which would result in a SEGV.
 *
 * When not using RCU, it is OK for list_first_entry() to re-read that
 * pointer because both functions should be protected by some lock that
 * blocks writers.
 *
 * When using RCU, list_empty() uses READ_ONCE() to fetch the
 * RCU-protected ->next pointer and then compares it to the address of the
 * list head.  However, it neither dereferences this pointer nor provides
 * this pointer to its caller.  Thus, READ_ONCE() suffices (that is,
 * rcu_dereference() is not needed), which means that list_empty() can be
 * used anywhere you would want to use list_empty_rcu().  Just don't
 * expect anything useful to happen if you do a subsequent lockless
 * call to list_first_entry_rcu()!!!
 *
 * See list_first_or_null_rcu for an alternative.

johannes

