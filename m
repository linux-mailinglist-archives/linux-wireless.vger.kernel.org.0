Return-Path: <linux-wireless+bounces-24127-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6235ADAB37
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Jun 2025 10:56:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB344188A91E
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Jun 2025 08:56:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 341E9238C25;
	Mon, 16 Jun 2025 08:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="PJJ0KhMc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 716CD2CA6
	for <linux-wireless@vger.kernel.org>; Mon, 16 Jun 2025 08:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750064143; cv=none; b=ZVv7h8x6C16EuBI1XK8bOuhPKogfIDeAIv8h9gB0LhiS405NbUkbjgSJ8Fxx0nFCLPeDsnkWKr6zpejEDY29v1uE/KdN+BPYD7/MfzdO4sqChvNB8p74Y2Q6l7D8rof4mBJj8jFBDHegru2bOsrYZaF+py5fZmtbxrZoJ2QxOmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750064143; c=relaxed/simple;
	bh=JWZrSlYHDkFAJCg8PmG33o9HsHzGP5MCt7w7d3F9CZY=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FWWVl9b0hg+DX2iEl0UC6R9N048WmvouFLK4qJVkscnk4UDNkIkOqVnXiBda0RyKIfgiKrSPF+oUznXoGk/xu25+nJHqpp97WyD3jRh4qaArRl0+0M+uIEQzQEHv6sdQvSODZsPt0JPfjU6xmqGndpIRVVGPyHRLNXLnIWGMTNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=PJJ0KhMc; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=JWZrSlYHDkFAJCg8PmG33o9HsHzGP5MCt7w7d3F9CZY=;
	t=1750064141; x=1751273741; b=PJJ0KhMcmRzooJEOrd0Vgaovaz4gONoxnvMj6vxB1npEnef
	seq6ws8ffcCeVMd0dVm20P/t6JonpS8PI6bT6XQNJIzbWVW9WDYdu1WpMEm1xU7uAU3lE1KQBWpjD
	AFX8pC7z58mUbt09njLsU4KzTvFCNRkFPYRi6qvrCnhNnj5Hjo9msaC/h/r+g6A20o3LV3x8HfvPP
	TBUfLf5XNKDJ3juE++G88ofyjYGMbXqESkhWhrOg6Mgsd1VbkDByD6vFxu77u+SdoKatDYK9Dv/9a
	PXAJ4Vew7fuZuEzqnoiR/hpqPXP7pawljIfXVS6iL4geeFlOtdwa4OOV0taNMxkQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uR5cp-0000000Byso-3xEU;
	Mon, 16 Jun 2025 10:55:32 +0200
Message-ID: <138684ee550d027a96d7b9d515b84921637eae57.camel@sipsolutions.net>
Subject: Re: [BUG] wifi: iwlwifi driver does not detect the card in Linux
 6.16
From: Johannes Berg <johannes@sipsolutions.net>
To: Ryan Chung <seokwoo.chung130@gmail.com>, 
	linux-kernel-mentees@lists.linuxfoundation.org,
 linux-wireless@vger.kernel.org
Date: Mon, 16 Jun 2025 10:55:31 +0200
In-Reply-To: <CAB1jyqw5RzeC4bT0oXEZ4fC2hcLj65sokW8gt=bp6=1d511D_g@mail.gmail.com>
References: 
	<CAB1jyqw5RzeC4bT0oXEZ4fC2hcLj65sokW8gt=bp6=1d511D_g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Mon, 2025-06-16 at 16:26 +0900, Ryan Chung wrote:
> I also checked the bottom configs and they seemed to be set correctly.
> CONFIG_IWLWIFI=3Dm
> CONFIG_IWLMVM=3Dm
>=20
> Below are some additional information:
> - Network controller [0280]: Intel Corporation Device [8086:a840] (rev 10=
)
> - I was able to find my card (A840/00E4) in drv.c

There's a bug with the recognition of these devices, please set
CONFIG_IWLMLD as a workaround for now.

We'll also have a patch to fix this, but looks like it's not on the way
yet.

johannes

