Return-Path: <linux-wireless+bounces-23373-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFC54AC2F47
	for <lists+linux-wireless@lfdr.de>; Sat, 24 May 2025 13:04:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA7F6A24B6A
	for <lists+linux-wireless@lfdr.de>; Sat, 24 May 2025 11:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11DAB1E633C;
	Sat, 24 May 2025 11:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iXZAc2LB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDC331E9901
	for <linux-wireless@vger.kernel.org>; Sat, 24 May 2025 11:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748084513; cv=none; b=dAeAwX/J9tSv8B0dlWM8Wrb7c+6lU2TEtm5mQ2aR9wIx0WnuCxzVBHiq8mMLy5sjGWuSWKPP1Mo2MIVqsq17+yuxVwhhpuKGD7cVgngFrA1fbQnMPKrCpzPuP8pDspphefyEwblS0tfsRSn5gvH+9ZlEjFoWhG5Va3T7euJCPOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748084513; c=relaxed/simple;
	bh=jsOFI/3l7DI68xEW1jpWooo+c55YFp/WUqSMUC7U6gc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pJHeMUocUN5YAmG9onXurYCBpbXmeZlSDKIj3QLuMadEUv8OUOmN32Yvk8nLX3oLnf3e2/RWaGr6HTFa+t+koWlGBOn+epRBUCz6+8Wu5sG6WfvskctVa8g+g0kBvxbi9uq9AS9rHOtEjckMbsAchFrHQT/pz6HA8F3ukRAxPFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iXZAc2LB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5457AC4CEE4
	for <linux-wireless@vger.kernel.org>; Sat, 24 May 2025 11:01:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748084513;
	bh=jsOFI/3l7DI68xEW1jpWooo+c55YFp/WUqSMUC7U6gc=;
	h=References:In-Reply-To:From:Date:Subject:To:List-Id:Cc:From;
	b=iXZAc2LBcVW8Fywka9T/Zjl2puikL4K+eRHRwLpX91hzjC3f1QVKwQt2vnQZgPNfk
	 r1GLLv3UacZJaf5/acGIcIGE2azadOes968G4shCn5MT/yLyvWD5HzuXfMFOt2sBVj
	 XkKZwrEaHKFkLvyS8XrX5R3rEg4c3mwJqj4VlMLPFzd5/KsB5mM0Nb759oflu3Au0X
	 yKkVf4x164nhY38avISdSkt119gNvellidFtjkFSFncHZYFIwkBFV3aiFzlumwrfYK
	 7wvMHSSW1e8orKBe3w8wKlolHic8V3LNma1iqlouWwiOF3Zff+HUAXIN/DkSCvsP7I
	 zAl539dy3iiSg==
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-70e33252046so2060897b3.3
        for <linux-wireless@vger.kernel.org>; Sat, 24 May 2025 04:01:53 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXPL3rPlfWbWJViCVxQvQLQo/ugFirdtK5b8gMkjWFcQvmEyIOLC7mM/PY7Y/sFLqR6WnjO7bp/Vx4UVWjMeA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzTNoxmoIH2CXJsY4Fi8E1m0Dmv8OmzyMO52f5Vrn6WFZx3Uqyt
	NsgUNSy5kTJVs6Xz/CiGLstwj8DWjftzZvKou2n85Q3eANEdjsBQyUPIgUSE2OI+ehzymO0owk4
	ocmOAhMunCdCyLmRcY6/c6HWcWY9oP1U=
X-Google-Smtp-Source: AGHT+IFJVdZ543r+wIyn2Imhhh/2TGC+yMudMhDw1/AM/qAFP+N7wR+LWtgSrHl5DYBkEaNMuQIbk3KltwcTmicgV7Y=
X-Received: by 2002:a05:690c:921c:b0:70e:2fd7:de8 with SMTP id
 00721157ae682-70e2fd710d6mr10753577b3.29.1748084512607; Sat, 24 May 2025
 04:01:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <fcfa4e63-e421-42d1-b6da-11d2d7d2dd95@oss.qualcomm.com>
In-Reply-To: <fcfa4e63-e421-42d1-b6da-11d2d7d2dd95@oss.qualcomm.com>
From: Josh Boyer <jwboyer@kernel.org>
Date: Sat, 24 May 2025 07:01:41 -0400
X-Gmail-Original-Message-ID: <CA+5PVA61i6upJES0Ex+fu=3te0nL5C6UsBzwdqqG71=D9cFz0w@mail.gmail.com>
X-Gm-Features: AX0GCFtakdGE72uU9Nz4698nzxMe14QZAD3v4jd7XJvJegpl_2qLoV6ELz6n7T8
Message-ID: <CA+5PVA61i6upJES0Ex+fu=3te0nL5C6UsBzwdqqG71=D9cFz0w@mail.gmail.com>
Subject: Re: [PULL linux-firmware] ath10k, ath11k and ath12k firmware ath-20250523
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Cc: linux-firmware@kernel.org, linux-wireless@vger.kernel.org, 
	ath10k@lists.infradead.org, ath11k@lists.infradead.org, 
	ath12k@lists.infradead.org, jjohnson@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Merged and pushed out.

https://gitlab.com/kernel-firmware/linux-firmware/-/merge_requests/561

josh

On Fri, May 23, 2025 at 1:08=E2=80=AFPM Jeff Johnson
<jeff.johnson@oss.qualcomm.com> wrote:
>
> The following changes since commit 3fbaee2775a4a6d44021aa035823a7388b0874=
fa:
>
>   Merge branch 'robot/pr-0-1747839277' into 'main' (2025-05-21 15:05:37 +=
0000)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/ath/linux-firmware.git at=
h-20250523
>
> for you to fetch changes up to 2e91d8c3c4bd34a27177180a38f62d3ba3c96031:
>
>   ath12k: WCN7850 hw2.0: update to WLAN.HMT.1.1.c5-00284.1-QCAHMTSWPL_V1.=
0_V2.0_SILICONZ-3 (2025-05-23 09:50:02 -0700)
>
> ----------------------------------------------------------------
>
> This is an update to the WCN7850 firmware that fixes the widely reported
> failures due to the prior version in ath-20250424.
>
> ----------------------------------------------------------------
> Jeff Johnson (1):
>       ath12k: WCN7850 hw2.0: update to WLAN.HMT.1.1.c5-00284.1-QCAHMTSWPL=
_V1.0_V2.0_SILICONZ-3
>
>  WHENCE                        |   2 +-
>  ath12k/WCN7850/hw2.0/amss.bin | Bin 6082624 -> 6078528 bytes
>  2 files changed, 1 insertion(+), 1 deletion(-)

