Return-Path: <linux-wireless+bounces-29824-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BD1CDCC4E76
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Dec 2025 19:33:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E0D423067328
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Dec 2025 18:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 264E823D2AB;
	Tue, 16 Dec 2025 18:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="TcaCSoG9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BDCB318149
	for <linux-wireless@vger.kernel.org>; Tue, 16 Dec 2025 18:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765909830; cv=none; b=KrD9x2neQyE+q5XcQWI8xwjpClvRF2yznbM8FyoWpBybI2p0++8No+C/8JYP44Y8C1OxSsBDhb91UNoTng7gPK6zVVkbqbymmEuRF+qGgtnWRGtvP+cuQvmms7K4ObWx57gdykj+nTRjoISCc5dxJJckFA30UQWrB4xPv4BWwDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765909830; c=relaxed/simple;
	bh=QafaFbETdf8Vkhtx9QiAKQetJl0uJuZaL4kqFUhcRLQ=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sm4uvQRQHRD9nR+RnSJeiKcBAnjk8i3NSuwaN+9nGwPv3nhoCED50mNBvDa4AhwtcexDHnWrRL8Sx6KYfA7LlbTsHowgJeNr9IwzJE7W8Vcc0VlVF66h+S5PemKqmJWbuPmoDvjbITo0TnDzykhpwOgltzL5VpWmk7oyNhVCIbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=TcaCSoG9; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=QafaFbETdf8Vkhtx9QiAKQetJl0uJuZaL4kqFUhcRLQ=;
	t=1765909828; x=1767119428; b=TcaCSoG9SbvUlfRyvU444vHX+ek/vZ6M4lKyB7W3GOR9H5d
	p6oN4bMGOEuSGTy0XYoTVlZ8G9rwB6vt2E8D9R/x2I1zvi4l9/Tk8RVrYTU4Qv8u+iNjr+kCASW3J
	gjez/SysMcRzgdiFnJHyApO5LLkOKjFwXITIk7aa+pFUIYTdj1Cv7bktYJuO/VLCskGus59bavKQ0
	QOc0uGLuzaASrEHN7I/TLn4Z4Omc5fPaKxbyv8Oa829PGiM1FGnMtlYkkFlptNFTSry3zhf8jhVUc
	O1FSo0+kHxrWLsXSvskhRYmJqOCF3OxaQHwU/0pyD9BIBYgdFcyO+fY4HfGv1zPQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vVZoX-0000000AfLk-0BXE;
	Tue, 16 Dec 2025 19:30:25 +0100
Message-ID: <26403d4d8db35e837ce1e56281ab739500183b17.camel@sipsolutions.net>
Subject: Re: [PATCH wireless 1/1] wifi: mac80211: do not use old MBSSID
 elements
From: Johannes Berg <johannes@sipsolutions.net>
To: Aloka Dixit <aloka.dixit@oss.qualcomm.com>, 
	linux-wireless@vger.kernel.org
Date: Tue, 16 Dec 2025 19:30:24 +0100
In-Reply-To: <2eacf101-3e4d-41a2-a45d-018bf0f134b5@oss.qualcomm.com>
References: <20251215174656.2866319-1-aloka.dixit@oss.qualcomm.com>
	 <20251215174656.2866319-2-aloka.dixit@oss.qualcomm.com>
	 <da89d1394d19915a389f19f8773a028956562a6c.camel@sipsolutions.net>
	 <2eacf101-3e4d-41a2-a45d-018bf0f134b5@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Tue, 2025-12-16 at 10:12 -0800, Aloka Dixit wrote:
> On 12/16/2025 1:32 AM, Johannes Berg wrote:
> > On Mon, 2025-12-15 at 09:46 -0800, Aloka Dixit wrote:
> > >=20
> > > Fixes: 2b3171c6fe0a ("mac80211: MBSSID beacon handling in AP...")
> >=20
> > I'll fix this, but please just literally copy the subject.
> >=20
[...]
>=20
> Adding complete commit title for the fixes tag was going beyond 65=20
> characters.
> Is that okay? I added '...' to avoid that.

Yeah, that's fine.

johannes

