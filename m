Return-Path: <linux-wireless+bounces-27141-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 56C85B4A1D2
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Sep 2025 08:13:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ADCFB7B01FC
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Sep 2025 06:11:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A45D2F3616;
	Tue,  9 Sep 2025 06:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JdA+YKmS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13AF42D8791
	for <linux-wireless@vger.kernel.org>; Tue,  9 Sep 2025 06:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757398379; cv=none; b=K+JVtR+6zT4Mr/ePfpTGzi56q2uEx6yD/tO5lOz735bbkBQMuAJOc8Q2TFn9BAh3b0HLruVRiJnNYOhZ6I1nh7NgixSDQkOV7pln7KEmLpBIvjSRFkoPJ7N0OSXqSvinja0Dr60ZSLFpRYB8p2OgT6o+p6H5x55SqN3dRPjJTpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757398379; c=relaxed/simple;
	bh=IhTfS0JUckoliWKeRxLgJ1fRKb93Z2PXLWdC7vce1Po=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hohB26f0b0qLIwzVhI55DIYggUj6o5Mj5oCwlkF+ljbfZKUGavE/7NA9o4pcLtIhgQBLTdsizsYvq5D7c5rc6LS9Ku7KQhO9xcVg2geC2uKA3hEdms+lNjdzwCouoihDp9D3MWA1X11ulg1Nah1RWh66YrsJsvOdoSWCwK4NTOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JdA+YKmS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 953DAC4CEFD
	for <linux-wireless@vger.kernel.org>; Tue,  9 Sep 2025 06:12:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757398377;
	bh=IhTfS0JUckoliWKeRxLgJ1fRKb93Z2PXLWdC7vce1Po=;
	h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc:From;
	b=JdA+YKmS48rFY08CB//OrLRHr3sTmavZttnDpnvkb4VsDVNix8RAfpT78unHOJgIc
	 impKvBxXqOPkB1RMFr9HwNz8Y1jZwUvsIjMQYcbPbH8vqGdwKyOMbc2OMIHyBJyFG4
	 eE9JcArDL3pJA3VjoUuNHi+1lQatxLiaXcojD+cT4G3uEJtA89TmMQSAkOsucg19UT
	 fs5Xd0Wo0HccMnHOt4QdbWZmLS8iMYMNCA7l2P/HrmV4VTUXxK6APfT9uNZKKqDGNf
	 3KeYbhs4twwliFs6C5g87wUTY6xQcliw1c0Uly1JgVvR9LULUoo7DbYp9f8nDBtQJd
	 JnOwbcckhs3kA==
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-336a85b8fc5so38494331fa.3
        for <linux-wireless@vger.kernel.org>; Mon, 08 Sep 2025 23:12:57 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUfHzaxeWJug44p+JXU4A7mjqnp4F+pvnOl2VOk4MzX1feMzjVzlsY2VjkPrTxLK9R2o+x8IaxzfUuii18+ZA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxQKxkrMb3pHjmYQ9TsU7fl9pZKbhCbNTGzQDUAPoUW/xBzH10E
	1AVB6OUIz8D+NpwGbfs81IJ9pU19CAWh1lDy9pT4q5a3O7ZUBgjJLFRhX37xb6b4SCPDlNyAupz
	JqlrmhdekRA3se5z/V1/MfvArrg+g/Ek=
X-Google-Smtp-Source: AGHT+IHmIWEsCknZu3Jqd201RYpsXCgaqRpOm4m1rhu2IqOFqpBjyfEfmvoPDAL7Tq+q9yrHWoLwflm6Ly6nv45/NMk=
X-Received: by 2002:a05:651c:23d2:20b0:338:735:8a79 with SMTP id
 38308e7fff4ca-33b4b230a20mr25793411fa.1.1757398375874; Mon, 08 Sep 2025
 23:12:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <000201db8822$98f28da0$cad7a8e0$@gmail.com> <CAGb2v65490c1m3W_1RkxJ-E7Q=3V_K8xqS2jmd6awcOdzWHXzQ@mail.gmail.com>
 <ff6ad414457e4b1cb68e834978a553c3@realtek.com> <CAPRryQobXZe5OwR=F-X0KHYyfBwUpFsi=Y5pKnENcUXTN42xAA@mail.gmail.com>
 <002d01db8da7$daf2ed50$90d8c7f0$@gmail.com> <CAGb2v66Y+rTsuKfQDgv-qwRTOorOucM+qfBOia-gY5sPCJp5qQ@mail.gmail.com>
 <319c9de5-e26f-45c0-9200-747c86bce303@green-communications.fr>
 <001a01db8ddc$019e8890$04db99b0$@gmail.com> <CAGb2v6689=CmxqOk9rCSXPctg8iCZzOUgcaxdNeB9uHSHzk39Q@mail.gmail.com>
 <14ab2a58e7603047354a17b2c980c143992a6782.camel@sipsolutions.net>
