Return-Path: <linux-wireless+bounces-27821-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 930D8BBD3B4
	for <lists+linux-wireless@lfdr.de>; Mon, 06 Oct 2025 09:39:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6DF464E516B
	for <lists+linux-wireless@lfdr.de>; Mon,  6 Oct 2025 07:39:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8288124A06D;
	Mon,  6 Oct 2025 07:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="e/tesFxr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D97D1DE2A7
	for <linux-wireless@vger.kernel.org>; Mon,  6 Oct 2025 07:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759736349; cv=none; b=LzN85flIcyOYRjZgi28iciZw7etFISLf6M1rb9y8rvqumQVZ3djtvV3/WV0194MSaEP/HdGK2jXJyAokb6/cBhG7JSEvzz1cVW14oZ2UV+SqJ8N35vCz7tljSJlUrFMZC+ZMgXSXiou/6BQUnTgYCHu9egriRtdEzKSTCSoP3l8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759736349; c=relaxed/simple;
	bh=Am1gbmFi315e0Yjm/+wj8vDp5gvMLY42rYVitHxlKFg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YXI4WrH2gNtiJo7Q2DqAeQBcnKUMAfdyJ7VnyXEu3y8fEjdQF8I79qzxETmBOVcTW54oeKU9DBirpmmCtGb2EhQQoKz9czCydONVrnLehJK8qrd9CiDIpCbkPsUi75UjbtFSUF3EYcEszWlSYGarXN3uRA4nBjKdHRQsRqm2RXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=e/tesFxr; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5818de29d15so5587451e87.2
        for <linux-wireless@vger.kernel.org>; Mon, 06 Oct 2025 00:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1759736344; x=1760341144; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Am1gbmFi315e0Yjm/+wj8vDp5gvMLY42rYVitHxlKFg=;
        b=e/tesFxr4QQaxI6wQMA/dixqwxJUasEEZZBaailEJBozxDEhR6qL/TiiHXKWX0Gkjw
         8Lmt5UxTs9pkiamPwbzwFvaUYUWiUAOk9XW8Jp4TEx0b2MZPsD146kYJlGPzYkEHh+mp
         FO/Jw9R0WYsVvMHbgEa/fAhHqAZwElVHRZAippXcYpBBYg+/NHNjsvCJs+MUYscFmaSc
         EZ0qoKS6vBmgDpur4IRHQnoqPHjGXw3NGfb9ORk8SV/gJI3hdugyYIR9jNnRBk3H65i5
         XMGVCJdCqY8KNeGK/AaPvl/7CCao/4Xg25e6k1tamLuHodYp+BauzszGKTqGoqkrya4B
         bplw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759736344; x=1760341144;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Am1gbmFi315e0Yjm/+wj8vDp5gvMLY42rYVitHxlKFg=;
        b=kQSYx9FpKwZYn5OZxilN/H4qcJ24KwED5642BdRNwukJcM8Ylz2+UrH9KAYGqL3Z3R
         bp/VFPLT0dQNT1wMiPM7LHNYseUJsyFTsm9Y9KjkhCRHie/A09qhdi+GnbhdM42anAAb
         GjHMkzgqpadZytizqnWo5v0GME5GaCGjVgAprrGydFmrWV95fJmIjLPB8XsvzSVW1Kbw
         oxAhi63yNBMk1DIEkTEY9uklR+zxQHV/OisvmHRyV6gM4itgUZdL2uIk6u4/T9xiRY+u
         ySMgUS70JdNhbZKnkXVGymCUP0yHevoqp7OUcm3gFS8NH/oUxw55dyzUaLJOKkhjGeJV
         bG5g==
X-Forwarded-Encrypted: i=1; AJvYcCXKbe/Jyq30Tk7toZuOmVmYwx7TD0BA50TVrKSOyU1oa2nXf2w+K28qCgmKI2DIoec5/hCoXLsAYFmzLm/YEQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzSUJR1S7VILxIqeoogPG9EEsLN6T+WQiHKpkB4jRGkHk2Zf8Jl
	7oaxBQSiioAOXdsk6aP5KK+9v4Pi5i7RaJs4I/98PzIn5MT0r0FshOhdLs6wsGdfVAxmcK57kz7
	dOea4STtVhilJn3MMUIhv/TYqVPsKLKy92ou5FKi5Fg==
