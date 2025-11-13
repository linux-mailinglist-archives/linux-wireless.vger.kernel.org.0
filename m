Return-Path: <linux-wireless+bounces-28909-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BACC5C57AAF
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Nov 2025 14:31:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D2C873436DC
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Nov 2025 13:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B51441A26B;
	Thu, 13 Nov 2025 13:30:52 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9650429CE1
	for <linux-wireless@vger.kernel.org>; Thu, 13 Nov 2025 13:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763040652; cv=none; b=MeAiPWgTlVWCvx1449P+95LHpk7xIDLYGcGvrf5X8wV5igp4REg449mxPuYHNDjZWlVfunpVWPpjUnMKackIOw2yrQGEKplYEUZMsICtXbRg86PvsQFW5gsYWqgu55X/BkZJNnXCjAfe1oI4hN81/EX5bnwS3Sy51lhKGye6G0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763040652; c=relaxed/simple;
	bh=edLroLDW6BuSG8ih+IbQOrGbMF6Aj5wue8zpNLndekg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hCgTC8G/pWM30bmYjTj37SkXuFPo2LE9t417Giw4mB0QiRvakpGu0LuwmWUPEV4j8tXYNymRx6WRfDLt6RG5FsiDcdvJe7LJYwbs7VV8pd3PQsiO36D+fILJvJdlsLB8seEsz4tz0lsinLqW/AP6p0Uhy/4qZ1onbYBtdjXK6oU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-5dfa9e34adbso631426137.0
        for <linux-wireless@vger.kernel.org>; Thu, 13 Nov 2025 05:30:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763040649; x=1763645449;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+xLL9o7GE3sjvNnv0gmcUpp0gtXE6Km3k6dzTeJTvuM=;
        b=jnI3MQn1lX2VvGXUrJqhPqWGbqErjgKpyGAf4UyVqL10Qcnmsg+NI1XW4nNS1iHk0C
         GyX8keONc+K+HUsrAKVi8pmr02wwf0JhzfNXaCN4J4zzn/XFS1Ai58PED5QmzpO9ruXH
         xhy2NOm86OYzDIwSXPpGcDbXTmUv5ssslXmKERWOjOpM6mSISxTCv1rAh4zk2jBW508z
         GzC7VoEca+93hI5L9NZKdPVvlPYlR63kmdQJTEfuSrkeiVuon6+p4lLiHNzkrLlvFs8O
         qCn9F6qR1CPBt68beJt3K8FO9ulBt14sL3sm/qjp4w7MjaPsk8FhYOAwlNgziPZ/09sA
         zapQ==
X-Gm-Message-State: AOJu0YyemngGY/9R1o27s+P3DILEEk3lQXc3+t5P5XjpLZKR2H7FFsg/
	jWiY0vAGBFdxOs3wm0FXS/XF4SReZB2czw/wZ8qSPtBildvosWe7NYNvwPcWPn09Q3c=
X-Gm-Gg: ASbGncsPpzKn2E4SC9SRUKG9ft9DvXBfvMkXwe+ijwFR7OcYa0zF1fvJEfOKq13mq3L
	xcrfJow9QaJ3eQk3nDALWsPl/aFXehMISS8hZTEeWB+37PVkEU1Xo0uc7VNqcR55+BahYlxCaWB
	byWkkyzvhoIKF3TErDkQNJPA2vjt2UgAWy1+tmVtS1wFMruDrnHweUCUugq2oqRmJVEvTV5yIn+
	Gc9x7ksDTAT2nyLtpAEf5uTrQV7q6w1KDqM9vFyqBm67wCC/Z30Z2iI/ZdlgHlChfUNY6/MRKCl
	BeSHO8wVBAX08HLRXiCMOYIieXTPz95FBmX2TQA68qY1xZvQTcl9xGm42SlkdaiPL4rUkjoarTA
	42eLw2G5Hm+TQEhVu/EfMT8uv5nhdpOCRVax7FZr+7B5Osr24891fOTeX16IYz5WjJV0liChVHt
	HDzfihllmOvfQIcPhwo6CarQG1FhNxts7yyJRl1Q==
