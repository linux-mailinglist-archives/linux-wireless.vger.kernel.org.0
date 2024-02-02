Return-Path: <linux-wireless+bounces-3063-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0949A847A67
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Feb 2024 21:19:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B235C1F255DB
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Feb 2024 20:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 893108063B;
	Fri,  2 Feb 2024 20:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b="OfamJUth"
X-Original-To: linux-wireless@vger.kernel.org
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33B5F8060F;
	Fri,  2 Feb 2024 20:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706905163; cv=none; b=Df0OCN0SSSLHsbCgWQe6vM1lhioHedeBL7U3Wo+ey0tN7OXHWcjwFuvylqXQrKq3471k5+jzPx6nh1Rurk5YHGPnwIRNfCV8tm98o3IG3rC4uxXqEjROxy1W9rPED2W6runhdlQNV6T5ex97/Fc/QXCYHM4/AcMxGb6gCTQpw2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706905163; c=relaxed/simple;
	bh=mtAAaAHQ87GRvCt/f/HNdb37dmDNHvRqrP8yLpZjFGA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q6zF052r9OncgOXf82VrZsZsIcnALRVg9ozUim7+GiP4dm0WiDmYrJ5E6D4zaMzpyWVdweC6bmBmxjcV4PHWR8Is1FhlFhoT7exK00V+9Ep4S1fPPEI9w6Hwvv6jusrYFtIOusK3aNwGnWuhfBTiWwShZ5N1auimDnvl2BM8vzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz; spf=pass smtp.mailfrom=ucw.cz; dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b=OfamJUth; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucw.cz
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 1665A1C0075; Fri,  2 Feb 2024 21:19:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
	t=1706905158;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d3lPDfgTxbpaYP0omT2u05b/N3MVIBURyfQsTSMQ0PA=;
	b=OfamJUthX0zK9T2frDVo3f279qZ36xmkUbrOCKBxV6wDAccp9qLbZlNp4pF3fuHgjp4cc3
	nNkpbLXG+GITkXy17jtPBBl6V0P6AfGZpkhcA6HHRtkjOYTahi9ezID8atTcDzYY3y4b4l
	zXe+mSILYKn5SAQxkXC1vG0fhOldFvA=
Date: Fri, 2 Feb 2024 21:19:16 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Fiona Klute <fiona.klute@gmx.de>
Cc: linux-wireless@vger.kernel.org, Ping-Ke Shih <pkshih@realtek.com>,
	Kalle Valo <kvalo@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
	linux-mmc@vger.kernel.org,
	=?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>
Subject: Re: [PATCH 0/9] rtw88: Add support for RTL8723CS/RTL8703B
Message-ID: <Zb1ORD_Lzd4O4gu-@mobian>
References: <20240202121050.977223-1-fiona.klute@gmx.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240202121050.977223-1-fiona.klute@gmx.de>

Hi!

> Ping-Ke Shih kindly offered to add the required s-o-b for the firmware
> and help get it into linux-firmware when it's time, for testing now
> please see the code I used to extract firmware from the out-of-tree
> driver [1].

Can I get you to apply this?

So far I got driver to insert, but I did not have firmware
installed. That should be ok on next reboot.

Best regards,
								Pavel

diff --git a/Makefile b/Makefile
index 1f8e8b6..fbc1f14 100644
--- a/Makefile
+++ b/Makefile
@@ -7,6 +7,10 @@ firmware_files =3D rtw8703b_ap_fw.bin \
=20
 all: $(firmware_files)
=20
+install: $(firmware_files)
+	sudo mkdir /lib/firmware/rtw88/
+	sudo cp $(firmware_files) /lib/firmware/rtw88/
+
 %.o: %.c
 	gcc -fPIC -DCONFIG_RTL8703B -c -o $@ $<
=20


