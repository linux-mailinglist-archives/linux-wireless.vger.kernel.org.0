Return-Path: <linux-wireless+bounces-36233-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aCh/Mb7tAWr0mQEAu9opvQ
	(envelope-from <linux-wireless+bounces-36233-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 11 May 2026 16:54:54 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F297510A4E
	for <lists+linux-wireless@lfdr.de>; Mon, 11 May 2026 16:54:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CB9C0300D1D4
	for <lists+linux-wireless@lfdr.de>; Mon, 11 May 2026 14:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FA163FFAC8;
	Mon, 11 May 2026 14:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="X+NxNDpB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CE96401492
	for <linux-wireless@vger.kernel.org>; Mon, 11 May 2026 14:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778511283; cv=pass; b=M3pa93B5sysUkN6jShjPzfDeVzj+unwSJC7xA4bbRo3VhWP7HoSdoqOZ/pPYmURvDJ474SlAFmisapYsYteJAge+epPXnKSrBGW+yXQR10kBrfqN872gu34oQYRGGY2Tw89BF1gkePkjd6SbJFDzfC0B7HzmJH/DjtlKoxAScAI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778511283; c=relaxed/simple;
	bh=I9qo4iu/lGpI3j9s93ypUJxrsS0jGrvIFGrhc5NQn6U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YiGHxm8Rn1pRNr7zhKFlfj6rTNgI7pctuR1TpBWr/+st1100tjlrB0A9UM1utFmHGAGxOo4artV8Js4AZFDGsorp1nWW9zYYP9Q1RREH4ZTtnxNFbT8SnJAMDsrEsEI+wKCMpw0kZqz8Ifocq8Mp8HqJ9TqOob8U+XlsKT5Jxpw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=X+NxNDpB; arc=pass smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-7bde9d73678so46292147b3.0
        for <linux-wireless@vger.kernel.org>; Mon, 11 May 2026 07:54:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778511280; cv=none;
        d=google.com; s=arc-20240605;
        b=dHnWV6FylmSfF3Sfm2PcQc8XobHlxlAHO/CBDtiEwCnpJ/yjqwjG2WnE2nKYj1vSTa
         ahwtblK5KIUxvhPJ0WQDovpX3RT8XYw/9RihrJPuUn0icrf88kA7+4qCmNJW3LhJNKls
         itjfT8551RseNmpzJ+FSiOgI4xY42yHale+GnlrixYJ1TW7pV3FQ3ibyXygaXWpyt2IV
         GXy7Jn7xO1IOIAf896O+uwzHEH+bC9Khl3mGSDbTjwqq28n7P8GyZyRypS8NsqtbCWNg
         EHrMA/8jpHXQhFucG8E2lPAG15SBpGCQaVZUYfm8jbuNyl4IdQsX2FT0kt2yVDODV6Q2
         uYlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=A7NUC6AajstAM2rRNdd54pVilaJ3jXs4RoWAQN/sufw=;
        fh=Yvhw7zC6fhMJBaGkHbvGUVkI8vHAuKWHI9in5YrAmJA=;
        b=T0+iIMz/gvhBOE73DqvuRnUzeFXerC/cUyOqClwCD9FdhUtLRQJ70QFbMR4mXVZe4q
         rOf7sZWIeq89WL02mdE0SVhFYzyY5XgRNN+CxPLK8NWUUFWHRBg6tK9JOmhX/UEOkwXc
         jcYCJHFS6fhzLjIRKx1e6i5xuRh1jScDXlfyjNmpFGLVqgfd4clfncFFfeOlxaFrRUTG
         kPHwv+6GqMJ8tlUjsoHkX2jINAMyeC+1SzeQGb/FQQh0KBPzNpiEv3Nn8Cj5/v2MTFOG
         28Equ9NHX+FGhpzvg4MQkKO2/v1D/YS7ZRBndL56hjszguV8FmivT7ZUh1Dw8FiTRPwI
         BLWg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1778511280; x=1779116080; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=A7NUC6AajstAM2rRNdd54pVilaJ3jXs4RoWAQN/sufw=;
        b=X+NxNDpBP2RsE6LuXUqUhBJSVRie851XqMsW1T/tqKFmOSHlBo2qw8ISW+NPFiAOh9
         2ZzFwUvW7fChsc05bqnBs7w9ivcY7BH4q1li7mIRvTb1vgH2lObmwdRrEMttjtfmojs2
         6Oc9tGvkpECLd6y8Rv/4LrSeB4GVWotfHDVOJemg37RwZuPzx0LH56g30GtTr5+EEooz
         Gtpcy5mQua7l9zOFI80HgYcTEln9R0ENcD2bIGhkvMxG/0Z1tQfWY6C4moCw63DgZq9l
         AF7LW3Vp4tv/Apjm0fJe5iRMVTFZR7aghME8vRkaidYtA+WJyYglnhNvGtb5PYe3TP8I
         luXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778511280; x=1779116080;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A7NUC6AajstAM2rRNdd54pVilaJ3jXs4RoWAQN/sufw=;
        b=B7qWYqGAvCIOArrE98GHWZLvY326JJUGoo0Aq0AVAqxGNgll42/dxmUP3eUdZJ0tDt
         bu4w9Y/LRP4qZSa2j19DAVl9fyIgXd17QqG3PTbnBpD4Xb8l5UHSTlQtR4X8qkVHB0Bl
         eMiExyCRB77G0hxY55npgLjfoSzqMlksAT73AYM8r04a03cD5/y+nWCDaALTTAts0Hih
         qwk6Y6ktCYCgK9iXkoXMUm/qPHQ/4/yKcAW+DrTI+4lVvo5CsqePkaDQMk6/lLrk83gJ
         Nys7VoZfCA8NAZT+UPOk+Zsp4L0H8RRraB6sqA92kvJHP/N/KylLSQPHbrfsjd0RxUPd
         pqcw==
X-Forwarded-Encrypted: i=1; AFNElJ+blfCKuJczeUum7RLJ5hIKb6onUh9Fps28IiVmtECMXJKeielUpSmu/KjgpUFm5JfljQ9Pbl5lAN/vp7R5+Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzp2rMA+XeoS8PLPYc2Eqd4MFKwvdr40Y6LryKiTN39TUY9XjnF
	im24V93ycaiSGk4jcebnGM4kBSCELk003RtVtZFnLKF37ti/zPHDTb602mCZhrpll+yChGgwLjX
	Vu/Ujzva9VYitVY3V+T0RVu3pM+VjEFKJSPP3Fn4pbg==
X-Gm-Gg: Acq92OHcsdzgvBAfEYvU3ng/AXZSeR8fDYTqrwiKpF38kQUBd4uxBRcA04AZ/3D+OY1
	juIXf7PtkjiQ9/Nrw99LC7qTgJXr5RfVqzjJSZrMdpU8dFxZktt0yKuXvPh/FVIGRV8NxeHGy50
	eg1X2CnD7Oi2KJP7CGNeq5r70smDfI2wKRNdHbkOT79/assXeKsZcpfsnB8pruorv7RPKkh5UKJ
	wFvBXORd5FX37neo2SJJ5ziDF9Wz5uEVynPoXqyaYCDdpsDhL21Pidv+ah30mmJhLRG/EkWn28X
	i6Mis7gq
X-Received: by 2002:a05:690c:f06:b0:7ba:fd82:9121 with SMTP id
 00721157ae682-7bf04c314ddmr148104837b3.12.1778511280347; Mon, 11 May 2026
 07:54:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260430045615.334669-1-lachlan.hodges@morsemicro.com> <20260430045615.334669-22-lachlan.hodges@morsemicro.com>
In-Reply-To: <20260430045615.334669-22-lachlan.hodges@morsemicro.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 11 May 2026 16:54:01 +0200
X-Gm-Features: AVHnY4JWfsrKbkqzJ2r2MSmWzNdF30HH3zv6ON9KnU6Yl_xtARtc44QtPLgfbDU
Message-ID: <CAPDyKFrBdFxkGjj=y2Qz6Jx5A_HQbxh=nnwWHEtWK+NrADD-uQ@mail.gmail.com>
Subject: Re: [PATCH wireless-next v2 21/31] mmc: sdio: add Morse Micro vendor ids
To: Lachlan Hodges <lachlan.hodges@morsemicro.com>
Cc: johannes@sipsolutions.net, Ulf Hansson <ulfh@kernel.org>, arien.judge@morsemicro.com, 
	dan.callaghan@morsemicro.com, ayman.grais@morsemicro.com, 
	linux-wireless@vger.kernel.org, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 4F297510A4E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-36233-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linaro.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ulf.hansson@linaro.org,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mail.gmail.com:mid,linaro.org:email,linaro.org:dkim,morsemicro.com:email]
