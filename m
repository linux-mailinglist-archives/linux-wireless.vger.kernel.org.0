Return-Path: <linux-wireless+bounces-12666-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C0DF971A21
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Sep 2024 14:56:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 090D228229F
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Sep 2024 12:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1048B1B81DC;
	Mon,  9 Sep 2024 12:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dCf/fA0u"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D6E01B81CC
	for <linux-wireless@vger.kernel.org>; Mon,  9 Sep 2024 12:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725886550; cv=none; b=NPZQzGAj2pY6iRRhSdPr12naJsMCVeBKaNqm4NTDRvzNaiyGlNVTmRbcNoLwCjMiiQsU9gwxaCZ9g4/8cKi7czRWwM8CzcutpadgMDragOc3/Jtyd4h3OtxEG/R0g6aFXltS8TlfrQutiLkpeil9yoD8ZSh+/W3xxIRnMKaKvtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725886550; c=relaxed/simple;
	bh=0EJFLu45fa5cVrvJvAIrk3fL9pms+WEJDbQV6tJFRms=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=cMes88oo2VfhMSjgN0ow5dr8C/29RGWYdJc7Gfhz3MjcPrNlzWdhBIJZUGGv2S3Bxy7gGjkwYxNh5OPVeFaaxFyoHjPH9Gh4buxH82wFKKEtB20DWgnTlERqFVSHk74idVkuvmTqIwXqGKwXOjjHRgEwcw0UryPpQw5dRpNqwXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dCf/fA0u; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-42cbb08a1a5so3628385e9.3
        for <linux-wireless@vger.kernel.org>; Mon, 09 Sep 2024 05:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725886547; x=1726491347; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bJFjo702X8q5uVDM9Y/osr1tGRyblMgk3zX0Xjg/pSU=;
        b=dCf/fA0ujnbFGcQv3vFj2NRMm/4iJxhyD6UFGe85AEcDWpdJ9j3zw8EwhqSmPIq0TW
         0/9MQ+2w/UTz/wJEar47oxJ4tWn+LtQk7gJjD7+FKzceJlGSgm4nKNfMnKn3ROl4d0+9
         9ZzC3G0ENWz46HOJRfrHxwFZ1kgL25pZQsDQudTYQf6piiI1O124i4REK2g37i8MH+kK
         NoFnipCy17cnHrxQo2wVLKSDvZOThwF/Q8lpLmv7P2+Br7ZbR8Y6eobQO3jsIWRlAv46
         91fpmROiGnuLaiOHJHEd55NmKZj2/lztOQFkV24uBSym6Faaj6R8Inde18rvsQFDn6dW
         9PCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725886547; x=1726491347;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bJFjo702X8q5uVDM9Y/osr1tGRyblMgk3zX0Xjg/pSU=;
        b=Z0vXDnEaqP8qSYn6FvAHE1MkFK3b2IzmAYgr1qVYtPkEpGTAsi6yJdwOBmJmsG0WxW
         sJCHFp2eu+j86DHENzvyERlwtuWOrPQk1YxdVoVT7XQpTi08tqASpgRf2BjH0DQ0h2K3
         WyrrkfleptESxQVR0eDYx/BDG2grq3liTcKVp+tjpdvKmUbaNF5wLxDc5TG46J3+jQOp
         4//Cwn1mOznhhEH4m7r06FuzOeJlFRivoQhVxJOZN8gTM5SX0N/Zi9mIxGy/2IA5lLVb
         SDAqClVj4/CnbLgZ/cIbNk3hVOMuKtRaWAD8Wn3RWRFoRMMh+ykLTfsyZQ+1VN4L5V5b
         CjOQ==
X-Forwarded-Encrypted: i=1; AJvYcCUWceipbyA0rpd2oYqMrB41eZzH30rS/GyjlJYqAm1GTfRs7Il/g/WqLmhVpRCJIiRkX7fXN7Kbv4cg16CF4w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/infULcNhII3xcVBCYXlYHFKVRFE+BLO8jTrAVowI06vwg+2T
	Ct6Ewyjq+7EJZ4c7eVjjmigM2+No6caecSvSw+I1PxQLt614HKqT
