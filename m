Return-Path: <linux-wireless+bounces-26225-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 76C2CB1E7A4
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Aug 2025 13:46:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AFDE166B7E
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Aug 2025 11:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9819E26FA4E;
	Fri,  8 Aug 2025 11:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I8NYN2fm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73E6A256C73
	for <linux-wireless@vger.kernel.org>; Fri,  8 Aug 2025 11:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754653561; cv=none; b=ASZCTlO/WPbR+u/jkDfy5xXH3sem0bR1oTNWJOzTtbfPr5rThd3AqKX14eUKwZLvgpt5nyonwleIUt6UKs5kuKBexG/NrOLlPLq4EpXn9n1RdIA+fBNFJ8IWxBFGe4c+3CXfmEkIuIzePWJv0iWe3vOKPgS7bQ4HgHLCIx5tVOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754653561; c=relaxed/simple;
	bh=YwgJ4W0yz/3U7CZDEb+pmN3xlnIzTMSoc9qyKFnxOfQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kLCP2MIp2WUS8R+csobMcXCN3IB1qXmJXrYQFX/EDDepkQgb79UAV89CodGNwBhhUGo9YnrI9lZJUXcvhl1It6AXdsU/7p1MXhqg1rb95qGuMAqPSzDjxhyiAFdcSlZJjV0qxcavXA1u3IIVDk7lFB8dCHvkC8luB6kg+ZeW7D0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I8NYN2fm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B55CC4CEF1
	for <linux-wireless@vger.kernel.org>; Fri,  8 Aug 2025 11:46:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754653561;
	bh=YwgJ4W0yz/3U7CZDEb+pmN3xlnIzTMSoc9qyKFnxOfQ=;
	h=References:In-Reply-To:From:Date:Subject:To:List-Id:Cc:From;
	b=I8NYN2fmgNFMtr67TFvKJS81k2mk4lRbgU/aLVNCBloZ2ky0dgUaPt59EWfC6HdGY
	 myj+Ny8SRdQfBSuW9xdKj3MHfkI+zOIT/rbEWpUNuj0Y7PwuRIj36Azdu9oXi8wvEt
	 5UxHWDlt1PcTiWrVuA8Vlva7f0c+6JtujG8hGEfqB9XvzClEgqhzS0RH/10PdwOZ1l
	 wsKWRh4lygemJzHFP+jP2/7+eILqVqe/I5wlwLQZzx/mNPu2OiZWxy1bo/ELAVWW3m
	 pJP/DhM9fsPVUIHTyToHxm5xGI4vCkWHgQ4YYee0NaWE+YkQwLnCnMrgqzJMEBVD5i
	 9/8PJa2xRkxgw==
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-71bd9e38af7so19874487b3.1
        for <linux-wireless@vger.kernel.org>; Fri, 08 Aug 2025 04:46:01 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUvw2p56K06YbhcO8dTgbKtTL8V3q0NiVyrDGpOKUO743so+KGKKX+c4mKKn9xNcpcT/img4pnXex8MPGnQaA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+b6rktlMQEbuLB4FTv6VeC09eaqPJoytvX3xDzxRWV4XO9GZr
	V1kHp1pWC50AlIFGDK+PZFBSA7ElMFZHb6qC9+lVO/gVoQ69/dAXt9IGRiNJQBtR9hVfbn+WkXp
	qhs5Aj1ef3om0QdXQf78mXJ/uo9PUqDE=
X-Google-Smtp-Source: AGHT+IFFl8Yogl/jKz3XpUVYcblZSE0Vjd1MxzRMkjBSnZJloREpmQubm0b1JY7EOyr/OXIxMNRYZLiJ0sdD+ACvgdI=
X-Received: by 2002:a05:690c:4989:b0:71b:6c7b:c802 with SMTP id
 00721157ae682-71bf0cddb9fmr32662157b3.6.1754653560280; Fri, 08 Aug 2025
 04:46:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6e3e8199-814d-4969-a951-d6b60f60257d@oss.qualcomm.com>
In-Reply-To: <6e3e8199-814d-4969-a951-d6b60f60257d@oss.qualcomm.com>
From: Josh Boyer <jwboyer@kernel.org>
Date: Fri, 8 Aug 2025 07:45:49 -0400
X-Gmail-Original-Message-ID: <CA+5PVA7RqfOjP612_Miy-JTp-56oi24utAV7pBtpjvejqw0aqw@mail.gmail.com>
X-Gm-Features: Ac12FXxkFAZR0HWfVSFeG8aD6tgL6AjCIDf1XZqFSufHmaZxsq5D_8VEwNwvaAU
Message-ID: <CA+5PVA7RqfOjP612_Miy-JTp-56oi24utAV7pBtpjvejqw0aqw@mail.gmail.com>
Subject: Re: [PULL linux-firmware] ath11k and ath12k firmware ath-20250807
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Cc: linux-firmware@kernel.org, linux-wireless@vger.kernel.org, 
	ath10k@lists.infradead.org, ath11k@lists.infradead.org, 
	ath12k@lists.infradead.org, jjohnson@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 7, 2025 at 5:43=E2=80=AFPM Jeff Johnson
<jeff.johnson@oss.qualcomm.com> wrote:
>
> The following changes since commit d30c7b425f6d9c9e9f54bcafa99b375342b3a7=
74:
>
>   Merge branch 'robot/pr-22-1754588181' into 'main' (2025-08-07 17:52:32 =
+0000)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/ath/linux-firmware.git at=
h-20250807

Merged and pushed out.

https://gitlab.com/kernel-firmware/linux-firmware/-/merge_requests/640

josh

>
> for you to fetch changes up to 35abebaa15c1ff1a141b7c24d79220ef70f48548:
>
>   ath12k: WCN7850 hw2.0: update to WLAN.HMT.1.1.c5-00302-QCAHMTSWPL_V1.0_=
V2.0_SILICONZ-1.115823.3 (2025-08-07 14:32:02 -0700)
>
> ----------------------------------------------------------------
> Jeff Johnson (6):
>       ath11k: QCA2066 hw2.1: update board-2.bin
>       ath11k: QCA2066 hw2.1: update to WLAN.HSP.1.1-03926.13-QCAHSPSWPL_V=
2_SILICONZ_CE-2.52297.9
>       ath11k: QCA6698AQ hw2.1: update to WLAN.HSP.1.1-04650-QCAHSPSWPL_V1=
_V2_SILICONZ_IOE-2
>       ath11k: WCN6855 hw2.0: update board-2.bin
>       ath12k: QCN9274 hw2.0: update to WLAN.WBE.1.5-01651-QCAHKSWPL_SILIC=
ONZ-1
>       ath12k: WCN7850 hw2.0: update to WLAN.HMT.1.1.c5-00302-QCAHMTSWPL_V=
1.0_V2.0_SILICONZ-1.115823.3
>
>  WHENCE                              |   8 ++++----
>  ath11k/QCA2066/hw2.1/amss.bin       | Bin 5349376 -> 5349376 bytes
>  ath11k/QCA2066/hw2.1/board-2.bin    | Bin 685144 -> 745408 bytes
>  ath11k/QCA6698AQ/hw2.1/amss.bin     | Bin 5140480 -> 5005312 bytes
>  ath11k/WCN6855/hw2.0/board-2.bin    | Bin 6429240 -> 7056532 bytes
>  ath12k/QCN9274/hw2.0/firmware-2.bin | Bin 15392824 -> 15183928 bytes
>  ath12k/WCN7850/hw2.0/amss.bin       | Bin 6078528 -> 6082624 bytes
>  7 files changed, 4 insertions(+), 4 deletions(-)

