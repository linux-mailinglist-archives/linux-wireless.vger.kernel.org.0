Return-Path: <linux-wireless+bounces-14329-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 461E59AB0B8
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Oct 2024 16:23:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0519428385F
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Oct 2024 14:22:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DBFF19F424;
	Tue, 22 Oct 2024 14:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="oBfNXSsW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAE3A19DFB5
	for <linux-wireless@vger.kernel.org>; Tue, 22 Oct 2024 14:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729606978; cv=none; b=qKavApV52R63EFCZePbnC67knog6BB/20+H7l5e/Pe0msRohVgOubdWzt1hCbULqjikCjtIltJ/rQ0KTQgTH1isG9rbFpVI14/iNvAmaIZW/qp/6UJ/NDCFNdIsSV+bpDDrdRWruStmPaVuCi/RJkaFGHRFQxnrIXjC+96wscPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729606978; c=relaxed/simple;
	bh=C7dB+44glUjthplD54g454wMmfyotwR9WqglEpzszAk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=u9VdS/FD1y912ehPKKnc6hZEqPynNbCqQpxJ9IDi8806xuj+MF8/KDFeSnfRgK3vPJMS7TI64auMYoeq4t+ImpUTrxOG0gwsn2eYHtz516qyqW1TBIwjGe6fp1VUf2MGTQvBXzMjjXTmxHuxz8sLY3jc8P13NTSHHrLy1tFJ7vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=oBfNXSsW; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=C7dB+44glUjthplD54g454wMmfyotwR9WqglEpzszAk=;
	t=1729606976; x=1730816576; b=oBfNXSsWLoZ0yh2osQqZ7jzZONmf86+kI34BDzcPYjX8aFj
	sNHWayzenXutgKQdepbk8EQfcU63UuaClPBIHi+cmL+o0RQAlCQY3MUioM27d+pdBe5Z1m+IixpqD
	KK5SlwVs4Ry/DSw5SEFTWJSO/SVAL4GFKZD+aBtQJXhG6U9jL7FOwmYvYwETRlHQ7u1vLTsLm+2xh
	6k6OB31TkIQ3J0oTB1LXswddHXddLj9X0Inf1hmeZbVV0WgSrg/nWCeE0TybMAjOw6O7/y+jU/8J1
	uLA2E8BN0MaYPVnTuFE3l6ZtyMaKu5VIjCZcb3K+kD1Rkv73yxVW+r0aRZEhJ1zA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1t3Fmf-00000001lyY-1c6C;
	Tue, 22 Oct 2024 16:22:53 +0200
Message-ID: <9d70965797bb3309dd7405f1ab1f789db135ddb7.camel@sipsolutions.net>
Subject: Re: [PATCH 1/2] wifi: nl80211: add link id of transmitted profile
 for MLO MBSSID
From: Johannes Berg <johannes@sipsolutions.net>
To: Muna Sinada <quic_msinada@quicinc.com>
Cc: linux-wireless@vger.kernel.org, Rameshkumar Sundaram
	 <quic_ramess@quicinc.com>, Aloka Dixit <quic_alokad@quicinc.com>
Date: Tue, 22 Oct 2024 16:22:52 +0200
In-Reply-To: <559c2b6e-23d8-41d5-ba4d-262ab996dad6@quicinc.com>
References: <20240910204538.4077640-1-quic_msinada@quicinc.com>
	 <20240910204538.4077640-2-quic_msinada@quicinc.com>
	 <5673aab17fa4e6bbba5b286f29b0558726305155.camel@sipsolutions.net>
	 <559c2b6e-23d8-41d5-ba4d-262ab996dad6@quicinc.com>
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

On Wed, 2024-10-16 at 12:50 -0700, Muna Sinada wrote:
> >=20
> > Why not use config->tx_wdev and avoid changes around tx_netdev?
>=20
> tx_netdev instance is being utilized on exisiting code to perform checks =
and grab its ieee80211_ptr. W are not making changes to tx_netdev itself. I=
n this specific patch we are making changes to config->tx_wdev. I was wonde=
ring if I could get clarification on this.=20

I might've misinterpreted the code, but also you're pulling out the
tx_netdev variable and really don't need to, just like the end of
nl80211_start_ap() you can release it via the config->tx_wdev pointer?

johannes

