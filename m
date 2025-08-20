Return-Path: <linux-wireless+bounces-26472-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E041B2D6A3
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Aug 2025 10:36:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1EFF91884E33
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Aug 2025 08:34:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E972726E70B;
	Wed, 20 Aug 2025 08:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=moment-tech.20230601.gappssmtp.com header.i=@moment-tech.20230601.gappssmtp.com header.b="IzMCfEwg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9A4E231826
	for <linux-wireless@vger.kernel.org>; Wed, 20 Aug 2025 08:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755678833; cv=none; b=GBVhlFp4Vsnym6SoAOHhgJ0/Z0lEbg1iooPpXnY3Om/TJF6mwx1xrf3iqTiHMPhPMFjE2kw0hDinMifs+o2y7ubQZLVUWLwpQIaVKgoYij9HhKRXsWbCiaso+n5pd4XhlIGwCY/r3UTNP+4cq0hvjxFzF+bEfvfERghilaIPTLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755678833; c=relaxed/simple;
	bh=B/gyvWOcQvvcUFNAAR36SpZ7Qmtpec5uKGHhrZ1PSa4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YnqnYdnBHzz5LZoljgJhY5V3PuP6nV4mzR8fzLuA5c7C4VkyjR6rfXKUMie3H9n1vS/MZEILCaSnnyaojzylVek6Y4uvf6RmGHFTyV0vJY/KW0OPWk8v/LtEfQTNlWLt23HjI9KSUfF4hvRNgK/x9NZJB7yDfBcxHOaPZfFYxNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=moment.tech; spf=pass smtp.mailfrom=moment.tech; dkim=pass (2048-bit key) header.d=moment-tech.20230601.gappssmtp.com header.i=@moment-tech.20230601.gappssmtp.com header.b=IzMCfEwg; arc=none smtp.client-ip=209.85.217.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=moment.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=moment.tech
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-50f890e3df6so1759292137.1
        for <linux-wireless@vger.kernel.org>; Wed, 20 Aug 2025 01:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=moment-tech.20230601.gappssmtp.com; s=20230601; t=1755678829; x=1756283629; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B/gyvWOcQvvcUFNAAR36SpZ7Qmtpec5uKGHhrZ1PSa4=;
        b=IzMCfEwgRWxojzQJqx8STxkez2OJmaKptaBn2ROmQ4vY7HJeDWxH88E4XCKXRGM4zZ
         Kf0ulyroA9oGHLJQlWX7hWPnXiYcXhrGP1YBtDdlNzPpX+lE+XEP2Wd5ELMJPAaAgloI
         wZYTtl7SeTuRoqbxJbt9SX660goxh/8mbCpsRZbD/oa0l4qEBbCxsf/u9RQlvldcEK2b
         iFA+JwGaJLEURl4gjC0SfnHRkWlFXfCyJSJdELgfnGHXw5t48RBQckXmY7Q1+SfMnkmR
         P/Z+HPIIo5jdsv9hxrjIqgFmCHZB2jUllB9Fc3EQ/dGALPc2g+YKI/fb9k7q0lFiEdPP
         UkLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755678829; x=1756283629;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B/gyvWOcQvvcUFNAAR36SpZ7Qmtpec5uKGHhrZ1PSa4=;
        b=XeO9KEIqBDd9RlWiwWcm8hw9uYaNALvyklzn+5fIAUprOl+jfSeVxcJLRdgd7PxJbJ
         Wx36Evimzvoi7ANSmi5/Lo3+F0TqvgTdfgbaPsPY2xN2iaKKRG18PqalTR6wlxqWFKPr
         rceMAXkqGySiqjAUs4G8bDx7oNMB3kz87mi7mh3/z4iosXhAOmN3Nz8Cb4Q53tQTzBLi
         rK3qaGuhcT7yQrnY60aR9FkAFrTfleG63ec3owIr5CUE4byfqOXWtaDQ/It4OWLYZQ7I
         gzLmqEDF/G00GsqVJMbpPoLz5QLCpQ6OsPmZyZXGy+vzOgycT/5LLI8M6et125+qEMG1
         8Oyw==
X-Forwarded-Encrypted: i=1; AJvYcCWV5Y+DLIAU9sePLmoyzxgRvZGgaKE3GX+EITG789sS+TjwLSzKgC7aOg1vuXuBI9UkVCjtqXZgVVtame6HCA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxOTnnCpKR4Y9iDa7TXDBiJzEOoRlteEU3Y5YyFKvk4OPf2OytK
	oQWNsKEsS5evQW6mAV5Puz9CxWuHVdR6mQOJLFeraeZgztUvP9frmXB0Oo6az5ELnhRuQChQCq/
	1GAQ3ioi+OeTgNUlhQTp20Ii1JbAP4IIOrB3hIQ0hxw==
