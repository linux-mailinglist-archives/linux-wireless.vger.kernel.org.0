Return-Path: <linux-wireless+bounces-4589-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B94EF878F88
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Mar 2024 09:16:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9FB61C21697
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Mar 2024 08:16:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BC7969D00;
	Tue, 12 Mar 2024 08:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="bf87jEAB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87CA369D11
	for <linux-wireless@vger.kernel.org>; Tue, 12 Mar 2024 08:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710231401; cv=none; b=rCpkki1pgrkcXfZUn3zDn20ndD7C+58KDynJAqS4HN8QhAuwZnReLofN9mt5FjTv7MaZl+46Cgo3W0/A6bYLnAZWyKQvl29OI1oda44z7a1Ja1Awyp6CYcTeU/NmkhNsQanu14gZBQT9qFUQQ9hcUcW+D0Eq72qpRUNa56Wjyjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710231401; c=relaxed/simple;
	bh=ihz++E9B6/8HRGfur9tdMnVj2qTl+gPGQxmLPwTE2Ko=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FOaxcX07JGhcRLN6+s35spXj2/Wwo7KAL56pxnF+G7Xg0KktYBbnihnMSFNt+cFJ+O4jvyNxI4FHSb2EllvLt2ozMxXcycX2XD7XxJciNV1YWHzh5eH/gAPxt2/1AK1Gx1b9HcmmtikQxUAERo/HjMr/tvPC8Wf4FX35vWUZmN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=bf87jEAB; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=ihz++E9B6/8HRGfur9tdMnVj2qTl+gPGQxmLPwTE2Ko=;
	t=1710231398; x=1711440998; b=bf87jEABK0Eu4wwNmCXHJkEJ9Dtg7rcbnA1Dm9ZzyV+Wb6b
	brlk6PNBrzJvElymjCmtHwcyVh4lKhUxBEITMK4kSy5eunwohTtUoKeIcpgwapkiI5ZxPA+5faUGT
	cXdsNMiQ3QhSlqDF2R1JVpGM1Aqcm3WLPbl2OkAlmr16tiVheiWW4lbJVpMMJUD05KomagfeNXQgv
	0Dmvc+ZJ3mF5+PB29vWWplft8THEd1BaI0ZUbFqau34lLKAqKwYt71CDOnOWq21Eux/uj/5xLRn42
	71rAPmxFLP+uiqJarS7nlIjMEJDbnczYPE/MKFFKBA0ARkOEpBZzSUDSqvTy0Y0g==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rjxJE-0000000DjWz-1qLP;
	Tue, 12 Mar 2024 09:16:28 +0100
Message-ID: <8cc7e7f7b2914385b481ecfdd7bc3f67fc4546b3.camel@sipsolutions.net>
Subject: Re: [PATCH 1/2] wifi: mac80211: supplement parsing of puncturing
 bitmap
From: Johannes Berg <johannes@sipsolutions.net>
To: Kang Yang <quic_kangyang@quicinc.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
Date: Tue, 12 Mar 2024 09:16:27 +0100
In-Reply-To: <20240312045947.576231-2-quic_kangyang@quicinc.com>
References: <20240312045947.576231-1-quic_kangyang@quicinc.com>
	 <20240312045947.576231-2-quic_kangyang@quicinc.com>
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

On Tue, 2024-03-12 at 12:59 +0800, Kang Yang wrote:
> Current mac80211 won't parsing puncturing bitmap when process EHT
> Operation element in 6 GHz band or Bandwidth Indication element. This
> leads to puncturing bitmap cannot be updated in related situations, such
> as connecting to an EHT AP in 6 GHz band.
>=20
> So supplement parsing of puncturing bitmap for these elements.

Hah, yes, I just noticed that too and fixed the second part yesterday,
and was still thinking about how I could test the first part :-)

johannes


