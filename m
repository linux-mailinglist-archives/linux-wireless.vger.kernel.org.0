Return-Path: <linux-wireless+bounces-26630-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA567B35E0A
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Aug 2025 13:51:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AA8E3A63A6
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Aug 2025 11:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B77E1283FDF;
	Tue, 26 Aug 2025 11:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="RcqgSMxX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C5A3285CA9
	for <linux-wireless@vger.kernel.org>; Tue, 26 Aug 2025 11:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756208996; cv=none; b=D4/mfMh/G7Acn+1uLmSOJA+IHsR/K/xVnJGp0Kj0sdhWDODjuMe4VE5kiO57kt9zUHFE7NrYxaJCO5LhfgTlX4bUZNZi1tkh8eZMA/GwFy77P3Vdd8+3kHiBXUNAHvmFiq6Xq2Ubv+5wyMttejpiuSkd+aXFoUgPYWKmqH77AHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756208996; c=relaxed/simple;
	bh=Er2kVmbQlx5pzj5cb2Ho+SDL4DXCfvohnUvguQxoEPQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=E0WRpbb1B4FA7Zmqyqu6VENRftixG+P5QAlSXJmmas9nbo7/ldDrr/3IYKuol/IQPOoLA0uKPjmp7tyh5tgpXe+1j+40XqSQe/ep2PgyPoHhSs7wvTiuUd4UkDYHZIR1p0NbnFCrciaeJr2AKcuact+VYJEQwvg1ps4YAblOU50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=RcqgSMxX; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=Er2kVmbQlx5pzj5cb2Ho+SDL4DXCfvohnUvguQxoEPQ=;
	t=1756208995; x=1757418595; b=RcqgSMxXu5EGSicXNqBJLKMMrgFO8EPmpmDXQP3JNpTGRgS
	aURi3oJo63mIgjWNJJzMHjCmEcT0y8WCvi0b72lMfLg1fEsFdJWCDimdA5m5lu02DPXMmK1abKtGR
	itbcon6YWer3EWPi8JpDgX2i4m4kE6IATOqYDJvlAHe0YIncNMPHr4CuT0oFQYjPsgL6VsnWID+93
	SyNN5qrIsUBlQN9aQHC5qlput9lPVW6mf/qBo4B+IeJhLm6RWZ9e9wCngtBYRCJoeFY3/X94IZdAn
	p95Phm/NMlPt50DLs+eQUkJixPJ8J+oPuKz6tiRgwK7sbu8wqHLaYQGWIzdgP6XQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uqsBU-00000003afv-1zPO;
	Tue, 26 Aug 2025 13:49:52 +0200
Message-ID: <b813a59f1e1e6b38517a12f3c0c4e512c07ebefb.camel@sipsolutions.net>
Subject: Re: [PATCH wireless v3] wifi: mac80211: increase scan_ies_len for
 S1G
From: Johannes Berg <johannes@sipsolutions.net>
To: Lachlan Hodges <lachlan.hodges@morsemicro.com>
Cc: linux-wireless@vger.kernel.org, arien.judge@morsemicro.com
Date: Tue, 26 Aug 2025 13:49:51 +0200
In-Reply-To: <20250826085437.3493-1-lachlan.hodges@morsemicro.com> (sfid-20250826_105515_346282_6B119689)
References: <20250826085437.3493-1-lachlan.hodges@morsemicro.com>
	 (sfid-20250826_105515_346282_6B119689)
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

On Tue, 2025-08-26 at 18:54 +1000, Lachlan Hodges wrote:
> Currently the S1G capability element is not taken into account
> for the scan_ies_len, which leads to a buffer length validation
> failure in ieee80211_prep_hw_scan() and subsequent WARN in
> __ieee80211_start_scan(). This prevents hw scanning from functioning.
> To fix ensure we accommodate for the S1G capability length.
>=20
> Signed-off-by: Lachlan Hodges <lachlan.hodges@morsemicro.com>
> ---
> v2 -> v3: don't include kernel test robot for a new patch...
>=20
> Again, targetted wireless.. but not really sure if this qualifies
> as a "bug"... I gave my reasoning in the reply to the first patch:
>=20
> https://lore.kernel.org/linux-wireless/3j7kkqznavkxt23iopacl626xkppzcitia=
ctxz43axqorucrvu@6gaixffy7zaj/

I'm happy with it to go to wireless, and will just do that at this
stage, but I'm also curious how it would matter at all there?

The only driver with S1G right now is hwsim, I believe, which always has
also other bands and HT/VHT/etc., so wouldn't it allocate more than
enough space anyway?

Feels like you should only be able to run into this with a driver that
only has S1G, and no such driver exists upstream? Or am I confused?

johannes

