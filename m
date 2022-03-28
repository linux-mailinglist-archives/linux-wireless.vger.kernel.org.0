Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 693014E97CF
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Mar 2022 15:17:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243056AbiC1NTU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 28 Mar 2022 09:19:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233955AbiC1NTT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 28 Mar 2022 09:19:19 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E45E75DE4B
        for <linux-wireless@vger.kernel.org>; Mon, 28 Mar 2022 06:17:38 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id a1so20339632wrh.10
        for <linux-wireless@vger.kernel.org>; Mon, 28 Mar 2022 06:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=tpXnN0VHB6iUEh42xZkIfKz+h2Jc2+CMtnusz63fzes=;
        b=YPALESBKVO/yFKv+lXwz8leucUW/QtFuB0hl8JHZCqjO5xu4w5wIoQ5+pwQ+QRVXb9
         3B2L4bQYw0N2jb7N56M5R7JWYxgho8xdRwRmv4vnJodlkTGVC2bN4KorM9+VarCUvhfz
         rq7UuF1pwztE+IwdlG9cbNz+sqpgQ/NI9IDLUETHwbQomOpQYmH+MNVfGvC/MeWvzE8P
         lVgleUzejo6opEuHS9sTuvN1v42e4fq5Sl4PYl0tj9Ag7RHSYKvKr2OYJJ4Wgi/PE7G+
         XZp5RIOP+vUQXZXu/Ec0fSds9Y00Tni8973wJOMtSetYycYYe8h/qByU8h8Ok03tSfRP
         ibtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=tpXnN0VHB6iUEh42xZkIfKz+h2Jc2+CMtnusz63fzes=;
        b=1fW0ER+VBQTX1aTpVRZAt0psSt9sv0aHuBAGRR3IZH8AOvicwHGeauTD3y7NHW06BY
         sDHq25xL9czKw3LOrNThwKPy31vFCsi3iJL2wj5BiaBewbBv2+62fHJdMrO0PGYMiGxL
         mVaQ8kWN66h/yNe4qnxwKZg9kdZNJDSHSVhUjuIm4l9rj/++S6+H02Ri071gdM61tLoW
         c1PJBQatshLXDjPfH4w3SpU4V8QF/5mxgEIdp15XdDCv4IVvwb831xLqqxT9QjH6dzn+
         yFrq8vfSvEPZ6sUdLHgsYxq7bPWAZgv1qr1rgRXb3uyKXz2NyUM7H8pi7a5KDZU3HD/A
         dB/g==
X-Gm-Message-State: AOAM5310J4h6jFRIMVg/UjwzMo8BGOrUEn8Z0V4LFnf2VtJd3UG9V1vs
        K1SfRjQiseLaqEcaNwv1Rxx0+g==
X-Google-Smtp-Source: ABdhPJxNq7t8QyUoAz9PQk4czd3rKFhq8Qof4HJlKz+Grc5sLrrh91AI45J9TNBzEfnY5jgV4oClHQ==
X-Received: by 2002:a05:6000:1ac8:b0:204:2917:acd4 with SMTP id i8-20020a0560001ac800b002042917acd4mr23551818wry.31.1648473457317;
        Mon, 28 Mar 2022 06:17:37 -0700 (PDT)
Received: from maple.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id j7-20020a05600c410700b0038c72ef3f15sm15290807wmi.38.2022.03.28.06.17.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Mar 2022 06:17:36 -0700 (PDT)
Date:   Mon, 28 Mar 2022 14:17:33 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Benjamin =?utf-8?B?U3TDvHJ6?= <benni@stuerz.xyz>
Cc:     andrew@lunn.ch, sebastian.hesselbarth@gmail.com,
        gregory.clement@bootlin.com, linux@armlinux.org.uk,
        linux@simtec.co.uk, krzk@kernel.org, alim.akhtar@samsung.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, robert.moore@intel.com,
        rafael.j.wysocki@intel.com, lenb@kernel.org, 3chas3@gmail.com,
        laforge@gnumonks.org, arnd@arndb.de, gregkh@linuxfoundation.org,
        mchehab@kernel.org, tony.luck@intel.com, james.morse@arm.com,
        rric@kernel.org, linus.walleij@linaro.org, brgl@bgdev.pl,
        mike.marciniszyn@cornelisnetworks.com,
        dennis.dalessandro@cornelisnetworks.com, jgg@ziepe.ca,
        pali@kernel.org, dmitry.torokhov@gmail.com, isdn@linux-pingi.de,
        benh@kernel.crashing.org, fbarrat@linux.ibm.com, ajd@linux.ibm.com,
        davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
        nico@fluxnic.net, loic.poulain@linaro.org, kvalo@kernel.org,
        pkshih@realtek.com, bhelgaas@google.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-acpi@vger.kernel.org, devel@acpica.org,
        linux-atm-general@lists.sourceforge.net, netdev@vger.kernel.org,
        linux-edac@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-input@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-media@vger.kernel.org,
        wcn36xx@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH 01/22] orion5x: Replace comments with C99 initializers
Message-ID: <20220328131733.akhkwnldtldp7nyn@maple.lan>
References: <20220326165909.506926-1-benni@stuerz.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220326165909.506926-1-benni@stuerz.xyz>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sat, Mar 26, 2022 at 05:58:48PM +0100, Benjamin Stürz wrote:
> This replaces comments with C99's designated
> initializers because the kernel supports them now.

This commit description seems wrong to me. This patch doesn't include
use C99 designated initializers (or AFAICT any other language feature
that has recently been enabled in the kernel).

The changes here are just plain constant-expressions in enumeration
lists and were included in C89/C90.


Daniel.


> 
> Signed-off-by: Benjamin Stürz <benni@stuerz.xyz>
> ---
>  arch/arm/mach-orion5x/dns323-setup.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/mach-orion5x/dns323-setup.c b/arch/arm/mach-orion5x/dns323-setup.c
> index 87cb47220e82..d762248c6512 100644
> --- a/arch/arm/mach-orion5x/dns323-setup.c
> +++ b/arch/arm/mach-orion5x/dns323-setup.c
> @@ -61,9 +61,9 @@
>  
>  /* Exposed to userspace, do not change */
>  enum {
> -	DNS323_REV_A1,	/* 0 */
> -	DNS323_REV_B1,	/* 1 */
> -	DNS323_REV_C1,	/* 2 */
> +	DNS323_REV_A1 = 0,
> +	DNS323_REV_B1 = 1,
> +	DNS323_REV_C1 = 2,
>  };
>  
>  
> -- 
> 2.35.1
> 
