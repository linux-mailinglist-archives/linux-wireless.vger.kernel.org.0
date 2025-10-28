Return-Path: <linux-wireless+bounces-28345-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 715A0C16BFD
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Oct 2025 21:20:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BA3D4069AD
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Oct 2025 20:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C04029E0EE;
	Tue, 28 Oct 2025 20:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YJ9coa7+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A0229CB4D
	for <linux-wireless@vger.kernel.org>; Tue, 28 Oct 2025 20:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761682806; cv=none; b=YfcfIUMJ9RJhQ/zwmHezXpnW5Jccr/E7/p0cBZfCsdiG2GJLV9FbF/OrC5py672lavO2YSzSXTP5aiFOPhq7tb8jDH0oQ1w62NvfBAuAIgjsmqUFC5AXTPtB2u3jf+rbKBt83MSJLhRIqErYrP1ShyIYfrIvWI9XG+3aNg5lICA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761682806; c=relaxed/simple;
	bh=1DL7qm57wub/f9vhoCnXsfxm9twR8KCYygrnXx0fhOc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZZPH+WX3/nQ1WmXwxpF/W3ol9svBWHwk9W5rdxE1NNcLVHekSeHA26HMvxyoJPAUp1kROUjgeR21MvvRajT2gPfLsG5nRmyKi/Z5UeBoxAFJvdSroepptL2hfHzq1FiwvdzkYOlfMA70kODZCuTIEoDPw0E5FN3zz/4F1ly6uuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YJ9coa7+; arc=none smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-63e16fbdd50so6060873d50.2
        for <linux-wireless@vger.kernel.org>; Tue, 28 Oct 2025 13:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761682804; x=1762287604; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3lEnOrPU7t9BTi0lIm6AXk0/RgDoLHUnhIVJitTcT88=;
        b=YJ9coa7+agFZT+GjtubljnQLVrI3/nFNlARYWqx2XKiwMAFEuH5pOWdpcm0wj7ppSv
         lskvQG7wh+uQNWEWm5MSp5eqnD0G2vUa/tiWKtmRVah5ij+nVEj6LhiEaCzyXiik/nlG
         +DB6lEWD/LIUi82yBVknCkJizSyRB0llrWFyll7oa7ucuVPBeNNyK0e3S0T2jUtCg3BD
         NEXEACJ0XNPFh+0qX+0R2ILuRCJmwyeJlD/0ym6ZZR+Mlu7wFPk9xtV8XcNLG8rFPVod
         V24yOR3+dxGsQRk5zqvEtsWpBW8NAmHoh4Qe92xI23/1RSXyQF10TtVFKs07kK/83aHy
         j5Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761682804; x=1762287604;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3lEnOrPU7t9BTi0lIm6AXk0/RgDoLHUnhIVJitTcT88=;
        b=cRdIXm5RQxK6ECPLy6AvaCcVWviPSiuLF0sH8KC0e4G1mt67CSfGLKEk3HibgGLSzr
         LLvQU293/+ZdW/cChNMuhxgcb7pKp/SHaUBLxl84WhXIkZtkhYIhtNurAGBQSwMRh5eb
         3/YGQIp5jr46xs2IeQCeG2L0Yv+uJdDjR4X6FWEnO04/JpRyp2zcjMaTvNLbd9wMTUHT
         2+BBvlnqXko0/5WJeSQsavgkIqVFThhvKmqrnZM/tl5Oq/XDjFN2s10rTE1q4GsQLVq0
         Udg9RblJ/ydTpqnmHnL4f6kWMTieZYt7RxDKSuDqUDDVfGhREmR7ntMU+ouK2lZu9KWA
         Gw8Q==
X-Forwarded-Encrypted: i=1; AJvYcCVeQJp6ZgHM6pcgia0TlVBopMTVdQr4lIyTX//GaxwtgHNIYWgHOPF1SNUHiBgSGEXMUH0Gg57VwgzN7MYrgA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+lTIX5aIQeIZza8pE4EEZuNX0sv+4Jag10pNpU0v8LPfneaq6
	UYAU+rE9VdpGJZaYxx+E50UInV9CK0FLhMPjmbE9Fp+EWJLZQoE0JdUrVRmahxD+2xicifxcRD/
	bX/+pbCcO/GqT5o/mHfribAjyNsXhNOU=
X-Gm-Gg: ASbGncuXaKXdw1stKQPkKLdVYIIPUN+mKIyEP4zotWPHR/1Kqz8qm0qSqkE0/JHpgbK
	jDFsdxIPCQzedTitpJ2+vwtQUOFanqQLIWhZuCh7WhJ0aDVF2lnKaioLxkWy66SE8BvPc3LWvVD
	MQSrcZ1GfXpeeJqiZpy09VSeXSjhdfrz5AzZWYT22kbsBOdCvx/LVmm7zyroqKPa1bdt+ee27zB
	q70/rTCtp0mXMhR76fSs/so0vTLzXk0bELyDrHMrjDaTQe8rjuqwx+NX1I=
