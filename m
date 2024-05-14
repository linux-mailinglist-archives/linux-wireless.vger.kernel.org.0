Return-Path: <linux-wireless+bounces-7634-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EDB478C4E42
	for <lists+linux-wireless@lfdr.de>; Tue, 14 May 2024 10:59:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D59A1F2297E
	for <lists+linux-wireless@lfdr.de>; Tue, 14 May 2024 08:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA8F61CD2B;
	Tue, 14 May 2024 08:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="jzw/DTtZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 032AD125C1
	for <linux-wireless@vger.kernel.org>; Tue, 14 May 2024 08:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715677184; cv=none; b=qS+zNudi4APJDIjCb3agPgV+WmU3hukpDCSsJPg1+89vq3ufLSfmVAuf1PEhM7fofI15fQ3Nf1aT/L2MinRpz0RcgRyj+EjS4EUjWZuUHozOSWtOL578EBkBsJ7swwuQSEzqnrpj7VmZ48HN4C50b13GCGfD+PQA1BMqeRaurp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715677184; c=relaxed/simple;
	bh=UMQ2dS6qvcm+jQUru3w7yZxQitHSNkkv36pED7OJzw8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y1cqUP+knhAiJRlxqwUPbon3Dv2uVniUIh/batb3jlB2VKM/ILgK35eEe8jYU64JkXOHQuHCeyq204FCco/a0xiKKl436k4IWiDyTGEDKhq45tSSUgXgmuxwAI461ubhct0I/vmCaPiFIqkEueGdotl4dOoUssDEsXXXxssghUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=jzw/DTtZ; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id E956440009;
	Tue, 14 May 2024 08:59:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1715677179;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MomaDHcQ720zOeANXso6trR71GZq9flz5oVBCp1e1GM=;
	b=jzw/DTtZLT/L18sqVbA1ysb6Kkf7rAHWJB/y50WNZQH73BOhYW7cB2jozn0a15i2O0sDWf
	J3/E5/TK1cBjNYibO0tioE4jpA21nKt0U6WpqkjJVdilWYgDS8AaDLo1K264Lj68e8R4cw
	s6x1mTf/R7EEC6Q9Xw20VvHW7apVsf8gUOAajAFGUPx7TJkP0VXAQJdFLZ4Zh1pGeEPaFY
	uOmVmn2nkCx0IpdRoN4era+IvL2P2hrN/urVgp+lZd46outYeDdc77NbLa5vjsK8oK0Yhv
	d/5SZxORBkChnMJTRkFd+6w5DBmw6RCUuFn1Op4QbVGR0Di5e4MD1ELUjy9BsQ==
Message-ID: <812f01e5-58e8-4128-b329-a2456c7e6b86@bootlin.com>
Date: Tue, 14 May 2024 10:59:38 +0200
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
 <1a982ba8-c5f3-415a-bb39-fae9973b100e@bootlin.com>
 <8ee9481f-7677-4a0e-be11-0c81d4bbef9f@suswa.mountain>
From: =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
Content-Language: en-US
In-Reply-To: <8ee9481f-7677-4a0e-be11-0c81d4bbef9f@suswa.mountain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: alexis.lothore@bootlin.com

On 5/14/24 10:54, Dan Carpenter wrote:
> On Mon, May 13, 2024 at 04:16:05PM +0200, Alexis Lothoré wrote:
>> Hello Dan,
>> sorry for the late reply
>>
>> On 5/9/24 15:24, Dan Carpenter wrote:
>>> Hello Alexis Lothoré,
>>>
>>> Commit f236464f1db7 ("wifi: wilc1000: convert list management to
>>> RCU") from Apr 10, 2024 (linux-next), leads to the following Smatch
>>> static checker warning:
>>>
>>> 	drivers/net/wireless/microchip/wilc1000/mon.c:236 wilc_wfi_init_mon_interface()
>>> 	warn: sleeping in atomic context
>>
>> I am struggling to reproduce the warning in smatch. I executed those basic steps:
>> - clone and build latest smatch
>> - checkout linux-next master branch
>> - export ARCH and CROSS_COMPILE
>> - load a defconfig enabling all features in wilc driver
>> - run ~/src/smatch/smatch_scripts/build_kernel_data.sh
>> - then run ~/src/smatch/smatch_scripts/test_kernel.sh
>> Yet I do no see any mention to wilc in the resulting smatch_warns.txt file. The
>> outcome is the same if I run smatch only on the wilc driver:
>> - ~/src/smatch/smatch_scripts/kchecker drivers/net/wireless/microchip/
>>
>> Am I missing something obvious ?
> 
> Yeah.  I'm sorry, I need to write a blog entry about this.  These checks
> rely on the cross function database, and you need to rebuild it a bunch
> of times.  It's a simple process but very time consuming.
> 
> Instead of that, it's better to do run time testing using
> CONFIG_DEBUG_ATOMIC_SLEEP=y

Yes, that's what I have been doing in the mean time, and it allowed me to at
least reproduce the second bug you raised, but I just wanted to make sure to
have suppressed those issues once I will have written the proper fixes. I'll
continue with the runtime checkers like CONFIG_DEBUG_ATOMIC_SLEEP :)

Thanks,

Alexis

> 
> regards,
> dan carpenter
> 

-- 
Alexis Lothoré, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


