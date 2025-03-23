Return-Path: <linux-wireless+bounces-20713-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F19AA6CEAA
	for <lists+linux-wireless@lfdr.de>; Sun, 23 Mar 2025 11:21:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0435716E698
	for <lists+linux-wireless@lfdr.de>; Sun, 23 Mar 2025 10:21:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 350741BD01F;
	Sun, 23 Mar 2025 10:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="VbiqiMMC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-40133.protonmail.ch (mail-40133.protonmail.ch [185.70.40.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98ABE1E5B6B
	for <linux-wireless@vger.kernel.org>; Sun, 23 Mar 2025 10:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742725274; cv=none; b=sr2pD5ezbXm/v4Q/5CxfVjBrOtEjSEvkuGNbwQjR2KKvJEEQLPgsO3Jpb1sGVzZy6bPTKxfRR274RhcB/DQ6TbG2JwDmerJuCbzUDPnreeIo36SkkPa+xstkpjJZs5qzSVv43bK7/uwHAnG72rJOdwHKnuSwoDx+YUQPqbuXUoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742725274; c=relaxed/simple;
	bh=nCM1cqOnkXbSUjspK5cjAMLuElnHgxF9X/S261jLYig=;
	h=Date:To:From:Subject:Message-ID:MIME-Version:Content-Type; b=pbYivwV95u5UObq1JGW5Lo7XhWB36mdSWtfz7MbQckrbstlz9yYeIdpNiho5/UF9DR1y7g3dOpfOZArIkT+iVspMBDj3Xh2P3auXC3z+Z83u2kqEAlpMLICFr8T4tQEqbypu8QWSoSDhk8l6UIy4JA0prOwWwsKX4a2cv4a5+o4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=VbiqiMMC; arc=none smtp.client-ip=185.70.40.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=gvyn2sffjvfnnezrenhhjv5tw4.protonmail; t=1742725265; x=1742984465;
	bh=bGysH5BGLhodUfNgP0H3dbTK4ZZUgCPSRAbd9SDZqm0=;
	h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector:
	 List-Unsubscribe:List-Unsubscribe-Post;
	b=VbiqiMMC3C2/KMeMtzT7o/Dnv98Prxp7uhR5wLrijgMNYBrCHQHMoS9utgcMaX92Z
	 GNlUhpwcSJnl1sTMLyVC1aSvPdeKwLx8e/VyH64JNpDYdsM0h6orCxqddH5vCORutY
	 lAtDSi1BEbcmU8227fS5P0i2iTbCrVcdgaohAUdZhx7Mdqe3Qu2llHN4X+23ZWKJHb
	 CjXeRZWtRcodof/9yc54vsERpd5Oy6J2wN+7ThcF6YU4l8T52VLIClXGpjNuOr0j3t
	 VNTfB8BHqQem3/XoCltZVynsGgP8vohc5lVMboH5GEm2LjXXiZagmOoeHwssfEmyLh
	 ZLQvW1cOXlntg==
Date: Sun, 23 Mar 2025 10:21:01 +0000
To: linux-wireless@vger.kernel.org
From: Helga K <Strike0347@proton.me>
Subject: b43: Putting out feelers on adding support for BCM4360
Message-ID: <5906467.e9J7NaK4W3@nessa>
Feedback-ID: 100537087:user:proton
X-Pm-Message-ID: 677eb382a742e3247b6f855534a0566dca13eda7
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

I'm a C dev that works in network hardware testing and bringup.
I'm extremely tired of the myriad issues of the broadcom-wl driver, and I'd=
 like to add=20
support for the BCM4360 card to b43 instead. The last few times this card w=
as mentioned
by developers were:

* Arend van Spriel in 2015 saying support would be unlikely because Broadco=
m didn't
  clear it and because it'd require adding VHT support to brcmsmac (that ha=
sn't changed in=20
  10 years - brcmsmac still doesn't support VHT+ hardware)
* b43 developers adding a stub saying its PHY wasn't supported (but could b=
e in the future)

AFAIK support for this card in b43 is feasible - it's only AC PHY operation=
s that are missing.

My questions are:

* Is it possible to merge new functionality into the driver given its orpha=
ned state? I'm
  not capable of taking over maintaining b43.
* Is anyone in the community broadly familiar with reverse-engineering Broa=
dcom hardware
  and can bring me up to speed with the state of the art?

Thanks in advance,
Helga




