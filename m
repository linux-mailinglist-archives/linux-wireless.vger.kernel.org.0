Return-Path: <linux-wireless+bounces-17571-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EA0BA12C29
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Jan 2025 21:01:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9F82166940
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Jan 2025 20:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E2C61EEF9;
	Wed, 15 Jan 2025 20:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="CBw/N5EW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49B75CA64
	for <linux-wireless@vger.kernel.org>; Wed, 15 Jan 2025 20:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.32.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736971286; cv=none; b=CGmSPQ5sJox32UIMllkE2VmdEggJDoSmT/gfNrehQt9jx6rm+kc4b6rVJ04MSyS0LvVyTkfvx4ZIhaFKd78eJ24gDRH7tk7ODxSim86xDhDmcLleAl18WIblFtj+SJ2qAYuJMOhUFvscsRYYXLn03qOuQNBq2ArALSlXJHb8yRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736971286; c=relaxed/simple;
	bh=ztvZH7sZlj3bd93v/OAQ3nwiPIMEUpmnb1Fkk+ei+xY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X+FhQZEPaz9pFjCbvjVHnCY93RZZIKO2mQbQd3F5fQcmnjBFpo/ikj9nZOaSFqMTlRj0iaS/5V9yXreC5gxMP+3XnfYaSYcv2s5MHi00WjO8w1kEmJeiSWuAPivTVCpjVkEWRkVWlKL3wLoIIY8qGy2/gwmkfBaHf2LinS0O5jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=CBw/N5EW; arc=none smtp.client-ip=89.58.32.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 863D2108882FB;
	Wed, 15 Jan 2025 21:01:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1736971281;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X9ILjOQk4NPNmK5CK+3GVxOdGc9rO9rWfNOAGkbPclU=;
	b=CBw/N5EWXNzEg+CeAFZbHqQ/XDPbkwTmbeODxWD4O3MOdPwdUuCGjuG6uykgauSRV1Qrwu
	i1c/yJvUvpnJcs6M4UHic2xgwR5TtD37Yjqn93AVlUTynIHMlQbXfxBfC8ZhKhBxU8gszb
	ZqO+1pm8jOtxianxD1DVDLvSldwG8zjl3S4c0xq3IcPIzDaNUrc8cFJ9YGjaQryGylTV9n
	2IVF57DIHKTcQ/0tkfi2Qi4QTVGFN47wdvM/ScmiD3OwaBNuPbWQYRWjg+IpgXr2iiR6vv
	rqBw5R8Ug6bs3ogSODNVCTEpEQCT8vuj7n2Bi2bm54h1bSVkeZUsI6sXoIUkig==
Message-ID: <b558af8a-a72b-4568-8ed7-5be22105a5c6@denx.de>
Date: Wed, 15 Jan 2025 20:02:28 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] linux-firmware: wilc3000: add firmware for WILC3000 WiFi
 device
To: Ajay.Kathat@microchip.com, linux-firmware@kernel.org
Cc: linux-wireless@vger.kernel.org, kvalo@kernel.org,
 alexis.lothore@bootlin.com, Sripad.Balwadgi@microchip.com
References: <20250115171751.7308-1-ajay.kathat@microchip.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20250115171751.7308-1-ajay.kathat@microchip.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

On 1/15/25 6:18 PM, Ajay.Kathat@microchip.com wrote:
> This commit adds WLAN firmware for wilc3000 which is supported in mainline
> Linux with commit [1].
> 
> FW version: 16.1.2
https://github.com/linux4wilc/firmware.git

containers firmware v16.3 , why add this old firmware v16.1 here ?

