Return-Path: <linux-wireless+bounces-16322-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6B0C9EF7FC
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Dec 2024 18:38:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 981FD28E6CA
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Dec 2024 17:38:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D811223C4D;
	Thu, 12 Dec 2024 17:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4rgW3kF9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 854B2222D70
	for <linux-wireless@vger.kernel.org>; Thu, 12 Dec 2024 17:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734025100; cv=none; b=IUiQ0O0JAx6pH1tcKrBTOTN7DX8nhXSpBOHb9+Ik/kA4O1IUMaSuZ9uXDD8mP2fjO1jkd81ZiYLn8FZQZwnBS3Tx8+lzYt/GEAjRd3A0v1Su2NE6z4BPgOr2rjbJb8PvG3Tat56x0feRfvRLwZsO737qBV/Bg38wLGJxReztJ+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734025100; c=relaxed/simple;
	bh=aWTVrxmG5W3tIhT6neWuRFNEJ1LBgRdw+hgIKFCMjK8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vlp+bFJuDaep724ZrLVsjJef4+qBpoCPuXbTVQqMHjWprqaaShB+M9GnF3wEl1DDbx7hgrv76QUWh+qvZ3xdGzqyCCRHfguaSK1sezgpkt+EEpxndXt3EvFLV3gkJyIwGXPJhL2LuIWlSphlogKqcEgZjL3975wj4HfqB1MMGlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4rgW3kF9; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-540218726d5so887349e87.2
        for <linux-wireless@vger.kernel.org>; Thu, 12 Dec 2024 09:38:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734025095; x=1734629895; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aWTVrxmG5W3tIhT6neWuRFNEJ1LBgRdw+hgIKFCMjK8=;
        b=4rgW3kF9468wmzu5vD3JP2gqmc4PdmJAWEx2DVd80dOtBAnwJwaaxmm/DAHJO3bYIY
         dQWCVSDktLwQ7VY7erI49aRt1NVP9Nb8iMD1j9Crza7t+fvbyyFizPyhloGYOoiVmJ3c
         ovIboTYbmYkTrK0uh2L3wuTGWqPvaAuGUf+d4VhxkefASUIIvl6HFQ8lLUc5zj8c+UOQ
         ZQA9obp/zn2gqu7MkONKg9YGFMOCf9MGc75qK5wYbjo2pRCPS6QRmRYbxzz4/OdM7Ybo
         W417cELTTjvLWTl56/QqSTvb3EVIQ4+Pmk1q76lMX+90km/kwUu0PzVhXFoNnPRk/QNb
         43vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734025095; x=1734629895;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aWTVrxmG5W3tIhT6neWuRFNEJ1LBgRdw+hgIKFCMjK8=;
        b=SKOJmBNUHGK6bwits6nX6vejUm/3PkFGzplJyx2jwxZvR3GrQTJn7QcI5k2kvGI14D
         acywJMw0MfGkceDGqTwrAsENOTYbAHVhwn7KknXK2CJOZCCrg1I9zqBJqUzPg3pRgBNq
         sJX0ux6luLXjie1SGi+m3YTAFE6qLpKhi+tb9sdV1tqNad4opnmYtQKj5v3y2UTd7wNK
         xpgfTM+hu3GR/2+pfS9rTXC1+QDXoH+gZ8BRT9p0AwaT3yhV/LUEbmSWjT/8wYm/yhOX
         /qbAGfVnfdm0AVyujASHHsJrCLwMvbdVG9l8p9QgbiFzROAvz9zbGCeyT5j5Npt+wrYl
         sd7w==
X-Forwarded-Encrypted: i=1; AJvYcCXXqXeAQKi2TQi4EImY/4IPYISy3R76Q+2od5bTg9hhnn2m/47R50fQIinkkOYAts7gQFNp5abxRjOxIMhEmw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyUHoIoyb/A5cBdL/rX+wqDGTwLz2Xux9F39El4D32BSgnJNVzz
	oL+XJ5X+5tyupjYJEjU1iKBtmuHBMAIizR7GbKcafbni5lAhzw7ohXJQsL/StYyI4tbiNUWCnms
	LdckwrsPK1FCEqR1z0DwPZJ3J1hpEEGXFTHMO
X-Gm-Gg: ASbGncvHyKx5QAHpz9J8bQJR9a2Qc4lkkzQ5z+6yvfJ+RnjAJ2/iCZCoOxjxZUaUT4L
	hZHndnhRR0pUxhoa4oN763Dqm7O+FVvvUDeU/kw==
X-Google-Smtp-Source: AGHT+IH015phUurBpWFmQa3s3RBwJ8PNrtRSaF1ujp3Q451/4hYQAF7Ccw77Ht0ZKlUC+7RE7PoqmmdadfJXIZMtLLU=
X-Received: by 2002:a05:6512:124f:b0:540:1e51:b919 with SMTP id
 2adb3069b0e04-54034112534mr504071e87.31.1734025095447; Thu, 12 Dec 2024
 09:38:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241212-netdev-converge-secs-to-jiffies-v4-0-6dac97a6d6ab@linux.microsoft.com>
 <20241212-netdev-converge-secs-to-jiffies-v4-1-6dac97a6d6ab@linux.microsoft.com>
In-Reply-To: <20241212-netdev-converge-secs-to-jiffies-v4-1-6dac97a6d6ab@linux.microsoft.com>
From: Praveen Kaligineedi <pkaligineedi@google.com>
Date: Thu, 12 Dec 2024 09:38:03 -0800
Message-ID: <CA+f9V1OK39b5hNoVZqu6AfPJqGsB4_5iyAK24Oit-tjmxrk7jA@mail.gmail.com>
Subject: Re: [PATCH net-next v4 1/2] gve: Convert timeouts to secs_to_jiffies()
To: Easwar Hariharan <eahariha@linux.microsoft.com>
Cc: Jeroen de Borst <jeroendb@google.com>, Shailend Chand <shailend@google.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Kalle Valo <kvalo@kernel.org>, Jeff Johnson <jjohnson@kernel.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	ath11k@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 12, 2024 at 9:33=E2=80=AFAM Easwar Hariharan
<eahariha@linux.microsoft.com> wrote:
>
> Commit b35108a51cf7 ("jiffies: Define secs_to_jiffies()") introduced
> secs_to_jiffies(). As the value here is a multiple of 1000, use
> secs_to_jiffies() instead of msecs_to_jiffies to avoid the multiplication=
.
>
> This is converted using scripts/coccinelle/misc/secs_to_jiffies.cocci wit=
h
> the following Coccinelle rules:
>
> @@ constant C; @@
>
> - msecs_to_jiffies(C * 1000)
> + secs_to_jiffies(C)
>
> @@ constant C; @@
>
> - msecs_to_jiffies(C * MSEC_PER_SEC)
> + secs_to_jiffies(C)
>
> Signed-off-by: Easwar Hariharan <eahariha@linux.microsoft.com>
Reviewed-by: Praveen Kaligineedi <pkaligineedi@google.com>

