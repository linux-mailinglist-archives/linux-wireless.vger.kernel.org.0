Return-Path: <linux-wireless+bounces-12028-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 881299603BA
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Aug 2024 09:57:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB5CB1C20D39
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Aug 2024 07:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10965156C5E;
	Tue, 27 Aug 2024 07:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tradeharmony.pl header.i=@tradeharmony.pl header.b="LT3TJ2wW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.tradeharmony.pl (mail.tradeharmony.pl [5.196.29.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D61FB13E41D
	for <linux-wireless@vger.kernel.org>; Tue, 27 Aug 2024 07:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.196.29.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724745454; cv=none; b=CuBg5WnnXN6+3NWTLj6EUJv9W3z2wekHmMg9LUVr/u3VSJJxIP/iwo20QugjIF8DRgm6md1SZcUSdGD3Xk5FJHrTSmdeIUNTDNmAgN0yqKMTJCl855hoFw9NeijrXh0J9CvfGTApXfCUoZL2sWnfUErqcXv/sDQJavs8WM8dN70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724745454; c=relaxed/simple;
	bh=siHX5jVClg4W32F/NjlCmIL8w17yqZEkZP0Dfrdd7Ok=;
	h=Message-ID:Date:From:To:Subject:MIME-Version:Content-Type; b=APQf6PDPcFWhXQRLcPRtQJetGncjkFBL0QsqZKEsMQFVj4mityZZwUbBXfc5OC4sZ2RO04KiVbHUNzKi7lD3LIg0ywvV4mLLfwfPjwIEAafneTojF0r5FxIIN7DHqdWqWeM2nqH0vt3gh+kj8KnOzfAD9A+RPtG+jy/MaW2D+xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tradeharmony.pl; spf=pass smtp.mailfrom=tradeharmony.pl; dkim=pass (2048-bit key) header.d=tradeharmony.pl header.i=@tradeharmony.pl header.b=LT3TJ2wW; arc=none smtp.client-ip=5.196.29.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tradeharmony.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tradeharmony.pl
Received: by mail.tradeharmony.pl (Postfix, from userid 1002)
	id 4D6D527091; Tue, 27 Aug 2024 09:56:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tradeharmony.pl;
	s=mail; t=1724745368;
	bh=siHX5jVClg4W32F/NjlCmIL8w17yqZEkZP0Dfrdd7Ok=;
	h=Date:From:To:Subject:From;
	b=LT3TJ2wWslYwssn6WYsoCIPH33fo/TVK6PZtpJKX9Gf9G04SZIW6KPWOFaebty5Tl
	 sR+4OgmXQMdCUCoFmB85a0sczwMxC98psfCyB0uqkwpAuwbWJXJYCmU2rwdyNnbLBc
	 FKbxDmuRg24GWRcL9eUz2PzDqd4C/3fqMWWN4UTsTHAZ34n+1dTXWC+3brlP3f5NhL
	 O6oVFg6RF7ZeHhW/RYzLijkP6LWkrVcY7C2ooOlqRHjw79eu3cVKcWd2SkIY+1kcaC
	 JpcVULSIPWnCm1ZagTRJ/Wtveg4nzCAd33uyv8YkL722Ey4TAGCVsOTXnCXvDwYcbe
	 +gj74RgBo2O0Q==
Received: by mail.tradeharmony.pl for <linux-wireless@vger.kernel.org>; Tue, 27 Aug 2024 07:55:59 GMT
Message-ID: <20240827084500-0.1.8a.2xiju.0.guqu9loxv4@tradeharmony.pl>
Date: Tue, 27 Aug 2024 07:55:59 GMT
From: "Karol Michun" <karol.michun@tradeharmony.pl>
To: <linux-wireless@vger.kernel.org>
Subject: =?UTF-8?Q?Pytanie_o_samoch=C3=B3d_?=
X-Mailer: mail.tradeharmony.pl
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dzie=C5=84 dobry,

Czy interesuje Pa=C5=84stwa rozwi=C4=85zanie umo=C5=BCliwiaj=C4=85ce moni=
torowanie samochod=C3=B3w firmowych oraz optymalizacj=C4=99 koszt=C3=B3w =
ich utrzymania?=20


Pozdrawiam
Karol Michun