X-Rspamd-Action: no action

On Thu, 30 Apr 2026 at 06:58, Lachlan Hodges
<lachlan.hodges@morsemicro.com> wrote:
>
> Add the Morse Micro mm81x series vendor ids.
>
> Signed-off-by: Lachlan Hodges <lachlan.hodges@morsemicro.com>

Acked-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
>
> v1 -> v2:
>
> - Use a single VENDOR_ID
> - Drop B2 chip which is not needed
>
> Ulf, a mistake was made in v1 [1] listing multiple vendor IDs instead
> of a single vendor ID and the subsequent device IDs. As for why
> the series is structured as a series of singular patches is due to
> how wireless driver submissions are as per [2] to simplify review
> due to the size. The final submission will be sent as a pull request
> with all driver files as a single commit and this SDIO commit
> beforehand going through the wireless tree once you have acked.
>
> [1] https://lore.kernel.org/linux-wireless/CAPDyKFp6dhmpkMCs=ejYTpR9oNbNz0urtFD2HTvRwOp2Y7H3DA@mail.gmail.com/
> [2] https://wireless.docs.kernel.org/en/latest/en/developers/documentation/submittingpatches.html#new-driver
>
> ---
>  include/linux/mmc/sdio_ids.h | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/include/linux/mmc/sdio_ids.h b/include/linux/mmc/sdio_ids.h
> index 0685dd717e85..111cb1758830 100644
> --- a/include/linux/mmc/sdio_ids.h
> +++ b/include/linux/mmc/sdio_ids.h
> @@ -117,6 +117,9 @@
>  #define SDIO_VENDOR_ID_MICROCHIP_WILC          0x0296
>  #define SDIO_DEVICE_ID_MICROCHIP_WILC1000      0x5347
>
> +#define SDIO_VENDOR_ID_MORSEMICRO              0x325b
> +#define SDIO_DEVICE_ID_MORSEMICRO_MM81XB2      0x0809
> +
>  #define SDIO_VENDOR_ID_NXP                     0x0471
>  #define SDIO_DEVICE_ID_NXP_IW61X               0x0205
>
> --
> 2.43.0
>

