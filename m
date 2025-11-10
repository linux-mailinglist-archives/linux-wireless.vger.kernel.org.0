Return-Path: <linux-wireless+bounces-28815-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 71BDDC4964C
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Nov 2025 22:23:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5E9154E15A6
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Nov 2025 21:23:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3ADE2FBDE6;
	Mon, 10 Nov 2025 21:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HCoXzJmZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CCAE2FB963
	for <linux-wireless@vger.kernel.org>; Mon, 10 Nov 2025 21:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762809835; cv=none; b=LJHbHeWH/aw/UVd8eC30IdQdNnyFMcvhiJn1SX0qoRuka5m14yNTwUAnU9RM0gbG142bZSItuxfl9iapQivR00h5oorbFJFDpQJyb7Nt2qWiXrKB/Wf084KPUDsVvYrEB+7EJymLQ0j3WBMcEGHmgOX96+tqOhYiROoCHBeLgtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762809835; c=relaxed/simple;
	bh=2uGReqIQ5kWbuGEQi0JCJuK28kv/W/bpv+JazgIidks=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QALDZqXYFN2OH86qFvLcaJTUVFmmdD9QPXYbgrRefZ0mOfrR+wNWhkCoLmptCKZEIFgEiEWBLIA36ttXGxespKXrmapJxhIQKQtqqTpyUllwt4/zg0p89ENFZGOIrZQ83z/SxXze7SwYID1OKxW9X4ZBxz8fWPmwTCELfE/8Ufw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HCoXzJmZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1B32C2BC9E
	for <linux-wireless@vger.kernel.org>; Mon, 10 Nov 2025 21:23:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762809835;
	bh=2uGReqIQ5kWbuGEQi0JCJuK28kv/W/bpv+JazgIidks=;
	h=References:In-Reply-To:From:Date:Subject:To:List-Id:Cc:From;
	b=HCoXzJmZfl/Ztx/RtRa2W3s2XUAmtut6t35v+8cU7U1Z8VvIZh09Z87CxhBz8uPO9
	 fh6eq4TT2C2b5th6iXRr7+axMI68JsKgkTOv8OmTNzdbLgmCnFHL0ptwh8SnEDfx2H
	 pEbwdcx5PYDTI0mM0SYWtQhjikjTYiuQNrE7BsQAlXljNNx/7VVC6WZIiYG9NZ7L0N
	 O1jmyuk4R4cnRgov3JdHrbgjbfl7gdG3XqO747Ph5crfw8k8xtLrUnI7X9sLC207sC
	 Tz+2n6ky+2RXZanm04/yloKgOu/u3iyyVchPpVsNEP6k0dkBmRzcOqeaTBW4y3xyoz
	 shL+IykzAW1Ug==
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-63fc6115d65so3427393d50.0
        for <linux-wireless@vger.kernel.org>; Mon, 10 Nov 2025 13:23:54 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXOp7+KeaGainOHf6w2r8Lx8quFKeq0Uqan3WoHm8ebBiTiA1z4cv+EZzZV96QVrnV/Y3BrHSxSaiSK0npW9w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2Kqe5PQEmvmOS2sl+iKJ0PNVdKarOvKMzTBgCGrHcF4xEJvms
	sYsc8S5SkW0JWSwUMklabX+q4GY2gz0adErWuZh+tLVzJMxV7LyT3svUUbfUDORNysCK5M2ofS+
	PtdIzuTPposnFBies4vGHZGk743enO7k=
X-Google-Smtp-Source: AGHT+IGX+znZnacsFVbU0Zgb44+4h1xrCYgDbNysK5l1c/inArGTxD9LZvvXF6De3CrDL3s3ktbsMJ1bMcPX1k7rbgo=
X-Received: by 2002:a05:690e:42d2:b0:640:cfa4:e8c9 with SMTP id
 956f58d0204a3-640d45f6586mr7942013d50.69.1762809833945; Mon, 10 Nov 2025
 13:23:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251109230315.6899-1-zenmchen@gmail.com> <aa1a0c67256f416584c9099496cc2aff@realtek.com>
In-Reply-To: <aa1a0c67256f416584c9099496cc2aff@realtek.com>
From: Josh Boyer <jwboyer@kernel.org>
Date: Mon, 10 Nov 2025 16:23:42 -0500
X-Gmail-Original-Message-ID: <CA+5PVA4AgS9xE0-TTYWg1R7XLJ2j3hJsbCH-BZ2JaJqz1++tCQ@mail.gmail.com>
X-Gm-Features: AWmQ_blQknKrVnUNNitrmQRxzmI8NTO6ZaZslRJXKhTNOBhXMnr6jB65mr9893k
Message-ID: <CA+5PVA4AgS9xE0-TTYWg1R7XLJ2j3hJsbCH-BZ2JaJqz1++tCQ@mail.gmail.com>
Subject: Re: [PATCH] rtw88: 8822b: Update firmware to v30.20.0
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: Zenm Chen <zenmchen@gmail.com>, 
	"linux-firmware@kernel.org" <linux-firmware@kernel.org>, 
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, 
	"rtl8821cerfe2@gmail.com" <rtl8821cerfe2@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 9, 2025 at 10:03=E2=80=AFPM Ping-Ke Shih <pkshih@realtek.com> w=
rote:
>
> Zenm Chen <zenmchen@gmail.com> wrote:
> > Sent: Monday, November 10, 2025 7:03 AM
> > This firmware was extracted from the vendor driver for RTL88x2BU
> > v5.13.1-30-g37e60b26a.20220819_COEX20220812-18317b7b from
> > https://github.com/RinCat/RTL88x2BU-Linux-Driver
> >
> > Signed-off-by: Zenm Chen <zenmchen@gmail.com>
>
> I confirmed the binary is identical as release version, so
>
> Acked-by: Ping-Ke Shih <pkshih@realtek.com>

Thank you.

Merged and pushed out.

https://gitlab.com/kernel-firmware/linux-firmware/-/merge_requests/776


josh

>
> > ---
> > Some people said this firmware fixed certain problems [1][2], so upstre=
am it.
> > Only tested with RTL8822BU, NOT SURE IF RTL8822BE/RTL8822BS WORK FINE
> > WITH IT.
>
> I tested RTL8822BE and no obvious fault.
>
> Look back into vendor driver, all interfaces use the same firmware, so I
> think it will be fine.
>
>

