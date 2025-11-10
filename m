Return-Path: <linux-wireless+bounces-28721-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0976CC453E7
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Nov 2025 08:44:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA81F3A9C2D
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Nov 2025 07:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAC7D2EBBB7;
	Mon, 10 Nov 2025 07:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="yCUz1Tjx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4770F2EBBB2
	for <linux-wireless@vger.kernel.org>; Mon, 10 Nov 2025 07:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762760642; cv=none; b=VpXhiH7Ti5AkYh9zLhGoOkmYOPwzYCRhbdhQqV4joss18ID1YjkgJ9ojQIShm2FbpeGCXwX/Kk24cse447Xpp66Tu3sLIxu0xdG68QQM/XQcg+4S0uhoSgjq0eKSEd6jNC0aHiXe3y1dPcKocRr2QSEON74vK/e0159MN3ZWHAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762760642; c=relaxed/simple;
	bh=4T5cJsyaau6iJSk2BfglEfFO4Gtb6QbZayNFI1Xesk4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dxLBvx+SNxfiWxMMKyq+t5PCGweifeG0b3AIRgIEqw/m+1IPEp8V/QMzqffdqhmf9DAzmeTml0WQJ37986KXNidNCmwjoih3/KZXMWYNnweFeec65y+mmlZTw2tj9+4MWYkPAkA2AoMYgmgeLjt+i6PVDc5VDbEN4LjMkX97TMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=yCUz1Tjx; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=4T5cJsyaau6iJSk2BfglEfFO4Gtb6QbZayNFI1Xesk4=;
	t=1762760641; x=1763970241; b=yCUz1TjxAy/A3cv7hbF1+frCVSvEGp2OAEF06D77tRl37cA
	tBsAYia3owunN0hsp6UAm2LOnzVBFzZ4uUYw3levEHtVyMn2dLlvpqsCd+GTyQJrFDLkYJHq1UX/3
	V+M0iduybxBuBYMfc4ZV8PuPIOGtyirdExzxd98qBIDth3lkn5mrQp1TqLw0eR1uOOwaLjBimVcte
	qiCBRDF/QKWgG5EJP7jQtKI0LdnioxC8Xz/qTgRLXWB7FI/jxIFlKjEHzmLj4pqi2LPlJaROJLvzr
	Pdz4r4r8wMh6pFk10LhEhc3zVwNYqc89ftEryPHPbhsfPIpteltsLpVaslj4MsPQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vIMZC-0000000As9O-36Oi;
	Mon, 10 Nov 2025 08:43:58 +0100
Message-ID: <f67d8a5ffd57acecda1f2d3bcf53c35135415ef0.camel@sipsolutions.net>
Subject: Re: [PATCH 6/6] wifi: mac80211: refactor CMAC packet handlers
From: Johannes Berg <johannes@sipsolutions.net>
To: Chien Wong <m@xv97.com>
Cc: linux-wireless@vger.kernel.org
Date: Mon, 10 Nov 2025 08:43:58 +0100
In-Reply-To: <20251109140450.118106-7-m@xv97.com>
References: <20251109140450.118106-1-m@xv97.com>
	 <20251109140450.118106-7-m@xv97.com>
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

On Sun, 2025-11-09 at 22:04 +0800, Chien Wong wrote:
> Merge CMAC-128 and CMAC-256 handlers since they are almost the same.
> This removes duplication.
> All references to the refactored functions in the tree are adapted.
>=20
> The comment 'MIC =3D AES-128-CMAC(IGTK, AAD ...' is out-dated since CMAC
> is also used with BIGTK, as is the comment for CMAC-256. Simply remove
> the comments.
>=20
> Tested-on: mac80211_hwsim


Oh, I see this now - but your changes affect both RX and TX so you
should cross-check against another implementation (such as wlantest) I'd
think. Also, that's a non-standard Qualcomm/ath driver thing :)

johannes

