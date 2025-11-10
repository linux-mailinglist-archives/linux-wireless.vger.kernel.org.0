Return-Path: <linux-wireless+bounces-28719-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CF5AC45390
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Nov 2025 08:34:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14E73188EB18
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Nov 2025 07:35:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9FC223D7C8;
	Mon, 10 Nov 2025 07:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="QlJeS1E7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32ADF2853F8
	for <linux-wireless@vger.kernel.org>; Mon, 10 Nov 2025 07:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762760086; cv=none; b=GQS9kW+neJoS4NVf3wSzjAU5c4CSbqfDFdl7OEdBka2Xk67isDubdJmW8b6AF+sCH3CS/sO7Gkn9GNftO+z0NL/KTvKoLsfNp2V5GKvBiuy2dq5fZR+GkOgaGyI2zUJF69GSlIB4jjOmVDMVbaSp5ztxG7BfoLnhVhtEAqz62yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762760086; c=relaxed/simple;
	bh=kGY4fyiD5/nMo+5XvgNez/6I0nSPoUlCTF4/AcZ5YF0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aizopPFJ3mYHb0razdDgaVwed3euVz4bYt8nbUTm8khiTzDbnIBxayeo1zP4H6pSWtfYaaIlBvhwbb9QYzjKZ4/dn073Bb/GFylBIhLRyAdtvNxPamJ0XWJT4ED5E8Vx09o5Gj/zCcPiew2NnZFIG/G5Ucwp3vwYZq6yqbWcG2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=QlJeS1E7; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=kGY4fyiD5/nMo+5XvgNez/6I0nSPoUlCTF4/AcZ5YF0=;
	t=1762760085; x=1763969685; b=QlJeS1E7yXK8O2vfzypgiUPYD0LkAZ+sb7FIkQOcim58q1L
	sfZTaGtqJCZ5kdheKY7b6PQ2rGbjAAI+BpPYCMXtYrUfVI/CNrQTcf24cseUz35XhRN7EfxEUPJtG
	a5HAORkv8P1NR3HTNoT2BqYbuKnphlELZwlgx/Yt7Z4Wud5JEVM0hPEe/rlb+RJynuXH5BNTZ40eU
	6h24k5XhwbUXPhY3PWuP+R2K/1dqjerXC5zp6/t1g8PtrlQsddxYH1XiIo6ktC+3cHpOktar3v5MI
	4aOJ93IjZeqhYvrcQDwTePRJ7mmFRwOAmzg7QGQhCnCdyAv6iOpimfygVAsOcyKA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vIMQE-0000000AqWw-2uh3;
	Mon, 10 Nov 2025 08:34:42 +0100
Message-ID: <e340d3d08e945df144110b9da2f272cab8a2c40b.camel@sipsolutions.net>
Subject: Re: [PATCH 1/6] wifi: mac80211: remove an unnecessary copy
From: Johannes Berg <johannes@sipsolutions.net>
To: Chien Wong <m@xv97.com>
Cc: linux-wireless@vger.kernel.org
Date: Mon, 10 Nov 2025 08:34:41 +0100
In-Reply-To: <20251109140450.118106-2-m@xv97.com>
References: <20251109140450.118106-1-m@xv97.com>
	 <20251109140450.118106-2-m@xv97.com>
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

On Sun, 2025-11-09 at 22:04 +0800, Chien Wong wrote:
>=20
> Compile test only.

You can trivially do better than that, say with hwsim + wlantest.

> Fixes: 26717828b75d ("mac80211: aes-cmac: switch to shash CMAC driver")

That seems unwarranted, it's not even broken in the old code.

johannes

