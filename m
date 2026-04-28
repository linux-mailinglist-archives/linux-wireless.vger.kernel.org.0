Return-Path: <linux-wireless+bounces-35490-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uLdyBDjG8GkqYgEAu9opvQ
	(envelope-from <linux-wireless+bounces-35490-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2026 16:37:44 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B4214871F8
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2026 16:37:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1CA6430D2EFB
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2026 14:21:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C65BB42EEBA;
	Tue, 28 Apr 2026 14:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="vxjVaeVo"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B6994418CC;
	Tue, 28 Apr 2026 14:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777386063; cv=none; b=dPS63SdYNpofgWXtGLiEoAu+3fd/RWZy6cuAR8t/sI6yiM7B/nkgS+4J0ACQeMCoBOWt3Jh1imkQzEojWzR7adh8hmQdH4tfzZk7CsRT9NrVLzteqgVftUjF7u8B92inH/ZPoCDD5e6zhASNrT+P16qp3B/q8TnkdA+MuNrbYws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777386063; c=relaxed/simple;
	bh=Gf+XrcYgPenGEIKbsoSDcC9F+FbyEhYGvpS57tMlaI0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OICK6HWQNvOkkcFe8gi4Y6kzK/6UhiwJYkhBL68KsniClzJrJ/Bte5Gr7hBiU5TTFTIZctUAeiC3eZFW1pIqCw4IKKd03Buq2cozsYau22kuLiMSbGYn16za2S/4DIRuxJ1eimZ+hT2x+9gTZ1uDZ3uODbsmaZhYlhgrHXyYZgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=vxjVaeVo; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 2E8E3C5EF13;
	Tue, 28 Apr 2026 14:21:36 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 71025601D0;
	Tue, 28 Apr 2026 14:20:52 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C9BD910728AA4;
	Tue, 28 Apr 2026 16:20:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1777386050; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=Se88myibkKEKJupqIWVDpzFA5fJPWlqZId0UB7SQ3r8=;
	b=vxjVaeVoViKGSjmy7yA8GP/7DlUObLqX7S8zv6rcnNtDxwGmIJXvVzu3v4mrrviqaY5A9e
	LJp++FMBsE1rBNkgf+gPOlF7M4dmIf8dfvFsZ8mr/BXasf4iWnFFBYk6V5+ocpAxJmQclD
	dqAoNv2o6aTuDlojzUMk7cANEAVzmJvw9SwcZ66z57zpBrriy/fe+UhXu8x6GUD8ItAIjn
	5OwX3oTmK5ouLl/du3JxUfurO0KeigVf4PiX8ZzxgUeGMefgok2tSohk1VICdEGxouRQs/
	QVYdzCGuyaj+yMIMPX6HUQ2HwIPF/1GVumnQAW14Vjlp9xzAmcvW2MbU7oEcvg==
Date: Tue, 28 Apr 2026 16:20:40 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Yury Norov <ynorov@nvidia.com>
Cc: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	David Laight <david.laight.linux@gmail.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Hans de Goede <hansg@kernel.org>, Linus Walleij <linusw@kernel.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Salah Triki <salah.triki@gmail.com>,
	Achim Gratz <Achim.Gratz@stromeko.de>,
	Ben Collins <bcollins@watter.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
	linux-rtc@vger.kernel.org
Subject: Re: [PATCH v2 8/9] rtc: rv3032: switch to using FIELD_GET_SIGNED()
Message-ID: <202604281420408aa2e078@mail.local>
References: <20260427214127.406067-1-ynorov@nvidia.com>
 <20260427214127.406067-9-ynorov@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260427214127.406067-9-ynorov@nvidia.com>
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Queue-Id: 1B4214871F8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-35490-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,redhat.com,alien8.de,linux.intel.com,zytor.com,infradead.org,baylibre.com,sipsolutions.net,gmail.com,analog.com,realtek.com,lunn.ch,davemloft.net,google.com,rasmusvillemoes.dk,stromeko.de,watter.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[35];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexandre.belloni@bootlin.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[bootlin.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.local:mid,bootlin.com:email,bootlin.com:dkim,bootlin.com:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:email]

On 27/04/2026 17:41:25-0400, Yury Norov wrote:
> Switch from sign_extend32(FIELD_GET()) to the dedicated
> FIELD_GET_SIGNED() and don't calculate the fields length explicitly.
> 
> Signed-off-by: Yury Norov <ynorov@nvidia.com>
Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

> ---
>  drivers/rtc/rtc-rv3032.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/rtc/rtc-rv3032.c b/drivers/rtc/rtc-rv3032.c
> index 6c09da7738e1..6bafdec637ae 100644
> --- a/drivers/rtc/rtc-rv3032.c
> +++ b/drivers/rtc/rtc-rv3032.c
> @@ -376,7 +376,7 @@ static int rv3032_read_offset(struct device *dev, long *offset)
>  	if (ret < 0)
>  		return ret;
>  
> -	steps = sign_extend32(FIELD_GET(RV3032_OFFSET_MSK, value), 5);
> +	steps = FIELD_GET_SIGNED(RV3032_OFFSET_MSK, value);
>  
>  	*offset = DIV_ROUND_CLOSEST(steps * OFFSET_STEP_PPT, 1000);
>  
> -- 
> 2.51.0
> 

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

