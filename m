Return-Path: <linux-wireless+bounces-8146-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E0DC8D09E4
	for <lists+linux-wireless@lfdr.de>; Mon, 27 May 2024 20:30:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E5881C21989
	for <lists+linux-wireless@lfdr.de>; Mon, 27 May 2024 18:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7277F15FA91;
	Mon, 27 May 2024 18:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="qq294NiM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EB8915FA80;
	Mon, 27 May 2024 18:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716834641; cv=none; b=KbAoCuu6c6R0nkABdJu8FPhBRi6dRaYabuwCh1q21mdfI8o/EvHUXWtQR8tCYLfOhQt8W2tmusDeU8pfo13kOdm9tMgH+mJs3rp72MtepS1gipTgw9mK4HKRWxZKvKd5RLiuKgb0zsUhLY/AOXDohFDEPMUj/jirHMd5tHP/rlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716834641; c=relaxed/simple;
	bh=VNwqDkuFgKjhVHJW0w5JUYp4JYk3Ki4mNKDdPxV9apI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=L/7Q0JlGodyeBsjydn6nD33+zXK9Ma3g+uZ6I0bfivavmp1hj+DQ1emSsMdcuEdyiSjRRGvLUdGW8REIABlAzfzNRP8eRgHapQZcz6ckXW77TIx0OUjdcwHZ2UtsYrwv4Ure9hhAPJ7co7xXil+RY33BjLvKg1fG1rKfqbwMK5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=qq294NiM; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=VNwqDkuFgKjhVHJW0w5JUYp4JYk3Ki4mNKDdPxV9apI=;
	t=1716834638; x=1718044238; b=qq294NiMW+Umd//R+Iek7poOaRGs2K1N+kxAfA++JAMN4WX
	AH5YRPm6GZchkqKp4X5SINGVpOC9zRJxk7f3mDYzRPNVQw497X0JsNNIA/67Jgv7GrlnPjvp3oScr
	R0KC1q0I8yMlBhw4NW17tNI5NMF5W2kf8tzmlYUWLNOJqH2g3AiGzZK9mYVgW7qdE52AK9/CJjeiX
	wQLap1ly8oRafHyClUxs/Jb/WXhaGwPv940xDmPVHzBGMEIxt/QYiptlezfMKCwyuZCn2HbQrMzqT
	53613LhEH/eVR2HRldiXAG4n/c72aegBxp41AglEceokZfoHH7KfxEfZMbB2EFZA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sBf7B-0000000D2t4-0Xcd;
	Mon, 27 May 2024 20:30:33 +0200
Message-ID: <98871a58e675aef7ad7f2e5bd3bb2ee526d29d5f.camel@sipsolutions.net>
Subject: Re: [REGRESSION] MT7915E doesn't work any more with v6.9
From: Johannes Berg <johannes@sipsolutions.net>
To: Greg KH <gregkh@linuxfoundation.org>, Kalle Valo <kvalo@kernel.org>
Cc: Oleksandr Natalenko <oleksandr@natalenko.name>, 
 linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, "Linux
 regression tracking (Thorsten Leemhuis)" <regressions@leemhuis.info>,
 linux-mediatek@lists.infradead.org,  linux-arm-kernel@lists.infradead.org,
 Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>, Ryder
 Lee <ryder.lee@mediatek.com>, Shayne Chen <shayne.chen@mediatek.com>, Sean
 Wang <sean.wang@mediatek.com>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Peter
 Chiu <chui-hao.chiu@mediatek.com>, StanleyYP Wang
 <StanleyYP.Wang@mediatek.com>,  Linux regressions mailing list
 <regressions@lists.linux.dev>
Date: Mon, 27 May 2024 20:30:31 +0200
In-Reply-To: <2024052750-rippling-catty-1cb5@gregkh>
References: <6061263.lOV4Wx5bFT@natalenko.name>
	 <2341660.ElGaqSPkdT@natalenko.name>
	 <60fe8df750a74331b8a54a76d55d5e8349ac46b4.camel@sipsolutions.net>
	 <878qzy9zly.fsf@kernel.org> <2024052750-rippling-catty-1cb5@gregkh>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Mon, 2024-05-27 at 20:29 +0200, Greg KH wrote:
> >=20
> > Yeah, commit 2f7cf3b61d85 should have been taken to wireless tree but i=
t
> > fell through the cracks. I didn't realise that it's an important bugfix
> > and the commit message didn't give any indication of that either.
> >=20
> > But commit 2f7cf3b61d85 is now in Linus' tree so it would be good if
> > someone could submit it to stable releases.
>=20
> It's already in 6.9.1, does it need to go anywhere else?
>=20

No, but apparently we need a similar commit for mt7915e or something? I
have no idea why I missed those. I'll take a look tomorrow.

johannes

