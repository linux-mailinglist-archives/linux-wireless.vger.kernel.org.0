Return-Path: <linux-wireless+bounces-25359-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C32C2B03B46
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Jul 2025 11:47:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CD4B1884796
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Jul 2025 09:47:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B3E823F403;
	Mon, 14 Jul 2025 09:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="O1bNegZg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFFBB23B63E;
	Mon, 14 Jul 2025 09:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752486450; cv=none; b=I9AhV/h8mPW/ZJ8cvHIFP5+4V7mwV994Y4env5uFeA1QZCGIsExBmWswup8JBe1t45167W4m1hbVKt8T1u0Ixz2HTNUzRiLk8d6W3RHsp6hlstB6A42CN7EkPZISvQhd2k+4IjjBD2SCN2dMTRkdQb4XcZf9A48fbpgwn13IONI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752486450; c=relaxed/simple;
	bh=U9GVC5R5I+/D5375MuuZ50OzNLrm5EmG3hC3sHDuf0g=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=P8MK1tw0x19MQ2wc/pYQLZyAqGrt72Wh51i+LCIBUkSZlCPesdecnZQ96ZCr5tKC5vk0S3kf90xhVdntUcJbiIdGWtZJMToDmJUfOWfRe/m5Fk/Uyhn7dmFzVwFt52hIVwB518cAg/hp2GwE8GTZ5I/X/MSE9EFajb+EPeFLV0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=O1bNegZg; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=U9GVC5R5I+/D5375MuuZ50OzNLrm5EmG3hC3sHDuf0g=;
	t=1752486448; x=1753696048; b=O1bNegZgNF1shqFScp10zO8HbyWQmdmtZmfo9E90ro/J4yz
	Zj4idXuAS5wjulv1qFoYvchHEPaB5gReNenuHxUkn4TiZRT2QzJjq+EvESLChFyXJ8ANqLYbWzEuK
	IZrajcHaFAmD28OEEj6mgR8EVw4VM+5KkA/FMOvQPOAkQQo1IePSrHa/v117ULdcSop5aF4vQmaxY
	UK66cwUxfvazW5Dy92i9tvYUN0ELiYv1W5m9DOY4ALlrmOITJCj7tiNUezWfCJfPNQysB+ShU1hwD
	wnABKGp5LZHHcYJFUvKG4Eff/uFFj87IQd0q46AMbOh18dLNWYu41sIdExAX1GFQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1ubFmG-00000003qug-1aSX;
	Mon, 14 Jul 2025 11:47:18 +0200
Message-ID: <9a178703de98e87d9c046975de1b078086b7cf9f.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: mac80211: warn on insufficient antennas for
 injected HT frames
From: Johannes Berg <johannes@sipsolutions.net>
To: WangYuli <wangyuli@uniontech.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
	zhanjun@uniontech.com, niecheng1@uniontech.com, guanwentao@uniontech.com
Date: Mon, 14 Jul 2025 11:47:09 +0200
In-Reply-To: <53AD760311F904D0+20250714094456.259784-1-wangyuli@uniontech.com> (sfid-20250714_114552_432528_2BC595AD)
References: 
	<53AD760311F904D0+20250714094456.259784-1-wangyuli@uniontech.com>
	 (sfid-20250714_114552_432528_2BC595AD)
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

On Mon, 2025-07-14 at 17:44 +0800, WangYuli wrote:
> When injecting frames via radiotap, an HT MCS rate can be specified.
> The number of chains for that MCS implies a minimum number of
> antennas that must be enabled in the antenna bitmap. Previously,
> if the antenna bitmap specified fewer antennas than required by the
> MCS, the bitmap was silently cleared. This makes it hard to debug
> issues with injected frames.
>=20
> Add a WARN_ONCE() to log a descriptive error when this happens, make
> it clear that the antenna configuration was insufficient and has
> been reset.
>=20

No. We shouldn't WARN on userspace misbehaviour.

johannes

