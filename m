Return-Path: <linux-wireless+bounces-26179-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87517B1C95A
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Aug 2025 17:53:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D053116998A
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Aug 2025 15:51:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 431582904;
	Wed,  6 Aug 2025 15:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XEcEjD8n"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FCA1292B45
	for <linux-wireless@vger.kernel.org>; Wed,  6 Aug 2025 15:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754495484; cv=none; b=VDcSr/Hwrq94vMlSIx47Kqwhb1YnIdJ179EbRSmNyHdw1l99e27/EUKwgmEHTCmgJHCPaeZRnPLLmTH34gU01/DNQq8oTrI7n9AsZpHceRbnHO55NqaiPyRvECMMejAe1ur673Rswf5Aey3Q5vVMJynwL4bW3igtHVxoPN/1Z5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754495484; c=relaxed/simple;
	bh=lgCSteki+t2ptlG/th49EEKiYbUbsa+8Xf0k+LnM4fQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NY2PRuvcKVCiqQZsP3PGp0OWLkd9dsOoRNCLEjxjlnmlF/pykGs+6iYPbijMNYE4sT+WZE3JMg26HCddFhua2N5KRZE+0TIVlbTqaMTMcnc0g+eqYK/PrfyE7y2HiW2j9Y/nEmgd0qXWu1R42b/HAJscUIvNOQHcIvkOfyWNrt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XEcEjD8n; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-61564c06e0dso10109a12.3
        for <linux-wireless@vger.kernel.org>; Wed, 06 Aug 2025 08:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754495480; x=1755100280; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lgCSteki+t2ptlG/th49EEKiYbUbsa+8Xf0k+LnM4fQ=;
        b=XEcEjD8nQhnl6sdRsNH+jYPkUxqsGuV+tff+MKFMMEoiorKto6r2y4c9NI7fw3t2VR
         i488VDAsiQz5VYjBS+PKk6lpynSsEJbIbNnLJCy/YT8hvgvTOR6nmx+L5c3HKg/9pU4F
         yuEMSFL2T0xTsNal2YuFvNfYd1+gFubILjtsiRXIg7oQDsjZ0I59TxdZz9QY6USr0ffQ
         UxpX+epHl8s+hHoAzZr3u0Mfx6MbuBV6MOipKdq/X6NnK1INhAGzMsidncKQs4CdOL4P
         VDkq5pbmmhK4Md5XzYuFOGGYzELygHVRFJbKWPhpheLtWVtdSRwk/HfB0SEI9jsIlfDM
         p2sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754495480; x=1755100280;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lgCSteki+t2ptlG/th49EEKiYbUbsa+8Xf0k+LnM4fQ=;
        b=baA6jsa9feQxbUVqAUbHo2u2YhjUrsRf+uuP1o11H75VQg97hleMZNjJAyWfwlInIV
         Ix9+auhn6E3sih8OY2c/G381H7Zd0EQiQbkQLepVw2BEUdkzhxYZa5rkr58NDQw9PUL2
         1mpoE6fnbD0fGr5zah/t2h9mceYkqZHZrj2znyDontT9Zbw0N7pnsDBsrOvwOGujqFFO
         76XVFQLMiJ8NjYcm3JgfbLF4ou7PtQAptUrnlM1MoGIKOGfdaxcv54vf9iMjSRYv3HMm
         CPHyYBWjv1Ex6G5T2ELFtQVFTK+b/klzZyGEpR9nhGMP0pcMJ8b/TUHG3PQkwNuiJwEQ
         dhPA==
X-Forwarded-Encrypted: i=1; AJvYcCVFWTcur/qll/dSJPjbJNFihPFnak0wuuJqmA9YKXsPPLg4AJNZrdG9SHQ5RtcoCxH4Juxtcz+J6gIKwizcdw==@vger.kernel.org
X-Gm-Message-State: AOJu0YybizA2daO/CvxT30DtOWQH3nyG3ZF+6aXwbRoHqhcZBTSVlNiA
	aDCmAErEOg2hw5KDXVchMCu3SIEh0NFT4CZHZgSX2BR24JpIm/u2VpmT/2n6MmyIUlIwPNxmrRm
	jNGDXbUhR9afHPramHeXotZYKMObSGPs=
