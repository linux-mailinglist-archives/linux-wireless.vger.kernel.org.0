Return-Path: <linux-wireless+bounces-8267-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A78E8D39FE
	for <lists+linux-wireless@lfdr.de>; Wed, 29 May 2024 16:55:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15AAD28AC80
	for <lists+linux-wireless@lfdr.de>; Wed, 29 May 2024 14:55:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1162015ADAA;
	Wed, 29 May 2024 14:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="hY4Edtuy"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E350D27E;
	Wed, 29 May 2024 14:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716994505; cv=none; b=kXQWHXVGNjk0KJYF13rsCaItsXLypSNUcGaqQlu+oSxcJD6m9+TmSoWz+NOyrTdRuWAomVC/SJnCEaMFPLQylEiHOxhHMvOCgBjNoVcKrvNSetFyM1ucSJH2ujvCvxvZwMDBeazpfA9BkX25UpwuWDqqlXONgHYFOdfBluLWMCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716994505; c=relaxed/simple;
	bh=LKlh9hVOnB/K2o7RLmzS0uBIBkUJWNr7avAUzdtD2pY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NtxAR5OtaI02VZfS2X3D6pPcL87InXfOImgJk5kScgAbs/SWACGM0BOF74JFci/i7L4UhHO6T8ukDIADxzIrowAVVJAdE4k37WefK/pdVcRcK2B/9vFo+Un+yRygBv4adn/P6jnsFIfrvd30KndsvNe19Qzd1OiaEJjA2YRnEw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=hY4Edtuy; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=LKlh9hVOnB/K2o7RLmzS0uBIBkUJWNr7avAUzdtD2pY=;
	t=1716994503; x=1718204103; b=hY4EdtuyiN/2SnkNKjYKgRnvz7ND5tMCviUZdFx5oTeaWIw
	pdt6xQFveEUXPuGx6IgekDy1h3Waa/LxwsGj4kZwvv3DaGQI5UxuVUYiqbtvdo+b6364qkFQotCVn
	eGQyi6k44TkYSNuFfxvh5igLnGXw5KxQkPgzAbFI2stOTnyl3CoboTezTiesQ/CpTFLnCK7xU/OSv
	RTWUQBYgX9zt1HurbKmz3lqR/y8thxjQdIujnYB5ZndfJC5/KMNtN7J+P2YAzx7TDqtqjTdMQj+UK
	4E8Kx1J5qPUeU88mxoGgMFhHJne/iqkbyGwizjoPY16DYgSc5wuIDg4/a29/rW+g==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sCKhZ-0000000H44c-3tbZ;
	Wed, 29 May 2024 16:54:54 +0200
Message-ID: <d1fea590e53cb1b00dc64f4f8a4c8aec84610401.camel@sipsolutions.net>
Subject: Re: [PATCH v2] wifi: mac80211: Avoid address calculations via out
 of bounds array indexing
From: Johannes Berg <johannes@sipsolutions.net>
To: Kenton Groombridge <concord@gentoo.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com,  linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
  linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, Kees Cook
 <keescook@chromium.org>
Date: Wed, 29 May 2024 16:54:51 +0200
In-Reply-To: <20240517145420.8891-1-concord@gentoo.org>
References: <20240517145420.8891-1-concord@gentoo.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Fri, 2024-05-17 at 10:54 -0400, Kenton Groombridge wrote:
> req->n_channels must be set before req->channels[] can be used.
>=20

I don't know why, but this patch breaks a number of hwsim test cases.

https://w1.fi/cgit/hostap/tree/tests/hwsim/

johannes

