Return-Path: <linux-wireless+bounces-27523-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 124AEB89FAA
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Sep 2025 16:32:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EDBCD4E1EF7
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Sep 2025 14:32:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 538DE315760;
	Fri, 19 Sep 2025 14:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PWbawacu"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FA28314D33
	for <linux-wireless@vger.kernel.org>; Fri, 19 Sep 2025 14:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758292320; cv=none; b=sg3wzHk9Ba8dyi95uASeH0IZWDU+cnae1wwyGQydJ5lzIYe5TjtwUmpkDmQIMAVrKRPxYseyvDEzZGregBuUn0dQdEhhuSgRiEKlSG2CEXKveYCj+vMvLnvm8YysCVTzZ/GCAoQMK4+FPLbNWhcaq2DcGjtib07ClcB0TUVOTww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758292320; c=relaxed/simple;
	bh=ezfOU/1GMLWeqS+bjgy1ZwWTdgQNEIEBXo9J8JeXB8E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EJPSf4QxZya0PHhZPRfNqx+7T+Peeyk2hv6gFN9V+9zSknmRLogGEBl7nHBqRGwExxct9Nc9XNkLuNB5HkqUYgcjkaKh3u0vMGbqrPRW5UqZuAyFdcM2vn1tT7HmPFFAvIvkYnNALDg+NLj2scNaW/6etVd5IpN25Bes6DY1Jrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PWbawacu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10D20C4CEF9
	for <linux-wireless@vger.kernel.org>; Fri, 19 Sep 2025 14:32:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758292320;
	bh=ezfOU/1GMLWeqS+bjgy1ZwWTdgQNEIEBXo9J8JeXB8E=;
	h=References:In-Reply-To:From:Date:Subject:To:List-Id:Cc:From;
	b=PWbawacudtOvyg3vVGMGGiOmwoIFBIWIpS9HPm2TganW/fRXX3vsJHZeKnS3jXOom
	 gDL7CLSKgSsw3JQo0g/8COHi6z+zdCIJk2uw+N4Nfzg/OunR+SOncvYiqLfqqdYh3y
	 ttqgmqxCm1waPpj3R3bwIrRP4fqjW/BcLgeScPBAQDohAOenjnzccsjU3OgEuiPCd7
	 J4alQTbXJ4fzC1B7vJh0MZUdfstGZnJb58f6EeOP7V95ncI20Y6CIy9YOowCB4cAH9
	 XS9VrF7uOLYRujPTj3cHxUFtvFjGAFHTgTuy9sxhYs5Oobg5tmj17uAlZr5wZnCRbC
	 XJrUZ18mNBkRg==
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-72e565bf2f0so18475217b3.3
        for <linux-wireless@vger.kernel.org>; Fri, 19 Sep 2025 07:32:00 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU+tYEYl6PSKtQ+JNOPOt+VMoQq3yoAsjwXtip2+ylSqo5AEWaeUQwJKW4ofpKFV+2q0qcRZSbcc35uwRcIEQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YydxS4VIrO8Oepw9Gjr3beuFWLdm6eB0SfXKvsVkE77LZaYotWv
	lZQHPg2kq5Z3PuUzu2ismIzS6dZxSE5+Fw2jkOSSC+N1ymrDRXKNDdub5G7gQP0ZX7Z3mPGFpU3
	hKQrRMfHM/b2QtdyWXjU5IP9dZL7C4h0=
X-Google-Smtp-Source: AGHT+IFCQN6I/KYO7xVrBSNFPDc5Kyac3QZX8xN90CS+V124H8ksRuV/W1kaFUkMgoZAWdeH1sqzdd0wvkGzwsWpr9w=
X-Received: by 2002:a05:690c:5092:b0:734:81db:1b33 with SMTP id
 00721157ae682-73d3237e749mr28124147b3.19.1758292319285; Fri, 19 Sep 2025
 07:31:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <9cadcd6a-5f99-4a2f-8aac-c612f355d82a@oss.qualcomm.com>
In-Reply-To: <9cadcd6a-5f99-4a2f-8aac-c612f355d82a@oss.qualcomm.com>
From: Josh Boyer <jwboyer@kernel.org>
Date: Fri, 19 Sep 2025 10:31:48 -0400
X-Gmail-Original-Message-ID: <CA+5PVA446=RjjQpbAeiZYVeX-PAx1MrPVU_yPnOtOyuoJjLxDQ@mail.gmail.com>
X-Gm-Features: AS18NWB_2BdrTn8cn6c5KQ00nGtZALj68uPuOx4rGtGAkFYLcFDgRu_jI6sPALQ
Message-ID: <CA+5PVA446=RjjQpbAeiZYVeX-PAx1MrPVU_yPnOtOyuoJjLxDQ@mail.gmail.com>
Subject: Re: [PULL linux-firmware] ath12k firmware ath-20250918
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Cc: linux-firmware@kernel.org, linux-wireless@vger.kernel.org, 
	ath12k@lists.infradead.org, jjohnson@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 18, 2025 at 2:17=E2=80=AFPM Jeff Johnson
<jeff.johnson@oss.qualcomm.com> wrote:
>
> The following changes since commit 37f3f2d8e14cff7b316616924331d57f6ec6e2=
59:
>
>   Merge branch 'robot/patch-0-1758163077' into 'main' (2025-09-18 12:26:2=
2 +0000)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/ath/linux-firmware.git at=
h-20250918

Merged and pushed out.

https://gitlab.com/kernel-firmware/linux-firmware/-/merge_requests/696

josh

>
> for you to fetch changes up to 1d588f106ceea113c4c650b43d948da5746e704c:
>
>   ath12k: WCN7850 hw2.0: update board-2.bin (2025-09-18 11:03:58 -0700)
>
> ----------------------------------------------------------------
> Jeff Johnson (1):
>       ath12k: WCN7850 hw2.0: update board-2.bin
>
>  ath12k/WCN7850/hw2.0/board-2.bin | Bin 1986952 -> 2253732 bytes
>  1 file changed, 0 insertions(+), 0 deletions(-)

