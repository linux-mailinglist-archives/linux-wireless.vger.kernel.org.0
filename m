Return-Path: <linux-wireless+bounces-300-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 07620800E87
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Dec 2023 16:26:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9501BB20D76
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Dec 2023 15:26:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DEB248791;
	Fri,  1 Dec 2023 15:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="JptvBWSp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::225])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E318B6
	for <linux-wireless@vger.kernel.org>; Fri,  1 Dec 2023 07:26:30 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7418D1C000C;
	Fri,  1 Dec 2023 15:26:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1701444389;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0OqJCJBqZM2rydliN3oe3qwJoihri9qJCPDRkEfP5wA=;
	b=JptvBWSpz20wwgm8UIw1JHUPyOBMriaHoqc4EiaseI2gkPxZk2EON0TeBSWGJe1fyyhElK
	yv9rdC6fYL2jS1lULOCeKgJNAZHb2cEM5Of9U1Lwh6Qf/U7QFOPE6cBfYnC7kX/VrPRh38
	ENjHY9hHx1LFHx/CnN1b4bRRPpFAfXsjX1QVmUn+d0rTf7tK2deNMGQRM0PMUbScLBBeux
	FTKC1QKs9tiagWirmMzO1fZz8tYFkv1SdgBKqgjPm6JDhH9hL08r9HihE+bM08LTdYiPb9
	+kAdGj26PfcWaTtHJ9BSt50h3hVEVvu8CWf1NHF0TyFm3CN/ODHehASCEbFA+A==
Date: Fri, 1 Dec 2023 16:26:28 +0100
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: linux-wireless@vger.kernel.org, imx@lists.linux.dev
Subject: Re: Linux v6.6 sporadic reboot failures with ath9k on i.MX6Q
Message-ID: <20231201162628.715983d6@booty>
In-Reply-To: <016b48b0-2021-434f-88c7-deb1bf08d14a@gmail.com>
References: <20231129102240.183f94ba@booty>
	<016b48b0-2021-434f-88c7-deb1bf08d14a@gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: luca.ceresoli@bootlin.com

Hello Florian,

On Wed, 29 Nov 2023 21:10:44 -0800
Florian Fainelli <f.fainelli@gmail.com> wrote:

> Do you have a reboot log with "initcall_debug debug" set on the kernel 
> command line and if so, does it always point to the PCI bus shutting 
> down the device drivers, pcie ports and ultimately the root complex?
> 
> We have seen something similar before with ath10k_pci and our 
> pcie-brcmstb driver which eventually was a result of having made 
> incorrect assumptions while implementing the platform_driver::shutdown 
> routine. There was a hard hang in ath10k_remove(), I do not recall the 
> details, but we were definitively doing something improper there.
> 
> imx6_pcie_shutdown() seems to much simpler, but my first guess would be 
> there.

I had attempted using initcall_debug but the hang was happening on a
different line across tests, so it did not reliably point to a specific
place. Perhaps the serial port just stopped working before being able
to flush the last few lines.

I will have the shutdown code, even though it did not seems to the
problematic.

Thank you for your hints.

Best regards,
Luca

-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

