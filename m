Return-Path: <linux-wireless+bounces-37905-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id hKytH25nNGqxXAYAu9opvQ
	(envelope-from <linux-wireless+bounces-37905-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jun 2026 23:47:26 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D4CD6A2CE4
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jun 2026 23:47:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=WKqrgOwq;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37905-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37905-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DF2F9303798E
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jun 2026 21:47:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE543233927;
	Thu, 18 Jun 2026 21:47:22 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4880221F20
	for <linux-wireless@vger.kernel.org>; Thu, 18 Jun 2026 21:47:21 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781819242; cv=none; b=EfToYeoPlS+6EohJGmhWvnToJwxfqU3fQ9PaZkhov7Vbew15DE+bslGp4ZUJmFjNZYcXKtoq38rgUCVq7coWo3h+R5PCq7ByR39JDnYADEF+D+X6VAk5pzwBtHotfPmF4XvK7ZuhJvMx216DHRwmgC1wXjrBWooAMJdL5q4ClTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781819242; c=relaxed/simple;
	bh=VBJuo0ibG6TgsiJgMtbyGfMHWuYDeqpoHyMEFkaJADM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JSNPSxEPU8yY2OAKHRgV2KEUvfXvADSwq8WIRfM5H1hl7UsdX528/FgQAoc+iyVV+LxgroORg3/cZLJ5IKRVhcPb8d86IkVdFC964o41Wq5DIL01Hbu+VSvZAihhZM1CmUkhjkv5FXPNo3IjR7g5cZXmEsCqaPauaYEKsKUQctY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WKqrgOwq; arc=none smtp.client-ip=209.85.218.41
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-bdb3fd39045so186907566b.3
        for <linux-wireless@vger.kernel.org>; Thu, 18 Jun 2026 14:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781819240; x=1782424040; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KGlMDnViUMkCsSlZJzDY1S0meEDS8qDd3hMSbZlQ96o=;
        b=WKqrgOwq++3gcJYgjwDIRbb0+moPeNq1J4BRafM3ma54z8zMee0n/HwNOZ0/zKKq0K
         QUhxr4He+63cHOY1Ux3zTvHwzbRsKV9g3O/wWuDe5TnYF8kf4K3nbvGxK+igyBfgDu3X
         un7nZ2e7Vnuxf3/MHcfP5gmlz9oFk59IljLv+rJ8EA8ZqNk+AOmR1OIeN8uwkqW0QIat
         Mgygq4CdgiBZhVwXATvRxfBM5/wzdAhjihUWXHqoNRHzytYXi62/nHyiiHM53EtcxvO2
         xrvyEshENpwam7gnlJlXwmHbLr+XK+XnE9SmXMo9lDD2XX6Sg7LfJHK50TY4r7l3xyl4
         rMDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781819240; x=1782424040;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KGlMDnViUMkCsSlZJzDY1S0meEDS8qDd3hMSbZlQ96o=;
        b=Sx97AJ2eJTmZkdmvt0Rfb+qb0m0CwoPwV3fKVxM/8shkdvVh3ggL6lJj0nC+bnrE8J
         2gUHDqJh59C0ekhItKNxESYbSYuj5MUFnTH7byzvFPuOQ5ER9GSiZlyLNBRSp/6m/5P0
         l3Znr7nzxF5FnQXarginnASD3DrReiimIs4p3LYjJCKnmyJ0mqdzwy/R+xzu4ew/vlzE
         E6ye854+S30n2H0wx8P3QZHRW/B6v0+OKuYysiw42nx6Rv9P4hrl15pz1PisXT6jQI/0
         dtp7Zdn9XOJuqnmwTQElGeGuBThFaeruu7vKizWLr8chhQ3M9XLv5ifjQs4igoQ2mplW
         dtpg==
X-Gm-Message-State: AOJu0YzGTZB0o9QrcdefUMnZnx36+/Dx6Wc8v3ppyJ0dg58ecEKK0n8h
	AlcVDW38dAtBmCL5GgRCmot5H9b6iXJbx4cQI9K4kEPSF3cG+25Z2pzG
X-Gm-Gg: AfdE7ck0nymShNHrpIEvmEWmD1TQdULXzxy8zzxdqfTlj4wdLUn6cw0qbC/FFFH8dpv
	zg5HXadx4I25mo+5NszUpORKQwpnxnMutDhRLlu2QPtSWXky6XijJ3KTK1asuxwR0B2kGrXEnGZ
	GKhlUYCfryLKFEb+prrGAfG01KEyODtU00OwnEpxiEU6Z3qrUXSD3CE7wZK3WtKjyS23mR7RhK0
	2kM3LkSQVFyeAYwCeHTMx3jUlTQhUVsJkmRP6CpkrYbtf4Gi0j4UA1HG9vsUJZG6zOtAI7ZQnAk
	AuUtsljxdjd+hFDxYR8p3REUI+3Xy9Zo/jn7dPeThz10N5I7LTx+vIbvdMPnAaEbAqYGX2Nw+cF
	adA42RWct/peWUagKekE0ZQJ7DQ3SicqFdL2IYjy/0TrorpeVR4DLFscjvgZlaiYAsNM3dpr03C
	WcI393ZQlT+5mWGFgVz/T3XqBuls4=
X-Received: by 2002:a17:906:9fca:b0:c08:49a4:c737 with SMTP id a640c23a62f3a-c097ae2ddd2mr58097066b.2.1781819239771;
        Thu, 18 Jun 2026 14:47:19 -0700 (PDT)
Received: from localhost (soda.int.kasm.eu. [2001:678:a5c:1202:4fb5:f16a:579c:6dcb])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c0a9a1568dcsm6914166b.51.2026.06.18.14.47.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 14:47:19 -0700 (PDT)
Date: Thu, 18 Jun 2026 23:47:18 +0200
From: Klara Modin <klarasmodin@gmail.com>
To: Rosen Penev <rosenp@gmail.com>
Cc: linux-wireless@vger.kernel.org, Felix Fietkau <nbd@nbd.name>, 
	Lorenzo Bianconi <lorenzo@kernel.org>, Ryder Lee <ryder.lee@mediatek.com>, 
	Shayne Chen <shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	"open list:ARM/Mediatek SoC support" <linux-kernel@vger.kernel.org>, 
	"moderated list:ARM/Mediatek SoC support" <linux-arm-kernel@lists.infradead.org>, 
	"moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH wireless-next] wifi: mt76: fix of_get_mac_address error
 handling
Message-ID: <ajRmlyx_AEGybykL@soda.int.kasm.eu>
References: <20260427051746.954704-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260427051746.954704-1-rosenp@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-37905-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:rosenp@gmail.com,m:linux-wireless@vger.kernel.org,m:nbd@nbd.name,m:lorenzo@kernel.org,m:ryder.lee@mediatek.com,m:shayne.chen@mediatek.com,m:sean.wang@mediatek.com,m:matthias.bgg@gmail.com,m:angelogioacchino.delregno@collabora.com,m:linux-kernel@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-mediatek@lists.infradead.org,m:matthiasbgg@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[klarasmodin@gmail.com,linux-wireless@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
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
	FREEMAIL_CC(0.00)[vger.kernel.org,nbd.name,kernel.org,mediatek.com,gmail.com,collabora.com,lists.infradead.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4D4CD6A2CE4

Hi,

On 2026-04-26 22:17:46 -0700, Rosen Penev wrote:
> Check return value instead of is_valid_ether_addr. The latter is handled
> by the former.
> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>  drivers/net/wireless/mediatek/mt76/eeprom.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/mediatek/mt76/eeprom.c b/drivers/net/wireless/mediatek/mt76/eeprom.c
> index 93d91264687f..0f6ccf6ed53d 100644
> --- a/drivers/net/wireless/mediatek/mt76/eeprom.c
> +++ b/drivers/net/wireless/mediatek/mt76/eeprom.c
> @@ -93,7 +93,7 @@ mt76_eeprom_override(struct mt76_phy *phy)
>  	if (err == -EPROBE_DEFER)
>  		return err;
>  
> -	if (!is_valid_ether_addr(phy->macaddr)) {
> +	if (err) {
>  		eth_random_addr(phy->macaddr);
>  		dev_info(dev->dev,
>  			 "Invalid MAC address, using random address %pM\n",
> -- 
> 2.54.0
> 

Recently I have started to see randomized MAC-addresses on my x86 laptop
with a MT7922 and the above message printed in the kernel log. I have
CONFIG_OF turned on, but since this is an ACPI system the device is not
described by any device tree and the earlier of_get_mac_address() likely
fails with -ENODEV. Looking at the !CONFIG_OF stub for
of_get_mac_address it always returns -ENODEV, meaning this will always
randomize the mac in that case too.

Reverting this patch fixes the issue and the correct MAC address is
used. I'm not sure if there is any case where of_get_mac_addres() could
fail in a way that results in a valid MAC address but it seems unlikely
to me.

Regards,
Klara Modin

