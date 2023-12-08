Return-Path: <linux-wireless+bounces-569-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DA5380990D
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Dec 2023 03:11:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 806531C20A38
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Dec 2023 02:11:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA4BB1878;
	Fri,  8 Dec 2023 02:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BvxLr56n"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BD311719
	for <linux-wireless@vger.kernel.org>; Thu,  7 Dec 2023 18:11:05 -0800 (PST)
Received: by mail-yb1-xb32.google.com with SMTP id 3f1490d57ef6-daf26d84100so1752741276.3
        for <linux-wireless@vger.kernel.org>; Thu, 07 Dec 2023 18:11:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702001464; x=1702606264; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NrS1+gj4SQqrLBMUECtVXORlr6dGcnhoysWJjVqwxW0=;
        b=BvxLr56noAj0MwngcFDn9sBX4EkG4BqwIc4Ak82p+YDnmjrGZciQPj2XKeG9dXgxtM
         CGnKbQYASOFJbdM+AHJd83wDVE7rgJOgN0bIoUQWzSfWmF/exmxNVSrfATL5tz87AZRe
         0VRXEwfL6Gu7O1lDn/lKAqCcZlraQ6i2HBfKHN4RMhGY38o7V+iZsl1zrybPPOowbOtk
         FTesiy4M6Gkr7vvNz68zXWA6JLaUZRmOgJD55lMRL1TomYVVCtIdenNjqNxlcdhIh9Ah
         d6JNZZScjjbxp8YbRa37wGMXjsVAparQZYvs56jrRTqWnQkC6451RKKNi1gs/cjHGrey
         WZ4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702001464; x=1702606264;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NrS1+gj4SQqrLBMUECtVXORlr6dGcnhoysWJjVqwxW0=;
        b=NPWUCdAIQfWMHoTizcp9083FokPnJTVr+haDPTzhaMHxfjx1X4AkNuhiEFovcHqtA+
         BdfFXnkCwT1dAsuZ41ac2SYOjBjW4xtRrEWOxPDN3qvrFZYdCpK6SrUbx/mdt2MOCngv
         FCXRdZ+/km1NooSh8vOSd570s+Nrdmb4pLQlIzfDpPZdLwK6NaBdSGCfdbZVcNRbb67a
         wyALY/XCMJL5p6ScvsQyOQBQsqpVzrmS2UXQ16+PfZavxcJ8G7Ze85XBIa7i4iDFIBG9
         Z3Keo6yZk5wR4rzT526SEcm/U7mMVP11iuA7CVSVcpQoBeviYOVWOcX4cbhGBQYTH6hU
         D82A==
X-Gm-Message-State: AOJu0YyhIpcPi90aOFTxzzt0El6GHRVesGQt+fezRqLRY2VLGJed+nxA
	WHyeMTvqE1O9hMa1TZFLuAZ+fe22Mcfm2ndr8bdetg==
X-Google-Smtp-Source: AGHT+IFzB/fvfpt3l9KUjfBQeyBhYz5PrQ3cvYlMjYHNiikQIZ+vKmYh5c3DKdUmzSxnO8b96mhu8iTGOuCgu0Nogu4=
X-Received: by 2002:a25:d415:0:b0:db7:dacf:59f1 with SMTP id
 m21-20020a25d415000000b00db7dacf59f1mr3933594ybf.101.1702001464147; Thu, 07
 Dec 2023 18:11:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230630151842.1.If764ede23c4e09a43a842771c2ddf99608f25f8e@changeid>
 <CAMSo37XcwAn9znSQ8202LUTdBKLDz94QJ9i43aXya5LHs-4GiQ@mail.gmail.com>
 <87wmtqnk3y.fsf@kernel.org> <CAD=FV=VHHCsjJmVWDXN4g3U=-_SLWc2iWqbAdZPOykn+QMQojw@mail.gmail.com>
In-Reply-To: <CAD=FV=VHHCsjJmVWDXN4g3U=-_SLWc2iWqbAdZPOykn+QMQojw@mail.gmail.com>
From: Yongqin Liu <yongqin.liu@linaro.org>
Date: Fri, 8 Dec 2023 10:10:52 +0800
Message-ID: <CAMSo37UfQmpTb3_+URbGTbX77mTJNn4SC0aaVD5KXasMsW7Jow@mail.gmail.com>
Subject: Re: [PATCH] ath10k: Don't touch the CE interrupt registers after
 power up
To: Doug Anderson <dianders@chromium.org>
Cc: Kalle Valo <kvalo@kernel.org>, ath10k@lists.infradead.org, 
	Abhishek Kumar <kuabhs@chromium.org>, Youghandhar Chintala <quic_youghand@quicinc.com>, 
	linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Sumit Semwal <sumit.semwal@linaro.org>, 
	John Stultz <jstultz@google.com>, Viktor Martensson <vmartensson@google.com>, 
	Amit Pundir <amit.pundir@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 8 Dec 2023 at 00:49, Doug Anderson <dianders@chromium.org> wrote:
>
> Hi,
>
> On Thu, Dec 7, 2023 at 6:49=E2=80=AFAM Kalle Valo <kvalo@kernel.org> wrot=
e:
> >
> > > Recently during our Android build test on the Dragonboard 845c board,
> > > with the Android Common Kernel android11-5.4-lts and android12-5.4-lt=
s branches,
> > >
> > > we found there are some ufshcd related changes printed,
> > > and the serial console gets stuck, no response for input,
> > > and the Android boot is stuck at the animation window.
> > >
> > > The problem is reported here
> > >     https://issuetracker.google.com/issues/314366682
> > > You could check there for more log details.
> > >
> > > And with some bisection, I found it's related to this commit,
> > > when I revert this commit, the problem is gone.
> > >
> > > So replied here, not sure if you have any idea about it,
> > > or any suggestions on what we should do next to resolve the problem?
> >
> > FWIW we don't support Android kernels, only kernel.org releases.
>
> Right. If the problem also reproduces on mainline Linux then that
> would be interesting to know. I think db845c is at least somewhat well
> supported by mainline so it should be possible to test it there.

I checked with the ACK android-mainline branch, which is based on the
mainline Linux,
this commit is there, but the problem is not seen.

> If I had to guess, I'd think that probably the CE interrupts are
> firing nonstop for you and not getting handled. Then those constant
> interrupts are (presumably) causing the UFS controller to timeout. If
> this is true, the question is: why? Maybe you could use ftrace to
> confirm this by adding some traces to
> ath10k_snoc_per_engine_handler()? There's a way to get ftrace buffers
> dumped on panic (or, if you use kdb, it has a command for it).

Thanks for the suggestions, I will check internally on how to debug that.

> If this reproduces on mainline and it's not obvious how to fix this, I
> don't object to a revert. As per the description of the original
> patch, the problem being fixed was fairly rare and I didn't have a way
> to reproduce it. The fix seemed safe to me and we've been using it on
> Chromebooks based on sc7180, but if it had to get reverted it wouldn't
> be the end of the world.
>
> -Doug



--=20
Best Regards,
Yongqin Liu
---------------------------------------------------------------
#mailing list
linaro-android@lists.linaro.org
http://lists.linaro.org/mailman/listinfo/linaro-android

