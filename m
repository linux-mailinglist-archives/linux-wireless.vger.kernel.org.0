Return-Path: <linux-wireless+bounces-24522-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96D8FAE9802
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Jun 2025 10:20:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F26B76A4524
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Jun 2025 08:18:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42F8B262FE4;
	Thu, 26 Jun 2025 08:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EdtW2Sjj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DF8725CC54
	for <linux-wireless@vger.kernel.org>; Thu, 26 Jun 2025 08:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750925722; cv=none; b=dBm1OqyjOJOHYLg/jwHLrBHVGXonY2p7TsSki3cqOMgVKJV8MUAJobx3AKKEP/VyyFl2LdN7i0JNX5CIbVxVCv6pjtyDS7qxRCIsyGPiGAL7bJ8Lv0lhhqRvr1QD0I+n3BI6Tjg4a00lf7f9P4wbWbR+G0rtjJRb1KTKx2vkPdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750925722; c=relaxed/simple;
	bh=SmK8b6VrBI/cE9vO5wXRBlljKbzYgPH45k2S+M2/jHo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BCblK7PVhlBJd3gNuG1OX/EnHC+4m7POjzxk1QwFlLHp//pMXzQ2h50Jae+lfLsKqewX9GPZRwbRA/e3YFsCx1NZhCwEr1M0O2yciqR0V2BI3O7FaHU18tb9Nq+jf+fdwGvpOVBQ2KFat6KdNZfhulM3BFh/WYI0PxVH0Ht6/5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EdtW2Sjj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A90FDC4CEEE
	for <linux-wireless@vger.kernel.org>; Thu, 26 Jun 2025 08:15:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750925721;
	bh=SmK8b6VrBI/cE9vO5wXRBlljKbzYgPH45k2S+M2/jHo=;
	h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc:From;
	b=EdtW2SjjSDHauwf6PyFVttkrT8/aaIIPzM495VOtZhoLqu+Uag9MIV9b6pF3q9l2X
	 MiKvFQpVldNnmDf01y6UwEcf7i+4lWJ7Ba10kl69F+tHFcMmAza0o048du2d+YtLKT
	 PakTmS+eBRdI9u7E8DpFSKPPmzBDxhBj+bL3+/W7P7JlhuVKMI+2f9f7Mtn6r0NCDg
	 FJ43MfIXCcncs0lDTdFuj6Xc/fYrV1XMajJKt2tA1Z6o1+3rk1Atu/aQfKAJF5vAXJ
	 0jscEda3iE+kUWry6lWywiwtWbQHK1qL7Rbv+0bXWE24534hlwnJO+3pqQA9M9fA9A
	 JVNbOK5/Nkiww==
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-32b7123edb9so6285681fa.2
        for <linux-wireless@vger.kernel.org>; Thu, 26 Jun 2025 01:15:21 -0700 (PDT)
X-Gm-Message-State: AOJu0YwnRKGfJbYSgtyVV2ALQVEpvddzIcWF8xMB2K6aD5WuvOIBN8kn
	i2rPZOLbAo+RsYnI+3wQUgHcgWECwBMKnkVMUNj3NCJZbb/I7kewbja/H1SDyq8XSx97r4A8ia3
	OnPkOAtTSkAu34VdSAylIOyVfkWgwvZI=
X-Google-Smtp-Source: AGHT+IHggU3vz5CakghnW+4rPk363vdtiWa5vUIITEkBiwnIDVowlCfKg1mumuErjARME73DKW7HA8C86WR5dzDV2+w=
X-Received: by 2002:a05:651c:724:b0:32a:8591:668f with SMTP id
 38308e7fff4ca-32cc65a0155mr13794901fa.31.1750925720078; Thu, 26 Jun 2025
 01:15:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <8bc290d6-5687-495d-b5d5-a8ca94cf2f7a@gmail.com>
In-Reply-To: <8bc290d6-5687-495d-b5d5-a8ca94cf2f7a@gmail.com>
Reply-To: wens@kernel.org
From: Chen-Yu Tsai <wens@kernel.org>
Date: Thu, 26 Jun 2025 16:15:07 +0800
X-Gmail-Original-Message-ID: <CAGb2v64z3Yv_MNxJDTMcDR5ajD_L0zpsea2aBcrCLKfw3HUmiQ@mail.gmail.com>
X-Gm-Features: Ac12FXyWjrJE1Oy8LDZuKw4922MF6BQ7ScmZpiwvF9CC5CxrOL6aPgnVb79jJtU
Message-ID: <CAGb2v64z3Yv_MNxJDTMcDR5ajD_L0zpsea2aBcrCLKfw3HUmiQ@mail.gmail.com>
Subject: Re: wireless-regdb: Update regulatory rules for Brazil (BR) on 6GHz
To: Marcos Alano <marcoshalano@gmail.com>
Cc: linux-wireless@vger.kernel.org, wireless-regdb@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 2, 2025 at 9:23=E2=80=AFAM Marcos Alano <marcoshalano@gmail.com=
> wrote:
>
> Hi,
>
> The rules for Brazil were based on this normative
> https://informacoes.anatel.gov.br/legislacao/resolucoes/2017/936-resoluca=
o-680,
> as mentioned in the comments of the entry.
>
> This January came out a newer normative
> https://informacoes.anatel.gov.br/legislacao/resolucoes/2025/2001-resoluc=
ao-772,
>
> It allows 6GHz frequencies, so the line:
> (5925 - 7125 @ 320), (12), NO-OUTDOOR, NO-IR
> Should change for, at least:
> (5925 - 7125 @ 320), (12), NO-OUTDOOR
> The removal of NO-IR is important, since routers Wi-Fi 6E and 7 don't
> work because of this outdated rule based on an outdated normative.

Those are very large documents. Could you help point out which sections
or comments apply to your argument?

Thanks
ChenYu

> I'm no lawyer, so please if you see something different, like more
> granular control in the allowed frequencies, please let us know.
>
> Thanks,
> --
> Marcos Alano
>
>

