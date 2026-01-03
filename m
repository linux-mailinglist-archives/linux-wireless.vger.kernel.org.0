Return-Path: <linux-wireless+bounces-30308-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 41745CEFBEE
	for <lists+linux-wireless@lfdr.de>; Sat, 03 Jan 2026 07:46:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3D82F300B988
	for <lists+linux-wireless@lfdr.de>; Sat,  3 Jan 2026 06:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 344A73BB5A;
	Sat,  3 Jan 2026 06:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qOf8rGop"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F368A55
	for <linux-wireless@vger.kernel.org>; Sat,  3 Jan 2026 06:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767422777; cv=none; b=vBIvJ5rNPPj8mgTOfrtKsw2ojw+y5zZ55nKzLnFMnWM1oDfWlQEfZcubB28bEnVI6fU4OBfBr2/g5p9vqCs7ArH3yzEMeMdKSuGIyRmsRKlYszDMgPOSYSLv7uViG3Tq7g/6Q9sZOqmVRSUJNSLZBv+cLrqsud955YRzU+11bM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767422777; c=relaxed/simple;
	bh=fKyT9YQ1JG7A9UW+J+VZvz2mXTizPcVyVmn/tQIYOU8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BL4zg5hqM97jTm1k2mpLM2Sv7vYSSMuc5oS99kGCaoZevL8DA5EO5u1Dw/+zoYI0SK1i8EcGfd7KtS327h7/FvcNsjNKwxApHmNXCoiNqzsEhUh6D22H958tstCZvCHyIaT8PlR0+zUc9SxZzT0oqtdwZthivoV2I5RPsHw5BEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qOf8rGop; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FDFBC19423
	for <linux-wireless@vger.kernel.org>; Sat,  3 Jan 2026 06:46:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767422776;
	bh=fKyT9YQ1JG7A9UW+J+VZvz2mXTizPcVyVmn/tQIYOU8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=qOf8rGopTKafTAiQyIcVzPreI6PDPhP9AdJjJsPaDgk/If6fYJGnJ+y9WoqWHUw1B
	 gZqSLoAlSWuSgwPaT6eyTJOz6fAgJFTlt8v5FpGRji+pabrm/2Neb6RRO+vm7VWt5W
	 kQhQXMEeyfH5djCqloRe+FPoRTeD33mIiAZzFv0slUEraMxNR2yBUZNGFgO9njI34E
	 tDc7FgUkwfTbi+BmQn00vqc7ie17G08pIyrpGlKz7VzaKzXiyyz5gdEx/7bSl438Rl
	 jPZst0mL7XEf9Xt/c3TN53yNbcbGdxn5uNmfOmFouU8gdypszzxkvkJzsnOSZwMT0n
	 paieNo0M93dDw==
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5943b62c47dso11966872e87.1
        for <linux-wireless@vger.kernel.org>; Fri, 02 Jan 2026 22:46:16 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUlyAMLSmtEKI08pbxNCENZxKi4sN6wBLg5sqSm5PR35uE1xDx29q3Ev1vfYqqOA+lTLZ7rTcWyy8ecS34stQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwR1upsKD5XwCm5hZZcbiH5RwuSxUlKZS3XSQHkIc5lu5WUYjZt
	pIWw7axTwsp+YvdnLQduMSFf6wVO+coUzIYFkkr7hGX9H0uTa7rg3xmvFt1ZRDmeI0O8oQJ/ZPu
	/71g1Uvd0KRuQUbRoqulIkRqkfO26YiU=
X-Google-Smtp-Source: AGHT+IHXZ7D+FgPyIoTbZMNwsQhnnk+pRJDN0D/PxGXyy/t7T8KOZL5gpJOs2sze55vkNZd5OgU6UTSr6tnOuKvr2Bo=
X-Received: by 2002:a05:6512:220e:b0:594:2f72:2f7b with SMTP id
 2adb3069b0e04-59a17d00274mr13419800e87.6.1767422774918; Fri, 02 Jan 2026
 22:46:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260101062543.186499-1-zbowling@gmail.com> <20260102200315.290015-1-zbowling@gmail.com>
 <20260102200315.290015-5-zbowling@gmail.com>
