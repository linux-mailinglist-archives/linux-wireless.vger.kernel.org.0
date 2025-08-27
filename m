Return-Path: <linux-wireless+bounces-26702-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 795BAB383C5
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Aug 2025 15:38:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77ADE189EB20
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Aug 2025 13:38:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 190641DB12E;
	Wed, 27 Aug 2025 13:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=moment-tech.20230601.gappssmtp.com header.i=@moment-tech.20230601.gappssmtp.com header.b="o3I1B/hx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27D35303C91
	for <linux-wireless@vger.kernel.org>; Wed, 27 Aug 2025 13:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756301901; cv=none; b=Jv5EW3UFnNsjFg0puQvSYnZ1/qKcx27KJu60Vtdh925Jc4Q8slG6qx5WCi/shQj6hH9WkqHwhcyIZLt7siWus3KVtvGdM7Eo73E42RabokPN+1tHEs/M0C8s5zJV2c9iNr5RbT9fehkUUX+CW2F2ZpX8g33T5J+bSjV6yOzGdXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756301901; c=relaxed/simple;
	bh=KE7wb2ebz3aytmTHU9Nm2QadMUrN0mtKT6nbctYdj4g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IussZqWi4fK9vsWJXly71oxmJmKtDUclGsKMbloxuFGfwhq4Blzqr4qw3/sEGDc4FxssiI9/+w733g/WVx4UaAif9zyhdAcinieOWO7Muj23KHVkRFXhSxLyp6OWl9/zVwUCqKhjkmo3xPAI3j6RSN6hGun7g7LylTB8SlNlAtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=moment.tech; spf=pass smtp.mailfrom=moment.tech; dkim=pass (2048-bit key) header.d=moment-tech.20230601.gappssmtp.com header.i=@moment-tech.20230601.gappssmtp.com header.b=o3I1B/hx; arc=none smtp.client-ip=209.85.217.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=moment.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=moment.tech
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-527348b392eso411108137.1
        for <linux-wireless@vger.kernel.org>; Wed, 27 Aug 2025 06:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=moment-tech.20230601.gappssmtp.com; s=20230601; t=1756301897; x=1756906697; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KE7wb2ebz3aytmTHU9Nm2QadMUrN0mtKT6nbctYdj4g=;
        b=o3I1B/hxdN+aYAHZ2uKYzYq5j2lOfgGsfQaxuDGx632E4Iiq4RBpGkOPLZEIIR2Iqf
         +6503HwHlnBpw6zOKba3OXg503aaTToOMkpr0Dh6Wls5FLRlgEpRhL6N0v9/GPuI2s7M
         EOZ6ZMUtyEO7ouZ0AXU23h8dzwpnVCwbdrt4/jWwL7CqEDTWO+tl9oUWZhEuO6ROvTxR
         Ft30BzgkDGDKy82LgIKTI1p4BW5yuTicH7esNEIqoMJvcK8wQRt+6hNLArYJLdfvRNuS
         co9NNjuYVRA9LSxxeKJp95bCh2pLgZGisAlTQ5LBaTX1Y8Z613P/KoECa/vlET0IH2/Q
         dTNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756301897; x=1756906697;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KE7wb2ebz3aytmTHU9Nm2QadMUrN0mtKT6nbctYdj4g=;
        b=KJIbiqzkw1TRoV501n+YwyOYCUX4/3kMjseSMQN+OkpFoRbtGRHhXbp3gLDaR2dGcJ
         NQgRVdqk6dwpGlBoS4F++azW9/2ulUATQ605qH6lzGE3CYoV+7S4fvn7s7J11ONfOHc2
         rWkwS+VP9EpLYflIx7thMtvxoIx24vgO18FygAF2ZgZohp4fAZbEUh5IV1ye0OjKaxxa
         OAVtagwUU/hT1s1otaZ8w0SROSNjsLIvYleqUCH70kcBV94J0igWxrcx9KgffQeO8yfG
         HmzQmcvrMMXxvN84PgJZt4MByBXo97o5ltjl2ddHCM09FXtNyFx89Jj74Jff3215dDXt
         Z3BQ==
X-Forwarded-Encrypted: i=1; AJvYcCWvuDuHCKNw2SQLaAADdZhMdAS3T7O4XFTDAq3tkAGUD+czMqxopsoECex/8lPzd0FjPoXDKTnIPQba4totvg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzPmqUL8U5LIUT3IEdeXKpxM63ibtAgv3TD2QE5KzsMFdgBEsks
	YQ4mGBZlJA8Phod8bcgI6I6M5NRXr1OuRci0uQ6yTafBwOezSv2ISv9DAiY5rKLss5MQCwEWXt7
	hDqkTtFrztjjxWMYmowlEzmI7VwgpnkXtCJiRPa3GgA0CPMAGeJpFhWqzmQ==
