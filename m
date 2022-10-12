Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB6A15FCC21
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Oct 2022 22:37:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbiJLUhk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 12 Oct 2022 16:37:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiJLUhj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 12 Oct 2022 16:37:39 -0400
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B2FA102DED
        for <linux-wireless@vger.kernel.org>; Wed, 12 Oct 2022 13:37:37 -0700 (PDT)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-1322fa1cf6fso81609fac.6
        for <linux-wireless@vger.kernel.org>; Wed, 12 Oct 2022 13:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=donbowman.ca; s=google;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KSwQr18BbuLQCo5sc8X61BxuhXJCLO2tHeJ+hlWv6fQ=;
        b=AHGIBz1O6V0nn60TM9s1NugihCpKX+9wo2n0HR2abi9W1DlGG4w8HUZ7tp5EpaB5rR
         CadRANnbh2D9EMjko+QT149UG4E+H3Pt0nymXV0dzr3IUHaQVda/Hb+hcWaQ5df3P3Ib
         pJUhA334tuS+5gy3mYQcgTAsofvVTEgxEcs+4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KSwQr18BbuLQCo5sc8X61BxuhXJCLO2tHeJ+hlWv6fQ=;
        b=AwmeSTzxyHQ9T50lY704/e5pETDsKG05GcxKehcjQ7WRFBkHaQLGR6fC1N76Qu7Zyk
         xDXrcocdEyiCFtOWIr5olgTwWzN/i2X3h4C37ruQA0GOxdM90HunMYplCkIg+sjYaN2A
         +vnFfZ1U23r3xfqyYaPbj6dcSnl1D4aRCmsExdb1dG8LT/b6wV8TSm0U38WItm3bRRLO
         izcYcC0CAr0kYUByBcwyM2KMv46Asm92ZpP3nOUT/MNWTcFE3rEPAmwVwpY0dg0wgJ62
         JE1qRw1K6+d/M42shj3QQs6C37s4Wic1dcoszapcWkPapv30RGEPA9NLsaES5OKChiwI
         Z68w==
X-Gm-Message-State: ACrzQf07d+vhQY9Z5XNhFzcG3xHX3r7Oivfw1Ydwmcgjb3Slh1cKa4A9
        2kCa01QEmxLvHQKVj8J9QKQB+UBI+++CuV7Bk+D1CnW416lFmw==
X-Google-Smtp-Source: AMsMyM6mTTgRZn7pahLb6220Qpv8fu45l033Gp5NAETGR7FsFcD4qgizCN3I04lsCivPysLOgBUje1mESRFpKjLcDSc=
X-Received: by 2002:a05:6871:a6:b0:12b:8d8d:d7b with SMTP id
 u38-20020a05687100a600b0012b8d8d0d7bmr3530848oaa.197.1665607057163; Wed, 12
 Oct 2022 13:37:37 -0700 (PDT)
MIME-Version: 1.0
From:   Don Bowman <db@donbowman.ca>
Date:   Wed, 12 Oct 2022 16:37:26 -0400
Message-ID: <CADJev7-wMryV+Mw=cHBLAXT0nXVB5fbyYNyqWc5aBhBLUbm7pw@mail.gmail.com>
Subject: re: [PATCH 10/12] iwlwifi: Add support for getting rf id with blank
 otp Inbox
To:     linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luca@coelho.fi>
To: Kalle Valo <kvalo@codeaurora.org>
Cc: linux-wireless@vger.kernel.org
Subject: Re: [PATCH 10/12] iwlwifi: Add support for getting rf id with blank otp
Date: Thu, 26 Aug 2021 14:45:55 +0300 [thread overview]
Message-ID: <e9265c03dee77861f5aeb8d94569b51d28bca148.camel@coelho.fi> (raw)
In-Reply-To: <ce687133d7edf29abb421a9f1a105bb9eedd9761.camel@coelho.fi>

On Thu, 2021-08-26 at 14:30 +0300, Luca Coelho wrote:
> On Sat, 2021-08-21 at 17:07 +0300, Kalle Valo wrote:
> > Luca Coelho <luca@coelho.fi> writes:
> >
> > > From: Matti Gottlieb <matti.gottlieb@intel.com>
> > >
> > > When having a blank OTP the only way to get the rf id
> > > and the cdb info is from prph registers.
> > >
> > > Currently there is some implementation for this, but it
> > > is located in the wrong place in the code (should be before
> > > trying to understand what HW is connected and not after),
> > > and it has a partial implementation.
> > >
> > > Signed-off-by: Matti Gottlieb <matti.gottlieb@intel.com>
> > > Signed-off-by: Luca Coelho <luciano.coelho@intel.com>


I find this patch breaks my Asus UX433FA
Intel Corporation Cannon Point-LP CNVi [Wireless-AC] (rev 30)

[    4.350690] iwlwifi 0000:00:14.3: enabling device (0000 -> 0002)
[    4.352211] iwlwifi 0000:00:14.3: Can find a correct rfid for crf id 0x5a2
[    4.352239] iwlwifi: probe of 0000:00:14.3 failed with error -22

it worked prior. I notice a few other people online with the same
cannon point asus with the same issue.

I'm not sure what other diagnostics i can provide but more than happy
to. Is there a way to dump the OTP out?

00:14.3 Network controller: Intel Corporation Cannon Point-LP CNVi
[Wireless-AC] (rev 30)
DeviceName: WLAN
Subsystem: Intel Corporation Cannon Point-LP CNVi [Wireless-AC]
Flags: fast devsel, IRQ 16
Memory at b111c000 (64-bit, non-prefetchable) [size=16K]
Capabilities: [c8] Power Management version 3
Capabilities: [d0] MSI: Enable- Count=1/1 Maskable- 64bit+
Capabilities: [40] Express Root Complex Integrated Endpoint, MSI 00
Capabilities: [80] MSI-X: Enable- Count=16 Masked-
Capabilities: [100] Null
Capabilities: [14c] Latency Tolerance Reporting
Capabilities: [164] Vendor Specific Information: ID=0010 Rev=0 Len=014 <?>
Kernel modules: iwlwifi
