Return-Path: <linux-wireless+bounces-3064-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93ECA847AA5
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Feb 2024 21:44:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ECF97B2110B
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Feb 2024 20:44:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88BD03CF5A;
	Fri,  2 Feb 2024 20:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b="Uw7BdU4Q"
X-Original-To: linux-wireless@vger.kernel.org
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EF651862A;
	Fri,  2 Feb 2024 20:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706906691; cv=none; b=OdqUqxwxG9Ys9o/ZqFz/W0Eescg7MRzSU7KmTAFxz2/EI3PGK3tWVDp6Fl1o/8Sz9p+qATnoQG78HjqLsKSjkdHy4EQES9fii/x5gMEGsQeqnId9FtSmjrg+d7LhIZO5aqdW+u7BshS2we+j4K+CRKh1wkEB0PRS2EYTi/INhQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706906691; c=relaxed/simple;
	bh=ggj4j4vTDDXoTjY42nSzLP+dFzTRFUGiWaXpE9z5P1A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C5b8MNJiSsXT70pyS7l9xfpaXEE6pF2WmEBBa74W5aqAU3lTwxmxJuecFJ8e+oaJllw6q3rSFlGFf7lopDWd7wqPTc7DW3NglBP2XPqSV29S4JC03S7WHncvtaiX0/nVhH4Ku/7olo3egmsmfuvpy2YbhoXCcrbpuGHMvbL1GSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz; spf=pass smtp.mailfrom=ucw.cz; dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b=Uw7BdU4Q; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucw.cz
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 3DCC21C0075; Fri,  2 Feb 2024 21:44:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
	t=1706906686;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wnNPBBNOKSOKFW9wZIaMMIEpPsmgvB/bRcZfgYmpbWo=;
	b=Uw7BdU4QMUuL6UjX+DkItlRo/qsKVhPVrkWUDq66TTFFLByAKQwtyXrkFzIcsl/TXVEgTJ
	1ZSOLl2iygLztuHz+ivPn5uGBzqsm7U9OyHJlVGNf3a+3RLD9/5m2cWmgZmHAXzTTXLQpJ
	Kw4d+ntAoTfkqWuyd37PkC/doMYyd5c=
Date: Fri, 2 Feb 2024 21:44:44 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Fiona Klute <fiona.klute@gmx.de>
Cc: linux-wireless@vger.kernel.org, Ping-Ke Shih <pkshih@realtek.com>,
	Kalle Valo <kvalo@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
	linux-mmc@vger.kernel.org, Ond??ej Jirman <megi@xff.cz>
Subject: Re: [PATCH 0/9] rtw88: Add support for RTL8723CS/RTL8703B
Message-ID: <Zb1UPHwfqdAGKCn_@mobian>
References: <20240202121050.977223-1-fiona.klute@gmx.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240202121050.977223-1-fiona.klute@gmx.de>

Hi!

> This patch set adds a driver for RTL8723CS, which is used in the
> Pinephone and a few other devices. It is a combined wifi/bluetooth
> device, the wifi part is called RTL8703B. There is already a mainline
> driver for the bluetooth part. RTL8703B is similar to the RTL8723D
> chip already supported by rtw88. I've been using the out-of-tree
> rtl8723cs driver as reference.

I've installed in on PinePhone with v6.8-rc1, got firmware, and it
simply started working (maybe with slightly reduced performance, but I
did not check). In fact, I'm sending this email using the new driver.

Tested-by: Pavel Machek <pavel@ucw.cz>

Thank you!

Best regards,
								Pavel


