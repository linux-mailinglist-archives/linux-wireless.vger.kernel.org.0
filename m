Return-Path: <linux-wireless+bounces-12141-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4745A9622B1
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Aug 2024 10:50:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03BCF285BAD
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Aug 2024 08:50:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98DC415FD1B;
	Wed, 28 Aug 2024 08:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="GX76gNlC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE41515AAB1;
	Wed, 28 Aug 2024 08:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724834991; cv=none; b=Y1ah0tUgOu2PwUuUrIaG8l2kG6Yd+BH+rpBjzE8XpvNe7FenYIjg7BuWBkVdDgifWDSKVGe3qvT1v0FzQeo3HCwWvn0ttCyyMeFGbCD31DNBXHdP1JAoz5wwQxn8uNylAy+sw74ipY71FWmH4welC7YqE+CtqV+pNSKOdn5ZZEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724834991; c=relaxed/simple;
	bh=w3UQh3YjOmm1mjxe74WKMB2wV1Vo9ThjngJkm+amIsg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bOyeWDp59AJ2wj4BPtqiO1avINQnhZ5Evg7ZsfoFVKmsks+ssuoW0lejKIypNsABmYS2ZdciGiBhey6IXNrDqOWmks5tmkVtga8zSenZsyYoks/h9qwI5hMNf+dtoNZps1ju2vmjLCTz/RtWRpOZzZqm5nlDXAA4Fi/IDIrslwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=GX76gNlC; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 355F020003;
	Wed, 28 Aug 2024 08:49:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1724834981;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4gq8FrzeR468IgCrdCZ/Q+Fpyxok8NZVzdlwUV3fWpc=;
	b=GX76gNlC35bLanfJ8uA1k45wFD8QcQz+pisBD4LzNth7RVHIzVJ+g2SADaajCI5WMdzCuB
	98BSZEoig7WsZIt7uLEpXuM/layn2VkLu2UkLkdGF0u8vdfTM/G1dCqYcIPJRtqgTf0x32
	tmh2At9COXdwpMKCleGomayjtDsSQccAW8KDn8p0pSDQWbwTvLNGnZ2aCG7alSpsmM4TNL
	oPzxCSI64H0PAc4u1Cn36CtYc3HOkLq0fxnyGw6MPgNQ8kMTwL58mRzMOFXjH38TOPsa4H
	M3jm/uaEmxlXFx5PD58kk3C4zLBp9d0EMRoGWy/FYGH++dmA9wmDKVl9Wln7Rg==
Message-ID: <0493044b-3e9f-40ef-8bd5-cc7ffdb035cc@bootlin.com>
Date: Wed, 28 Aug 2024 10:49:39 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/5] wifi: wilc1000: Fill in missing error handling
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
References: <20240827164042.53698-1-marex@denx.de>
 <20240827164042.53698-4-marex@denx.de>
From: =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
Content-Language: en-US
In-Reply-To: <20240827164042.53698-4-marex@denx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: alexis.lothore@bootlin.com

On 8/27/24 18:37, Marek Vasut wrote:
> Add error handling to chip_wakeup() and propagate the errors throughout
> the entire driver. Add error handling to acquire_bus()/release_bus() and
> host_sleep_notify()/host_wakeup_notify() functions as a result as well.
> Fill the error handling to all call sites.
> 
> Signed-off-by: Marek Vasut <marex@denx.de>
> ---
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Adham Abozaeid <adham.abozaeid@microchip.com>
> Cc: Ajay Singh <ajay.kathat@microchip.com>
> Cc: Alexis Lothoré <alexis.lothore@bootlin.com>
> Cc: Claudiu Beznea <claudiu.beznea@tuxon.dev>
> Cc: Conor Dooley <conor+dt@kernel.org>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Kalle Valo <kvalo@kernel.org>
> Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
> Cc: Marek Vasut <marex@denx.de>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: Rob Herring <robh@kernel.org>
> Cc: devicetree@vger.kernel.org
> Cc: linux-wireless@vger.kernel.org
> Cc: netdev@vger.kernel.org

Reviewed-by: Alexis Lothoré <alexis.lothore@bootlin.com>

-- 
Alexis Lothoré, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


