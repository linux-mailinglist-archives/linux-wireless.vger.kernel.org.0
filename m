Return-Path: <linux-wireless+bounces-21920-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 747F8A98D70
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Apr 2025 16:44:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4CD416C128
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Apr 2025 14:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D9B4149E17;
	Wed, 23 Apr 2025 14:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="PgowDYg/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ADB97081C
	for <linux-wireless@vger.kernel.org>; Wed, 23 Apr 2025 14:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745419440; cv=none; b=WbTWQt7dsVOFErLM/xla2CAgPAvs3IXBcdrUy86xe2M5Y6Anoqs4AelAe8w3Qk4hykzfieJQ0UhEr+Q/PsLl1TNBRmAL9OFz28Z4SMT0VNCpj0ejhTG8Qavyt+iduvi9YZT5WG3vyaEvmkkR2khu2b9Yz6tZX6h8emKT8ZfzUFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745419440; c=relaxed/simple;
	bh=jm6iS41bwi0ruPwhs/XoD3xcqj9q+M+WsyP20tEUfmU=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=es+pqYWSM2YHexFhe+O9XEsBCh+nlINIU8sbP/RXNVkE8hwtleJRT9n3BAzza0FIn5VTuMdQMuMAYv7Iv7YYIo7sWOIhltLWN77mw1Feg02+TSwVWHlBiLRlmXkEydhBmkOv8rdVEkvCv8BQReMtB+f2v6RXI1zrVEPd3GrsAiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=PgowDYg/; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=jm6iS41bwi0ruPwhs/XoD3xcqj9q+M+WsyP20tEUfmU=;
	t=1745419439; x=1746629039; b=PgowDYg/e04bbAB0XqvUTF0Qh8aHCgbTHXCc7B135aC49wF
	2X/8p1cC5CzLe/XDkUoVgYOj7NsOlCDxZSQFkopqXWUdFd3uvzLdI2ODAi9YMQay2T14WTIfU08Cg
	Gyljt5F3zr3Udavk1ZqZvE9DwPL36okaDRNh4rqqYdhqs4hRL0eDqnt9gV43ZqQQ11NwAQ+ITEqyZ
	8/yDMs+yv8/UZ7JGb3rg5p8znsDVhWtgWTAIPYZKm9HyGESDRopKnROXrPiTkeE9OHGmWDI8B0GVN
	wHm4Ne+gB3q6PEVnI+KuJblB0KOENyOUhJ9r4i7Y4ZGYS79/jpecboJPI3Pg3e6w==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.1)
	(envelope-from <johannes@sipsolutions.net>)
	id 1u7bKO-0000000Ekuz-3Kc3;
	Wed, 23 Apr 2025 16:43:57 +0200
Message-ID: <0c995a29d73a99084add34ef2b56b0fe673578c4.camel@sipsolutions.net>
Subject: Re: [PATCH iw] iw: print HE mcs correctly when mcs_len
From: Johannes Berg <johannes@sipsolutions.net>
To: Janusz Dziedzic <janusz.dziedzic@gmail.com>, 
	linux-wireless@vger.kernel.org
Date: Wed, 23 Apr 2025 16:43:55 +0200
In-Reply-To: <20250413160455.158335-1-janusz.dziedzic@gmail.com>
References: <20250413160455.158335-1-janusz.dziedzic@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Sun, 2025-04-13 at 18:03 +0200, Janusz Dziedzic wrote:
> Print HE mcs correctly when lower layer
> report correct/real mcs length.
>=20

I applied some other HE related patches and this didn't apply any more.
Please check/rebase.

johannes

