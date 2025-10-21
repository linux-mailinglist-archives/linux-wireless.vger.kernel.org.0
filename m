Return-Path: <linux-wireless+bounces-28131-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 794E6BF5388
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Oct 2025 10:27:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3927F3AAA91
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Oct 2025 08:27:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41A00303A2D;
	Tue, 21 Oct 2025 08:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="APiTwHVU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9164C303A0B;
	Tue, 21 Oct 2025 08:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761035250; cv=none; b=pVLKpbH4aZEDbzIHxiNyGGgk8DFk6f5j/9Uq+28Xpxx6qNxa+yk2nCNI9f+hM59oVbdYJqJNVv8YCT7zcETfvU/z4WYpzWcQ73Ai4VL1EMeTMvIXYgQS2Hq+eAc+IyVipr8NsadXzIYBwRgrtWT/RMdO07d4zPVXOxbQJpEd7C4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761035250; c=relaxed/simple;
	bh=QHC3WozEhc//frG3tRZ9YA6Jk2AfmypdfZ6r0DzLzVE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UTE57ec4m9LOSn0tHTvwKnywH38s2jbhEPuTFoZ3+m+8vtbZe+EPpFgvTpyhMwKRBqWCVtYKZX3/Y+cZJKFyejWfKdvgbc0Q0PgEcM3wbcXMkPcUvCnOYq31aLX0HSQnuwYmc7SWCWyyZAmfdTHP/tn+GfTbflx2hGDCvGgNx18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=APiTwHVU; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=QHC3WozEhc//frG3tRZ9YA6Jk2AfmypdfZ6r0DzLzVE=;
	t=1761035248; x=1762244848; b=APiTwHVUKZdeSpx/aRORxjGp3COth2wKqKmGznTL3sCZ+uU
	2Nba2I1stnhvS8WzaojAD/22Z1WUAWnveZuYecUKsz5KctrULNbpUk2kUBJJj9ej7A/pEsvrXM4YY
	h2QiG9F8Twx6k0SBjY1mQ24WUdnZCaAFN5GY7x20MvnXvUTTxJq7L2Q00L8jpPaE94bEfFNQOFNM8
	yCcWsZ+IX4AGvufGRMZGFtSliBfGXr/kQtEIae0mYhnwBG0KUGIza6MrnVbYuWdrbpjEyKolKpnmQ
	pOEai4AHig9Oe+MxFmtSDulqYXxuH59/tSeJeRN6QpyRHcnlLP/DG4tIo5X2LM1g==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vB7i8-0000000BIMk-2RVk;
	Tue, 21 Oct 2025 10:27:19 +0200
Message-ID: <a99d7c92bcf40614d66228d8de89017ce2b6a580.camel@sipsolutions.net>
Subject: Re: [PATCH v1 6.14] wireless: aic8800: add support for AIC8800 WiFi
 chipset
From: Johannes Berg <johannes@sipsolutions.net>
To: Krzysztof Kozlowski <krzk@kernel.org>, "he.zhenang"
 <he.zhenang@bedmex.com>
Cc: linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Date: Tue, 21 Oct 2025 10:27:15 +0200
In-Reply-To: <01030786-764c-4215-a4ca-dcd841e6ed3e@kernel.org>
References: <20251020092144.25259-1-he.zhenang@bedmex.com>
	 <01030786-764c-4215-a4ca-dcd841e6ed3e@kernel.org>
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

On Tue, 2025-10-21 at 09:03 +0200, Krzysztof Kozlowski wrote:
> On 20/10/2025 11:21, he.zhenang wrote:
> > Add driver support for the AIC8800 WiFi chipset family.
> >=20
> > Driver features:
> > - Supports 802.11ax (Wi-Fi 6) and backward compatible modes
> > - PCIe/USB/SDIO interface support
> > - Hardware encryption offload (WPA3 support)
> > - Enhanced power management for mobile devices
> > - Integrated Bluetooth coexistence (if applicable)
> >=20
> v6.14? That's ancient. Work on mainline, please.
>=20
> Also, this is absolutely unmanageable huge patch. Please read submitting
> patches document.

Well, it's got 25k lines that are an embedded firmware blob, etc. Not
even sure _staging_ would take that kind of thing as is.

The details you gave for submitting patches are obviously not wrong, but
in a way also miss the point entirely, this driver needs to be
redesigned from scratch before going anywhere near upstream.

johannes

