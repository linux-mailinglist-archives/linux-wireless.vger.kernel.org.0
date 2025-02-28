Return-Path: <linux-wireless+bounces-19592-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65CB8A49BD1
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Feb 2025 15:23:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A165816897D
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Feb 2025 14:23:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 711E526D5A4;
	Fri, 28 Feb 2025 14:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hYYfQyes"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C3241AA1FA
	for <linux-wireless@vger.kernel.org>; Fri, 28 Feb 2025 14:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740752608; cv=none; b=R1xZCt/ynLmtBSZVsnRzp57TdxAFo1EQj3zb9WK6pFe3pdYOtRd07IaoCfaQ9UqFEHms/sxK016vsiYwiTdbJPRjNDCSOk0BAkD9DNZ6sLcndyLYayTQuISv9w07LrO7JCNFn4xqEqqvjawDjwBn8c+HsIUdJnTwDxH2xNTjYwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740752608; c=relaxed/simple;
	bh=Ixp7yCQwmxH5iAj5X6uih/HSFfgLk+61gfC1s2n2Sog=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qno7JnekmG9J82uiyhOsmsbjUmArEhRBtWApS8uq8UEIcD02zX37zDBmM7QMs7HHLyWgd6n1m+Q46ZctVf45VNrFVGVHXl6GThYY3iCJyxeLEfKBqcNpH2bjrqUpzFgh4LRlQ7+jjqXWc9UWZ/TDNG18Bnif3wZa7rqbcPfXzLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hYYfQyes; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2F44C4CEE9
	for <linux-wireless@vger.kernel.org>; Fri, 28 Feb 2025 14:23:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740752607;
	bh=Ixp7yCQwmxH5iAj5X6uih/HSFfgLk+61gfC1s2n2Sog=;
	h=References:In-Reply-To:From:Date:Subject:To:List-Id:Cc:From;
	b=hYYfQyes+87D1zRTYv39OBFRpEnSGd8l37xdtNglQGpGcmjCbLirYjyodDymq5eaX
	 q0TBGVZQXBmE90qnX26v+rxcSUjgbQZzlOWFU9KvtMyWX5eyrA9VvsnE/0kJ5FJiZD
	 LdvSw2d6Qpqj18QDfIqnw157OME0fa/gE3b7OAlL0gpfi5yHnSMKXHiDGfI5ORT2m8
	 WuUtBA0rvx9kMTDUlV03HWoCQGoRHFFgVklx42upT3XcNW3kBUTg1dZjCLOtMIYTob
	 YQhNyjWDwoX1Ee3xPA3oLwpfC0DeEWH78SpISqu+3d0UfYa4AoBs2Y4al4r2gVR9xT
	 5eLJzeHBSPtIg==
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-6fcf90d09c6so18756677b3.0
        for <linux-wireless@vger.kernel.org>; Fri, 28 Feb 2025 06:23:27 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWSX0ppSgOYwceVEXnF/viB+2wdbqPl78zXr7Or8sH5yygNL9cHx+PuJ1WH0+Zk7jUwj4BOIn0B2nj/dvreKQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzU/JxIx/GpVqTrWCfrRGlpkQz0uWnY1JPjCzzZB5ebGwrt4/cn
	X3FP8Iwtea3UzmRmiKpG8C4C0pn2ssZ64C2tqDh9svCDeFUSdXlyErrjCZMjyvc5O/cds4yr6JK
	w0s6KPpqPACtYfvEexaPseTjkBTY=
X-Google-Smtp-Source: AGHT+IFBw+C8TJ7OTqiW9TAJfZMrrLscr0uAEq4wfLF+1ArhUSuCv2PPuHPrhhoFsg/POsSt1JR6zA+fHf12wo1fI14=
X-Received: by 2002:a05:690c:4988:b0:6fb:5d74:959d with SMTP id
 00721157ae682-6fd39471851mr104119537b3.1.1740752606896; Fri, 28 Feb 2025
 06:23:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <74b29af1-4024-4636-af8f-a95fa0f3601e@oss.qualcomm.com>
In-Reply-To: <74b29af1-4024-4636-af8f-a95fa0f3601e@oss.qualcomm.com>
From: Josh Boyer <jwboyer@kernel.org>
Date: Fri, 28 Feb 2025 09:23:14 -0500
X-Gmail-Original-Message-ID: <CA+5PVA76tdjDE+4+JrpkrQ0+mw2aB-MPtXx6vjaQc77d8AQ6gw@mail.gmail.com>
X-Gm-Features: AQ5f1Jq49M1aKHoQ4B7ctdYd0pAV_MseN3BJzOya8m5bDxVjlI7OkYAe0iQqH7o
Message-ID: <CA+5PVA76tdjDE+4+JrpkrQ0+mw2aB-MPtXx6vjaQc77d8AQ6gw@mail.gmail.com>
Subject: Re: [PULL linux-firmware] ath10k, ath11k and ath12k firmware 20250226
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Cc: linux-firmware@kernel.org, linux-wireless@vger.kernel.org, 
	ath10k@lists.infradead.org, ath11k@lists.infradead.org, 
	ath12k@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 26, 2025 at 6:08=E2=80=AFPM Jeff Johnson
<jeff.johnson@oss.qualcomm.com> wrote:
>
> Hi,
> Here's a new pull request for ath10k, ath11k and ath12k.
>
> This request only touches ath11k, and adds new firmware and board file fo=
r
> QCA6698AQ hw2.1 and new microcode for QCA6698AQ.
>
> Please let me know if there are any problems.
>
> /jeff
>
>
> The following changes since commit 1a1470d90de2a25e5befadb2f1fa30758af682=
ca:
>
>   Merge branch 'robot/pr-0-1740366711' into 'main' (2025-02-24 05:26:03 +=
0000)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/ath/linux-firmware.git at=
h-20250226

Merged and pushed out.

https://gitlab.com/kernel-firmware/linux-firmware/-/merge_requests/461

josh

>
> for you to fetch changes up to 811bb52b1d293c3a9641c8747c8963ade18b7e81:
>
>   ath11k: QCN9074 hw1.0: update to WLAN.HK.2.9.0.1-02175-QCAHKSWPL_SILICO=
NZ-2 (2025-02-26 14:53:32 -0800)
>
> ----------------------------------------------------------------
> Jeff Johnson (3):
>       ath11k: QCA6698AQ hw2.1: update board-2.bin
>       ath11k: QCA6698AQ hw2.1: update to WLAN.HSP.1.1-04604-QCAHSPSWPL_V1=
_V2_SILICONZ_IOE-1
>       ath11k: QCN9074 hw1.0: update to WLAN.HK.2.9.0.1-02175-QCAHKSWPL_SI=
LICONZ-2
>
>  WHENCE                             |   5 +++--
>  ath11k/QCA6698AQ/hw2.1/amss.bin    | Bin 5132288 -> 5140480 bytes
>  ath11k/QCA6698AQ/hw2.1/board-2.bin | Bin 866120 -> 986384 bytes
>  ath11k/QCA6698AQ/hw2.1/m3.bin      | Bin 266684 -> 266684 bytes
>  ath11k/QCN9074/hw1.0/.notice       |   4 ++++
>  ath11k/QCN9074/hw1.0/m3.bin        | Bin 340108 -> 340108 bytes
>  6 files changed, 7 insertions(+), 2 deletions(-)
>  create mode 100644 ath11k/QCN9074/hw1.0/.notice

