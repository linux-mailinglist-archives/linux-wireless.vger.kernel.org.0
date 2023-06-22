Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C24A573A024
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Jun 2023 13:56:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230191AbjFVL4Z (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 22 Jun 2023 07:56:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230450AbjFVL4U (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 22 Jun 2023 07:56:20 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A1BA1FD2
        for <linux-wireless@vger.kernel.org>; Thu, 22 Jun 2023 04:56:10 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-311275efaf8so5511687f8f.3
        for <linux-wireless@vger.kernel.org>; Thu, 22 Jun 2023 04:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687434968; x=1690026968;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iudEYsggi64U3UdoD1sUVcXvLGzfjsdo/x/MjoGCvsg=;
        b=PM4xBtENWwGFdFEw8JfA8z1C4N6FxxW1nUBww9f/T+k3SaJbBv9fCf6RX5KUbH1c3X
         k/H7W7P8jXN94VnjFXxOx1DQ/TC/BUxpmz7FjGjMLpuYITeMgKVl/NK8736CVPG3Zt3y
         9jIceY+AtZWZyBtT9Y6FtY97lBgqt8Y9lo4e6qW6+DSIVxvNBzOHt+VoX4foVWixijpc
         8CgCGUwcifKKgdZQdK/D42yKOSro0UyKLMDSn3pTJxS9YiKC4Rsp3U2GiDkuzrH7QwiC
         feNYOSyz8WIURk0KMpdfyPqfmnUL7I581R10iMAIHmtZc1tKNihFtnp41/PmeRaK/69o
         ZEig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687434968; x=1690026968;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iudEYsggi64U3UdoD1sUVcXvLGzfjsdo/x/MjoGCvsg=;
        b=J70radbekcj28X7+ezq0Mxpr3mO6C6VgqMxgx4Yd9tVHmKWla3fAGCnf7Bmei10T3z
         cw1z8iGbgvdJSEwEvcNxUskCeghQ7O4HrOLRRNFz1byVAZkx6YBuLVeOatQCcMHQY5jh
         McIzpaF+HiL7lWpdWEXAtDDPzm9flq3YgDh5F2LgXLYFyghZG5cLTk7H8b8QA9k37tSu
         3ZOyKSTlXUupkLXK5LIxwE4JPnF7voQrNpThul48FiBPz3YwCFk1SxhUI7+EKPm02R+m
         wcY9LdoEfAH0fcBIxTFVKmMX5qYLwUhZCbxEjanilb8hSLTeb3z3GA6pDHtklHXN9ZYb
         XbZw==
X-Gm-Message-State: AC+VfDzahA/SfCX55SczM+lB18ZFJeZDQ7JjD6xgUr0V1gPqFRJjs6dg
        imMpqkhzK13buE+s7mAA58chXZIS6dk=
X-Google-Smtp-Source: ACHHUZ66SJ0dJX7sCLtaKJZ6k/au5sC8lH98FREQYQCHmxa9JO5VJ2g7X/gfewzti0hsqN+5INCG2w==
X-Received: by 2002:adf:e489:0:b0:311:d3c:df0 with SMTP id i9-20020adfe489000000b003110d3c0df0mr11811084wrm.43.1687434968258;
        Thu, 22 Jun 2023 04:56:08 -0700 (PDT)
Received: from [192.168.26.149] (031011218106.poznan.vectranet.pl. [31.11.218.106])
        by smtp.googlemail.com with ESMTPSA id l8-20020a05600012c800b0030ae4350212sm6889139wrx.66.2023.06.22.04.56.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Jun 2023 04:56:07 -0700 (PDT)
Message-ID: <707ebcf8-bd24-2131-ab55-4e3a8c03f5bb@gmail.com>
Date:   Thu, 22 Jun 2023 13:56:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] brcm: add CLM BLOB files for Luxul devices
To:     Josh Boyer <jwboyer@kernel.org>, Rip Route <riproute@gmail.com>,
        Arend van Spriel <arend.vanspriel@broadcom.com>
Cc:     linux-firmware@kernel.org, Kalle Valo <kvalo@kernel.org>,
        linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        SHA-cyfmac-dev-list@infineon.com, openwrt-devel@lists.openwrt.org,
        Dan Haab <dan.haab@legrand.com>
References: <20230601173046.3185925-1-riproute@gmail.com>
 <CA+5PVA46VWBL7ZVskFiSEUYvWoH7W75gRMw3smFysVRX90YFZg@mail.gmail.com>
 <CALZrXOk+2gy3useDj8cpzyzyDMHcXq_wpHkdSnE3C7RVQbvLkg@mail.gmail.com>
 <CA+5PVA6CRyMioY5XV0QbzMsOrmqv5NqSTyfHZoTuWtpW6igY=g@mail.gmail.com>
Content-Language: en-US
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
In-Reply-To: <CA+5PVA6CRyMioY5XV0QbzMsOrmqv5NqSTyfHZoTuWtpW6igY=g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Josh,

I'm OpenWrt developer and those CLM BLOBs have significant meaning for
this project. They allow OpenWrt users to use their devices with full
WiFi support (not limited to some generic fallback setup level).

For that let me speak up regarding this PATCH case.

On 12.06.2023 18:57, Josh Boyer wrote:
> On Mon, Jun 12, 2023 at 11:05 AM Rip Route <riproute@gmail.com> wrote:
>>
>> The files were compiled from source obtained through Luxul's contract manufacturer of these devices.
> 
> OK, it's not clear to me whether we can accept these.  We have no idea
> what your contract specified, what sources were used, what the license
> on them is, or if you had authority to release them at all.  I'm not
> questioning your integrity by any means, but we have very little way
> to know Broadcom is agreeable to these being included in the
> linux-firmware repo.  If Broadcom wants to submit them or provide a
> Signed-off-by statement, we might be able to take them then.

I fully understand your concerns. Those are binary files and it's hard
to tell what they contain at first sight.

It'd be perfect to have Broadcom simply approve them but I'm afraid it's
unlikely. I see linux-wireless@ and Broadcom lists were cc-ed but we
didn't get any feedback. I know some firmware contributions took
Broadcom months or years in the past.

So I'd try to analyze what we have here and try to review it.


First of all: CLM (BLOB) is a binary formatted data. It doesn't contain
any actual CPU-executable code. It gets uploaded to FullMAC (closed
source) firmware and gets parsed by it.

So what we have here is not actual firmware (executable binary) built
from proprietary C sources full of logic and possibly some patent. We
have binary files containing (literally) numbers and strings. They just
use a binary undocumented format.


I actually took a moment to reverse engineer those files and write basic
tools for them.

BLOB is a simple container format with header containing offsets, sizes
and CRC32 sums. I developed "bcmblob" tool for parsing BLOBs and
extracting from them:
https://git.openwrt.org/?p=project/firmware-utils.git;a=commitdiff;h=f730ad2fa0b4728e2bd66771d22cf642909e020e

CLM BLOB is a BLOB file containing CLM and chipset version. I also
developed absolutely basic tool "bcmclm" for parsing CLM files:
https://git.openwrt.org/?p=project/firmware-utils.git;a=commitdiff;h=916633160dc92ccae6a0ad8fd900f2d75b5b5ff0


Given that, in my I-am-not-a-lawyer opinion, those files are safe to
accept and distribute.

If I were to compare them to something it'd be an XLS stylesheet file.
It's a binary undocumented format but what it actually contains are
sets of values.

I don't think it raises any concerns to use a custom binary format.
We're clearly fine sharing .xls, .exe or .rar files.

I also don't think you can stop anyone from sharing a list of 2 GHz,
5 GHz or 6 GHz channels. Or their rates. Or flags (like radar etc.).
Or allowed TX power levels. Just numbers in general.


Do you think that with my basic technical summary and Luxul-provided
info you can accept those files?
