Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D387D984C
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Oct 2019 19:10:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406465AbfJPRKZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 16 Oct 2019 13:10:25 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:36960 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404848AbfJPRKZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 16 Oct 2019 13:10:25 -0400
Received: by mail-qk1-f195.google.com with SMTP id u184so23482081qkd.4
        for <linux-wireless@vger.kernel.org>; Wed, 16 Oct 2019 10:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kUmvgidWrzJAmUn4k8febeD4hOBuYQj6kP5p8qO7WGU=;
        b=KaKsq60gFuuHsthWEDS3OKBKEaz/05xowGVDZxnUkeOEWk1Ehdt7elud6dbUWx99xs
         whIVT6U9lImPXHHr+G1B0ohmDPxj5udXVZAp1NgpkSqShsLl/eijUHu1qpYq2VQiJ3Yc
         KHkF1flfs6dwBPKUDNCV5VqO4HxyPZo/Y2Idk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kUmvgidWrzJAmUn4k8febeD4hOBuYQj6kP5p8qO7WGU=;
        b=aTf3gTUJBLyj/5DBa+rQsT8YtlK/J1oIRtFwN5F2zZs4reOzwda4mfuDiTl5nPZlcf
         GF46RxD1v+SvnjM7OJzq0Nmbg8HOmXvYs+C/rMvx+EaD4s/2XgggHNBhOsVdFElem3r7
         wGS2S2gnedr2ddLK8tV8pVe0gfwCUmDaTRo+wx40u1iGNHwzOBKyqNL6IY0BrhfrViaz
         z6O0b51uTUyTP058/cPPr6/QZP/Pb17ZqsfMLXUsbUJuUhvUVoh2Cj7ALPdtdF7/hdzz
         +VR4su2uDQOoLkvmVOlkaf3T/KAkaGvPOFTb+KTvb5LPX+lSHc5lgO661woboOuGQUiR
         IEng==
X-Gm-Message-State: APjAAAVgoJCu0X/r61fSGm2fAvZB4iA1jC5lxUVqYdp5hJyE/ii/W5uv
        getn/aTKAgkSlCHwQJm+wlKMiD5BsxI=
X-Google-Smtp-Source: APXvYqwo2lrN5GpPzrc/jZvv902xE4W2L4ahpz8Mz65FRkntLa3AfJAPl/DJCflX9wff4rWj35YCzw==
X-Received: by 2002:a37:ba46:: with SMTP id k67mr11261397qkf.175.1571245823356;
        Wed, 16 Oct 2019 10:10:23 -0700 (PDT)
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com. [209.85.222.176])
        by smtp.gmail.com with ESMTPSA id w11sm15483918qtj.10.2019.10.16.10.10.22
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Oct 2019 10:10:22 -0700 (PDT)
Received: by mail-qk1-f176.google.com with SMTP id w2so23484985qkf.2
        for <linux-wireless@vger.kernel.org>; Wed, 16 Oct 2019 10:10:22 -0700 (PDT)
X-Received: by 2002:a37:9c0f:: with SMTP id f15mr1238861qke.62.1571245821637;
 Wed, 16 Oct 2019 10:10:21 -0700 (PDT)
MIME-Version: 1.0
References: <20191016123301.2649-1-yhchuang@realtek.com> <20191016123301.2649-2-yhchuang@realtek.com>
In-Reply-To: <20191016123301.2649-2-yhchuang@realtek.com>
From:   Brian Norris <briannorris@chromium.org>
Date:   Wed, 16 Oct 2019 10:10:10 -0700
X-Gmail-Original-Message-ID: <CA+ASDXNmMiW_FaqCKowzZW6fnBhA+JXcGBJOEToBA47EShu35A@mail.gmail.com>
Message-ID: <CA+ASDXNmMiW_FaqCKowzZW6fnBhA+JXcGBJOEToBA47EShu35A@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] rtw88: use macro to check the current band
To:     Tony Chuang <yhchuang@realtek.com>
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        linux-wireless <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, Oct 16, 2019 at 5:33 AM <yhchuang@realtek.com> wrote:
> index 4759d6a0ca6e..492a2bfc0d5a 100644
> --- a/drivers/net/wireless/realtek/rtw88/main.h
> +++ b/drivers/net/wireless/realtek/rtw88/main.h
> @@ -58,6 +58,19 @@ struct rtw_hci {
>         u8 bulkout_num;
>  };
>
> +#define IS_CH_5G_BAND_1(channel) ((channel) >= 36 && (channel <= 48))
> +#define IS_CH_5G_BAND_2(channel) ((channel) >= 52 && (channel <= 64))
> +#define IS_CH_5G_BAND_3(channel) ((channel) >= 100 && (channel <= 144))
> +#define IS_CH_5G_BAND_4(channel) ((channel) >= 149 && (channel <= 177))

There are channels between 48 and 52, 64 and 100, and 144 and 149.
What are you doing with those?

> +#define IS_CH_5G_BAND_MID(channel) \
> +       (IS_CH_5G_BAND_2(channel) || IS_CH_5G_BAND_3(channel))
> +
> +#define IS_CH_2G_BAND(channel) ((channel) <= 14)
> +#define IS_CH_5G_BAND(channel) \
> +       (IS_CH_5G_BAND_1(channel) || IS_CH_5G_BAND_2(channel) || \
> +        IS_CH_5G_BAND_3(channel) || IS_CH_5G_BAND_4(channel))

Given the above (you have major holes in 5G_BAND{1,2,3,4}), this macro
seems like a regression.

Brian