X-Google-Smtp-Source: AGHT+IFZfbmxw+BnVpvwUdEZamnT0ZP+IITsxoBFnGgcY8roL1Q8w/9wir5QSnvYZl53hXGSNi+XcA==
X-Received: by 2002:a05:600c:1d10:b0:42c:bae0:f066 with SMTP id 5b1f17b1804b1-42cbae0f268mr9608425e9.13.1725886546251;
        Mon, 09 Sep 2024 05:55:46 -0700 (PDT)
Received: from localhost (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42caeb32318sm75389955e9.17.2024.09.09.05.55.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Sep 2024 05:55:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 09 Sep 2024 14:55:45 +0200
Message-Id: <D41RPXAVWZRY.39N9OHG07XAS2@gmail.com>
Cc: "Santhosh Ramesh" <quic_santrame@quicinc.com>,
 <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
 "Sathishkumar Muruganandam" <quic_murugana@quicinc.com>
Subject: Re: [PATCH] wifi: ath12k: fix tx power, max reg power update to
 firmware
From: "Nicolas Escande" <nico.escande@gmail.com>
To: "Kalle Valo" <kvalo@kernel.org>
X-Mailer: aerc 0.18.2-0-ge037c095a049
References: <20240909073049.3423035-1-quic_santrame@quicinc.com>
 <D41LUTO0MIC3.12475D2J3VNX3@gmail.com> <87mskhgpox.fsf@kernel.org>
 <D41OHKZYZR9E.2JD7SQKZBBYGH@gmail.com> <87a5ghgjrl.fsf@kernel.org>
In-Reply-To: <87a5ghgjrl.fsf@kernel.org>

On Mon Sep 9, 2024 at 1:15 PM CEST, Kalle Valo wrote:
> "Nicolas Escande" <nico.escande@gmail.com> writes:
>
> > On Mon Sep 9, 2024 at 11:07 AM CEST, Kalle Valo wrote:
> >
> >> "Nicolas Escande" <nico.escande@gmail.com> writes:
> >>
> >> > On Mon Sep 9, 2024 at 9:30 AM CEST, Santhosh Ramesh wrote:
> >> >
> >> > [...]
> >> >
> >> >> diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wi=
reless/ath/ath12k/mac.c
> >> >> index 137394c36460..6d7a005d83b4 100644
> >> >> --- a/drivers/net/wireless/ath/ath12k/mac.c
> >> >> +++ b/drivers/net/wireless/ath/ath12k/mac.c
> >> >> @@ -7217,9 +7217,9 @@ ath12k_mac_vdev_start_restart(struct ath12k_v=
if *arvif,
> >> >>  							chandef->chan->band,
> >> >>  							arvif->vif->type);
> >> >>  	arg.min_power =3D 0;
> >> >> -	arg.max_power =3D chandef->chan->max_power * 2;
> >> >> -	arg.max_reg_power =3D chandef->chan->max_reg_power * 2;
> >> >> -	arg.max_antenna_gain =3D chandef->chan->max_antenna_gain * 2;
> >> >> +	arg.max_power =3D chandef->chan->max_power;
> >> >> +	arg.max_reg_power =3D chandef->chan->max_reg_power;
> >> >> +	arg.max_antenna_gain =3D chandef->chan->max_antenna_gain;
> >> >> =20
> >> >
> >> > For what it's worth, I already got a similar patch from QCA a few mo=
nth ago, and
> >> > it fixed some tx power problems when scanning so I know there is tru=
th in this.
> >>
> >> What hardware and what firmware did you use? The firmware branches can
> >> behave differently so whenever testing something it's good to include
> >> that info.
> >
> > Well what I tested was with the additionnal patch provided. So dependin=
g on
> > Santhosh response, I'll either give the proprer tested by tag, or if th=
e patch
> > isn't needed. I'll need to find some time to test it :)
>
> Can you say what hardware (QCN9274 or WCN7850) you are using? I'm not
> asking for Tested-on tag, just some extra information to help the
> review.

Sure, I tested it with a QCN9274, in 2*2x2 (2.4GHz + 5GHz) in station mode =
with
a special firmware WLAN.WBE.1.2.1-00148.1-QCAHKSWPL_SILICONZ-8.
Without this, all probe requests sent by the firwmare during a scan (both b=
ands)
were send with around 15/20 dBm less power that the data frames.

