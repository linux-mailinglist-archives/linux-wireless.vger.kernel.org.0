Return-Path: <linux-wireless+bounces-26480-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 46DD1B2E22A
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Aug 2025 18:19:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6880188AE37
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Aug 2025 16:17:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E7AD327785;
	Wed, 20 Aug 2025 16:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="paPpanP+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0863F326D7F
	for <linux-wireless@vger.kernel.org>; Wed, 20 Aug 2025 16:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755706643; cv=none; b=aB+9XBJG4ALQ3FQ6TkB+ybGWgnm0/P7rMM4HqBFA3LI7w+8zJQax9NNMt1ZjE5QUbVnLcO6pDU0p1fmY3gGi77T7dPvjn2lPz8Vmlo/uCxxQBUGggbf2a0XhHPfqAmANT5lljaPkJChFr31EIrd278yteGjjjRJCf/ldT3EmY1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755706643; c=relaxed/simple;
	bh=t+ycOb5iNlE3oQujrJjZp9WkbI6MVMq0bnMqM9b7LRo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fBGdu42duHCmgv8YaOvCoTn6jasNJec/EnDmDCFuyjQ0OsGSxA0q4Gk04PB2HeFKTXLBfDaCZ9h3IvdsQyhnzKb2ZGBB3MEXDp/bM9Xfjy304xH5euPsv9Rbs9tPBEMbxw1jqK38l/TNyRe9HRAJ4GBoZV3I/qX6T+bVINfaE+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=paPpanP+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F925C113CF
	for <linux-wireless@vger.kernel.org>; Wed, 20 Aug 2025 16:17:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755706641;
	bh=t+ycOb5iNlE3oQujrJjZp9WkbI6MVMq0bnMqM9b7LRo=;
	h=References:In-Reply-To:From:Date:Subject:To:List-Id:Cc:From;
	b=paPpanP+6j6Id2XAQw+l1Ns/fBw8uqCODHLS07VZOP4anZjsKxmN9dCWD++x+wraI
	 RYDwIyP3j9cxaeNkR521mN0qJcD7jLGEpNYitPxmFVbm7RLysSjhliawQcwHVtff40
	 1LsKtml83GDX1A1EdsY8erWB9VID5hlrpMKHhjljHz0B1RVHkvAqWSDLkD/AUURw97
	 3m2pGfFJfSNLfrDMujwok/XYtuGJL/n90ZgHyPOqeG7ru74CaB0A8jG30BA3rF7EZr
	 mjjmfEh4z/HujqX4+vJ9osqb9BpxqR6uOh+y/SH0Bw2nVi78qHT7pXZAFkDZmCLRFM
	 4Z8m9E+9k/SEg==
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e94e6c6150eso35586276.3
        for <linux-wireless@vger.kernel.org>; Wed, 20 Aug 2025 09:17:21 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXAuUNeXcmQQWF6y3TLk76EpDLuvzschAeN8B9kWIGByqvkUMa3W7ovjwKZKmS4VYvqWP5Yz9UKUgfcudIkOA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzG+V8clBTdYsSt2yhTL37auELJyPW1teEp1q2cMuSoh97gqxpZ
	wKKClV38dD+E1JJ69M9ntY1+DMAuFOy6NUsRY9snn2IQR2ejl3p8Z0KtIidKCwmWEws/XhYmtoK
	6qHHSFOuITO5dCaf0T9KaR9dbG3S50w0=
X-Google-Smtp-Source: AGHT+IEIvxy4pkBjmIrsNlC8iA7B1npTls4qyfPoYOP3dde7/lkDCFEZHzVAICwtTDSEfLDZEszUUaKvJvkzNr8ObbM=
X-Received: by 2002:a05:6902:430c:b0:e94:e1e5:37f4 with SMTP id
 3f1490d57ef6-e94f6707983mr3154446276.50.1755706640799; Wed, 20 Aug 2025
 09:17:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <323382be-397d-4df6-976a-89319fe97202@oss.qualcomm.com>
In-Reply-To: <323382be-397d-4df6-976a-89319fe97202@oss.qualcomm.com>
From: Josh Boyer <jwboyer@kernel.org>
Date: Wed, 20 Aug 2025 12:17:09 -0400
X-Gmail-Original-Message-ID: <CA+5PVA53_O+TmvHcJM-7xLaE5wwtELJE-oX8f=WZFnA+ZZSRGA@mail.gmail.com>
X-Gm-Features: Ac12FXzHSnPFBjD5SgC0DQxSz5oP68mLKNVoc6XNbXGuiE3XiYL4ENWc4kWi5wk
Message-ID: <CA+5PVA53_O+TmvHcJM-7xLaE5wwtELJE-oX8f=WZFnA+ZZSRGA@mail.gmail.com>
Subject: Re: [PULL linux-firmware] ath11k firmware ath-20250820
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Cc: linux-firmware@kernel.org, linux-wireless@vger.kernel.org, 
	ath11k@lists.infradead.org, jjohnson@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 20, 2025 at 11:24=E2=80=AFAM Jeff Johnson
<jeff.johnson@oss.qualcomm.com> wrote:
>
> Hi,
> Here is a new pull request for ath11k firmware.
>
> This adds an alternative firmware for WCN6855 that is part of NFA765,
> optimized for IoT applications.
>
> Please let me know if there are any problems.
>
> Thanks,
> /jeff
>
> ---
>
> The following changes since commit 5dcaa87d4035f437acb9d8817d88b269322698=
63:
>
>   Merge branch 'robot/pr-0-1755692386' into 'main' (2025-08-20 13:19:30 +=
0000)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/ath/linux-firmware.git at=
h-20250820

Merged and pushed out.

https://gitlab.com/kernel-firmware/linux-firmware/-/merge_requests/656

josh

>
> for you to fetch changes up to 71b945d2190cbaf6bebe8c1a8b0b41a71d65ec31:
>
>   ath11k: WCN6855 hw2.0@nfa765: add to WLAN.HSP.1.1-04685-QCAHSPSWPL_V1_V=
2_SILICONZ_IOE-1 (2025-08-20 08:01:38 -0700)
>
> ----------------------------------------------------------------
> Jeff Johnson (1):
>       ath11k: WCN6855 hw2.0@nfa765: add to WLAN.HSP.1.1-04685-QCAHSPSWPL_=
V1_V2_SILICONZ_IOE-1
>
>  WHENCE                                 |    4 +
>  ath11k/WCN6855/hw2.0/nfa765/Notice.txt | 3658 ++++++++++++++++++++++++++=
++++++
>  ath11k/WCN6855/hw2.0/nfa765/amss.bin   |  Bin 0 -> 5005312 bytes
>  ath11k/WCN6855/hw2.0/nfa765/m3.bin     |  Bin 0 -> 266684 bytes
>  4 files changed, 3662 insertions(+)
>  create mode 100644 ath11k/WCN6855/hw2.0/nfa765/Notice.txt
>  create mode 100644 ath11k/WCN6855/hw2.0/nfa765/amss.bin
>  create mode 100644 ath11k/WCN6855/hw2.0/nfa765/m3.bin

