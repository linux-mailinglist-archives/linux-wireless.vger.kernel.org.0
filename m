Return-Path: <linux-wireless+bounces-32140-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cJa8LS55nWmAQAQAu9opvQ
	(envelope-from <linux-wireless+bounces-32140-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Feb 2026 11:10:54 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B6A918526B
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Feb 2026 11:10:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4C4393145F15
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Feb 2026 10:09:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 868CE376BF4;
	Tue, 24 Feb 2026 10:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b="iR1WN76k"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx4.wp.pl (mx4.wp.pl [212.77.101.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F169F376BC8
	for <linux-wireless@vger.kernel.org>; Tue, 24 Feb 2026 10:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.77.101.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771927787; cv=none; b=panYGa6I2MwI5uCeTX47lU5HjJvsGCGnLgUwICCmBUz3GI/T+n7M1GNrlAl3OPtade056ETtvj3fBN43Nk0B3tCz3TlSXckQY7B/qMiDSiIItKjGldNI/obNAj1YzpKEY1r7k1t/lcumfPnoRyHMeVmJVMbiHibg7HHtxqzc9qE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771927787; c=relaxed/simple;
	bh=a5UDK46yPGfoKMTYr4gf04WdIDPuOvtig938e2CtPjY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mju2texlGMMJfSeFhSxWDk1mV+/1XT8pCdH4bpcnBoXjG7ygPU/t6AuPDvcTMezQqN1vq3wD/gltHGkuXQiUwmbzbZcf2A17SiY1MHI3hFkqgy4UmH365OWwtGosu6hu8ipqKiAe5qizSB8NltOkmZM/3q26fs5h+Nf7jQDGk30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl; spf=pass smtp.mailfrom=wp.pl; dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b=iR1WN76k; arc=none smtp.client-ip=212.77.101.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wp.pl
Received: (wp-smtpd smtp.wp.pl 30403 invoked from network); 24 Feb 2026 11:09:36 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=20241105;
          t=1771927776; bh=17/UuRMpiXKk6XtBNW2SGS7xpeuqd1Inxf0UwJVJK/8=;
          h=From:To:Cc:Subject;
          b=iR1WN76kotNiwhcsX4Ugd2b5Pc0KhUxI4C1o+/ZtEFSMDlIXvQtzXTiIayErWik8S
           o8hMBXCOxQf6dFmgYvVPomyJv3ov06+UwT0nSK6tmRdoKeJWAt+hawRI1apt9gPbcP
           wDzBshn0FHjFXwu8Wm2yREDrBtpDRgju/GnYd3Ki68fYZeBg6VVaP8w8qRp78FFwzv
           E5Ut9yjARYd4sdmuA9xxAz94o5FnuLE1kqL8abZE31snAcQCRaFVis9rOZF4qfmIfz
           7k2D45EUmb8kWzvnpRTvPpslg61awxoy5uyH8+qpjcmt0DcT3xkTD4cvOpSf5Fd5mO
           3/MmjMl18hhJQ==
Received: from 77-236-5-213.static.play.pl (HELO localhost) (stf_xl@wp.pl@[77.236.5.213])
          (envelope-sender <stf_xl@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with TLS_AES_256_GCM_SHA384 encrypted SMTP
          for <rosenp@gmail.com>; 24 Feb 2026 11:09:36 +0100
Date: Tue, 24 Feb 2026 11:09:35 +0100
From: Stanislaw Gruszka <stf_xl@wp.pl>
To: Rosen Penev <rosenp@gmail.com>
Cc: linux-wireless@vger.kernel.org,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCHv2 wireless-next] wifi: rt2x00: use generic nvmem_cell_get
Message-ID: <20260224100935.GA32009@wp.pl>
References: <20260223214004.19960-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260223214004.19960-1-rosenp@gmail.com>
X-WP-MailID: 9d380c74d42094a9c927a682e9baf3aa
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000000 [0VPx]                               
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[wp.pl,none];
	R_DKIM_ALLOW(-0.20)[wp.pl:s=20241105];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-32140-lists,linux-wireless=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,wp.pl:mid,wp.pl:dkim,wp.pl:email]
X-Rspamd-Queue-Id: 4B6A918526B
X-Rspamd-Action: no action

On Mon, Feb 23, 2026 at 01:40:04PM -0800, Rosen Penev wrote:
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