X-Gm-Gg: ASbGnctySReZpfFZj3zS/uaKY3dAEBcY5K/JnagnLBrFjmg/SnPVwz44tDZwjTvdjgL
	JXb5oDKKcFRKfbzeX24Eq31wsq/QknLn4FRIvhhu9nVdeHUI8U+I0+P/etMm5zBqWmTo6qe/yu8
	eorBUSk5AP2Slo7ALL6xZFFwuqSnVff5Cmab9GQSAoE8wQCsAAGUl5rPMo8Fwnf73aaIoJHeI+E
	OvajIabW3l6ecLXrA==
X-Google-Smtp-Source: AGHT+IE3MeNHT6IbSDqqyk8Nl5eb2ctbTeULDiqqa3ommVO1l1tS3oPic/2CvY1Vu23D69lNA0tN4EnrAVnFBs6yny0=
X-Received: by 2002:a05:6402:518f:b0:602:241c:345 with SMTP id
 4fb4d7f45d1cf-61797e1acaamr2302513a12.23.1754495480266; Wed, 06 Aug 2025
 08:51:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250806070005.1429-1-hujy652@gmail.com> <29ef8aab-06a3-48e2-a370-86b1b2107143@oss.qualcomm.com>
In-Reply-To: <29ef8aab-06a3-48e2-a370-86b1b2107143@oss.qualcomm.com>
From: Zhi-Jun You <hujy652@gmail.com>
Date: Wed, 6 Aug 2025 23:51:09 +0800
X-Gm-Features: Ac12FXzWxzIOa51wZLvSPCSe3-7hewf18YP2hT4TEr_5gZ2RQVfpKsU2qB5skfI
Message-ID: <CAHGaMk_rMCoWDzKtxgsg9GkH0s-U540zYq_AOC9HpBo_JF7qJg@mail.gmail.com>
Subject: Re: [RFC PATCH] wifi: ath10k: support flush_sta method
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Cc: jjohnson@kernel.org, Remi Pommarel <repk@triplefau.lt>, linux-wireless@vger.kernel.org, 
	ath10k@lists.infradead.org, Loic Poulain <loic.poulain@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 6, 2025 at 10:23=E2=80=AFPM Jeff Johnson
<jeff.johnson@oss.qualcomm.com> wrote:
>
> On 8/6/2025 12:00 AM, Zhi-Jun You wrote:
> > When a STA is marked as no longer authorized, if the driver doesn't
> > implement flush_sta(), mac80211 calls ieee80211_flush_queues() to
> > flush hardware queues to avoid sending unencrypted frames.
> >
> > This has became a problem for ath10k because ieee80211_flush_queues()
> > will stop all traffic and call ath10k_flush, which waits until the
> > whole HW queue is empty. In a busy environment this will trigger a
> > timeout warning and stalls other STAs.
> >
> > Fix this by implementing flush_sta method using WMI command to flush
> > frames of a specific STA.
> > Flushed frames will be marked as discard in tx complete indication.
> >
> > ops->flush_sta will be set to NULL if htt.disable_tx_comp is set to
> > true.
> >
> > Tested-on: QCA9984 hw1.0 PCI 10.4-3.9.0.2-00157
> >
> > Signed-off-by: Zhi-Jun You <hujy652@gmail.com>
> > ---
>
> There is already a patch from Remi pending for this, see:
> https://msgid.link/cover.1732293922.git.repk@triplefau.lt
>
> Please see if that series addresses your needs.
>
> First Kalle, and then I, held this back due to lack of internal validatio=
n
> across supported platforms, but it is actually still on my TODO list:
> https://patchwork.kernel.org/project/linux-wireless/list/?series=3D911851
>
> Let me make one more validation request internally since I know there is =
at
> least one ath10k-based project with active development.
>
> /jeff

Hi Jeff,

I am aware of the series and glad to know it's still on the list.
I did test with it but the warning can still be triggered easily with
the instructions in Remi's series.
And according to other people's reports it can still block sometimes. [0]

drv_flush_sta() is called before clearing the keys and Remi's approach
still waits for the frames to be sent which imo isn't enough in this
situation.

[0]: https://github.com/openwrt/openwrt/pull/19427#issuecomment-3102794793

Best regards,
Zhi-Jun You

