Return-Path: <linux-wireless+bounces-32117-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AEi4CR9vnGmcGAQAu9opvQ
	(envelope-from <linux-wireless+bounces-32117-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Feb 2026 16:15:43 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 82E291789C0
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Feb 2026 16:15:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B95283100DC3
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Feb 2026 15:11:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB1E2366060;
	Mon, 23 Feb 2026 15:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b="Brc5TSLH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2C681C5D5E;
	Mon, 23 Feb 2026 15:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.145.95.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771859471; cv=none; b=na2AtKZ8LTiboAE7CE4UlR7Y39P1zxY/YkqGhIw7TY/djJ+lJUWgMaBb9TvCjBRMqyD70HtR3UCXBr2vW1f1Yvqc5LGTAimoMTHOyzLsmxphLRdFL8XzywictCu7ktt6pdWv+dTo+irubE4FEAnT8eCq2gdbMWEZ+6dP64ZBR0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771859471; c=relaxed/simple;
	bh=kGKSxwViJNEQK73vs8QsyLAdrnwEw06os2axu0yWn0s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kIEvbdiebwyAFqKJpFgCyZM4q6dTwQMMo4PTMNTxOW7zm9CM07xjtoW341L5Z1hnnVATZBo3dWX1V89iz9QGZZLivMFL6mk0gL7nx4k3iq7vf7PAE40moFr8efCmsxbAs8cj8Wo1Rl63+ECPEyYtgIYPzSuo2inbmx8OtTCcoWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk; spf=pass smtp.mailfrom=toke.dk; dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b=Brc5TSLH; arc=none smtp.client-ip=45.145.95.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toke.dk
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
	t=1771859152; bh=kGKSxwViJNEQK73vs8QsyLAdrnwEw06os2axu0yWn0s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Brc5TSLHZtc1BvrhQschbZCiFB04Sq+ang3eIqACvYTKEfekOuUgqV1MeRKuLa6wU
	 8SO5v9i81x6ry2xPzsJbetFEBKVKlhyKviRtCtfJkSElMvMBp79pykJXmNiZ15K8Kl
	 Rq/jsDjb3AEnMVt1bMjYRqxwjEpYyAEkKCAJ+1yxRmtc3bZWMXymDhCN+Getv/zx5Y
	 Kzuj0Xmq97uc8mLVKW2NWx5vI6DK5BcPFc4c6jiVjRTfiRQyAlhlAiTZDDsJRexo/u
	 EpAQEcv2+ja5lVvrrKr3gl8tyNOPk7qqjIkxFJWj08aUCN2pKR0ClTpe6kZv+B1Ej8
	 WBAIhT3vkIAgw==
To: Rosen Penev <rosenp@gmail.com>, linux-wireless@vger.kernel.org
Cc: Andreas =?utf-8?Q?F=C3=A4rber?= <afaerber@suse.de>, Manivannan
 Sadhasivam
 <mani@kernel.org>, open list <linux-kernel@vger.kernel.org>, "moderated
 list:ARM/ACTIONS SEMI ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>, "moderated list:ARM/ACTIONS SEMI
 ARCHITECTURE" <linux-actions@lists.infradead.org>
Subject: Re: [PATCH ath-next] wifi: ath9k: simplify eeprom format strings
In-Reply-To: <20250821033908.638871-1-rosenp@gmail.com>
References: <20250821033908.638871-1-rosenp@gmail.com>
Date: Mon, 23 Feb 2026 16:05:54 +0100
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <874in7o5yl.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.95 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MIXED_CHARSET(0.71)[subject];
	DMARC_POLICY_ALLOW(-0.50)[toke.dk,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[toke.dk:s=20161023];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32117-lists,linux-wireless=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[toke.dk:+];
	MISSING_XM_UA(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[toke@toke.dk,linux-wireless@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[toke.dk:mid,toke.dk:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 82E291789C0
X-Rspamd-Action: no action

Rosen Penev <rosenp@gmail.com> writes:

> devm is already used here so might as well simplify the whole function
> with devm_kasprintf.
>
> Signed-off-by: Rosen Penev <rosenp@gmail.com>

(sorry for not getting around to replying to this before)

> ---
>  drivers/net/wireless/ath/ath9k/ath9k.h                |  2 +-
>  drivers/net/wireless/ath/ath9k/ath9k_pci_owl_loader.c | 11 +----------
>  drivers/net/wireless/ath/ath9k/init.c                 |  7 +++----
>  drivers/net/wireless/ath/ath9k/rng.c                  |  4 ++--
>  4 files changed, 7 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/net/wireless/ath/ath9k/ath9k.h b/drivers/net/wireless/ath/ath9k/ath9k.h
> index 6e38aa7351e3..60aac2c50409 100644
> --- a/drivers/net/wireless/ath/ath9k/ath9k.h
> +++ b/drivers/net/wireless/ath/ath9k/ath9k.h
> @@ -1076,7 +1076,7 @@ struct ath_softc {
>  #ifdef CONFIG_ATH9K_HWRNG
>  	struct hwrng rng_ops;
>  	u32 rng_last;
> -	char rng_name[sizeof("ath9k_65535")];
> +	const char *rng_name;

Changing this fixed buffer to a devm-managed pointer makes no sense: it
doesn't help with any lifetime issues, and just adds overhead.

>  #endif
>  };
>  
> diff --git a/drivers/net/wireless/ath/ath9k/ath9k_pci_owl_loader.c b/drivers/net/wireless/ath/ath9k/ath9k_pci_owl_loader.c
> index fe1013a3a588..c4f8d1f98369 100644
> --- a/drivers/net/wireless/ath/ath9k/ath9k_pci_owl_loader.c
> +++ b/drivers/net/wireless/ath/ath9k/ath9k_pci_owl_loader.c
> @@ -140,19 +140,10 @@ static void owl_fw_cb(const struct firmware *fw, void *context)
>  static const char *owl_get_eeprom_name(struct pci_dev *pdev)
>  {
>  	struct device *dev = &pdev->dev;
> -	char *eeprom_name;
>  
>  	dev_dbg(dev, "using auto-generated eeprom filename\n");
>  
> -	eeprom_name = devm_kzalloc(dev, EEPROM_FILENAME_LEN, GFP_KERNEL);
> -	if (!eeprom_name)
> -		return NULL;
> -
> -	/* this should match the pattern used in ath9k/init.c */
> -	scnprintf(eeprom_name, EEPROM_FILENAME_LEN, "ath9k-eeprom-pci-%s.bin",
> -		  dev_name(dev));
> -
> -	return eeprom_name;
> +	return devm_kasprintf(dev, GFP_KERNEL, "ath9k-eeprom-pci-%s.bin", dev_name(dev));

This change sort of makes sense, given that devm is already used. But
really, it shouldn't be; the name is only used to pass it to
request_firmware_nowait(), so the devm management is totally
superfluous. Better to change it to an on-stack buffer like the other
call instead (maybe just by getting rid of the owl_get_eeprom_name()
helper entirely, and moving the scnprintf() into the caller).

>  }
>  
>  static void owl_nvmem_work(struct work_struct *work)
> diff --git a/drivers/net/wireless/ath/ath9k/init.c b/drivers/net/wireless/ath/ath9k/init.c
> index ee951493e993..04903b5c611f 100644
> --- a/drivers/net/wireless/ath/ath9k/init.c
> +++ b/drivers/net/wireless/ath/ath9k/init.c
> @@ -625,7 +625,7 @@ static int ath9k_of_init(struct ath_softc *sc)
>  	struct ath_hw *ah = sc->sc_ah;
>  	struct ath_common *common = ath9k_hw_common(ah);
>  	enum ath_bus_type bus_type = common->bus_ops->ath_bus_type;
> -	char eeprom_name[100];
> +	const char *eeprom_name;

Changing an on-stack buffer to a devm-managed one also doesn't make any
sense.

-Toke

