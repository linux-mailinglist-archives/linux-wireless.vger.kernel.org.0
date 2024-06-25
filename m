Return-Path: <linux-wireless+bounces-9528-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 55C309166AD
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Jun 2024 13:55:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BD501F21BEB
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Jun 2024 11:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FE0F154C19;
	Tue, 25 Jun 2024 11:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="OoW+Ap8q"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86E7514D29B;
	Tue, 25 Jun 2024 11:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719316495; cv=none; b=ni/aYbn7WcELZ2cJ5TY+dTmFAXTQvr20CxXYZ4FnRMm1dYbegUu4CVjAZnzDwY8unOaCrp9Yp4JCGzMt6ZxAKqtukfQKKdjGMbL5sjgik3IW6bRlaggJ3IpXEdsvG9g7Z01nedCToqiBBQJwfMwn35p5EAM+YBx8ghdb3o0Twkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719316495; c=relaxed/simple;
	bh=tdiZzho1yxP3FP7HmO5wX6bXsbOVDiUXTcDyk6knbu0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MYRkdfvYOHxN0tiGTwrNCLNgkO4+rYm+A2A9teKhRKByLyWgG/X9FEqsDoCn3iYQQa5/q8tQ86+rzGQOblhP2jERNsckdo0Edi+r/iItx1W33Xfl6jVr+nKRJ2L5D0MNr9kqFcBd9oFJ+xz5nAVAkRebx0xuY3ZiypRvdHpHwm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=OoW+Ap8q; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=tdiZzho1yxP3FP7HmO5wX6bXsbOVDiUXTcDyk6knbu0=;
	t=1719316491; x=1720526091; b=OoW+Ap8qpRtY3MflXFDwprnVke6ylfjINu8FyRkKvXM8SN1
	E/lU2lRDQB7OqAV/KMwSq1jlG23EAGoyizGKG/J14m4uOX65cqxBIRyPMfS8NWGbNY6w8IN4vHgou
	Qs0ob2HwdgnAXLS/l3jQCcRfRh35eET9l7yOAqfUG22HmjtzPV9Lwk5u2ZE9nK8SHdLWGUoqUMgxE
	JaEsoZwgXMUmBT7FxFuFyAHzcxOJ9Vb5/Cyk7dYUBZrPaW/PqrHzrmEbCcldPRy+87JsgSLKX2nCS
	K2DlguSLCUWHnb4roCcx9571sqjb4SDFtmZeKWWi8KQVV5+0upCkkN+Bpxrssbpw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sM4l6-00000000fQc-2WYs;
	Tue, 25 Jun 2024 13:54:48 +0200
Message-ID: <2fc4b98c0899b0bbbfbfb0c7a60eb0264ce97894.camel@sipsolutions.net>
Subject: Re: [PATCH net] wifi: cfg80211: Fix out-of-bounds in
 cfg80211_wext_siwscan
From: Johannes Berg <johannes@sipsolutions.net>
To: Jeongjun Park <aha310510@gmail.com>
Cc: linux-wireless@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Tue, 25 Jun 2024 13:54:47 +0200
In-Reply-To: <20240623084939.6889-1-aha310510@gmail.com>
References: <20240623084939.6889-1-aha310510@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 (3.52.2-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Sun, 2024-06-23 at 17:49 +0900, Jeongjun Park wrote:
> In the process of searching for matching hardware channels, wreq and=20
> wreq->num_channels are checked to see if they are NULL. However,=20
> if the value of wreq->num_channels is greater than IW_MAX_FREQUENCIES,
> an out-of-bounds vulnerability occurs.
>=20
> Therefore, you must also add code to check whether the value of=20
> wreq->num_channels is within the range.
>=20

This is the same more or less as=20

https://msgid.link/20240531032010.451295-1-dmantipov@yandex.ru

no?

johannes

