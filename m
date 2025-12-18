Return-Path: <linux-wireless+bounces-29894-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 09EE6CCA95A
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Dec 2025 08:07:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 411BE303EF74
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Dec 2025 07:05:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43B7B21D3E6;
	Thu, 18 Dec 2025 07:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="b+x9aYVE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3571017B425
	for <linux-wireless@vger.kernel.org>; Thu, 18 Dec 2025 07:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766041545; cv=none; b=Ept/YGHQeiYX9s6JIWUhW6HcdHFL8i26dDanCPVer8utll9LTLcC6TftbD7WjfTsPi02HQvk7tPj/JXw6vCCQoWQrvu3kw/zXVyuRMWK0a49P/z0jWf4eM/LZ4UepGXOANMX0YbJALGeChnctWE9Lus4ldh6q1c92vsp0qLv0Hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766041545; c=relaxed/simple;
	bh=WkaZwMv2JvPKYzx1x5YJKcKMa/ycX1CuZmm0Ujjv7D0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aPvPBB5Z2EqJZsv0REZQlzOYQ4bL0TKPcFm3l1pNLQjF4YQheKPGouoTraFHwbJzLdiVklmJwX7oX31dszeJLAC7qdobZC/Z3QQnnmrIQIZjHuS6Yfy6+i5p1IdiLgnGTrgMDYDwGJi1zXD9Pore1bl2viFiHFPcrxoYhwpz38w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=b+x9aYVE; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com [209.85.218.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 822993F82B
	for <linux-wireless@vger.kernel.org>; Thu, 18 Dec 2025 07:05:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1766041540;
	bh=c7S7hlyro8bVLPaUshenPuh/zyDvp4ao0uVsdHOsDEM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=b+x9aYVE8DWnw9M4Xk3LXKWB4AxNPbR4yPGAV5qT9mRLujSAn3+jZ4wVLWVm25SyV
	 zVwQCKSOEBwj5Qa44loAOzLUdwYO69ROndaTk50ieXfnAlMTGGi5kklGjblg69VhrU
	 92rjjPVpcmdXo0LAHqm4uDDpgajFtDY/LM0yu4yK/LDO2EXB4x5OOwk4vq5kwLx61M
	 nSI+n/xifQ4oQGbvsNuG/1UmplXwed+yBouWNE87quDiLrgHCh0+xTV6Ajz9WSR8W2
	 SEM2qQS4aL/KNFsDQPjDKRK1t1fcqDtI4iPp4/k8Jpf6/Xp8RJ+UzfM5PWEA8YJRxt
	 AlgIN0KxUT9pWD56uLS3ilrpOhV60X+u/jYn4izPuZrbc+vPG3OugLCpjLDc6MsVzK
	 vAQTMQHGDFrr+cHgGTnS/qiII5oraUeo893N0WkK4LSxXy2zBTsIwmYtjd4FIoMP9Y
	 5HfRPMPsRA4o1YSOAbUZR+khRsYDX+RDfLdv8Ivnkfn+byryVy8FgUksoPKdK2sKGm
	 mu/1HMeKWQq7NICNhlDwB2UxaxaSqj+rA/LLsfxmtMpu98plJYhm2prV2Ev9plUZZr
	 hj97mY56zJ2YwWnbk0rkNeXKEZ9mpRdA4IHcAoQ5zcGmkj5be4WutqGOTXV15+rIgR
	 RkCz+PVb+A6VsLDeLMAIN4eM=
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-b771bfe9802so20875166b.1
        for <linux-wireless@vger.kernel.org>; Wed, 17 Dec 2025 23:05:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766041540; x=1766646340;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=c7S7hlyro8bVLPaUshenPuh/zyDvp4ao0uVsdHOsDEM=;
        b=P+gREcDamlZh6MkYZMFAvEftGg6Uj8zRKH9sCNFLldi+PYY6ET+CB+JamZCG+jFK1Z
         TxcXtkN7Tj1uEKnTJiYu/Yi37h0PD4ZrXcyBr04ditXWp9kdaYgPuD2nBK2Y13Pk1vau
         5eXn9s3ztqPW4YOABbB3G4oTUIGK5ILR33avN1d6fbDp4YWdrLwrhhRDnl4W8F0wnWr6
         qzfAo78Uvh5DK+So8Clc6LC6FLAdAIisqA0UJcwBuAbo3Nv1+iECUKf0D3nkj0MDRu2N
         jydFTZX/tk/pzsPZqkyiUuxy3dU9rnCyXA6xxFdS6vvulM/BDmbgBMoS/OS44Ecta/7i
         g7Ww==
X-Forwarded-Encrypted: i=1; AJvYcCWdJVWm2A3nu20Nw/5ZTPu2L9mc5X9QlJ3skBvV2kSUi/Rptla3rL7jxFz/spLRYT0pDdzFsl7+zwj/oaB+aA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxGbBe8hAaQSFb2jBQvDMlT34WaZ/xtJUg1UCQK6EpHVw1BXv8i
	6D/xsyB73d/6o/eg+LklfIPaR7Voa033+0ymApG+SH3q0sCWPTNWun14ewLGTQOai5xDXp6OnNw
	aX4DclVdTIj1PLJ/SgXZ/1TT/IT2gjbO7XRcYxUiOuyxSY7JB4RV1bRfuUHGzSXaC0fTuAdYcL1
	TlPKT83FO7/3Ovj/av+91jOgg/RL6pq5u3KE6eJ0e8K0AxDLruENIMjARXSCw=
X-Gm-Gg: AY/fxX4j1/doJOWB5289BTuavF5/Nz3c+cWVW2rKXGfGraOkAr/ejrbS4yQHsPCcLkW
	FcFmpr4K0LHge6Fb35v2cnZfh1GGT/+3vcYeSPOUHrc+qGz4kD8zFbUDC3CZsJGyvQtoCjSbXxR
	EHqkXiZcnFdhCeyeMwxZY5BsO90X72vEpP3t9/c9yR/mYXGm/6QYV8C5+pNSOLJqmB2xhX3hVvW
	95e2/Pu9YayUw==
X-Received: by 2002:a17:907:9282:b0:b7c:e5d6:2462 with SMTP id a640c23a62f3a-b7d236c1aa1mr2440553166b.28.1766041539962;
        Wed, 17 Dec 2025 23:05:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHYGGDlGR8ADZeTuf+I2EP8DPreDJKDZDO7LRoTEnfNBskKW5KUZhOxrJXIujTLMPLzLh8TI5+4XZpPWPsKGLg=
X-Received: by 2002:a17:907:9282:b0:b7c:e5d6:2462 with SMTP id
 a640c23a62f3a-b7d236c1aa1mr2440549866b.28.1766041539543; Wed, 17 Dec 2025
 23:05:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251215122231.3180648-1-leon.yen@mediatek.com>
In-Reply-To: <20251215122231.3180648-1-leon.yen@mediatek.com>
From: AceLan Kao <acelan.kao@canonical.com>
Date: Thu, 18 Dec 2025 15:05:27 +0800
X-Gm-Features: AQt7F2rFCwU_nFN8zxCPmULe9M1cSOrOTgxx5yt49VcbBl8x2h-eJIE_P-DiYM4
Message-ID: <CAFv23QnPqdw8v4_k2_sbxhb7p7ZR7fuDJ0CRij=9aX6EC3-4Mg@mail.gmail.com>
Subject: Re: [PATCH v2] wifi: mt76: mt792x: Fix a potential deadlock in
 high-load situations
To: Leon Yen <leon.yen@mediatek.com>
Cc: nbd@nbd.name, lorenzo@kernel.org, linux-wireless@vger.kernel.org, 
	linux-mediatek@lists.infradead.org, deren.wu@mediatek.com, 
	sean.wang@mediatek.com, mingyen.hsieh@mediatek.com, michael.lo@mediatek.com, 
	allan.wang@mediatek.com, quan.zhou@mediatek.com, sarick.jiang@mediatek.com, 
	ryder.lee@mediatek.com, shayne.chen@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Leon Yen <leon.yen@mediatek.com> =E6=96=BC 2025=E5=B9=B412=E6=9C=8815=E6=97=
=A5=E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=888:24=E5=AF=AB=E9=81=93=EF=BC=9A
>
> A deadlock may occur between two works, ps_work and mac_work, if their wo=
rk
> functions run simultaneously as they attempt to cancel each other by
> calling cancel_delayed_work_sync().
>
> mt792x_mac_work() ->   ...  -> cancel_delayed_work_sync(&pm->ps_work);
> mt792x_pm_power_save_work() -> cancel_delayed_work_sync(&mphy->mac_work);
>
> In high-load situations, they are queued but may not have chance to be
> executed until the CPUs are released. Once the CPUs are available, there
> is a high possibility that the ps_work function and mac_work function wil=
l
> be executed simultaneously, resulting in a possible deadlock.
>
> This patch replaces cancel_delayed_work_sync() with cancel_delayed_work()
> in ps_work to eliminate the deadlock and make the code easier to maintain=
.
>
> Signed-off-by: Leon Yen <leon.yen@mediatek.com>
Tested-by: Chia-Lin Kao (AceLan) <acelan.kao@canonical.com>

Without the patch, the system may hang during stress tests.
And now I can't reproduce the hang issue with this patch.
Thanks.

> ---
> v2: Modify the solution to make it simpler and easier to maintain
> ---
>  drivers/net/wireless/mediatek/mt76/mt792x_mac.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/net/wireless/mediatek/mt76/mt792x_mac.c b/drivers/ne=
t/wireless/mediatek/mt76/mt792x_mac.c
> index 71dec93094eb..888e5a505673 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt792x_mac.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt792x_mac.c
> @@ -375,7 +375,7 @@ void mt792x_pm_power_save_work(struct work_struct *wo=
rk)
>         }
>
>         if (!mt792x_mcu_fw_pmctrl(dev)) {
> -               cancel_delayed_work_sync(&mphy->mac_work);
> +               cancel_delayed_work(&mphy->mac_work);
>                 return;
>         }
>  out:
> --
> 2.45.2
>
>

