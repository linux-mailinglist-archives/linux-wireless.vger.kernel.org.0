Return-Path: <linux-wireless+bounces-27183-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42E4CB4B5E3
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Sep 2025 14:07:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04FAC165138
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Sep 2025 12:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C72D82DAFBA;
	Tue,  9 Sep 2025 12:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="GBlkzjj9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 076763019CD;
	Tue,  9 Sep 2025 12:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757419620; cv=none; b=p/kQsjQRKgJYDOKoyvIp5NnXs2H9sabir3QeiS8ZFRNsrsyITu8Z2O6iXY7sP4X8owTqo4OiUe0s8F3+dOaUIjv1CQLzXr5YrfGW6IMDzPrbS1fTDHAbQ7Gt2NHvjNxHCqviv89sCbS4sYemTrFm4z9zEYvzHJ+yay4r6vsUjmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757419620; c=relaxed/simple;
	bh=PAKA1wCGbeX/jloc+RXWCoaOOIQehe0BvPsRlLQy0ZI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nabwRUBiVyTiiqtjBo+YztxkSY+wup2ZkpK82AP9/lGNoBsdiaboyrPVi2b+ZFto9MlL2tkxFQtf/GGKAmm9yAGbhL0pOF3s1A2R4D0kxpcKMacSoMkQwWYTjuVss6r78jwxh9IQZSfyOINIZX26EAuLlIbBVl0seXcM5LQCN58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=GBlkzjj9; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=PAKA1wCGbeX/jloc+RXWCoaOOIQehe0BvPsRlLQy0ZI=;
	t=1757419619; x=1758629219; b=GBlkzjj91fms8i7EnWSqm6lVNFD2RgtTv99b7QaUuy6LsfE
	xDnYLq4UgoenUpJBVRWflMmHH77/1Q8NHdCD5gKX6CtADUiK8F39P7hgXY1gIGkretTZNE9ufkN9w
	ggDqGx4f36zunKwKKXp3VaFGg4XMMqq6wNtRZP+0441Dh+f8qEG8nSjkp5Hm7xPoxvXkBuJ9CDzXu
	tV9jBhQpw2MESYTDdikH3tvNY88hGiXuPoCUrNMgoRva0+YvnZZMUPMJSimUTERkdlwCXYI/Q3p6w
	5Gq4erbs8JupcqGYHh8oaYFFEmN4H9weYf5qRoUwB2Bx7oUZEFV512bRex/amn1g==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uvx7f-0000000AF7J-3HSl;
	Tue, 09 Sep 2025 14:06:55 +0200
Message-ID: <2363d0a432d280cc2e374cce6603300868780592.camel@sipsolutions.net>
Subject: Re: [PATCH v3] wifi: cfg80211: Remove the redundant wiphy_dev
From: Johannes Berg <johannes@sipsolutions.net>
To: tanzheng <tanzheng@kylinos.cn>
Cc: arend.vanspriel@broadcom.com, linux-kernel@vger.kernel.org, 
	linux-wireless@vger.kernel.org
Date: Tue, 09 Sep 2025 14:06:55 +0200
In-Reply-To: <20250909011444.86314-1-tanzheng@kylinos.cn>
References: 
	<67bca659b2e5d3f1625d6d92c9652618f29a6195.camel@sipsolutions.net>
	 <20250909011444.86314-1-tanzheng@kylinos.cn>
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

On Tue, 2025-09-09 at 09:14 +0800, tanzheng wrote:
> > > > > There is no need to call wiphy_dev again.Simplifying the
> > > > > code makes it more readable.
> > > > >=20
> > > > > Signed-off-by: Zheng tan <tanzheng@kylinos.cn>
> > > > >=20
> > > >=20
> > > > The bot complains this doesn't match your From: line, is that
> > > intentional?
> > >=20
> > > Yes, I set it up this way on purpose. Sorry, I don't know=20
> > > this rule. I'll modify Signed-off-by. Thank you for your comment.
> >=20
> > Oh. I wasn't really thinking you _need_ to change it - actually I was
> > wondering if you _want_ to change it since I thought maybe "Zheng tan"
> > was your preferred spelling, and your email client just used the
> > localpart (before the @) instead of your name spelled out by accident.
> >=20
> > So either way I'm fine. Let me know what you prefer.
>=20
> In that case, perhaps I prefer "Zheng tan".

Ideally you could resend with your From: line adjusted, or even an extra
From: line thrown into the body of the mail, but I suppose I can try to
adjust the From: line as well on the other mail you sent, assuming I
remember :)

johannes

