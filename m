Return-Path: <linux-wireless+bounces-9791-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44A4191E9C9
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Jul 2024 22:47:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA13CB2174B
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Jul 2024 20:47:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A6CF83CC7;
	Mon,  1 Jul 2024 20:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HTVcoccd"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB75C1366
	for <linux-wireless@vger.kernel.org>; Mon,  1 Jul 2024 20:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719866860; cv=none; b=Xq8DEDWIjSNyKmvtozWYHoIQCXElhxFeshxRV19Lnkf6ynN9zLf3vEQfib1VwZ/mgPVZF7lSAnSAISvRmp1Fhpz595dS9TZrrYgpERWlH3DLrePQ5oR+SfTHDBHL+5CU9lI3ocdrz5tQ/WT/HOX573oh5YHo/TnVP0WsU4DCBuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719866860; c=relaxed/simple;
	bh=EERxZzJHIEjkgE2YFnSA6mxUDY4nR0HijqJORkMnuPU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VJQpzi0wW9XFQnvTfGhleadbQq2dkhE6bSKLjd2iORmLbP3YYJjd77C5uL/XBnHcM0UgIm9H27T9eBEZ5v3R/OMcU3qNnpxy5mKdOe9WePu6dCW4gU/lIR1yGUw7trhSEX3HC42dz6hCWOTfCqmMNzQwrliiPSv8ntUWlhzxqDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=HTVcoccd; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-57d251b5fccso952369a12.0
        for <linux-wireless@vger.kernel.org>; Mon, 01 Jul 2024 13:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1719866857; x=1720471657; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EERxZzJHIEjkgE2YFnSA6mxUDY4nR0HijqJORkMnuPU=;
        b=HTVcoccdHuWebfnZqooWP7w8X/FCrjfMMWGmm5t5sKovH3hsZCq+bSVuPAOeSfh1d2
         mGjGczNWb8HfAR4TN2LKOtNK8eOQ5lBqOU/ZqYW2qHLLrBE+CxbaCekorYn8VIs6jk0b
         UFq0zAwn1wljVDi8Ju7vH7i87/bIsCEKwjHBQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719866857; x=1720471657;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EERxZzJHIEjkgE2YFnSA6mxUDY4nR0HijqJORkMnuPU=;
        b=xEVLnPfbmNaCzgUp9gl9uGEd10I0EYOjIchaK/ZUqGTWt0cQ9r5FPxzL1+UTi23Z4M
         7NFOsegh+KdAm9GVSahWJ4AAtiTqiGBUEzo7hFvIoww75u9bUAmBgKEEISCdajMfh5/t
         OtGjlknQIohiY9dB2yYTgTipEt0v03HiXVZaeNy164x/zUgGjOdjCTEtw1vx+zdQXY/0
         O5l1NSawmCTCmbs2b5hUQY0ZO4JgF9xCqyuh6/KLxLuK84QgApAVBphJRSOyvELCZ89Z
         iRKfpS6ontNnQO9BK94jGwQ7ZHQZ7FYuJpHCwnBmMxwKlyACx0jBjPBZSG2eaRmcphOT
         93Eg==
X-Gm-Message-State: AOJu0YzP4j2QzVIr+7jNTnA9hw94zbjcZMmIsLGCJT1dgdD/3AdbEfow
	ei6wLWvX9mH23/LxOF9ZPyyAQ1ldDcRfHgE9kbX4imV8KDQI3NXAZCRCsuG0uYChGxF/YGR65Z5
	aFA==
X-Google-Smtp-Source: AGHT+IGtYCtuhOeIjfrkgGtZ9qKp0zBxH693Vc3A5n0n82LjsNtkJc2hO/vSWWssCbkKcZgU7WJRxQ==
X-Received: by 2002:aa7:db54:0:b0:57c:6f0a:bc57 with SMTP id 4fb4d7f45d1cf-587a0fdc80bmr3790932a12.36.1719866856715;
        Mon, 01 Jul 2024 13:47:36 -0700 (PDT)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com. [209.85.208.45])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-58b3fcf142esm124311a12.3.2024.07.01.13.47.35
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jul 2024 13:47:35 -0700 (PDT)
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-57d1012e52fso893282a12.3
        for <linux-wireless@vger.kernel.org>; Mon, 01 Jul 2024 13:47:35 -0700 (PDT)
