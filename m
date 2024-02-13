Return-Path: <linux-wireless+bounces-3550-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83CBE85339D
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Feb 2024 15:52:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F56B28CE2D
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Feb 2024 14:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D55835DF2C;
	Tue, 13 Feb 2024 14:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Y0COmzHH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2970757884
	for <linux-wireless@vger.kernel.org>; Tue, 13 Feb 2024 14:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707835952; cv=none; b=PL0TxiqDl4xNeECWoXvRTVQU0Gwd3NJV2yDVUGGKhWfMhntWciJTdmsBvvkCPejCG56gNarbiWCabGz/CcJoa+IqYqhLsrHS3XUDlcyYirggpOqbN3oSfPTIm7oxtW6a0Q3db6RNN2KbLBvB6V8AFhSt4lsQqcmcyWm/FTm6ZH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707835952; c=relaxed/simple;
	bh=DEh+YwdkwB3QgBLBT0vkwFtZFCxMc2Js1vJfeh38fjA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YoJSbtPNsBHdkQ7moaaZyQxcGmn978E4diVUxcjh7yGmRJXbD9ryoP2t9MYj4ABEdj8b2RW6BgdI4HbE5tV9h4blkXsJwER/hr5A45GErInxNuP4ZzLpLxvU4RyM2lKxnEMiL4Yr+VxKPANx/tuw/G45pkcHJDsx8vrEW7csGWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Y0COmzHH; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id C93D11BF211;
	Tue, 13 Feb 2024 14:52:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1707835942;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OpfNohTE5kQaS0jSU0QJqCgEPiKlpuM+LN2XbjHIE0Q=;
	b=Y0COmzHHY3HRHW0T/5C06fD69HRd4LmT7AYB06bkKwrWUqc4gQxIy+GE/tTtcvm5xa91lj
	XvUQilMkbMx5lKQZJtbq8q/OO6kon+eA3r02RTIPsmZSxGgI6rXEDQXEDfNBuK5jzA7Mb3
	OH8RkU3vr9ENR3GY6WhkPnvEy7jBUdPuKM/+AcIgU3mOd03pgCTTcjQi6HIU4PFyUUxaTu
	ByYmPfoQU7WrZCr8OBQQbkSQxHHHEAXs36+xJ5FnH8hXs+zuRh6EQTZC3VhgNGZa7ermmt
	XdzflmBJbtSFFnLeVPg5lJU4IY9ZZ1yDKRjMKLJYLNjl67VGJINbM8INXlITNQ==
Message-ID: <31f4f7e0-0853-4f10-9dc7-56b72e251c9e@bootlin.com>
Date: Tue, 13 Feb 2024 15:52:21 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: wilc1000: validate chip id during bus probe
Content-Language: en-US
To: David Mosberger-Tang <davidm@egauge.net>, linux-wireless@vger.kernel.org
Cc: Ajay.Kathat@microchip.com, kvalo@kernel.org
References: <20240212202057.3468714-1-davidm@egauge.net>
From: =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
In-Reply-To: <20240212202057.3468714-1-davidm@egauge.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: alexis.lothore@bootlin.com

On 2/12/24 21:22, David Mosberger-Tang wrote:
> Previously, the driver created a net device (typically wlan0) as soon
> as the module was loaded.  This commit changes the driver to follow
> normal Linux convention of creating the net device only when bus
> probing detects a supported chip.
> 
> Signed-off-by: David Mosberger-Tang <davidm@egauge.net>

Tested-By: Alexis Lothoré <alexis.lothore@bootlin.com>

-- 
Alexis Lothoré, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


