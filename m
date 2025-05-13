Return-Path: <linux-wireless+bounces-22909-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CC1B8AB5419
	for <lists+linux-wireless@lfdr.de>; Tue, 13 May 2025 13:47:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E91C4A486D
	for <lists+linux-wireless@lfdr.de>; Tue, 13 May 2025 11:47:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 701A1255E4D;
	Tue, 13 May 2025 11:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="VaOIbhiC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB7F480B;
	Tue, 13 May 2025 11:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747136817; cv=none; b=siZFX3yZGq/I51K+rJ/YAdCrpsad5cPzcW+RvsxSEcl+CUCL3dEM8nrJDcDWP4u4tH4kxeD4RSKS6UgQhgEHN9ofsoh7RrMkvzaR+3vfzK1UtopIFExHyWIKoiWjEeMYWGcwy3NAYjCTRkcIfsxdpUBzXMHuPanCs0qPxFWFO94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747136817; c=relaxed/simple;
	bh=39DgN9vO0bRlRqRRCgPbIKO6NwIWeagSGyorUVU4fLU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IYpP+fWVPVCIZtfKlnF/DSmpb6ZkuApxlCgWmT/ftNP3ZC3v1xx1vJ5H2FmPqIZKLpA1RV1L1R/dWo8RVKv0LFotccygsiYGe/fIKorXJQXJIGBKsLosK604Tl0sAACi2eCK9c5cPvp6E8ju5Is6pAX/LA9uJWNgLcGb1u7ZmPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=VaOIbhiC; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=39DgN9vO0bRlRqRRCgPbIKO6NwIWeagSGyorUVU4fLU=;
	t=1747136815; x=1748346415; b=VaOIbhiCwcYzUXXZkYv65/3UIIW6UP+lvyBOjWA6WyVEcNV
	EFh8IQd/rEcvUfKdBg+ZddXP/E4nzaL4aWCqUScJxcIXs5fEVI0HWdokvseByV1vV68snj+rqYvj1
	g+oo2zQ2ECmcku9JV9soUwM1k82vWAbyCUsoRpOt4KScutjoXjGQmBdCtgQ01MQ2Cc908UwPUgCw9
	2BUOgtcUWxovBJrHb3h8InY110GqYWgoM/MgRe8O5HRusduaBwV+y4Xzz4I2riwUlunbkKt+e+D6X
	ABrWhrT4QSpNSyk1faYP9bWA4qiYCBR2p8mxpoakRtp1FWK5NTa584Nj/WQF5FFw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.1)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uEo60-00000005WwZ-0p4C;
	Tue, 13 May 2025 13:46:52 +0200
Message-ID: <e1b26ee842bc60cfa939874f467a03531871807e.camel@sipsolutions.net>
Subject: Re: wifi: iwlwifi: SAE fails when AP sends confirm before STA
From: Johannes Berg <johannes@sipsolutions.net>
To: Jan Hendrik Farr <kernel@jfarr.cc>
Cc: James Prestwood <prestwoj@gmail.com>, linux-wireless@vger.kernel.org, 
 Miri Korenblit <miriam.rachel.korenblit@intel.com>, iwd@lists.linux.dev
Date: Tue, 13 May 2025 13:46:51 +0200
In-Reply-To: <aCMtCCYtNNl4dL5Q@archlinux>
References: <aB30Ea2kRG24LINR@archlinux>
	 <4ffbeb94-ac19-4437-9d98-24981fe6c240@gmail.com>
	 <aB4HC8Iaa6wR5dj7@archlinux>
	 <15943a1f-0e5d-4705-b8ef-3f22fa3fe672@gmail.com>
	 <aB4hMsBfyawYatoj@archlinux>
	 <902daf8802c723d72fff0155cd0638848ce1bc7f.camel@sipsolutions.net>
	 <aB5onavenLymR-QJ@archlinux>
	 <8a1c5172bc0fd9d2a33522294d1a2a4c4ceb313a.camel@sipsolutions.net>
	 <aCMtCCYtNNl4dL5Q@archlinux>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Tue, 2025-05-13 at 13:29 +0200, Jan Hendrik Farr wrote:
>=20
> There is a an SAE confirm sent by the AP. It's frame 170 in
> capture2.pcapng. It's also retried a number of times after that.

Oops, yes, I didn't catch the different seqno and thought it was all
retries of a single frame.

> There is however no ACK from the client in response to it and it also nev=
er
> shows up in iwd.

Right. Clearly this is because we actually leave the channel when we get
the response to the auth frame.

I guess most cases we have the client much faster than the AP, so this
might never be an issue. I guess here you were saying the client wasn't
all that fast in responding.

In fact the AP seems to take ~17.1ms from one frame to the other, and
the client ~20.4ms, though the client has some propagation delay through
the software stack too.

I don't think this is really the right fix, but it might help:
https://p.sipsolutions.net/e852565303ad878b.txt

johannes