X-Gm-Gg: ASbGncvhMvVoJIGYJX0QTkiVC1I+yTNquoAiAhe/COkwdhggcoSVjlTXWJkNKVM0YR2
	iKzFP7eazWzxPGIHucakm/IgAdcrYVrOibO3iYRM+dQSZJRH1iXu1lh32/vHr4zm9OQUaCB5ncH
	LqLYQOP9DvNBo0Ho7QqZqUnel7wJTUhZTuHie6zuYFuKDAdtf2ez0lMERamF7xScNEuNQM/we0C
	eIFrm315Q4wzeGZ0Jru
X-Google-Smtp-Source: AGHT+IHOqDXgOE/03CQt8aIYD8DKGk5dbif04xDsPj/PX5VTOIQqUQbqqsUc9xOX07v23ZYhz582V6jq78kP1LQp7Ck=
X-Received: by 2002:a05:6102:3e19:b0:4fa:e005:cb20 with SMTP id
 ada2fe7eead31-51d0c8d7a21mr6967682137.3.1756301896706; Wed, 27 Aug 2025
 06:38:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250611164004.38580-1-balsam.chihi@moment.tech>
 <91fa8b1d-7bd0-4beb-80ef-eb65d2562f17@oss.qualcomm.com> <CAONkfw5Xyk8CGmVDpWZfkWnuCcFq6400jUkqyeMDtS0UNSh9vg@mail.gmail.com>
 <ecab2156-b234-4fba-a2ad-13a2d9b4693f@oss.qualcomm.com> <CAONkfw4hkDQtJyOj4RVsR3V=FJDJYKnjtmqzD=jBMy1ax=tC_A@mail.gmail.com>
 <0dfe48fc-085f-4dce-933d-e0f132d2ff9c@oss.qualcomm.com> <CAONkfw4p1AuE-MhGiZNMmi-PXR+CjoY63K2Yx_dmv2vnjo-Eyg@mail.gmail.com>
 <CAONkfw58jcGRxotm2zJasQd56oDR-h0b3Z0Yi+pE8hdrmN=Ucg@mail.gmail.com>
 <69f3fef9-017d-86fa-8fbb-2ac2a1df8ae4@quicinc.com> <CAONkfw4cQktTqR6e3PGfVhGQPsqPctwjwLSPjdiAvm45tq5qEw@mail.gmail.com>
 <127cb2e9-5371-21fa-1f09-586e6770afcc@oss.qualcomm.com>
In-Reply-To: <127cb2e9-5371-21fa-1f09-586e6770afcc@oss.qualcomm.com>
From: Balsam Chihi <balsam.chihi@moment.tech>
Date: Wed, 27 Aug 2025 15:37:40 +0200
X-Gm-Features: Ac12FXw1c-muGuOM_3hKorxmv6uk4EtkGN7FstlOP0GT4t_5hZAfRXFl3AYDogU
Message-ID: <CAONkfw5K0v7UJ1R8NmW1jVnukF9zsS38JAaV==j0_YXB3RynBA@mail.gmail.com>
Subject: Re: [PATCH] ath11k: pci: avoid unsafe register access during shutdown
To: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
Cc: Vasanthakumar Thiagarajan <quic_vthiagar@quicinc.com>, 
	Baochen Qiang <baochen.qiang@oss.qualcomm.com>, linux-wireless@vger.kernel.org, 
	ath11k@lists.infradead.org, jjohnson@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 20, 2025 at 12:29=E2=80=AFPM Vasanthakumar Thiagarajan
<vasanthakumar.thiagarajan@oss.qualcomm.com> wrote:
>
>
>
> On 8/20/2025 2:03 PM, Balsam Chihi wrote:
> > On Wed, Aug 20, 2025 at 10:03=E2=80=AFAM Vasanthakumar Thiagarajan
> > <quic_vthiagar@quicinc.com> wrote:
> >>
> >>
> >>
> >> On 8/19/2025 2:20 PM, Balsam Chihi wrote:
> >>> Hello,
> >>> I Have a question on the same subject but not related to the bug.
> >>> I have many identical PCIe WiFi cards on the system and I need to loa=
d
> >>> a different board-2.bin on each one (1 adapter per frequency band).
> >>
> >> So you are using multiple pcie devices at the same time in a system
> >> with ath11k? Wondering if you are using any private patches to address
> >> QRTR instance id clash issue [1][2].
> >>
> >
> > I'm not aware of any issue of QRTR instance id clash.
>

To clarify: my setup is based on an NXP LS1088A SoC hosting QCN9074
PCIe cards, using the ath11k_pci driver.
The cards communicate directly over PCIe, and QRTR/QMI infrastructure
is not used or enabled in my system.
Therefore, QRTR instance ID clashes are not applicable in my context.
Maybe QRTR is only applicable for SoC AHB based integrated WiFi IPs?
And I did not use any of the patches [1] and [2].

