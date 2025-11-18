Return-Path: <linux-wireless+bounces-29094-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A623C68DFE
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Nov 2025 11:41:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 895F84E2193
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Nov 2025 10:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59EAB1C5D6A;
	Tue, 18 Nov 2025 10:41:04 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CF7A34677A
	for <linux-wireless@vger.kernel.org>; Tue, 18 Nov 2025 10:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763462464; cv=none; b=V4wJaQ5eVTeuLNb13jtOwqjo0bUUyKwcBP/Ico2yq7HyYGLt6ROXqfN4qc1j4At3I7nf7HdowIIPM2gE/hW6kBkkBak8XNanZI+HEsFDH94H4QVvkVQDTPyHTiO++D37QlHjLG9oRvXGCjS6vqeQaG17eySKJPXGSCHu6rbrh80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763462464; c=relaxed/simple;
	bh=d/WSm9QXC7flvcu/nbgFHrON+k3egcMAh1fYY7kEg6E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MBQ+OoVBSvK3UBHZ4xwf9gnbb1DeBLOMbfVKYEqOxzvc3dYd+Ksj1+f2HlyS0qamBg0bGNLtH+Nhj21gm9Db5imxcVfyTXF0aNYM/G2GpCdOb+2NXuvDZDRDyUIdkrrR3xB2TnqvM6iql+brVUX8paRTuHYg44Xc8Awb1YZnBS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-5dd88eef2f3so2067435137.3
        for <linux-wireless@vger.kernel.org>; Tue, 18 Nov 2025 02:41:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763462461; x=1764067261;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xVx8yY1J/G5V4XJgPz81bDd6fwmroBV4tv9yV9Oi4Fg=;
        b=LWRWoxhIt30bDYXGTbzWn2a1PkcVgdOOwtnMPoxcGY5N7ADKFTirHepqD/DFDJ6z9T
         yQSN7vEvSD2yJS3TEdGlvwaQh6ohL8DOrwDWyR6Fzz7t/YuWapsyA4vNteXO67sbOEl2
         kCBsZ+wd66rLdiIXO14F0a5Ar9jaFXFC9ncv7LhHv9S7DsXEvmP+0EX4kv7i7uPQPz5x
         UAtre4K2w+2+emIaReuukK/iHjyXNeQ/UT2F7wVJEAGM0x9xrtM68K5h5yPmRwi7OYi1
         7VdLurdmwwokWIJ3Roef4G54Tqo+Vrsw6R6tAqphPgFVuRbCIW3rkq3u6NdSokD+SDpS
         DDNA==
X-Gm-Message-State: AOJu0YzPEazvGRicZnrD3VFPRHxp4K8YXlDBWZ5cfON6YnQOxpQgwMC2
	/225BnLViNz9P8rnVnkqQmDsWHuq3EjZvAB5iZD6ENqyz1/PQDhb1JZKv5PniKBvP8c=
X-Gm-Gg: ASbGncuw+63Gr/GEcK3zDhaRC71cDPrBgkrLuVFGvsVo0RqG0pKGNu9iH88NHq0ZhjG
	SAvn3h8GX6fF6o+G8EJPyJm6LxQkwE/PDEvb7oGxnehiX41VoRiDEpizm2apFmE5GqsMH/Mxd4H
	Hr1/sl3ZY8m1hejR15GoXQyl3cy7tcMCgtbs7L2YaNJITHYT4nPq38HnqQ3hr3G0XHjPDzL+nAe
	yhrbXim2+qtnXhqZFcz/6tDAq3kTSz1D9zJv2dx2IjPVsBee/72foxxoPSK/rtcQZo7SyhE5KQU
	SUrWmbVtonynHRMeiQTVYfha5Rpu3TaZIpNn9bJLdEGHRxFnnMm0FnP1J9NoajhRO567D6ZeRf8
	V0OobHjTnublEWZp/1WVBZzcGKlXadTivt6skYheMJNul9dlhuAEYOfoEL+EUNL9QZFTAz06ANI
	FLGETxpcJT+CFuEbSsICjQYjzIIgvfpb2MP70Dz97EB5gvf6kg
