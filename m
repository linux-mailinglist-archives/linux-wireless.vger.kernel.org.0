Return-Path: <linux-wireless+bounces-12035-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B90C7960527
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Aug 2024 11:10:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 774C02835EB
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Aug 2024 09:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00FEA1991D0;
	Tue, 27 Aug 2024 09:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="XNp1uzxW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E831176FD3
	for <linux-wireless@vger.kernel.org>; Tue, 27 Aug 2024 09:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724749851; cv=none; b=UXRkivj3/5kjlCE7yJknDf15apGtWY3gjUO7ZxF1vjBwefp9P63nZCcMGXGLLJVgF/eFcIfMNzQiZ7Yayt+ozA0HS/Y2ADA3wu8TZe/6EMbIBSBofZcyuny3swPKo3LMjA5NXsW3Gn0nXv1h8lKScP/UMd98xrXpgdc4yJszXJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724749851; c=relaxed/simple;
	bh=18VdJQ/yupsIVWiONnvobY1EbdXDa9MSKxSg4CfIZ5A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uGAMOeMXEExADfEF+HxRyioGOLSbN6LpIMCzpCqya/Pi7LebLf0CnPn/yEtMLOBX+U9WAQ6KRn4HnMS34G6Uzpe1wV78neUDq5+wWfPNqj9AbQiWMxHknXy6P5Ks2tZr6gb4dhSolXVscL6Szh6A2viDyS5FOsrOGRTSdeGwh1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=XNp1uzxW; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 67442FF806;
	Tue, 27 Aug 2024 09:10:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1724749847;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NJsGBE04xrI6b+hXf346IuhAHMbt7kwD8waQAkunPug=;
	b=XNp1uzxWQXowQAUlsnQbrz7mfJqoafkWdMqbHHAB9Dext2y/SrpbpiPyafKkycwx2abkXZ
	e8tPupmn4OCHgEK1ykyAUkUwIjE9wd8WZrr3cgwZqSVOajVEfmRwEkbxhPj+OJGEfvQ6NV
	1Q3K2thynmEh+vstDvhLTFiqEmIXHfBtHr+VLmM/jX9S8+osxgI823Bqg0Nq2v7OoDb53V
	98QzPA/FDP36Pkwf4BQO8B9K5YOECP1hV1FSRP7llS+9dgqTkIr/CDA4Qd1b3itYOH0fFn
	E03n3XweKwgfBkd1iL+Isb2l/3Kyol9rYzB4e8wg13Q/AqhNtO84245s7rZuZw==
Message-ID: <da6d4237-e207-4894-87c9-a75fffd318bc@bootlin.com>
Date: Tue, 27 Aug 2024 11:10:47 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: wilc1000: Re-enable RTC clock on resume
To: Marek Vasut <marex@denx.de>, linux-wireless@vger.kernel.org
Cc: Ajay Singh <ajay.kathat@microchip.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, Kalle Valo <kvalo@kernel.org>
References: <20240821183717.163235-1-marex@denx.de>
From: =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
Content-Language: en-US
In-Reply-To: <20240821183717.163235-1-marex@denx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: alexis.lothore@bootlin.com

On 8/21/24 20:36, Marek Vasut wrote:
> The wilc_sdio_suspend() does clk_disable_unprepare() on rtc_clk clock,
> make sure wilc_sdio_resume() does matching clk_prepare_enable(), else
> any suspend/resume cycle leads to clock disable/enable imbalance. Fix
> the imbalance.
> 
> Signed-off-by: Marek Vasut <marex@denx.de>
> ---
> Cc: Ajay Singh <ajay.kathat@microchip.com>
> Cc: Alexis Lothoré <alexis.lothore@bootlin.com>
> Cc: Claudiu Beznea <claudiu.beznea@tuxon.dev>
> Cc: Kalle Valo <kvalo@kernel.org>
> Cc: Marek Vasut <marex@denx.de>
> Cc: linux-wireless@vger.kernel.org

Reviewed-by: Alexis Lothoré <alexis.lothore@bootlin.com>

-- 
Alexis Lothoré, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


