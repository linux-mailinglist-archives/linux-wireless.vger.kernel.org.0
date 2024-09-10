Return-Path: <linux-wireless+bounces-12754-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D0EB9735A7
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Sep 2024 12:54:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF6C71C21135
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Sep 2024 10:54:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 678D917C220;
	Tue, 10 Sep 2024 10:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="BR24SVdG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D049D5381A;
	Tue, 10 Sep 2024 10:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725965693; cv=none; b=Ez7FMWooIHE6KzJZkGH14pvg4uYzLc8zboxnNcVKg4rvc8cZ+Rspsbkbs5saSM9rRFXYnZTZi6HdlyJ1PtwbjkUJAtAONcmrM3h0YGqF8kY+I7eqMcvppI4khr7dAI+bJfsG8n2Y8ivrQJXbznfOEJkiqG20mutNRvrHc/sWgA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725965693; c=relaxed/simple;
	bh=Wh+owzRCtjJxHLGFaI5wLRWKWVcggyAybw6Eyx2lcng=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Eak674zQkE2rtMM2cKiD/xII5tXoNqLs2pmXtTWXDeLAVsbaSIjlavQd2cWYdk4dTmdGpelVCVj4gbzmu1dvkUfmK5B29E0fU6V6X+6cpuYEvqqZMbpBrx+hgOzqNSJmRJ3XQjC4lYXLoz7zgI4/Tkybl/HaDsF7LIDK3jVgDMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=BR24SVdG; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 666B688F86;
	Tue, 10 Sep 2024 12:54:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1725965690;
	bh=qoaKpe8hmZdXvzj3KdwHJhDf5BJ8aJPHolFz1r34tCI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=BR24SVdGaBvfhqXIeXNufheEmEPyT6Ph2a4hA/0NoIl6PC0YBO8A8q9twKZSRRFY7
	 kwbtwguSZMrCh2KKcExaAir5U6GJaJsXayzVFvmQIGnhFWhFwnYqrd1wImPmb+sT70
	 hE5pInkFG9s7tOmemPU331PBT+mh0GnRk8kHCzVW6aPc6mmDqyQuQW3D9EINx6aa6Z
	 9ilvNHXrUvNbept55vrWFRHPxjqraBtdjmBehsBlu+fffBRjtchhrXHGgII3CY/MKy
	 +kZ2L1FdGolWpPKLIoxg8ANq++yTTxNyfa7n7wzHtkRj84kAXuRWHnBApMQ0529k58
	 WZv195s1WlgiA==
Message-ID: <25704805-b98a-43ac-b54e-2857b12e1574@denx.de>
Date: Tue, 10 Sep 2024 12:49:05 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 6/9] wifi: wilc1000: Remove cmd53_buf() allocation
To: =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
 linux-wireless@vger.kernel.org
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
 <20240909193035.69823-6-marex@denx.de>
 <9602d2a7-8397-425a-b567-bc06422d89ec@bootlin.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <9602d2a7-8397-425a-b567-bc06422d89ec@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 9/10/24 11:47 AM, Alexis Lothoré wrote:
> On 9/9/24 21:29, Marek Vasut wrote:
>> The cmd53_buf is a 4 byte buffer, embed it into the struct wilc_sdio.
> 
> Is this change really desirable ? I mean, looking at git log, it looks like this
> kzalloc is voluntary, for usage with DMA (see [1] as initial fix and [2] as the
> final patch which has landed in the driver)
It is unrelated to the series, so I'll just drop it for now.