X-Gm-Gg: ASbGncslgmcgjYoEsIOldoQv1LOYFg4AU2yEJOBYWv6QotruOlg7HrPgrYVvmji4yjb
	GrW6Bx6XmtGgt7U3gbLgVKAfvrPWVlifpqS3GFavY4puYqfTmo24vFGO6NAOhoBHWXlb4HisZu5
	WsEa1WXaH62xxF2RFkCIUtTxMqEFsp5JF9VwQ9fgOrujmCxRNcMuE7/cqmgRvH//wwKTzi0jBlE
	p7t0L5dYge3B2DBktaVt4TzJVQuYaPZSyft3M1Pwkyw17fVp1aeCDD+FhiaGev4i3Pzi5Qc
X-Google-Smtp-Source: AGHT+IHYByKCjoadqMwcgzZaxVjBw3PHlVdkGGg+QRgwTG+jZY1QPNT+NBpdcc2Rk1gDsVaKNiOyZ0rSsxcbQfoQqwg=
X-Received: by 2002:a2e:a989:0:b0:332:2d5a:db98 with SMTP id
 38308e7fff4ca-374c36fe07emr33431021fa.12.1759736344045; Mon, 06 Oct 2025
 00:39:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251004141539.6512-1-brgl@bgdev.pl> <CAMRc=Mepopam1zhUONtratqopa6zHhsJfah9JO9D2VKyXcqjEQ@mail.gmail.com>
 <DM3PPF63A6024A97A503FF0208F582651E1A3E5A@DM3PPF63A6024A9.namprd11.prod.outlook.com>
 <CAMRc=MdtkAFJBGN1biaGDLjgwjuzJ=kjDzEWbrX+DX27e8jYhg@mail.gmail.com>
 <DM3PPF63A6024A9796B12A990D023532081A3E2A@DM3PPF63A6024A9.namprd11.prod.outlook.com>
 <CAMRc=McJ649k44-Y9ugjq1-xKX9QL4c4MX_LeYs12N1SD4D7_g@mail.gmail.com> <DM3PPF63A6024A92B862A68F1EA07192752A3E2A@DM3PPF63A6024A9.namprd11.prod.outlook.com>
In-Reply-To: <DM3PPF63A6024A92B862A68F1EA07192752A3E2A@DM3PPF63A6024A9.namprd11.prod.outlook.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 6 Oct 2025 09:38:52 +0200
X-Gm-Features: AS18NWCgmq99M7bjWuppQInX3-2khuJgMBOFqrUX3_kDP1nJuerbid7wvBUmDYo
Message-ID: <CAMRc=Md1SO4GWxyn2M8G-nLkc45CTDF-aDvPE9HnX9We+KtudQ@mail.gmail.com>
Subject: Re: [PATCH] Revert "wifi: iwlwifi: mvm: remove support for
 REDUCE_TX_POWER_CMD ver 6 and 7"
To: "Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>
Cc: "Berg, Johannes" <johannes.berg@intel.com>, 
	"Anjaneyulu, Pagadala Yesu" <pagadala.yesu.anjaneyulu@intel.com>, 
	"Grumbach, Emmanuel" <emmanuel.grumbach@intel.com>, Bhaskar Chowdhury <unixbhaskar@gmail.com>, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, "Peer, Ilan" <ilan.peer@intel.com>, 
	"Gabay, Daniel" <daniel.gabay@intel.com>, 
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 5, 2025 at 3:36=E2=80=AFPM Korenblit, Miriam Rachel
<miriam.rachel.korenblit@intel.com> wrote:
>
> > So the 89 at the end of the filename is not the version of the firmware=
?
> It is. But not for "frozen devices" - like yours.
> In such devices, the API number (89 in your case) doesn't increase anymor=
e,
> but we still update the FW from time to time.
>
> > No the full version anyway? I wasn't aware of this. Where is the versio=
n
> > information encoded other than the linux-firmware git log?
>
> You can see the SHA-1 of the FW in the dmesg. For example, in the log you=
 sent:
> Loaded firmware version: 89.e9cec78e.0 ty-a0-gf-a0-89.ucode
> The SHA-1 is e9cec78e.
>

Ok, got it. Will keep it in mind in the future.

Bart

