Return-Path: <linux-wireless+bounces-11733-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70FF0959885
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Aug 2024 12:54:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04B44281A69
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Aug 2024 10:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CC311E46B9;
	Wed, 21 Aug 2024 09:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="dhrMCT3T"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39CEC1E3899;
	Wed, 21 Aug 2024 09:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724231527; cv=none; b=rQ83jJlZjwjUCQo+/7qC1AE7R+KORtTWObVULhKTmAcCFYMGlu4qriskv+HycgU/472NBKm39QqPZ4ihEskqWP58jka7jFO+WOQ6ei2FDhKO8jctXbJ4YpnKvsJ3Abti2tIBOVE2cLIjWxUI/cY+jf3cvK7gE1aPBFcYoiSuEhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724231527; c=relaxed/simple;
	bh=Ynw4Gbum5nKlrqSeuif2kCZleeSEUWKHxDtAXiKIyRY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dvOPjqEDbZ92sJR7FmxWJtehKwXdFHRi6TZwQreAT+RXiq24H/mtOFS5idbVusgtcMc4QKboLRSHJMwfASVvSwFycC0iCdLZ7NS3X89OVUW+7fftA/WyJBmBM0q97/HjrtVxlXn96PN7VTkm9kvOpB2NJe1Mml9fn0peaJw24/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=dhrMCT3T; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=Ynw4Gbum5nKlrqSeuif2kCZleeSEUWKHxDtAXiKIyRY=;
	t=1724231479; x=1725441079; b=dhrMCT3TuHy2TDLoVjSnImkwpC6PwY4EFibPyVE7WMuCXBw
	WiD/rdLY5AKgmfah2UKZtPjjmLpLXlch3TWLZwUA345GZvvSCKm0Nc5bx87E6TXjNl72nR08JLf1W
	jyELFzZ0co0nah+xqUmULS+Nha1sto89geUU0yoJMcsXXpQQfnbALMudjTpj+a7C2qT/vYwWyemoI
	62Y03DUW6nfbj/EOJeYDyDBlUtosPZFwQGytzORYdn8ze48If9YAkYKFZS3SuD4N70kpuC9vcDM4Q
	qBVYkcnlLbhA/SvSbyYfaH6BJFfEvnVAj2OQUWUZBhM1BCPa9wj3L5OxrAxwHrzQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sghMJ-0000000AdXP-1pqe;
	Wed, 21 Aug 2024 11:10:27 +0200
Message-ID: <9a757e2c6766b85e8cc4c59a58521c4d3e6afadd.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next v2] wifi: cfg80211: fix bug of mapping
 AF3x to  incorrect User Priority
From: Johannes Berg <johannes@sipsolutions.net>
To: hhorace <hhoracehsu@gmail.com>, gnault@redhat.com
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com,  linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
  linux-kernel@vger.kernel.org, kvalo@kernel.org, horms@kernel.org, 
 idosch@nvidia.com
Date: Wed, 21 Aug 2024 11:10:26 +0200
In-Reply-To: <20240807082205.1369-1-hhoracehsu@gmail.com>
References: <20240805071743.2112-1-hhoracehsu@gmail.com>
	 <20240807082205.1369-1-hhoracehsu@gmail.com>
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

On Wed, 2024-08-07 at 16:22 +0800, hhorace wrote:
> According to RFC8325 4.3, Multimedia Streaming: AF31(011010, 26),
> AF32(011100, 28), AF33(011110, 30) maps to User Priority =3D 4
> and AC_VI (Video).
>=20
> However, the original code remain the default three Most Significant
> Bits (MSBs) of the DSCP, which makes AF3x map to User Priority =3D 3
> and AC_BE (Best Effort).
>=20
> Fixes: 6fdb8b8781d5 ("wifi: cfg80211: Update the default DSCP-to-UP mappi=
ng")
> Signed-off-by: hhorace <hhoracehsu@gmail.com>

^^^ looks more like a username, is that really your name/"known
identity"?

https://www.kernel.org/doc/html/latest/process/submitting-patches.html#sign=
-your-work-the-developer-s-certificate-of-origin

johannes


