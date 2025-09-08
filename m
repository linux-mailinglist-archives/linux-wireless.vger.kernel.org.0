Return-Path: <linux-wireless+bounces-27073-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3428DB48434
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Sep 2025 08:29:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E46E5161F7C
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Sep 2025 06:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29FB82222B6;
	Mon,  8 Sep 2025 06:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="sg4I7TU2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBFC1137932;
	Mon,  8 Sep 2025 06:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757312972; cv=none; b=hIXfBvRVrd9/b5vJ6yFs+1/B67Gbdbhll43zfH9FkAbYxD/JGZhpkGo592MbyFn+DMazoR432IGou7Rexde3ZOHXSUr017RaLBU74gHpVPyC5NRBks5XXbAfLmZ2sZ2lpanxLe6IatXK30RlwlaBNUytoyh1U6X0et5WABKSIIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757312972; c=relaxed/simple;
	bh=GQo3N1VRu9BW1J0dDwW/ru3HPFhE7kRzualaDvdJXzc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TAO3R3jHGQCm+DkSXL4I2T1GqcfixeAVU4qxMVpcA2vr8fvTw18MxFRrvvNaNZ/dJIF8qD+mF4TFIo1k+UujIa/slO4czJKKal5lS/IIroxe5podM497zGe05OsxXDg5+Ez41YVIU6qejyOBM2K6vyPufb0zSjpCb9H67Wh7Zf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=sg4I7TU2; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=GQo3N1VRu9BW1J0dDwW/ru3HPFhE7kRzualaDvdJXzc=;
	t=1757312966; x=1758522566; b=sg4I7TU2kmxQlqzklRiktlXddX3wYlpu0hPwbTftMGUJu27
	ILckX6uJ5tlTLUs1ztIQL2q+dLklmtqoPU+k3rNOxnzXei3nYc4TsRbZFdlJ/Q5ULtEExD+tbSuYU
	E8MPevrj3rC1buVQ3Q0dBb4t8WuBUSXuv9Pe1aKyvinNJikvi/OWuTNjshQFtxtA1eOftgNMJUJlT
	F1dzowp7fswM0Jjerdjbh9RQTGEe+G+ITdZIhhlj0v22bE44qFQ6VIAwQtS+Sg9XuOnx9PIrm7sq9
	YxRjlbMDlL8RnMoldTLavboy82C20QjFyq67sWQHZ6qeX0zp343g48wCbiKgUVyw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uvVNC-00000006pbA-3Crm;
	Mon, 08 Sep 2025 08:29:06 +0200
Message-ID: <67bca659b2e5d3f1625d6d92c9652618f29a6195.camel@sipsolutions.net>
Subject: Re: [PATCH v3] wifi: cfg80211: Remove the redundant wiphy_dev
From: Johannes Berg <johannes@sipsolutions.net>
To: tanzheng <tanzheng@kylinos.cn>
Cc: arend.vanspriel@broadcom.com, linux-kernel@vger.kernel.org, 
	linux-wireless@vger.kernel.org
Date: Mon, 08 Sep 2025 08:29:06 +0200
In-Reply-To: <20250908014509.190317-1-tanzheng@kylinos.cn>
References: 
	<e02385300c075395346ccf70b46a648698a66a3d.camel@sipsolutions.net>
	 <20250908014509.190317-1-tanzheng@kylinos.cn>
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

On Mon, 2025-09-08 at 09:45 +0800, tanzheng wrote:
> > > There is no need to call wiphy_dev again.Simplifying the
> > > code makes it more readable.
> > >=20
> > > Signed-off-by: Zheng tan <tanzheng@kylinos.cn>
> > >=20
> >=20
> > The bot complains this doesn't match your From: line, is that
> > intentional?
>=20
> Yes, I set it up this way on purpose. Sorry, I don't know=20
> this rule. I'll modify Signed-off-by. Thank you for your comment.

Oh. I wasn't really thinking you _need_ to change it - actually I was
wondering if you _want_ to change it since I thought maybe "Zheng tan"
was your preferred spelling, and your email client just used the
localpart (before the @) instead of your name spelled out by accident.

So either way I'm fine. Let me know what you prefer.

johannes

