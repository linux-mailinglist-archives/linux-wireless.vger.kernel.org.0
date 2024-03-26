Return-Path: <linux-wireless+bounces-5301-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 788DA88CD4D
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Mar 2024 20:34:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CA981F32A72
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Mar 2024 19:34:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A861913D246;
	Tue, 26 Mar 2024 19:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="ma1E60l3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36C3C380
	for <linux-wireless@vger.kernel.org>; Tue, 26 Mar 2024 19:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711481677; cv=none; b=fIef+lg+4fAX5aZadJr2pP3SulyCnCthXu5ctUCcZaChAInFKqGtnA16y7ahn0o50RlLxtgfoSGNZljKSRtyW6PfLLdGfeUA+Cm1dW+HK5aHR3O6+Yrodx6NRosZtPsMbmd8GHbDKrNXitLC2arBvsRFEVZZoRoph2sfOdcoH4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711481677; c=relaxed/simple;
	bh=jB0SbUqj4yWjpSitSatel0i7gAXM+MX9wtzrHyDJJ5g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VzOwZkK9wVFqNDz9lP+KIVrsz0jpWuSVvbE/Jdeu8kW1elCAz0WRIAmLgRw352PbDLrMQF7DcGKq4FLoePFuWaK8m2YiIPBsYJSDfi72EgGGLmXonfbi8XUMBYoriJqzo6Ps3OfqWsRd4p4FTLNbHrYTUqfddqyVEyCYH1nM4+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=ma1E60l3; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1e0d6356ce9so17121875ad.3
        for <linux-wireless@vger.kernel.org>; Tue, 26 Mar 2024 12:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1711481675; x=1712086475; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jB0SbUqj4yWjpSitSatel0i7gAXM+MX9wtzrHyDJJ5g=;
        b=ma1E60l3F1K3KBlw6iG2P8CHMv6OG5aHYWSjA3thIJtGiJLFGfxrcdyoH0U90KjspN
         CCtV+Th8EqsF4yPNSFpVa1oVtZ5+JBB0aiFO65gmWO0wrOatVPmPaHHOWYl3lKKeWui7
         Du6hsqlSGC7fijjFUI/EUSFPZ4OoL6nffOea6/vZ7xY1S6D4Fao1suSSQABmGv5V1eT+
         8E2uXJ77Qin29WM0JROTfPFFAvUJ3JCsY6SentEHcTevKW7gLCpa/tP0J68J7OXh6HBB
         UOJsAMqnkCrMfWiebuv4UJSAXUBGHz4vjvUl12eA3iKQgJJOfQd6BOrSu9U8KQEWjAXx
         wdXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711481675; x=1712086475;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jB0SbUqj4yWjpSitSatel0i7gAXM+MX9wtzrHyDJJ5g=;
        b=djaPqHHFw48dpyeVMwCzgeBMTJ3Z5c8dZM4Es6Ccw5mckNCPklA3Opk3vzoSEfIaq8
         k65By1tGUncnX0dXZ8rCm6niNbfECSzOoJE0n+GlS7ytdSndq3KJsLNyP9GWyiqmM0K0
         SwHOUHtNBwNAWXf8CLanLXFXZRc12BfZzE2XYu429Z66N8+yehaLB7754qTAbZoKUT4r
         T1tbrcyDnq5OB+qY1KUxQu+ciEX5dPZbw0+PWsQVc4SVpzUv2KY0sP0GC8JRPXbMIZnY
         gU6RDKQ+U/kMmRqdTPe+MV2QrjHpsUzLa5lNtf/B/A5tuduHcNDizDYCAqGFf3lEdOrk
         0v/w==
X-Gm-Message-State: AOJu0YyVunPQUBou5rEciwxnBCUirHv9dHfgFcBaloQdkNJ0LGu0gJEs
	n0JFZcR4cSPy2y7Ath/Xz6BK0uoRjfCnM+Rsbnb9O2VbL7C7LIjTDHzE8se8idL0Trj4M9TzHSi
	WV9DqQLvapELSbb373pQ/zCtS/EU=
X-Google-Smtp-Source: AGHT+IExGDBlGpdY5hN7iRzs3AXrhkbA2Clns14s+kBZLeP8QFLaNSah8nKLUgUT6EDyqDu/SfwPTFoBkWKdbyGB/gs=
X-Received: by 2002:a17:902:ecc8:b0:1e0:d630:f18e with SMTP id
 a8-20020a170902ecc800b001e0d630f18emr5222911plh.14.1711481675401; Tue, 26 Mar
 2024 12:34:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240326014707.17458-1-pkshih@realtek.com>
In-Reply-To: <20240326014707.17458-1-pkshih@realtek.com>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Tue, 26 Mar 2024 20:34:24 +0100
Message-ID: <CAFBinCDdagAbmTBx_4qezbaPwrEK+5YaQhTZm_YjnrMc4OSJ6g@mail.gmail.com>
Subject: Re: [PATCH] wifi: rtw89: station mode only for SDIO chips
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Ping-Ke,

On Tue, Mar 26, 2024 at 2:48=E2=80=AFAM Ping-Ke Shih <pkshih@realtek.com> w=
rote:
>
> Since only station mode has been tested on SDIO chips, only keep it suppo=
rt
> for SDIO chips to reflect correct supported features.
Overall I'm fine with this patch, thanks for taking care of it!

I only have one small comment: the subject line should start with
"wifi: rtw88: ..." (currently it states rtw89)
With that changed:
Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

Also I'm hoping that some people will step up and find the missing
link to get AP mode working on SDIO chips. I currently don't have time
for this.


Best regards,
Martin

