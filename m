Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 720D565BF34
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Jan 2023 12:44:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232970AbjACLnl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 3 Jan 2023 06:43:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237490AbjACLnV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 3 Jan 2023 06:43:21 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A14B10552
        for <linux-wireless@vger.kernel.org>; Tue,  3 Jan 2023 03:42:15 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id d10so19923418pgm.13
        for <linux-wireless@vger.kernel.org>; Tue, 03 Jan 2023 03:42:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RTbVdnoB1fMA8FNeVWq5aGNuZkP6XciThsh+OBKTYD4=;
        b=W9VQjRGeE+vvNlT5VVXgPOmuDhBAg5qQKSYzDVjCoWxkxwlzsD/pGmII8Ij1CUMhZw
         Rs3P0NkMe4HgA9P1bSFq3ejHFtGaXw34lxEWEMzPn5KOnB0xFSaWyVatxcDcnWDio9fP
         qWNcQsua0fvBLfXj7IbIs0QSF0AzCpST0zQB4xMivizekA58MPANYowkcpUy/oWQvizC
         zPUkQDzzK25qhOwI4qh953SY7RbswNadWp9/SifpatN2iD98LiVIsSYxgmRjJUkUotG4
         ln7GEkrYJeqBASMLDRzbx1DjdVFOkM5GKKhI4EMvnhXp0Fcq9hxcew02DUxRRpADPAXj
         AzQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RTbVdnoB1fMA8FNeVWq5aGNuZkP6XciThsh+OBKTYD4=;
        b=I+k64UL2KdTehqINYGi0NJgp5JCxoBwrR2WYe28npdw9vaXqEfv6VX4iy1DtCK2JdS
         xMi+SX8YYgwyZcJaHQnGCrgFZeDLoNhdWRyr41T8ozv0/4AQ7ExxgrjTHVXRa2tZTS4P
         UEmyo/R87bcsigKak9jTbsZrUj7of2PgBFyFWjBtukfLIoxZj69OYlJ+gP1iRec4O20W
         l8ctqy/d2TE8+7vEbagJt54hI+8Nn6zJ+kC44fxjSIchIqSd2tGE9pnSXdyAtR0J6ZDY
         ebSjEe6iC9pQw7gTC/nYUwFNedrUtB8wL+7nO2DthWoLiRYfrQGvGUP+gRrHhRPuNvq9
         Zb/w==
X-Gm-Message-State: AFqh2krZ7PRHjL8RobJzEghvHi+by9rWv+XIzc51q0c2xPhIZYrwKw34
        mguL8SyRVlKyX5KUNgMMI9Gq6+52MDBzbMAvcmZ3iQ==
X-Google-Smtp-Source: AMrXdXuM55BejzFIXuf7gfODVrmZwD5SLGcZjDBNHOBWM5NE24dlP2dnqyG2D3P5Sc8VFW3/DJc/WoDxcsrFnm3LW0I=
X-Received: by 2002:a62:2f07:0:b0:580:b57:f7ad with SMTP id
 v7-20020a622f07000000b005800b57f7admr2194756pfv.28.1672746135008; Tue, 03 Jan
 2023 03:42:15 -0800 (PST)
MIME-Version: 1.0
References: <20221227233020.284266-1-martin.blumenstingl@googlemail.com> <20221227233020.284266-6-martin.blumenstingl@googlemail.com>
In-Reply-To: <20221227233020.284266-6-martin.blumenstingl@googlemail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 3 Jan 2023 12:41:38 +0100
Message-ID: <CAPDyKFqJRL8Ngh1rj=tvr142WcwqSCNTWeGDVD4vto=Y8Fvj4A@mail.gmail.com>
Subject: Re: [RFC PATCH v1 05/19] mmc: sdio: add Realtek SDIO vendor ID and
 various wifi device IDs
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     linux-wireless@vger.kernel.org,
        Yan-Hsuan Chuang <tony0620emma@gmail.com>,
        Kalle Valo <kvalo@kernel.org>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, linux-mmc@vger.kernel.org,
        Chris Morgan <macroalpha82@gmail.com>,
        Nitin Gupta <nitin.gupta981@gmail.com>,
        Neo Jou <neojou@gmail.com>, Pkshih <pkshih@realtek.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, 28 Dec 2022 at 00:30, Martin Blumenstingl
<martin.blumenstingl@googlemail.com> wrote:
>
> Add the SDIO vendor ID for Realtek and some device IDs extracted from
> their GPL vendor driver. This will be useful in the future when the
> rtw88 driver gains support for these chips.
>
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

I assume it's easier if Kalle picks up this patch, along with the series. So:

Acked-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe


> ---
>  include/linux/mmc/sdio_ids.h | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/include/linux/mmc/sdio_ids.h b/include/linux/mmc/sdio_ids.h
> index 74f9d9a6d330..bba39d4565da 100644
> --- a/include/linux/mmc/sdio_ids.h
> +++ b/include/linux/mmc/sdio_ids.h
> @@ -111,6 +111,15 @@
>  #define SDIO_VENDOR_ID_MICROCHIP_WILC          0x0296
>  #define SDIO_DEVICE_ID_MICROCHIP_WILC1000      0x5347
>
> +#define SDIO_VENDOR_ID_REALTEK                 0x024c
> +#define SDIO_DEVICE_ID_REALTEK_RTW8723BS       0xb723
> +#define SDIO_DEVICE_ID_REALTEK_RTW8723DS       0xd723
> +#define SDIO_DEVICE_ID_REALTEK_RTW8821BS       0xb821
> +#define SDIO_DEVICE_ID_REALTEK_RTW8821CS       0xc821
> +#define SDIO_DEVICE_ID_REALTEK_RTW8821DS       0xd821
> +#define SDIO_DEVICE_ID_REALTEK_RTW8822BS       0xb822
> +#define SDIO_DEVICE_ID_REALTEK_RTW8822CS       0xc822
> +
>  #define SDIO_VENDOR_ID_SIANO                   0x039a
>  #define SDIO_DEVICE_ID_SIANO_NOVA_B0           0x0201
>  #define SDIO_DEVICE_ID_SIANO_NICE              0x0202
> --
> 2.39.0
>
