Return-Path: <linux-wireless+bounces-28092-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 785AABEFBAB
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Oct 2025 09:47:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 65BAE4E625F
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Oct 2025 07:46:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E63292D6E53;
	Mon, 20 Oct 2025 07:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="Rsebfh+s"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A14D178372
	for <linux-wireless@vger.kernel.org>; Mon, 20 Oct 2025 07:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760946416; cv=none; b=KSeeO2J7V87dMKCDnBFHjpes2d06hgb/rFj06VJJnHfiT72ogRxBRfLb/4eIrpc+i+tUpRUVrlohphvmM5XzFp9Q/o5/r4CUKCtvQeWYaQLo6eIlIBClr36+uyU7LzNfKV/Q+FXYbf3wcGKk6BtXwSkvEPd3lRfoRwHQ4qkQr00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760946416; c=relaxed/simple;
	bh=pvkPyt2430/smoA/sNiW5w2WPDmsKX4nbw4pzrLn4xs=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DhYWi9C7qW7jKQuVc5/Ir95nFCLv9FCHH3wclqXUwK+sobVV6n8LkmNmSP1amtXO5rMEit8ClePXF2+W5hN67Dq9k1lCfIBZXJjTsultZaJ+ALjAVhLWbd86LN8J83TpAX9QNt6cWM/gBYhpdhHo5/4RYug/HqUXb2caUb2NOBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=Rsebfh+s; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=wmsCfnBkFkEeeceaGBk5BMFKv6B+F8vDCS0RnRNYP54=;
	t=1760946415; x=1762156015; b=Rsebfh+sJ2g4joASoZRwlEoxDgsZGiAg/spIwil5aihvjFu
	PSQlH5CY/9jfmM6FZjp8s8axcCMmxZZ6+vziMvUtJSBFfpDaM4ok6yYwN/ym7nxclMW2lRHOQbfSz
	F3I+a4a1KsShCfj48dq155Y91Hp2l80qX+AF27Kgf1eAyurv/vUbx7CdwwmRIoqjWcdwtLliAf6kn
	MMnjWThgE4r8ukUOXnU2b7Nhi/VshvuPgxXcQOg8t2qhUQkxqj3qrpTkSd4p46fqgd0VGfZGzpT9A
	6AUfHkWTLm4MnhPxgem0Hc73clRSrrrbq3uoMWhuC/rqarSklAX0X1DmzocPizEg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vAkbU-00000008LbM-3GW1;
	Mon, 20 Oct 2025 09:46:52 +0200
Message-ID: <7b249ffec47b4297c8ba97ba6932338dfb62b9f1.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: mac80211: use jiffies_delta_to_msecs() for
 sta_info inactive times
From: Johannes Berg <johannes@sipsolutions.net>
To: Nicolas Cavallari <nicolas.cavallari@green-communications.fr>, 
	linux-wireless@vger.kernel.org
Date: Mon, 20 Oct 2025 09:46:51 +0200
In-Reply-To: <20250925144629.26947-1-nicolas.cavallari@green-communications.fr>
References: 
	<20250925144629.26947-1-nicolas.cavallari@green-communications.fr>
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

On Thu, 2025-09-25 at 16:43 +0200, Nicolas Cavallari wrote:
> Inactive times of around 0xffffffff milliseconds have been observed on
> an ath9k device on ARM.  This is likely due to an race in the
> jiffies_to_msecs(jiffies - last_active()) calculation causing an
> overflow when the observed jiffies is below ieee80211_sta_last_active().
>=20
> Use jiffies_delta_to_msecs() instead to avoid this problem.
>=20
> Fixes: 7bbdd2d98797 ("mac80211: implement station stats retrieval")
>=20
> Signed-off-by: Nicolas Cavallari <nicolas.cavallari@green-communications.=
fr>

https://patchwork.kernel.org/project/linux-wireless/patch/20250925144629.26=
947-1-nicolas.cavallari@green-communications.fr/

Commit: 23e2a8cf2453 ("wifi: mac80211: use jiffies_delta_to_msecs() for
sta_info inactive times")
	Fixes tag: Fixes: 7bbdd2d98797 ("mac80211: implement station stats retriev=
al")
	Has these problem(s):
		- empty lines surround the Fixes tag


*Please* check these things yourself so I don't have to spend my time on
it.

johannes

