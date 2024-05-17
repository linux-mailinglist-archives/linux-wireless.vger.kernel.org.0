Return-Path: <linux-wireless+bounces-7792-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E8A78C8A33
	for <lists+linux-wireless@lfdr.de>; Fri, 17 May 2024 18:38:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 270211C219B0
	for <lists+linux-wireless@lfdr.de>; Fri, 17 May 2024 16:38:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A4ED13D89F;
	Fri, 17 May 2024 16:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ffanOiIM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC0DA13D625;
	Fri, 17 May 2024 16:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715963882; cv=none; b=n5Za2kFPScEtAeseUyLc9uJqF2/P6ZWZ639R3ul1Haj4Sncc6crk1MVaVBf8WU6HiaoBQq3S0gS49fMN9Iq3wgOeTnd+TpJGt1T158mk0wML2hvIfJJkKVu1ZwIXp74RhLUaiSN1OwCe8puNr8TVsj3d6+WJjp6parnVtYUWbX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715963882; c=relaxed/simple;
	bh=VhxzfyQX6UlrAr0KfzJ1VoEGjFRM3wnRB971rxbAml0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OZGsx5K6bYax3loQS9ca9jnxvQDbDRI79NhztQh7xOoFfEKh2acwjQnkJiG2/pjI9iR5wDLKz1hwoTkamdu4XOSUEpE709tRcacG2pbDe/BwvQvotLfCoHa1JlBrT40fKU8r+Q3uRtM7gQ++EMOnQvctLq/0/QK9Vpv5plgQAgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ffanOiIM; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6a3652a732fso5248166d6.3;
        Fri, 17 May 2024 09:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715963880; x=1716568680; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WsjumDZ0H1yS3DBh+QfsoEZzohX5fRd4/kFrgIp3CUE=;
        b=ffanOiIM5Hw5ZI6GZ/fWfB8C2MOnpILOrpo5nmbZC1Iri9LMwE5+eCGlRmchzVcRWc
         naD38osAysRoN2mpjhDj3nOy4/DI5Ua0h6o0rmmWxl1LsafkYJC8c4WSRYAMCUhhpYNv
         zMf9Q/hqllRn6KJK/eHv8vqYvXSERUl9pZmAZTuawtu9KhGpyEnM70aFP0B/gt+QhmOa
         7Oz8uxKfowpGe3Kjni7uaSQ+Mkkaxvy4Xoo54zVRZzBBAnu+w0jMKXFODaqS/20ZMVBy
         E9+InZpM6o5X/gL/tWfiejCY4XicDt73jwGE2VUp8Zs+3BFJYADfdP/n0vu07zVo94hg
         mCYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715963880; x=1716568680;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WsjumDZ0H1yS3DBh+QfsoEZzohX5fRd4/kFrgIp3CUE=;
        b=eZ0ZEEbA8AJKBNtRBTQN0kLw5SyBa77aixdIOjfYFb3x+BbaW1oT2naUYKdUIrsAZ8
         kdkRBeTyYhtSmVms0u0fDZu98zSiBrgM5g0cnC3DmKVX6Z9dRxAuVqlmZO7c0iFOiS+0
         9wQ5PutATzD7+Gp+0HZQ6j/xE6D737MEwoC4491cWTtSWJL1tnQXvF7Q3Ui/F7pUBwlX
         1XzLZgnFEizdy86S4AP1LCFRlpZv26C6HF3rIKsQKLmm6VTXkz44GIsPEAgfbQxVB9w6
         DjxIusFIkVL1Ktx2qEE6nDoFlU7cMxK5Ew3vvJPJXaoyQtU0kWRwDurjZwGSMn/9Rcor
         /KPA==
X-Forwarded-Encrypted: i=1; AJvYcCVhbTPwpWXdQfXpPydfx9DZ1j8G9xNbtht/9+Uzvj+vVgDeRQBu7njvML2F8K7FRhJKJ1lCBGPTLyXzJ12QH3rNmxt/V4NTPn95tLVvxZTuDFuIEWWUoO3LCT7rndeNwR27+FMNpk0elBt4ukQ=
X-Gm-Message-State: AOJu0Ywvow2HgCN4tsoGmhkGQgqC33/er5EU8LG+yt5qckgFrx6A/dIY
	zU2JzQj4nbCh0SFL4vby+HomJvQ1l9PLXmRWw9BQyNPOb0CM+3QKW5FIPsborbqpsjzknxLmk0O
	SaiO2wWPmRL3Mq64Z8JRqRY3yuMI=
X-Google-Smtp-Source: AGHT+IHlxXXV3Ht9FZV5xoQaCT9JvokJEOUZw686sRj9u7wnQVsDPcK1TBBggrCedV7E2gMZ3XW9fombP1P6LW4NeQw=
X-Received: by 2002:a05:6214:4497:b0:6a0:b3eb:5626 with SMTP id
 6a1803df08f44-6a1681a167cmr277927426d6.39.1715963879817; Fri, 17 May 2024
 09:37:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240517141655.2797-1-trintaeoitogc@gmail.com> <87r0e0fq1l.fsf@kernel.org>
In-Reply-To: <87r0e0fq1l.fsf@kernel.org>
From: =?UTF-8?Q?Guilherme_Gi=C3=A1como_Sim=C3=B5es?= <trintaeoitogc@gmail.com>
Date: Fri, 17 May 2024 13:37:23 -0300
Message-ID: <CAM_RzfYzaTYmNCCGwW+JAC0CXF3SauzH4s8wfgW+TzLkpnUTKg@mail.gmail.com>
Subject: Re: [PATCH] thermal: adding check if the thermal firmware is running
To: Kalle Valo <kvalo@kernel.org>
Cc: miriam.rachel.korenblit@intel.com, rafael.j.wysocki@intel.com, 
	daniel.lezcano@linaro.org, johannes.berg@intel.com, dmantipov@yandex.ru, 
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Kalle Valo <kvalo@kernel.org> writes:
>
> Guilherme Giacomo Simoes <trintaeoitogc@gmail.com> writes:
>
> > In the dmesg is showing the message "failed to read out thermal zone"
> > as if the temperature read is failed by don't find the thermal zone.
> >
> > After researching and debugging, I see that this specific error is
> > occurrenced because the thermal try read the temperature when is started,
> > but the firmware is not running yet.
> >
> > For more legibiliti i change the tt.c for return EAGAIN when this was occurrence.
> > After this change, in my computer I compile and install kernel in /boot
> > and in my dmesg the message "failed to read out thermal zone" is not show
> > any more.
> >
> > I would like to thanks for Rafael Wysocki <refael.j.wysocki@intel.com> for
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
> https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

Thank you for your explanation Mr. Valo.
I will fix the patch and resend.