In-Reply-To: <14ab2a58e7603047354a17b2c980c143992a6782.camel@sipsolutions.net>
Reply-To: wens@kernel.org
From: Chen-Yu Tsai <wens@kernel.org>
Date: Tue, 9 Sep 2025 14:12:43 +0800
X-Gmail-Original-Message-ID: <CAGb2v66aOHxeHEEKO_XaBfufWPnjJk6RkTBo8e9D1T9ET4S1Fg@mail.gmail.com>
X-Gm-Features: Ac12FXx4shXnbeVWSvaDVdt1XgyWGOKPO6XkNJGCmVmG-O_vnFWduYdKw68XKJw
Message-ID: <CAGb2v66aOHxeHEEKO_XaBfufWPnjJk6RkTBo8e9D1T9ET4S1Fg@mail.gmail.com>
Subject: Re: wireless-regdb: Allow 6ghz in the US
To: Johannes Berg <johannes@sipsolutions.net>
Cc: rmandrad@gmail.com, 
	Nicolas Cavallari <nicolas.cavallari@green-communications.fr>, 
	Dennis Bland <dennis@dbperformance.com>, Ping-Ke Shih <pkshih@realtek.com>, 
	linux-wireless@vger.kernel.org, wireless-regdb@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Mar 6, 2025 at 4:02=E2=80=AFPM Johannes Berg <johannes@sipsolutions=
.net> wrote:
>
> Uh, this is a complex discussion. I do believe that we simply do not
> have a way to capture the complexity of the rules in the database today.
>
> Skimming the documentation, it seems that:
>
>  * Paragraph 56: For AP operation, it is allowed to operate an LPI AP
>    (indoors, obviously) - we could capture that with NO_OUTDOOR and
>    that's what the rule has now.
>  * Paragraph 122: For client operation, passive scanning is required,
>    presumably because clients are assumed to be mobile and thus also
>    present outdoors, where they will also scan.
>    This can only be captured with NO_IR today.
>  * There are additional spectral density power limits in paragraph 59,
>    which cannot be captured by the database today.
>
> However, the combination of these really cannot be captured - NO_IR will
> also prevent AP operation, which I think is the issue discussed in this
> thread, but removing NO_IR will make clients break Paragraph 122.
>
> I'll note that in general scanning on the 6/7 GHz band, by 802.11 spec,
> is only active on the few Preferred Scanning Channels (PSCs), however,
> that'd _still_ break Paragraph 122.
>
>
> Unfortunately, it's also hard to fix - we cannot remove NO_IR because
> that's used by older kernels, so I think the only way to fix it would be
> to add a flag a la NL80211_RRF_ALLOW_6GHZ_VLP_AP (which translates to
> IEEE80211_CHAN_ALLOW_6GHZ_VLP_AP) which overrides NO_IR for this
> specific case.
>
> We also have reg_rule->psd internally already, I guess we just never
> added a way to convey it from userspace? Not sure what it even does
> though.

I wonder if it is worth bringing up this topic in the networking track
at Plumbers this year? It would be about the various limitation of
wireless-regdb today, such as:
- lack of PSD
- only one rule per band, preventing things such as
  - AP on 6 GHz in the US, as this thread mentions
  - very low power outdoor usage vs higher power but indoor-only usage

That said, I'm not in a position to implement anything to improve the
status quo.


ChenYu

