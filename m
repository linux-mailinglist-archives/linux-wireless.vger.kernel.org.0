Return-Path: <linux-wireless+bounces-6081-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 84F0089EE31
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Apr 2024 11:09:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38A981F22316
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Apr 2024 09:09:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08ADF1552E8;
	Wed, 10 Apr 2024 09:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="oHzgxTEo"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC98119BA6
	for <linux-wireless@vger.kernel.org>; Wed, 10 Apr 2024 09:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712740168; cv=none; b=jG0+KgE5z7aLkKfC1tZup8SRgZYEDS3Ff2vVpuyLFcyvW4mI0vDfrs3RVQ1vZHOSzEVcdvvqtijs3iqTQJqgY4p8e1iiyly4cspcc6quwJDePzg0A+J9/RnAHzNJHsAC9G27xYAit9azp49+iqQaGCqZFLIuNZL82XFrXasXTAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712740168; c=relaxed/simple;
	bh=z+mS3LjXAeboYKWMVRHAKrLgD1CfxzElUCTBdIJEHcc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oZePmI23D4I5NzW4EX6RiydMurLeOz/ErUqMRh8Y7C5USupZZAJBaL/EEU3vMdQM0LSJpuSqYIIMTqHVri9pKxQxPM6KJ49itStdBwduoJwGLjRqgAI8ch2Lh22rwfpkNi4f7kqIB4N3O2ToyDUHkaA8F1k4NgguS9e4YX8ypIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=oHzgxTEo; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=z+mS3LjXAeboYKWMVRHAKrLgD1CfxzElUCTBdIJEHcc=;
	t=1712740166; x=1713949766; b=oHzgxTEojMpdI3U5IkFG2biHC7Du5PhsCP2G2XipmUVKcup
	zwMchroz6oomnMmVYGEmHBmTs1D8UQFW18nGN7Piti+HCJ7BJqu5DC/TJRTvmtAHifUQTCebwvbrh
	BfyikhcGdW9JdG2l2fbK38HXVQAVfeuQ+NKXdECr0et+g2W0BaDgg5VRanCCchkt9N1oC6U7hPm7y
	reoGdEOjjej1MDlIStxd950Y/J+9wrrMBDSXcERm2oCVPlYw5fx9Hu5Q2SJY2Xc/783Gxi6hvFWsD
	kvVst+pUrMAlFO5shTYhiCqv0m7t5K7lvmMp68Y6t3SBxjqBSIXT7SHOgBbaQ85g==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1ruTxL-00000001HKq-2CJA;
	Wed, 10 Apr 2024 11:09:23 +0200
Message-ID: <c2160c4616ef520d7037f9b7606b47d366f02dd6.camel@sipsolutions.net>
Subject: Re: [PATCH 01/13] wifi: cfg80211: Add provision to advertise
 multiple radio in one wiphy
From: Johannes Berg <johannes@sipsolutions.net>
To: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>, 
	ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org, Vasanthakumar Thiagarajan
	 <quic_vthiagar@quicinc.com>
Date: Wed, 10 Apr 2024 11:09:22 +0200
In-Reply-To: <d2e6360b-1092-4e57-47e6-c5f336f32c92@quicinc.com>
References: <20240328072916.1164195-1-quic_periyasa@quicinc.com>
	 <20240328072916.1164195-2-quic_periyasa@quicinc.com>
	 <e36599d3269496de59505b36be46f873976f8706.camel@sipsolutions.net>
	 <d2e6360b-1092-4e57-47e6-c5f336f32c92@quicinc.com>
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

On Wed, 2024-04-10 at 14:38 +0530, Karthikeyan Periyasamy wrote:
>=20
> On 3/28/2024 1:16 PM, Johannes Berg wrote:
> > That's a big set, not sure I can review it all at once :)
> >=20
>=20
> I plan to separate the code refactoring changes from this patchset. Do=
=20
> you have any concerns?
>=20
If you split it up? I don't see why.

johannes

