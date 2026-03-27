Return-Path: <linux-wireless+bounces-34064-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UGx7Iip3xmnwKgUAu9opvQ
	(envelope-from <linux-wireless+bounces-34064-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Mar 2026 13:25:14 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0096A3442AB
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Mar 2026 13:25:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C981F304C94B
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Mar 2026 12:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1946739D6CE;
	Fri, 27 Mar 2026 12:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b="EcLJ95J9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx4.wp.pl (mx4.wp.pl [212.77.101.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C9E62D6E4B
	for <linux-wireless@vger.kernel.org>; Fri, 27 Mar 2026 12:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.77.101.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774613983; cv=none; b=P7XfUk1/rc3oiYLFUDa2tVH+BTrZqSj3GMvyQsdVDc4TeiUaaa5XaaKs8qmtjQf0dRmA9iVGt+IrLQaSqZrbkzvXbPJHFVlVTyVwt65ldzDTglImVn9sy0JxZN4seLt1ljMoNOZ8wZnFi36bKhrWjvbPUd74IKeo2b+ck1sN8DM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774613983; c=relaxed/simple;
	bh=nXO58KgcOSFD5NXL3UaqWfOGuPdY+H+Uby+ffFErYcE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TCUC0I2ajT7v5Mv7Q8SbwLkwi3GiP+cRJeQ2WmpemtBgR2UnEGAHchVwb1TQ/iceGS1pNzVWU1uQFNtOtDhQ0JoEdebYUcecSy4ZMSWlbYdUN9IPUzHj5ckbrpgCdeWDFtMsH1j2FMULn7pSZs91QYnKT/aXiQZm5orJXy3N5Ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl; spf=pass smtp.mailfrom=wp.pl; dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b=EcLJ95J9; arc=none smtp.client-ip=212.77.101.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wp.pl
Received: (wp-smtpd smtp.wp.pl 36376 invoked from network); 27 Mar 2026 13:19:33 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=20241105;
          t=1774613973; bh=+9KIb0T+WT9OzqTMOwo1n0HvVm6k3ENENUEgwuOw2DU=;
          h=From:To:Cc:Subject;
          b=EcLJ95J9NQpAYhH4N7sr508RLabGwlNpO0mS2QVjBSsDT1qglBae+nJsnE4aG1HYl
           SsOnbOA7KIAQLUyxDcXcawj9FTl7L5sFt5so3h/CFw59+X1+RBk0bKmW0iDSttUI3P
           vNi1ZqZbRg9Nqx7pv2G5nCwMc9b66HU58sb6n5G0dIlmNihT0ApoyrkrdYy4z1Jeb5
           sUNFgzQO7GK4F1uWDIVuiwP3olfLdx1kNm8FHkHSm0096Si6YwGvBv0+x39EGXV3iQ
           WbIRE8/3cncLico2pZcrLjDOCRje9btq9162yHa0OSwU1um0El0SCBTFG8Tk+DjIv/
           l4Wh6feTpX89Q==
Received: from 77-236-5-223.static.play.pl (HELO localhost) (stf_xl@wp.pl@[77.236.5.223])
          (envelope-sender <stf_xl@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with TLS_AES_256_GCM_SHA384 encrypted SMTP
          for <johan@kernel.org>; 27 Mar 2026 13:19:33 +0100
Date: Fri, 27 Mar 2026 13:19:33 +0100
From: Stanislaw Gruszka <stf_xl@wp.pl>
To: Johan Hovold <johan@kernel.org>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, Vishal Thanki <vishalthanki@gmail.com>
Subject: Re: [PATCH v2] wifi: rt2x00usb: fix devres lifetime
Message-ID: <20260327121933.GC16800@wp.pl>
References: <20260327113219.1313748-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260327113219.1313748-1-johan@kernel.org>
X-WP-MailID: bd41d97f0885404bb4e168523c1c8c2c
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000000 [gSMR]                               
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[wp.pl,none];
	R_DKIM_ALLOW(-0.20)[wp.pl:s=20241105];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-34064-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	FREEMAIL_FROM(0.00)[wp.pl];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stf_xl@wp.pl,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[wp.pl:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,wp.pl:dkim,wp.pl:email,wp.pl:mid]
X-Rspamd-Queue-Id: 0096A3442AB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 27, 2026 at 12:32:19PM +0100, Johan Hovold wrote:
> USB drivers bind to USB interfaces and any device managed resources
> should have their lifetime tied to the interface rather than parent USB
> device. This avoids issues like memory leaks when drivers are unbound
> without their devices being physically disconnected (e.g. on probe
> deferral or configuration changes).
> 
> Fix the USB anchor lifetime so that it is released on driver unbind.
> 
> Fixes: 8b4c0009313f ("rt2x00usb: Use usb anchor to manage URB")
> Cc: stable@vger.kernel.org	# 4.7
> Cc: Vishal Thanki <vishalthanki@gmail.com>
> Signed-off-by: Johan Hovold <johan@kernel.org>
Acked-by: Stanislaw Gruszka <stf_xl@wp.pl>

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

