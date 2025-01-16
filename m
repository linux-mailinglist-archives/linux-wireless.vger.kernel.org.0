Return-Path: <linux-wireless+bounces-17598-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7E7CA1398C
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Jan 2025 12:59:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 00D5F7A41CC
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Jan 2025 11:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3070B1DE2BE;
	Thu, 16 Jan 2025 11:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B+Sc4o09"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B6E919FA92
	for <linux-wireless@vger.kernel.org>; Thu, 16 Jan 2025 11:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737028761; cv=none; b=HgmcbMdxjJgM/QaRmREMnOnjh6nTgiX0UktNCGx8FPjEWSX1a3aCk1k8lYFq+GiE1zc4jr8pqUlli1J4soZzIp7bgyAaOtZdIwFxQ3VH8LQednHcq01p9R3aEJ7/rRep1SZ+cElhGhb3LR8MZqHMFtq+uIyWXoJfHMzE1W1oem4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737028761; c=relaxed/simple;
	bh=XxMfDiJW7EnW4WvRbo3d2krzQIkID6cBIBy3wfgJq14=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O4pa+aMp12hC0GEKefO35JieVqRk+kaljGrSFeisJh+5TZ2W+uSzBiqlhVIjctWtXZHUOh3Y0/l1BjnSfkMBGBF7kKEtTaXvSlvFOcR0s9ykR4ku3/3+NeYPhtvKDf/d0067ymrhvA6eKKUOmKA/YOakUCOhNERz3oRvwcFok0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B+Sc4o09; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D837C4CEDF
	for <linux-wireless@vger.kernel.org>; Thu, 16 Jan 2025 11:59:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737028758;
	bh=XxMfDiJW7EnW4WvRbo3d2krzQIkID6cBIBy3wfgJq14=;
	h=References:In-Reply-To:From:Date:Subject:To:List-Id:Cc:From;
	b=B+Sc4o09RH02vVclWL1rRg8QL9e1y8JDdH1/B4PtZMs/1ZsUtDiqgaL0i/d0dAQ5p
	 0gfQZzNvl0KrxVklgCuxgOr5lGcNxk5B908DEJf5x66EkZmdn5KfRnsfrYOdels4gz
	 hhqItF9eCilPt7UxMs4HQz10mejmERAcZwC7Cqhi/zWA5KmX85X3xsmnfRDsAKdOk/
	 Q3Dpl10vEhsehGKuTR+jjwsuy/LCvBDgmz4ip8xmRQvQPCgQ9Q8QnxSjAT0MHmXB4o
	 fnTBF1+IVnP2egfOctPQr/RZ3Ed7xrwZrF52J8MXWm/+JbEpbnQwO0P103EBXgO4FS
	 3IXUKXnIPSZig==
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5d3f65844deso1369395a12.0
        for <linux-wireless@vger.kernel.org>; Thu, 16 Jan 2025 03:59:18 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWzqUOxASRgxalNGbjyAi46WgzXHWucrtiCLiWFioaPRjjIgaxFZ4P6gGn5FtUn1gOeFG34IwWIeO63LhYGfg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxvDDDeumH0TBZ+1wpBrVoI/4noDfIWfDLxIrXEEljnfUsqe1Z3
	aeo7Ffinjo7kSk/FcMi2WpmjCq7kvYAS0VqcoQ/hRbS98Pc3B2kGLjBiCfTC77iHZABKJfBwYFP
	9Nwwovi9yzZJlhyR/6ktrJ1R8dII=
X-Google-Smtp-Source: AGHT+IGDyT4bZb4xIo2DjV3d7+rg3m9XzVpUJ3QYWXuhQ94hQJdd+NEdfASEiD1yBXpJLXe4SnCqlkEA78zwafjdJmo=
X-Received: by 2002:a05:6402:26d3:b0:5d9:a59:854a with SMTP id
 4fb4d7f45d1cf-5d972e07f98mr31517607a12.13.1737028757096; Thu, 16 Jan 2025
 03:59:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <82c98b21-326f-4694-86cb-5d6af04a9166@RTEXMBS04.realtek.com.tw>
In-Reply-To: <82c98b21-326f-4694-86cb-5d6af04a9166@RTEXMBS04.realtek.com.tw>
From: Josh Boyer <jwboyer@kernel.org>
Date: Thu, 16 Jan 2025 06:58:59 -0500
X-Gmail-Original-Message-ID: <CA+5PVA7+vovudJLEip6P6gcZwDzzFvL2CQfd9ij32aXUvgtp=A@mail.gmail.com>
X-Gm-Features: AbW1kvZzBZmKaqFTbcNZuMdBTb3k0xA_zkyQhpZ_zReGMvVIm39tO4lbEcKAEno
Message-ID: <CA+5PVA7+vovudJLEip6P6gcZwDzzFvL2CQfd9ij32aXUvgtp=A@mail.gmail.com>
Subject: Re: pull-request: update rtw89 firmware by rtw-fw-2025-01-12
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: linux-firmware@kernel.org, linux-wireless@vger.kernel.org, 
	damon.chen@realtek.com, phhuang@realtek.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 11, 2025 at 8:42=E2=80=AFPM Ping-Ke Shih <pkshih@realtek.com> w=
rote:
>
> Hi,
>
> Update rtw89 firmware including RTL8852B, RTL8852BT, RTL8852C and RTL8922=
A.
>
> Thank you
> Ping-Ke
>
> ---
>
> The following changes since commit 7673dffd5e3324a726caf8bfc0f1a005862f5f=
16:
>
>   Merge branch 'robot/pr-0-1736442209' into 'main' (2025-01-09 17:11:19 +=
0000)
>
> are available in the Git repository at:
>
>   https://github.com/pkshih/linux-firmware.git tags/rtw-fw-2025-01-12

Merged and pushed out.

https://gitlab.com/kernel-firmware/linux-firmware/-/merge_requests/406

josh

>
> for you to fetch changes up to f495ed8a143a4e1844cd18f875c82f2823843d02:
>
>   rtw89: 8852b: update fw to v0.29.29.8 (2025-01-12 09:33:44 +0800)
>
> ----------------------------------------------------------------
> Kuan-Chung Chen (1):
>       rtw89: 8922a: update fw to v0.35.52.1 and stuffs
>
> Ping-Ke Shih (3):
>       rtw89: 8922a: update fw to v0.35.54.0
>       rtw89: 8852c: update fw to v0.27.122.0
>       rtw89: 8852b: update fw to v0.29.29.8
>
> Po-Hao Huang (2):
>       rtw89: 8852b: update fw to v0.29.29.7
>       rtw89: 8852bt: update fw to v0.29.110.0
>
>  WHENCE                  |   1 +
>  rtw89/rtw8852b_fw-1.bin | Bin 1242808 -> 1244784 bytes
>  rtw89/rtw8852bt_fw.bin  | Bin 897512 -> 913992 bytes
>  rtw89/rtw8852c_fw-1.bin | Bin 2180616 -> 2375560 bytes
>  rtw89/rtw8922a_fw-3.bin | Bin 0 -> 1725278 bytes
>  5 files changed, 1 insertion(+)
>  create mode 100644 rtw89/rtw8922a_fw-3.bin

