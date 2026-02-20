Return-Path: <linux-wireless+bounces-32053-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2AYUOgk6mGmFDQMAu9opvQ
	(envelope-from <linux-wireless+bounces-32053-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Feb 2026 11:40:09 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5157C166E63
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Feb 2026 11:40:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D88BA3029AC9
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Feb 2026 10:37:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AB0133DEE6;
	Fri, 20 Feb 2026 10:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b="TlOgqWT5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx3.wp.pl (mx3.wp.pl [212.77.101.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 055C03314C4
	for <linux-wireless@vger.kernel.org>; Fri, 20 Feb 2026 10:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.77.101.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771583870; cv=none; b=YTUpCl5udTZzKZxxAmy23sdr7Y9WmvhPp7p6GX9wHMTw6XppJaJrDh17fwekXcr0PcDmuqFRXoLxYwKhNF/sDYZ99CQAqYsTmQT4lcDI81tNYXmkKT+pO2Gb+tQwMehLNU+R+GVjFkizj7R+6GF/KP4QC/IgP8xuGHhku40SVnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771583870; c=relaxed/simple;
	bh=ZF7rW4fbWVW9Fa77qHRlktNthr0+POiyyUZG8GPD8r0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PyZGHFyc1lFK0mrnjiRVSf7gXsQnyIkMZo6S4U2HASLj5OnO4F0R0bkt6rOQJgwqqVFIzwjy+MTyjg/gKqZGVpOWCXJqS7qKzbBc5SmOVPjp7SOiMYh2KpLxwfTqUseG/5cWX2QhvJ7OP7g6zbl0ZbYh9e2o93ZDryDiC/pkc7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl; spf=pass smtp.mailfrom=wp.pl; dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b=TlOgqWT5; arc=none smtp.client-ip=212.77.101.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wp.pl
Received: (wp-smtpd smtp.wp.pl 4309 invoked from network); 20 Feb 2026 11:37:39 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=20241105;
          t=1771583859; bh=pLhYtOxr7WkhCfEAN47xYLkxWHVoKzPf9owmh2YlMmE=;
          h=From:To:Cc:Subject;
          b=TlOgqWT5rjWYli0tzucTofrOcQ4AXazZ7QNHE4U8j9U30MiZlgoZuoI8R7kilQxIG
           IiqhTmqshNt5CikPG5IeWLvWB/CA9g6C1lo9Wpz9sBcv7uBpBkUVUSCLkHeMhC+22e
           lIzfIWoGZAb55DOSGJUTZFCFrmQ83lIo3kEEoo5M+KNVEbl6SQIJ78WFSJ4g/QNuqV
           yK52xwH6OvfDrW5InaysVYmSOn2jnb/BdLcf0Cjte8s4PNLHh1DFpNkzugXjfRgjH3
           0ySb8GwXhR76NnEr7BY1rVpo2q2rR/kysYhwOEySdxYAyXtCNb6fiwTKjOMBha9w1n
           tljn3dFutIN0A==
Received: from 89-64-9-107.dynamic.play.pl (HELO localhost) (stf_xl@wp.pl@[89.64.9.107])
          (envelope-sender <stf_xl@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with TLS_AES_256_GCM_SHA384 encrypted SMTP
          for <rosenp@gmail.com>; 20 Feb 2026 11:37:39 +0100
Date: Fri, 20 Feb 2026 11:37:39 +0100
From: Stanislaw Gruszka <stf_xl@wp.pl>
To: Rosen Penev <rosenp@gmail.com>
Cc: linux-wireless@vger.kernel.org,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] wifi: rt2x00: use non of nvmem_cell_get
Message-ID: <20260220103739.GA20961@wp.pl>
References: <20260220020908.40115-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260220020908.40115-1-rosenp@gmail.com>
X-WP-MailID: a86f56928f890de4dfe4c6dc9c9f3e30
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000000 [sSPh]                               
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[wp.pl,none];
	R_DKIM_ALLOW(-0.20)[wp.pl:s=20241105];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-32053-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FREEMAIL_FROM(0.00)[wp.pl];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stf_xl@wp.pl,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[wp.pl:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5157C166E63
X-Rspamd-Action: no action

On Thu, Feb 19, 2026 at 06:09:08PM -0800, Rosen Penev wrote:
> The library doesn't necessarily depend on OF. This codepath is used by
> both soc (OF only) and pci (no such requirement). After this, the only
> of specific function is of_get_mac_address, which is needed for nvmem.
> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
Acked-by: Stanislaw Gruszka <stf_xl@wp.pl>

> ---
>  drivers/net/wireless/ralink/rt2x00/rt2800lib.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/wireless/ralink/rt2x00/rt2800lib.c b/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
> index 65d0f805459c..93e4ce604171 100644
> --- a/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
> +++ b/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
> @@ -10965,13 +10965,13 @@ EXPORT_SYMBOL_GPL(rt2800_read_eeprom_efuse);
>  
>  int rt2800_read_eeprom_nvmem(struct rt2x00_dev *rt2x00dev)
>  {
> -	struct device_node *np = rt2x00dev->dev->of_node;
> +	struct device *dev = rt2x00dev->dev;
>  	unsigned int len = rt2x00dev->ops->eeprom_size;
>  	struct nvmem_cell *cell;
>  	const void *data;
>  	size_t retlen;
>  
> -	cell = of_nvmem_cell_get(np, "eeprom");
> +	cell = nvmem_cell_get(dev, "eeprom");
>  	if (IS_ERR(cell))
>  		return PTR_ERR(cell);
>  
> -- 
> 2.53.0
> 

