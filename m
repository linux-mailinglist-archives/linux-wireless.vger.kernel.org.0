Return-Path: <linux-wireless+bounces-13086-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0868597EB91
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Sep 2024 14:35:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39AC21C213D0
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Sep 2024 12:35:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E2661714DF;
	Mon, 23 Sep 2024 12:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r4G3YxSP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19AA982C60
	for <linux-wireless@vger.kernel.org>; Mon, 23 Sep 2024 12:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727094914; cv=none; b=THXRP6HgjmQYJTQK5gjZ1Vc/D5ZoCgq/WM0MA2xCVIvaWFNQOvpG+SM5M0q6DZrofkmU/96RgvY4Wot+xBr62TXDodapsR3vpwYeqrOkKI2dMD1vudh23UTx0Y+7Gf8zQpYV9iZye5zINdRoss8kBVhkEQDDnmodp1sauyFbzO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727094914; c=relaxed/simple;
	bh=gYUyS7Zy83sLVLJ406QnRTLkFwRG+iZlkfHOIRWCOpo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NogWoZhWZEiFqkp6uubR9kp8upngPfnd4qXngKz4qG+55/CQrigqZsXIW1ImFXvUbXzwqjfe4n1Lw38Thp8Jk0jVd+xDASRTI7BzTd5WjNgwfo0HLCIPJXgTGfwXfP1PRy/uF2k9vAJchu6WxePxsDfSLSA3PVk2IB2B2hR/eE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r4G3YxSP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4DEDC4CEC4
	for <linux-wireless@vger.kernel.org>; Mon, 23 Sep 2024 12:35:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727094913;
	bh=gYUyS7Zy83sLVLJ406QnRTLkFwRG+iZlkfHOIRWCOpo=;
	h=References:In-Reply-To:From:Date:Subject:To:List-Id:Cc:From;
	b=r4G3YxSPPt276PjCoCMktxpVNx61DCRQIQad/XbE8nSSq2JlLMfaIFgyPOZ7aXjf9
	 gmyIiX7jFB97kIv5RJhyhij+JyHhnCdY1po8MLlae9VwkctaekWlVC7oAEfse9u7g4
	 NmSWeZnsb0j8RrTUEDDP91DulrgSM93j9CHsPPyKRQkkKGGTrO3oZUtDBRAhybJyQf
	 gOaBICUQ7KDzRmAnlCsIYJHWJpsKibitSQJkHDhGXmtPPSq3vLPW2cdo244tNnuS42
	 hr2x6E2bZwmBoRSt9rtPyTYUrz5z6AkuwvfhAFiEYgLAKlxLL684EXznFORE0l+X5B
	 nRvrrRSer8/nA==
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-6ddcce88701so37088007b3.1
        for <linux-wireless@vger.kernel.org>; Mon, 23 Sep 2024 05:35:13 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX3nnlWVTZOG//u3YZ1BgR3qeGlNt8OdlrBZyow6pxDiw3aUUsy1LY2UhA0+U9VTI7HKU+BnRe4gAHSrP7boA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxEKee6VdxvwIlcLL7vzHw3GEBoqMt8Cxrks2KXiQ16ty/jPSUz
	lfEYwTE9xJml9Q9Y4/G+DjrqBloyEDPp/Mdm3dX0oBOfuJEk1pbMNVC5uwmbLukJwfxWkkZlILj
	mTyOCvi6N2hiGs5KacSo807e8ISI=
X-Google-Smtp-Source: AGHT+IELMOj9emzteexxdV3fiRtRZPTcQ9NVan2r9uhwrNePXQXXSCv64Xfb9XnNJ09KH8N3H+9HvqjMIQ5J7d1dAL0=
X-Received: by 2002:a05:690c:338d:b0:6de:b23:f2a1 with SMTP id
 00721157ae682-6dff283be74mr91869217b3.15.1727094912977; Mon, 23 Sep 2024
 05:35:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <28a0ab5067a34a308c155f3ccc08790b@realtek.com>
In-Reply-To: <28a0ab5067a34a308c155f3ccc08790b@realtek.com>
From: Josh Boyer <jwboyer@kernel.org>
Date: Mon, 23 Sep 2024 08:35:02 -0400
X-Gmail-Original-Message-ID: <CA+5PVA7aVsf3-Peqxk0+gg=GsYYNtoOXfHrVY5wx9yR06r3HWQ@mail.gmail.com>
Message-ID: <CA+5PVA7aVsf3-Peqxk0+gg=GsYYNtoOXfHrVY5wx9yR06r3HWQ@mail.gmail.com>
Subject: Re: pull request: rtw89: 8922a: add fw format-2 v0.35.42.1
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: "linux-firmware@kernel.org" <linux-firmware@kernel.org>, 
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, Timlee <timlee@realtek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 13, 2024 at 3:34=E2=80=AFAM Ping-Ke Shih <pkshih@realtek.com> w=
rote:
>
> Hi,
>
> Add rtw89 driver firmware for RTL8922A that firmware version is 0.35.42.1=
.
>
> Thank you
> Ping-Ke
>
> ---
> The following changes since commit b9daf8c33f02650b79bd1c61d61d6b1fae470e=
8b:
>
>   Merge branch 'amd-staging' into 'main' (2024-09-12 16:05:08 +0000)
>
> are available in the Git repository at:
>
>   https://github.com/pkshih/linux-firmware.git tags/rtw-fw-2024-09-13

Merged and pushed out.

https://gitlab.com/kernel-firmware/linux-firmware/-/merge_requests/300

josh

>
> for you to fetch changes up to 5685e14f2a1cf8ce8ee2ab5883eb327c9c9c5d15:
>
>   rtw89: 8922a: add fw format-2 v0.35.42.1 (2024-09-13 15:28:58 +0800)
>
> ----------------------------------------------------------------
> Chin-Yen Lee (1):
>       rtw89: 8922a: add fw format-2 v0.35.42.1
>
>  WHENCE                  |   1 +
>  rtw89/rtw8922a_fw-2.bin | Bin 0 -> 1586954 bytes
>  2 files changed, 1 insertion(+)
>  create mode 100644 rtw89/rtw8922a_fw-2.bin
>

