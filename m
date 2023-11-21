Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AA437F396B
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Nov 2023 23:47:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234642AbjKUWrS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 21 Nov 2023 17:47:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbjKUWrQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 21 Nov 2023 17:47:16 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E57E71A3
        for <linux-wireless@vger.kernel.org>; Tue, 21 Nov 2023 14:47:12 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-5c194b111d6so4707499a12.0
        for <linux-wireless@vger.kernel.org>; Tue, 21 Nov 2023 14:47:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700606832; x=1701211632; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=OX6uBa5cz0afY3NVUY5EgRcp9PQhwE8tcaCWpv6PS7A=;
        b=ZPNlajVHWqoyHs1RhsvfA0gTD20nDXYKA9r/9bIaNzROO+rw+8zbepFawmCES8PAlg
         3Xi1VL1dgYJk/eSz3asbAPM4RhjN7zvq11q7bO+Ju5KwtxDIP0zhd8Y+K7fYdUVjMEj0
         YXWd3b2RMGyVZtksb1Vl91+9F/g/naKM25ggHyZtDu6IX2YcGTJQCFeGM34LDYyVEPLt
         g248nbLWeJkCdSugNRCKALhMVZ4elgg4Rqve11qmPr8puSnAc3Uo51e2CJd88XxEXxx6
         NQ8AO+Xpf11eAJT7PtImCzQ8nx16mf1ldQlUNQQkMCcJZhr/4fMcJoOZ1rc7z3RCNcB3
         sgxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700606832; x=1701211632;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OX6uBa5cz0afY3NVUY5EgRcp9PQhwE8tcaCWpv6PS7A=;
        b=CFaAEwOZIsyXzr5b2xgOC8SY/e4wVFHuyY33hGhkSf4S/5PgsR5k4Yvs/tbeNpXwPK
         RAi5zGd605bVxTwN9abExvphzpkd7dmfs3K74opO0TRtI5Ez1aXDN9CF8BcRy0byNp3u
         o6LV59tLDFqFtxwwaANSSXu5FtgDAdnFgqbWhGTuXkgeO4+/MnRlLDiKjAz72yRBSWWw
         aT+D1g5PietyYnfKgOG4FDhG/J6MEFjjgTPPAHvixRLb8TTgrtbiGtbJMisAXjfAxId8
         IaEMHxYIcB6kLAqKg9Fsyb+KE6et1lFeD+FD4+CCJoAetyIa3uXq7ARdjZDVRBDVqQta
         JD0g==
X-Gm-Message-State: AOJu0YybOrvDbL3EZbUHwQ1z4atYNx8z7sR+AER9ErwI6zCg3EhJ1Qfm
        etKz8zZr8ma1tZbnyDXGe1oQFbqS+m5JcA==
X-Google-Smtp-Source: AGHT+IEZUUan3rnq6i9r25dIcHCtem5aolnG1LVwaWtru2sH1+I12gEqah2pFnsWDT3g04DAJpUf7Q==
X-Received: by 2002:a05:6a20:3947:b0:18b:3c9b:f186 with SMTP id r7-20020a056a20394700b0018b3c9bf186mr152118pzg.30.1700606832228;
        Tue, 21 Nov 2023 14:47:12 -0800 (PST)
Received: from [192.168.1.119] ([216.130.59.33])
        by smtp.gmail.com with ESMTPSA id 13-20020a17090a01cd00b002851e283c21sm51528pjd.12.2023.11.21.14.47.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Nov 2023 14:47:11 -0800 (PST)
Sender: Larry Finger <larry.finger@gmail.com>
Message-ID: <84dc9e8b-0850-4724-a55b-582c994d042f@lwfinger.net>
Date:   Tue, 21 Nov 2023 16:47:10 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: EFUSE in RTW8723DS
Content-Language: en-US
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Ping-Ke Shih <pkshih@realtek.com>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>
References: <f3505110-b76b-4152-8375-37fa3184d3c1@lwfinger.net>
 <748b045e7aaa43eb9a7fb83ad924614f@realtek.com>
 <CAFBinCD=iLbyfWWTqQjLQ5CiqOn08r4UaVqyKHve8AoW_xeFEw@mail.gmail.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
In-Reply-To: <CAFBinCD=iLbyfWWTqQjLQ5CiqOn08r4UaVqyKHve8AoW_xeFEw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 11/20/23 13:55, Martin Blumenstingl wrote:
> Ping-Ke is right: the eFuse is split into two sections:
> 1. common (RF calibration, EEPROM version, antenna information,
> country code, ...) which is independent of the HCI (host controller
> interface)
> 2. HCI specific bits (PCI vendor/device IDs, USB vendor/device IDs,
> SDIO specifics)
> 
> #1 has already existed for a long time and I didn't have to touch it
> since it's the same for the PCIe, USB and SDIO variant of a wireless
> chip.
> 
> For #2 there are no (known to me) SDIO specific bits other than the
> MAC address. That's why I only added the MAC address for SDIO. If
> there's more it can still be added.
> Note that the MAC address has different offsets depending on whether
> the HCI is PCIe, USB or SDIO.

Martin,

As shown in 
https://github.com/lwfinger/rtw88/issues/157#issuecomment-1820421821, driver 
rtw88 shows a lot worse performance than the vendor driver for a chip with a 
properly encoded EFUSE. Is this not a case of incorrect setting of the 
calibration data?

Larry

