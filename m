Return-Path: <linux-wireless+bounces-10611-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 34A8F93F0AF
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jul 2024 11:13:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA128286043
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jul 2024 09:13:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECA6513D8BF;
	Mon, 29 Jul 2024 09:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="jelfHMZe"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29D6D13D63D;
	Mon, 29 Jul 2024 09:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722244347; cv=none; b=MdHjPwiVYNjxLd9jYSvqZfE3THxlAGRPUDZLZN+VJGXv6xwjeM7xQVY6iGUpjKkagtKn4o5TGAt1Tj9/vSF3MKNMCfZlFB8LRtLNRDE0lRM4stC1wlHz3dYuxc8dt5HF4du8ixjXEj7UYFuKzp3YlWBg/dRFVj0a24QstAzxU10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722244347; c=relaxed/simple;
	bh=UsWGMWJQJ2WgdALuKi1nebGY0MGxQLg/y0f9U8d4lH0=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=GSBwq8qgytn7zjWD4F3FiBLjghSa6gyCmt/vQn1aiG3cx1oCu7PbgQaj9zlfROj9QpQpvrerZpI3gcn9OPAWOSZafjpedbb/3hIk0b80pvzgtCorIQcGKhJNYkbAzKk2h3GBNo0Pi1Z8FDe7+AeTzkOl+6kSX2KxYuap38uxR2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=jelfHMZe; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1722244342;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pswipPAaVOFmPwBSVAMERH4Feh9aaMUGuX9A7jGGpDg=;
	b=jelfHMZeLyyD0sapjj+wGdwlqNR8cQumQFm2t56MTOnLKQccXRYSWmnMsLSEZVc7C1Iss0
	jdETKXZ6hftIhwKI+lYVHPv5R0g4CzqB4bjK2fFmE9ksA5oXusgU6SazoBgKKJ2ZaWPTQ1
	TL9EVQlFA6+WzdHR+1P+41DBnWhd+QJXkeQOtLLnGY1DqCQfO5Lg/6mjBomJtuMYL3Wbt3
	5zBAqBcI7GanYJLZmHe7A83habOlPkJbPs7qM/LZBiD2+HNZNEck9K6YZsA4Ddzq7abFnh
	MWqGTYJefH5bg78jP7Z2KYp06+SwaTQ53XU1RUaag6O7SenK98RCuGC2yTm90g==
Date: Mon, 29 Jul 2024 11:12:19 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Dragan Simic <dsimic@manjaro.org>
Cc: Jacobe Zang <jacobe.zang@wesion.com>, robh@kernel.org,
 krzk+dt@kernel.org, heiko@sntech.de, kvalo@kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 conor+dt@kernel.org, arend.vanspriel@broadcom.com, efectn@protonmail.com,
 jagan@edgeble.ai, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, arend@broadcom.com,
 linux-wireless@vger.kernel.org, netdev@vger.kernel.org, duoming@zju.edu.cn,
 bhelgaas@google.com, minipli@grsecurity.net, brcm80211@lists.linux.dev,
 brcm80211-dev-list.pdl@broadcom.com, nick@khadas.com
Subject: Re: [PATCH v4 4/5] wifi: brcmfmac: Add optional lpo clock enable
 support
In-Reply-To: <qetrwlvqekobedpwexeltaxqpnemenlfhky2t2razmcdtwlcv3@qdlesuiac2mr>
References: <20240729070102.3770318-1-jacobe.zang@wesion.com>
 <20240729070102.3770318-5-jacobe.zang@wesion.com>
 <d7068c96e102eaf6c35a77eb76cd067d@manjaro.org>
 <qetrwlvqekobedpwexeltaxqpnemenlfhky2t2razmcdtwlcv3@qdlesuiac2mr>
Message-ID: <9f248b0e2645a29b83ee503701e04d57@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Ondrej,

On 2024-07-29 10:44, Ondřej Jirman wrote:
> On Mon, Jul 29, 2024 at 09:12:20AM GMT, Dragan Simic wrote:
>> Hello Jacobe,
>> 
>> [...]
>> 
>> >
>> > +	clk = devm_clk_get_optional_enabled(dev, "lpo");
>> > +	if (IS_ERR(clk))
>> > +	if (clk) {
>> 
>> These two lines looks really confusing.  Shouldn't it be just a single
>> "if (!IS_ERR(clk)) {" line instead?
> 
> It should be `!IS_ERR(clk) && clk` otherwise the debug message will be
> incorrect.

Ah, I see now, thanks.  There's also IS_ERR_OR_NULL, so the condition
can actually be "!IS_ERR_OR_NULL(clk)".

>> > +		brcmf_dbg(INFO, "enabling 32kHz clock\n");
>> > +		clk_set_rate(clk, 32768);
>> > +	}
>> > +
>> >  	if (!np || !of_device_is_compatible(np, "brcm,bcm4329-fmac"))
>> >  		return;

