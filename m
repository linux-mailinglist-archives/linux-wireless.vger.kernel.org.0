Return-Path: <linux-wireless+bounces-27098-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE1E4B49216
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Sep 2025 16:52:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AE9D3AB93E
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Sep 2025 14:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22AAC2EFD86;
	Mon,  8 Sep 2025 14:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="E/CNag0H"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 855FBF4F1
	for <linux-wireless@vger.kernel.org>; Mon,  8 Sep 2025 14:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757343129; cv=none; b=UnoFFy6Y3lRMW2LAuvFdqkC+IEnfVIV0ygKFbv+e0zotLPzGxSw8Ax/atcpmfk2eJ+CDWBVCIiAFLw/RiRr+/MCaOFqb114PDu+qFhS79T6gaakRF6N8vKXXIMq9UhpFT2aU/KEJclgSvagwarXTVQ8usnCTuK4k2dHxEhAiRI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757343129; c=relaxed/simple;
	bh=ydfXV7lSWNE+uEQHTlIdPGO61opkTimWY74x8UtNIos=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=D36a8X0UsGpgtBlWT4xQ8KTopqdOnEx0eg2SS/8j8O3kEM+SSr63V1lI3T008JAem3lJirhrZyd/yC0y83g4f7NKighXM3QmkfrqnAZ+j9+hlrwuT2ulF4L9biiB6yy9RpKXYMdV4hyg4S50LAG0YQ+p9MEgg26dMn5vF09/Z4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=E/CNag0H; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=I0G8AiY0UPXvKowwSLSS7qMnyWQVPJh6DsaKle6M4rU=;
	t=1757343127; x=1758552727; b=E/CNag0HgDoIOtKE6cik5Sdl5hZnggSXKcrjAr14GDl9pkE
	f2OJ2ZC0xrhdCLZFXndszl4W4/luWmNTP7PS+OltxDGsmzydyHZq7/ldRy7UrfO+wgTST1XxmQUll
	yl4jy6Pq66yHyjWnmeorc/Opb5q+JdFMY6TVlXz1//NsS4DyrJy3kUD7zjkHzfHWvXnnBwZmifk7X
	Jux8Ia8lTHM/126z0rk3B1UiO1VpbmGV0Q/Opq9aJ7Vfp2vWVI00Um1srSrTKMtPyqQ84w4nBWv04
	XUwZ1gyn51O78AHtkqjpP9RZQ0laf7w+wVAjANN0w4tvDPL02eNbuTOz/WoBh76g==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uvdDu-00000007m59-350v;
	Mon, 08 Sep 2025 16:52:03 +0200
Message-ID: <34607f53a5e68e4c9e306188738b001db8d42a52.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: mac80211: fix RCU use in ieee80211_build_hdr
From: Johannes Berg <johannes@sipsolutions.net>
To: Chen Yufeng <chenyufeng@iie.ac.cn>
Cc: linux-wireless@vger.kernel.org
Date: Mon, 08 Sep 2025 16:52:02 +0200
In-Reply-To: <20250908144709.1122-1-chenyufeng@iie.ac.cn>
References: <20250908144709.1122-1-chenyufeng@iie.ac.cn>
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

On Mon, 2025-09-08 at 22:47 +0800, Chen Yufeng wrote:
> The variable link is accessed under RCU protection, but isn't guaranteed =
to
> actually have protection. So add rcu_read_lock() and rcu_read_unlock() to
> ensure RCU protection.
>=20
> This is similar to the commit 9480adfe4e0f("wifi: mac80211: fix RCU=20
>  use in TDLS fast-xmit").

Please don't submit patches that are "like" other patches you don't
understand. There's no bug.

johannes

