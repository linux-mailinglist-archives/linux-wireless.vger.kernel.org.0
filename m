Return-Path: <linux-wireless+bounces-12677-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EBBE971D73
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Sep 2024 17:04:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C168284ABF
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Sep 2024 15:04:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A79FD1A716;
	Mon,  9 Sep 2024 15:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pmqu16jk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ABBA18EB1;
	Mon,  9 Sep 2024 15:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725894270; cv=none; b=E6y7yT0kHju4JHtWFbEF4A5Mgz+Q16pz9WP4HQx7ue6fQwmQvqHL+F+wUtC3FzY5xGqE/8QMHr+W/yf6EidT+SRt4CcLC8bifvNnbAycN8JgUgw1w7QH2IyGDVxgznE9KBeqpifh+fRg2CYeVuIBPeUaYXK/pnHtnrq9Y4jAEzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725894270; c=relaxed/simple;
	bh=jJ++vCECAJfKHzTW5oT1kH64h5kQ5KsgEJwaDueHyzI=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=CaMM/jU4NcQbyNC9mgIxIlg53nXqdxAriCGg9j8PZeXbLv5bGq9Zrx+wGmmRPJBJ/DUtFrFbg4oGEAcOdYybE8K4xMjpcTJyN78VwMCd2bO8zYAkac+BpLXFTZDbknvYgIhtK5iYIVsZDcMZM9dy4fgBK1uL91MYI9TS2qPZClY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pmqu16jk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBC15C4CEC5;
	Mon,  9 Sep 2024 15:04:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725894270;
	bh=jJ++vCECAJfKHzTW5oT1kH64h5kQ5KsgEJwaDueHyzI=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=pmqu16jkp61Y2myVfR/pRh5NciKY8dLqucrC94s9rcRkU99LLw7t+5TO5cnFUbNT0
	 EPb5awSQncK7Lwvo0Op67uAzW19MVdQsfXnoXYkzrHTodSgGY98Y/fYvY/p/EkGyJa
	 gjQMGVi7zBM59DodL00LWzzmPkm9QVqxNza/evy5p/qvIT2dBU6nQvTURZDNUzLrEC
	 8DO4NxcGiM84DjNDv8rA3SHj23FB5vTxJ+sUaIASexfth9VzlI5EKCNwRKPrGEX5wL
	 dm5DazV0ldqKdwD4iJLKUdiqTcxUFLIjQnRJaiVUDW+vFpcP6ccVxt2CSVxwwBRz4a
	 MtwZcjw7zZJbw==
From: Kalle Valo <kvalo@kernel.org>
To: Marek Vasut <marex@denx.de>
Cc: linux-wireless@vger.kernel.org,  Ajay Singh <ajay.kathat@microchip.com>,
  "David S. Miller" <davem@davemloft.net>,  Adham Abozaeid
 <adham.abozaeid@microchip.com>,  Alexis =?utf-8?Q?Lothor=C3=A9?=
 <alexis.lothore@bootlin.com>,  Claudiu Beznea <claudiu.beznea@tuxon.dev>,
  Conor Dooley <conor+dt@kernel.org>,  Eric Dumazet <edumazet@google.com>,
  Jakub Kicinski <kuba@kernel.org>,  Krzysztof Kozlowski
 <krzk+dt@kernel.org>,  Paolo Abeni <pabeni@redhat.com>,  Rob Herring
 <robh@kernel.org>,  devicetree@vger.kernel.org,  netdev@vger.kernel.org
Subject: Re: [PATCH v4 5/5] wifi: wilc1000: Add WILC3000 support
References: <20240829004510.178016-1-marex@denx.de>
	<20240829004510.178016-5-marex@denx.de> <87ed5tgofh.fsf@kernel.org>
	<343a45a8-1891-4e66-a77c-ad6e4d485903@denx.de>
Date: Mon, 09 Sep 2024 18:04:25 +0300
In-Reply-To: <343a45a8-1891-4e66-a77c-ad6e4d485903@denx.de> (Marek Vasut's
	message of "Mon, 9 Sep 2024 16:46:18 +0200")
Message-ID: <87seu8g96u.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Marek Vasut <marex@denx.de> writes:

> On 9/9/24 11:35 AM, Kalle Valo wrote:
>
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
>> [...]
>> 
>>> --- a/drivers/net/wireless/microchip/wilc1000/cfg80211.c
>>> +++ b/drivers/net/wireless/microchip/wilc1000/cfg80211.c
>>> @@ -313,6 +313,13 @@ static int connect(struct wiphy *wiphy, struct net_device *dev,
>>>     	vif->connecting = true;
>>>   +	if (sme->auth_type == NL80211_AUTHTYPE_SAE &&
>>> +	    is_wilc3000(vif->wilc->chipid)) {
>>> +		netdev_err(dev, "WILC3000: WPA3 not supported\n");
>>> +		ret = -EOPNOTSUPP;
>>> +		goto out_error;
>>> +	}
>> This looks wrong. If wilc3000 doesn't support SAE you shouldn't
>> advertise NL80211_FEATURE_SAE to user space. I think the check for
>> wilc3000 should be in wilc_create_wiphy():
>> if (!is_wilc3000(vif->wilc->chipid))
>
> It is probably better to do "if (is_wilc1000(wl->chipid))" here.

Good point.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

