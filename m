Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 934004ECD69
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Mar 2022 21:42:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbiC3ToD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 30 Mar 2022 15:44:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229939AbiC3ToC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 30 Mar 2022 15:44:02 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A421496AA
        for <linux-wireless@vger.kernel.org>; Wed, 30 Mar 2022 12:42:15 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id dr20so43580639ejc.6
        for <linux-wireless@vger.kernel.org>; Wed, 30 Mar 2022 12:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=wTC71dLHFQBC2DUNq3IY9+KCNVpWcc84MF9z+8xrDVo=;
        b=OoKebumkmWVaz8tjsHu1+Rp2h1IaO1OHy8uGW2J458Ek6JMmszGvpgQVIcQfc4g1l5
         Zkd4typMrIdN4ojagNGDXqoaO9uzIiLT5bbkxzh9RJvxyunUQvaMrvAFUM2hxr/p/AJc
         u8iFvRNjcDIGxW+Zt4PcEWmNszPeYxjmDcoZ4J1YwyZ3DELqL0kL13ff+wFGBv8wDlri
         C9kNGH3ZGD0d/G+7JHA6C/3+3LlrKiAutFNbWrM0wquzwer6tWoqFpty/j5vsax8wAHR
         D5LJ3YoTi46SPcZdnHaUTQigtuCECdVnLe3aEn1Q++FAYSzBduwhXScFoOxpgJVaQLWl
         NSwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=wTC71dLHFQBC2DUNq3IY9+KCNVpWcc84MF9z+8xrDVo=;
        b=gVR9XzgW5sdbtfgki0wKvn/Iz/SuQ6TJuQm7qmcfz1DqmAP9SsOWxS45flyYVIzhtY
         l8d657dwo6neon0EktGeXq3PIUA9U4/Uou2ud+tpgpIlldRrVhUpgGXPq9E+DwfgxX1C
         xKNJChK71MBi6vEHCDtohMyZ86nM6T4FL4O62PGoVP5AlGV1VlIJh8ET8Fu7B7NYlUrS
         Ih17n0KNScimVHy3hX/5bf75+kN4etQ+HfwRix4Gry1DBY92GN+B7fAFekKEGoeONUzU
         ExoTR3+g2kVL5l9Eyhbq0dQgtXWbI2uB6mSQIAbfEJLEPCqkjepYGqZm+zwEZ5JfFDyc
         r0eA==
X-Gm-Message-State: AOAM531iVIyvU/WV2yDbi8MKAmsgdJRApg6b4zRMOCT/r6mXAq3/J1f9
        X11bJWIvE+bS4LfU2nSzEwncFxX4EaUZipTlBco=
X-Google-Smtp-Source: ABdhPJyQV4gVc5ODlycJkVJzUMeoixOjbvZ6WGOaWjazY3h/AbzgTLUmcKu0r4COeO0UULzLJbtDE7RXMkJAefJ9uQc=
X-Received: by 2002:a17:906:7d52:b0:6df:a6c7:2c5 with SMTP id
 l18-20020a1709067d5200b006dfa6c702c5mr1328530ejp.540.1648669333710; Wed, 30
 Mar 2022 12:42:13 -0700 (PDT)
MIME-Version: 1.0
From:   Duke Abbaddon <duke.abbaddon@gmail.com>
Date:   Wed, 30 Mar 2022 20:42:09 +0100
Message-ID: <CAHpNFcP4NNendmeYAsD9fDf749drekDv8c2muXHw361R+biVhA@mail.gmail.com>
Subject: Lux the Droid robot loads fast enough loaded in 300MB's of CACHE ^p
 Say 700FPS : Security 'LUX' The DROID : Really does float in 32MB floating L3
 RAM Tables
To:     scott.herkelman@amd.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Lux the Droid robot loads fast enough loaded in 300MB's of CACHE ^p Say 700FPS

The size issue is not one clearly defined by progress, but defining
reality though pre tested hardware? Source of future security &
reliability RS

So Security 'LUX' The DROID : Really does float in 32MB floating L3 RAM Tables

https://www.youtube.com/watch?v=dSCpVhKvmCY

*****

On the subject of PSP processors : Arm features include NEON2!
Why not use this to our advantage? if safely potentiated! Every SiMD
matters after all,

Particularly preparing for the GPU & Audio output!
As a driver specific the advantages are around 13% improved
performance & 20% improved code flexibility on SiMD compatibility.

We can also directly utilize for Automated Direct Reactive Secure DMA or ADRSDMA

(signed RS)

ARM Patches 3 arte enabled! https://lkml.org/lkml/2022/3/30/977

*

GPRS for immediate use in all SFR SIM's & SFR Firmware & routers &
boxes including ADSL & Fibre

Cloudflare Kernels & VM linux, I pretty obviously would like to be
able to utilise cloudflare Kernel & Linux & cloudflare is very special
to me

Submissions for review

RS

https://drive.google.com/drive/folders/1X5fUvsXkvBU6td78uq3EdEUJ_S6iUplA?usp=sharing

https://lore.kernel.org/lkml/20220329164117.1449-1-mario.limonciello@amd.com/

https://www.phoronix.com/scan.php?page=news_item&px=AMD-PSP-Sysfs-Expose

https://lkml.org/lkml/2022/3/30/1005

https://lkml.org/lkml/2022/3/30/1002
