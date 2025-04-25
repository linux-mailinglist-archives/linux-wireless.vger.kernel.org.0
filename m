Return-Path: <linux-wireless+bounces-22060-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AEA6A9C3FF
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Apr 2025 11:42:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC2DA1BC0B09
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Apr 2025 09:41:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0261221294;
	Fri, 25 Apr 2025 09:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="PIUnaNVq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D7C1FF1BF
	for <linux-wireless@vger.kernel.org>; Fri, 25 Apr 2025 09:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745574049; cv=none; b=Efryy1py31ogAgBM8ZFClM45HsEyTfM0rD6Q0TLNU5HqrW9kOunP7YGOWz6esCmFCw3CHVuu9AWGnlEo/45aCRE18OOhMtwlV2U8S6KeltEFjR7y75msNPcIrU5izDmyCj3hI9tnv3XRjHvQ+8XmXOL7tHTEkTBk0b4WN2vgB0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745574049; c=relaxed/simple;
	bh=2pbUWp2iOL1GOfU4Sd9ukfrVbPU6d0oBgNVRcTj4Ino=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WWWZus7ZXjU+RI7qMbu3hOCRCEcgrDK3Jbi+E6BaVzkyHFXjmnxpxW0ppDRCUsJQ61cuxnRGIIb5guAdrR/KpTbWG7tDsN3Iwzw+9ipAKuQi1BTDVW+frrb/ppyyRXP2TjlCaEhYjza5NXCsvFmLVvT7sNTdIhPawtYXSyAs9UQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=PIUnaNVq; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=2pbUWp2iOL1GOfU4Sd9ukfrVbPU6d0oBgNVRcTj4Ino=;
	t=1745574048; x=1746783648; b=PIUnaNVqrc1t9oZDNp0MD821olXPp22DDQ0o9kSTIdyzvRs
	DtWvVh5rryYfT5rO03ea7cTZWaPCVtM+c+GQzcjbkeUnCiBPhfhpKtJaCaRWaqpsIUus0e/98WbZm
	Y9CxQTHfCeQuUhLhc/UcwI+Q2Yd8DnA6ucneTu23eUQ1lGx3GXwoEAW0wpPavtalDWMiZ5s+m/mmD
	hNB0qgq5gPpBxrKo2rtJKAOKsX9+TdSroDQhdTn/FHJSR6Q6xTWby2M9lJd2R118RZOGZH0QMkho7
	g20hvixfD07tW7uHL0V9Q8O0ZeSxuXsjZHPROAyCaDz71Bhlegryz+qMYJWjnTFA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.1)
	(envelope-from <johannes@sipsolutions.net>)
	id 1u8FY4-00000001HTu-2bnt;
	Fri, 25 Apr 2025 11:40:44 +0200
Message-ID: <6d4e921e0c656260ef6f56119591bbaee6c14634.camel@sipsolutions.net>
Subject: Re: [PATCH 00/38] wireless: ra6w driver for Renesas IEEE 802.11ax
 devices
From: Johannes Berg <johannes@sipsolutions.net>
To: Alexander Savchenko <oleksandr.savchenko.dn@bp.renesas.com>, 
	linux-wireless@vger.kernel.org
Cc: Sergiy Petrov <sergiy.petrov.ue@bp.renesas.com>, Viktor Barna
	 <viktor.barna.rj@bp.renesas.com>, Gal Gur <gal.gur.jx@renesas.com>
Date: Fri, 25 Apr 2025 11:40:43 +0200
In-Reply-To: <20250417135236.52410-1-oleksandr.savchenko.dn@bp.renesas.com>
References: <20250417135236.52410-1-oleksandr.savchenko.dn@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Thu, 2025-04-17 at 16:51 +0300, Alexander Savchenko wrote:
> Renesas Electronics Corporation publishes to the opensource new
> wireless driver for an own 802.11 chipset family - RA6Wx.

Oh, and out of curiosity - and maybe you can't say this - is this IP
coming out of the apparent Celeno acquisition? I had some meetings with
Celeno more than a decade ago :-)

johannes

