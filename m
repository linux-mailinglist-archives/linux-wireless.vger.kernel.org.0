Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 079706EBB06
	for <lists+linux-wireless@lfdr.de>; Sat, 22 Apr 2023 21:48:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229508AbjDVTsq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 22 Apr 2023 15:48:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbjDVTsp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 22 Apr 2023 15:48:45 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCA321BD5
        for <linux-wireless@vger.kernel.org>; Sat, 22 Apr 2023 12:48:43 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-3010889c6ebso1740731f8f.2
        for <linux-wireless@vger.kernel.org>; Sat, 22 Apr 2023 12:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682192922; x=1684784922;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UQMSHOEXy4dd32S1UV0ZhNWB6VKkhN22gnwR9IMusl0=;
        b=nHmMObR7x3FiUkaAPIlaQyocvvgn5cZjZnvZUAlj19vRreiBRr0OrjVYcp34NcAoNu
         9cdqrSazGuGiOA7k/p+EN9YMJFHSFkLxHLQH2DwgDlnX4sM6jZa3oJyPytw1Mwy05Nto
         d5dQO1GKskQ4xoRCKnZaysBDP4R17bnTwmnNFBcoMesrDyLesbWmpJIsImdGvku+Hp3X
         2wtM6bY/iq7tieTgsAPDLaFtxkcbUyqtyThPb1eNAPyowHojVgKL9R3TP3oUvIeVy/Cq
         JS/jFKMN/GdYACkctrawwhLvQrne6MhmV7qhNGmqQ9/+7qwGfUWEj9PSm0JxNLaFWXYH
         Zgrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682192922; x=1684784922;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UQMSHOEXy4dd32S1UV0ZhNWB6VKkhN22gnwR9IMusl0=;
        b=SCuRpeBigq7UOFzjLx7kXXKQdEFsiVKe9Fm23AFYInUmZwkLCcWTUhNAOzki6OWjRZ
         kS6Q0fMUizyq3YLD/i/6XzGvjq6D84pN1fhIoyosX9mils+XtXnJosGptPvEkEEAFYbY
         7gjfmTCc1eAYwT5i2q80nTceLdI5Kojuf6n58x5aasK9sl/eFxInR+H6EcZI4HTnNnX7
         tr8uEUN2KRJbwi6kljWY91+S2e9rXR6ftMD5SO3R5C41R7PQXjdkIQKwArZGENjYKJ09
         DQVsIuvp2Urbstcqv2sOAfgzr0qvR/7+fMZFdpaxzzThsqzFP6fCkEdFm2S7TAuLbRFC
         mXPA==
X-Gm-Message-State: AAQBX9eUC92yDhwtjT4epiIM/MM4RjCopQbs6I3yprtMOumPMiqIHLOy
        4sZU2EQcb/Rk1fotLsV4/RtzMQ==
X-Google-Smtp-Source: AKy350aLYJew3ugaktSPtVTFee5OZkYC67M5r+9LtUdpkJB3mKDc49tydAixWUKxvVGhL43y2CuajQ==
X-Received: by 2002:adf:f3cb:0:b0:2f2:7adf:3c67 with SMTP id g11-20020adff3cb000000b002f27adf3c67mr6362132wrp.61.1682192922260;
        Sat, 22 Apr 2023 12:48:42 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id u6-20020adff886000000b002f28de9f73bsm7159089wrp.55.2023.04.22.12.48.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Apr 2023 12:48:41 -0700 (PDT)
Date:   Fri, 21 Apr 2023 15:39:45 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     "kvalo@kernel.org" <kvalo@kernel.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH] wifi: rtw89: fix rtw89_read_chip_ver() for RTL8852B and
 RTL8851B
Message-ID: <3b1ed718-ce01-4a98-ae8b-3c042851c3f5@kili.mountain>
References: <e4d912a2-37f8-4068-8861-7b9494ae731b@kili.mountain>
 <7475bff70fd50c7e8527e66080e126b4eff440bb.camel@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7475bff70fd50c7e8527e66080e126b4eff440bb.camel@realtek.com>
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DATE_IN_PAST_24_48,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, Apr 21, 2023 at 11:48:43AM +0000, Ping-Ke Shih wrote:
> On Fri, 2023-04-21 at 13:44 +0300, Dan Carpenter wrote:
> > 
> > The if statement is reversed so it will not record the chip version.
> > This was detected using Smatch:
> > 
> >     drivers/net/wireless/realtek/rtw89/core.c:3593 rtw89_read_chip_ver()
> >     error: uninitialized symbol 'val'.
> 
> I use smatch to check our driver regularly, but I can't find this error.
> With the latest version v0.5.0-8321-g556064ca, I still can't find it.
> Do I need to specify additional arguments? Thanks. 
> 

You need the cross function database (which takes like 9 hours to build).

~/smatch/smatch_scripts/build_kernel_data.sh

regards,
dan carpenter

