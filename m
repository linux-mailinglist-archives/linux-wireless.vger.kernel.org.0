Return-Path: <linux-wireless+bounces-8182-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB8318D1748
	for <lists+linux-wireless@lfdr.de>; Tue, 28 May 2024 11:31:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13A301C22EA2
	for <lists+linux-wireless@lfdr.de>; Tue, 28 May 2024 09:31:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72E42158A0F;
	Tue, 28 May 2024 09:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="fc3tSgkx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCB0515885F
	for <linux-wireless@vger.kernel.org>; Tue, 28 May 2024 09:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716888681; cv=none; b=cnr9VTEHQeiqueLgXdg30A1o77PJKRNQdA4sV60N64AGOTDAXb2Z9yjAn8yRmqIIVvUKTHk+YRqyc8HfiGfgz08NSs8dvk/a6wzQbG/gaOqMqrSDPUAQwx0CvaF2ghIKJ3GgG/6eEyhgeBUliaugG27UA8rvxrbzRH+kK/f61n0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716888681; c=relaxed/simple;
	bh=jfFX90uZOymu9T8b0XnhNHmoMFCMd1+uiHn8SXAv3+c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BSzgCATX0SEbhRQFzl7DdwlKxBru4h1LkNN5EB8gZvH+xBRo5uQbZ35jvLlAqYCBUP6CYWi0MCCNk8Yes+eV1FC8GNdL1fRG+0PaS6jL7B7qM/1EpnRHeDIjkgR5J9efhlrclgeY5bTdj67d1IjSMkSd+UA1s1LHL3XRihJrH74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=fc3tSgkx; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 98484C000C;
	Tue, 28 May 2024 09:31:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1716888676;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1MkSEDJwrWNIPR0bchm1t68CwLKFDFfr/6JApuMvURM=;
	b=fc3tSgkxInE+1aS3Bl7WGkHvPjXSRPg4LrNbrrr+vmxItszOJ0/i4VIPZjkXmgKS1zpdO1
	piqS71ZMoGizJFriwZ46VsJhEW/WRXqg0J8FZ8XB+Y6KTmGn4kYWjVF4AIJ6+7ssiCB3ra
	eSOhYYHNQagTWgtXFjMgPofFcLT0tU+w6x6Kp2CSEs6ILuMURWnUhvQ54ie7234dqJ2baW
	Gvhnlm7zL594KAxqueCjkW/4hMcNZW0IQ6/Zx85P/OokE1Fde8lpjvF7Ifena+12ykr9hY
	iBT8QhaNdv18rS8GpLzhlm4H4K+6LhhUGGAQH/EmLOwVxwcQpmKlNoXxyE/Dkw==
Message-ID: <0a9c592d-7db3-454e-a83f-901b1865b414@bootlin.com>
Date: Tue, 28 May 2024 11:31:16 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bug report] wifi: wilc1000: convert list management to RCU
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: linux-wireless@vger.kernel.org, Kalle Valo <kvalo@kernel.org>,
 "Ajay.Kathat" <Ajay.Kathat@microchip.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
References: <3b46ec7c-baee-49fd-b760-3bc12fb12eaf@moroto.mountain>
Content-Language: en-US
From: =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
In-Reply-To: <3b46ec7c-baee-49fd-b760-3bc12fb12eaf@moroto.mountain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: alexis.lothore@bootlin.com

Hello,

On 5/9/24 15:24, Dan Carpenter wrote:
> Hello Alexis Lothoré,
> 
> Commit f236464f1db7 ("wifi: wilc1000: convert list management to
> RCU") from Apr 10, 2024 (linux-next), leads to the following Smatch
> static checker warning:
> 
> 	drivers/net/wireless/microchip/wilc1000/mon.c:236 wilc_wfi_init_mon_interface()
> 	warn: sleeping in atomic context

My bad for the extensive delay to fix this. I have been in fact scratching my
head quite a lot around it. Adding Kalle and Ajay to keep them updated, and
possibly to get opinions.

This issue is indeed due to my recent series converting back SRCU to RCU in wilc
driver (submitted because at this time, there was no obvious reason nor
documentation about why SRCU was needed). By checking further the consequence, I
find in fact three issues, and I suspect those to be the original reason for
SRCU usage in the driver instead of classical RCU. All of them are reproducible
with runtime checkers enabled regarding RCU and sleeps in atomic sections,
either by triggering some heavy traffic for the first one, or raising an access
points for the two others:

  - one issue is in wilc_wfi_init_mon_interface (the initial warning raised by
Dan). This one:
    - parses the vif list (under RCU) to perform some checks, possibly canceling
    the interface registration
    - then registers the monitoring interface (has sleeping calls, especially a
register_netdevice call)
    - then if registration is successful, updates appropriate vif to flag it as
monitoring interface (then leave RCU section)
  I have a hotfix for this, but not a very satisfying one, which consists in
splitting the RCU section into two (first and third points), but additionally
using the vif list lock to make sure vif list has not been altered in-between.
IMHO this kind of fix just make things worse in the driver, just to tame RCU.

  - one issue is in wilc_wlan_txq_filter_dup_tcp_ack (the second warning raised
by Dan), which calls wait_for_completion_timeout while being in RCU critical
read. The issue can be properly fixed by just counting the number of packets to
be dropped inside the critical section, then effectively applying the multiple
wait_for_completion_timeout _after_ the RCU section.

  - finally, there is an issue in set_channel ops (cfg80211.c), which fetches
the first vif (under RCU), and then uses this vif to send appropriate channel
configuration command (which sleeps at some point). Since used vif here comes
from the vif list, I don't think it is safe to leave earlier RCU section (vif
pointer needs to remain valid until command is sent to chip).

Because of the second point which would bring a not-so-clean fix, and the third
one for which I still don't have a proper fix, I am considering to submit a
revert for my RCU conversion series, to come back to SRCU. I don´t know if those
issues do or do not make SRCU usage more legitimate, but at least I feel like
really fixing it need slightly larger rework. I will still search for better
options, but if I do not find any, I will submit the revert.

Thanks,

Alexis

-- 
Alexis Lothoré, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


