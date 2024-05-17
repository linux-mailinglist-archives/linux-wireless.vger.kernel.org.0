Return-Path: <linux-wireless+bounces-7791-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 362278C8A2D
	for <lists+linux-wireless@lfdr.de>; Fri, 17 May 2024 18:36:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF7841F28720
	for <lists+linux-wireless@lfdr.de>; Fri, 17 May 2024 16:36:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 512AF13DB8A;
	Fri, 17 May 2024 16:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T8gOTyD+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C538D13D8B5;
	Fri, 17 May 2024 16:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715963751; cv=none; b=IZ6KnqmowPJzep1jxqbW5VtZDwSxP78h5as7hbkM3CcybETyreKmvUtmp51fXN3xbyF5i6IpMrBTgmfqf/z+ghEP2ESlCA3qF8/2RaGg6LiHze74CnDRhIHQ6qnRjOhXftslh2s1qOTCpR/73IVpe0aMoNYAXqhwR+vUsef8KEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715963751; c=relaxed/simple;
	bh=nkkHDHiaBHkuvFvLajlWirgD2OoCHK6D3sY38PCGXTE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S7Vtp49UqI4CVdIGQoJN6bvMDDM6o/Q2s07ov21f2/HFs9LZ+fVSPs9a7EU0D8/1WiNAO17R/hbF/ce4h+oNlLQfWCuC2fLftzCIsL3j6tA0dYmqSpa5oTejcOxAXdHHTSwEAxp6ufleTCBnpxbsV39IDB6T96Bs1lpEmCItTmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T8gOTyD+; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-2454154e53aso823037fac.3;
        Fri, 17 May 2024 09:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715963749; x=1716568549; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KfWAdsD62pu0Ea+pW5rj7BJjge2BbnNFY9DWFyvD4r0=;
        b=T8gOTyD+SseLiKVkah1W7Vla0Z7+SjZD2tzf5RFIRkX8K04YnkB3/r0iQX3P2OrivI
         H7zFhn0vZaJjj54iwGw473SXo4WgdJMmJZNDHhm58p5jG6KktBTJLCzwpvjJqGIBAiZr
         LbwxeQB1Ub4cH1uiZ8TKKWcbbxyQGO5OTuah1+bXu010y3FEXdUPHlTsS+neZ9dxj9tj
         NAgwrwabnSDbMCuTvIjj33yhBMCXzY2gOqNFMqAyHB01rX3qj47tLkHJOR1U1jerrZ38
         vP8KhL1J32dYM9BDwxJ7OMER+K3YVOHDC1NT/JMINhTqECt1w+uuuJyQbsnOe+ADhg4g
         vavA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715963749; x=1716568549;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KfWAdsD62pu0Ea+pW5rj7BJjge2BbnNFY9DWFyvD4r0=;
        b=HyJUMgwQiUs7MtLPzzCfnqpqMw2aDuUR7AIsSwnz+kNluudHuLFBIuD5y37IDwITBJ
         s2/Mk+1qedQb2aPMIJ+jqcgnRkJkL3jAhlXfoNRlPIUSw54rBtNzFOcfBf6QLKVSnyfX
         BvraFk7iv+0Zn8z8i61nZkA2FRq2SPpQPqvzck9ac6IuJwN3zNsPN3UrI0aXu1Jj4Jwc
         AnW5u1DsFi6EDeMydKEnD4PBOkZ1TV0OBrYOaChF72rcOqQyS8tPUZWF7QxsrCHKjgoO
         1XQlTI7uGpuwuNrTUDMsBTCvmNTYOPIu3fBiv1VkuM1hAuGulesY8CzZ8nCdrLzJidKL
         n+qw==
X-Forwarded-Encrypted: i=1; AJvYcCWgyLdekD4ywHbmqsHm9NQhNicPDtzQJRyRm6IKa3ek6BAnfdXYBIpBF8NtREszqVMj9ibl/52x4vCbVUuAFeRTx2XK2CFVdIv6YGsPvSwau4jhQ+srC+Y32eZgSHhdZOv5SJSTSmnpDn1R+hw=
X-Gm-Message-State: AOJu0YxIKKwJkoOO1OqWQiuNgxKL8lNJ3Odbw+cgK8LultQvQoSxFyW4
	uSxJGrZTRhy9DLqeMTH1xLIyhED6tFpx2WrEH6JcbtQ8YtxoldacEUfotsnRHKdwAReB2aKDW8d
	/1fKGnoKrNP8uWMHfHZLvuXwDxqdDZurzrQI=
