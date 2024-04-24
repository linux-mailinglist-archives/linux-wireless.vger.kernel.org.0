Return-Path: <linux-wireless+bounces-6759-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DF6D88B0336
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Apr 2024 09:28:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 371B4B26C21
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Apr 2024 07:28:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C51B3157E62;
	Wed, 24 Apr 2024 07:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="kxZupPxP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F542154BF4
	for <linux-wireless@vger.kernel.org>; Wed, 24 Apr 2024 07:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713943708; cv=none; b=V3qO8lFk4rbqNGSrhie0fN7Wh4Nwzfgvf3b+qq0hfO/XuM7l9/2lPgIfkpr/Vlwu474R963GozT+kxW0K9mlIAQ9vUy4Y/I3vbOmY7mYGBzJkuuBUf2Obo041gWMCLAQHy6j09nysgYdRk1WFShPT0hx6Ci6PAip2trMbxAIrVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713943708; c=relaxed/simple;
	bh=XX5ZBXN6Sz9rNOKRXlE1sizd9rwXNODWEDVONeQGMr8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DKrnZB8hL+lSZm0Hh8d2WlW9i3tZrnOF4LOBP1bouLrA8/YF6lUzzZlF88n1vBfpd7p9PbVr6Ouv7p+U3xvHiuIfNvs2dfiforw3bEMxaCs93BX6Vp7j1ogsw1EBUYsYxD1ldVjhbyrX/opLLUl1/Nq+bhp/mXvRM60NJ2hJQhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=kxZupPxP; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=XX5ZBXN6Sz9rNOKRXlE1sizd9rwXNODWEDVONeQGMr8=;
	t=1713943706; x=1715153306; b=kxZupPxPFMOG/p4bDodYHuGxGnaR1fqWmixlt1ZW3reoXlL
	AY+ngJGaGm/n/tpFojf4/2Z5MJ427C2D7176dwJVtaUgMm1KlxNTsZJJgPiqAC8EuIwTdM5pQTEqi
	ZcqndTNtzZ5S1kcbqaFIjU/FZK5oA+feH/NvDpy2Sjs9J8dzRfbk/XK2fORSUORSalD74ZEAw8UfQ
	FzquhNCqiX9DyClQzXdhuSxMrZ5B01XG4Y7TVASA+bZvZQCghiCfnqhKzNbNkuYorW0z2vggdZlJ2
	HpWTHOKConpgu3hQsZzlgrd/qcHGyIXqal9dsbOhpYPKGo5aR3sy9fI692hQerfQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rzX3F-00000003PGm-3UIo;
	Wed, 24 Apr 2024 09:28:22 +0200
Message-ID: <517caf852d37b3803bcf087a6b575f2ecdb5ba10.camel@sipsolutions.net>
Subject: Re: [PATCH v2 3/3] wifi: ath12k: Add lock to protect the hardware
 state
From: Johannes Berg <johannes@sipsolutions.net>
To: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>, 
	ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
Date: Wed, 24 Apr 2024 09:28:20 +0200
In-Reply-To: <20240424065646.1666166-4-quic_periyasa@quicinc.com>
References: <20240424065646.1666166-1-quic_periyasa@quicinc.com>
	 <20240424065646.1666166-4-quic_periyasa@quicinc.com>
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

On Wed, 2024-04-24 at 12:26 +0530, Karthikeyan Periyasamy wrote:
> Currently, hardware state is not protected across the reconfigure
> operations. However, in single wiphy models, multiple radio/links is
> exposed as a MAC hardware (ieee80211_hw) through the driver hardware
> abstraction (ath12k_hw) layer. In such scenario, we need to protect
> hardware state across the multiple radio/link at the driver hardware
> abstraction (ath12k_hw) layer. Therefore, introduce a new mutex in
> the ath12k_hw layer.
>=20

It's your driver, but ... it would seem _simpler_ to do locking across
the hw with a single wiphy model, because everything (except currently
for ath12k_core_reset and ath12k_core_restart) already holds the wiphy
mutex. You can probably move those to wiphy work.

I'd avoid doing lock explosion like we had in mac80211, it's going to
come back and bite you eventually :)

johannes