> Then better take [1] for proper functioning with multiple pcie devices.
> The other one requires a new firmware feature flag.
>
> >
> >>> Is there any kernel built-in solution for that?
> >>> I could not find any, so I had to create a patch that loads a
> >>> different board-2.bin for each card based on the pci device address.
> >>
> >> Current board data selection for QCN from board-2.bin is based on pci+=
chip-id+board-id
> >> combination, not based on pci device address. You can find the chip-id=
 and board-id in the
> >> debug during QMI boot stage. Then you can use ath11k-bdencoder [3] to =
encode those
> >> board data binaries into board-2.bin. This way you can package all the=
 needed board
> >> specific binaries for a hardware into a single board-2.bin. Ath11k boa=
rd data file
> >> load logic uses chip-id and board-id to download the right board data =
for the given
> >> hardware variant.
> >
> > I have multiple PCIe WiFi adapters based on QCN9074 from different
> > manufacturers.
> > The problem is that I could not distinguish between them at the system =
level.
> > All have 0xFF as board ID.
>
> Hmmm, ideally it should have a valid board-id other than 0xff.
>

I asked the manufacturers about it and they said that all their pcie
wifi cards are with
board_id=3D0xFF and I have to use the provided board-2.bin because of
the calibration data,
regulatory date, band capability and many other reasons...
That's why I had the need to write the patch.

> > So, when loading the default board-2.bin they behave the same way.
> > When I contacted the manufacturers they sent me board-2.bin for each
> > configuration :
> > 2x2, 4x4, 2.4Ghz, 5GHz... (maybe calibration data and more?)
> > The default board-2.bin for board ID 0xFF does not support all bands.
> > My requirement is to have 2.4Ghz band on slot 1 and 5Ghz band on slot 2=
.
>
> I can not think of the cleaner solution when board-id is not programmed.
> If you can make changes to ath11k driver and your system has device-tree,
> may be you can add a hack to pass board-id/chip-id through dt (new dt pro=
perties)
> to driver. In any case, you need to encode all your board data binaries i=
nto
> one board-2.bin to enable auto download of the right board data into firm=
ware.
>

Adding DT properties will require patching the driver too to be able
to read them.
So, I already patched it. Without the need to change the DTS.
And as you just said the board id is not programmed...

> > So the patch reads from rootfs a text file named with the pci device ad=
dress,
> > the path to the custom board-2.bin.
> >
> > P.S. : qca-swiss-army-knife did not succeed in decoding the custom
> > board-2.bin files.
>
> I that encoded binary with TLV for each board data or it is board data
> binary itself. You can run ath11k-bdencoder -i <board-2.bin> to
> get the information about the board-2.bin. You can use ath11k-bdencoder -=
e <board-2.bin>
> to extract the board binaries and json used to package the board-2.bin
>

ath11k-bdencoder -i <board-2.bin> and ath11k-bdencoder -e <board-2.bin>
did work for the public board-2.bin file and i was able to extract a
bin file per board id :
bus=3Dpci,qmi-chip-id=3D0,qmi-board-id=3D160.bin created size: 131072
bus=3Dpci,qmi-chip-id=3D0,qmi-board-id=3D161.bin created size: 131072
bus=3Dpci,qmi-chip-id=3D0,qmi-board-id=3D162.bin created size: 131072
bus=3Dpci,qmi-chip-id=3D0,qmi-board-id=3D255.bin created size: 131072
bus=3Dpci,qmi-chip-id=3D0,qmi-board-id=3D163.bin created size: 131072
bus=3Dpci,qmi-chip-id=3D0,qmi-board-id=3D164.bin created size: 131072

but the commands did not work for board-2.bin from WiFi card manufacturers.
i noticed that their board-2.bin have the same size as the extracted ones.
I tried to run the commands on the extcraced ones and i've got the same err=
or :
invalid signature found.
This means that their board-2.bin could be integrated to the public board-2=
.bin.
but in my case it is not the solution because of the board_id=3D0xFF.
So, the PCI device address is used to decide which slot will do 2GHz or 5GH=
z,
even if I swap the cards and it's quite useful for me like that.

>
> Vasanth
>
> >>
> >> [1] https://patchwork.kernel.org/project/linux-wireless/list/?series=
=3D692423&state=3D*&order=3Ddate
> >> [2] https://lore.kernel.org/all/20230111170033.32454-1-kvalo@kernel.or=
g/
> >> [3]
> >> https://github.com/qca/qca-swiss-army-knife/blob/master/tools/scripts/=
ath11k/ath11k-bdencoder
> >

