Return-Path: <linux-wireless+bounces-15838-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DC4D9E0F67
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Dec 2024 00:49:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1EF9B2226F
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Dec 2024 23:49:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DB501DFD80;
	Mon,  2 Dec 2024 23:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mpoxTxFd"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D0FB1DF972
	for <linux-wireless@vger.kernel.org>; Mon,  2 Dec 2024 23:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733183382; cv=none; b=CZtGlGFg9yiAb5FV605YPO9dvuKAO90w47TuwisO+6RJk/yezeonDJqj5wKaf/W6VaNPdoTUOEv1LYmwe0Q0OoQmu7rpab01xL4hjseZl42RivPy3XN460eNsc+SHRUaX9gJI05+qW2J0T8KtEHTCIIQ6DOtMApOkoitLVPorYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733183382; c=relaxed/simple;
	bh=030Lr2uBlPApQpK+RsVmnSP5J3APa3CYpYGVR3knTOw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XjAB9Bcb8ouErgpwa1A+UJsxPrbgufE7+wTutIZRtwfi5C4NVaogfDIdv2x3xVy03IySiSgffqJbIQj5NQ2ML1uQ/0fFqHplGjYWm15vvTsSLSOkZNVtUNRT74ovHzCxRSWfyBaPwq3kWE4p2FmPZkNkaQrcW/tKxFCb0FcHI+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mpoxTxFd; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2ee74291415so1990337a91.3
        for <linux-wireless@vger.kernel.org>; Mon, 02 Dec 2024 15:49:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733183380; x=1733788180; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=030Lr2uBlPApQpK+RsVmnSP5J3APa3CYpYGVR3knTOw=;
        b=mpoxTxFdL6c7rkQEQWYQoY7vmsno+KRjMHgA3mD8VEeXMGHzhcTM2XRUHjpt/Vj15F
         erQABVaOZmls5Bz3oGmCvCA2gg7TCWJR1ZshZ6s0274UKhExYrKFS8UHH6hnZsCrSb/h
         E8NeNOpNsJpuJai0e70j8MEDx5jMmL/tI7NXqtPhXIL073AiTpbZm+92XZoEjlQauugE
         MKxm8Zo4LfjB2C7DaXRpoGADdAUkT6r+FVSkoWn3teab5dhxe/4sXso4tqbIbYl69Qn0
         WZVI98YYQ0GngQVi8BGzHm09W4fZOX1za7iPKCnekCRxxebpZfMm1E9yqqLPphpeahqK
         ifmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733183380; x=1733788180;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=030Lr2uBlPApQpK+RsVmnSP5J3APa3CYpYGVR3knTOw=;
        b=IZsHXMZ37sOGERYx2FIHh++FY0MHY6ou5npbNywFry9N/wN8CpIWUm12Ok/FLfMmFe
         5IBRkxsB/DZiCQDXVJ5qMg6TTCUpBvlHLdwT0BtD8+IWate5DX1p1vC+L2NMis9ixXRi
         lKOqkx4paZuizjxMeZ6kN68Zy0iBgClkxwSY5YS65UbinipNuso152lE1z1kaFoDFIn5
         wj7YpizBBLPC9/Hw7ZF/j2p4JVRmdme9WiEnN81TtOZR+2MeKBTs7K45udFvPgNfQoDy
         sfJkhi6L2bRJtto00+mD79H3sMecU91eXBEgiYpmX2oZnLm+5JLSMrI4geHpHhW1/ZOa
         Lsng==
X-Gm-Message-State: AOJu0YzVUcHFuDC46R+yCH+rTLPp/Ptwsywc2LRY1kZKtsBSkPgiMhag
	XuXGuof+baZCNEomihGWWaqB435a2+X+Lk1HfxBtUfiVuqWT+spzUFQ55CQQiTi5jQswZWF2pik
	+Q/ZuMM/x7fQLXRKIudpaeK2uXr0=
X-Gm-Gg: ASbGncv6imBE+0YdnmTF/faB2GKUxKOwVRj1yS5LKO36/aRne4IgVWKpTr+LLkYY5Yg
	/aqAyd+4s//W6gUjWdWk9M/n0V95IhOl+GQ==
X-Google-Smtp-Source: AGHT+IGFGI6lxGZFYz/CwnA2xA/qyP6jMULGfd4sW4NG9SAiN+JVyevwkruNg/k5T2N0x1JJa0pSWcsGe3HntYcpKDA=
X-Received: by 2002:a17:90b:4fca:b0:2ee:e961:3052 with SMTP id
 98e67ed59e1d1-2ef01201297mr814633a91.14.1733183379881; Mon, 02 Dec 2024
 15:49:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAG17S_P=bz0DFU71jEnV4RkT-Vxwvb2GpPwvLnjmD_n=2hLfUw@mail.gmail.com>
 <19388725ac0.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
In-Reply-To: <19388725ac0.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
From: KeithG <ys3al35l@gmail.com>
Date: Mon, 2 Dec 2024 17:49:28 -0600
Message-ID: <CAG17S_MJZ4VHvXiGj0qoimfQ8GLE6OEZe4DHZLx0H+0U_1X4pQ@mail.gmail.com>
Subject: Re: brcmfmac: Unexpected brcmf_set_channel: set chanspec 0xd022 fail,
 reason -52 - Part 2
To: Arend Van Spriel <arend.vanspriel@broadcom.com>
Cc: linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Arend,

Yes, I can build and test patches.

I will build a current kernel version tonight and will then be able to
add any patches you may develop to address this issue.

If I may ask, could you also patch the WPA3 External_Auth
functionality as well? I can test patches to that as well.

Regards,

Keith

On Mon, Dec 2, 2024 at 11:36=E2=80=AFAM Arend Van Spriel
<arend.vanspriel@broadcom.com> wrote:
>
> On December 1, 2024 10:55:26 PM KeithG <ys3al35l@gmail.com> wrote:
>
> > This floods the journal of my Pi ev ery 6 seconds:
> > Dec 01 15:51:30 pi5 kernel: brcmfmac: brcmf_set_channel: set chanspec
> > 0xd022 fail, reason -52
> > Dec 01 15:51:31 pi5 kernel: brcmfmac: brcmf_set_channel: set chanspec
> > 0xd026 fail, reason -52
> > Dec 01 15:51:31 pi5 kernel: brcmfmac: brcmf_set_channel: set chanspec
> > 0xd02a fail, reason -52
> > Dec 01 15:51:31 pi5 kernel: brcmfmac: brcmf_set_channel: set chanspec
> > 0xd02e fail, reason -52
> >
> > Is there something that can be done? Is there something I can help
> > with to fix this? I can test on multiple Pis, but cannot actually code
> > anything. Is this going to wait for the new infineon driver
> > development? The latest kernel where this has been seen is:
> > Linux pi5 6.6.62+rpt-rpi-2712 #1 SMP PREEMPT Debian 1:6.6.62-1+rpt1
> > (2024-11-25) aarch64 GNU/Linux
>
> You can build and test patches? Is it only those specific channels as
> listed above? Those are pre -802.11b allowed in Japan. I don't think any =
of
> the brcmfmac devices actually support those channels.
>
> Regards,
> Arend
>
>
>

