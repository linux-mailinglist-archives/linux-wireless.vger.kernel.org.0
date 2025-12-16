Return-Path: <linux-wireless+bounces-29794-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0211DCC1CCB
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Dec 2025 10:32:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C426D303E032
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Dec 2025 09:28:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEEE41A08AF;
	Tue, 16 Dec 2025 09:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="g/hafZod"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FBD8207A38;
	Tue, 16 Dec 2025 09:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765877321; cv=none; b=CU1yfm6tbyFejK25+30NFTUPuDmjZNuV/q52ac5Hh+gPgk3OS5Dn7iP5OMsEKvJfv7wfq5aRJ1sRkXyECfRWJQDFxCxhoC0QkKusAO9rQCNw7YKHJcUscUIuOj330pt5gXKtwx1Vs177vetNrfXM3D+CUTPz4n2G/ikq1O3xQmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765877321; c=relaxed/simple;
	bh=1LuOpQEN25sxsMS0zJBQsfa0xGGW4EGRIf+/FQSLj8Q=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NZMPNOr6nOuRVa4X2ZB96dOA/IOIrFmcGETPEh/SzvLyuRhAwH8ewO6QcYbuwLgrpVHE2zrXLq1gO27BbQ9dt1mUcgkMj9ZJFT9o316aNtjM3Qf8GoaC13TN0Sp9qIyf5L6nXK+CWgTT62nGIzggLvh83jhDOXylK6KU8D9WPKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=g/hafZod; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=866IzXU9pRNgcPp61o3S7I4p3rHWFGMSgmCQlhu7ZNM=;
	t=1765877320; x=1767086920; b=g/hafZodTFLHHXjtIghlvhwveVTM7JTFmiSv6oSUPQBDGDt
	YU7SGtWMvbst4xaeZlHHCRDVJ7XN0AiLmZrD5qaPPBhmI+Y5KsU6eKKZYOecRonMJihS9FI88nPjW
	ztO6pzbTGplGxN/A6vzWNQ5CsnfOwQ86f2GwxiUwapGdl3KekaI1Q+EuLnxCXIFeiCYI/IOFfo5cW
	hHoj5q9a3I9GutrUaooorDlJY7GL9b1EdLBadfFNrF+52Kc/I62rL76EEq9ktV2FNVvEaJdO78IYk
	vG4pFmm6q771HDjKsDZsHwV7LjOy11rYtJhIL89eYpChTWcys5mM/Pwngj+8jJJA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vVRMD-0000000AFR8-02Bn;
	Tue, 16 Dec 2025 10:28:37 +0100
Message-ID: <7723c9b1b370f9f23f70285560dad9362e9ab37a.camel@sipsolutions.net>
Subject: Re: [PATCH v4] wifi: cfg80211: Fix uninitialized header access in
 cfg80211_classify8021d
From: Johannes Berg <johannes@sipsolutions.net>
To: Ranganath V N <vnranganath.20@gmail.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
	skhan@linuxfoundation.org, david.hunter.linux@gmail.com, khalid@kernel.org,
 	syzbot+878ddc3962f792e9af59@syzkaller.appspotmail.com
Date: Tue, 16 Dec 2025 10:28:36 +0100
In-Reply-To: <20251203175418.6623-1-vnranganath.20@gmail.com> (sfid-20251203_185432_410465_2AE88914)
References: <20251203175418.6623-1-vnranganath.20@gmail.com>
	 (sfid-20251203_185432_410465_2AE88914)
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

On Wed, 2025-12-03 at 23:24 +0530, Ranganath V N wrote:
>=20
> +++ b/net/wireless/util.c
> @@ -962,12 +962,28 @@ unsigned int cfg80211_classify8021d(struct sk_buff =
*skb,
>  	}
> =20
>  	switch (skb->protocol) {
> -	case htons(ETH_P_IP):
> -		dscp =3D ipv4_get_dsfield(ip_hdr(skb)) & 0xfc;
> +	case htons(ETH_P_IP): {
> +		struct iphdr iph, *ip;
> +
> +		ip =3D skb_header_pointer(skb, sizeof(struct ethhdr),
> +					sizeof(*ip), &iph);

The sizeof(struct ethhdr) is probably a *correct* assumption, but
wouldn't skb->network_header make more sense?

Please try to understand the code in question before reposting this
patch *again*, I'm not interested in coding by remote-control.

johannes

