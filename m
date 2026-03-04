Return-Path: <linux-wireless+bounces-32473-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mMrWAt1hqGmduAAAu9opvQ
	(envelope-from <linux-wireless+bounces-32473-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 04 Mar 2026 17:46:21 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FBF72048C5
	for <lists+linux-wireless@lfdr.de>; Wed, 04 Mar 2026 17:46:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 550193011344
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Mar 2026 16:46:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84EA236F41D;
	Wed,  4 Mar 2026 16:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gqViPD7A"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD04F371CF5
	for <linux-wireless@vger.kernel.org>; Wed,  4 Mar 2026 16:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772642763; cv=pass; b=a7JfOHhs0Ao147vG4yYSwI9MloQIOQq01E7LM4vUsjqtSAKh8bajzUhK6+LW/WSrXxxizrR6ZUlgAXv2wklXeWM925solcnjFT2d+lYLz0ih3z9IhJw16o2cMxV8D5KSaTiuiDTXcQnhikbHAgEuvKh8/EPixb2Z37LCEVqeYtE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772642763; c=relaxed/simple;
	bh=Xn4mrHZ95N428i6MZYQDXnsrCqWWD9RHngc4Mamma+w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FrZ4zab2oHrO4G/kPMCtuHU3G7+46Lp6q719/roFFUNQsiiWAhw4RS9PXqTMOA73Vi8J/SWmnwov+1Wk4vm3yUxZXA3nO0OdVIlJeiLIRTR9fWGb14wapksxCnU1U/rxUkIRpYWDm8ANPFBJZwCHLWEXkXV99HwVJSGiIS8tGsQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gqViPD7A; arc=pass smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-38a2544b52bso33283261fa.3
        for <linux-wireless@vger.kernel.org>; Wed, 04 Mar 2026 08:45:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772642758; cv=none;
        d=google.com; s=arc-20240605;
        b=bzsYya3QCw0JYOJr3tswA5ibOwI8O83iWDILZYy4dBdmYrTfmMtAzzYgFbucpwksNQ
         7x3v/efmcNUrlSgmkjhUw1S28dRktkzisn8RQK50RsaeXRLy/MTO3QSvF9pCsaxu2NQA
         O4+ObHRdeLOidskIM5LxdYfbdLsnJaPJ0Ebudbc2TMT5e+udFwEwQ0PlqV1e9l03xe4o
         gLi5hMzqU9F32G9L9mkAUpNXYnoKiGKDRW6ZEbO1UaAkLkmsp5ll5Gir6t7gEjBgsuJh
         uokVgOA0FNNm0MvsSeptsEDY6nXW+P/HWw5rFlJvr4EbODI3/phQR3LVdSblDj/EZpzM
         fotA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=k3qxdlKEuPdrJH8Pte/wff3Ygvq/uxu8SZlFOQqhsHk=;
        fh=lP4TrvoVOnbter2utlXMCTMmBgZGtjtIuQX6KFZr/Q4=;
        b=k6RCSjZ/TvJVQyOQd9Tf723/PksoNQScGHL02XSqmQ65bui+FTQqylDsTwxDSC3LPr
         0aihtUQLuA+IbE6cC8iCS/0XS+6fp6HdUHoRQnvE/u6MnyXg8DaJuKJ1JqTI4YP1vKMJ
         O6kgoCdxkj8WEbWFlGu8FoLVPGSVgpfSFEmTe5bTxslG2/9A/lWMgWN2VAYzADRwSKMG
         409eWxNEnd+DZdJju4gBdg9Op0CnbpwbaI5IChTNXRc8F+QbqV4BAYrrX0KI+Fkhi0Qg
         8dfTRd6rafb+XKU5q2BgcJjhG5+c0fuKdstsMA/5P1P0OnEJk3LQ9O2hGp0covQxF7K+
         UiWQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1772642758; x=1773247558; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=k3qxdlKEuPdrJH8Pte/wff3Ygvq/uxu8SZlFOQqhsHk=;
        b=gqViPD7AjhGGcy/Uh0WRIZ9ovyrfnToge8AlufXLERIk6aooH8MwP7R1rs83cHoJx9
         Tpfc96ZhrWpRvSpm5oZAxjiUed7s/BzEWAXEQqA7XudlOQLKtgHoVBS+TxifhZLkzbL2
         XktVh31nriiTyKzf6qZmkK9JTEo3D27FEfXeKr5MtZljrRYHGB7sumlPkBjLkfiN3R7R
         +BBvQEjmWSfNPUPnRQVK5lAMoOJzltsiS82ANpGwfkyE56AdpkhPG8DWo+tfemzHScEH
         e7OVq55PXY7OA8qCqhQ5yR/IADG5MdmoTfPvmo2fhz3VbkIxVD9rNwiLa2ftp+pBwTV8
         TWSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772642758; x=1773247558;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k3qxdlKEuPdrJH8Pte/wff3Ygvq/uxu8SZlFOQqhsHk=;
        b=cIt5pQjCO0wEGiiKUvcX0N5/wUEfBFz9hD5gP/MCe38wAZHDxvjQVI7d75gvjHp4oE
         2p/vCtICfBKuCAZfvWtRmsfCiOxEkosbX83iGM9PS5IZrlLH9AQq0/zKJ9NgDJDOh1E0
         Rqgbi9OKaAUzx2dn5XTPvSoA15o99N2W67AwgecU1f4vgks8sBlwf4Ub7uTXUGTxgWQ1
         ygcwtZG5OXwVYJsbFRFyij7E4wYjaRWjnavRQGVyA05hogM5EI/6+/xXwqBOsw44tc7h
         D8kzFywdde+IITaT8CwhXFmZQPE7WmMw7Qv6AGgO50V2NK5j0hUyuxSRo/B5AkT73OGW
         PMzg==
X-Forwarded-Encrypted: i=1; AJvYcCWLNAQiGyTi4VjfLFk6AwHbijDVMPVKNlnOB+KhT1aqIAihdic3B/7n6ZHW0vdorZvlKu6HJF5tD1Zpy9/hOA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyrZ6i4noV0B5gxpsGUYgHAOzCaLWiqBAD3t+emTbZLrW3+BMj8
	FEVUog7Vzsb++x1GbIE5H37nyP4eqTSfyd0QslIj73aEhNoJxU5gQSEvZtum4KMtdQ51HNmFQvu
	xihV7FbMyJ0xwnNTybPl9LRtkInwJgWIYVuUF4mvsIw==
X-Gm-Gg: ATEYQzz48y/LqN3I25JhoP/OSRGaoF0Xp99QEty+XZRLIJ1dE9zHALjc+q2aqtLXZ34
	lC2YSaPR4sik1nuxz5no6h+Q3zWcyIzYQYTkv0a1y/orGZS44lwKErKcibyFk9OMDWFS/oXAUol
	e4i6lUpNbZMyXk5dXp0gAs7/VhQXBsF5N1hvc7hjey5dzSCFM5yVVI9FcJoHyMNfPOE2XbnCqmU
	UL5tXe/uyeGMJTm9E/kdIGnk4Ql64JDmqbIZtQ1UOBfsxGIGkVwqqFK8IhtXx2xUPimFdLssf/Q
	PI7UkrQU
X-Received: by 2002:a05:651c:1509:b0:38a:2792:b4f7 with SMTP id
 38308e7fff4ca-38a2c5b6039mr19908311fa.24.1772642757581; Wed, 04 Mar 2026
 08:45:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260227041108.66508-1-lachlan.hodges@morsemicro.com> <20260227041108.66508-34-lachlan.hodges@morsemicro.com>
In-Reply-To: <20260227041108.66508-34-lachlan.hodges@morsemicro.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 4 Mar 2026 17:45:21 +0100
X-Gm-Features: AaiRm52dRDirGfxBP2ZwBErVxf4sLGIJPu_ID9B-Ngv6BgEM7NPLN6E8EgHqA7U
Message-ID: <CAPDyKFp6dhmpkMCs=ejYTpR9oNbNz0urtFD2HTvRwOp2Y7H3DA@mail.gmail.com>
Subject: Re: [PATCH wireless-next 33/35] mmc: sdio: add Morse Micro vendor ids
To: Lachlan Hodges <lachlan.hodges@morsemicro.com>
Cc: johannes@sipsolutions.net, arien.judge@morsemicro.com, 
	dan.callaghan@morsemicro.com, ayman.grais@morsemicro.com, 
	linux-wireless@vger.kernel.org, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 9FBF72048C5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-32473-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linaro.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ulf.hansson@linaro.org,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Action: no action

On Fri, 27 Feb 2026 at 05:15, Lachlan Hodges
<lachlan.hodges@morsemicro.com> wrote:
>
> Add the Morse Micro mm81x series vendor ids.
>
> Signed-off-by: Lachlan Hodges <lachlan.hodges@morsemicro.com>

I understand that those vendor ids will be used by the sdio func
driver to match against. Although, the way the series is ordered makes
no sense to me. Each patch doesn't compile by itself.

Anyway, feel free to add my ack, once you have sorted out how
re-structure your series.

Acked-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe


> ---
>  include/linux/mmc/sdio_ids.h | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/include/linux/mmc/sdio_ids.h b/include/linux/mmc/sdio_ids.h
> index 673cbdf43453..3ccfe3679c91 100644
> --- a/include/linux/mmc/sdio_ids.h
> +++ b/include/linux/mmc/sdio_ids.h
> @@ -116,6 +116,10 @@
>  #define SDIO_VENDOR_ID_MICROCHIP_WILC          0x0296
>  #define SDIO_DEVICE_ID_MICROCHIP_WILC1000      0x5347
>
> +#define SDIO_VENDOR_ID_MORSEMICRO              0x325B
> +#define SDIO_VENDOR_ID_MORSEMICRO_MM81XB1      0x0709
> +#define SDIO_VENDOR_ID_MORSEMICRO_MM81XB2      0x0809
> +
>  #define SDIO_VENDOR_ID_REALTEK                 0x024c
>  #define SDIO_DEVICE_ID_REALTEK_RTW8723BS       0xb723
>  #define SDIO_DEVICE_ID_REALTEK_RTW8821BS       0xb821
> --
> 2.43.0
>

