Return-Path: <linux-wireless+bounces-9752-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A389391DABD
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Jul 2024 10:58:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C585A1C2242D
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Jul 2024 08:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F5B4132117;
	Mon,  1 Jul 2024 08:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="au8CpYPC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AE0E12DDA9
	for <linux-wireless@vger.kernel.org>; Mon,  1 Jul 2024 08:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719824117; cv=none; b=atDifUudcU9DIAXJ4CkBFUiPdrqFMxkxc9n+Btt3JNeorRCwESMMYiy1x7PD1cr2K845m54IGBGfJ9sMu4RX2MEYjYpUwHDb0Mox/yOyekHKwmM+PVOKxclXQc11/GWnrU9Qv8raGNPrn+wKl+HTk8peMf2niBv/X1A1XV7UUj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719824117; c=relaxed/simple;
	bh=SuvjarER2AZq18GyRlIXRrOt6IN/6thFb0jUI4bj+3g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E0rPKsizsx8XumH6ZFzqDCHO/m/7Os6sRQzULwgfMQWfbkJGo3Wy1WaxJF6V8H6qGsANjsnYxLtnpBLMFcgDJ1v8PbgRHPNPBZUNA38P96xyY9sqGH01SJLmZJYSmnXjsQCmdbjEBm291fNEtXMPvJ5D70RdV7aCFIU+0Kt3WwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=au8CpYPC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD033C116B1
	for <linux-wireless@vger.kernel.org>; Mon,  1 Jul 2024 08:55:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719824116;
	bh=SuvjarER2AZq18GyRlIXRrOt6IN/6thFb0jUI4bj+3g=;
	h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc:From;
	b=au8CpYPCxv7TsB3HuOHLinc+CPyPloR8g1pdqFPzXB3V4mrJNkzthTim5KHDriwO0
	 MI9bV95o80ddoGUmXK5UW49g5GgBFC2OI2jQWvHylAvaSk5IrQvEN9durdbcJs1ypE
	 1sPLkDvLXH1FJXKOz7o4eWFCzxPFZTmADmkP1jwAv4jZrPr7fpOwcv7DJt40mwVMTi
	 ZrA2hVsQRvtM+S2K0zWq/fXpAFMM3xp6RfB7pUMxot4MEz6gOxwDLPrcMo1PLOmoN9
	 SUecsVc0dsnYZL1sfYGOyeTA9GQ7SnEVx3DOXoXK3eHcJoVT2II5IUXR9bITGebsut
	 xA6qY9Z3R/Kcg==
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2ee4ab4076bso32450451fa.0
        for <linux-wireless@vger.kernel.org>; Mon, 01 Jul 2024 01:55:16 -0700 (PDT)
X-Gm-Message-State: AOJu0Yz1FmO6rYO1WB4ZDkhVYHbg+clritLmuTu1A0JQhXUD/XEgtKTi
	5y7cKr0DW8KDZkETDih850uZ4SDHav4kMwOHVrdhH5/jq9IjcwEQl/sMg5+wFMIrMJ6ZzWPyUkL
	RtwRVmJz9LgXgTrewHZY9Dilt7Wk=
X-Google-Smtp-Source: AGHT+IEiwZPU1FVVO+z7Xw7oqUU9yTGlMQMY63gZIOt5jn79c63KhcekBw3AwEObZJeMR7rFpA/IoqkOzJNFiFuLPlM=
X-Received: by 2002:a2e:8907:0:b0:2ec:825:91b9 with SMTP id
 38308e7fff4ca-2ee53bfb12amr25859461fa.9.1719824115094; Mon, 01 Jul 2024
 01:55:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240624025623.6021-1-pkshih@realtek.com> <20240624025623.6021-2-pkshih@realtek.com>
 <CAGb2v651jAs9g-UqCeoPgmiigpNDTVY_itvhwq9VBHPuzfdPRg@mail.gmail.com>
