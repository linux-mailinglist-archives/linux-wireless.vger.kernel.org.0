Return-Path: <linux-wireless+bounces-38797-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id BbgIG8CqTmr3RgIAu9opvQ
	(envelope-from <linux-wireless+bounces-38797-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 08 Jul 2026 21:53:36 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B8F7B72A025
	for <lists+linux-wireless@lfdr.de>; Wed, 08 Jul 2026 21:53:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=johnrowley.me header.s=2025 header.b="dmX8Aw/O";
	dmarc=pass (policy=none) header.from=johnrowley.me;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38797-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38797-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 75B9530554A0
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Jul 2026 19:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E36883D75D7;
	Wed,  8 Jul 2026 19:50:27 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.johnrowley.me (mail.johnrowley.me [195.201.26.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A1FC3D6CB4;
	Wed,  8 Jul 2026 19:50:24 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783540227; cv=pass; b=sRqWPw6VSkCYgzMc1JPq8EuRZUxLpowQ5le6jzerPQv4JwKmEETp8/VjPBDxLsPjZhupYfCLcedDBtfVzoJRqkkQAwDxRH3DRtkXtNQry1pasJte5iHbZHwWjOD47GaFg4BczkEa/GEs3M3qUN/qgvh4D2BPh7jtMQ7MmYNAJsw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783540227; c=relaxed/simple;
	bh=8RbFruJHebluwWNNScRRb9k0UHFHf2cCT4aJ7a12Tf0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kUy1wlIgUubV4NPQ0dqbR6eIS4h6gOStTr/XgMtDd5e7vOrV66WM8F9B3v+9jqHPm4qf2n4voUl2Yk9QMl7FHZu7vmUnVchNOiiA4biaNnRBDS6PWPs/hSDPP6o8hV2oHCH1xru91emNMlKuNeB0qtJSv+PEc17fIonqZoBxfM4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=johnrowley.me; spf=pass smtp.mailfrom=johnrowley.me; dkim=pass (2048-bit key) header.d=johnrowley.me header.i=@johnrowley.me header.b=dmX8Aw/O; arc=pass smtp.client-ip=195.201.26.17
Date: Wed, 8 Jul 2026 20:42:56 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=johnrowley.me;
	s=2025; t=1783539781;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kEMm9QuKYkuKATX8nQVckgqvQIGgEyMpKgrrFFvElyA=;
	b=dmX8Aw/OrQnlYzC3ureeT1tIYh721plKtz8eFF7WRGH7ZbyMvweab19QSznZRAfH/YrlNp
	OQKG2iyeQSxllmf7jsVgFMj9tW+owZzTzUxe+x5F5qhPWFQjKNy8pkadp0xJZkcFs5Xwmx
	w3s9+7IwaE9zI+Gv8Qlu1f5GwBrOT9rL/u1sRXp5O4RBcEX8A296yeeSxkt30s/1Wv3/Xs
	Sfxx2+hqT9s7Eh1sEwY5m36MkEPStVAuBI9hjS/TK6yPWnlMtud17Dy4BEz3ocpRIcGb3L
	OyL0t6x6gezbH9i5YwW5PuVGz1g2PPhbU/Q5v2zRWMxlp3ZcQEs2w0MNuuNVTQ==
ARC-Seal: i=1; a=rsa-sha256; d=johnrowley.me; s=2025; cv=none; t=1783539781;
	b=fuoPR/5JafdmYWEprBKsuKz6KWNBEZoJbsbBMTbEQWbogkrpMjC/xp5zFTqYwvHzT0uhQW
	Y3ybpQwVn1EGDF5yUSgIgPS4BbsXYVI7qNwSe8uZWnaD7ReT1savA2SR6TXYdgFR+qKx/V
	Vq6oiZ3vFbpZV0GMxRaGZnxG4fF651bS0N4CsIaCZYeOZpSUiqj12Ko+vBxjnI3rMTKjaT
	jTRSJZDaPuyGZtwL6R1WY8/2TQJaTIXGIrzyv7JM5XTDEBawCBN1kxUHBp0TB615N2uUxY
	/G1M5gv4A4jUsS7zHfn1xxWDTTVKi/fIWYSAgO0omwKtLHVslqyb/BXXkvhGYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=johnrowley.me;
	s=2025; t=1783539781;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kEMm9QuKYkuKATX8nQVckgqvQIGgEyMpKgrrFFvElyA=;
	b=VgXPQetL6mK/JLHHsyDGhCW3x9nfu1NNEXjl9nqIsFR+ZdOjG6497ZMKgYZA7oxE9Rcb9V
	JOpkkJDQ8qn1AtVxgrJOhYDIjP55OjA385Hr/iWjCXvO6ftD+b2wCHrPUn+UAJ/Bl4tley
	ocWLUd5nJufm/GoG2J0Lu7kB4PiQzgsYZwzVBjIydFkPJIawMqKVQzSEc9KLwyhrHRn10g
	iz5KFdVZ0fi1F9M5X9JU9auPAaxXZFQBh8dYuhfVwv5DJkAFOj57wxRYNngsNxR+m3K/20
	bpncVlQ/zW31Nu6/vGx5lH6XNe2qBf8TIji2hDZ1ldnVZJAI1qxwfopP7wTd0w==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=user smtp.mailfrom=lkml@johnrowley.me
From: John Rowley <lkml@johnrowley.me>
To: Rosen Penev <rosenp@gmail.com>
Cc: linux-wireless@vger.kernel.org, Felix Fietkau <nbd@nbd.name>, 
	Lorenzo Bianconi <lorenzo@kernel.org>, Ryder Lee <ryder.lee@mediatek.com>, 
	Shayne Chen <shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	"open list:ARM/Mediatek SoC support" <linux-kernel@vger.kernel.org>, 
	"moderated list:ARM/Mediatek SoC support" <linux-arm-kernel@lists.infradead.org>, 
	"moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH wireless-next] wifi: mt76: fix MAC address for non OF
 pcie cards
Message-ID: <ak6notej5X7Oiyj8@localhost.localdomain>
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
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[johnrowley.me,none];
	R_DKIM_ALLOW(-0.20)[johnrowley.me:s=2025];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:rosenp@gmail.com,m:linux-wireless@vger.kernel.org,m:nbd@nbd.name,m:lorenzo@kernel.org,m:ryder.lee@mediatek.com,m:shayne.chen@mediatek.com,m:sean.wang@mediatek.com,m:matthias.bgg@gmail.com,m:angelogioacchino.delregno@collabora.com,m:linux-kernel@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-mediatek@lists.infradead.org,m:matthiasbgg@gmail.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[lkml@johnrowley.me,linux-wireless@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-38797-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[johnrowley.me:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkml@johnrowley.me,linux-wireless@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,nbd.name,kernel.org,mediatek.com,gmail.com,collabora.com,lists.infradead.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,johnrowley.me:from_mime,johnrowley.me:email,johnrowley.me:dkim,localhost.localdomain:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B8F7B72A025

On Tue, Jun 30, 2026 at 02:02:15PM -0700, Rosen Penev wrote:
> If seems the check for err is wrong as the proper macaddr gets written
> to from the EEPROM itself. Meaning checking err from of_get_mac_address is
> wrong as the proper macaddr has been written by this point.
> 
> Fixes: 31ee1582717e ("wifi: mt76: fix of_get_mac_address error handling")
> Signed-off-by: Rosen Penev <rosenp@gmail.com>

Fixed, thanks.

Tested-by: John Rowley <lkml@johnrowley.me>

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
> 

