Return-Path: <linux-wireless+bounces-30102-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E7D3FCDCB1A
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Dec 2025 16:27:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id ACEE13010E7B
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Dec 2025 15:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A63E34CFB5;
	Wed, 24 Dec 2025 15:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="GdznoYgd"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0112834BA49
	for <linux-wireless@vger.kernel.org>; Wed, 24 Dec 2025 15:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766589924; cv=none; b=HKC5NVDj4Vh4jIgNtn3Sl8aerHThlDQPGKlkh2WFeuIrLiXqQSycV5zurjIhz9bpv6hhtbPrXBHkIBTsN9enM96HGqJqmCyaXWf69awagwGORB0vt7T3V3n7HTynq7Y0tFNEeR6ANspSCq9eX2Lp2EREq2qRTBRncw0TY/NdE6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766589924; c=relaxed/simple;
	bh=OT5P9D3eUmbZqKMnqZHxTQ5Gp6FLOvMLnz5Jn3p6aAc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h75SDX04SABB93tJc9BfcGeD18blvJ8/D3+KV7+Sph5rGZed6UDCQQ3ihchfhdcyaqP7mk0J784JmNnGy1U9+R9xbl0rfz0GEfQieuWUKHNStMYhUgFep6Sp17ggf1t7GW+gQ3FOltF8+wubnhKyNNFYyBzA5E8QQskDMZarviY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=GdznoYgd; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-37a3a4d3d53so50617181fa.3
        for <linux-wireless@vger.kernel.org>; Wed, 24 Dec 2025 07:25:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1766589920; x=1767194720; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ub/18GJ25fDacSsVJieCeokU7It3HAFq//YyevGHRnM=;
        b=GdznoYgd1wfAbmxdI1i7ptN9lCTf6sLcWw8TsBg9F3UgwbErcD06LMuzuh05yFK+tT
         3awph+AK0TDBGKTM8v/avX5xGW+61Axdo18BR+RYe+e2bXSkME1XCP8Ht9oBxS6RT+r9
         fmRiNEiNoDy/LRbCA+N9+PWtr8TmdD8xvAkyLrjexy3+Oa4zALHAMzmTsArgOjUUFi2Z
         0neR//wbtYsGuTGUBoujB2Im0kteo/OwOqmfHKJD8fgJADM+aM6PcsSMH274Z5CAzoG9
         18F1Yrupcp0zGIuSeK0uTK6SR3LeqWm3Lt7gR4FWRnXy2phclm71ULDPvcpDIqy3ykhy
         PMxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766589920; x=1767194720;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ub/18GJ25fDacSsVJieCeokU7It3HAFq//YyevGHRnM=;
        b=L6BsYRQ4T/X05s4cjfDFNfdAjA1Sr+KTaAnnbpZlgbiIuQxbMVbnbzwToZcFdNpf3J
         uGYZDIkOJN2beXT64NLlkso7FaNlVSJcheo/VF4nizsiTm/7MoBKbjWu+sz6JV2EgHSO
         cZfC/UqiLUvM6wf8rd6fUoAxKA1vMTWb7lCw6XhPIH/PH1hRX28dVuESS+y4KPTo72bR
         ClWgmhJ1Y9rvSOkfTs/TzroBnHXTtMxm5eQkI2j+vyqx8Y+UBPZAvpi12QkcqGdOSgzh
         5ie9+7DTUIgGHEB6Dfns5eATQ3XRMXPId+PdU3h5eGbJn40aI0DeHuT/CAWIpq1r0ZIv
         neFA==
X-Forwarded-Encrypted: i=1; AJvYcCX7HpYMp8Wt8gXY0asRtWUhe/Gldk/9wpQXmzi/MzubyaLCGYmAxqGcuQIXKBNob1m2O0xAje4pfFJFZyrXFA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1oT58lkadEuVHIQiJQ/UkNSfKCDuxVuZy30SeO1TTEyLuvVdZ
	uVjkYPyOgaQGnN6se7Vx4lM1S3IUut23qAmrkL74PLchwnsvUkY6TEZPOTvr8CLIyHKGRp13MyN
	y2/sqhX4d0suuxF1KMoN7v/BiikeKOrK64PcMfPY1XJI012ZEX410
