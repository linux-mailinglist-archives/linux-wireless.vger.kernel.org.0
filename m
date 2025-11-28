Return-Path: <linux-wireless+bounces-29422-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DC3E6C931EC
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Nov 2025 21:32:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CE1954E15F7
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Nov 2025 20:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0E35262D0B;
	Fri, 28 Nov 2025 20:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="R8gm8u6z"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46F0425487C
	for <linux-wireless@vger.kernel.org>; Fri, 28 Nov 2025 20:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764361961; cv=none; b=fdc1WOb2hUQT2+XOojPMsWXfKY4lcwylY7jsm9kOEaXmVpUGLSQTZWnAikp7oc+zsNokMx0jf0N+iBhQl5lGJXPdYN85pz1cULtp2GMnCWC/5HxCC8Fq3ls4E/WbwBuEvFzabk8qJ+wSZ4wwgY8WQjXx1BaaVVvd5MncX+IH2gQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764361961; c=relaxed/simple;
	bh=+J4VM97TyzrCwMi6hmrjBHGsZQWH9Y1SEbS9rnXR8jQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tRC/9lRukq4pVZr2wMhDHs639Kr1JwQU5sQ+4/gTfoMYUmYLlZNI8urRPRlplyX5ChgbdEdyUF8dofCptzkr51UPbWUVU4Ug+XHmst0Y8NSoKOtbpPr8AX3buCxNDHfnp3f1Wsg+5xepQn9Bw+uwRMU0tPDhcyLTctxux5LrF/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=R8gm8u6z; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=Ibc9x76HtBixj27I1N9W2k0RdZjW4T5fPIHdnP1sc90=;
	t=1764361960; x=1765571560; b=R8gm8u6zhJWTNTxCURiYDlFfSTIIufPZWYantqXUtGcnVPP
	2H0LH6BWtgs9dUXfHgf5z1NnVlCCdZz+hAIqF0Eq7Ti19DKbdJPdDCjrkhCR33HpDsW0A34BSyQCR
	OzjIcIRXd6l3Vx9pO96cUJAL5/+KTv4bgkSF/6Jmg+mCWv9Joy1qR511QGu5Xn3imFWtmV2uCtEqe
	Idu8zy65uujqZaNQxMxqQbHIR48Ic4PTaYPMwrRIfvKkfw97fCFfAWAKB9bu9cHdAdhRpjAubLPzU
	2RDZABDUG9OnBCjhHh6KUCRekEOxdbayfsOJewgqqD/uMdfVqjLXJPJan8MtrYoQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vP58p-00000003prq-3NBF;
	Fri, 28 Nov 2025 21:32:32 +0100
Message-ID: <bd8cebbe9a75c0d90d7a03f49cfdefbf74a949e1.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next 08/18] wifi: mac80211_hwsim: register
 beacon timer by calculating TBTT
From: Johannes Berg <johannes@sipsolutions.net>
To: Benjamin Berg <benjamin@sipsolutions.net>, linux-wireless@vger.kernel.org
Cc: Benjamin Berg <benjamin.berg@intel.com>
Date: Fri, 28 Nov 2025 21:32:31 +0100
In-Reply-To: <20251128151537.7dc54aea48a1.Iccf6164f3feeb5350fcfe0df666248c686b226ae@changeid>
References: <20251128141537.287627-20-benjamin@sipsolutions.net>
	 <20251128151537.7dc54aea48a1.Iccf6164f3feeb5350fcfe0df666248c686b226ae@changeid>
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

On Fri, 2025-11-28 at 15:15 +0100, Benjamin Berg wrote:
>=20
> +	/* Round TBTT down to the correct time */
> +	tbtt =3D tbtt - tbtt % link_data->beacon_int;

I guess this is causing

ERROR: modpost: "__umoddi3" [drivers/net/wireless/virtual/mac80211_hwsim.ko=
] undefined!

johannes

