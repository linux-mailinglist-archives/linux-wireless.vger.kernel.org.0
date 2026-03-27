Return-Path: <linux-wireless+bounces-34057-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wPJrLAJlxmnnJgUAu9opvQ
	(envelope-from <linux-wireless+bounces-34057-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Mar 2026 12:07:46 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 13A7F34317E
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Mar 2026 12:07:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A66883018BFF
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Mar 2026 11:07:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01DB93E3D87;
	Fri, 27 Mar 2026 11:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b="AyjBR86n"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx4.wp.pl (mx4.wp.pl [212.77.101.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C204A3E5EE0
	for <linux-wireless@vger.kernel.org>; Fri, 27 Mar 2026 11:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.77.101.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774609662; cv=none; b=dAJTtat3FH0J3j0FC5UngifYeWw2T67SqtywXI6CqX81rEijOJ+Mto7FCw2DqKxIfH51RXCvh5sD4bT/RLK3isrkl7HfMc2RDbjnl6BQ6Uz7cvNP4MMKjV8o3tClgf4dKh4/toTJeOACkItZ1eTA2jWfX9B+R8Tg+nffKFMtTG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774609662; c=relaxed/simple;
	bh=Lk9hGEgJY8QumhreQg9plqr/618SLcczHo7oerNAfBI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ar10cEg/wfCgqo39+yhnJQFXvuhweYZFMvWTVIXGF3lf8u2h65eXezmTOEHyNtO0bIQnIDymnP95DP5NRetjuq4Txf5lzfcRYceDwcxGTnoa5S33IOmeJcfI/nchqvd+dRJh/aP2+daEFmNMo46xhXvBnWMQXY3H8Deobng/fUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl; spf=pass smtp.mailfrom=wp.pl; dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b=AyjBR86n; arc=none smtp.client-ip=212.77.101.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wp.pl
Received: (wp-smtpd smtp.wp.pl 18872 invoked from network); 27 Mar 2026 12:07:31 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=20241105;
          t=1774609651; bh=DZwkyEpi5NabXYL19l+znWTYjpnoUVfiwX04VtmuBRk=;
          h=From:To:Cc:Subject;
          b=AyjBR86nTggBkyFWbAaiAZpY/OKMDITquYoN72oc6EMWuh8m/2Z1KEaFZIrBTOVkM
           HA+5nl3JOGyOSZGPOW5G5ceDU4M3HKUzTmOcLCRy3YcTq7b2VTt3k/kkZWxoS4RHoa
           kSvKP+JotRaGC9VxEajpA3jan81KARJx8Cds/cp885yT2zbYzSNW1hvTPLTpK8UCA+
           yOB7ckEbzZM3dE7RG4Azh/NZ0hvyfjR3tVFptvoaNxKBkv/FG4Zq9tT8G/MbCibX7L
           FtYdj/C50YcocqevhCIMoj2qktyNy1q12HLMDTNGFOihSJSQdUwJhl+rp5OKgQpZRf
           HxHpV1745E6ZQ==
Received: from 77-236-5-223.static.play.pl (HELO localhost) (stf_xl@wp.pl@[77.236.5.223])
          (envelope-sender <stf_xl@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with TLS_AES_256_GCM_SHA384 encrypted SMTP
          for <johan@kernel.org>; 27 Mar 2026 12:07:31 +0100
Date: Fri, 27 Mar 2026 12:07:30 +0100
From: Stanislaw Gruszka <stf_xl@wp.pl>
To: Johan Hovold <johan@kernel.org>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Jakob Unterwurzacher <jakob.unterwurzacher@theobroma-systems.com>
Subject: Re: [PATCH] wifi: rt2x00usb: fix devres lifetime
Message-ID: <20260327110730.GA16592@wp.pl>
References: <20260327104726.1310327-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260327104726.1310327-1-johan@kernel.org>
X-WP-MailID: d81823b4bf74e16c6bcd6145ec56a4b9
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000000 [UePR]                               
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[wp.pl,none];
	R_DKIM_ALLOW(-0.20)[wp.pl:s=20241105];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-34057-lists,linux-wireless=lfdr.de];
	FREEMAIL_FROM(0.00)[wp.pl];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stf_xl@wp.pl,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[wp.pl:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,wp.pl:dkim,wp.pl:mid,theobroma-systems.com:email]
X-Rspamd-Queue-Id: 13A7F34317E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi

On Fri, Mar 27, 2026 at 11:47:26AM +0100, Johan Hovold wrote:
> USB drivers bind to USB interfaces and any device managed resources
> should have their lifetime tied to the interface rather than parent USB
> device. This avoids issues like memory leaks when drivers are unbound
> without their devices being physically disconnected (e.g. on probe
> deferral or configuration changes).
> 
> Fix the USB anchor lifetime so that it is released on driver unbind.
> 
> Fixes: 9f2d3eae88d2 ("can: ucan: add driver for Theobroma Systems UCAN devices")

Fix tag is wrong (and also cc based on it). Tag should be:
8b4c0009313f ("rt2x00usb: Use usb anchor to manage URB").

Regards
Stanislaw

> Cc: stable@vger.kernel.org	# 4.19
> Cc: Jakob Unterwurzacher <jakob.unterwurzacher@theobroma-systems.com>
> Signed-off-by: Johan Hovold <johan@kernel.org>
> ---
>  drivers/net/wireless/ralink/rt2x00/rt2x00usb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/ralink/rt2x00/rt2x00usb.c b/drivers/net/wireless/ralink/rt2x00/rt2x00usb.c
> index 83d00b6baf64..174d89b0b1d7 100644
> --- a/drivers/net/wireless/ralink/rt2x00/rt2x00usb.c
> +++ b/drivers/net/wireless/ralink/rt2x00/rt2x00usb.c
> @@ -826,7 +826,7 @@ int rt2x00usb_probe(struct usb_interface *usb_intf,
>  	if (retval)
>  		goto exit_free_device;
>  
> -	rt2x00dev->anchor = devm_kmalloc(&usb_dev->dev,
> +	rt2x00dev->anchor = devm_kmalloc(&usb_intf->dev,
>  					sizeof(struct usb_anchor),
>  					GFP_KERNEL);
>  	if (!rt2x00dev->anchor) {
> -- 
> 2.52.0
> 

