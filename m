Return-Path: <linux-wireless+bounces-553-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 78A67808DD2
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Dec 2023 17:49:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D76C1F2141B
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Dec 2023 16:49:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FB3B41761;
	Thu,  7 Dec 2023 16:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AKFSE2nn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20D5F10CB
	for <linux-wireless@vger.kernel.org>; Thu,  7 Dec 2023 08:49:37 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-3333131e08dso1393423f8f.2
        for <linux-wireless@vger.kernel.org>; Thu, 07 Dec 2023 08:49:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701967773; x=1702572573; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lyhxrpfp+75Q27I2sJ7iqWke8b01A5JKGENoBisxmEg=;
        b=AKFSE2nn8up7/3MihhTlBfvCIVqqCEXmTUMrcD+XNfiNs4F31JlhyMThn9bpL9KwL4
         ym/nFsxeuaayt/M1OinexvKROMnW0u42hIVINs/wjkBmhw55TkREPDAHGNw4KIHfKBNC
         KpfuZkwm0O4Pl/TEa3LHuffGsmkDo34O+5Rrs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701967773; x=1702572573;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lyhxrpfp+75Q27I2sJ7iqWke8b01A5JKGENoBisxmEg=;
        b=SZ+jqQfl1KhffJ/P76KozxZ2K4m5O4mW+Yi42tojFpSvXyKrSWSPbXnymGIARWG9M6
         ZCj2okV27EieYlwL2oZaW57DzL/g5AH3R6+5q9t97VsT68MOyEvoMzm7V8AQkdZM3qge
         YcnV/owr+l3TomMwR2BEaoROFjAdHXtFISy98wRjin9JbYNFFFBqHz6yL6pafyMHjrIi
         /NqdCeqpu0MCHYvRM2N9172I+CxqAWUCnjgVLGru4LczkEBVbtweSm26LGeV6OPHhCAu
         ayh+RTGOgN7WDI7nkCHnk0WNO9El7/tyzqsmQkNTHyiUZF+aYEQci+xKHoNwkR0gnmVK
         +Uyg==
X-Gm-Message-State: AOJu0Yx+Ptx1LvF9KOoLwGHRJNbNp7SQIt2FbhzMG3FafbKp0rMW5L69
	MiQnNLoJRYkh6PMGUg9LBQblJVwH51Kx4B54DlXCMIOm
X-Google-Smtp-Source: AGHT+IEuAOY8/yKZL3yy02zlWr9lkU8aeHEXqcwYI77FGd8ir2jTZbKEdnj/PoxuB5YZqIVLNt37cw==
X-Received: by 2002:a1c:4b0b:0:b0:40c:24dc:1166 with SMTP id y11-20020a1c4b0b000000b0040c24dc1166mr1101437wma.189.1701967773160;
        Thu, 07 Dec 2023 08:49:33 -0800 (PST)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com. [209.85.128.41])
        by smtp.gmail.com with ESMTPSA id by8-20020a170906a2c800b009dd678d7d3fsm1039186ejb.211.2023.12.07.08.49.32
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Dec 2023 08:49:32 -0800 (PST)
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-40b422a274dso82565e9.0
        for <linux-wireless@vger.kernel.org>; Thu, 07 Dec 2023 08:49:32 -0800 (PST)
X-Received: by 2002:a05:600c:22d8:b0:40b:4221:4085 with SMTP id
 24-20020a05600c22d800b0040b42214085mr206272wmg.1.1701967772109; Thu, 07 Dec
 2023 08:49:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230630151842.1.If764ede23c4e09a43a842771c2ddf99608f25f8e@changeid>
 <CAMSo37XcwAn9znSQ8202LUTdBKLDz94QJ9i43aXya5LHs-4GiQ@mail.gmail.com> <87wmtqnk3y.fsf@kernel.org>
In-Reply-To: <87wmtqnk3y.fsf@kernel.org>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 7 Dec 2023 08:49:16 -0800
X-Gmail-Original-Message-ID: <CAD=FV=VHHCsjJmVWDXN4g3U=-_SLWc2iWqbAdZPOykn+QMQojw@mail.gmail.com>
Message-ID: <CAD=FV=VHHCsjJmVWDXN4g3U=-_SLWc2iWqbAdZPOykn+QMQojw@mail.gmail.com>
Subject: Re: [PATCH] ath10k: Don't touch the CE interrupt registers after
 power up
To: Kalle Valo <kvalo@kernel.org>
Cc: Yongqin Liu <yongqin.liu@linaro.org>, ath10k@lists.infradead.org, 
	Abhishek Kumar <kuabhs@chromium.org>, Youghandhar Chintala <quic_youghand@quicinc.com>, 
	linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Sumit Semwal <sumit.semwal@linaro.org>, 
	John Stultz <jstultz@google.com>, Viktor Martensson <vmartensson@google.com>, 
	Amit Pundir <amit.pundir@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Dec 7, 2023 at 6:49=E2=80=AFAM Kalle Valo <kvalo@kernel.org> wrote:
>
> > Recently during our Android build test on the Dragonboard 845c board,
> > with the Android Common Kernel android11-5.4-lts and android12-5.4-lts =
branches,
> >
> > we found there are some ufshcd related changes printed,
> > and the serial console gets stuck, no response for input,
> > and the Android boot is stuck at the animation window.
> >
> > The problem is reported here
> >     https://issuetracker.google.com/issues/314366682
> > You could check there for more log details.
> >
> > And with some bisection, I found it's related to this commit,
> > when I revert this commit, the problem is gone.
> >
> > So replied here, not sure if you have any idea about it,
> > or any suggestions on what we should do next to resolve the problem?
>
> FWIW we don't support Android kernels, only kernel.org releases.

Right. If the problem also reproduces on mainline Linux then that
would be interesting to know. I think db845c is at least somewhat well
supported by mainline so it should be possible to test it there.

If I had to guess, I'd think that probably the CE interrupts are
firing nonstop for you and not getting handled. Then those constant
interrupts are (presumably) causing the UFS controller to timeout. If
this is true, the question is: why? Maybe you could use ftrace to
confirm this by adding some traces to
ath10k_snoc_per_engine_handler()? There's a way to get ftrace buffers
dumped on panic (or, if you use kdb, it has a command for it).

If this reproduces on mainline and it's not obvious how to fix this, I
don't object to a revert. As per the description of the original
patch, the problem being fixed was fairly rare and I didn't have a way
to reproduce it. The fix seemed safe to me and we've been using it on
Chromebooks based on sc7180, but if it had to get reverted it wouldn't
be the end of the world.

-Doug

