Return-Path: <linux-wireless+bounces-15747-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18D229DA478
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Nov 2024 10:06:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9914DB2316F
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Nov 2024 09:06:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E323190470;
	Wed, 27 Nov 2024 09:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="O3/1brLO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C06FD1891B2;
	Wed, 27 Nov 2024 09:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732698391; cv=none; b=E/GYWffoI5SePUNrLVpRYD7aWKHiqwhipJ5Du3er07kZYEbHSpPGL644X756yr+vsJ2hWVRsJdGFyyF7ZgC6r07WGA6qWUEzSvA7lectXil6WqBOayOIf7seu8XIu7fuj9eZBkIxS/A9FGPyyBoxDbMdpB1RIFNYf1gFXjCe7Rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732698391; c=relaxed/simple;
	bh=wg4nGisT0ebEQftfFVY4gvb3jWyAAg8FS55l08gOQIA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=stlomJDE9JNpz3VLJ78EN2pfoZuZ62115in6m+fVGAuj60IqtT0r6ihGBp7CZQ7eQElrTvciGlxXcqdEGOuIZo2py4JHZLWBpEWMiaVac53UPPCrWy7Hucp1xvPiSPiqyVXnvrzPVaQcyVVcQBP2TwgfOsIUmb0IRTmSB6bQchc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=O3/1brLO; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1732698365; x=1733303165; i=markus.elfring@web.de;
	bh=r2N93lXlkkWmnK3QygTnOg7BE1lU6KCWvJYDtF78mQU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=O3/1brLODTDDwNzbukpTD33n5fgI9xMf8dXNgVSljawzRpd4vk+DR4ULEHVEAnyc
	 1K56PtvWD1QmXziLcE2x/uawTINAYmmodzOCy8m639NrPXs3KIx+THcryL+FNt2aP
	 KgGHFzTekmd5wFJcfvWhgRIJA+oDv7D3NDCs3S2k/ygRdmUZOm1JR8l1W0y4HfhBK
	 0VoozSHNTtdgo7e60CRpTHiPU/x0Sxo+A34uPhbI+8dGudlm4oihMXUTYmwb15L+h
	 g3Etxnq084K8vddaeGwXSl8PnvlZxrllqV+BMyNg3HDIlHsJ93NC917UVy1KsfxvC
	 4C4YM42EmkC4IgU3lQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.91.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MT7aP-1t8A9j3mRz-00UQDP; Wed, 27
 Nov 2024 10:06:04 +0100
Message-ID: <a77fe99d-079b-4ef3-a1ce-6aea10256860@web.de>
Date: Wed, 27 Nov 2024 10:05:51 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4?] wifi: ath11k: Fix NULL pointer check in
 ath11k_ce_rx_post_pipe()
To: Baichuan Qi <zghbqbc@gmail.com>, ath11k@lists.infradead.org,
 linux-wireless@vger.kernel.org, Kalle Valo <kvalo@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Jeff Johnson <jjohnson@kernel.org>
References: <a9ccc947-20b2-4322-84e5-c96aaa604e63@web.de>
 <20241127033241.60478-1-zghbqbc@gmail.com>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20241127033241.60478-1-zghbqbc@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ZCgGeWswJhW4qQl74iKNQqJJsw3uVk6d6t2h0sBzF1JJbAf7EfF
 CKyNdwyRYFEtZBlR9tB30prKCqhEf0mppZXgepJHTirdA0k6IlnRltNUoueVyLQ/rovSqFv
 VGsg/rAob0P642Bel9DBGlS4t+c4n+eKY/GRIG7Gu+n5dZKb/aD62befocNMV5RB916abVJ
 6g0sAtU7b49OCMm5n8rDA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:8RNY/ZCRYK4=;H+R6xGo8OAVw+2fkqDaS6mMHccv
 n7CfkWqidCE697R4smazxW3hprt/iCth6rNITrVuLhnfjBWbH8Tiq/My94oQnUxDaTnPg5H2n
 kPsc+d3D4QWZbSgAJju+pVxNMVaeCkLBwmh6LPl9/dED+9D90H8EpdP5XzlDTIGu7CbXW2pln
 Ly4Q1kkVY80lKJR897e6hivuQerNxg4K42CXFKqew428gP1H/R62ZYPujp9oqzjjhbmkKHVuL
 fjk+V9FhaZ/bjewWNeosSsKUaYYzSlYZ8dQfuZIF0dKMRBaryl6VSkCvT/q5mSQDdmn40f9ix
 0Mx1HEgA0H2a4EdK2z6+z6n80X7ahYr+1EbWZ74sISXb5D1BoNE/KaZqE4sRcLsMrGewOo85K
 H53ayriDILFhx82RtpkZRrhLVOlHI/qtGQS5w859GvDYXr72ODmt02ZpwDPDbOMFBB3fDo+mu
 PdO4xs3Gfq8mbkjGiu6HznqEP6IXcrEFHPWW00Q4yrjwO0wa+h9LFh4xHgKe2S2gt1ieOIe7c
 POBc2w2iPO20oZbPQGpwpJTx0wx2MSgNsjxXvVkaXYgIXaD4BC4uBEpx60NLDdJR2GyS0q40k
 o0s+FJtGm4MRS3AZcHA8QY67kLFQNMMtFPTB2e379Zc/JERHsGwJ/e6PRx2yoefJHv4cAA8+X
 p3r2pOdRy6/oQVg8NJEhfDAnaSo13rsYNbepQCsqrajqu4bqkEN+SAookz2MsFlCintg2qgRZ
 3UOt3GAXwPuyHgCzKfqO4JV9h5MdXHmSlF+pENS1EwFp9aCuQMcCbORYJiOOiQKnza+9vY7HO
 sAdrB26XKdCQJVl+CTc0wc+XbYpwgXnHD5T4UQ1upSnx8XBnizoXNU4y9h0SlJcKzdC7dsoUO
 prKh8ijN+At6SdmFZ5ToKPAZADxAtX3H5sDLdez0UhL4lPcOkLK9QQeYT

> This patch fixes the NON-NULL check by =E2=80=A6

> ---
>  drivers/net/wireless/ath/ath11k/ce.c | 2 +-
=E2=80=A6

Did you overlook any guidance once more?

See also:
* https://lore.kernel.org/all/?q=3D%22This+looks+like+a+new+version+of+a+p=
reviously+submitted+patch%22

* https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/=
Documentation/process/submitting-patches.rst?h=3Dv6.12#n94


Regards,
Markus

