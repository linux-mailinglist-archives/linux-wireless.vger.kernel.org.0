Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C629B7A8FE1
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Sep 2023 01:36:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbjITXgR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 20 Sep 2023 19:36:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjITXgQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 20 Sep 2023 19:36:16 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2614BCF
        for <linux-wireless@vger.kernel.org>; Wed, 20 Sep 2023 16:36:11 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1c364fb8a4cso3047745ad.1
        for <linux-wireless@vger.kernel.org>; Wed, 20 Sep 2023 16:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695252970; x=1695857770; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=D7JKFpBTbm9XTEjmKLjqAg/TV0MkrJSGCfGc8p5dTYc=;
        b=XLM/7WHlmG9tzXtO0V93RbCWBrfBh+W1tzAT2HA2AN+E+lFS77bDoR+/gQz+p0ivpR
         BG70UY04sH6vW0Wwyr2ZUorlDdy0lWUJo5buyu4SZzYaFHo/CLVfyQgKAz2DyphGviQR
         zGLBt4hzh3o4VXti583rKfmM+ZOZ6GPS7Q/d4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695252970; x=1695857770;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D7JKFpBTbm9XTEjmKLjqAg/TV0MkrJSGCfGc8p5dTYc=;
        b=oPpy1U/ZNqZO8NHC/DpYQQJXnmMW5Uk9MJChuyItNpBGc2FWhIlrMDOYcbK4LvEPGG
         tYe/ifbT+zQtrzZ4NFyu5AiCQrWa7bjAO2i6gwps43AZ4c0D0oA7ouKnalxmS/tpLAu1
         mbfpf2jl4At6V3kSJzmhE7tdeZARQX8sSScyZGetJO0ZF9ahrw+oxV9W7HWjQLl6WuTS
         POQUH/riD0R0+WFWbsSAgOZtvXtHb2j50h/0w5M4/5h8qRUEG3p5YqezhyHlMbVgDVqd
         cixStqk/Ze5G4hDDuVO30WUxcBvhrtOeUD5I/ipXnRxJ9OKNSn4ixgVUfxWUcnk534Ia
         R+Iw==
X-Gm-Message-State: AOJu0YwyLmV2Gxjrv/KNh6iw+GkVUIsQp2kHc3H/drYeWoKOwdQIMORP
        tBNDixxiMcfOo3/9tjtyPj34DA==
X-Google-Smtp-Source: AGHT+IGebuKrLTYmK0OScSbI9IPrH/cE/jGUrcGcRBb77s67xLjgKNLZNK9IaPyARDQzwq43m5QYYg==
X-Received: by 2002:a17:902:6806:b0:1b9:ea60:cd82 with SMTP id h6-20020a170902680600b001b9ea60cd82mr3490309plk.5.1695252970631;
        Wed, 20 Sep 2023 16:36:10 -0700 (PDT)
Received: from localhost ([2620:15c:9d:2:23d5:c394:2c98:ffcf])
        by smtp.gmail.com with UTF8SMTPSA id 6-20020a170902e9c600b001bdcafcf8d3sm65472plk.69.2023.09.20.16.36.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Sep 2023 16:36:10 -0700 (PDT)
Date:   Wed, 20 Sep 2023 16:36:09 -0700
From:   Brian Norris <briannorris@chromium.org>
To:     Dmitry Antipov <dmantipov@yandex.ru>
Cc:     Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        lvc-project@linuxtesting.org
Subject: Re: [PATCH 2/2] wifi: mwifiex: followup PCIE and related cleanups
Message-ID: <ZQuB6aEcMGSsmvLs@google.com>
References: <20230919132804.73340-1-dmantipov@yandex.ru>
 <20230919132804.73340-2-dmantipov@yandex.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230919132804.73340-2-dmantipov@yandex.ru>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, Sep 19, 2023 at 04:28:00PM +0300, Dmitry Antipov wrote:
> Introduce a few more (PCIE and generic interface related)
> cleanups which becomes reasonable after the previous patch.
> 
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
> ---
>  drivers/net/wireless/marvell/mwifiex/main.h |  4 +--
>  drivers/net/wireless/marvell/mwifiex/pcie.c | 28 +++++----------------
>  2 files changed, 8 insertions(+), 24 deletions(-)

...

> --- a/drivers/net/wireless/marvell/mwifiex/pcie.c
> +++ b/drivers/net/wireless/marvell/mwifiex/pcie.c
> @@ -710,18 +710,12 @@ static int mwifiex_pm_wakeup_card_complete(struct mwifiex_adapter *adapter)
>   * The host interrupt mask is read, the disable bit is reset and
>   * written back to the card host interrupt mask register.
>   */
> -static int mwifiex_pcie_disable_host_int(struct mwifiex_adapter *adapter)
> +static void mwifiex_pcie_disable_host_int(struct mwifiex_adapter *adapter)
>  {
>  	if (mwifiex_pcie_ok_to_access_hw(adapter))
>  		mwifiex_write_reg(adapter, PCIE_HOST_INT_MASK, 0x00000000);
>  
>  	atomic_set(&adapter->tx_hw_pending, 0);
> -	return 0;
>  }

I have a nagging feeling that some of this is hitting
partially-implemented features (esp. around error handling for the sleep
cookie / mwifiex_pcie_ok_to_access_hw() stuff), but I also bet that the
only chip using that feature (8766) is in bad enough shape that no one
is getting reliable usage out of it anyway. (I know I'm not; ChromeOS
never picked up PCIe support until 8997, where we worked out most of the
driver/firmware bugs.)

So maybe no one cares, and simplifying the dead logic is a net win.

Acked-by: Brian Norris <briannorris@chromium.org>
