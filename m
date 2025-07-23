Return-Path: <linux-wireless+bounces-25944-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 29D95B0F555
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Jul 2025 16:32:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25C49189BB4E
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Jul 2025 14:32:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A3252F2C4A;
	Wed, 23 Jul 2025 14:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bi5UkJC3";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aSSR21VR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 189BD2E541F
	for <linux-wireless@vger.kernel.org>; Wed, 23 Jul 2025 14:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753281147; cv=none; b=HbsBhIddkPJo+w0YHmMS3U4CtIAxCEozSdYTJ7p7kFllaHqDA6Tjrpups9R3rE4NA/ygqdO41IXVgEipnpbMK0ho/L9vAc2rZ3unNDJ0LPzL5G8npuigdvIvoB833RoHUr7a3rQ3zX9LxcpNFY45uqXui5Sw5MANQik/21paYm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753281147; c=relaxed/simple;
	bh=Gg5UBb0E6xRCUZNjblK9BJZjkk4EOeqgI2QsgNo/HIA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BtZgDs0K5bwBwo1s9FQRRjVqPMoYkKEYDxlFAVXul23v65KXBNsDx1/rdENdrGLKfbY9REG+p4PFtorPdvxvb0tz8v++dPoLV/DTw1giDJyjt3+sCvw+pkqbjG7Og3yzmS/p42GpGGa0KfdJUlKrU5dk99TE4h7Rn7UviSr946Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bi5UkJC3; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aSSR21VR; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <73fbbb72-b0f1-4521-8abd-2bc7fd0dfdab@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1753281142;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BeaXa4hzcH8z7f1zdrXl1O+KXEzJkY9IT1FCFyQMlt4=;
	b=bi5UkJC3HM0Zg/+PiLiNe8lzgp+vDuRaK3qFPfoEThwglj40ROFx8hLnK/kDpamEYXWyZ2
	uy1sGHiKIssk2Gw0Be1ERxdWtvRhTFiVmo/qzeSAgIN1zFAgQmHlixn0UrdZ3XyjVQnJiw
	g5lz05OD/Ut+Hzv5EbIR3idszBFXaKbRELeA1QdJMU9GO4Rz1nsnZthoxtOxVC/Du9e6qY
	ZGwcwRVKLlBQMQufPzBtBTqNdUa8Xv51wbXzsnJIL+oeRX3NAClTwJF5OUHjWM/m+X3+BR
	ftdpwMa7xRfiGNzETn2fhhi4Fy5jTTcFlQ/VCOKFH5OsZCH34lkW+NRiEoMlBA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1753281142;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BeaXa4hzcH8z7f1zdrXl1O+KXEzJkY9IT1FCFyQMlt4=;
	b=aSSR21VR94DcMOuK1zMLqpzkT8CuofzRR4wKID0UKlESjAAvDaxQozn+KmFsUYsbHFVrIC
	JgN7dEmIfcUfq7Dg==
Date: Wed, 23 Jul 2025 16:32:22 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH wireless-next v2] wifi: mac80211: fix WARN_ON for monitor
 mode on some devices
To: Johannes Berg <johannes@sipsolutions.net>, linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
References: <20250723071419.7081-2-johannes@sipsolutions.net>
Content-Language: de-DE
From: Martin Kaistra <martin.kaistra@linutronix.de>
In-Reply-To: <20250723071419.7081-2-johannes@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Am 23.07.25 um 09:14 schrieb Johannes Berg:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> On devices without WANT_MONITOR_VIF (and probably without
> channel context support) we get a WARN_ON for changing the
> per-link setting of a monitor interface.
> 
> Since we already skip AP_VLAN interfaces and MONITOR with
> WANT_MONITOR_VIF and/or NO_VIRTUAL_MONITOR should update
> the settings, catch this in the link change code instead
> of the warning.
> 
> Reported-by: Martin Kaistra <martin.kaistra@linutronix.de>
> Link: https://lore.kernel.org/r/a9de62a0-28f1-4981-84df-253489da74ed@linutronix.de/
> Fixes: c4382d5ca1af ("wifi: mac80211: update the right link for tx power")
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>

Tested-by: Martin Kaistra <martin.kaistra@linutronix.de>

> ---
> v2: add missing { to fix build
> ---
>   net/mac80211/main.c | 13 ++++++++++++-
>   1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/net/mac80211/main.c b/net/mac80211/main.c
> index 351564360c26..9c8f18b258a6 100644
> --- a/net/mac80211/main.c
> +++ b/net/mac80211/main.c
> @@ -408,9 +408,20 @@ void ieee80211_link_info_change_notify(struct ieee80211_sub_if_data *sdata,
>   
>   	WARN_ON_ONCE(changed & BSS_CHANGED_VIF_CFG_FLAGS);
>   
> -	if (!changed || sdata->vif.type == NL80211_IFTYPE_AP_VLAN)
> +	if (!changed)
>   		return;
>   
> +	switch (sdata->vif.type) {
> +	case NL80211_IFTYPE_AP_VLAN:
> +		return;
> +	case NL80211_IFTYPE_MONITOR:
> +		if (!ieee80211_hw_check(&local->hw, WANT_MONITOR_VIF))
> +			return;
> +		break;
> +	default:
> +		break;
> +	}
> +
>   	if (!check_sdata_in_driver(sdata))
>   		return;
>   


