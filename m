Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2156E2DAC1C
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Dec 2020 12:34:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728494AbgLOLdC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 15 Dec 2020 06:33:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726951AbgLOLdC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 15 Dec 2020 06:33:02 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E466C06179C
        for <linux-wireless@vger.kernel.org>; Tue, 15 Dec 2020 03:32:22 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id k10so16569517wmi.3
        for <linux-wireless@vger.kernel.org>; Tue, 15 Dec 2020 03:32:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=L9hmd5NaYgRFLNtIvDxRITmqvSUYC9E6zRaf6aLkJb4=;
        b=FdU0COatfwVRh/zEb88il8Qi8p6ruwX9ZoZTmexthXDlriWbpaUdaX1mVR4289eRay
         bTR2LYMaU+Gvi2b8zx4bY2cHKjhriZvIsGqiuY8mw9U1EG2xIYvFWCv0j9s6BLk1TGq8
         lvNbnSLc44mTOxF1CRL5GuFdT344CLTjFAsQugnJjdWYC6omg44LIHqMw29uuWJBRua0
         wX+rTzPTTf+xAE1HrouWZw2w7REfUL40dEBXJDh5aBxQk54FOn3k9OSk8OHhY9aUuC16
         tDR+taNx7OWGAPugz7yoafxSYRkI8nw6Wdy4BlVDjbnKVY3F1Quq01nvPQi4Vk/Aihyn
         Palw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=L9hmd5NaYgRFLNtIvDxRITmqvSUYC9E6zRaf6aLkJb4=;
        b=geL/m0346BHughK1gDP6wUZRcCupwE1J5XB/aobhFYKNqE5I53jexHrcvGs4Dekebh
         QDmillj88jKIIqznWjsLwRON3dEFThoI3W6AR6SoEUPMuFKdU+C6ULD3ObXaSSICzRxq
         fVRTd4Zp4jVCzAsyVK7cTznYhm0rVU2EfJuvRjzNGX3mcxyvIulYeSffN006w88fNUT4
         uUKtXpQJGqEiMHR+8Sy3DwH+TcVKihNaS4Le2Oox9gmya/kkfp1nXMxV5J+5Be2S6tjA
         B3v7FOBFiXQy4Fcx/39hT3WKIfv0iRyZuz+2GcxogeJGWJ97giEKrAQzj1jSaYa1IYDo
         b8xA==
X-Gm-Message-State: AOAM531uaw0pshkwci/04qu7/M6ZfGEoEcceMd6QF38GZ40PsFQBm6zv
        MfyPA0d9/tTpigZ/DcppJ0G/i5zURmU=
X-Google-Smtp-Source: ABdhPJwc2QbiEHPIgT3tPTsREYG+J4wOtoNjtB3pGElPTMNeYNBxU3ha+I+4pFemv7GZC0TvVs5ixA==
X-Received: by 2002:a7b:cb93:: with SMTP id m19mr33376559wmi.45.1608031940772;
        Tue, 15 Dec 2020 03:32:20 -0800 (PST)
Received: from ?IPv6:2003:ea:8f06:5500:d4d9:f1ee:1b1f:c865? (p200300ea8f065500d4d9f1ee1b1fc865.dip0.t-ipconnect.de. [2003:ea:8f06:5500:d4d9:f1ee:1b1f:c865])
        by smtp.googlemail.com with ESMTPSA id n14sm36295307wmi.1.2020.12.15.03.32.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Dec 2020 03:32:19 -0800 (PST)
Subject: Re: AX210 version 0024 not detected by iwlwifi
To:     "Coelho, Luciano" <luciano.coelho@intel.com>,
        linuxwifi <linuxwifi@intel.com>,
        "Berg, Johannes" <johannes.berg@intel.com>,
        "Grumbach, Emmanuel" <emmanuel.grumbach@intel.com>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
References: <03e8284e-4ea8-fe3e-8da7-62a778b1a059@gmail.com>
 <ce7fab1d400a04eb31727546b99af0292a0d30f4.camel@intel.com>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Message-ID: <0cbeae30-f330-ad7f-05ef-b8726b54036b@gmail.com>
Date:   Tue, 15 Dec 2020 12:32:14 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <ce7fab1d400a04eb31727546b99af0292a0d30f4.camel@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Am 23.11.2020 um 09:17 schrieb Coelho, Luciano:
> Hi Heiner,
> 
> On Sun, 2020-11-22 at 22:35 +0100, Heiner Kallweit wrote:
>> I have an AX210 card that isn't detected by iwlwifi.
>>
>> 01:00.0 Network controller: Intel Corporation Device 2725 (rev 1a)
>>         Subsystem: Intel Corporation Device 0024
>>
>> Adding following entry seems to be sufficient.
>>
>>         {IWL_PCI_DEVICE(0x2725, 0x0020, iwlax210_2ax_cfg_ty_gf_a0)},
>> +       {IWL_PCI_DEVICE(0x2725, 0x0024, iwlax210_2ax_cfg_ty_gf_a0)},
>>         {IWL_PCI_DEVICE(0x2725, 0x0310, iwlax210_2ax_cfg_ty_gf_a0)},
>>
>> [  419.473140] iwlwifi 0000:01:00.0: enabling device (0000 -> 0002)
>> [  419.486984] iwlwifi 0000:01:00.0: api flags index 2 larger than supported by driver
>> [  419.487190] iwlwifi 0000:01:00.0: TLV_FW_FSEQ_VERSION: FSEQ Version: 93.8.63.28
>> [  419.488828] iwlwifi 0000:01:00.0: loaded firmware version 59.601f3a66.0 ty-a0-gf-a0-59.ucode op_mode iwlmvm
>> [  419.533136] iwlwifi 0000:01:00.0: Detected Intel(R) Wi-Fi 6 AX210 160MHz, REV=0x420
>>
>> Maybe there are more AX210 subversion id's to be added ..
>>
>> How about the api flags index warning? I saw it in several posts,
>> is there something to be fixed in the driver?
> 
> Good catch.  This indeed seems to be missing.  I'll add it and try to
> send it still for the 5.10-rc series, so it propagates asap.
> 
At least on linux-next I still see the api flags index warning.
Has the issue been addressed?

> --
> Cheers,
> Luca.
> 
Heiner
