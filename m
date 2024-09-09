Return-Path: <linux-wireless+bounces-12687-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7610A97211F
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Sep 2024 19:40:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6936B238A9
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Sep 2024 17:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F367A18952A;
	Mon,  9 Sep 2024 17:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YKcxBhl7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C540E17B4E1;
	Mon,  9 Sep 2024 17:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725903088; cv=none; b=FYkyV22bIHETcflDOztYRump4OOFJPAvdEQbXSJuDEUrVj+kME7hBI2V4i82BvLvDtLN917URO3Lx07pS9TFqRAJvBOG3RsCqWaVbodNMVZ2b17H7+zmLZ0Ad+VQNNg2EmPChQ6AhRlMAqPWAnjpk0NDMTnGXK8NDOm4n70BJdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725903088; c=relaxed/simple;
	bh=s1JqYI7ujxyuN5CqiWW5tvRXDZUlN+szue4aqm6YliE=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=Vpy/TwVxeIpzbt7W817ct8QODkUESsrZqHcetHNuKdD3vXCptIvAhtXFfQmGzR6ahcw9ao3atQOWkyPIY0R8K1qjtBGklD+e7eXqu2UZSLUSCqEx/YeinvXOeHImvljSlOCDaVUVXwZddLttGhMtaXOV9z4qreh3huWfqTtyhQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YKcxBhl7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 565BAC4CEC5;
	Mon,  9 Sep 2024 17:31:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725903088;
	bh=s1JqYI7ujxyuN5CqiWW5tvRXDZUlN+szue4aqm6YliE=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=YKcxBhl7ZWVX8vBS19EpypI/D/DyKDuXNZ/Ent6+SgcaXztQBBZMMlX8Y7nJ6Y36U
	 tvqgOkObgChC4cMh7miTxOPqUj5SYlk/j6plYQZt++7zLLqmfKr0ePI+8n55Bgn7eE
	 75NIUWSLW5L9IlUeaFHaU0GuWDRbin7LniT/I4bJUBNRHAc7E8GUFyLxdsNXm+mCDu
	 Txork5k3+7PpALutZ9Kk5YlsIybv6A29TYs31Xno6ud7lzDCQp30FSXJ72ov/yH+Ob
	 1CSdhbN618YprBjEAQw1W3RGpfDXFdREaB5d0EAaQBwk3w9NhZWdp8FmtGXMa/O9uM
	 qn/HFsTpiKVew==
From: Kalle Valo <kvalo@kernel.org>
To: <Ajay.Kathat@microchip.com>
Cc: <marex@denx.de>,  <linux-wireless@vger.kernel.org>,
  <davem@davemloft.net>,  <alexis.lothore@bootlin.com>,
  <claudiu.beznea@tuxon.dev>,  <conor+dt@kernel.org>,
  <edumazet@google.com>,  <kuba@kernel.org>,  <krzk+dt@kernel.org>,
  <pabeni@redhat.com>,  <robh@kernel.org>,  <devicetree@vger.kernel.org>,
  <netdev@vger.kernel.org>
Subject: Re: [PATCH v4 5/5] wifi: wilc1000: Add WILC3000 support
References: <20240829004510.178016-1-marex@denx.de>
	<20240829004510.178016-5-marex@denx.de> <87ed5tgofh.fsf@kernel.org>
	<7205210d-8bf8-41ba-9462-38e619027a45@microchip.com>
Date: Mon, 09 Sep 2024 20:31:23 +0300
In-Reply-To: <7205210d-8bf8-41ba-9462-38e619027a45@microchip.com> (Ajay
	Kathat's message of "Mon, 9 Sep 2024 16:51:35 +0000")
Message-ID: <87le00g2dw.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

<Ajay.Kathat@microchip.com> writes:

> On 9/9/24 02:35, Kalle Valo wrote:
>
>> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
>> 
>> Marek Vasut <marex@denx.de> writes:
>> 
>>> From: Ajay Singh <ajay.kathat@microchip.com>
>>>
>>> Add support for the WILC3000 chip. The chip is similar to WILC1000,
>>> except that the register layout is slightly different and it does
>>> not support WPA3/SAE.
>>>
>>> Signed-off-by: Ajay Singh <ajay.kathat@microchip.com>
>>> Signed-off-by: Marek Vasut <marex@denx.de>
>> 
>> [...]
>> 
>>> --- a/drivers/net/wireless/microchip/wilc1000/cfg80211.c
>>> +++ b/drivers/net/wireless/microchip/wilc1000/cfg80211.c
>>> @@ -313,6 +313,13 @@ static int connect(struct wiphy *wiphy, struct net_device *dev,
>>>
>>>       vif->connecting = true;
>>>
>>> +     if (sme->auth_type == NL80211_AUTHTYPE_SAE &&
>>> +         is_wilc3000(vif->wilc->chipid)) {
>>> +             netdev_err(dev, "WILC3000: WPA3 not supported\n");
>>> +             ret = -EOPNOTSUPP;
>>> +             goto out_error;
>>> +     }
>> 
>> This looks wrong. If wilc3000 doesn't support SAE you shouldn't
>> advertise NL80211_FEATURE_SAE to user space. I think the check for
>> wilc3000 should be in wilc_create_wiphy():
>> 
>
> Actually, the chip ID is not available when wilc_create_wiphy() is called but
> is set later in the device probe function. Therefore, adding the
> 'is_wilc3000(vif->wilc->chipid)' condition may not work as expected.
> Also, I think there is no API to change "wiphy->features" after wiphy is
> registered to set it later when chip ID information is available.

Sounds like the driver is doing something funky in the registration, the
idea is that the device capabilities are probed before calling
wiphy_register().

> Does it make sense to add a module parameter for device type(wilc1000 or
> wilc3000) to address device-specific featurization.

We don't do hacks like that in upstream, it's expected that the driver
does this all automatically.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

