Return-Path: <linux-wireless+bounces-27012-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C2D4CB43DB9
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Sep 2025 15:51:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3738A04E43
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Sep 2025 13:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A0DC2D3737;
	Thu,  4 Sep 2025 13:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RTyzLZAl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05B8A2F28F1
	for <linux-wireless@vger.kernel.org>; Thu,  4 Sep 2025 13:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756993906; cv=none; b=s0vQFm4pdV0LTKpBt8wILQ1tz2C1Bwm/xpKaINMQThTk04JBoYU6MVlHv0AB5x4AeBeQAIDcejlZuqDI6XuxKFsvvIpwHbQu+JqpCQRKku9t3235/a4d2CF/jSsuQD5qR5S2zNMZC19b+xa/oAaxMRNqJsomiIyR+LvB60tKzrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756993906; c=relaxed/simple;
	bh=9x2SkHcOreXiuQqlC6/KRQjV/21MzDezCnoULkIP14o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lH4evJUWN2gG2UsQNHgMMo9cjOniPLfUKRfhl2+LKnt1KShwYABZGiNmiP0gdTZ8LVvjFPsz4+3uOaGmPMSAm19rWfXOyjZtZamgV3YMaPMp3VpSJGJ2HRzuCm8oaIkHO/95TP1M7wBebSJcM5Q/MN8HjbJPnLWSD23uyaCar7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RTyzLZAl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 976EAC4CEF8
	for <linux-wireless@vger.kernel.org>; Thu,  4 Sep 2025 13:51:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756993905;
	bh=9x2SkHcOreXiuQqlC6/KRQjV/21MzDezCnoULkIP14o=;
	h=References:In-Reply-To:From:Date:Subject:To:List-Id:Cc:From;
	b=RTyzLZAlShPyFMtsi0UexVZQwVzGjbu6FaAINotKEdeRmWh3OUFnQOJ2r8ILqVxYL
	 KqwzGuTb0xSpqKziR9HhqqWOwzVeN9cWTLiB5J+5ihAnOUkYp7U0UkkwgJjUiwwQQx
	 fsySuk2OjkXaE+J7lJMEKK/xyKyMGhqnL7zlg/4VwpJ8wN7rJvmikoUA+AMCrcLO5P
	 +rtvjU4PSnZWNEUwikOzxLkhzDDPh1losU3yi3R/oM3DSAljJdRUtLSmTeb5EkUYjw
	 TM72JJZf2VP5aY+bzAXls3EgizEsV/WAk8ouMQ1YiGcJAAodWPblsfeb3QvL9Hcwyn
	 PU+dhRPh6p6mQ==
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-71d71bcab69so10712367b3.0
        for <linux-wireless@vger.kernel.org>; Thu, 04 Sep 2025 06:51:45 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWGbuCd2WmJ5DQwo5e2SnuHdG63Y32wRq1Bzssx4KRtlaWkDIZ9DZWG3zfg/+LSfHY+JbnTBv4Y1p6LqQa9qg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwKP6DPuSYsvugk5+4CMdEVc2MHvNFvi3+oY6Pn2TRuUUqleEBB
	CTDoBhxHJAaENKfFZ7vu+2y0MhHUHAsvR4+r/du/m0MY7OTkLnEwGBIsiicTG6FbGZbdvrCl37O
	jfWERyin8imtC6iYWXpXJ7q01auip9YE=
X-Google-Smtp-Source: AGHT+IHUQteiIw9Ozw+TIjzw0U8r2r786UvTNixegNiMm4NrZnyJI1jgfIFJjmUDUB2mMdHQd0hJ8pzqmoWzU/u07ug=
X-Received: by 2002:a05:690c:d85:b0:71f:b944:1039 with SMTP id
 00721157ae682-7227658c8bdmr198576107b3.54.1756993904817; Thu, 04 Sep 2025
 06:51:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <3d942fb1-e7dc-41cd-885e-a610bfcf856e@oss.qualcomm.com>
In-Reply-To: <3d942fb1-e7dc-41cd-885e-a610bfcf856e@oss.qualcomm.com>
From: Josh Boyer <jwboyer@kernel.org>
Date: Thu, 4 Sep 2025 09:51:33 -0400
X-Gmail-Original-Message-ID: <CA+5PVA63eRdcFa+hNP7vScr+T-zCWDYRHe7PXQGqkyomV8=E-A@mail.gmail.com>
X-Gm-Features: Ac12FXzzi0Y-AYZKxADg5uVFx-x0HQZZynRywWYWLCPmNzu0XgUtI3XbES9OZGk
Message-ID: <CA+5PVA63eRdcFa+hNP7vScr+T-zCWDYRHe7PXQGqkyomV8=E-A@mail.gmail.com>
Subject: Re: [PULL linux-firmware] ath12k firmware ath-20250903
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Cc: linux-firmware@kernel.org, linux-wireless@vger.kernel.org, 
	ath12k@lists.infradead.org, jjohnson@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 3, 2025 at 4:29=E2=80=AFPM Jeff Johnson
<jeff.johnson@oss.qualcomm.com> wrote:
>
> The following changes since commit 7d59b255fba6e1c3a4b7814c028cb9f8e83e14=
e8:
>
>   Merge branch 'mt7925' into 'main' (2025-09-03 15:36:06 +0000)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/ath/linux-firmware.git at=
h-20250903

Merged and pushed out.

https://gitlab.com/kernel-firmware/linux-firmware/-/merge_requests/678

josh

>
> for you to fetch changes up to 1c44d84a08bf0dfec147db6637aff593d7195b0c:
>
>   ath12k: WCN7850 hw2.0@ncm865: add to WLAN.IOE_HMT.1.1-00018-QCAHMTSWPL_=
V1.0_V2.0_SILICONZ-1 (2025-09-03 13:23:20 -0700)
>
> ----------------------------------------------------------------
> Jeff Johnson (1):
>       ath12k: WCN7850 hw2.0@ncm865: add to WLAN.IOE_HMT.1.1-00018-QCAHMTS=
WPL_V1.0_V2.0_SILICONZ-1
>
>  WHENCE                                 |    4 +
>  ath12k/WCN7850/hw2.0/ncm865/Notice.txt | 3386 ++++++++++++++++++++++++++=
++++++
>  ath12k/WCN7850/hw2.0/ncm865/amss.bin   |  Bin 0 -> 6111296 bytes
>  ath12k/WCN7850/hw2.0/ncm865/m3.bin     |  Bin 0 -> 299660 bytes
>  4 files changed, 3390 insertions(+)
>  create mode 100644 ath12k/WCN7850/hw2.0/ncm865/Notice.txt
>  create mode 100644 ath12k/WCN7850/hw2.0/ncm865/amss.bin
>  create mode 100644 ath12k/WCN7850/hw2.0/ncm865/m3.bin