X-Google-Smtp-Source: AGHT+IHgKGGElaUgkNdyxfVG3niQuHRbpKqrhRCCJLjNWkcWpoez/iaqA+lCNPGD4ysIgKN9cdylbUkkCIi+yZAgSns=
X-Received: by 2002:a05:690e:42d1:b0:635:4ecf:bdc6 with SMTP id
 956f58d0204a3-63f76dcb9eamr529307d50.40.1761682804232; Tue, 28 Oct 2025
 13:20:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251027171759.1484844-1-cjd@cjdns.fr>
In-Reply-To: <20251027171759.1484844-1-cjd@cjdns.fr>
From: Jonas Gorski <jonas.gorski@gmail.com>
Date: Tue, 28 Oct 2025 21:19:53 +0100
X-Gm-Features: AWmQ_bnFo7mm_j1RGqm_idjiztE8WhG05zba6SQTIj4ViGB8NtmMx-tKQzB1yd8
Message-ID: <CAOiHx=nSEP=4s2xZuPtLEO43YDbkNEYzw6V11JbXG0H2iPn7Ag@mail.gmail.com>
Subject: Re: [PATCH] wifi: mt76: mmio_(read|write)_copy byte swap when on Big Endian
To: Caleb James DeLisle <cjd@cjdns.fr>
Cc: nbd@nbd.name, lorenzo@kernel.org, ryder.lee@mediatek.com, 
	shayne.chen@mediatek.com, sean.wang@mediatek.com, matthias.bgg@gmail.com, 
	angelogioacchino.delregno@collabora.com, linux-wireless@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Oct 27, 2025 at 6:19=E2=80=AFPM Caleb James DeLisle <cjd@cjdns.fr> =
wrote:
>
> When on a Big Endian machine, PCI swaps words to/from LE when
> reading/writing them. This presents a problem when we're trying
> to copy an opaque byte array such as firmware or encryption key.
>
> Byte-swapping during copy results in two swaps, but solves the
> problem.
>
> Fixes:
> mt76x2e 0000:02:00.0: ROM patch build: 20141115060606a
> mt76x2e 0000:02:00.0: Firmware Version: 0.0.00
> mt76x2e 0000:02:00.0: Build: 1
> mt76x2e 0000:02:00.0: Build Time: 201607111443____
> mt76x2e 0000:02:00.0: Firmware failed to start
> mt76x2e 0000:02:00.0: probe with driver mt76x2e failed with error -145
>
> Signed-off-by: Caleb James DeLisle <cjd@cjdns.fr>
> ---
>  drivers/net/wireless/mediatek/mt76/mmio.c | 34 +++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
>
> diff --git a/drivers/net/wireless/mediatek/mt76/mmio.c b/drivers/net/wire=
less/mediatek/mt76/mmio.c
> index cd2e9737c3bf..776dbaacc8a3 100644
> --- a/drivers/net/wireless/mediatek/mt76/mmio.c
> +++ b/drivers/net/wireless/mediatek/mt76/mmio.c
> @@ -30,15 +30,49 @@ static u32 mt76_mmio_rmw(struct mt76_dev *dev, u32 of=
fset, u32 mask, u32 val)
>         return val;
>  }
>
> +static void mt76_mmio_write_copy_portable(void __iomem *dst,
> +                                         const u8 *src, int len)
> +{
> +       __le32 val;
> +       int i =3D 0;
> +
> +       for (i =3D 0; i < ALIGN(len, 4); i +=3D 4) {
> +               memcpy(&val, src + i, sizeof(val));
> +               writel(cpu_to_le32(val), dst + i);
> +       }
> +}
> +
>  static void mt76_mmio_write_copy(struct mt76_dev *dev, u32 offset,
>                                  const void *data, int len)
>  {
> +       if (IS_ENABLED(CONFIG_CPU_BIG_ENDIAN)) {
> +               mt76_mmio_write_copy_portable(dev->mmio.regs + offset, da=
ta,
> +                                             len);
> +               return;
> +       }
>         __iowrite32_copy(dev->mmio.regs + offset, data, DIV_ROUND_UP(len,=
 4));

Maybe just replace this with memcpy_toio() which does no swapping at
all instead of double swapping on BE?

>  }
>
> +static void mt76_mmio_read_copy_portable(u8 *dst,
> +                                        const void __iomem *src, int len=
)
> +{
> +       u32 val;
> +       int i;
> +
> +       for (i =3D 0; i < ALIGN(len, 4); i +=3D 4) {
> +               val =3D le32_to_cpu(readl(src + i));
> +               memcpy(dst + i, &val, sizeof(val));
> +       }
> +}
> +
>  static void mt76_mmio_read_copy(struct mt76_dev *dev, u32 offset,
>                                 void *data, int len)
>  {
> +       if (IS_ENABLED(CONFIG_CPU_BIG_ENDIAN)) {
> +               mt76_mmio_read_copy_portable(data, dev->mmio.regs + offse=
t,
> +                                            len);
> +               return;
> +       }
>         __ioread32_copy(data, dev->mmio.regs + offset, DIV_ROUND_UP(len, =
4));

And memcpy_fromio() here.

Best regards,
Jonas

