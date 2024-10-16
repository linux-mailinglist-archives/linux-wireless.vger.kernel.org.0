Return-Path: <linux-wireless+bounces-14064-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB5CB9A0501
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Oct 2024 11:06:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 935D01F25112
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Oct 2024 09:06:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFE63205149;
	Wed, 16 Oct 2024 09:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="Nj3mVFA3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29F09134A8;
	Wed, 16 Oct 2024 09:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729069596; cv=none; b=igmpgqGfeTvo9IcwQojCzRlJGaZR/8+91qcxBgk3cYHTeK6463DUGX+0LF/URIeiZbsQX1AcY/dCddbtT65K/nZAkHyLQAjVRuYCbFj6J3dhWc7J7d6mkrrNZwn+c2nuEK/JEsF+dEZAvl6xRFHRtNgVEfQI2ySJdSxvDwHx2L0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729069596; c=relaxed/simple;
	bh=EP34Go3o3E+bVfi/rpZAtI5M56XbwKeVq+nRPe/KikU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ok2zWZYO0rIVtt4FC/hGEiXONrFopGxbujLsHxIS3RLsbp57ZYpZ+pKVEvnhw//S4Hf8A9ey3CDXsf1lsw0nEv+Golm+l4ezcEoebWKnZpZg02RUU7J0iViRhFKigj2gKNMriEYWqiiKTybHQI09Nvhi1Ub6fa7apwCa5kBb6nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=Nj3mVFA3; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=EP34Go3o3E+bVfi/rpZAtI5M56XbwKeVq+nRPe/KikU=;
	t=1729069595; x=1730279195; b=Nj3mVFA38TCc5AKuxZhT7CVaP54+1xb/i8XlBtKDRV8kqoQ
	Z14S8c1s9pPYqL9T666QH8IMWbpLt4xeqiGLPd7gCusig+qLGh3E9HdSuisk5qvUt/0pwh8NlfDq5
	IpSp/zoQsOd6UyhzeQHepQ5CdQevfImUEr7gtVFGAC5IZDf60gZ+OwXAXlVlCq2nxXTiH2uErE4Jf
	cXDLJW+1RTUNbWUG7q4JZaJSHyLz9RYcK7X3C59/dexSmycyR4rNfN+ESrutjEv4xC6tzx1SW9qWL
	V63bPFAd6zqiBi2YBu9Bjj2jujHn6Q2wkV7hDJiYVzjhGWfN7pJxaLOuGP2Qt0eg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1t0zzE-0000000Cihs-3Vhq;
	Wed, 16 Oct 2024 11:06:33 +0200
Message-ID: <e4debfb8fff961e889cf333a95132f5ed6687928.camel@sipsolutions.net>
Subject: Re: [PATCH 3/5][next] uapi: wireless: Avoid
 -Wflex-array-member-not-at-end warnings
From: Johannes Berg <johannes@sipsolutions.net>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, Kees Cook <kees@kernel.org>
Date: Wed, 16 Oct 2024 11:06:31 +0200
In-Reply-To: <d9e9d9c1ade33701172b069e7dea728b063b00ee.1729037131.git.gustavoars@kernel.org>
References: <cover.1729037131.git.gustavoars@kernel.org>
	 <d9e9d9c1ade33701172b069e7dea728b063b00ee.1729037131.git.gustavoars@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Tue, 2024-10-15 at 18:31 -0600, Gustavo A. R. Silva wrote:
> -Wflex-array-member-not-at-end was introduced in GCC-14, and we are
> getting ready to enable it, globally.
>=20
> Address the following warnings by changing the type of the middle struct
> members in various composite structs, which are currently causing trouble=
,
> from `struct sockaddr` to `struct sockaddr_legacy`. Note that the latter
> struct doesn't contain a flexible-array member.
>=20
> include/uapi/linux/wireless.h:751:33: warning: structure containing a fle=
xible array member is not at the end of another structure [-Wflex-array-mem=
ber-not-at-end]
> include/uapi/linux/wireless.h:776:25: warning: structure containing a fle=
xible array member is not at the end of another structure [-Wflex-array-mem=
ber-not-at-end]
> include/uapi/linux/wireless.h:833:25: warning: structure containing a fle=
xible array member is not at the end of another structure [-Wflex-array-mem=
ber-not-at-end]
> include/uapi/linux/wireless.h:857:25: warning: structure containing a fle=
xible array member is not at the end of another structure [-Wflex-array-mem=
ber-not-at-end]
> include/uapi/linux/wireless.h:864:25: warning: structure containing a fle=
xible array member is not at the end of another structure [-Wflex-array-mem=
ber-not-at-end]
>=20
> No binary differences are present after these changes.

I don't see how this works if you introduce "struct sockaddr_legacy" in
a non-UAPI header, but then use it in UAPI?!

Also, userspace might have pointers to it or whatnot, and warn/break if
you change the type?

johannes


