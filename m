Return-Path: <linux-wireless+bounces-13760-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B8E5996046
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Oct 2024 09:04:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22DC3B21F77
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Oct 2024 07:04:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C9E417B4FF;
	Wed,  9 Oct 2024 07:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="RA6wLkDa"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D68D617B439;
	Wed,  9 Oct 2024 07:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728457451; cv=none; b=k0EMli9FX/j2RNu3VHjAndg+PHX8sKvd8BlnRnl1+QGl3DfZULeKXWCmDctY4gkds5vHOsEH7IdVzKTssPc/8zN0fZPiNxUami3uSs0sGKOQdwMc50Q+V2H0OvyHDbSQaKidnsik/dIDcjLZ7AUzA4+MR7YvbeZBCJQx62Htr6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728457451; c=relaxed/simple;
	bh=sJD2Z8sFpy5Y61L/RtbkCwjnD4BWVUJuDgf6rk8rJqs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tlsFT0mjwxP2H9YNoWHelF85gqVuTNJEvv7anlx9674eTlExEU3aS0i7gEhAW06/MyqV6aWjwqjO57BtIGxBV7LHB8BhDHc6mkhbL7MJGFVO6kFLwBdfmacJdjJsGVBiPdke9LZfS/tG13DwlngruIsjo2Qz5TUgfaR4Ud9TEhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=RA6wLkDa; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=aqhpBi3cklBTojqLh3j+zTm+IWOnXP/KJnkKKOJuSNE=;
	t=1728457450; x=1729667050; b=RA6wLkDa8VbZUXmLWu5Vt5BXzwg8vVmONBSrzbscvj47xxw
	c2QJn0FWMXLfhyhM1emX0u4ahaepkSB4A94A3TBr4Lcu8v81FL3IIcheNR2RmSdZVvrWoY8WPK0Rf
	PjzLQO3h4QXhpjuYkUaIT5f50fxaY6k5sN98fVddP1ZIoczilZrWUvjtFxrN8QXg8iP+dm4/yQTV+
	XFVi99TubCR9K4g/QbpnDjNm63NaMlEjETktJiZw+XkSVXbLyI9/Hi4XLZBeUn88WKUgZKbKqu5bX
	Y/0ht2mWj9cSH2uEbMba0KuDfTFfg2AeLWoFxL9ctVMM6KURlM3cLZ3CPeIa1QpQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1syQjt-000000050qK-3qA8;
	Wed, 09 Oct 2024 09:04:06 +0200
Message-ID: <7afe5f31dee8f356ae4299a27181c5f1546b8ef2.camel@sipsolutions.net>
Subject: Re: linux-next: build failure after merge of the wireless-next tree
From: Johannes Berg <johannes@sipsolutions.net>
To: Stephen Rothwell <sfr@canb.auug.org.au>, Kalle Valo <kvalo@kernel.org>
Cc: Wireless <linux-wireless@vger.kernel.org>, Linux Kernel Mailing List
	 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
	 <linux-next@vger.kernel.org>
Date: Wed, 09 Oct 2024 09:04:05 +0200
In-Reply-To: <20241009120457.4bcebe8e@canb.auug.org.au>
References: <20241009120457.4bcebe8e@canb.auug.org.au>
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

On Wed, 2024-10-09 at 12:04 +1100, Stephen Rothwell wrote:
> Hi all,
>=20
> After merging the wireless-next tree, today's linux-next build (x86_64
> allmodconfig) failed like this:
>=20
> ERROR: modpost: "wireless_nlevent_flush" [net/wireless/cfg80211.ko] undef=
ined!
>=20
> Caused by commit
>=20
>   aee809aaa2d1 ("wifi: cfg80211: unexport wireless_nlevent_flush()")
>=20
> I have reverted that commit for today.

Oops. I totally forgot that wext-core is always built-in (while cfg80211
can be a module ...). I've reverted it as well.

johannes

