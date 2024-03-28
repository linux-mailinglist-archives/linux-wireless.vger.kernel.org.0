Return-Path: <linux-wireless+bounces-5471-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0890189049D
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Mar 2024 17:09:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 371BE1C28474
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Mar 2024 16:09:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 512E95FB90;
	Thu, 28 Mar 2024 16:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="u8DMk1h5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9743F32C9C;
	Thu, 28 Mar 2024 16:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711642163; cv=none; b=aR9EdEf9uSTzHXF8oX+60MddCBP3BesDEbl2tNxh9vOX9fUK5WaCwiByGnLuKmV/wtuMogQ5dniyKdsyoLhhtkz/CT5T7v5VYwHKkDL102WwhjLCZ4Rl/aCL9/ud+0/hBxd0h9oPlo13OGzYLt+c+OxtSrUG66pJ/6kPO5K5hDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711642163; c=relaxed/simple;
	bh=CMmVIKQoM/PlNFhCTLxNd05/dFR7NQI6JqPlu8BOkgE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=t+damuH4YvQbNXIsV3w+pSwGULXtvfCEMmQcQ6XIKotHlLER1zLmixpr26PJIF2mICf2hsqhl8zw3hKDOmTLGqJ3+7Lv6iE+shlB8+kjbYm9UGz+vA0c3Nh93O+gjSCApZdyTF7e+MXESxO1XMcLtot8WgrdbD+ykWYMW1sBge4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=u8DMk1h5; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=CMmVIKQoM/PlNFhCTLxNd05/dFR7NQI6JqPlu8BOkgE=;
	t=1711642161; x=1712851761; b=u8DMk1h5iQFoCGm05H5oMCjSEgo1e/FjFyOS86/rCxS3GCd
	1s+OHU0Jm+Q9WU3UNNs4cVJClo3OL3YyNcg7JAtVpLL0p2DCkvyrjr82w1DB8G3gLZ+W0QNSCeSMf
	CaqsrHpAtceieEtlDhQk942bicrAEDO/EHScG9FhMYBJZuFZxoBtSjVL3D0ScG4P6/qHhULtDn9i6
	RqCSW9YpiRnQ3f8Kq1mxQI5xr2OTqwstcj5J4x5mHyggLFzzLYs+9oqodEU5KC8TuRDyfBH19N0NG
	cIHZcI/sB1NkInmJQTlqP8thkE9EnOZl9+6yErDKA/VWHrIIa8GJRB+YBxRZlV4Q==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rpsJa-000000017LB-363U;
	Thu, 28 Mar 2024 17:09:18 +0100
Message-ID: <3f61f18fbf3372ff88da54cdfbd309e74b2aa4e9.camel@sipsolutions.net>
Subject: Re: [PATCH 02/13] wifi: nl80211: send underlying multi-hardware
 channel capabilities to user space
From: Johannes Berg <johannes@sipsolutions.net>
To: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>, 
	ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org, Vasanthakumar Thiagarajan
	 <quic_vthiagar@quicinc.com>, netdev@vger.kernel.org, Jakub Kicinski
	 <kuba@kernel.org>
Date: Thu, 28 Mar 2024 17:09:17 +0100
In-Reply-To: <14b739c9-18da-0d58-b58d-cccebc505950@quicinc.com>
References: <20240328072916.1164195-1-quic_periyasa@quicinc.com>
	 <20240328072916.1164195-3-quic_periyasa@quicinc.com>
	 <6d92d0ba4a8764cd91cc20c4bd35613bcc41dfcd.camel@sipsolutions.net>
	 <9d5c2f9f-19b5-af4d-8018-1eb97fac10d6@quicinc.com>
	 <9d0f309da45ae657cd2ce0bc11a93d66e856ef64.camel@sipsolutions.net>
	 <14b739c9-18da-0d58-b58d-cccebc505950@quicinc.com>
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

On Thu, 2024-03-28 at 20:40 +0530, Karthikeyan Periyasamy wrote:
>=20
> Can you point to any attribute constructed in this way from kernelspace=
=20
> for the reference to explore more ?

I don't have anything directly, looking at the code finds e.g.
devlink_dpipe_entry_ctx_append() but honestly that's really quite
trivial, it just adds that new attribute while iterating whatever list
you have.

johannes

