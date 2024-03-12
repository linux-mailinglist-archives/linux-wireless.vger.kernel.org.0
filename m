Return-Path: <linux-wireless+bounces-4633-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 53BA587988D
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Mar 2024 17:09:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 829301C213A7
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Mar 2024 16:09:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35E947D071;
	Tue, 12 Mar 2024 16:09:37 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9F8B7CF09;
	Tue, 12 Mar 2024 16:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710259777; cv=none; b=m1CgDC9jPQWWJGt/DEmyK6bmsGqm3WRyeN4FDelg3TboCbQDH/Gt4/kr41GcoMihxWt6pJ08+oKO0Ro55zkWu1PJBjmEHf1L82HFzsp5x8Bd2n4xL+QzvI5AxNi1//l6q0mm9WYrIacYjCYREvmVhbMZnO9Dq1bIcevChUqAL78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710259777; c=relaxed/simple;
	bh=cDyDRHryGPqpj5GSXxvbgaqrkmOHvBYWafXLeSXan9s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EBIhUDOdkJ/dqvljxfVc+CggIPXK6coQCuqAQyih6+4uQL1ZudrecVrPQ8rmZzPWyhqlXFDBzJdPi/4plts2HUFL4udkSKKtKOQ5VR4Jsa9fDvnbcG+SEhRs3cryfkfFfUbR0TYvTVLWAMcPP2sd/sJl6IieJqgxsx0rxnqp+h0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lwfinger.net; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lwfinger.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2d28e465655so88633051fa.0;
        Tue, 12 Mar 2024 09:09:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710259773; x=1710864573;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1em0UiU249DrHLeNzLIJml8irT8PKoy/CdEqSjvk3lI=;
        b=WLsHnGmMcLWDpfzNiDdJ7DstxhgTN1c5wVEOkL6wCM/5uN/lVyeU0EUK3AYvourF5z
         aXVHXSn76yrE0q2PuguPyae75A1BqRc3vI3fnfoEm+3UpensUr6TnfFWyNum7yZrORwd
         gNnUbF4O8FxSSWiyeeXdiY/AskvV9jcyUikTGe0TAEoJlk2GQvPOY6QlBquDolBPla+Q
         4NU0p1WNnE8fxlk19RFZvVi8y92E2LtENxMFrDyf3dDpDYFqwz2O7mq5Za/8iWVQdZkG
         QfNCLi6RhaidaCqmu/hbTV5DQN4tllTpTPSJctyi1jG+vvpPRxBYIVlPuq8JSLjmzQnz
         1GkA==
X-Forwarded-Encrypted: i=1; AJvYcCVexvfKEv+l8L+HIIiTGzKcrn8nVi5UAAVYwnQljilpewuTz32T1Grq3XkP4h2gLCAJqS5Z2Rj+lDxL4uEVCcQztiQrSAVQtPAQ12jgb7m+WtlxIcRiI2ymWTxjxXVwCLcCFHrmZ2yigu8=
X-Gm-Message-State: AOJu0YyY9JQmhYDG7G+aF9pKYHtL+4HkvQTIv2TW4mv0wsa86lkdvPPO
	B20eQnNlaLZDntptcf29xN+fpss4DJfT6m+On39eXt+2wGzrXVWxtEOWZQZmZxomf/CU7bZ4hmU
	ofNHFH0LRFfAVG9S31PFQLKw6xH8=
X-Google-Smtp-Source: AGHT+IFn4yvJ3wdeK2JRTYDdajOpz3X1T5HkNFOVvAAPj0sw1Er1amaiiwNIwxU60pyeaOTe7OqlmP4wfAHZVO8m9sE=
X-Received: by 2002:a2e:9e19:0:b0:2d2:6608:3d05 with SMTP id
 e25-20020a2e9e19000000b002d266083d05mr6193541ljk.52.1710259772949; Tue, 12
 Mar 2024 09:09:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240311103735.615541-1-fiona.klute@gmx.de> <e540243c657043f9a6d0a8d5314191d3@realtek.com>
 <ZfAVlEhsMwYMq9BY@amd.ucw.cz> <6c73784ecc04cadbcaae3f7e073ffb120e13853c.camel@realtek.com>
In-Reply-To: <6c73784ecc04cadbcaae3f7e073ffb120e13853c.camel@realtek.com>
From: Larry Finger <Larry.Finger@lwfinger.net>
Date: Tue, 12 Mar 2024 11:09:21 -0500
Message-ID: <CAP71bdXhOTY83ODqJjb6Qjt=8HZqwx-YFbwcvWzXx5WMBFtT9Q@mail.gmail.com>
Subject: Re: [PATCH v4 0/9] rtw88: Add support for RTL8723CS/RTL8703B
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: "pavel@ucw.cz" <pavel@ucw.cz>, 
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, "kvalo@kernel.org" <kvalo@kernel.org>, 
	"megi@xff.cz" <megi@xff.cz>, "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>, 
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "fiona.klute@gmx.de" <fiona.klute@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Those patches have been merged with
https://github.com/lwfinger/rtw88.git. If you have an rtw8723ds, you
can access the new driver now.

On Tue, Mar 12, 2024 at 4:01=E2=80=AFAM Ping-Ke Shih <pkshih@realtek.com> w=
rote:
>
> On Tue, 2024-03-12 at 09:43 +0100, Pavel Machek wrote:
> > Hi!
> >
> > > > v4:
> > > >   * Move definition of GET_RX_DESC_BW from rtw8703b.c to rx.h (now =
in
> > > >     patch 3/9 "wifi: rtw88: Add definitions for 8703b chip")
> > >
> > > v4 looks good to me. Thanks for the great work!
> > >
> > > I also have run sparse/smatch with v4, no warning/error.
> >
> > Does it mean you queued the patch, or is someone else expected to do
> > that?
> >
>
> I mean this patchset is okay to me, and Kalle will help to apply this
> patchset to wireless-next tree. I suppose next next kernel v6.10 will
> have this.
>
> Ping-Ke
>
>
>
>

