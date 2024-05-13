Return-Path: <linux-wireless+bounces-7597-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF3AA8C4302
	for <lists+linux-wireless@lfdr.de>; Mon, 13 May 2024 16:16:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16D05282841
	for <lists+linux-wireless@lfdr.de>; Mon, 13 May 2024 14:16:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ECD215383F;
	Mon, 13 May 2024 14:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ETl/Gfgk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DB7F153BC1
	for <linux-wireless@vger.kernel.org>; Mon, 13 May 2024 14:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715609772; cv=none; b=AQ27N9g8y5rbDUGiERA+D57pwAHDp5fN0H8oPU5oMgeYAgGsSf0c1nap+RQf7yYD2gbF1m3/3XxN9Ht8k/osM5Za4p4+j5K3flP3bs6flvt0L5rRzAuzRUPLpIh7oaOL6ytrhbveM/oRX6ZUOzWgjka2WD83tD5t6UjuPOCzpk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715609772; c=relaxed/simple;
	bh=wfzIXG1YzIpsWivt/YC7eycM6lNE3PrvE4CmNR0mV/8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GwuY3a4KoSztRQGLd2qkedQIHNcWyWGmKn1MbVOaCp4mnv16WSbi9HT1CLuNy1PhyyHmIwpvD2ZfepqT+M8KywAdiNzZfZSlyQsg3M5mQvRZQPqDSWy+Znzcf25EH3+2u5WPDOxtWCQWnVxTGxfGprNowaFbw28fEaGi+Tu5DBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ETl/Gfgk; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 172821C000B;
	Mon, 13 May 2024 14:16:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1715609766;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4j6ctlYBcpB505D7n+kS+LBg8muwEW1UM1JH2tiewwg=;
	b=ETl/Gfgkl9L6eKAfBEej7lfsDJgxVsaAlGBpO5f9EwLB7ky0FpywNwLngs7wEseao5Q9Vf
	zhH1fDzPHe4zO7druQeoOeWg2htZq6cFAZUkGyH2RsQUNXpVGGUye20mriLD84SAqEkhUm
	JtBXzsYS3Ix4livQDRHk5DksZ63qHfVrJNkkbnuiShiLh1VzLS7ZwyJChFXm/Bn+S/PwpD
	Fd2ecLrCmhfHm0qHPIBE5OmeeemG42a5ADb5b8cbsdvSHMdb7QPr4WewbRhdTECez9wluS
	fZQ+58fn3er0bs5DEWkDBUgCmub+Sp4LfOfRQDqrLihzFhO1lGKOeVrz7+YYCA==
Message-ID: <1a982ba8-c5f3-415a-bb39-fae9973b100e@bootlin.com>
Date: Mon, 13 May 2024 16:16:05 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bug report] wifi: wilc1000: convert list management to RCU
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: linux-wireless@vger.kernel.org
References: <3b46ec7c-baee-49fd-b760-3bc12fb12eaf@moroto.mountain>
From: =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
Content-Language: en-US
In-Reply-To: <3b46ec7c-baee-49fd-b760-3bc12fb12eaf@moroto.mountain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: alexis.lothore@bootlin.com

Hello Dan,
sorry for the late reply

On 5/9/24 15:24, Dan Carpenter wrote:
> Hello Alexis Lothoré,
> 
> Commit f236464f1db7 ("wifi: wilc1000: convert list management to
> RCU") from Apr 10, 2024 (linux-next), leads to the following Smatch
> static checker warning:
> 
> 	drivers/net/wireless/microchip/wilc1000/mon.c:236 wilc_wfi_init_mon_interface()
> 	warn: sleeping in atomic context

I am struggling to reproduce the warning in smatch. I executed those basic steps:
- clone and build latest smatch
- checkout linux-next master branch
- export ARCH and CROSS_COMPILE
- load a defconfig enabling all features in wilc driver
- run ~/src/smatch/smatch_scripts/build_kernel_data.sh
- then run ~/src/smatch/smatch_scripts/test_kernel.sh
Yet I do no see any mention to wilc in the resulting smatch_warns.txt file. The
outcome is the same if I run smatch only on the wilc driver:
- ~/src/smatch/smatch_scripts/kchecker drivers/net/wireless/microchip/

Am I missing something obvious ?

Thanks,

Alexis

-- 
Alexis Lothoré, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


