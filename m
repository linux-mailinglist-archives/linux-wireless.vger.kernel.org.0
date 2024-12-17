Return-Path: <linux-wireless+bounces-16435-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FF859F3FBD
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Dec 2024 02:08:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E33B8165B85
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Dec 2024 01:08:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B550A134BD;
	Tue, 17 Dec 2024 01:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="S9B9a/Jf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B19644EB45
	for <linux-wireless@vger.kernel.org>; Tue, 17 Dec 2024 01:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734397716; cv=none; b=ejQYIU+xjadGJ05OkeujiZLTYFLQk9S3TrqDSSqh9elDVGA8qdx+A1fEcfolkuf3dAhfIu5pJvhij6l7kSD8qH+g35PH3KfymF9W4ybE7Gzl0PuwfPSP1nHKihmPoYtMbP8WbuzmxVQWDv0tqL7eRM5dua5jn3TA9T8m9EXgHw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734397716; c=relaxed/simple;
	bh=5j6iT2zeBprglLkGjsx781QuAZzbfmuFvWgXrzwhfk0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cW9FEc6Za+/T7o/mx6KieE/ye1dmIgzGb6eCOz6+vKGPB55DRH8H8sVfQDtyLcEiP+K4+3roEAUHUDd8gN2w7qugpfqbRauC0jmMsJc0S5WPonHByD3zKykg8GQu7PHV5sKo6KqM666SIm7Ef+tZ1sQuyM2Ec3KfHlHTlQCu0IM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=S9B9a/Jf; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-aa6b4cc7270so640813366b.0
        for <linux-wireless@vger.kernel.org>; Mon, 16 Dec 2024 17:08:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1734397713; x=1735002513; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=x5HbsH3y11AUtX77RP9ShUJxU46vkQ8YNLD+VoIrduA=;
        b=S9B9a/JfOu4dceFJkqv/IlkRzbeItpl78nr/Z8ktTpCZmz2A//DQvPf4Jt8JV0Fl/e
         dxqrgzzi9YvgEgTxEXwOmAqmZY5VURR7knXCcRWkLvZJXH6q/YlIJIwHvKxlsERSzVIt
         ThDXeYowbAMaMrlGYAb72HDGR/MgPTo+GpuNo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734397713; x=1735002513;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x5HbsH3y11AUtX77RP9ShUJxU46vkQ8YNLD+VoIrduA=;
        b=YWzw/jlip7Rs9QOhI0IeJHEglPt2U2ZbnjeqTOFUOEB34H5XuLNNwUltWO3wJOaqnL
         bvGpGm3ILvXCQvUQFFk4/GiIpfbnDCJbIaqkKQzmznKTTj13t0hiRzyN/kXDuHXvHj9y
         EPqbQvMwjWznR+cqDtdlylRhL3e6s5Ijg52rQFNd4696Mm63cAWXCtsfbViR6KKsy6Sv
         le/NQ7BWXqp57azqQ1hvu46AZsNpaTtPC9/ssHTjx5RrZP5LurCQVJodzG5C2yE3iMUy
         qq9tN9LLCeOjb9+N163e4MxtoKYuel2CSfrHNUxf8WbKHtj+I0DdvOp39zgzCvikg4Kl
         yVBg==
X-Forwarded-Encrypted: i=1; AJvYcCXx2Rq+lhDSFn0+WSdUi3tuNAUGmlTp7TEF1YkNPO7MM8OIUpkVtfxHGPy9NUxnpjI0sNqqCMh+O0otNcYHgg==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywbw6KagMjdLJTJeg/PitnddzwFPw/cBJfU3sv09nyiERzPpO5X
	e9CohZCrSCU8S7Rvix3wkVgEwTXH896MQZBaNPyJ2EKZGo2svIdEzYu7mqDU1dYgwXgjzRFCu6M
	F/4k=
X-Gm-Gg: ASbGncsJmEvYlice19J7YmqRo1iWIpixYIuH5SBaOz8IsrrsNV35fsaWpRRWZpo/vbM
	tvhjMum/Oi1GPyIFuyelDshUTZ/cHm8DPsxTq2DWsw/n0AKL+i0bnv7wS9hhU5sJXkoo+nhPzqd
	jIelxVOp9lqneenC5tgAjX1tB7NtuY78tstwjo0S25VZnjU5QtWF2Pl/39ge8UB/WwJXWOWAt2Y
	EBA/GFTewJYj2jzfFhtSzwDjw1J8ObbtATsLI4WexYW+9GsfaJeayjjKcB1q/yddOSd5ppRXbSd
	UcroluQqcDKBPpxzOBRfXTdkYCU5efE=
X-Google-Smtp-Source: AGHT+IGNLxusDpMmnjZbQsHz3Ug36bkHEV1XxB7eRUlOMZKlwW1871jzYkFUx5DBH55ShhgSZrXQVA==
X-Received: by 2002:a05:6402:2696:b0:5d0:fb56:3f with SMTP id 4fb4d7f45d1cf-5d63c31dc49mr34322185a12.12.1734397712901;
        Mon, 16 Dec 2024 17:08:32 -0800 (PST)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com. [209.85.218.47])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aab960062a4sm388031766b.32.2024.12.16.17.08.30
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Dec 2024 17:08:31 -0800 (PST)
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-aa6b4cc7270so640809666b.0
        for <linux-wireless@vger.kernel.org>; Mon, 16 Dec 2024 17:08:30 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWtXURBBXVH3W11lMxP5J6r4sh/vuPYhiXskyQA5V7QK5VyJDQK8geFN/R+KxAz1Mzng2yewiwzFfyVku3ujQ==@vger.kernel.org
X-Received: by 2002:a05:6402:27d4:b0:5d0:d91d:c197 with SMTP id
 4fb4d7f45d1cf-5d63c3db906mr36599487a12.27.1734397709817; Mon, 16 Dec 2024
 17:08:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241213054610.55843-1-laoar.shao@gmail.com> <20241213054610.55843-6-laoar.shao@gmail.com>
In-Reply-To: <20241213054610.55843-6-laoar.shao@gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 16 Dec 2024 17:08:13 -0800
X-Gmail-Original-Message-ID: <CAHk-=wj=W-4Eu=g83QPUDB+thtL=uY=_1OAVRvXJP=zay+K4Qg@mail.gmail.com>
Message-ID: <CAHk-=wj=W-4Eu=g83QPUDB+thtL=uY=_1OAVRvXJP=zay+K4Qg@mail.gmail.com>
Subject: Re: [PATCH 5/7] security: Replace get_task_comm() with %pTN
To: Yafang Shao <laoar.shao@gmail.com>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, x86@kernel.org, 
	linux-snps-arc@lists.infradead.org, linux-wireless@vger.kernel.org, 
	intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org, 
	nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	ocfs2-devel@lists.linux.dev, Kees Cook <kees@kernel.org>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 12 Dec 2024 at 21:47, Yafang Shao <laoar.shao@gmail.com> wrote:
>
> Since task->comm is guaranteed to be NUL-terminated, we can print it
> directly without the need to copy it into a separate buffer.

So i think we should do the "without copying into a separate buffer"
part of this series, but I do think we should just accept "%s" and
"task->comm".

IOW - getting rid of get_task_comm() is good.

But the "%pTN" pointer format ends up being unnecessary.

          Linus