X-Gm-Gg: ASbGncsI3kC6a9m/oGWRxW2aTBUWTcicQo9mAX8zxvi4aZHsrphsNrS+biP0UVKtAhf
	HQ8FtzXQbAlEFWUDgT1kboG2U2/qpX3FCOxv8kVnFVsQiDUEpLLXriyigR7S9UpbXX1SZLj7R//
	3b5pQn4uvmQ1HSNu8tvzRmTgv+L1GwxQceSb0kDIuIz+O6r+OdSdoPY/QkXW30vFuLGKl9bxUMY
	zlFjiWnZaJkMDQDXMl9
X-Google-Smtp-Source: AGHT+IGdwXIo/Lq9pZ04mpZIutVXJE985PZFUOtHZA5OEt4PiHNjNukjGyULyBSg0KQSY620R9BtmZCsCh8F1Z9M8q4=
X-Received: by 2002:a05:6102:510d:b0:4e6:edce:4b55 with SMTP id
 ada2fe7eead31-51a4f437ef3mr574122137.4.1755678829651; Wed, 20 Aug 2025
 01:33:49 -0700 (PDT)
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
 <CAONkfw58jcGRxotm2zJasQd56oDR-h0b3Z0Yi+pE8hdrmN=Ucg@mail.gmail.com> <69f3fef9-017d-86fa-8fbb-2ac2a1df8ae4@quicinc.com>
In-Reply-To: <69f3fef9-017d-86fa-8fbb-2ac2a1df8ae4@quicinc.com>
From: Balsam Chihi <balsam.chihi@moment.tech>
Date: Wed, 20 Aug 2025 10:33:13 +0200
X-Gm-Features: Ac12FXyhq9h9XK7ltDa2jzIR2ta6rp-lPJytWMAmWt01wbo3Vckwg9PTfaTdmSo
Message-ID: <CAONkfw4cQktTqR6e3PGfVhGQPsqPctwjwLSPjdiAvm45tq5qEw@mail.gmail.com>
Subject: Re: [PATCH] ath11k: pci: avoid unsafe register access during shutdown
To: Vasanthakumar Thiagarajan <quic_vthiagar@quicinc.com>
Cc: Baochen Qiang <baochen.qiang@oss.qualcomm.com>, linux-wireless@vger.kernel.org, 
	ath11k@lists.infradead.org, jjohnson@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 20, 2025 at 10:03=E2=80=AFAM Vasanthakumar Thiagarajan
<quic_vthiagar@quicinc.com> wrote:
>
>
>
> On 8/19/2025 2:20 PM, Balsam Chihi wrote:
> > Hello,
> > I Have a question on the same subject but not related to the bug.
> > I have many identical PCIe WiFi cards on the system and I need to load
> > a different board-2.bin on each one (1 adapter per frequency band).
>
> So you are using multiple pcie devices at the same time in a system
> with ath11k? Wondering if you are using any private patches to address
> QRTR instance id clash issue [1][2].
>

I'm not aware of any issue of QRTR instance id clash.

> > Is there any kernel built-in solution for that?
> > I could not find any, so I had to create a patch that loads a
> > different board-2.bin for each card based on the pci device address.
>
> Current board data selection for QCN from board-2.bin is based on pci+chi=
p-id+board-id
> combination, not based on pci device address. You can find the chip-id an=
d board-id in the
> debug during QMI boot stage. Then you can use ath11k-bdencoder [3] to enc=
ode those
> board data binaries into board-2.bin. This way you can package all the ne=
eded board
> specific binaries for a hardware into a single board-2.bin. Ath11k board =
data file
> load logic uses chip-id and board-id to download the right board data for=
 the given
> hardware variant.

I have multiple PCIe WiFi adapters based on QCN9074 from different
manufacturers.
The problem is that I could not distinguish between them at the system leve=
l.
All have 0xFF as board ID.
So, when loading the default board-2.bin they behave the same way.
When I contacted the manufacturers they sent me board-2.bin for each
configuration :
2x2, 4x4, 2.4Ghz, 5GHz... (maybe calibration data and more?)
The default board-2.bin for board ID 0xFF does not support all bands.
My requirement is to have 2.4Ghz band on slot 1 and 5Ghz band on slot 2.
So the patch reads from rootfs a text file named with the pci device addres=
s,
the path to the custom board-2.bin.

P.S. : qca-swiss-army-knife did not succeed in decoding the custom
board-2.bin files.

Best regards,
Balsam
>
> Vasanth
>
> [1] https://patchwork.kernel.org/project/linux-wireless/list/?series=3D69=
2423&state=3D*&order=3Ddate
> [2] https://lore.kernel.org/all/20230111170033.32454-1-kvalo@kernel.org/
> [3]
> https://github.com/qca/qca-swiss-army-knife/blob/master/tools/scripts/ath=
11k/ath11k-bdencoder

