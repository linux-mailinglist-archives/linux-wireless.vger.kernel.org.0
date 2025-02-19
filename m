Return-Path: <linux-wireless+bounces-19112-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEA98A3AFB5
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Feb 2025 03:39:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32D8E7A2BE9
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Feb 2025 02:38:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F34AE42A87;
	Wed, 19 Feb 2025 02:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rdq7Jp5f"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47E3D13AD05
	for <linux-wireless@vger.kernel.org>; Wed, 19 Feb 2025 02:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739932763; cv=none; b=XrFDuFmt8Fwp4WavVONjzpO8zOmO8IxMolxFPUt8/1PmJpDJf5NYWo0QtG/aSj5iup+RjeH5wslAHz7DCpYrPOiMd3x3SJTNUWqOhJtsnZ7Qt9jdtZizs3SOqtV9h1CGiFVspsBRxYRwex/Cr2iZMXs4x1sxjBetbUdp0fYMl4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739932763; c=relaxed/simple;
	bh=dE15IpfuHv5IuYBDpFLLMFa5TpDTNEmOVHVBkWmqALs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BXqz5iHJbZD+4vqOUOhv2bVofMlEsHiCQqF+4+DmL9Qv8WW4WshKcsEmI+TvgLVy9lSsMH5mNQaZEc/QJM5sMRUGPUVf/lziw3szSxIDUBd+RTDD2XgIGH9tyqbI1J8+HNc9kgYi8f/RWeqVxrVepf53sw928Y6i+3brpd3EYso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rdq7Jp5f; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-abbc38adeb1so190460766b.1
        for <linux-wireless@vger.kernel.org>; Tue, 18 Feb 2025 18:39:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739932760; x=1740537560; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dE15IpfuHv5IuYBDpFLLMFa5TpDTNEmOVHVBkWmqALs=;
        b=Rdq7Jp5fanBGbWq+KMHtCvAZb1I9/KWacEfJb3z4LlSIfCxPx3WFdcSeDC9tZCN8eN
         043rs7kc54FZJkBlbJPMLsPv/WwRsto8xJv8nKi1eYisY8R3wHCww1f6/dYut5obQPo4
         qNIby4k+4qAgMoIVhXmBa5bSzSbT5PjCli7YeDUhHYttP7VEOxqY+QCVpVnJN87/16VW
         SZy0H0GRmbDQiU/+croo9KmmNqvlokqVdyu1Bcr5Kee+bW/M0t0Vc0+veClC60S6O0Ge
         /QXPmB085xqw7ytN/NzUhVo2I92gkDSHHw77c7HwsvCV6yLYWNxybiA34XTaIRg/8FXu
         EnGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739932760; x=1740537560;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dE15IpfuHv5IuYBDpFLLMFa5TpDTNEmOVHVBkWmqALs=;
        b=DlB+oLQtoiC8TPe3mmwxhYURr/jqWb37PEn8QNh7ufddC+AG9pueSvQ85YaoTgOXGz
         9Z9r2gHiXEguUMDPjeqx/IQ4+5BYy1EKz504CVreAmcRl6TEwq8U8l4bA8QRdAwlpkzJ
         /mYKMg7k2NOwCgjG1FbIiy/p3D+2Z1hH/x5fMvnRPUF8srHCNfUjpSRY0GIz/oncfSZw
         71PYjkA7PG0oM+NJ28wMz+mQV7T4gR3NmErNvY/9gEsALIsjGjf1F1exihzX6KCEpEeJ
         94G1Fp5JgNs48os/dpwGU9Uyc5v0nQdxySjCJk2q6bywA0P8qQ1Gqh+nQpm4D40dw8bW
         IqnQ==
