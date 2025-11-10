Return-Path: <linux-wireless+bounces-28732-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1538DC45A3A
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Nov 2025 10:29:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD4F83AC23F
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Nov 2025 09:28:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2CF32475CF;
	Mon, 10 Nov 2025 09:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="wz4g0Y0V"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 454AD15A85A;
	Mon, 10 Nov 2025 09:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762766908; cv=none; b=Lr45CPLy0au3DY5iq9y7bPWXGmPOzMxxLmIwZrmm9UAVx9v41ARVABfbNY1SakKWj+M3k8e65BVMXHAZYI0qVG5wghusb9sYHNOm6PfMvU9rg/OXYKlRZ6ozGXYt3kZiylx1TuUg84veScKCFpFmpVU8X0wkprJ46It/FHywOKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762766908; c=relaxed/simple;
	bh=cYaCfAsJLhkAmtsoPU7j9HX96np+0EanIFh/OL3w/G0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AqOpGtqbgf9E96P5uN8fB/m5b7OJ06dF4lHKlCZOh/YRFmEAMu2ES6csaG9r9EqmFWe8AvNTO4hYXn6XjaWhpQ3qLqIpbI0raDsRL6KjKeYsIS6Un6MA5qyf+N1Boz01Q1L/eYQ9rSfuMxj66nlLhVAUpPEdjEKmILIZ5HflakA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=wz4g0Y0V; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=HnIZWmodhvAsnzAotoOpaQVKuvrcDDgdgIGrbYqiDSY=;
	t=1762766907; x=1763976507; b=wz4g0Y0VQB+dUxzLrHvDAAoWICzPFexpEgHyUXkvnwWGu3e
	l1uJqGvI0eLLmEoPxVI9mOZgPK8NzAkRnaZAodcDXFS9G9icemM/lVU69vakdnJnfQjmaZzBujYY5
	DsLdLfiU/8QN/QUeLJMKMHiC1Wm+cdbeLx+eoUzgF3Ml9hE91de9o5lXFYzdNGfS0iCwZqUuXPEmT
	XNrdl35RGHEImSqTx7Dq/8HYg4qego8fmwOUsQNdHbHvNeE6B8dhx+HTnyQq0VyA9RNOfS4/zy21+
	2DZubTPHUeDi6S0/0GZynSQrYbMt4aunQdmSCS4TwTmL1BhcyyKgJf3/1lzMxZ3g==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vIOCG-0000000B9jq-0vLj;
	Mon, 10 Nov 2025 10:28:24 +0100
Message-ID: <f3a9797eb23d9c26007652798f14b76330aa1933.camel@sipsolutions.net>
Subject: Re: [PATCH v2] wifi: cfg80211: Fix uninitialized header access in
 cfg80211_classify8021d
From: Johannes Berg <johannes@sipsolutions.net>
To: Ranganath V N <vnranganath.20@gmail.com>, Dave =?ISO-8859-1?Q?T=E4ht?=
	 <dave.taht@bufferbloat.net>, "John W. Linville" <linville@tuxdriver.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
	skhan@linuxfoundation.org, david.hunter.linux@gmail.com, khalid@kernel.org,
 	syzbot+878ddc3962f792e9af59@syzkaller.appspotmail.com
Date: Mon, 10 Nov 2025 10:28:23 +0100
In-Reply-To: <20251108-fifth-v2-1-405da01c6684@gmail.com> (sfid-20251107_193312_898584_A71B4CAD)
References: <20251108-fifth-v2-1-405da01c6684@gmail.com>
	 (sfid-20251107_193312_898584_A71B4CAD)
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

On Sat, 2025-11-08 at 00:03 +0530, Ranganath V N wrote:
>=20
> +++ b/net/wireless/util.c
> @@ -963,9 +963,13 @@ unsigned int cfg80211_classify8021d(struct sk_buff *=
skb,
> =20
>  	switch (skb->protocol) {
>  	case htons(ETH_P_IP):
> +		if (!pskb_may_pull(skb, sizeof(struct iphdr)))
> +			return 0;
>  		dscp =3D ipv4_get_dsfield(ip_hdr(skb)) & 0xfc;
>  		break;

That doesn't seem correct to me, passing only the IP header length to
pskb_may_pull() call assumes that ip_hdr(skb) =3D=3D sbk->data, which is
almost certainly not true?

MPLS seems to not have this problem.

And maybe there's a similar issue for the VLAN tag?

johannes

