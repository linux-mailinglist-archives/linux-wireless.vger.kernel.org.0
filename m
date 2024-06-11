Return-Path: <linux-wireless+bounces-8801-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 942FF903FF2
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Jun 2024 17:25:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B2DA1F249CD
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Jun 2024 15:25:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61222219E7;
	Tue, 11 Jun 2024 15:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="q3+ty+pK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3328922331;
	Tue, 11 Jun 2024 15:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718119512; cv=none; b=qFrM+M3M+jnqiFn/SXtbLOq5VLW4hZhItfeYWAmxwsCswwoBWzS1kggcvNdCU6suHKfIbCeCWTPfzMCdojC/P5ttUp6ql+k6SqkmsMfbtx+Bd0muVYfm3pE5lJZBswMEwyuJI8GDCZeFZJ6MaFKZpJzf2y1N/tbuvNrwcq69fCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718119512; c=relaxed/simple;
	bh=pAIkbdwT70pIhtqP9qyqumKcblrj+UGC2VwGWbBjQMY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=P4dG3eNpj6/VnuYh1EwfQwyK8gyfgYfKbMeafV1giiEIWxYtJwZHLV9ZvJJrkuCinK4ffGJbydYNd3dmTG7TRnYNlJ4KsPJGEkvUFeyTtUiTNg7+3M3vVx2njrxk+uJUoTRlFfIh6K/lztS9JM8DBMQSSNEaluauyfKHhSiNi/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=q3+ty+pK; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=pAIkbdwT70pIhtqP9qyqumKcblrj+UGC2VwGWbBjQMY=;
	t=1718119510; x=1719329110; b=q3+ty+pK6cukDw1+6vjTONLD+fEyI3dpdenVlr2YCyLu8hz
	UiW64Uj54Ymb9pW3Gtqe+mKf209GBDnuWxyV9OmD81L0XS9HFCezJuSs/8CC8RhsSCPQWVyGy5ZQt
	aTYPnB1LhtflddtsRFns8oxoqOEOwlMoppHcjY9BftBoioOMsLcR8NRtTaedAbc6w7L0RJwvRAECo
	SK/Vd6BY6e8QtvsM7x4kceu+gp3pHgBj/XOfVVJHQCrimbSqOIH7w3xO4K0kbUYCLCNUjvVoekQjW
	AXouB1Fpu6BnF6qFjMKu/F/k4fJN9a+iMrspgsc/SsfaUhu0DBwP2osxogRda0tw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sH3Mv-00000008nJ6-2vKE;
	Tue, 11 Jun 2024 17:25:05 +0200
Message-ID: <36c1f49acfcc2cc16c7e54ffeb76f1e93cb96e91.camel@sipsolutions.net>
Subject: Re: [REGRESSION][BISECTED] wifi: RTL8821CE does not work in monitor
 mode
From: Johannes Berg <johannes@sipsolutions.net>
To: Ping-Ke Shih <pkshih@realtek.com>, Thorsten Leemhuis
	 <regressions@leemhuis.info>, Savyasaachi Vanga <savyasaachiv@gmail.com>, 
 Christian Heusel <christian@heusel.eu>
Cc: Kalle Valo <kvalo@kernel.org>, "linux-wireless@vger.kernel.org"
	 <linux-wireless@vger.kernel.org>, "regressions@lists.linux.dev"
	 <regressions@lists.linux.dev>
Date: Tue, 11 Jun 2024 17:25:04 +0200
In-Reply-To: <0e65ca6b471b4186a370b9a57de11abe@realtek.com>
References: 
	<chwoymvpzwtbmzryrlitpwmta5j6mtndocxsyqvdyikqu63lon@gfds653hkknl>
	 <a51f223f-18ac-4d67-9120-8da1c169b7eb@leemhuis.info>
	 <809d2332-625e-4a46-a77e-ca2e49b0d651@leemhuis.info>
	 <0e65ca6b471b4186a370b9a57de11abe@realtek.com>
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

On Mon, 2024-06-03 at 00:47 +0000, Ping-Ke Shih wrote:
>=20
>=20
> We have a draft fix of rtw88 driver for RTL8821CE, but as mentioned some =
drivers
> are affected, so I don't plan to send out the patch. Instead we are looki=
ng for
> the fix of cfg80211/mac80211.=20
>=20

Guess you didn't find it :)

Just got pinged (sp?) about this, can you share the driver fix so I can
take a look what the issue is about?

johannes