X-Google-Smtp-Source: AGHT+IHpHMf9XkVd+82e2P0VYfu6dyGpL6ndu+ImgTcG+/CSk1fC3YZc5gCvXvobABWb/uiKTLYoFzOzw9xPARumfzA=
X-Received: by 2002:a05:6871:5b13:b0:23d:5bd3:f74c with SMTP id
 586e51a60fabf-24172a43160mr24828261fac.10.1715963748671; Fri, 17 May 2024
 09:35:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240517141655.2797-1-trintaeoitogc@gmail.com> <87r0e0fq1l.fsf@kernel.org>
In-Reply-To: <87r0e0fq1l.fsf@kernel.org>
From: =?UTF-8?Q?Guilherme_Gi=C3=A1como_Sim=C3=B5es?= <trintaeoitogc@gmail.com>
Date: Fri, 17 May 2024 13:35:12 -0300
Message-ID: <CAM_Rzfbn4pH1vy_dQSEKzB0fmL1iP7JPEDqz7j5c0hory10FQw@mail.gmail.com>
Subject: Re: [PATCH] thermal: adding check if the thermal firmware is running
To: Kalle Valo <kvalo@kernel.org>
Cc: miriam.rachel.korenblit@intel.com, rafael.j.wysocki@intel.com, 
	daniel.lezcano@linaro.org, johannes.berg@intel.com, dmantipov@yandex.ru, 
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Kalle Valo <kvalo@kernel.org> writes:
>> In the dmesg is showing the message "failed to read out thermal zone"
>> as if the temperature read is failed by don't find the thermal zone.
>>
>> After researching and debugging, I see that this specific error is
>> occurrenced because the thermal try read the temperature when is started=
,
>> but the firmware is not running yet.
>>
>> For more legibiliti i change the tt.c for return EAGAIN when this was oc=
currence.
>> After this change, in my computer I compile and install kernel in /boot
>> and in my dmesg the message "failed to read out thermal zone" is not sho=
w
>> any more.
>>
>> I would like to thanks for Rafael Wysocki <refael.j.wysocki@intel.com> f=
or
>> your suggestions in mu first patch that results in this another patch.
>> ---
>>  drivers/net/wireless/intel/iwlwifi/mvm/tt.c | 10 ++++++++--
>>  1 file changed, 8 insertions(+), 2 deletions(-)
>
>Please read the wiki link below how to submit wireless patches. For
>example, the title is wrong and you haven't signed the patch.

Okay, thank you for your explanation Mr. Valo
I will fix the patch and resend this.

Em sex., 17 de mai. de 2024 =C3=A0s 11:53, Kalle Valo <kvalo@kernel.org> es=
creveu:
>
> Guilherme Giacomo Simoes <trintaeoitogc@gmail.com> writes:
>
> > In the dmesg is showing the message "failed to read out thermal zone"
> > as if the temperature read is failed by don't find the thermal zone.
> >
> > After researching and debugging, I see that this specific error is
> > occurrenced because the thermal try read the temperature when is starte=
d,
> > but the firmware is not running yet.
> >
> > For more legibiliti i change the tt.c for return EAGAIN when this was o=
ccurrence.
> > After this change, in my computer I compile and install kernel in /boot
> > and in my dmesg the message "failed to read out thermal zone" is not sh=
ow
> > any more.
> >
> > I would like to thanks for Rafael Wysocki <refael.j.wysocki@intel.com> =
for
> > your suggestions in mu first patch that results in this another patch.
> > ---
> >  drivers/net/wireless/intel/iwlwifi/mvm/tt.c | 10 ++++++++--
> >  1 file changed, 8 insertions(+), 2 deletions(-)
>
> Please read the wiki link below how to submit wireless patches. For
> example, the title is wrong and you haven't signed the patch.
>
> --
> https://patchwork.kernel.org/project/linux-wireless/list/
>
> https://wireless.wiki.kernel.org/en/developers/documentation/submittingpa=
tches

