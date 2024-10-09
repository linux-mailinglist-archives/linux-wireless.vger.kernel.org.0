Return-Path: <linux-wireless+bounces-13764-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C08A19960AB
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Oct 2024 09:19:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDEA1281E72
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Oct 2024 07:19:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23A3817BB0C;
	Wed,  9 Oct 2024 07:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="Ligpe25Z"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5D02178CC5;
	Wed,  9 Oct 2024 07:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728458389; cv=none; b=jo6sBAF48zP/zQfE5wBogiOGtWYlqk++D90L830cEWHtv081fDJtGbcZOHlWjeAYcGEKCH44hfJOChxyzJerkRFn6Q5uqEB7Wp7FpMSNE/XQxFvjS+rkomdySROMR31pQs4TGUNQ/8Bu7aWRiW3hW7HhvDpM5ANi6LzUSLqccwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728458389; c=relaxed/simple;
	bh=JBn4BEiZQHJtGcyOanMYeBuNbZA6TpUh9xbUs240bYI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XXx4RHd+ke8rSbkGwxZDSwN7ZWn/Nf3xRQb8gRQsEgggoGoqFiRw71XU/lz3nrcOcTxLL0R2WZEVU5a68IYnaWCkPZsm/NUK0M6QZlx8IPTcJT+nstTtcHyJC2bsQx6GhoU45O3dIBOEPh4MBm3AYriDqkqVRlsyucJid+s/YaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=Ligpe25Z; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=JBn4BEiZQHJtGcyOanMYeBuNbZA6TpUh9xbUs240bYI=;
	t=1728458387; x=1729667987; b=Ligpe25ZoS+609nwOtJpAmQ3TI6ZDu4SESIbdNQeNTNQfVW
	T/fs9c9V4xKwK3yISodG10MjuMwV1Zrmm3gsJDp/lHP3tpe7XojH9EhE/8GZTxFa1pOp3iY0YPGkE
	WlKCu/jQifDfnMd/gljgjTvWWJmnM2mwQmPKn7PDBSVWTZDvM5NG4llMOk84DA5MjjS/tRoVdZgHj
	h86W5IDq3yJxmYoZeJjuClyWpcYLmx34u6lEWZWVu+cujsBixmSugcPSY/iBimOBoH4G60aIpfDFV
	DzTGl7vubkzX5HJtSshq3/iaIOo4Khqc9PkQijL4Ubgse8dw4wg0vmkYg2rHZ/aQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1syQyz-000000051K0-38Hs;
	Wed, 09 Oct 2024 09:19:42 +0200
Message-ID: <e572bee3a1c2600b09cb2fd5d09a2e95b4e0faa0.camel@sipsolutions.net>
Subject: Re: linux-next: manual merge of the wireless-next tree with Linus'
 tree
From: Johannes Berg <johannes@sipsolutions.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Kalle Valo <kvalo@kernel.org>, 
 Al Viro <viro@zeniv.linux.org.uk>, Wireless
 <linux-wireless@vger.kernel.org>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>, Tree Davies <tdavies@darkphysics.net>
Date: Wed, 09 Oct 2024 09:19:40 +0200
In-Reply-To: <2024100917-footsie-anatomist-fd06@gregkh>
References: <20241009114455.52db31ad@canb.auug.org.au>
	 <2024100945-engross-appraisal-d1f0@gregkh>
	 <317aeb02110105be1483d13c204bfb48d4d19c61.camel@sipsolutions.net>
	 <2024100917-footsie-anatomist-fd06@gregkh>
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

On Wed, 2024-10-09 at 09:13 +0200, Greg Kroah-Hartman wrote:

> > But if the conflict is to Linus's tree, is that even going to help?
> > Seems like I should pull in -rc2 and solve this one and the ks7010 one
> > that way? Just need to check with net-next?
>=20
> I'm not worried about the conflict with Linus's tree, sorry, I now see
> that that's what was being reported here also.

Ah OK. But I checked, and I can just pull in net-next to resolve this
and two other conflicts (where one appears to be due to git getting
confused between moving a file and deleting another copy of it in
staging), so I'll probably just do that, just need to sync with Kalle.

> I just want to get your
> staging driver changes, so I'll pull in up to commit 4991d2e7ad38, which
> is all I really care about :)

Oh OK, so that's mostly unrelated then. Sure, you can pull that in so
you have the staging changes I've made in case other staging patches
want to touch the files.


Although ... maybe wait with that too. If you merge that now you'll have
to resolve (some of) the conflicts, and if I'm merging net-next now as
well we'll have two conflict resolutions for the same thing? That seems
a bit strange, even if the resolutions are almost certainly going to be
identical.

I can push out the net-next merge (& revert) soon, and then it'll all be
cleaner?

johannes

