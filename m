Return-Path: <linux-wireless+bounces-14145-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D0569A22B9
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Oct 2024 14:48:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D0B5B22E54
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Oct 2024 12:48:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8738E1D8E01;
	Thu, 17 Oct 2024 12:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lS6pBWXH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62B0C1DB92E
	for <linux-wireless@vger.kernel.org>; Thu, 17 Oct 2024 12:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729169304; cv=none; b=Rf6ZrLM/IbTmwilroPxknmn9deoINwG2m7GPyl+W+O9I4V9oe9AyH7NOrkWY8uFp70wK4NYK9MhZZ45UIgnDmgJmnkui88K1sL5df8yoY/Ag5GK4QigHU3YPYAd4enbwi7YAtgCmmUunohXVzIlPEtpLZwFbI7Gt3EBavgmakLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729169304; c=relaxed/simple;
	bh=yepe87Y/CVbpV5/zS4cGgBWtdIoO2PP5GNAR0TMVxf8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nGxAIUu/gttpY4G+Bl3tSjAWyqgqVGAd6h12xgSlQx9p34uTjdCsJRS+C02T8yl6FQJ33QduIe0FPeQ396vbcogxE9cHHUmlhp5aUW9Dy7EppY8iomx5Aj7TLlGvIpDerH6jLJxwtjq2MWMpdnl8/vW3mdr+28ZTf+WwDyavlH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lS6pBWXH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3889AC4CECD
	for <linux-wireless@vger.kernel.org>; Thu, 17 Oct 2024 12:48:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729169304;
	bh=yepe87Y/CVbpV5/zS4cGgBWtdIoO2PP5GNAR0TMVxf8=;
	h=References:In-Reply-To:From:Date:Subject:To:List-Id:Cc:From;
	b=lS6pBWXH0l/4SDhquiiWUzTsGcvxmMkcZ7GqK7EJ4ZuBvIxi4Po1twi049U+m3bov
	 EGOCoax/3H/F0gq4/Uk5+UA8VXr8PAj9UWE0lie169WzfMO78iBGmBRXlewnEeEfLq
	 +aCBzSJ9GU4pA/v+v3uROzaeJK4wmuXJ8KWxTqnb5w0ol5HsMRO484/vRBOFjW2LXF
	 WQcfchAWQg0JOq1GJSeLS4GFHYW02h5XWN3hS+L9pRJPJDR3UIJbJZLtLziNMuohT7
	 /ST7HRo9LB+PZyZzr0gdWXQDAFBELIop6W/e1cetuh7AG3eZwl25FZ5STL16ydfh9R
	 z3Up3zj7NbSFw==
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-6e3d97b8274so8991127b3.1
        for <linux-wireless@vger.kernel.org>; Thu, 17 Oct 2024 05:48:24 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXwoCwuJ6+C/l4W46KFi63s8PDK5956jUzoZVPRkY46KiKj9P/yQPfbf/ZGAS2hqZzrSoh2yUnUkdOZpqW6tw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7MNpYDI60G6OaLpoFQnryWYUQ8D3FLAQG/05pZ3huO6Bs58kt
	7hBFFhG5bh9UVZfpW7WiqH+RRFaMTUqbuEAOQZcF7P5nIIUHlJ2zz8mu1riYMGqNbTqtyu8WbGD
	J0zwailBBDMNmGyC75Spcrwx+0E4=
X-Google-Smtp-Source: AGHT+IF++RtsYXDXZDGbBctuItRfQ2HQSH2nBN9gBHJOhSQ3MzjcaJNEjE2hXwMiJJ066xI+f57g38m2KYY4UgzHCN0=
X-Received: by 2002:a05:690c:6609:b0:6e2:71b:150 with SMTP id
 00721157ae682-6e347b520edmr197351487b3.29.1729169303369; Thu, 17 Oct 2024
 05:48:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2e2e7eac86db45e8a1980021c7a3983d@realtek.com>
In-Reply-To: <2e2e7eac86db45e8a1980021c7a3983d@realtek.com>
From: Josh Boyer <jwboyer@kernel.org>
Date: Thu, 17 Oct 2024 08:48:09 -0400
X-Gmail-Original-Message-ID: <CA+5PVA7HSOLA_atsyvAn9n0=V=NnrB+6G+_yBtP=UVDLdtpXiA@mail.gmail.com>
Message-ID: <CA+5PVA7HSOLA_atsyvAn9n0=V=NnrB+6G+_yBtP=UVDLdtpXiA@mail.gmail.com>
Subject: Re: pull request: rtlwifi: Add firmware v39.0 for RTL8192DU
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: "linux-firmware@kernel.org" <linux-firmware@kernel.org>, 
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, 
	"rtl8821cerfe2@gmail.com" <rtl8821cerfe2@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 3, 2024 at 11:25=E2=80=AFPM Ping-Ke Shih <pkshih@realtek.com> w=
rote:
>
> Hi,
>
> Add firmware for RTL8192DU
>
> Thank you
> Ping-Ke
>
> ---
> The following changes since commit 95bfe086cd84966449dc0cba734bc582b988b8=
e8:
>
>   Merge branch 'mt76' into 'main' (2024-10-01 11:53:24 +0000)
>
> are available in the Git repository at:
>
>   https://github.com/pkshih/linux-firmware.git tags/rtw-fw-2024-10-04

This seems to be covered by:
https://gitlab.com/kernel-firmware/linux-firmware/-/merge_requests/314

josh

>
> for you to fetch changes up to f2894a5b7e30621d6bb2a3f8547451990bad3496:
>
>   rtlwifi: Add firmware v39.0 for RTL8192DU (2024-10-04 09:18:06 +0800)
>
> ----------------------------------------------------------------
> Bitterblue Smith (1):
>       rtlwifi: Add firmware v39.0 for RTL8192DU
>
>  WHENCE                  |  10 ++++++++++
>  rtlwifi/rtl8192dufw.bin | Bin 0 -> 31452 bytes
>  2 files changed, 10 insertions(+)
>  create mode 100644 rtlwifi/rtl8192dufw.bin
>

