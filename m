Return-Path: <linux-wireless+bounces-38697-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id mpNkCDbCS2ojZwEAu9opvQ
	(envelope-from <linux-wireless+bounces-38697-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 06 Jul 2026 16:56:54 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A712B71241C
	for <lists+linux-wireless@lfdr.de>; Mon, 06 Jul 2026 16:56:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=VwZmURvI;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38697-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38697-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 391683276B64
	for <lists+linux-wireless@lfdr.de>; Mon,  6 Jul 2026 14:42:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBA9B41611A;
	Mon,  6 Jul 2026 14:40:15 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19D1641F7E7
	for <linux-wireless@vger.kernel.org>; Mon,  6 Jul 2026 14:40:13 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783348815; cv=none; b=HI3ix96k2cOKhoAWDZTDYvYdgPYOW8jbPxbjdeFOjKz89tpc0Rh8oEBe7Gj6Nb1OlHD9MGrteSvqVDHYPvDb7EwNXRbItDxBRQhswKTBOn2Y+Xzqn9tGn4wB/Y7dH15FE0Pslpv6nSvvTyNVZ2KW/rgWToTuge/ThXGf8tgTX5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783348815; c=relaxed/simple;
	bh=+HJRPXWUR5wKFR7fxw0fX+rLOu+JjhItliDTQTLZ/1U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D6Pk9TylBltsa8EIrof+4u0dHzozXb9nhFU1Xhss0JJ1uZpkp6r8EavMlVezpAP5k+A7YyB+7/T+z5ZAbAslmjQSsxK5fC7BjTHay5ZkUENZBpKqNAGOwa3o4MIyt3Qpr7sc+Ejur9kDIMA33aHzqBjFsuoZ2dLqBvojPFKmoFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VwZmURvI; arc=none smtp.client-ip=209.85.208.177
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-39b2d353713so23149891fa.3
        for <linux-wireless@vger.kernel.org>; Mon, 06 Jul 2026 07:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783348812; x=1783953612; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YkycRqxvjty9WMrqLNNOLyHpGeUgcD9g+5kM6fU1uwM=;
        b=VwZmURvIN5ocZzYjjHDEPZ5CM8rsMEIT/zv4HGLZK/HSH+bTXf1yr1t/2BITffixCF
         3ADyUyevyA63h7SKuk38CcuzeyF8t+bzKLb8nwxNBxsQcPcuhnohzMSctzXTJglHctIX
         bnnyrzmO16OZYnhqVLHk8fJPjNcKGgwP60Q+FWS/yGD0BrHpp13hYIMVpeGNTWGL9UCA
         x9sXkqfyKaxwMsXhrv5+Slck9Ek0C5t+9rG7LWbg31I0YDzbb1zpKII6AOJYEham91K3
         D2JzsLZf8L+gXpWd5sKSgmK60m3lBoCbWfGwQK3jLWqCJZP6DSSDcQ7apc7yKv8um1DF
         THBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783348812; x=1783953612;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YkycRqxvjty9WMrqLNNOLyHpGeUgcD9g+5kM6fU1uwM=;
        b=MsFI3boqOPm/XbhgFqW8JGZ5KeeavwNY6LGzt/d2U5cUe/pc8PsJytbmMbx3I1B+CZ
         IFSlq+dS+pZ2JtQIdo0P0e6Y53jFIgWAws7UOeZ2sXM4xmoowCyd804k3BLCIUNWtU8p
         uEi31F8FeN6h2wzsWpL7Stl1p50gudD8bC2Ph5Itex7kUZwt+J8hGKKC257vKn1TIb6E
         kYx9TLZStCTqekrGZgVuSJR0bZBwtR3aK4+xIQyz0gxuCpI+tYqRxyVu/XMn7u5mtf/B
         McVaQ5+dI3/uZN0shFnaMHt+/IXKcaML9XDBk8maHWYyoPVBqYPWQWnnmAyboNcMTbfi
         O3Eg==
X-Gm-Message-State: AOJu0Yyq8EZf3E8Bc0FzniZdDpzoDUaZid3S//hP8LsF+aCJ5RUP+287
	SVsgQrYXr2QZOIdy95f/jour3LTvCDyx5CbKjPFZh3pY8bBjCw2E1E82
X-Gm-Gg: AfdE7cmB0KckGMu3K+CDEcKADqa9KvXBBj31fJcZEakKOHVDvIGbIfA/Df585JJ2+ni
	YNPAOqyq8rvJmxlwIZ2X/zg62eRL3G2VXSFrzhWZuoWOrEsKFXbTCr0D2U8+zdCyXP4e5BUNhGl
	UTWjaBJdaCigLg+IWMTMokOO131u5nKF15DX0EoArfwS3Skr+lgFUtAkQ9FN1ZzD9cFYK5yfnUq
	t2kCd22aYnvu4s5qSGYAVe8/ORInQw2pwtjUifKBP4585dlS/etljWO7LV/IX7SHQiW44fz7e+J
	RSqPlT3I/QvvHlt20Z/mYqGYHiNFvP/6ke6ybcRj9AmTD1kRFZGafAp4VNGDF9lLcjJsC3I8npk
	we2nWA9yy9wiu12oS7F7UOXeiU9u9MkYQVk8Cu4ByS3alheDmniWT5niCCc0cACnlywTp6ix5nu
	Y9Bu4CDKm5xMaNIfpaJaEj64w6rJY=
X-Received: by 2002:a05:6512:414d:b0:5ae:9de4:4907 with SMTP id 2adb3069b0e04-5b007bb9136mr132541e87.53.1783348811872;
        Mon, 06 Jul 2026 07:40:11 -0700 (PDT)
Received: from localhost (soda.int.kasm.eu. [2001:678:a5c:1202:7b92:9ac1:b9ef:5287])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aed137705dsm2947841e87.32.2026.07.06.07.40.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 07:40:11 -0700 (PDT)
Date: Mon, 6 Jul 2026 16:40:10 +0200
From: Klara Modin <klarasmodin@gmail.com>
To: Rosen Penev <rosenp@gmail.com>
Cc: linux-wireless@vger.kernel.org, Felix Fietkau <nbd@nbd.name>, 
	Lorenzo Bianconi <lorenzo@kernel.org>, Ryder Lee <ryder.lee@mediatek.com>, 
	Shayne Chen <shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	"open list:ARM/Mediatek SoC support" <linux-kernel@vger.kernel.org>, 
	"moderated list:ARM/Mediatek SoC support" <linux-arm-kernel@lists.infradead.org>, 
	"moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>, Tobias Klausmann <klausman@schwarzvogel.de>, 
	Thorsten Leemhuis <regressions@leemhuis.info>, Linux kernel regressions list <regressions@lists.linux.dev>
Subject: Re: [PATCH wireless-next] wifi: mt76: fix MAC address for non OF
 pcie cards
Message-ID: <aku9T5a__-8EqFM_@soda.int.kasm.eu>
References: <20260630210215.400379-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260630210215.400379-1-rosenp@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-38697-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:rosenp@gmail.com,m:linux-wireless@vger.kernel.org,m:nbd@nbd.name,m:lorenzo@kernel.org,m:ryder.lee@mediatek.com,m:shayne.chen@mediatek.com,m:sean.wang@mediatek.com,m:matthias.bgg@gmail.com,m:angelogioacchino.delregno@collabora.com,m:linux-kernel@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-mediatek@lists.infradead.org,m:klausman@schwarzvogel.de,m:regressions@leemhuis.info,m:regressions@lists.linux.dev,m:matthiasbgg@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[klarasmodin@gmail.com,linux-wireless@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[klarasmodin@gmail.com,linux-wireless@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,nbd.name,kernel.org,mediatek.com,gmail.com,collabora.com,lists.infradead.org,schwarzvogel.de,leemhuis.info,lists.linux.dev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,soda.int.kasm.eu:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A712B71241C

On 2026-06-30 14:02:15 -0700, Rosen Penev wrote:
> If seems the check for err is wrong as the proper macaddr gets written
> to from the EEPROM itself. Meaning checking err from of_get_mac_address is
> wrong as the proper macaddr has been written by this point.
> 
> Fixes: 31ee1582717e ("wifi: mt76: fix of_get_mac_address error handling")
> Signed-off-by: Rosen Penev <rosenp@gmail.com>

Tested-by: Klara Modin <klarasmodin@gmail.com>

> ---
>  drivers/net/wireless/mediatek/mt76/eeprom.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/mediatek/mt76/eeprom.c b/drivers/net/wireless/mediatek/mt76/eeprom.c
> index b99d7452800f..afdb73661866 100644
> --- a/drivers/net/wireless/mediatek/mt76/eeprom.c
> +++ b/drivers/net/wireless/mediatek/mt76/eeprom.c
> @@ -181,7 +181,7 @@ mt76_eeprom_override(struct mt76_phy *phy)
>  	if (err == -EPROBE_DEFER)
>  		return err;
>  
> -	if (err) {
> +	if (!is_valid_ether_addr(phy->macaddr)) {
>  		eth_random_addr(phy->macaddr);
>  		dev_info(dev->dev,
>  			 "Invalid MAC address, using random address %pM\n",
> -- 
> 2.55.0
> 