X-Google-Smtp-Source: AGHT+IFTN3IyYro9PpEG5ht1fPFuBwmMdKJ+HHEGP++5oTLz/UO72+4C0dHryFgpBd8JsWP7ADLyqg==
X-Received: by 2002:a05:6102:5087:b0:5dd:b2a1:e9a5 with SMTP id ada2fe7eead31-5de07ce480cmr2158447137.5.1763040649103;
        Thu, 13 Nov 2025 05:30:49 -0800 (PST)
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com. [209.85.217.53])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5dfb707557esm572369137.1.2025.11.13.05.30.48
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Nov 2025 05:30:48 -0800 (PST)
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-5d967b67003so565355137.2
        for <linux-wireless@vger.kernel.org>; Thu, 13 Nov 2025 05:30:48 -0800 (PST)
X-Received: by 2002:a05:6102:2ac2:b0:5db:debf:6588 with SMTP id
 ada2fe7eead31-5de07ceed37mr2334999137.9.1763040648654; Thu, 13 Nov 2025
 05:30:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251113053459.34995-1-pkshih@realtek.com>
In-Reply-To: <20251113053459.34995-1-pkshih@realtek.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 13 Nov 2025 14:30:36 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVt+5yOA6tuasX4KQgZud5wtRwu0A15UkEfQJbcd_xvVw@mail.gmail.com>
X-Gm-Features: AWmQ_bl9-EIG_hqFvxyD3TurlNbXdi7JE26tgKoO_Uh9D7h-E_KCa7Chg2iqLSI
Message-ID: <CAMuHMdVt+5yOA6tuasX4KQgZud5wtRwu0A15UkEfQJbcd_xvVw@mail.gmail.com>
Subject: Re: [PATCH rtw-next] wifi: rtw89: use separated function to set RX filter
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Ping-ke,

On Thu, 13 Nov 2025 at 06:35, Ping-Ke Shih <pkshih@realtek.com> wrote:
> Normally use rtw89_write32_mask() with a consecutive bit mask, but mask of
> RX filter B_AX_RX_FLTR_CFG_MASK is bits 31-22 and 15-0, which excludes bits
> of B_AX_RX_MPDU_MAX_LEN_MASK (bits 21-16).
>
> Though the original logic is well to set RX filter, change it to a separate
> function to avoid the tricky design.
>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

> I plan to have this change in next release cycle, and then you can send
> your patches without errors caused by this.

I found two more classes of issues:

  1. drivers/net/wireless/realtek/rtw89/rtw8852a_rfk.c has twice:

          rtw89_phy_write32_mask(rtwdev, R_ADC_FIFO, B_ADC_FIFO_RST, 0x0303);

     B_ADC_FIFO_RST is only 8 bits wide, so 0x0303 does not fit.
     Other call sites write the magic value 0x0303 to B_ADC_FIFO_RXK,
     so perhaps that field was intended?

         #define B_ADC_FIFO_RST GENMASK(31, 24)
         #define B_ADC_FIFO_RXK GENMASK(31, 16)

  2. drivers/net/wireless/realtek/rtw89/rtw8851b.c
     drivers/net/wireless/realtek/rtw89/rtw8852b.c
     drivers/net/wireless/realtek/rtw89/rtw8852c.c

           __write_ctrl(R_AX_PWR_COEXT_CTRL, B_AX_TXAGC_BT_MASK, val,
                        B_AX_TXAGC_BT_EN, arg.ctrl_gnt_bt != 0xffff);

     B_AX_TXAGC_BT_MASK and B_AX_TXAGC_BT_EN are combined,
     thus forming a non-consecutive mask.

         #define B_AX_TXAGC_BT_EN BIT(1)
         #define B_AX_TXAGC_BT_MASK GENMASK(11, 3)

Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

