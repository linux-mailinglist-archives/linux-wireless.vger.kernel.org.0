Return-Path: <linux-wireless+bounces-22083-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5432EA9D193
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Apr 2025 21:31:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C16EA3B3079
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Apr 2025 19:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 592282165E4;
	Fri, 25 Apr 2025 19:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="dNjFCy6x"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-28.smtpout.orange.fr [80.12.242.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE11017C21C;
	Fri, 25 Apr 2025 19:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745609503; cv=none; b=p+OjvdRg6oyap4ygrFIU5l5cal5ZaPu+D2vH+S7cPq7jEPM7t8ZTqg59urCMU/2Zih1wPdt2sNZy9eRxifGqbN0cMXJQ2nlmZP+NiXSBtX7sibgk5A2LInsNSOvKxk3jSyDn3sjHRv8sRieY2w9v2brShifKZ9OfFnKqG/BSUhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745609503; c=relaxed/simple;
	bh=8PieXv6mj0nc1z3cu6Sb94XkBuu/I3wwKOQ/R0xhdRw=;
	h=Message-ID:Date:MIME-Version:Subject:References:From:To:Cc:
	 In-Reply-To:Content-Type; b=pxyq6BAXzE4OZRPY0Ifc/ht+SjgN3q00mVRojYKGKevOiGDfKbrXaAEn+KN/BgxGCRw01v53iEZDYCoXnweqzHUCooX7eq6X3yIPpcCeKEqdmChOS1+0+RhZr/yi3aEWP87vohziTjs1VnfXHYHnvQv14rVj/Sb26grQHrd3kC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=dNjFCy6x; arc=none smtp.client-ip=80.12.242.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.37] ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id 8OljuoZghQxp68Olmuvwz2; Fri, 25 Apr 2025 21:31:31 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1745609491;
	bh=JIqrozcWOsOgrfWz/Flt09tv8c/B8HQaA5udh4Yf2FQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To;
	b=dNjFCy6x6w6fM7gGn/+CfgPLBFdQ5mTn0ML317iEvwlLVdz5O3scxkRbtSPGIgKQZ
	 iR+FVmsPIBcfQuhpYzeZ61RpB8iT4urP5ZEA1/Dze3sqmfuKPp49tN1mQ+emTSK9Dl
	 KwlO5AOf9qRl7uKT9o5Wt2e8dAs1gFdOYN9qAzUWRpbfzTBIWqU/nLzxbCl8yBkfOy
	 etD7xYvQEvbXl4S8fxTOaGfUBodgnzzJ/WfN94KcKiH3V1E56PgjYIvsWA+BTSVvw9
	 JxFMEqhiPYNW3wd419UeCBZDHdm5qdFils2cN8aOQue/IYDJ1dRL6txzXKu45ETCkZ
	 DRai1BYlZnx5Q==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Fri, 25 Apr 2025 21:31:31 +0200
X-ME-IP: 90.11.132.44
Message-ID: <3cfd718f-e96a-44d0-b42f-d759ae698810@wanadoo.fr>
Date: Fri, 25 Apr 2025 21:31:26 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 2/2] wifi: Add Nordic nRF70 series Wi-Fi driver
References: <20250422175918.585022-1-artur@conclusive.pl>
 <20250422175918.585022-3-artur@conclusive.pl>
Content-Language: en-US, fr-FR
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: artur@conclusive.pl
Cc: broonie@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org,
 jakub@conclusive.pl, johannes@sipsolutions.net, krzk+dt@kernel.org,
 lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
 linux-wireless@vger.kernel.org, robh@kernel.org, s.hauer@pengutronix.de,
 ulf.axelsson@nordicsemi.no, wojciech@conclusive.pl
In-Reply-To: <20250422175918.585022-3-artur@conclusive.pl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 22/04/2025 à 19:59, Artur Rojek a écrit :
> Introduce support for Nordic Semiconductor nRF70 series wireless
> companion IC.
> 

Hi,
...

> +	/* vpwr is mandatory, but we want to catch the -ENODEV error. */
> +	priv->vpwr = devm_regulator_get_optional(dev, "vpwr");
> +	if (IS_ERR(priv->vpwr))
> +		return dev_err_probe(dev, PTR_ERR(priv->vpwr),
> +				     "Unable to find vpwr-supply property");
> +
> +	priv->vio = devm_regulator_get_optional(dev, "vio");
> +	if (IS_ERR(priv->vio) && PTR_ERR(priv->vio) != -ENODEV) {
> +		return dev_err_probe(dev, PTR_ERR(priv->vio),
> +				     "Invalid vio-supply property");
> +	}

Unneeded extra { }

> +
> +	irq = of_irq_get_byname(dev->of_node, "host-irq");
> +	if (irq <= 0)
> +		return dev_err_probe(dev, irq, "Unable to find host-irq\n");

If irq is 0, is it expected to return sucess here?

> +
> +	mutex_init(&priv->write_lock);
> +	mutex_init(&priv->read_lock);
...

CJ

