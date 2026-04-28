Return-Path: <linux-wireless+bounces-35484-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IACtDzqJ8GloUgEAu9opvQ
	(envelope-from <linux-wireless+bounces-35484-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2026 12:17:30 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 927D94826EC
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2026 12:17:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 065EF317F237
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2026 09:39:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C96D93D5252;
	Tue, 28 Apr 2026 09:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fQZ+sdHr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F29E12EF653;
	Tue, 28 Apr 2026 09:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777369171; cv=none; b=tk2jMhMJMFLzMi83k6fp/ispo4oxQm1JGrHVtTfd86W9gpCeR2DIwPb9DtVN1c0P4SpJO154l3tQqkfo8hoHD7z3vcSPUJlG3WeuITJu8ukgN15QchClWYEFwY33J7rJkL2okSmkSMN+LejqnyQ5XNu0IS97nY8gwzMke7e6rck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777369171; c=relaxed/simple;
	bh=p7IdvtVE/evm+N22/Y2mzoWyYve0mGB/apLJBPbltXs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hcg319DMARvWXMsSU6quW2AYj7pmOZZ47JDfWy8+1ZFMInM7qaLU/YCXXPtKmyEiL/izP6k26XzNq9vQLBVzL9DHvqJaoFJBm3H24Yh1buAmQQb9ge9zqV1sXxRlhiXKDq9IqnI5d5X3mnzT7e8s2ht1PCusW6VX8sYXYWldCBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=fQZ+sdHr; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=PSRhFVtT2RWFdp856Xk+KYQvTFkIYWnEyy7wWGqEW4M=; b=fQZ+sdHr/DxtXPOoTa0/PXsoq7
	akesGkU6rpfZ8ktRkjQ7tb4j3wfiY2oC0JpAxpcj5J6QSH+4/QdbiyWoNvPOhdc3ymvaX15Tlsf6U
	+jDrDT9XWlUxaHuLTcM6FRz60Ez8QHwalzwaPVTo1RDVxgD8UnM9wteHViwqyt1dw0Y0Z82bUVQ5G
	LHZC0upELm//PQd4zJFQwM7yY1xBvPQOp7Z6Qxt3H5FLYzMbwmnUx+DgPPNFKttx2uYW4nflxpdsh
	ftGz7lpw550Tda7nMjz+4g78gSeB0NfhUtv97VPsSjZsAhQvGEgVhgTCmMoVY8FxA/dRDpdIVYyGQ
	1O7O0eKQ==;
Received: from 2001-1c00-8d85-4b00-266e-96ff-fe07-7dcc.cable.dynamic.v6.ziggo.nl ([2001:1c00:8d85:4b00:266e:96ff:fe07:7dcc] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wHeuJ-00000002bvc-0jGo;
	Tue, 28 Apr 2026 09:39:07 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id A1C1C30330B; Tue, 28 Apr 2026 11:39:05 +0200 (CEST)
Date: Tue, 28 Apr 2026 11:39:05 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Yury Norov <ynorov@nvidia.com>
Cc: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>,
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
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
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
Subject: Re: [PATCH v2 2/9] x86/extable: switch to using FIELD_GET_SIGNED()
Message-ID: <20260428093905.GA1026330@noisy.programming.kicks-ass.net>
References: <20260427214127.406067-1-ynorov@nvidia.com>
 <20260427214127.406067-3-ynorov@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260427214127.406067-3-ynorov@nvidia.com>
X-Rspamd-Queue-Id: 927D94826EC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=desiato.20200630];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-35484-lists,linux-wireless=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,redhat.com,alien8.de,linux.intel.com,zytor.com,baylibre.com,sipsolutions.net,gmail.com,analog.com,realtek.com,lunn.ch,davemloft.net,google.com,bootlin.com,rasmusvillemoes.dk,stromeko.de,watter.com,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[35];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[infradead.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[peterz@infradead.org,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,noisy.programming.kicks-ass.net:mid,infradead.org:dkim,infradead.org:email]

On Mon, Apr 27, 2026 at 05:41:19PM -0400, Yury Norov wrote:
> The EX_DATA register is laid out such that EX_DATA_IMM occupied MSB.
> It's done to make sure that FIELD_GET() will sign-extend the IMM
> field during extraction.
> 
> To enforce that, all EX_DATA masks are made signed integers. This
> works, but relies on the particular implementation of FIELD_GET(),
> i.e. masking then shifting, not vice versa; and the particular
> placement of the fields in the register.
> 
> Switch to using the dedicated FIELD_GET_SIGNED(), and relax those
> limitations.
> 
> Signed-off-by: Yury Norov <ynorov@nvidia.com>

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

> ---
>  arch/x86/include/asm/extable_fixup_types.h | 13 ++++---------
>  arch/x86/mm/extable.c                      |  2 +-
>  2 files changed, 5 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/x86/include/asm/extable_fixup_types.h b/arch/x86/include/asm/extable_fixup_types.h
> index 906b0d5541e8..fd0cfb472103 100644
> --- a/arch/x86/include/asm/extable_fixup_types.h
> +++ b/arch/x86/include/asm/extable_fixup_types.h
> @@ -2,15 +2,10 @@
>  #ifndef _ASM_X86_EXTABLE_FIXUP_TYPES_H
>  #define _ASM_X86_EXTABLE_FIXUP_TYPES_H
>  
> -/*
> - * Our IMM is signed, as such it must live at the top end of the word. Also,
> - * since C99 hex constants are of ambiguous type, force cast the mask to 'int'
> - * so that FIELD_GET() will DTRT and sign extend the value when it extracts it.
> - */
> -#define EX_DATA_TYPE_MASK		((int)0x000000FF)
> -#define EX_DATA_REG_MASK		((int)0x00000F00)
> -#define EX_DATA_FLAG_MASK		((int)0x0000F000)
> -#define EX_DATA_IMM_MASK		((int)0xFFFF0000)
> +#define EX_DATA_TYPE_MASK		(0x000000FF)
> +#define EX_DATA_REG_MASK		(0x00000F00)
> +#define EX_DATA_FLAG_MASK		(0x0000F000)
> +#define EX_DATA_IMM_MASK		(0xFFFF0000)
>  
>  #define EX_DATA_REG_SHIFT		8
>  #define EX_DATA_FLAG_SHIFT		12
> diff --git a/arch/x86/mm/extable.c b/arch/x86/mm/extable.c
> index 6b9ff1c6cafa..ceb8d03191ab 100644
> --- a/arch/x86/mm/extable.c
> +++ b/arch/x86/mm/extable.c
> @@ -322,7 +322,7 @@ int fixup_exception(struct pt_regs *regs, int trapnr, unsigned long error_code,
>  
>  	type = FIELD_GET(EX_DATA_TYPE_MASK, e->data);
>  	reg  = FIELD_GET(EX_DATA_REG_MASK,  e->data);
> -	imm  = FIELD_GET(EX_DATA_IMM_MASK,  e->data);
> +	imm  = FIELD_GET_SIGNED(EX_DATA_IMM_MASK, e->data);
>  
>  	switch (type) {
>  	case EX_TYPE_DEFAULT:
> -- 
> 2.51.0
> 

