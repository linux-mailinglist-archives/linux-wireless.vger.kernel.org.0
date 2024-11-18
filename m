Return-Path: <linux-wireless+bounces-15457-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 223149D11D3
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Nov 2024 14:27:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E085B27CE0
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Nov 2024 13:26:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52C311991C6;
	Mon, 18 Nov 2024 13:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hKS7VT/L"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2BF7192B79
	for <linux-wireless@vger.kernel.org>; Mon, 18 Nov 2024 13:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731936412; cv=none; b=gEkNYVsSTbCPNo4bzzI4ZI7bKjPjN7H07Xb/A1kmUOvys+sPhGkbFDmGLi3WJ2VXylMoNgmJrMr9fI6FV18Vjih/lYZextdV4VRz/7RgF9XhbKLAawWjYqnAPgBl4AICWSwtm7023LeprRcZmv+oE3eyIJDrJ+qeD+VwZCUTX1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731936412; c=relaxed/simple;
	bh=mzABEeJKUm1eL+WcWI6hDHAKgti2PIy5NGeq/Kfg3tA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kLpLgvjtgPxqBTPy2vphvTYSJDhj8ZcXfrEaxYmgXqiK84BEnQRvaKnQ6XfT135E0g5A4Be5H+zzaAZvajvIpm9hIJPiCs8uCxt3IcUKhPOxFSAHpEYcHLJKBHNcXXR94hLUT2CTUqtcxy6eSpa21CRuFiY60TgnywzgeBdR+4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hKS7VT/L; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5cfa1ec3b94so2919840a12.2
        for <linux-wireless@vger.kernel.org>; Mon, 18 Nov 2024 05:26:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731936409; x=1732541209; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SBjJKgdG5EC8SWkozbzG11SkJAaLQDNNNnMlI930MwM=;
        b=hKS7VT/LZ2S0OkfXXIbXvcwNg20ihKCc91BeAy/tXRRfiOU4ugaIXcghJ6ekbwkEH0
         5ecz7JVhca0GbZa1V2cqr4ntXXxwPAjOxZlEGFCQdI6rEV0LlGOBumA+7ybnjp1NGklq
         YZ5nbjjM8Y/u/tltTKKsoXuhBwVUeHnJWeXctoqDFhsqSdwRaV9z4TH8uNV3Ti9/2KyG
         CT1AdBVu95oN9PShe+vHFCPD0l7J09n+GAfq936r59AXAH/cAsbcC8jXpcbdBinxFoTS
         fRbu2WnyRfihJFm1dOCEq3+3XWjel7CpM1CYZ6ocfEjYAOkNv130iLxqsGaJ5uAXdzpM
         o1tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731936409; x=1732541209;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SBjJKgdG5EC8SWkozbzG11SkJAaLQDNNNnMlI930MwM=;
        b=VdFHyCgRnv71ZXVPjLucTnl0SNQ7i2cfiA/UtvyrCF+DxkaEblw48L8CHC/v1C16c/
         Y51p2089NFsXyoYRNg/X7dULXaEzqDRvAZGzxjYdlvBzowyXEFx4t3vH61xg1kNLd1Rm
         N5VCEHdiYFuaUzfPmGqREDxmCWLQYhg946f4xjJtUxW6Ps8SB2HnEfrUMovHW1uY20Yi
         1T+j/jP83XYr0Os3TbQJsz3izS0dsGrdcC459tJLL2M9NwAX54BT5BN4+44lR8XX4Kay
         q0PJViQjgsC8m6JOx/VII4cN2kn5vvClHNuVqpABiBgaev34Kg3rtEs94jUEEK89e/Rq
         YVXA==
X-Forwarded-Encrypted: i=1; AJvYcCWx+eFWJRyvcIKcYB0hLNkpf2ldE7rEXj6AISIp42M29Qv6tzfeRu8LKvJEwy0jKITZRoK/zfvWNTi1bsn8Ww==@vger.kernel.org
X-Gm-Message-State: AOJu0YzGnVbZCDuQdwRI7KSmVMi8MFeUaj4cmjlEWycZKIVZNrgRt5T+
	IzENp63/gmDxILUHFU9BL+EZd/3J3z+pmGqzwj5fTntsQxN95O+DW1Og17nPcifjLMw70KyD95T
	3mcKxuI9sIWmqWoGZ7l/Hvlc5uVI=
X-Google-Smtp-Source: AGHT+IFEK7vYgvpT4WORH4EXepTqY8KMjvzX2UScsboQW9v2yeGd1yA6yRy4NZUc1y6Z3escciDRl2KSgnvfuzBFVUE=
X-Received: by 2002:a17:907:7ba3:b0:a9e:45e6:42cb with SMTP id
 a640c23a62f3a-aa4834263aemr1253258466b.18.1731936408764; Mon, 18 Nov 2024
 05:26:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241104172415.3790038-1-ih@simonwunderlich.de> <20241118125640.1110502-1-ih@simonwunderlich.de>
In-Reply-To: <20241118125640.1110502-1-ih@simonwunderlich.de>
From: James Dutton <james.dutton@gmail.com>
Date: Mon, 18 Nov 2024 13:26:12 +0000
Message-ID: <CAAMvbhEy9CtTN4-sw1jEb5Y+4gEdaKE3OR839xA-4nL2WZ9FpQ@mail.gmail.com>
Subject: Re: [PATCH v2] wifi: mac80211: fix mbss changed flags corruption on
 32 bit systems
To: Issam Hamdi <ih@simonwunderlich.de>
Cc: johannes@sipsolutions.net, linux-wireless@vger.kernel.org, 
	mathias.kretschmer@fit.fraunhofer.de, sw@simonwunderlich.de
Content-Type: text/plain; charset="UTF-8"

On Mon, 18 Nov 2024 at 12:56, Issam Hamdi <ih@simonwunderlich.de> wrote:
> ---
> Changes in v2:
> - Use BITMAP_FROM_U64() to map all the 64 bits.
> - Update the commit description.
> ---
>  net/mac80211/mesh.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/net/mac80211/mesh.c b/net/mac80211/mesh.c
> index cb5f16366b9c..e420eb4797a8 100644
> --- a/net/mac80211/mesh.c
> +++ b/net/mac80211/mesh.c
> @@ -1157,14 +1157,14 @@ void ieee80211_mbss_info_change_notify(struct ieee80211_sub_if_data *sdata,
>                                        u64 changed)
>  {
>         struct ieee80211_if_mesh *ifmsh = &sdata->u.mesh;
> -       unsigned long bits = changed;
> +       unsigned long bits[] = { BITMAP_FROM_U64(changed) };

Wouldn't it be easier to use this instead:
-       unsigned long bits = changed;
+       u64 bits = changed;

