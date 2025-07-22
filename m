Return-Path: <linux-wireless+bounces-25852-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F8ACB0D849
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Jul 2025 13:35:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C44401AA78B9
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Jul 2025 11:35:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60A372417EF;
	Tue, 22 Jul 2025 11:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="PrLMr+FP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD88E2DFF28
	for <linux-wireless@vger.kernel.org>; Tue, 22 Jul 2025 11:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753184116; cv=none; b=JDCHnEXCCsm5/BD+UHYF+qVF3WheR99D3FlCEPqMuLvGeOnr8HiQCTAxBhBF0QK9PZAJRZkSbSjToOfRq6oDvQ4t8R+zVqo7I3Kh4LOridwGWM7+2RM53CDCTfehNcoIvMD29si3cQVR76BD0LGt4CB4mMuKk83IAihEZC3PzRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753184116; c=relaxed/simple;
	bh=doSyj6HBDA7yaaA0nZG5xQPVagYrC0hS3TvqtqXzJPY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Qf9c7NwCPK9UNc0eIkk/IK+ukjS/oM38+NBexzFhbEwdQFUFM7Fs7a4pwW2ydwOxUw4ZSr+B/eWNNE4HAzXOWEKRaJZHRNKcvCJOF7sJJ1ZWXUIJShcYjyx0ZGP4NOwfTaSuHBeNFbVDfHCVeoMMF8Eb0saVVIAvSCVuWu7u0kA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=PrLMr+FP; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=doSyj6HBDA7yaaA0nZG5xQPVagYrC0hS3TvqtqXzJPY=;
	t=1753184114; x=1754393714; b=PrLMr+FPPt7t8KP7WkRoDQrD1oiJBHx+ic/3AMzIAtvVzCW
	R169yeq66V5C+nFn+aZCjnalvodmYPTIZu1JjLd5XJ41iTrxb+zP2wG1143Abj7KsqjTmQRP10+8U
	qwKtgm3UHeK3kVCMfTyUhUTpVNGVgRvbcXq0FoYHNeo1sSXFPmiw+ynpWycIUPrTxPRhfSJqqgaXa
	H+DSO9wAkjnr6QrKE7glhV6yJVuRpVQbaYqRwgC7Az0o16SfgB8NabXuLGYki2/Ez3L2+79/s854c
	S38qB62NFfbEoiaNjcCtJXt7ivPmFmWm8imv5U3CE1CGY82mJ3FaPGDoQaXpU7uA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1ueBH5-000000023WL-1Gdt;
	Tue, 22 Jul 2025 13:35:11 +0200
Message-ID: <c116cc5f1258693d67a28b9282da4cf8c94413f5.camel@sipsolutions.net>
Subject: Re: [wireless-next 0/2] wifi: support S1G TIM encoding
From: Johannes Berg <johannes@sipsolutions.net>
To: Lachlan Hodges <lachlan.hodges@morsemicro.com>
Cc: linux-wireless@vger.kernel.org, arien.judge@morsemicro.com
Date: Tue, 22 Jul 2025 13:35:10 +0200
In-Reply-To: <tx3gim4qbf6qmwd4u6kqspzu7n37cih42elgbnwedxogvpkxcn@vmzo7fiyrshw> (sfid-20250722_092312_540750_0DB38E5E)
References: <20250722071642.875875-1-lachlan.hodges@morsemicro.com>
	 <tx3gim4qbf6qmwd4u6kqspzu7n37cih42elgbnwedxogvpkxcn@vmzo7fiyrshw>
	 (sfid-20250722_092312_540750_0DB38E5E)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Tue, 2025-07-22 at 17:22 +1000, Lachlan Hodges wrote:
>=20
> Something I forgot to mention (my file didn't save ._.) is that I aim to =
get
> some S1G hwsim tests up and running soon as S1G is almost fully functiona=
l
> within mac80211 (1 maybe 2 more patchsets left) such that there is some
> standardised testing utilising hwsim.

After reviewing the bit twiddling code here a bit I'd like to point out
that perhaps some testing in kunit might also be useful. Not saying you
_must_ do that, but I've found that even for development it helps, and
we could drop examples from Annex L into it too.

johannes