X-Forwarded-Encrypted: i=1; AJvYcCVVe6AfBjvcPgEvlsb81ZKqGT3oa6EMISsTy1+9SpxCBVkfu/iH0PAo1DfXF4kXqS9cf2g9Gz4ArKTZtpJQSg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1nGyoVVWHPbBDqfVAIQKOqtG79RiyLRcWRUBWPheEZ5AmG1n2
	1Fk/nnC4pfDG6RQNce0eLMq10iC17tvRsxfQggqvr3zrRfUZ4KdmqqqsUbtCYYu8c8l70ZbQwl/
	Kba9Z9MK55MIvkSrvjo942pS5VFE=
X-Gm-Gg: ASbGncuRoLw9MKSlye8CwsaRxpNyJpFlWHK9hdVKt71UztFMvAhXvyw7y7Rbm4QvKyE
	mn1DAXIu6wv9rbHtCHZvBYz00PhNQU0Sn+Bvcvv7mKO7BOLPYl+vuK+dDE2g9VXOVe+XLnt6X
X-Google-Smtp-Source: AGHT+IFAMtRvtWqh/vKVXJ0C3N26mL4l+whHbvP/7hglm/5ls52mTVj6N9Vwe7twFE+NyfhW5yb3nIxMdhLLnQWmcRE=
X-Received: by 2002:a17:906:32d4:b0:ab7:c1d5:14f9 with SMTP id
 a640c23a62f3a-abbccccb76fmr201348266b.10.1739932760221; Tue, 18 Feb 2025
 18:39:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250218025957.13818-1-pkshih@gmail.com> <CAGb2v66Qev8nQvt54dKDC+Q+rJ5m6+erWO2L4_vSMVqrTe_DRQ@mail.gmail.com>
 <5e433cd8d070682cb6ed31de3a2dd337e6f48b50.camel@sipsolutions.net>
In-Reply-To: <5e433cd8d070682cb6ed31de3a2dd337e6f48b50.camel@sipsolutions.net>
From: Ping-Ke Shih <pkshih@gmail.com>
Date: Wed, 19 Feb 2025 10:39:09 +0800
X-Gm-Features: AWEUYZlZEUhW_0dF1fc1R8zNVyB4pmlUp86nXh0nT2GzQ83jBdO776ipx-OdRbU
Message-ID: <CAHrRpums5Czf8S0QmabsP+CTdeRwhfC49J5Qq_6v5Wgt8dKahg@mail.gmail.com>
Subject: Re: [PATCH] wireless-regdb: Update regulatory rules for Iran (IR) on
 both 2.4 and 5Ghz for 2019
To: Johannes Berg <johannes@sipsolutions.net>
Cc: wens@kernel.org, linux-wireless@vger.kernel.org, 
	wireless-regdb@lists.infradead.org, mobin@mobintestserver.ir
Content-Type: text/plain; charset="UTF-8"

Johannes Berg <johannes@sipsolutions.net> wrote:
>
> On Tue, 2025-02-18 at 13:29 +0800, Chen-Yu Tsai wrote:
> > There are NO-INDOOR and NO-OUTDOOR flags for the database. The kernel
> > doesn't have a matching IEEE80211_CHAN_OUTDOOR_ONLY flag though.
> > Maybe that should be added?
> >
> > Johannes, what do you think?
>
> Good question. I guess we could have it, though I'm not sure we'd have
> any mechanics to actually _use_ such a thing right now? Something, say
> hostapd (?) would have to promise it's actually outdoors?
>
> More information doesn't hurt and I don't mind adding it at all, but I
> do think we'd probably not be able to use it at this time.
>
> Or we could add it to the db.txt file but ignore it in parsing now and
> skip the band for the binary for now?
>
> The thing is I don't think we have a good way to say "older kernel skips
> this range" - or perhaps we set the NO_IR flag so older kernel cannot
> use it but then allow OUTDOOR_ONLY to override that given some
> conditions?
>

Thanks for the suggestion. I have made a patch to allow NO-INDOOR flag, but
not parse into binary.

Since I'm very not familiar with Python, please review the patch carefully.
Thank you.

