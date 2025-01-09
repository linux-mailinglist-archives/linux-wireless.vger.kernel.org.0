Return-Path: <linux-wireless+bounces-17247-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96F17A07C0E
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Jan 2025 16:32:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63C2718815DC
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Jan 2025 15:32:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68DD1249E5;
	Thu,  9 Jan 2025 15:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="b5BY0vFa"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E04821764D
	for <linux-wireless@vger.kernel.org>; Thu,  9 Jan 2025 15:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736436773; cv=none; b=mREsRY759OXxsCXK9sPd/nDmn1JY54sYFeTw8wbI2L/f/XA3rby6A+UToOagwAcpuRrO2TAaiLHtn7ueOZ9BFcrZwWtxdqFR/e6Bn2eQqIe1JW0tPuFzXJFtOqyDnloIwQWoowpLGU6IvHAWkUJXLazoXwaCXQd9UPrRUyVAszk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736436773; c=relaxed/simple;
	bh=I0getgo+dd1dIJsEMlFONveKqdjr0BQFHiqPRJUjlD8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ag37WJSOYL6jkc+NH2Xk+MLiuVohZ4kFlqSyY6ktGhjGcxNCjH0+igjtoPMuSsJQlh6xMD1KNsUmGrHP9mB1GByw1n3qATlNcMjnWw/GBgV0yNMUYS6AX2rd966r7Jwp19yikfyx4cAXjRKlcZ50p/AoervgeD/6wJNLiIgzQGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=b5BY0vFa; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=I0getgo+dd1dIJsEMlFONveKqdjr0BQFHiqPRJUjlD8=;
	t=1736436771; x=1737646371; b=b5BY0vFabFeGhLNK3OOZTKCbfrMcZ9ZEjJsJCvu7IaRwzzX
	tqCozXtspJvej+4EofUo4Uw8g16y+F5Ai9Twq7142R2H9dVB/t3tuEXFcJyACCMW5iPmBvM+X6TVY
	U+X54HBwv3j4Q5UpbjguMDWejaQcA7Ua1TofhSHJLN8tFn638sSotgZm6uXZqrzl/an7ygTJwAjhd
	pwtnhA4rRxImUpXtFMBRQ2BW6VVcU1ubFPlczrH87lgXrlCrS2Kfuza5W201pBsqIGOcGa6WT0gnL
	hP2JiD6vA8DYJfcq0g70CHD8epKm17ty/Rf3Ar7jUUzff6PPk/D+qQgbYmRF3m0g==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1tVuWZ-00000009Us6-0feY;
	Thu, 09 Jan 2025 16:32:43 +0100
Message-ID: <5963653d3de8e9e9a8cc3bcef271caa575e26052.camel@sipsolutions.net>
Subject: Re: [PATCH v3 1/2] wifi: cfg80211: define and use wiphy guard
From: Johannes Berg <johannes@sipsolutions.net>
To: mbizon@freebox.fr, linux-wireless@vger.kernel.org
Cc: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Thu, 09 Jan 2025 16:32:42 +0100
In-Reply-To: <380c254f0b2f19fb185ec0e89f4c321802a0455f.camel@freebox.fr>
References: 
	<20241122094225.88765cbaab65.I610c9b14f36902e75e1d13f0db29f8bef2298804@changeid>
	 <380c254f0b2f19fb185ec0e89f4c321802a0455f.camel@freebox.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.2 (3.54.2-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Thu, 2025-01-09 at 15:42 +0100, Maxime Bizon wrote:
> >=20
> > -unlock:
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0wiphy_unlock(wiphy);
> > =C2=A0
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return err;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return 0;
> > =C2=A0}
> > =C2=A0
>=20
> This hunk is incorrect, any error from last called function
> rdev_start_radar_detection() is no longer propagated.
>=20

Good point. Want to send a fix?

johannes

