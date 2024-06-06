Return-Path: <linux-wireless+bounces-8624-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D2128FF086
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Jun 2024 17:23:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F931B25B6B
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Jun 2024 15:14:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1981197A7D;
	Thu,  6 Jun 2024 14:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KNznBASd"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A78AC1993B5
	for <linux-wireless@vger.kernel.org>; Thu,  6 Jun 2024 14:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717685508; cv=none; b=Y9DdJh6M5pJ0BeoYtPJZWB51kkN2OfH1oCVlLfVCpJ4a1MKbHK7CELKccCJQQkibUAkgkdHuXm9DKTaH9Iop8nUU0iKjYx2sCCdSv26AHejJGkWtyWVR8mXgrpXb3Me3W2tTU+nCymyFeIW+Ysl21Xi+Gmly4RTYuL/+Sp/Kus8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717685508; c=relaxed/simple;
	bh=4yUuVIpNSByOKrQaxBK79bz+fXs14mIZpU2VxC6YR1A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R0pbdkS76fDmoEhFFh8xm+gPs9HULGPV3HL6DpZZzk2sRces0wr4HuCOz5YBExLZmyGHEinHpT7/gwwrr7i5JMzXUkWW0scQuY44GRFYVI27lBTvyXXJXWp6i+OHJ2Bh4vPVpdLadwwQ2qCQ0gbILKuFJqZ+lGuEbtriAhwEOrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KNznBASd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8931AC32786
	for <linux-wireless@vger.kernel.org>; Thu,  6 Jun 2024 14:51:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717685508;
	bh=4yUuVIpNSByOKrQaxBK79bz+fXs14mIZpU2VxC6YR1A=;
	h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc:From;
	b=KNznBASd741KbU5KtyhTgrfu+ucYIPfmdjZBGNOuKDPoZ+CuCMU0W2HexU557cVxt
	 twcaVzCrfgWHX2+JS6gv3ku+SrFoipqQW1Gy29rVRP0NFDskRDBFt4x0WXC2K1PPIn
	 FcgzzMA+A0C7iSAihanL9TSNDHAcysoDYoorm9VyVHLMC8Iql3HIbs0q4ZvPjO1i/A
	 MTHJpKaj5rT3WrT3I/HCL7egSSaJ16JCZnwgUoy4XM4LtbifN+lMwrdb/K/guZzvVT
	 cCrPpA0a6o0T/9xS4dPYDXuT6WAgo/2iHSLrCkPfLNdIasQT/O37lH6fU6yRu8gWds
	 QssZ9UqSkiAUQ==
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2eaa80cb573so12302501fa.1
        for <linux-wireless@vger.kernel.org>; Thu, 06 Jun 2024 07:51:48 -0700 (PDT)
X-Gm-Message-State: AOJu0YyDp0n1vUzPkpHJH8zfpw9XRB8iHiJ6i+r3yoV3qWK2KI9aXmUb
	Fl/p3FAbV9lSepA+1DdcxrP9MmLznlcf/3E4E260GXmC6HJQMr1hTk8YsXDtZWZg666vKTlFYYf
	+hVBNZajicE5dwVAArxbhCmuKqn8=
X-Google-Smtp-Source: AGHT+IG1XLP0JHa7pVv+1OHvxPTO2xmsAuXJDBNstDo0vp9x6gO8+oTUsg8bZtp82tUtI8ovSGU/o2hsH/1u96ksxLc=
X-Received: by 2002:a05:651c:19a6:b0:2e9:714a:ef43 with SMTP id
 38308e7fff4ca-2eac798e609mr38883471fa.8.1717685506946; Thu, 06 Jun 2024
 07:51:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240603060558.98791-1-pkshih@realtek.com> <171768539053.810063.5040807853852576172.b4-ty@kernel.org>
In-Reply-To: <171768539053.810063.5040807853852576172.b4-ty@kernel.org>
Reply-To: wens@kernel.org
From: Chen-Yu Tsai <wens@kernel.org>
Date: Thu, 6 Jun 2024 22:51:34 +0800
X-Gmail-Original-Message-ID: <CAGb2v65xfJJ7nDy3f8UXM5PpCVNYAf0+xsv=PuK0BWymGN2+sA@mail.gmail.com>
Message-ID: <CAGb2v65xfJJ7nDy3f8UXM5PpCVNYAf0+xsv=PuK0BWymGN2+sA@mail.gmail.com>
Subject: Re: [PATCH 1/4] wireless-regdb: Update regulatory info for Malaysia
 (MY) on 6GHz
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: linux-wireless@vger.kernel.org, wireless-regdb@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 6, 2024 at 10:50=E2=80=AFPM Chen-Yu Tsai <wens@kernel.org> wrot=
e:
>
> On Mon, 03 Jun 2024 14:05:55 +0800, Ping-Ke Shih wrote:
> > Malaysia Communications and Multimedia Commission announced CLASS
> > ASSIGNMENT NO. 1 OF 2022, which page 11 describes frequency bands
> > 5925-6425 MHz are used with conditions of 25 mW EIRP for indoor and out=
door
> > use and 200 mW EIRP for indoor use only.
> >
> > [1] https://www.mcmc.gov.my/skmmgovmy/media/General/CA-No-1-of-2022_-si=
gned_19012022.pdf
> >
> > [...]
>
> Applied to master in wens/wireless-regdb.git, thanks!
>
> [1/4] wireless-regdb: Update regulatory info for Malaysia (MY) on 6GHz
>       https://git.kernel.org/wens/wireless-regdb/c/ddbf3192cbc0
> [2/4] wireless-regdb: Update regulatory info for Morocco (MA) on 6GHz
>       https://git.kernel.org/wens/wireless-regdb/c/472f62de66a7
> [3/4] wireless-regdb: Update regulatory info for Chile (CL) on 6GHz
>       https://git.kernel.org/wens/wireless-regdb/c/2b2e1f829e84
> [4/4] wireless-regdb: Update regulatory info for Mexico (MX) on 6GHz
>       https://git.kernel.org/wens/wireless-regdb/c/30b964dd5d3f

Ugh. Wrong revision merged. *cringe*

Please ignore this.