In-Reply-To: <CAGb2v651jAs9g-UqCeoPgmiigpNDTVY_itvhwq9VBHPuzfdPRg@mail.gmail.com>
Reply-To: wens@kernel.org
From: Chen-Yu Tsai <wens@kernel.org>
Date: Mon, 1 Jul 2024 16:55:01 +0800
X-Gmail-Original-Message-ID: <CAGb2v65aRPo3kwvUA8WZXxnbjJmGNr5OsU9=92zLzCUSB8MzSQ@mail.gmail.com>
Message-ID: <CAGb2v65aRPo3kwvUA8WZXxnbjJmGNr5OsU9=92zLzCUSB8MzSQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] wireless-regdb: Update regulatory info for Jordan
 (JO) for 2022
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: linux-wireless@vger.kernel.org, wireless-regdb@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 1, 2024 at 4:22=E2=80=AFPM Chen-Yu Tsai <wens@kernel.org> wrote=
:
>
> On Mon, Jun 24, 2024 at 10:56=E2=80=AFAM Ping-Ke Shih <pkshih@realtek.com=
> wrote:
> >
> > The Hashemite Kingdom of Jordan, Telecommunications Regulatory Authorit=
y
> > issued pursuant to the provisions of Articles (12A) and (22) of the
> > Telecommunications Law No. 31 of 1995, as amended. [1]
> >
> > The effective radiated power (EIRP) of devices used in local radio comp=
uter
> > networks must not exceed the following values:
> >
> >  - 2400-2483.5 MHz: 100 milliwatts (20 dBm)
> >  - 5150-5350 MHz: 200 milliwatts (23 dBm), (ETSI: 20 dBm, DFS)
> >  - 5470-5725 MHz: 1 watt (30 dBm), (ETSI: 27 dBm, indoor only, DFS)
> >  - 5725-5875 MHz: 200 mW (23 dBm), (ETSI: indoor only)
> >  - 5925-6425 MHz:
> >    * 25 milliwatts (14 dBm) (for outdoor and portable devices)
> >    * 200 milliwatts (23 dBm) (for devices operated indoors only)
> >  - 57-71 GHz: 10 W (40 dBm)
> >
> > Follow ETSI EN 301 893 [2], which specifies reduced power limit of
> > 20 and 27 dBm for the range 5150-5350 and 5470-5725 respectively for
> > devices that don't implement TPC; and classifies the 5470 - 5725 MHz an=
d
> > 5725 - 5875 MHz ranges as indoor use only; and DFS is required for band=
s
> > 5250 - 5350 Mhz and 5470 - 5725 Mhz. (Add these rules followed rules of
> > [1] with "ETSI:" annotation)
> >
> > [1] https://trc.gov.jo/EchoBusV3.0/SystemAssets/PDF/RSMD/cb9f9a83-43a6-=
4e66-8432-6e02ecaf465b_RLAN%20Arabic%20%20Final%20-%20clean%20with%2057-71%=
20GHz.pdf
> > [2] https://www.etsi.org/deliver/etsi_en/301800_301899/301893/02.01.01_=
60/en_301893v020101p.pdf
> >
> > Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
> > ---
> > v2:
> >   - Follow ETSI EN 301 893 to modify limits, and add description in com=
mit
> >     message.
> >   - add 57-71 GHz
> > ---
> >  db.txt | 12 +++++++++---
> >  1 file changed, 9 insertions(+), 3 deletions(-)
> >
> > diff --git a/db.txt b/db.txt
> > index 61c46186919e..60343a745ecf 100644
> > --- a/db.txt
> > +++ b/db.txt
> > @@ -957,10 +957,16 @@ country JM: DFS-FCC
> >         (5490 - 5730 @ 160), (24), DFS
> >         (5735 - 5835 @ 80), (30)
> >
> > +# Source:
> > +# https://trc.gov.jo/EchoBusV3.0/SystemAssets/PDF/RSMD/cb9f9a83-43a6-4=
e66-8432-6e02ecaf465b_RLAN%20Arabic%20%20Final%20-%20clean%20with%2057-71%2=
0GHz.pdf
> > +# ETSI EN 301 893: https://www.etsi.org/deliver/etsi_en/301800_301899/=
301893/02.01.01_60/en_301893v020101p.pdf
> >  country JO: DFS-JP
>
> Change this to DFS-ETSI given that the official regulations just point
> to ESTI for details.
>
> > -       (2402 - 2482 @ 40), (20)
> > -       (5170 - 5250 @ 80), (23)
> > -       (5735 - 5835 @ 80), (23)
> > +       (2400 - 2483.5 @ 40), (20)
> > +       (5150 - 5350 @ 80), (20), DFS
>
> Per ETSI regulations, DFS is only required for 5250 - 5350. Please split
> this into two rules. And please add AUTO-BW to both.
>
> Also, looking at the official regulations again, I believe it is worded
> in a way that does not require TPC for 5150 - 5350. So please raise the
> limit back up to 32 dBm.

I meant 23 dBm.

> Thanks
> ChenYu
>
> > +       (5470 - 5725 @ 80), (27), DFS, NO-OUTDOOR
> > +       (5725 - 5875 @ 80), (23), NO-OUTDOOR
> > +       (5925 - 6425 @ 320), (23), NO-OUTDOOR
> > +       (57000 - 71000 @ 2160), (40)
> >
> >  # Source:
> >  # https://www.soumu.go.jp/main_content/000635492.pdf
> > --
> > 2.25.1
> >

