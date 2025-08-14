Return-Path: <linux-wireless+bounces-26387-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F3FAAB269CD
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Aug 2025 16:43:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B929E1BC36BD
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Aug 2025 14:35:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 857B21C831A;
	Thu, 14 Aug 2025 14:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="DaYRtAmf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EADE13635E;
	Thu, 14 Aug 2025 14:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755182096; cv=none; b=Uc4sfn2X1CYXltROKVw4j8XgnMx6Ij63d9p5YCKzgQ29KJV/3BaZ+kCUSaT06LryPqTBjN8TS0e4LVfc2ZSgLNYdLxFPpuudguc/rETnRHOFkQjuKEus9/wKSz96IVuDDh2UYbCS4GLgdb6npoRI2vn22QnSBUbNUKQKpM4aljo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755182096; c=relaxed/simple;
	bh=gLPFzn9OolcrgPXYRJ7TVBHptwhq1Oeyd3JeBirZwuU=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=cMhlzzQhBTzYJ44qgPs/JrWOEAEM3gPnbmgx6WV7JRUjdxCiRqlI+I7fXQ/wiQYG5KuLJr3cutZuzOhFBSk3AcsK8BL0usfJe4b2mgXs6r9UoCDfsoXkl+w6gDquI5AyRHO2ebVR0SfV2JjKNVPYgeuq8hCVCZ8AG0RxlUZcU6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=DaYRtAmf; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1755182023; x=1755786823; i=markus.elfring@web.de;
	bh=gLPFzn9OolcrgPXYRJ7TVBHptwhq1Oeyd3JeBirZwuU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=DaYRtAmfz5dP/W50kg//YetP1AOBovJOvQh9aK3fxZyffOZ2bSGUFvrPRZAa6TFS
	 OExlO5e/ro2EUEcTo6wmsiA5E9o44ZxrLOojJMRRFx3/Cie+cvps8148GSc7ijIv0
	 wsaYKQLo82zVCiSUeKr/H77vprIQ8yW04FR16STPRySY1+QMcUzmryjhmV70kfkV0
	 j25jgd8hdb/BLWwgJvpaqpnw1d6nnqTHglIr7aVSIGSw3MFS3RDJPhbvICoDwolzK
	 6Vvwow1m5y3NOyWoQHx38UndRSSNu+h1LmOYSi79qxx2rx0kyb8MDw+klSXh4gtek
	 EikaLJPEsnQO0HvD4w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.92.224]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MXXN7-1v5QXA0ST9-00YWw9; Thu, 14
 Aug 2025 16:33:43 +0200
Message-ID: <486183c0-0086-4168-bc90-1df92bfbc1d3@web.de>
Date: Thu, 14 Aug 2025 16:33:40 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Qianfeng Rong <rongqianfeng@vivo.com>, linux-wireless@vger.kernel.org,
 Aditya Kumar Singh <quic_adisi@quicinc.com>,
 Avinash Patil <patila@marvell.com>, Bert Karwatzki <spasswolf@web.de>,
 Brian Norris <briannorris@chromium.org>, Cathy Luo <cluo@marvell.com>,
 Christophe Jaillet <christophe.jaillet@wanadoo.fr>,
 Francesco Dolcini <francesco@dolcini.it>,
 Jason Xing <kerneljasonxing@gmail.com>, Jinjie Ruan <ruanjinjie@huawei.com>,
 Johannes Berg <johannes.berg@intel.com>,
 "John W. Linville" <linville@tuxdriver.com>, Kalle Valo <kvalo@kernel.org>,
 Rameshkumar Sundaram <quic_ramess@quicinc.com>,
 Roopni Devanathan <quic_rdevanat@quicinc.com>,
 Sascha Hauer <s.hauer@pengutronix.de>, Thomas Gleixner <tglx@linutronix.de>,
 Xinmin Hu <huxm@marvell.com>
Cc: stable@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 Dan Carpenter <dan.carpenter@linaro.org>
References: <20250814131536.231945-1-rongqianfeng@vivo.com>
Subject: Re: [PATCH v2] wifi: mwifiex: use kcalloc to apply for chan_stats
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250814131536.231945-1-rongqianfeng@vivo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:TxP2DwNQDKpjzer7tcAWDwxXCi+dXQn5I1XtBkZoE4ctNclfz9m
 qCfQHonXP4nMyuQbpbkpj0Ai5YWLEz6brJ+D5ZzUsNPzu6WBbaMnT65+RcDM8UPRFGeqYCz
 ir/i0eNTFZk7x6ZWpAglBMWn/jyAvZGTfQgFpDntC3hdPBtGX19CVORjBbbXvRykwM+cVop
 Wp7tZpvL6UAMtTT8eomTw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:SOXsr76CAHQ=;xpbSp5k+UQJe9muxB89dpI6KxEl
 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

> Use kcalloc to allocate 'adapter->chan_stats' memory =E2=80=A6

I find the summary phrase and change description improvable.

Regards,
Markus

