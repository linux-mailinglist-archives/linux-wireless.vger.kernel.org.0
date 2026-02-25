Return-Path: <linux-wireless+bounces-32170-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eARCHs29nmnYXAQAu9opvQ
	(envelope-from <linux-wireless+bounces-32170-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Feb 2026 10:15:57 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CE016194C03
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Feb 2026 10:15:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 645213021E77
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Feb 2026 09:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DCBF3033EA;
	Wed, 25 Feb 2026 09:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="qjE9L62u"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB90332938A
	for <linux-wireless@vger.kernel.org>; Wed, 25 Feb 2026 09:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772010950; cv=none; b=rDjkbiB/p/ntmKlTPJvVrkLX5gTh1s4iqlMFreMNGKAy6kMxffwqYOPqzU54yUMEgTT6vToBOEecY9NceYlwSA/dwtoZFsk2Q8+d8PD6qV5Ff4NehJ9ssD8yqvXXWYx8ROo7TMxAT2hzBwqGHfetB02SdHhWuwBTFnS0uurFQFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772010950; c=relaxed/simple;
	bh=ygpPJzHw1FTePvNkUJizSKjHRhDwPaUZBa+xP6TNq34=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oMpjmJXnbLs1szY+FmdMhq3rWWuMfRgrQ5aw+nktgS7Dn+KNqqpGIVt4eHBElbUvKZZsswsf7Y/+xFPyneVB/QY8oZLFnrz3TLO5I6PsMLLjfhDdGjuBBOMFs1aks5S12phA5FM5PFhaXxtVPXf9h9LT40gRHp9XITGZWKQAzcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=qjE9L62u; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=o3OtsF+pQzJ4HCt1eAgs7N7oTV7HoAn+7/pV54PS8vY=;
	t=1772010947; x=1773220547; b=qjE9L62uCACBWTH+2ZaHMfNFax0gPrFeiaOpxwtKYzIaaFk
	8q3i9tiZh1kQwt2pMU9GUXqBWEysri1Yl+T3Vzq9YlBdXDtoV1qq3Op+QdNjyLpYVGnQdYrpQirRF
	Jj0cTbni9yVv8n371UqL9PRmAQyXAKN0qNH/2IpAXlGJBlmIdWzK6b76wl+rT46YKyTkSN6lqLHND
	CZSyHtCi6Rz1Pu6eWbo3WU4YWBHfEkr8YyqTJDNGYDXaQtq4US53usmRh059YDIdJ0QAmhRZFM8Bs
	JfDKZkuvN3BJEH6a8+5qs5VXgwHXTqJsF4d9v4aWtHFoufbij+Xwifs5T9XcKZdw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1vvAzg-00000001MNC-1ZTp;
	Wed, 25 Feb 2026 10:15:44 +0100
Message-ID: <0915e34c5839124f7f66cc63e796c1c071e78dcf.camel@sipsolutions.net>
Subject: Re: [RFC PATCH v2 8/8] wifi: mac80211: pass error station if
 non-STA transmit was requested
From: Benjamin Berg <benjamin@sipsolutions.net>
To: Ramasamy Kaliappan <ramasamy.kaliappan@oss.qualcomm.com>, 
	linux-wireless@vger.kernel.org
Cc: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
Date: Wed, 25 Feb 2026 10:15:43 +0100
In-Reply-To: <6197fae9-832c-4e48-b8fc-0b14cb44b5b0@oss.qualcomm.com>
References: <20260223123818.384184-10-benjamin@sipsolutions.net>
	 <20260223133818.00346f27a7d3.I5ffe7bc0d4ccefca5c1e506d5d3d482e13989cda@changeid>
	 <6197fae9-832c-4e48-b8fc-0b14cb44b5b0@oss.qualcomm.com>
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
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-32170-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[benjamin@sipsolutions.net,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CE016194C03
X-Rspamd-Action: no action

On Tue, 2026-02-24 at 23:17 +0530, Ramasamy Kaliappan wrote:
>=20
>=20
> On 2/23/2026 6:08 PM, Benjamin Berg wrote:
> > [SNIP]
> > =C2=A0=C2=A0	if (!need_offchan) {
> > -		ieee80211_tx_skb_tid(sdata, skb, NULL, 7,
> > link_id);
> > +		ieee80211_tx_skb_tid(sdata, skb,
> > +				=C2=A0=C2=A0=C2=A0=C2=A0 sta ? sta : ERR_PTR(-ENOENT),
> Do we need to pass sta here? I didn't see sta actually being used in=20
> __ieee80211_tx_skb_tid_band().

Uh, it should be.

You are right, in the end I forget to update the call to ieee80211_xmit
to pass sta instead of NULL there.=20

Benjamin

> > [SNIP]

