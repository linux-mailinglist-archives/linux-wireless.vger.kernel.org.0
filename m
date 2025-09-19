Return-Path: <linux-wireless+bounces-27518-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28420B89476
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Sep 2025 13:31:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F0FF167C5C
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Sep 2025 11:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E74A886347;
	Fri, 19 Sep 2025 11:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="nXo3a1Jl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E6DE2E3AE6
	for <linux-wireless@vger.kernel.org>; Fri, 19 Sep 2025 11:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758281488; cv=none; b=DYkZeVX5ceghAOIpK29RN+xoPwe/oW8+AgEhBTxbrJ2NzO5HMO5F5ib45OkXcQ6QIEDV18wJTr6QY2UAiNXfzPylTwkutNXrLb2XMwUImV1uVf7BYDwQY90nOJhOfWIlYmxoV3Va34wogdv7t1RogiKWt5wKnpBri6ZxxvWSwsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758281488; c=relaxed/simple;
	bh=e6447XKg+CjrsQRAzgZ/FO8xN4N/+6Z64fVuk5F+W70=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hJ1PUwhh3iuObBAv3GkSsIhBQ/nvgRI5Xp78AIbEwFjGiAmEAKvKfA86qJjBrSd9DNf+7DnFa+jldDku3w4JOCsT4otYDi+4DHlxvdeRmbjS5inpqbnrCI12ulmzZWT3Yikp8erhuE6A3XjRIjziDe9wm0WcePInnB3L5j8xWtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=nXo3a1Jl; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=MoFLP1PKMxAw7ddjlr/vCsDsF4FPCYNrDr7daqMl7Ho=;
	t=1758281487; x=1759491087; b=nXo3a1JlhQFmB0Y6531Rm7Tnx/fToN62ag+86BXeKBGMR3/
	jhPZqi5G22Me0Q47q5EiO61ioOE92X+lw2eUXA8mPPes2JqbmJDSbrEeJ7I84B/glW6aI5A691o79
	T22rCFwbEv+WQkHwhhot45LdCSlhKJPLNlIaDI9IvltCoWPPEJEaociXWnYPDIwqem8UJtiW8oT1Z
	Xa++bBcrxmcknlPW7qBiWAHTeGP2ZfPvPBwmTWBrmm0hNaj6LysoNAj++VhIzTXdfr8d0ZDRtMcv3
	gha8IMZrzOkBeL4Hlr+5UNyeBTk0OAm4CFT6QZGFwtNPcL4qESiAIpovxAmR4XLA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uzZKm-0000000FmW4-1Vz6;
	Fri, 19 Sep 2025 13:31:24 +0200
Message-ID: <7228247840ad007b9fdf2383ef93f60864bb0179.camel@sipsolutions.net>
Subject: Re: [RFC v3 wireless-next 1/2] wifi: cfg80211: allow send/recv
 tagged EAPOLs
From: Johannes Berg <johannes@sipsolutions.net>
To: Janusz Dziedzic <janusz.dziedzic@gmail.com>, 
	linux-wireless@vger.kernel.org
Cc: j@w1.fi
Date: Fri, 19 Sep 2025 13:31:23 +0200
In-Reply-To: <20250913202801.448853-1-janusz.dziedzic@gmail.com> (sfid-20250913_222816_964990_F45E95D2)
References: <20250913202801.448853-1-janusz.dziedzic@gmail.com>
	 (sfid-20250913_222816_964990_F45E95D2)
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

On Sat, 2025-09-13 at 22:28 +0200, Janusz Dziedzic wrote:
>=20
> + * @control_port_vlan_id: if set (nonzero) userspace expect to receive a=
lso
> + *	8021Q tagged control port protocol frames. Verification of VLAN id
> + *	should be done in lower layer. Also 8021Q header should be stripped.
> + *	For tx path userspace expect lower layer will add proper 8021Q header
> + *	and setup VLAN id.

No harm adding the '.' in '802.1Q' in documentation? :)

> @@ -5091,7 +5097,7 @@ struct cfg80211_ops {
>  				   const u8 *buf, size_t len,
>  				   const u8 *dest, const __be16 proto,
>  				   const bool noencrypt, int link_id,
> -				   u64 *cookie);
> +				   u64 *cookie, u16 vlan_id);

Maybe the documentation for that call should be updated to say 0 (rather
than another invalid value) means no encapsulation?

johannes

