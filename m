Return-Path: <linux-wireless+bounces-12741-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 025B2972D1F
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Sep 2024 11:13:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1B521F260A9
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Sep 2024 09:13:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A14FF188A38;
	Tue, 10 Sep 2024 09:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="FFw35lxd"
X-Original-To: linux-wireless@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB8218859A;
	Tue, 10 Sep 2024 09:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725959592; cv=none; b=LB7bcXCQADYf2+l9rbRYj8TNrEpPwuEc1WfyUKbz72E4luCug86erRc6lT0ojZM5/jfBIhnnfMI+NTPuYZkLJdBmqmcZgT+mFRrGnnNJ6JThZX+Y4YkZOCc38l935qWIK2i78g4VZ5akpD4YFs/k9t24/AxOt01EVbIshwhUUcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725959592; c=relaxed/simple;
	bh=qTZxGGcz619C/JiS7yoQ1fa+JJZ6Jyz4D/6axGk5MYo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Nud7f+QTgJpMEQNL5SxixrSmgM+FFqz0EqU4NG8Yn7GcbI6HZZh9D5Y3kKjSYj/O+E70GNbY8w7J/j4bV2dbP0FNqx75Jcme7mSIgpU1/uUmXiCkkBN3HhC+gVCH3F15f8gmDNzwItJEvhRM5BhU2ZpBPJxYUA7KmdPpg6+74io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=FFw35lxd; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3334020002;
	Tue, 10 Sep 2024 09:13:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1725959588;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SkHrPrPvv0ycqknuXki++Kh1vXcSnQQukH5IsHU8Cww=;
	b=FFw35lxdII0wpy7i8uEBnaJ1xWXdTCjN9gKXMXDw61r1pMH8KPf6RcBHkYpnJY0q33/U21
	6ygqzJEzAGe9TgDs2LQH4C9JUrIT04VcvBvHiWVyZquOdoL6rEebCul7sz66ToEcYUmW5A
	G78xXIZlJsQP2dFQDHPS1XrrXJU3NHxlvYWYWoKo/B+Q/OwkZfzRIZCnnXrP6J0MjCNTxP
	VJdK/dxD+IPr5jDttNe3pc09iv8CpLb90FvFH6c0+NW5UNKtKtsLGIR0Yg4aFJUOMSKGZw
	QSY/uDVRnQwTMUThTudscaNTbOb56sCg3g7sVnv3w9epiIIOgvKOLwYAEVYZZA==
Message-ID: <5ae8121f-8ead-4d7e-9fbd-417c273474e5@bootlin.com>
Date: Tue, 10 Sep 2024 11:13:06 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/9] wifi: wilc1000: Fill in missing error handling
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
References: <20240909193035.69823-1-marex@denx.de>
 <20240909193035.69823-4-marex@denx.de>
From: =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
Content-Language: en-US
In-Reply-To: <20240909193035.69823-4-marex@denx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: alexis.lothore@bootlin.com

On 9/9/24 21:29, Marek Vasut wrote:
> Add error handling to chip_wakeup() and propagate the errors throughout
> the entire driver. Add error handling to acquire_bus()/release_bus() and
> host_sleep_notify()/host_wakeup_notify() functions as a result as well.
> Fill the error handling to all call sites.

Out of curiosity, what tree/branch are you using as a base for this series ? I
wanted to pull it locally to also test it on wilc1000, but it fails to apply
this patch, and the failure points to a conflict with one of my patch which has
been merged quite some time ago in wireless-next:
https://lore.kernel.org/all/20240613-wilc_suspend-v1-4-c2f766d0988c@bootlin.com/

Thanks,
Alexis

-- 
Alexis Lothoré, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


