Return-Path: <linux-wireless+bounces-6764-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 62E7A8B0674
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Apr 2024 11:52:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17FE31F21D41
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Apr 2024 09:52:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA469158DA1;
	Wed, 24 Apr 2024 09:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="Uo0UDld/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48E3F1581E0
	for <linux-wireless@vger.kernel.org>; Wed, 24 Apr 2024 09:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713952347; cv=none; b=Gg9jEvkC5eBR/fJAzNipO8EhNse1I2FJZSumDtZkOIDp8Zitq8PCzar0Gug2j6EM1+0KRPm2VvD7sVbkTTo3iYMh5+j8LnDQf0wvfpjwSITAkUrQFlHs9ppEHgA+q04Nq2RwfRak9HVl72WBW27FX/7HXLrMP1OsKXySDmXDRFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713952347; c=relaxed/simple;
	bh=KExW29pFg2U1j32PSnZKZGEMbN+QiSoNNAFNVkXT0sg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bN3yik9yCCdjR8UsmXDyEc+aCXJRL+HqVq5Owngk6b9rZCgd6xoiJlubiSydlRNYDfF51V82byDyODI5KHvx8u3CSK9LFpmfEV/RSavXZffLtN+5Pl3QlycDnxB5qTpHaT8UwsPLXsFTfjPX3Ts0Xqcu7ygBjCgoe7fLvyQThTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=Uo0UDld/; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=KExW29pFg2U1j32PSnZKZGEMbN+QiSoNNAFNVkXT0sg=;
	t=1713952346; x=1715161946; b=Uo0UDld/lDfDF2tqv2zd3IJ8+Hsxc1nxjJxphiekZf/seZj
	xL3wqM/A49HNbg3FkBtUe8N9YIJX+1VVgD1PjEOverA4ZRKuM0Jo9e1BGS4EtZHpHz+RLwxRX/iEX
	1/5acC36xWS6QHOayNKd6jxTao176o/erJpLwRJHm+o8ELtrR4hsFLMi7xkCLRtMrKoy9ov16Hdfz
	2S7xRYahWliMcVKIFM5swLLFCSGbxSbJXao6vA2UK9loHCIq8JJJegihloNq9QSV7/gMs5oIyhaPT
	9TlLtIOLAQx/Lb+Ka3C3Pk/adLLu2pHRxqhvlZhndgv7X06QVrZuP+alHmC6Jgwg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rzZId-00000003Us9-0tSA;
	Wed, 24 Apr 2024 11:52:23 +0200
Message-ID: <0bfbb5549b48296e6219488d47caccd10e818700.camel@sipsolutions.net>
Subject: Re: [PATCH v2 3/3] wifi: ath12k: Add lock to protect the hardware
 state
From: Johannes Berg <johannes@sipsolutions.net>
To: Kalle Valo <kvalo@kernel.org>
Cc: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>, 
	ath12k@lists.infradead.org, linux-wireless@vger.kernel.org
Date: Wed, 24 Apr 2024 11:52:22 +0200
In-Reply-To: <87edavt7h8.fsf@kernel.org>
References: <20240424065646.1666166-1-quic_periyasa@quicinc.com>
	 <20240424065646.1666166-4-quic_periyasa@quicinc.com>
	 <517caf852d37b3803bcf087a6b575f2ecdb5ba10.camel@sipsolutions.net>
	 <87il07t7zq.fsf@kernel.org>
	 <3dc4339f5c3f603027c2214058e7e3251652a7f0.camel@sipsolutions.net>
	 <87edavt7h8.fsf@kernel.org>
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

On Wed, 2024-04-24 at 12:50 +0300, Kalle Valo wrote:
> Johannes Berg <johannes@sipsolutions.net> writes:
>=20
> > On Wed, 2024-04-24 at 12:39 +0300, Kalle Valo wrote:
> > >=20
> > > Exactly. Swithing to use wiphy_lock() definitely one of my longterm
> > > goals in ath12k. I already started working on switching ath12k to use
> > > wiphy_lock() but IIRC I got blocked by not being able to call
> > > wiphy_delayed_work_cancel() without taking wiphy_lock.
> >=20
> > That's because I didn't want to have an async version, but theoreticall=
y
> > we could have a version of it that just cancels the timer. If you don't
> > hold the wiphy mutex already you could even wait for it to finish. It
> > just adds more complexity there, and I was trying to make it all a lot
> > more obvious :)
>=20
> Yeah, understandable. I think changing ath12k WMI event handling to use
> wiphy_work makes sense, running them in tasklet context feels overkill.

Maybe. Note that the wiphy lock _can_ create delays etc. here, if you're
doing other configuration work at the same time, or similar. Though I
guess eventually you need locking there anyway, to access the HW. So it
can be a bit of a trade-off.

I expect this will evolve over time even in mac80211, though so far we
haven't seen any bad effect from it.

johannes

