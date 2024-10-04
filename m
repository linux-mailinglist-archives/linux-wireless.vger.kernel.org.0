Return-Path: <linux-wireless+bounces-13492-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CCB6E98FF01
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Oct 2024 10:46:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6AA46B225E8
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Oct 2024 08:46:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CB71136345;
	Fri,  4 Oct 2024 08:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="dDD+pg2o"
X-Original-To: linux-wireless@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FB61179BB;
	Fri,  4 Oct 2024 08:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728031577; cv=none; b=pkwJgX6KjwZPqIjd9qQ58+6ijrDh20J9H+apWLouPdf7tw2CpmDCJN+d918EwqMSETLGmaZzjfci+Ffr7//mTZ9VD4/cfdOluECR0+JmCJPwSlhSmJq8Y6qV1i4EPUyiKSrlysf8yhhLPYDtKuCEnWFQyXMuNNE5pEeuDB2h/+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728031577; c=relaxed/simple;
	bh=l8qboFZDS0LmhxPS4qc2TV8dKQUVXozlJ0gMQJt7XuY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uVLo5tp39jSdK2g0ARzVdPmICTYLHr+sJzuh5sHR8MmPsSUc/1g9lish+xHOnjugjV34IUXuAPfowMwquaOYEZ8aTZtcSndndFKPfE3Rscw0R8eJZgl5XjPB5ej+8AL7wsJpbjDMY28muSQtEQc7r5FLYS6eJsSAn3mTQ1utUmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=dDD+pg2o; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 96DDB240007;
	Fri,  4 Oct 2024 08:46:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1728031572;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=okeEEVX3/VdO47AZCRhOLjrnz4W2UV8STTrINxXWStQ=;
	b=dDD+pg2oGl+NsWfeGBFkbmVx3GF7NOYzvavZdzngj10Quvaxu0ct96HFznHLTwDIALfzR7
	Vpmi2S8w2IYZdgbcEtn/rWce12jaoPXwkHGWjpvqtzMft+Qqn8Gbkz4dYgmCob2omc08Wv
	4VCyujHwPNxC8jKAZYvkaqpVEuq5Ea7D/YUGKaAphaOsX5zJsmgLUltqwyWxQ0FECVozuw
	slUYWr63fWChS7UD6EuAJK5ZMmn508N5dbuLWhz0V94SZ0DNWRPZfZRuB2BPQo29f6WTLK
	sfrBzGEDSvlXLNEnoo7hl4FjGpSGqRyhFIEAMpZEbmO2lNhzH6SS94Q1e/sFWA==
Message-ID: <206e5a5a-25ad-43d1-b8d3-53ecbfecb755@bootlin.com>
Date: Fri, 4 Oct 2024 10:46:11 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 7/7] wifi: wilc1000: Add WILC3000 support
To: Marek Vasut <marex@denx.de>, linux-wireless@vger.kernel.org
Cc: Ajay Singh <ajay.kathat@microchip.com>,
 "David S. Miller" <davem@davemloft.net>,
 Adham Abozaeid <adham.abozaeid@microchip.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, Conor Dooley
 <conor+dt@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Kalle Valo <kvalo@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
 netdev@vger.kernel.org
References: <20241003111529.41232-1-marex@denx.de>
 <20241003111529.41232-7-marex@denx.de>
Content-Language: en-US
From: =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
In-Reply-To: <20241003111529.41232-7-marex@denx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: alexis.lothore@bootlin.com

On 10/3/24 13:14, Marek Vasut wrote:
> From: Ajay Singh <ajay.kathat@microchip.com>
> 
> Add support for the WILC3000 chip. The chip is similar to WILC1000,
> except that the register layout is slightly different and it does
> not support WPA3/SAE.
> 
> Signed-off-by: Ajay Singh <ajay.kathat@microchip.com>
> Signed-off-by: Marek Vasut <marex@denx.de>


Reviewed-by: Alexis Lothoré <alexis.lothore@bootlin.com>

And for the basic feature set (basic sta scenario, basic ap scenario):

Tested-by: Alexis Lothoré <alexis.lothore@bootlin.com>
Tested-on: WILC1000SD 07 SDIO WILC_WIFI_FW_REL_16_1_2
Tested-on: WILC1000SD 07 SPI WILC_WIFI_FW_REL_16_1_2
Tested-on: WILC3000 A SDIO WILC_WIFI_FW_REL_16_1_1
Tested-on: WILC3000 A SPI WILC_WIFI_FW_REL_16_1_1

-- 
Alexis Lothoré, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

