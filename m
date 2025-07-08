Return-Path: <linux-wireless+bounces-24919-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 941F0AFC7AD
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Jul 2025 12:02:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3F394A855C
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Jul 2025 10:01:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B271C2686A0;
	Tue,  8 Jul 2025 10:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iyK95EaP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 348982080C4;
	Tue,  8 Jul 2025 10:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751968890; cv=none; b=qYocDq9l/o7UGNLeLy8h8JXBKf+12M6xxEVOOtEohb97bf5VggUp+/geZTJHDkTB1DvOCVcs2ccwF61vQrSyvzN5GnvfzUnn7shhceRzlwWsZ8El68tAyyI6dg+V+VQM5pT2u/anGuDyl3wkh48YU1AcmZ/0xeDFjJAlsmzpaa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751968890; c=relaxed/simple;
	bh=2GpWp3s5PTqNIR37H3UM5Y9dp8BOP0M+MyctEuN/YIw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SFnIjDMMAUhVp51pBaTDZsKI0VgzUo0+ln0T4s547hDb5qevRoWFLxd+OL002KtB902mC3qm+NFu8spwjoOn2a579AbrivsOdx93b+eG41pV32mWfgwxe0AZFbDNCrOZUQ7sRVmaK3MullOfPtyFczQBw+fWEwm5SZAinydQ5xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iyK95EaP; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3138e64b3fcso2941576a91.2;
        Tue, 08 Jul 2025 03:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751968888; x=1752573688; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BYVWqBDuV8m7HidOYvo6oSjOV7wiCQCv03/6xvMA1E0=;
        b=iyK95EaPlq+40s6uw5tcnXHBO8e9eCw3d/2Q9JG0ZCq0SFFTLNaI44v9h8c1527QCT
         krK83BgIcxtYWrWfwQco89hkB0HyOfOeYfmsEGImlO2J7PWova4HzJzy7TEvUaOyLqE0
         i7g3N76HY+MwqrSdg4pjxIlYvAop0CeR0ORq+nK6Nx+N0uG5/9kwylkCXnfAiCQ24tIW
         tuasqThpdwyyUissnlL6zApN6zE+JIYAkKR1AHjh5Kvb3o9ZxahNvZ3fKeVwT9o51u0m
         rRpMGeZMt6kGy5GJqw9+VLJoY1v8P8ZD9nEZxWWG3+/dqy9lDEPUYIfccwbkxsWQ3WVD
         raGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751968888; x=1752573688;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BYVWqBDuV8m7HidOYvo6oSjOV7wiCQCv03/6xvMA1E0=;
        b=f8HFLhTcHpv4DToxLh9JGURLWEktpAFJHnH0JIJfOEBoI1PzxG/Oi3zDZWtzrvTuKx
         dY36yqiIi4eG4lB7j+gMmfg7elutt96KHLg1T1uHfvTT7kTI90wp/ewO06t4LphOCga7
         U9yUAx4t+n3CQ7cY1A78RBZ2T/Zb8TvCDBVr+Xub97A3Mvcr9vSg60WjcxQg5Q9iHap8
         amxZRXIWXUkDvZoZKLYujldYupsZthtOzQZ3fbuA61EPT4JPYniduMsERzhW/p9hcpEK
         BYYnVZDC5Kf4VvYZtnHrznYjn3YwbLkID9jO8tqigO4+hdp7rme+dRvpYS/a/09Yo2zd
         MyRg==
X-Forwarded-Encrypted: i=1; AJvYcCU+V5g/3uNcc/RVT3C/3lW6mAJXFiqqMXdzwBwZf+/qmRlLfQxx9MOJTDQHryjnse+TQQoRC5sUWU71@vger.kernel.org, AJvYcCVR4ZGiKp8RfzIVsD16oT+BFXzFk4fpbsnUjQ8sEBUTaLB7wJcGekOG5/JxrjUE3VSJagEQt/+HwN29V2pm@vger.kernel.org, AJvYcCWusLU5Syk+ejUNx4V87al6hwgHPPYpDZIk9R7KCW/RrUjEaUZhUosbmXt/zjDW41jGs2F9kVWMr6uE+Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YweudBRaQyIinHSsFsCqP+cjmolGxNXZgFSchQiZgLo7pENccUZ
	QeUoB0+pEo5oZRC3ENZV5Q92t0YRoDiqHpGL3PeqVfOUegwaS/V8TcKQhzO4OkYokQhZHE1LyFU
	q9FI8vLd9KK4JJnG8UkQn85s41eBUWNU=
X-Gm-Gg: ASbGncvDhlOFEPNEQhDU6Pu6D9oMqGngEnyhG4kNjY2Lnhbs6jscuc+hpCiqem4cCN7
	7V3IwUZ3ClKaZtaPckXjQ9fgA1B/4ifHwTOpYqUl4BGu6zk+iXoir7l2b/14mqWh2cbfAfx6RDL
	DspF9gtijYrpb6SjAPnuslKTnLScFJ5BL8k4BxY2CF
X-Google-Smtp-Source: AGHT+IGYKEJK2xo4dPc6y1F7cjXea1ETy9xhjndwr4Pdcn3GQxSSY8T38dioJ0DFG99A1R8cEUN75ggzKI5af6Tbcd4=
X-Received: by 2002:a17:90b:3c8f:b0:313:1a8c:c2d3 with SMTP id
 98e67ed59e1d1-31aadd8535fmr18447334a91.22.1751968888351; Tue, 08 Jul 2025
 03:01:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250706214111.45687-1-rosenp@gmail.com> <20250706214111.45687-3-rosenp@gmail.com>
In-Reply-To: <20250706214111.45687-3-rosenp@gmail.com>
From: Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date: Tue, 8 Jul 2025 12:01:17 +0200
X-Gm-Features: Ac12FXypn69TyIfigXU2ITYLudOZytlc3g_sKOneE3FvF9rspGTP0tpBLxtSZas
Message-ID: <CAMhs-H8Ts8nreYppvbXFuTkvcEUGCurjUtjMy1XrfVzv4q8k4g@mail.gmail.com>
Subject: Re: [PATCH 2/6] wifi: rt2x00: remove mod_name from platform_driver
To: Rosen Penev <rosenp@gmail.com>
Cc: linux-wireless@vger.kernel.org, Johannes Berg <johannes@sipsolutions.net>, 
	yangshiji66@qq.com, ansuelsmth@gmail.com, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Stanislaw Gruszka <stf_xl@wp.pl>, 
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	"open list:MIPS" <linux-mips@vger.kernel.org>, 
	"moderated list:ARM/Mediatek SoC support" <linux-arm-kernel@lists.infradead.org>, 
	"moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 6, 2025 at 11:41=E2=80=AFPM Rosen Penev <rosenp@gmail.com> wrot=
e:
>
> mod_name is a legacy debugging feature with no real modern use. An
> analysis of the underlying MIPS setup code reveals it to also be unused.
>
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>  drivers/net/wireless/ralink/rt2x00/rt2800soc.c | 1 -
>  1 file changed, 1 deletion(-)

Reviewed-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>

Best regards,
    Sergio Paracuellos

