Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94D7A7A8FDE
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Sep 2023 01:31:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229478AbjITXbr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 20 Sep 2023 19:31:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjITXbq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 20 Sep 2023 19:31:46 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7706C2
        for <linux-wireless@vger.kernel.org>; Wed, 20 Sep 2023 16:31:40 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-69101022969so284845b3a.3
        for <linux-wireless@vger.kernel.org>; Wed, 20 Sep 2023 16:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695252700; x=1695857500; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=G/eEH2queOwNg5/I2SCWhXDAO5cqtfOn/DksmwR4ju4=;
        b=RxWOJXJYBP+YGeOlw6nwDALK21LKSmxX4C0df9gaVfQa+IW5f2lvg4SuQ4R0s8rxI6
         fgj0Y3xAEMbDAtXtxQS85kNZCbugeIXqOnEPLgV+CExXeYzlXBFwgGfFA7Tk8zTSgPyw
         C+8SwyJhCBWJFjcMPTWLWSpyx8nNqvEeCTa/I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695252700; x=1695857500;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G/eEH2queOwNg5/I2SCWhXDAO5cqtfOn/DksmwR4ju4=;
        b=pPapANn5s9WtUfSnWMiO6+G/3g/WUQhI29eMWUlgeoEEM5cBk7p49rNDS2SXC8VHn/
         7x6P4N8lLabqHWcUAXq+2e+JHfr2hFyO/Dl/pdFFaBDIr8xJcVVJ0PclTPcXtG2Ut1K6
         WbPHo+pbtWQ7BFh31PsZHU23M4OrnKUPrk/FyDLTH6PjPHZTScMPX1SyBw9lnr6IMEGo
         jZZCdOxdGPX2RBsgqoR4b/vKtMD7BKHFuFW4bWSeJ2lSzVc+9bI2NOAvlkZM/OzmvSAe
         m3fTO6SuX3WppXMiruQ4zBLReE7Rai1YUpzbNfMflfJM7kvkynFWAB9tqj+eq0QKDhJR
         7VSQ==
X-Gm-Message-State: AOJu0YxHZvUdI9gUMv4t+lbefipYbTAFFtHGyl0UdGMAKWkKRLSO/vRG
        EosTTV/mDYcoMlSNdB0pV2tDmQ==
X-Google-Smtp-Source: AGHT+IHkdrMJ/bHH0JTESKCeXtWqfq+3kDhgNBlcPJ9Jn3JCjYpFJBRwbFhgIfCoufEO/g2GjPeUjQ==
X-Received: by 2002:a05:6a00:2d23:b0:68c:6a77:4845 with SMTP id fa35-20020a056a002d2300b0068c6a774845mr4497243pfb.12.1695252700319;
        Wed, 20 Sep 2023 16:31:40 -0700 (PDT)
Received: from localhost ([2620:15c:9d:2:23d5:c394:2c98:ffcf])
        by smtp.gmail.com with UTF8SMTPSA id g23-20020aa78757000000b00690cd49cee2sm76997pfo.63.2023.09.20.16.31.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Sep 2023 16:31:39 -0700 (PDT)
Date:   Wed, 20 Sep 2023 16:31:38 -0700
From:   Brian Norris <briannorris@chromium.org>
To:     Dmitry Antipov <dmantipov@yandex.ru>
Cc:     Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        lvc-project@linuxtesting.org
Subject: Re: [PATCH 1/2] wifi: mwifiex: simplify PCIE write operations
Message-ID: <ZQuA2u9l1mCRVYdz@google.com>
References: <20230919132804.73340-1-dmantipov@yandex.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230919132804.73340-1-dmantipov@yandex.ru>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, Sep 19, 2023 at 04:27:59PM +0300, Dmitry Antipov wrote:
> Since 'mwifiex_write_reg()' just issues void 'iowrite32()',
> convert the former to 'void' and simplify all related users
> (with the only exception of 'read_poll_timeout()' which
> explicitly requires a non-void function argument).
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
> ---
>  drivers/net/wireless/marvell/mwifiex/pcie.c | 290 +++++---------------
>  1 file changed, 66 insertions(+), 224 deletions(-)

Acked-by: Brian Norris <briannorris@chromium.org>

> diff --git a/drivers/net/wireless/marvell/mwifiex/pcie.c b/drivers/net/wireless/marvell/mwifiex/pcie.c
> index 6697132ecc97..88f632b9dd93 100644
> --- a/drivers/net/wireless/marvell/mwifiex/pcie.c
> +++ b/drivers/net/wireless/marvell/mwifiex/pcie.c
...  
> +/* Non-void wrapper needed for read_poll_timeout(). */
> +static inline int
> +mwifiex_write_reg_rpt(struct mwifiex_adapter *adapter, int reg, u32 data)

This is kind of a weird name, but I don't have better suggestions. Maybe
it helps dissuade people from using it outside its very specific context
(where you have to read the comment to understand what "rpt" means).
