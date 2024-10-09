Return-Path: <linux-wireless+bounces-13779-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 50AD69962E7
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Oct 2024 10:36:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B4211C2105F
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Oct 2024 08:36:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7FFB188CCA;
	Wed,  9 Oct 2024 08:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="CMuEruiQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25F5A156242;
	Wed,  9 Oct 2024 08:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728462620; cv=none; b=H79802Gq6QAgvoJaFxB7EbtZBTAeLzCrbVkMR1WHJuCzg6cbl1BBbLvpPCX4Vh+j0VqNBLuEHsICIKNwBwscqnPjaSaWVmuqv19Lk25rGq9/57j7+RDsQtpSRmjRF8QObMlzgNXm2r2+oIqeM8yNiuoiqnjfujWRAEzYyio8kF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728462620; c=relaxed/simple;
	bh=J0MuZ9y7Csr9VC4erkWF13eDiezrQ8t0T4lEkYuLdUw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=u+qlTl7vG25N+Nqzx/xNESHWOUt/nPJDax+CRY/NBVQ4qQMgvQ4sz+Ioh9C3+zRmzzK+2ivy6AfZfqIpQ/yISEYDnQhxheImdgSOlVZuz1q7fHt4VoKGh05PXmB0q+lNic/yRQQ2l/zVESQjUNxKZrjcoToXanyNqnWlPAkGJN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=CMuEruiQ; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=J0MuZ9y7Csr9VC4erkWF13eDiezrQ8t0T4lEkYuLdUw=;
	t=1728462619; x=1729672219; b=CMuEruiQIFiD+lnDqbPL3bvVlEnPK9eJI603PKJC4akFMkg
	vSQGmMldali8gKbS1DPSwAg4Q1d+f+C9WBJEibLg+N52P344uyZTBcovvXZpFKArdMtxk3VYfplsN
	/r8aH/Vu0P0IT4xT4rGe4bFbkX8foQnn27xLev51uhVdCv9tOwv7WCkJ+voS1gz88l+PRr2j9pkI/
	+NAmJd7ST1O/mbTrGT6UF/j3Feybr8XBrxjOIbk1GXnJ9sVtm5MSToQC3gPxALdmy0W9JJ03M8gjN
	wMViG3PTRXdaqsW7LFrFc4r7P1PWjB0Gmd/eMYzEe2WvaO+wIQWzcEpZAg6LO1jg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1syS5F-0000000537C-3SgT;
	Wed, 09 Oct 2024 10:30:14 +0200
Message-ID: <287ad9eeb94f1e326c22fdcb74c94ef3fde84115.camel@sipsolutions.net>
Subject: Re: linux-next: manual merge of the wireless-next tree with Linus'
 tree
From: Johannes Berg <johannes@sipsolutions.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Kalle Valo <kvalo@kernel.org>, 
 Al Viro <viro@zeniv.linux.org.uk>, Wireless
 <linux-wireless@vger.kernel.org>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>, Tree Davies <tdavies@darkphysics.net>
Date: Wed, 09 Oct 2024 10:30:12 +0200
In-Reply-To: <2024100941-gaining-sprang-826b@gregkh>
References: <20241009114455.52db31ad@canb.auug.org.au>
	 <2024100945-engross-appraisal-d1f0@gregkh>
	 <317aeb02110105be1483d13c204bfb48d4d19c61.camel@sipsolutions.net>
	 <2024100917-footsie-anatomist-fd06@gregkh>
	 <e572bee3a1c2600b09cb2fd5d09a2e95b4e0faa0.camel@sipsolutions.net>
	 <2024100941-gaining-sprang-826b@gregkh>
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

On Wed, 2024-10-09 at 09:27 +0200, Greg Kroah-Hartman wrote:
> >=20
> > I can push out the net-next merge (& revert) soon, and then it'll all b=
e
> > cleaner?
>=20
> Sure, I'll wait, just let me know what commit to merge at, from what
> tree, whenever you have it ready.
>=20

I've done all that now, so you could merge wireless-next/main up to its
head, which right now is a0efa2f362a6 ("Merge net-next/main to resolve
conflicts").

johannes

