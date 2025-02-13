Return-Path: <linux-wireless+bounces-18921-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90F3CA347A3
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Feb 2025 16:36:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EAFC1188A3E9
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Feb 2025 15:31:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0504E1632DD;
	Thu, 13 Feb 2025 15:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="PtmoB1+K"
X-Original-To: linux-wireless@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 309DC26B098;
	Thu, 13 Feb 2025 15:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739460653; cv=none; b=BR19uiwLzJDVIAeOTheNIpCNeSasRilc56B/qFkXY9t/LW/ftP5zynp1RL47yjBaV2rPi1afRgRnYYiRasHGz7ZvpaYrBFxb7M+tGSsl1IBMhf+Qf/+9t8r7ZYVZ4xfbwIG6Bbl4MWtDO4ruFPPnRP0gXkG+E156+orIVCAwfLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739460653; c=relaxed/simple;
	bh=wpqBdgYCrkVPe3zyeTy8Rpi1usNHYornxiirneekDh0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GTPeeXWey/NnW7RiEczx7BABfRLPi6AamnWrvJUse/kJYVzWw3R7NC65nlFRIM99pLd0cmd4ILbDgDCk0NSUICQQMh/nbk1vu2K13T/nTy9kGk7tG5maw1SZG7iNRClfhM4QmL+h+oVrotqEeBJIi0umDqaKdQZ1mcoDH83HfPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=PtmoB1+K; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4324C4327E;
	Thu, 13 Feb 2025 15:30:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1739460649;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cSPo3S4QwhCTf4yRppXnD4bxwylZMuurUQ4Zm3rpVHA=;
	b=PtmoB1+K9ZJpqH7XU7YV+rkGa5/jQ96ghiUnt6VfxJVRxZYka5Ak+BMTqGWHQoJvheOSqD
	qGwvjShFz7i4ntX0vUQCB+tJEbcCJ8Dm/EEh7SAYuEm/jN9yewdGbbamUQSnarpvuUU5Xv
	jZI/Uy/kgLuzo1W0NMnqk6GTO+Orj9RtxNpsX+ilWiD8RV5pxlDVcEDdQ8QCloTBvbCTKB
	zXL8kh1gNSDnl79NNXC8x9iE+rMVTxGRWfescZRLAULJIKnwAD/60ucr5M9gOWIkK74Bn7
	81l4MFKwhUNtG9CzFZgvc7zyoMnlltSasP+dVZqLmyR89940UDzKcg/fqC0RMw==
Message-ID: <8e954934-b0af-4c80-9ca0-1914b65644f3@bootlin.com>
Date: Thu, 13 Feb 2025 16:30:48 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/12] bluetooth: hci_wilc: add wilc hci driver
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Marcel Holtmann <marcel@holtmann.org>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Ajay Singh <ajay.kathat@microchip.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, Kalle Valo <kvalo@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Nicolas Ferre
 <nicolas.ferre@microchip.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Marek Vasut <marex@denx.de>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, linux-bluetooth@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <20250212-wilc3000_bt-v1-0-9609b784874e@bootlin.com>
 <20250212-wilc3000_bt-v1-10-9609b784874e@bootlin.com>
 <20250213-fine-thankful-lobster-eed3e8@krzk-bin>
From: =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
Content-Language: en-US
In-Reply-To: <20250213-fine-thankful-lobster-eed3e8@krzk-bin>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdegjedugecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkfffgggfuffvvehfhfgjtgfgsehtkeertddtvdejnecuhfhrohhmpeetlhgvgihishcunfhothhhohhrrocuoegrlhgvgihishdrlhhothhhohhrvgessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepvdetteektdehudelheehkeeggfejgfelveevgeevtdejudfgveetgefhtdduuedtnecuffhomhgrihhnpegsohhothhlihhnrdgtohhmnecukfhppeeltddrkeelrdduieefrdduvdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepledtrdekledrudeifedruddvjedphhgvlhhopegludelvddrudeikedrtddrvddungdpmhgrihhlfhhrohhmpegrlhgvgihishdrlhhothhhohhrvgessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepvdegpdhrtghpthhtohepkhhriihksehkvghrnhgvlhdrohhrghdprhgtphhtthhopehmrghrtggvlheshhholhhtmhgrnhhnrdhorhhgpdhrtghpthhtoheplhhuihiirdguvghnthiisehgmhgrihhlrdgtohhmpdhrtghpthhtoheprhhosghhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrhiikhdoughtsehkvghrnhgvl
 hdrohhrghdprhgtphhtthhopegtohhnohhrodgutheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghjrgihrdhkrghthhgrthesmhhitghrohgthhhiphdrtghomhdprhgtphhtthhopegtlhgruhguihhurdgsvgiinhgvrgesthhugihonhdruggvvh
X-GND-Sasl: alexis.lothore@bootlin.com

Hi Krzysztof,

On 2/13/25 10:24, Krzysztof Kozlowski wrote:
> On Wed, Feb 12, 2025 at 04:46:29PM +0100, Alexis Lothoré wrote:
>> +#include "linux/bitops.h"
>> +#include "linux/byteorder/generic.h"
>> +#include "linux/err.h"
>> +#include "linux/gfp_types.h"
>> +#include "net/bluetooth/bluetooth.h"
>> +#include "net/bluetooth/hci.h"
> 
> Keep some order here. Why some are <> some "", why net is mixed with
> linux...

[...]

>> +	wilc_adapter = kzalloc(sizeof(*wilc_adapter), GFP_KERNEL);
> 
> Why not devm?

[...]

>> +	if (IS_ERR(wlan)) {
>> +		pr_warn("Can not initialize bluetooth: %pe\n", wlan);
> 
> dev_warn or even dev_err_probe to handle deferral.

[...]

>> +	dev_info(&serdev->dev, "WILC hci interface registered");
> 
> Drop simple probe statuses. sysfs already provides this.

[...]

>> +static struct serdev_device_driver wilc_bt_serdev_driver = {
>> +	.probe = wilc_bt_serdev_probe,
>> +	.remove = wilc_bt_serdev_remove,
>> +	.driver = {
>> +		.name = "hci_uart_wilc",
>> +		.of_match_table = of_match_ptr(wilc_bt_of_match),
> 
> Drop of_match_tr, you have warnings here.

Thanks for the review, true for all raised points, which will be handled in next
rev.

Alexis
> 
> Best regards,
> Krzysztof
> 


-- 
Alexis Lothoré, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

