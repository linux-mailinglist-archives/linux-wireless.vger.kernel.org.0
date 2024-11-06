Return-Path: <linux-wireless+bounces-14976-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 114189BE565
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Nov 2024 12:16:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9535284394
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Nov 2024 11:16:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D83501D434E;
	Wed,  6 Nov 2024 11:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="NFw5g8EW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4822418C00E
	for <linux-wireless@vger.kernel.org>; Wed,  6 Nov 2024 11:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730891805; cv=none; b=XpF1QeuT28YYTq8GDPXgyXO7FG/WJ1FxHM/nmwfq+u7mNvjg4YwjQsuOVnoOl8XaCzHV/4kKzzZSNbUZn+p9iaNy5vXCTyKjgO+HOwad/nN1+8E97U1LremmN1O+5N1PFgJUB2BPkOZNoZzY1nZYxrNZe4KxY/Inrx7psvyeabs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730891805; c=relaxed/simple;
	bh=u2OJHC3GFG0xeeuojpOzUK0RzPCFfRBF08cxfp2Tt9g=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NSL7Y08NvBPGQC7mKLSOY5aKYYDOf0LdaF1f9RLdSJTlCMxNyCDHkHJMbqjNWKLiTae9/nq6LjFDwhg1veqq2dHKmo99owtv2a873mDMDiyU6DwKdMSLXYNtPpPbPy49OKJZe3Mj7qnLg672SapCGR+XyQd03tRxynaCyrx+BJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=NFw5g8EW; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=u2OJHC3GFG0xeeuojpOzUK0RzPCFfRBF08cxfp2Tt9g=;
	t=1730891804; x=1732101404; b=NFw5g8EWl+VbjeE1f0Bfkx2hOFENepNipPAxgDP+wzaF2fB
	jCEUGi9sGtebpBELzw5nPldqeuCYSlafXcevh2VIDhUF3eJ/uHYSfEcz0RhPRFj40XoI0i1OOyMu7
	SWUkh8seoUknmj/VIp14pxMRh9JnTjjPvEblkVgRF68zQTqBK7bqlVYvVW5A2A7DWPk527Z123kVH
	dHvTK0eQ0z0xtqOAoCw5Dild6jBo983asFWAjnBgoY3oRnzOZyVYV5ZzL0mku0zZma+5bxJD48v+D
	WnVwfEWE/og3rPNmitaC3iT2BezyKTSMiNQNqpw0CaYAJPyxZXI0pg44YeD8+xkQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1t8e1h-0000000FatA-2bB2;
	Wed, 06 Nov 2024 12:16:41 +0100
Message-ID: <de027142c37024b2a2777011ae278b50e5fcd4fb.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: mac80211: fix mbss changed flags corruption on 32
 bit systems
From: Johannes Berg <johannes@sipsolutions.net>
To: Issam Hamdi <ih@simonwunderlich.de>
Cc: linux-wireless@vger.kernel.org, sw@simonwunderlich.de, Kretschmer
 Mathias <mathias.kretschmer@fit.fraunhofer.de>
Date: Wed, 06 Nov 2024 12:16:40 +0100
In-Reply-To: <eb4b7856fe814038de1673d47afabbbfef8e97c5.camel@sipsolutions.net>
References: <20241104172415.3790038-1-ih@simonwunderlich.de>
	 <df6c3317a71c8fa76f2b64623a0278f1fd0a68dd.camel@sipsolutions.net>
	 <eb4b7856fe814038de1673d47afabbbfef8e97c5.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Wed, 2024-11-06 at 12:11 +0100, Johannes Berg wrote:
> On Wed, 2024-11-06 at 12:09 +0100, Johannes Berg wrote:
> >=20
> > > +++ b/net/mac80211/mesh.c
> > > @@ -1164,7 +1164,7 @@ void ieee80211_mbss_info_change_notify(struct i=
eee80211_sub_if_data *sdata,
> >=20
> > You evidently have _hundreds_ of out-of-tree lines, probably some of
> > those cause this bug too.
>=20
> Ahrg, sorry, no. I take it all back, I was looking at the completely
> wrong tree by accident.
>=20
> Still this seems like the wrong fix, it would be better to take care of
> all the 64 bits?
>=20

Also, a Fixes: tag would be nice.

johannes

