Return-Path: <linux-wireless+bounces-8832-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 31A7F904C4D
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Jun 2024 09:07:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCF4D1F224CE
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Jun 2024 07:07:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 027E625622;
	Wed, 12 Jun 2024 07:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="QUIud+EN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C20F5167DB8;
	Wed, 12 Jun 2024 07:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718176028; cv=none; b=u8pmIlMea8Jn9Ztdss1VoB7O9VaAL+Ky74XitvYxg/VyCzROunied4GBRbGqcEqY1UbPPesM5L50HaEv40EWhtfNKqRgg3e12lqhPVk/SwbaGPPqdwaStj/TskEM4KkN/Ej1DpfPIllB/iJCMp8OXsy6J0oyTYFlnw8ruriEkAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718176028; c=relaxed/simple;
	bh=rYs16LMDXSBKD16sAOH3Kuiy41oWYZJcg08wjQC6+CU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hT8o7I2wijMXJVe1h3NrWju9cJZjHnxNbkEu6bRRJ5oJpgtFB4WhNwhlwhu2C8fJuPwFjnZnTdrTil61Ro22Bnbv75Hq72hLrUB7viEuLE1qr9EHlv+k02tqOUr3TbFhzy3DyhFofB149KpN6ERs3jekfFd/x2y8w/8qGDPfNK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=QUIud+EN; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=rYs16LMDXSBKD16sAOH3Kuiy41oWYZJcg08wjQC6+CU=;
	t=1718176026; x=1719385626; b=QUIud+ENh1B48hQH1hi4ATBi01siQW0cZzXXArwOziPPBxz
	9PyWzZV9h7lP4N+v/HqRD1rNQNoLmTFhZnrMX9v6beJMJhBKo0OuvVdIRO4C+DYSLimv9Giu4KADI
	rX8ynrcbuPUsy4W/2OYR7eGD0BHeAk8t/ZqhAiod3RuG93mT+MciJsnyBG5yig9BjwZmfJmEc9q4T
	JcFoDqQDhsSFnB/PThru3neZwAnEo9oa3Z5u++X8igdFcvQXCDcn3M/XgCKQ7F/n08YTK3wqebGZn
	5kU3nNIWbb/DMxkisvW3R3J/ABVDPGGdegTxb2D65hpWQNfpvmxLBchozaRr0IbA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sHI4T-00000009z6w-0LTv;
	Wed, 12 Jun 2024 09:07:01 +0200
Message-ID: <6a88e0d3e47ebbd1f0f383094e4804a627c41870.camel@sipsolutions.net>
Subject: Re: [REGRESSION][BISECTED] wifi: RTL8821CE does not work in monitor
 mode
From: Johannes Berg <johannes@sipsolutions.net>
To: Ping-Ke Shih <pkshih@realtek.com>, Thorsten Leemhuis
	 <regressions@leemhuis.info>, Savyasaachi Vanga <savyasaachiv@gmail.com>, 
 Christian Heusel <christian@heusel.eu>
Cc: Kalle Valo <kvalo@kernel.org>, "linux-wireless@vger.kernel.org"
	 <linux-wireless@vger.kernel.org>, "regressions@lists.linux.dev"
	 <regressions@lists.linux.dev>
Date: Wed, 12 Jun 2024 09:07:00 +0200
In-Reply-To: <5318640d6eb74301b1fbf6d9385ba69e@realtek.com>
References: 
	<chwoymvpzwtbmzryrlitpwmta5j6mtndocxsyqvdyikqu63lon@gfds653hkknl>
	 <a51f223f-18ac-4d67-9120-8da1c169b7eb@leemhuis.info>
	 <809d2332-625e-4a46-a77e-ca2e49b0d651@leemhuis.info>
	 <0e65ca6b471b4186a370b9a57de11abe@realtek.com>
	 <36c1f49acfcc2cc16c7e54ffeb76f1e93cb96e91.camel@sipsolutions.net>
	 <5318640d6eb74301b1fbf6d9385ba69e@realtek.com>
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

On Wed, 2024-06-12 at 00:56 +0000, Ping-Ke Shih wrote:


> > Just got pinged (sp?) about this, can you share the driver fix so I can
> > take a look what the issue is about?
> >=20
>=20
> Please reference patch below. I copy this idea from rtw89 [1], which the =
main
> stuff is to add WANT_MONITOR_VIF and case NL80211_IFTYPE_MONITOR in add_i=
nterface().=20

Ah, OK, but that gives me a hint. Yes, I see the issue now.

OK it's not trivial and it might leave ath12k still not working (though
not sure it ever did before? or maybe I'm missing something...), but I
think I can fix this. Let's see.

johannes

