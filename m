Return-Path: <linux-wireless+bounces-13450-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7263998EB04
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Oct 2024 10:04:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EC1D1B20E8C
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Oct 2024 08:04:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8D5182D83;
	Thu,  3 Oct 2024 08:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="LfocnND2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68C49811E2;
	Thu,  3 Oct 2024 08:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727942678; cv=none; b=FkeV63zWBrLdbm0DV5CktUdkkm5KSLgdqkkbwUlPtc+hmup5EcuLl04RZFTXNczK8aCzVn8ILOLZ9EZnDdHQtO1pqNq8MwJRPq+KBEQoHRrgNKCw9wd0dt6zls0NGpWY0hd4UrBjB+CCHmlqNF+A9puqENfoHzbr5ELRMOaZ9JA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727942678; c=relaxed/simple;
	bh=1tae21s3e6QcaNtDUvIDGJ9EWbkfufNZC2HUUZNH7CE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qK8UhK9GK5/eJeqw54Ud1r4DNsnxSRmt9OzZdkvVh9bknvOR6/ZKEe6o9BkKdE2wrlzHoeDylZDvHQ6R7PctX8GNhTHIFqR6Kf81uJp8ouOCl3Mgi9Mz2ko9P01mgpqIRo+8pbcE86HcUPdJMtAuSb9HTjTOX/8k/J3VTFv+c90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=LfocnND2; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id AE9C0FF804;
	Thu,  3 Oct 2024 08:04:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1727942674;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qaRvvQziLU6C2Xe7I8nl3yrGndFd7caE/VtEN8AnYx4=;
	b=LfocnND2/LlhnlobhP3UzyK0PfGnWrlsplWokefGtvgXy06ye7AHzPQdLFf4CU3BOXAKbk
	exlEz4R3i4CvRocUvhzaisF3HjwQ/ZMQ1LLUg8fH+Wc0QVvP+G6XPnBgwKmwEcCDWPYYNe
	AZIrCxyoDGsDNCwg6xj+ov88MEXgKG0wo9UG/C2C4syggcjlngPqsIyKT/joekl3q8ZePQ
	SvOd+oOCY/pTJRzJHixqQ+reF4jGe58Qp9vtmpG3CRsGeuQuUKjU7mnrCOhiurHCJcgB0s
	ErAyt5eBbNIwbaES94GwUHZI+Te7elwNdj0RIQkXBFmm7i+R0psnkKzW9yICCg==
Message-ID: <0321fc03-e1ea-4012-82a3-fcdc6f3b18eb@bootlin.com>
Date: Thu, 3 Oct 2024 10:04:33 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/7] wifi: wilc1000: Fold wilc_get_chipid() into wlan.c
To: Marek Vasut <marex@denx.de>, linux-wireless@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
 Adham Abozaeid <adham.abozaeid@microchip.com>,
 Ajay Singh <ajay.kathat@microchip.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, Conor Dooley
 <conor+dt@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Kalle Valo <kvalo@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
 netdev@vger.kernel.org
References: <20240926195700.2823751-1-marex@denx.de>
 <20240926195700.2823751-2-marex@denx.de>
From: =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
Content-Language: en-US
In-Reply-To: <20240926195700.2823751-2-marex@denx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: alexis.lothore@bootlin.com

Hello Marek,

On 9/26/24 21:55, Marek Vasut wrote:
> Do not use wilc_get_chipid() outside of wlan.c . Instead, call
> wilc_get_chipid() right after the SDIO/SPI interface has been
> initialized to cache the device chipid, and then use the cached
> chipid throughout the driver. Make wilc_get_chipid() return a
> proper return value instead of a chipid.

This new update now makes the commit message wrong, wilc_get_chipid is used in
files other than wlan.c (and this change goal is now rather to get the chip id
early enough to register wiphy with correct info)

> Signed-off-by: Marek Vasut <marex@denx.de>

With the point above fixed:

Reviewed-by: Alexis Lothoré <alexis.lothore@bootlin.com>

-- 
Alexis Lothoré, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

