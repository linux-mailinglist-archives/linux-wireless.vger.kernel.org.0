Return-Path: <linux-wireless+bounces-25453-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57419B054C3
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Jul 2025 10:24:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30FC9174AB3
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Jul 2025 08:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E355F274B30;
	Tue, 15 Jul 2025 08:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kISjnJZq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FD8426C396;
	Tue, 15 Jul 2025 08:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752567831; cv=none; b=OGT3UfEhzqhoLymfjTy6R88zQoZsahk/7JVKuvYJ79evdDbdXUQq+X8dzKxJc7qD31WjsLDTkzWW1twX8kezoAvXXkYdO4ooPu4Q0axoSBNjQb8Z5352eGSq7rpR/GQ7jRpARKpUdksNB1r9ZlGfz+lqG1t2cqQ1KYcJAGC04wA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752567831; c=relaxed/simple;
	bh=IXRCyqqh4GTD9xil3vhdDoGw5vRt665/k6/t0dxA3pI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fpldVkuh3meKTBzsjoxc1LAYfa4Dz9w1lhtWKsCuV6CIGxGsm6EurfP78lGdP5Dc6MFZG78S5EoZJgK8ec5JmMO3AxTiWA950S75XsCF3zLl14bU6nepMxqkTjiWf0emj1FA2gJFjjN1ucQVXPVyU6nbnURiWSx4a6bp4dvEzbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kISjnJZq; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-311e2cc157bso4437662a91.2;
        Tue, 15 Jul 2025 01:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752567830; x=1753172630; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AR57cyXHpNdEBRao+1ozE9zC0Ys9s/kP9hmKhK9UHUA=;
        b=kISjnJZq8sexE3vCQ2FpiUTcVlba4K1+zW+0xTsyZ4ySdKqADeN5oYsQvYy3TklpVV
         3Bshb0O1tHsUnGwzY6ExK87+75Szj5NGB56rUAYaSbDTa/jlpK7/0gu4vS9O6aX10I/N
         usk0XgM7nbfc1bZkAX/Q0rk1kkRBVzMk1KfN6WE6JR8Nvn5l45gKX3ycEm0kaD4bOJb3
         527MawZul9w7rPynDhXQoAK+BrRcFHE7R0G8fFfiQMueGtZ86FA2zF4ztJoc7tPAgK0s
         XkBZnIdyU6BfO0KL/MPUkZxwTTTZ+gWiu2T4aIhg1QxkcVpVd33XALqWrqsAvmF5x7UD
         EGPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752567830; x=1753172630;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AR57cyXHpNdEBRao+1ozE9zC0Ys9s/kP9hmKhK9UHUA=;
        b=rsKmsuuQ1M3cuU6hC2mOf2V057uT7Cclg7F3+IEa/85eG/OCm3LouQmfWulci0S0g2
         /+2KvYTvygjq70vRw2YgG6ua3M+I7Bd1/vtdJq1478mVcviv9QJwxL+qEwBKqId4cL8y
         18ND9Wt75BW/AX7o+y85Z13bq5HxdtM/qRNp16/IIPJ9GHZrGgEnPgoO/1H6k/iLs9dz
         yUuzxZzvVzyaDngVa2MiFd6r2ELQDS81NfI7piIn66A9/fsc4/694a35oVB/PYVibvlr
         r2LpO1MljGvDs0fNA5M7cf5me84zNL6K+Kqa7OR09mYP+j//b8xxAxISLfJuzfNxHIMt
         2u6g==
X-Forwarded-Encrypted: i=1; AJvYcCUghI2edBraYd7A7mGiu4pctV8vmvxkodJdFlo8SlJ3zm2POzoxPTxKvZSImhXnSt9iKKUgNfsrx/0s@vger.kernel.org, AJvYcCWLsIZwFqgPwK5psZAkW/Xt3aRTOphLBDn1xHzAIOWS6bh0Shh1AdardqJOyC9mzeKCG8lYHx6cQoWLTQ==@vger.kernel.org, AJvYcCXoZ69i0Un1eKG4jnuK7qgCsY/AhPu8LDcPwVOYvRHF2vAb+Mx01jjRD1ui0gHMXCk2wKxVrtbvW9YFoph8@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1mgjhyWhz2zXzJuu5t+JztAIQ0DK9II+HQeRPnrteUC8sL3Fw
	ItAPgYN5YEJtr5+GkqDuAAcV/mbQqsksxoe8UI8Azl+T1K6dVhFtHOfuJvQ0tdmFPeTsOvviiUf
	F3y6AihkbLJcMvAy/v3PgspBzUwNTcTGiI7pTybBFsQYD
X-Gm-Gg: ASbGncsO7ycElB22Rgj/dBQMk4dyVV3wdYcPoMm98c991fD4IM/Y/fI7MaTbo9tfi30
	xJxjJ2rMcNDFCJevrui2j5g0GdeirpXt/NU5s23quRFngEG6OxsGilv9aHUJlVqHf5BvgFNVcIJ
	S9ZD5d0FE08jSN/WKj8h3T1Btrw20Wdm6IvQN1Cer5bwAq6T3sAfXSY4ttEh99HvNI8HY6nWsLB
	mau
X-Google-Smtp-Source: AGHT+IGQim4tVu7RMI5fjr1GyhLLVevwXHUGV3YhMyRCmfDdHKplROEF+/5RsJJ3UPhiAa6LDTi+DGZv63jRAIn0aBU=
X-Received: by 2002:a17:90b:5885:b0:319:bf4:c3e8 with SMTP id
 98e67ed59e1d1-31c91f25558mr3528982a91.18.1752567829634; Tue, 15 Jul 2025
 01:23:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250712210448.429318-1-rosenp@gmail.com> <20250712210448.429318-6-rosenp@gmail.com>
In-Reply-To: <20250712210448.429318-6-rosenp@gmail.com>
From: Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date: Tue, 15 Jul 2025 10:23:38 +0200
X-Gm-Features: Ac12FXyjagyqzzwK9h4VxCo7FvGtmHUddwyUc5g6qUy0YRPcOqUgDiJgtz5UTuw
Message-ID: <CAMhs-H_xaV6o7ah=7m8KVBqRgudjKS5o5JA0LTLxf+S2gsuDAQ@mail.gmail.com>
Subject: Re: [PATCHv4 wireless-next 5/7] wifi: rt2x00: soc: modernize probe
To: Rosen Penev <rosenp@gmail.com>
Cc: linux-wireless@vger.kernel.org, Johannes Berg <johannes@sipsolutions.net>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Stanislaw Gruszka <stf_xl@wp.pl>, 
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	"open list:MIPS" <linux-mips@vger.kernel.org>, 
	"moderated list:ARM/Mediatek SoC support" <linux-arm-kernel@lists.infradead.org>, 
	"moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 12, 2025 at 11:06=E2=80=AFPM Rosen Penev <rosenp@gmail.com> wro=
te:
>
> Remove a bunch of static memory management functions and simplify with
> devm.
>
> Also move allocation before ieee80211_alloc_hw to get rid of goto
> statements and clarify the error handling a bit more.
>
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>  .../net/wireless/ralink/rt2x00/rt2800soc.c    | 185 ++++++++----------
>  1 file changed, 79 insertions(+), 106 deletions(-)

Reviewed-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>

Thanks,
    Sergio Paracuellos