X-Google-Smtp-Source: AGHT+IHuo6qEYdSyaQw1NCYEPz3Lu00lTazyFg5p623XsSaBQK2cY41VabyXm6kv6H+LXFKdQmRpLQ==
X-Received: by 2002:a05:6102:b06:b0:5df:aff3:c41c with SMTP id ada2fe7eead31-5dfc5b6b717mr4847320137.30.1763462460668;
        Tue, 18 Nov 2025 02:41:00 -0800 (PST)
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com. [209.85.222.54])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-937610d48b9sm4821615241.2.2025.11.18.02.41.00
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Nov 2025 02:41:00 -0800 (PST)
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-9371f6f2813so1464046241.0
        for <linux-wireless@vger.kernel.org>; Tue, 18 Nov 2025 02:41:00 -0800 (PST)
X-Received: by 2002:a05:6102:2928:b0:5db:ce1d:67a2 with SMTP id
 ada2fe7eead31-5dfc54feea5mr5039367137.1.1763462460131; Tue, 18 Nov 2025
 02:41:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251117032910.11224-1-pkshih@realtek.com> <20251117032910.11224-3-pkshih@realtek.com>
In-Reply-To: <20251117032910.11224-3-pkshih@realtek.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 18 Nov 2025 11:40:49 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUx6qY66bCcGsm1YHK3=H+=Td6YM_gsXJ=UgjAYJpGo0Q@mail.gmail.com>
X-Gm-Features: AWmQ_bkck10JrORXQvJ_TwbOk-WbubLPvqr07bd4Jr-aUUWydbwHXflagUWYQZo
Message-ID: <CAMuHMdUx6qY66bCcGsm1YHK3=H+=Td6YM_gsXJ=UgjAYJpGo0Q@mail.gmail.com>
Subject: Re: [PATCH rtw-next 2/2] wifi: rtw89: avoid to use not consecutive
 mask in __write_ctrl()
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Ping-Ke,

On Mon, 17 Nov 2025 at 04:30, Ping-Ke Shih <pkshih@realtek.com> wrote:
> The power value and enable bit fields can be not consecutive mask, but
> normally we expect mask argument of rtw89_mac_txpwr_write32_mask() is
> consecutive bit mask. Therefore, change the code accordingly.
>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

Thanks for your patch!

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

> --- a/drivers/net/wireless/realtek/rtw89/mac.h
> +++ b/drivers/net/wireless/realtek/rtw89/mac.h
> @@ -1456,6 +1456,26 @@ static inline int rtw89_mac_txpwr_write32_mask(struct rtw89_dev *rtwdev,
>         return 0;
>  }
>
> +static inline
> +void rtw89_mac_write_txpwr_ctrl(struct rtw89_dev *rtwdev, u32 reg, u32 mask, u32 val,
> +                               u32 mask_en, bool cond)
> +{
> +       u32 wrt = u32_encode_bits(val, mask);

Nit: you could do without this variable...

> +       u32 val32;
> +       int ret;
> +
> +       if (cond)
> +               wrt |= mask_en;
> +
> +       ret = rtw89_mac_txpwr_read32(rtwdev, RTW89_PHY_0, reg, &val32);
> +       if (ret)
> +               return;
> +
> +       val32 &= ~(mask | mask_en);
> +       val32 |= wrt;

val32 |= u32_encode_bits(val, mask);
if (cond)
        cal32 |= mask_en;

> +       rtw89_mac_txpwr_write32(rtwdev, RTW89_PHY_0, reg, val32);

As this calls mac->get_txpwr_cr() a second time, perhaps it is better to
open-code rtw89_mac_txpwr_read32() and rtw89_mac_txpwr_write32()
in this function?

> +}
> +
>  static inline void rtw89_mac_ctrl_hci_dma_tx(struct rtw89_dev *rtwdev,
>                                              bool enable)
>  {

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

