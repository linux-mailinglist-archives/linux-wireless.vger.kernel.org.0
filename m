Return-Path: <linux-wireless+bounces-27740-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6651DBACB1B
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Sep 2025 13:34:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F31A7A8BDC
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Sep 2025 11:33:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71791259CA4;
	Tue, 30 Sep 2025 11:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="N3RHuLZo"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF66E34BA3B
	for <linux-wireless@vger.kernel.org>; Tue, 30 Sep 2025 11:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759232076; cv=none; b=RwtakrFMpdz8SNXPiJ8mHVYxBOTAzHHRJfVfcsRB5po53px/eNP+R0oD8RWaOAF4pkz/d58dOtEIBZovpcqCE4dUOWE1ngf8wrXT9Wc1tkf8rYPMFMvxjtFOH7nnI2Q95VkNeNF7+mWx8rA5uD6KQOVvFI1SCqlS2Q0SeAvaI5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759232076; c=relaxed/simple;
	bh=/rdyzCw7D/vyN9W9ll/qHb5uDKvz8RYC1EjILK4BL+I=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mlnpjI8R/M7Jph1Ww4R1R3pk7m2HmXsazDne7gebGDNw/63Icyujxwr97iitlGU8vhv5Uic3lrCkiGqChQe5xuT7BkJgl/mFO3FvYmNV4Bm09XgUr7wtEnvxScE2v/o635zIvRN7AgahWHgok11hA35omrGUt38iVPxhxSs7B7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=N3RHuLZo; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=/rdyzCw7D/vyN9W9ll/qHb5uDKvz8RYC1EjILK4BL+I=;
	t=1759232074; x=1760441674; b=N3RHuLZo3CRo6xWC1wb9qoiK5Hihho9kqDBKwwL0ruClzHZ
	2VHIgL8bhvBu+Lh1GHLZTC+X3mdpxRfHN+Ry4VTGeS7flmIXpGMJRL5DcTkOWoWve4kvTpE0OkTEW
	Yvq0aTG+4E8bzA+FbuuktSYUqoiD+d0biajmGZie9XuKO8wLtZHHHeZ36GJ3xQqdc8IYpJSRHsxNS
	VJ+IfC0juHADkmxHwpzLmgyzvDf/IsGNj+gHCAiM2evlh8dNIGBg4ESQvHkfwJ/CEOMzuo/M10ymO
	iGke6qtuvZRsyE3ZPdyjhuKb5zpsEIE55DFr9xRxk9LHMmjWb7+slNNe2xHAoB3g==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1v3Yck-00000003pVm-1E7E;
	Tue, 30 Sep 2025 13:34:26 +0200
Message-ID: <76fa4cd8d3598c771f5e1c8bb305c241907edc77.camel@sipsolutions.net>
Subject: Re: [Bug Report] Intel AX1775 / AX1790 / BE20 / BE401 / BE1750 2x2
 (Wi-Fi 7) fails to resume after suspend (s2idle)
From: Johannes Berg <johannes@sipsolutions.net>
To: Francesco Bergesio <francescobergesio1@gmail.com>, 
	linux-wireless@vger.kernel.org
Date: Tue, 30 Sep 2025 13:34:25 +0200
In-Reply-To: <CAFXXzTbHabF2hZKWM=RquQXB_tFq-24SPifnyL9ZA5-HL30X1A@mail.gmail.com>
References: 
	<CAFXXzTbHabF2hZKWM=RquQXB_tFq-24SPifnyL9ZA5-HL30X1A@mail.gmail.com>
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

On Sun, 2025-09-28 at 20:51 +0200, Francesco Bergesio wrote:
>=20
> Steps to Reproduce:
> - Connect to a Wi-Fi network.
> - Suspend the system using systemctl suspend.
> - Resume the system.
> - Wi-Fi does not reconnect automatically; manual reconnection fails.

How does it fail? Does userspace get errors? Is there a wpa_s log? The
kernel log indicates the driver was restarted/reloaded or so, but
nothing else.

johannes