X-Received: by 2002:a17:906:da85:b0:a6f:1166:1b86 with SMTP id
 a640c23a62f3a-a75144a27femr519353666b.53.1719866854890; Mon, 01 Jul 2024
 13:47:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240418060626.431202-1-yu-hao.lin@nxp.com> <20240418060626.431202-2-yu-hao.lin@nxp.com>
 <Zk6TklTIbxZxIWyb@google.com> <PA4PR04MB9638DC958102D07A7B7084B6D1F52@PA4PR04MB9638.eurprd04.prod.outlook.com>
 <CA+ASDXOE2Pwv3kRhwkAd1e3+U8zxZi7cX0TeLDkycQya9xkdPA@mail.gmail.com>
 <PA4PR04MB963875C85CFFA0EE2E914BEAD1F52@PA4PR04MB9638.eurprd04.prod.outlook.com>
 <CA+ASDXMzHRs=CeyVeMbY44ornTa7f8G3ek3bFeyX39QAwr5bog@mail.gmail.com>
 <PA4PR04MB96380A04A6830AB69024E4B2D1F62@PA4PR04MB9638.eurprd04.prod.outlook.com>
 <ZnRsfiau_JSWBXTZ@google.com> <PA4PR04MB9638E38BF0C8391582EDB121D1C92@PA4PR04MB9638.eurprd04.prod.outlook.com>
 <PA4PR04MB9638F352F7026C4DFBD8C562D1D32@PA4PR04MB9638.eurprd04.prod.outlook.com>
In-Reply-To: <PA4PR04MB9638F352F7026C4DFBD8C562D1D32@PA4PR04MB9638.eurprd04.prod.outlook.com>
From: Brian Norris <briannorris@chromium.org>
Date: Mon, 1 Jul 2024 13:47:20 -0700
X-Gmail-Original-Message-ID: <CA+ASDXPjT1DywGG_7vVVKfRM-JCO8pBq0jm=yRGvYci2omnkNA@mail.gmail.com>
Message-ID: <CA+ASDXPjT1DywGG_7vVVKfRM-JCO8pBq0jm=yRGvYci2omnkNA@mail.gmail.com>
Subject: Re: [EXT] Re: [PATCH v10 1/2] wifi: mwifiex: add host mlme for client mode
To: David Lin <yu-hao.lin@nxp.com>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "kvalo@kernel.org" <kvalo@kernel.org>, 
	"francesco@dolcini.it" <francesco@dolcini.it>, Pete Hsieh <tsung-hsien.hsieh@nxp.com>, 
	Francesco Dolcini <francesco.dolcini@toradex.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi David,

On Sun, Jun 30, 2024 at 6:12=E2=80=AFPM David Lin <yu-hao.lin@nxp.com> wrot=
e:
> > -----Original Message-----
> > From: David Lin <yu-hao.lin@nxp.com>
> > Sent: Friday, June 21, 2024 12:36 PM
> >
> > > From: Brian Norris <briannorris@chromium.org>
> > > Sent: Friday, June 21, 2024 1:53 AM
> > >
> > > On Sat, May 25, 2024 at 12:50:59AM +0000, David Lin wrote:
> > > > That is the reason that I suggest that we put comments and TODO to
> > > > the
> > > code.
> > >
> > > OK, I suppose that works for me.

^^^
I don't have anything to add to this. This means "go ahead with the
quoted suggestion."

If you factor in the latest comments (which, I think is only the above
at the moment) then v11 likely will be good to merge from my
perspective.

> > I suggest that we just put your comments and prepare patch v11.
>
> I think WPA3 is more robust and updated security method. Please help to l=
et this patch be accepted.
> Please let me know what else should be done to let this patch be ACKed by=
 you. Another is already
> ACKed by you with minor modification.

See above.

Brian

