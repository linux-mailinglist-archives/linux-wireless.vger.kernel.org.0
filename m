Return-Path: <linux-wireless+bounces-12354-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 213BD96909F
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Sep 2024 02:23:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A90E91F236B2
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Sep 2024 00:23:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E9E01878;
	Tue,  3 Sep 2024 00:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="mYeOqMmw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D3EA32;
	Tue,  3 Sep 2024 00:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725322989; cv=none; b=DpOytq+15kBu60XYKM4/rsXk389o3pjHeAd4zFi/E0qpekCMAPmJnFQPC+IPAYcpGKTTeaotBJlC5OQudKzjiRHCTe3fl97BjKYtlN7gZpKR1W7+vxRumcl6G2s5pDQYuT/ZUGOqqL65YtvShgdxwDBnB+GZ/R0e0AkapqtDV80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725322989; c=relaxed/simple;
	bh=wpgxvuvuy6MrMob5LhfNIlA18ZNhaqV3NDIQgc5JzUI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PacjbIKZxS3zwcp0bqQYMSloD5o/NLWoBMOrkrsnrjN4J0U+XQL2C2cxJXXN81CSwxIor8TPNnjxr1lS8hBPmRDPNqU1TcIpIpH8YSSbmPnP0ZMIC2n/4OFnQQdeluOkmdC0/UPF+3TaMD8BsZ5Ow9gMOZnF6rOVWbp65Gt3qSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=mYeOqMmw; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=FWI5RwxkEQ33xNBb8ono2qSimaDGGTfOgwhj4qFOqzk=; b=mYeOqMmwXXd3HhNWPNrFxkc0PB
	d+LQusAnaTSTHyJcJe6/62w4ATqjmi2XJ+5CaweJTvQ6rutvd06gyDsvMkb2jw0UHZKDxfFr7ZKgG
	VN5orC4/lwWMMNpDZcEterdpVVbtbT8m8oPvdB22DqmWrackh+qRdODaerh6I5KWzd9A=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1slHJn-006LUO-9m; Tue, 03 Sep 2024 02:22:47 +0200
Date: Tue, 3 Sep 2024 02:22:47 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: linux@armlinux.org.uk, maarten.lankhorst@linux.intel.com,
	mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
	daniel@ffwll.ch, linus.walleij@linaro.org, alsi@bang-olufsen.dk,
	f.fainelli@gmail.com, olteanv@gmail.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	nico@fluxnic.net, arend.vanspriel@broadcom.com, kvalo@kernel.org,
	robh@kernel.org, saravanak@google.com,
	andriy.shevchenko@linux.intel.com, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, linux-wireless@vger.kernel.org,
	brcm80211@lists.linux.dev, brcm80211-dev-list.pdl@broadcom.com,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v1 0/7] Use functionality of irq_get_trigger_type()
Message-ID: <d6784b5c-6eb1-4b31-b870-da926fa00e32@lunn.ch>
References: <20240902225534.130383-1-vassilisamir@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240902225534.130383-1-vassilisamir@gmail.com>

On Tue, Sep 03, 2024 at 12:55:27AM +0200, Vasileios Amoiridis wrote:
> Convert irqd_get_trigger_type(irq_get_irq_data(irq)) cases to the more
> simple irq_get_trigger_type(irq).
> 
> Inspired by: https://lore.kernel.org/linux-iio/20240901135950.797396-1-jic23@kernel.org/
> 
> Vasileios Amoiridis (7):
>   drm/i2c: tda998x: Make use of irq_get_trigger_type()
>   net: dsa: realtek: rtl8365mb: Make use of irq_get_trigger_type()
>   net: dsa: realtek: rtl8366rb: Make use of irq_get_trigger_type()
>   net: smc91x: Make use of irq_get_trigger_type()
>   wifi: brcmfmac: of: Make use of irq_get_trigger_type()
>   wifi: wlcore: sdio: Make use of irq_get_trigger_type()
>   of/irq: Make use of irq_get_trigger_type()

Please spit these by subsystems.

For networking, you should read:

https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html

	Andrew