In-Reply-To: <20260102200315.290015-5-zbowling@gmail.com>
From: Sean Wang <sean.wang@kernel.org>
Date: Sat, 3 Jan 2026 00:46:03 -0600
X-Gmail-Original-Message-ID: <CAGp9LzrdvaPPLUi9TgenXvD6jWdOK-=95D_Fo2UYOppyzGPprw@mail.gmail.com>
X-Gm-Features: AQt7F2pIoQVOw-nvZQpZLafgk1Bl34hZ8-Lvcuuid17YYwHEJSDX5uwl3bFn_5g
Message-ID: <CAGp9LzrdvaPPLUi9TgenXvD6jWdOK-=95D_Fo2UYOppyzGPprw@mail.gmail.com>
Subject: Re: [PATCH] wifi: mt76: mt792x: fix firmware reload failure after
 previous load crash
To: Zac Bowling <zbowling@gmail.com>
Cc: deren.wu@mediatek.com, kvalo@kernel.org, linux-kernel@vger.kernel.org, 
	linux-mediatek@lists.infradead.org, linux-wireless@vger.kernel.org, 
	lorenzo@kernel.org, nbd@nbd.name, ryder.lee@mediatek.com, 
	sean.wang@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 2, 2026 at 2:03=E2=80=AFPM Zac Bowling <zbowling@gmail.com> wro=
te:
>
> If the firmware loading process crashes or is interrupted after
> acquiring the patch semaphore but before releasing it, subsequent
> firmware load attempts will fail with 'Failed to get patch semaphore'
> because the semaphore is still held.
>
> This issue manifests as devices becoming unusable after suspend/resume
> failures or firmware crashes, requiring a full hardware reboot to
> recover. This has been widely reported on MT7921 and MT7925 devices.
>
> Apply the same fix that was applied to MT7915 in commit 79dd14f:
> 1. Release the patch semaphore before starting firmware load (in case
>    it was held by a previous failed attempt)
> 2. Restart MCU firmware to ensure clean state
> 3. Wait briefly for MCU to be ready
>
> This fix applies to both MT7921 and MT7925 drivers which share the
> mt792x_load_firmware() function.
>
> Fixes: 'Failed to get patch semaphore' errors after firmware crash
> Signed-off-by: Zac Bowling <zac@zacbowling.com>
> ---
>  mt792x_core.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/mt792x_core.c b/mt792x_core.c
> index cc488ee9..b82e4470 100644
> --- a/mt792x_core.c
> +++ b/mt792x_core.c
> @@ -927,6 +927,20 @@ int mt792x_load_firmware(struct mt792x_dev *dev)
>  {
>         int ret;
>
> +       /* Release semaphore if taken by previous failed load attempt.
> +        * This prevents "Failed to get patch semaphore" errors when
> +        * recovering from firmware crashes or suspend/resume failures.
> +        */
> +       ret =3D mt76_connac_mcu_patch_sem_ctrl(&dev->mt76, false);
> +       if (ret < 0)
> +               dev_dbg(dev->mt76.dev, "Semaphore release returned %d (ma=
y be expected)\n", ret);
> +
> +       /* Always restart MCU to ensure clean state before loading firmwa=
re */
> +       mt76_connac_mcu_restart(&dev->mt76);
> +
> +       /* Wait for MCU to be ready after restart */
> +       msleep(100);
> +

Hi Zac,

This is a good finding. Since this is a common mt792x code path, have you
also had a chance to test it on MT7921?

One small nit: the Fixes tag should reference the actual commit being
fixed, e.g.

  Fixes: <commit-sha> ("mt76: mt792x: ...")

instead of the error string.

                  Sean

>         ret =3D mt76_connac2_load_patch(&dev->mt76, mt792x_patch_name(dev=
));
>         if (ret)
>                 return ret;
> --
> 2.51.0
>
>
>

