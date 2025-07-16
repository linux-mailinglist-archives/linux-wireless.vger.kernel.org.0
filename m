Return-Path: <linux-wireless+bounces-25530-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 96B30B07109
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Jul 2025 11:00:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85BE73B30A0
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Jul 2025 08:59:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B12D82EFD98;
	Wed, 16 Jul 2025 08:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="A4FAfAf3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 025722EF9C8;
	Wed, 16 Jul 2025 08:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752656394; cv=none; b=g7unspr2ErmTBjRypANg20uTw6c2ODzJ4bVT0J2Yxxi+CfzGbG/+wb4tDeJQXTm5ROhbfctTw6SYIFFGoAfJQ/uHSQf9sBhbhxZu5oi4PzclSNHX+a5dcb1ihDb10OXAkR2hR8bIjdCVaem6pH/lMl3iwyO13L+v0UGxfH3MO3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752656394; c=relaxed/simple;
	bh=omsA/uCDBuMfKRi2jS9/2tG724FfWKvFGOyfgKRKD4M=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YbGPIPgK/4CO0oEaUz0/7xoCalWLmbF3X6j/BDQKHvS+rwjf1nJHvpuzqjdj02fEIbVlkWFop+nq59AFCu5ECmjdh3c+iI3Qpxl90tGZVrp7exVNIEMrbHTqcdl6N2I0D+gTZ6ROaBQHAPAyxGTCp3nI82bhNkrKg9M215Wmrbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=A4FAfAf3; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=bNIqQCJn++oQUJ7jX7uY/k18mYpdzuADPNVvf9H5Dc0=;
	t=1752656393; x=1753865993; b=A4FAfAf3xFvoRb24IhE0/24iQxEyGr3qTgf0KP4GiZx0ZB6
	UGNjXoDcN7P9dNj8sjyNOz/XqtpZWPl/YQ8ZuSVbdE+W1JGvfe671k4sKJtPcyBx2iJ3xUn1nwX5J
	y5pYA/oRh2fyHq6zwlje0HJK7112KTDUtfsNxFSLmVCTYwtQH8fMV2ozLHh1azCrVaowta0rZE4Ab
	fEe+Prl4YmfPn877dKwZoyXsho+SVpGLoe7y9SaxLxW8I7jGnMLK/322UV9ZVvyVx1e2ugVFp/oNb
	CbqRMTbDF9xxvsoqiWAaN+JvYzl5Pn/MB2XmCgjx2S7reLgJg3IyPkyly+rr7Ngw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1ubxzA-000000080BS-2JWa;
	Wed, 16 Jul 2025 10:59:32 +0200
Message-ID: <4ee6758a49e6f01c5e42b2f7c27aff905ac07dfa.camel@sipsolutions.net>
Subject: Re: linux-next: manual merge of the wireless-next tree with the
 wireless tree
From: Johannes Berg <johannes@sipsolutions.net>
To: Stephen Rothwell <sfr@canb.auug.org.au>, Kalle Valo <kvalo@kernel.org>
Cc: Wireless <linux-wireless@vger.kernel.org>, Linux Kernel Mailing List	
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List	
 <linux-next@vger.kernel.org>, Miri Korenblit
 <miriam.rachel.korenblit@intel.com>,  Pagadala Yesu Anjaneyulu
 <pagadala.yesu.anjaneyulu@intel.com>
Date: Wed, 16 Jul 2025 10:59:31 +0200
In-Reply-To: <20250716135252.51125baa@canb.auug.org.au>
References: <20250716135252.51125baa@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Wed, 2025-07-16 at 13:52 +1000, Stephen Rothwell wrote:
> Hi all,
>=20
> Today's linux-next merge of the wireless-next tree got conflicts in:
>=20
>   drivers/net/wireless/intel/iwlwifi/fw/regulatory.c
>   drivers/net/wireless/intel/iwlwifi/mld/regulatory.c
>=20
> between commit:
>=20
>   5fde0fcbd760 ("wifi: iwlwifi: mask reserved bits in chan_state_active_b=
itmap")
>=20
> from the wireless tree and commit:
>=20
>   ea045a0de3b9 ("wifi: iwlwifi: add support for accepting raw DSM tables =
by firmware")
>=20
> from the wireless-next tree.
>=20

Thanks for the heads-up.

I'll double-check, and give Jakub a heads-up, he's probably going to hit
this, unless I defer the wireless-next pull request. We'll figure it
out.

I also just noticed that you're still sending this to Kalle - he stepped
down as maintainer earlier this year, so you should probably change the
contact for the wireless/wireless-next trees to just me.

Thanks,
johannes