X-Gm-Gg: AY/fxX4RTjLMgrkxBsHZvHKthveu7cURgH8VEmnMCmqcJ8Jvz/KETEChAXc2oXHusi8
	mwMJRpbzxGnIWDR3xrQdCvCfl3T3nthGh6vdggjOFIy+k09CnwGPBVgqDdjCBr1tYcaQjlB9B3l
	awdGZGX/sU2w1RB6iol3uwi/G8FO75VxQB+CCqKCSbFOc7X8wkc5gMzp5BYcWhZFb/p+endl1vY
	qQJ1UK6LIUlHbFkSJ2ScrpxqDFwKDXnPc4//buI7omrtlCWLAlvYo8ybdbj7R22GEiEunnSGEEr
	TrpiHn5+ku5HTSDlM6mzrv0laMH+
X-Google-Smtp-Source: AGHT+IE18Td0Nc/XUXi4Cl/TcjHngwFgeghpA9tqLowzRzDj1icyD8qdVib+ULxbElUN5zQM7gG2Jag6BgFnSaqID8k=
X-Received: by 2002:a05:651c:b23:b0:37f:c5ca:b70a with SMTP id
 38308e7fff4ca-381215671e0mr64786141fa.7.1766589920090; Wed, 24 Dec 2025
 07:25:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251114104325.116471-1-marco.crivellari@suse.com>
In-Reply-To: <20251114104325.116471-1-marco.crivellari@suse.com>
From: Marco Crivellari <marco.crivellari@suse.com>
Date: Wed, 24 Dec 2025 16:25:08 +0100
X-Gm-Features: AQt7F2pdx_yqBW3dZWH9yjaq2tVaCtyoU5kwu2elkW6Y4N6ZypwXb883yj0Z2S4
Message-ID: <CAAofZF51pkOzrg_nO0Mhx6g9b3JPtO3n+0YE=WtSgj_F6wnY4w@mail.gmail.com>
Subject: Re: [PATCH v2] wifi: mt76: replace use of system_wq with system_percpu_wq
To: linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Cc: Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Michal Hocko <mhocko@suse.com>, Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>, 
	Ryder Lee <ryder.lee@mediatek.com>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 14, 2025 at 11:43=E2=80=AFAM Marco Crivellari
<marco.crivellari@suse.com> wrote:
>[...]
>  drivers/net/wireless/mediatek/mt76/mt7921/init.c | 2 +-
>  drivers/net/wireless/mediatek/mt76/mt7925/init.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/init.c b/drivers/n=
et/wireless/mediatek/mt76/mt7921/init.c
> index b9098a7331b1..95764b82da39 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7921/init.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
> @@ -343,7 +343,7 @@ int mt7921_register_device(struct mt792x_dev *dev)
>         dev->mphy.hw->wiphy->available_antennas_rx =3D dev->mphy.chainmas=
k;
>         dev->mphy.hw->wiphy->available_antennas_tx =3D dev->mphy.chainmas=
k;
>
> -       queue_work(system_wq, &dev->init_work);
> +       queue_work(system_percpu_wq, &dev->init_work);
>
>         return 0;
>  }
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/init.c b/drivers/n=
et/wireless/mediatek/mt76/mt7925/init.c
> index d7d5afe365ed..e33ab4849e8a 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7925/init.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7925/init.c
> @@ -420,7 +420,7 @@ int mt7925_register_device(struct mt792x_dev *dev)
>         dev->mphy.hw->wiphy->available_antennas_rx =3D dev->mphy.chainmas=
k;
>         dev->mphy.hw->wiphy->available_antennas_tx =3D dev->mphy.chainmas=
k;
>
> -       queue_work(system_wq, &dev->init_work);
> +       queue_work(system_percpu_wq, &dev->init_work);
>
>         return 0;
>  }


Gentle ping.

Thanks!

--=20

Marco Crivellari

L3 Support Engineer

