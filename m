Return-Path: <linux-wireless+bounces-28272-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EC30C09E6B
	for <lists+linux-wireless@lfdr.de>; Sat, 25 Oct 2025 20:36:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB6EB3B76CC
	for <lists+linux-wireless@lfdr.de>; Sat, 25 Oct 2025 18:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6114B301035;
	Sat, 25 Oct 2025 18:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="mAg6/cV5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C448B18E1F;
	Sat, 25 Oct 2025 18:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761417376; cv=none; b=smHt/fMr+/HdVMnu96NEftM/f4VTNybyquKV+SySjE0eexpqIwzluakiAGF3Dn/6dTS/SsW2IXfGJW90SFxHt//jpEKNpTHqeiA6iY6gF3pNQMs/AgR4vPJUSTaZkkxz1bebTS1c7eLQMwnsnkVJpwg4wr4X/urOxQsgIZW1r/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761417376; c=relaxed/simple;
	bh=KODcySrExIg6wn2VGbfIskPdYJpjyaZmt8a+ivqWlFs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AMiFJ3sAZeFl6EI74IpzIFf6gis9tSt0oixaKRr4S+jiHm7TOEcF0FGcrhkh2UmFX+LQRSJ501oCuAloSwEmXfflGeY5JDWEYPj5ybvo5CLbB5Aq4O/c9FnAErjxQ8gB3uPMN6tPDMWrFZONUrnziWYdSpeP9orc5+yuWBjF50Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=mAg6/cV5; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=KODcySrExIg6wn2VGbfIskPdYJpjyaZmt8a+ivqWlFs=;
	t=1761417374; x=1762626974; b=mAg6/cV5VaAtt+euND5YrR05qJoILWMNkYoITYfkZWQ2ZqZ
	na866l+lrjVHGCSfQXwsiJPMGsC3eRhSoa8hhbBk8I/CXLLlY0trv4RpDwTuLjidVpcGVuMsnLy/2
	VViCiAwNHjzMOIh07grHx9205Ftfanbf5wWh087z/qA5C2YKaBpt4oNHrFN08G1ohSEHABN10s09M
	aahasaXaosLnsau7HbNTKHLxmXCSryajvVxxl4iQhUvOMP8pfUZ9PNZjb6cq8IXdM982ATHAtcKrt
	r9fp2XA4D/ALRSzf3CTa/M9tsKAGN8lcyi9DepGM6mcJqKrmOad5PPSH4TRHMTUA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vCj7V-00000005omn-3R2n;
	Sat, 25 Oct 2025 20:36:06 +0200
Message-ID: <72966d6ccecfcf51f741ca8243e446a0aaa9b5c1.camel@sipsolutions.net>
Subject: Re: [PATCH AUTOSEL 6.17-6.12] wifi: mac80211: support parsing S1G
 TIM PVB
From: Johannes Berg <johannes@sipsolutions.net>
To: Sasha Levin <sashal@kernel.org>, patches@lists.linux.dev, 
	stable@vger.kernel.org
Cc: Lachlan Hodges <lachlan.hodges@morsemicro.com>, Arien Judge	
 <arien.judge@morsemicro.com>, chunkeey@googlemail.com, pkshih@realtek.com, 
	alexander.deucher@amd.com, alexandre.f.demers@gmail.com,
 tglx@linutronix.de, 	namcao@linutronix.de, bhelgaas@google.com,
 linux-wireless@vger.kernel.org
Date: Sat, 25 Oct 2025 20:36:04 +0200
In-Reply-To: <20251025160905.3857885-99-sashal@kernel.org>
References: <20251025160905.3857885-1-sashal@kernel.org>
	 <20251025160905.3857885-99-sashal@kernel.org>
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

On Sat, 2025-10-25 at 11:55 -0400, Sasha Levin wrote:
>=20
> LLM Generated explanations, may be completely bogus:
>=20
> YES
>=20
> - Fixes a real functional gap for S1G (802.11ah):

I guess, but ... there's no real driver for this, only hwsim, so there
isn't really all that much point.

johannes

