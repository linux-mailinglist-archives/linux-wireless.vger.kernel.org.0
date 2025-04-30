Return-Path: <linux-wireless+bounces-22241-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD756AA49C1
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Apr 2025 13:26:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 868E21891588
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Apr 2025 11:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5FE91F0984;
	Wed, 30 Apr 2025 11:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q9TiAXZM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91CB42DC789
	for <linux-wireless@vger.kernel.org>; Wed, 30 Apr 2025 11:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746012399; cv=none; b=TZreZJDRoC3LS8xhI7bOpo7MB5XQBBN0ZKbroaXGOb6EDTGNqVOZx25vUBhqoWzuxiv07crPl8EPCYRIUuha6O5gGimfkrY+LmzTg/IjkgEDVnGB9ruKQaGvK+aCBwgKfk0Y6GJvMIgiZXgMdz/U9bMuctM9rKk3DSGr3kx6ePc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746012399; c=relaxed/simple;
	bh=hvlk/A3EFcxy5Esw13iMokdaD37nzD8BPPX3DiXr634=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=st99ljqOoR7KhJAynJZo+rUxACjbzlcBp0LNhp7/eHer5UkS3mMgxt4YkCG2JuTyY9HhZSTF3UJtl9o0UasZbc4a9gRzei9/P2+FEXM4suPFKylD2ZslyRqy7gKdp53Jsc3l+I3R/nPYpUPiwvemgLPDJAs/4dTTh8PLatq0LSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q9TiAXZM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 239F6C4CEE9
	for <linux-wireless@vger.kernel.org>; Wed, 30 Apr 2025 11:26:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746012399;
	bh=hvlk/A3EFcxy5Esw13iMokdaD37nzD8BPPX3DiXr634=;
	h=References:In-Reply-To:From:Date:Subject:To:List-Id:Cc:From;
	b=Q9TiAXZMQTY+RQbBq5EO7NX1T/MyOA3VotF0dJYEEd14YtxYaxUJZR1qEUzg9BxVW
	 zJdofIYIZyjrfH7A2Y73n8BeeB9F+FX2j030IUqBnYg/8wuXzAuYiIFQh4rpwD93Sg
	 gh4wCIF5sVpGT8/Vk4Y8HpBWpdsptEGubRxFs9D8iF7ycuSwKkiEpVRZIlIwTaxv+r
	 N4MbDBSIDxIqSaRW3eoySgzSRYtjCUww/dwTdLjsPpPSBMTul5l94/9gBl2FkDIAU4
	 mYxfhgcCzUsHycPtaIuol58ufV6DnpXZU1QW3ygFK+RSi6uHt1gNw+nI5iF8F4DFn8
	 ElRZ+yec0+CzA==
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-70427fb838cso59604717b3.2
        for <linux-wireless@vger.kernel.org>; Wed, 30 Apr 2025 04:26:39 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUIV/c3BMHNElre9A3TBT90uPKwPPdo1B9iBbNTsDs2RTfTKgEsAdu87mokDBYQCb0J28Rg2PlVvZbYrwDVJQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxLsrMQnNgnv5z2tQZ5sW/I/61ODn8NL6jQPPLK/zaqloEeIiDz
	BwDmGCVm3GpJNxK8kW/yzl1QUnWXfTsInQTmDi8lIJVljBi70PwuRJXYlrv3a4FhhULQtFpzvZE
	GIDArRMZvtgt2QiygjC4yfm3hFHQ=
X-Google-Smtp-Source: AGHT+IE1Dj2gOn/rE69apfbQO9akNFRBxKrfDPpxw273x9H+lLuE31wqAsXZeZu9K9Yax7AoMBjircFpeDVYP9mMuUc=
X-Received: by 2002:a05:690c:4d8a:b0:708:1d15:e008 with SMTP id
 00721157ae682-708abd6882amr45412947b3.13.1746012398406; Wed, 30 Apr 2025
 04:26:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <35d55e0b-8cc9-41f4-b48b-08d7e9f39f97@RTEXMBS04.realtek.com.tw>
In-Reply-To: <35d55e0b-8cc9-41f4-b48b-08d7e9f39f97@RTEXMBS04.realtek.com.tw>
From: Josh Boyer <jwboyer@kernel.org>
Date: Wed, 30 Apr 2025 07:26:26 -0400
X-Gmail-Original-Message-ID: <CA+5PVA6s+MR2ahwDE+9cBw6n7tnBseyGB4zJA75cXwb=NSWTpg@mail.gmail.com>
X-Gm-Features: ATxdqUGQ8XbL73UO-kgv5sSUpGNXew7NdzprqquaT-Rd5wGCUvH7so9o9VMh8UQ
Message-ID: <CA+5PVA6s+MR2ahwDE+9cBw6n7tnBseyGB4zJA75cXwb=NSWTpg@mail.gmail.com>
Subject: Re: pull-request: update firmware for rtw89 driver along with tag rtw-fw-2025-04-30
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: linux-firmware@kernel.org, linux-wireless@vger.kernel.org, 
	damon.chen@realtek.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 30, 2025 at 2:09=E2=80=AFAM Ping-Ke Shih <pkshih@realtek.com> w=
rote:
>
> Hi,
>
> Update firmware to fix problem of disconnection from AP, and add table
> for DAG mechanism.
>
> Thank you
> Ping-Ke
>
> ---
>
> The following changes since commit 0d104598cd5bfff9e1f1a3d0eb86568710cfb4=
a7:
>
>   Merge branch 'rock-pi-x' into 'main' (2025-04-28 13:14:38 +0000)
>
> are available in the Git repository at:
>
>   https://github.com/pkshih/linux-firmware.git tags/rtw-fw-2025-04-30

Merged and pushed out.

https://gitlab.com/kernel-firmware/linux-firmware/-/merge_requests/532

josh

>
> for you to fetch changes up to f56a4436ffe343c5e605050dd174a988950f0699:
>
>   rtw89: 8852c: add tables for dynamic antenna TXPWR (2025-04-30 14:00:05=
 +0800)
>
> ----------------------------------------------------------------
> Kuan-Chung Chen (2):
>       rtw89: 8922a: update fw to v0.35.71.0
>       rtw89: 8852c: add tables for dynamic antenna TXPWR
>
>  rtw89/rtw8852c_fw-2.bin | Bin 2411688 -> 2444568 bytes
>  rtw89/rtw8922a_fw-3.bin | Bin 1224798 -> 1238542 bytes
>  2 files changed, 0 insertions(+), 0 deletions(-)

