Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D204D6315DF
	for <lists+linux-wireless@lfdr.de>; Sun, 20 Nov 2022 20:35:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbiKTTf2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 20 Nov 2022 14:35:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiKTTf0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 20 Nov 2022 14:35:26 -0500
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82C3F1B9E3
        for <linux-wireless@vger.kernel.org>; Sun, 20 Nov 2022 11:35:25 -0800 (PST)
Received: by mail-ot1-x32d.google.com with SMTP id t19-20020a9d7753000000b0066d77a3d474so6209293otl.10
        for <linux-wireless@vger.kernel.org>; Sun, 20 Nov 2022 11:35:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:sender:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JFNf0xkafzndvLDoLiOxkKJorG86toYqjYyxxTRVAog=;
        b=esADx6YyZEzOoT0gDaTH/3+PnNM/uClNnh4GTj3N/6rlpD6QxU1flBYgjsxfh4d+iY
         fFdDe2UANoy/jEuRIMlMNNq1kxFVBSctJcfsh97T9yfVJvRu22NDMFvz4CyodY5o6Cts
         Vp2U6QrhWZ6V4W/oFZxW24oG3mhNfPFCMmyXNBYcJ4jbGjgYHuulitd4YL75VECtZoVC
         LsPqfT6oS5OQokGFjxeggOT/VdfYmsdSAJXEWTLeBSlp38+kL4Ys1I1yliOyBQy8GMws
         Icg5ytsdSQtERWvW6CBlJe8dFPrNJvApCZdoxBg8sel5b4OsteYO6BcjkUyKdMxoXmn0
         qPrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:sender:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JFNf0xkafzndvLDoLiOxkKJorG86toYqjYyxxTRVAog=;
        b=pZ44nQ1obq7Nk23MypLx/qu7S0nyY75ZxhwvdJFJUlrDd8+gcqUrjiHtNMA+EvB5v7
         h5XyyTf6aVa8VhYLEyq0nM0rEIbOFWwA/IW5CZwrLYrFPcebc2d1Ljnmak3CLd3q8JwY
         Dsp7CuKKIUHmVB2zFk3GtkW1cOWm9CNsgn80sm/hMyy1UuWvGGgAUueOiOQYZ6nRxupl
         uDfl2KY2zPGlJza2nAbqE8lsAE7I69vyR//FHNOx2hTNo6+gjnR98NMsqg+tzbCBI57X
         XZWDmU2tbRiHSqPtfiiz7geRZVOB5V0x0BKWblAHaWMr89iChxfKabWrrWisH5AaGIdD
         NeMw==
X-Gm-Message-State: ANoB5plgKhMxKEtMkETMv0pYiW3gRBUQsQHsu5kRJKqnuwl2OP29aZIv
        Q6AdhvFuMEHYqI8yDC3Eedw=
X-Google-Smtp-Source: AA0mqf59jzOw9DhRM1XAgXKzzC0yp0xLN8Qw3gc6qyGNGFXl42xSHhV+QoiE/SEV6N30mjoOiXO3PQ==
X-Received: by 2002:a9d:2961:0:b0:66c:4e7a:a316 with SMTP id d88-20020a9d2961000000b0066c4e7aa316mr8420516otb.329.1668972924903;
        Sun, 20 Nov 2022 11:35:24 -0800 (PST)
Received: from [192.168.1.119] ([216.130.59.33])
        by smtp.gmail.com with ESMTPSA id z18-20020a056870739200b00131c3d4d38fsm5011009oam.39.2022.11.20.11.35.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Nov 2022 11:35:24 -0800 (PST)
Sender: Larry Finger <larry.finger@gmail.com>
Message-ID: <bea5e5c1-77e0-f210-e8bf-922492e50213@lwfinger.net>
Date:   Sun, 20 Nov 2022 13:35:23 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
From:   Larry Finger <Larry.Finger@lwfinger.net>
Subject: Missing commit - Sent again with Kalle's correct address
To:     Kalle Valo <kvalo@kernel.org>, Pkshih <pkshih@realtek.com>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Kalle,

I was answering a query regarding the driver for RTW8852BE, and happened to 
check the configuration for 6.1-rc and discovered that the appropriate Kconfig 
and Makefile are missing the following:

commit b5db4ef38e21dd9b6b95ae96cea5032b00e04f24
Author: Ping-Ke Shih <pkshih@realtek.com>
Date:   Fri Oct 14 14:02:37 2022 +0800

     wifi: rtw89: 8852b: add 8852be to Makefile and Kconfig

I expected that this one would have been sent upstream to mainline by now. Is my 
expectation wrong, or is the commit missing?

Larry
