Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B3014CAC83
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Mar 2022 18:52:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244271AbiCBRwp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 2 Mar 2022 12:52:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241833AbiCBRwo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 2 Mar 2022 12:52:44 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 640C6C6232
        for <linux-wireless@vger.kernel.org>; Wed,  2 Mar 2022 09:52:00 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id n15so2217931plf.4
        for <linux-wireless@vger.kernel.org>; Wed, 02 Mar 2022 09:52:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=+/5/igsrfXanwK3DU0wBn0bDV+mDdnz3fmFR3ua895c=;
        b=RGdLSnaHq8juuxO5QzgSXE7RTdgwK+QxeDI0tx3jXQfaxAibsMClxkAybO/IYYCZBZ
         67YjmU9ncmmrOpLDGTrrzIMwmrqSe8K5d/81LM77IZJGU1CeXXJltsBE1KV2TsafgH7A
         VkdXbLffbTTHjW1EBvUTACjtEAhsTbo4bQImKRulvqeFy3QpwGa4EhOQEarx9MxTlXAy
         Xj3jbaPDdu2H8MKIfB54qd25xj7H9wG/tltCeb2OhDYmZn5xRgWcRUMi8ljd6Jh443LS
         ENYKZ+yXgqq19uWn6/BTTa9JgoWaO26m23OAJccTKstn2R/XyWDa9V0XUB6LCc2Gy8VN
         2Amw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=+/5/igsrfXanwK3DU0wBn0bDV+mDdnz3fmFR3ua895c=;
        b=kGFY/ebOvuynSNWfve4ghoM/a4/QO/M3Jc1r/OZkVdgrNQCk3RriyylMkQZF/LWY5g
         yVYa8w4ihxzC3f2LalX5kpyv3daCf6m+BIpmMLUbMcwKByN8YwXujwbkd+qI8uau/Ty+
         ah4tsIFZfiDgMIB8opQQ/1GwkXBFBpfrAt+IYNooP/MOUSMG1ENxQyRe+v9j0d1AyUbx
         rJ2PvP8tR1GhloJLvCh6ax+e6dqAyJjBh+osMEoJABQwHXiMVxj6f3vqv6FudVqH95HZ
         XP9AsygzZ0UxxJN638YBTfvULngekk1pgT4ytCxH2GV1SmM91gPk5/rxjaR4BhpR/mQi
         aTHA==
X-Gm-Message-State: AOAM530Kdp6kuTsdfZpgUTR8hPpnT8SJJu6fqUo4rtwvlks2E5FyF4CO
        k0D+MNHaMbKZXLZ0H+LxiGvGUfu2i0M=
X-Google-Smtp-Source: ABdhPJwn+Mi9O7Rr9IllE2YWlH5WXmdhfc9GuTk+PaDfe2pZmmcY2MeJua2k1rFIY/JdnhWmhNzLMw==
X-Received: by 2002:a17:903:110d:b0:14f:72a1:7b18 with SMTP id n13-20020a170903110d00b0014f72a17b18mr31833568plh.111.1646243519712;
        Wed, 02 Mar 2022 09:51:59 -0800 (PST)
Received: from [192.168.254.15] ([50.45.187.22])
        by smtp.gmail.com with ESMTPSA id e18-20020a63d952000000b00372a1295210sm15861276pgj.51.2022.03.02.09.51.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 09:51:59 -0800 (PST)
Message-ID: <d4cce352c09145afa95870532c27ebe9eef56328.camel@gmail.com>
Subject: Re: [PATCH] brcmfmac: include missing AP scan feature
From:   James Prestwood <prestwoj@gmail.com>
To:     Arend van Spriel <arend.vanspriel@broadcom.com>,
        Alvin =?UTF-8?Q?=C5=A0ipraga?= <ALSI@bang-olufsen.dk>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Date:   Wed, 02 Mar 2022 09:51:58 -0800
In-Reply-To: <89b87db4-1751-21b2-3e22-94d71e46c8d2@broadcom.com>
References: <20220224181809.2808754-1-prestwoj@gmail.com>
         <87o82ud09z.fsf@bang-olufsen.dk>
         <a6fc2d3b3fbd4ed2149fd85a21f7aae8f7fdc926.camel@gmail.com>
         <87k0dhdg0d.fsf@bang-olufsen.dk>
         <50df7d732efb392a6669d89e0893b17f8cec4204.camel@gmail.com>
         <89b87db4-1751-21b2-3e22-94d71e46c8d2@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-2.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Arend,

On Wed, 2022-03-02 at 10:24 +0100, Arend van Spriel wrote:
> On 2/28/2022 6:17 PM, James Prestwood wrote:
> > Hi Alvin,
> > 
> > On Sat, 2022-02-26 at 11:27 +0000, Alvin Šipraga wrote:
> > > Hi James,
> > > 
> > > James Prestwood <prestwoj@gmail.com> writes:
> > > 
> > > > Hi Alvin,
> > > > 
> > > > On Fri, 2022-02-25 at 22:55 +0000, Alvin Šipraga wrote:
> > > > > Hi James,
> > > > > 
> > > > > James Prestwood <prestwoj@gmail.com> writes:
> > > > > 
> > > > > > This driver does not advertise this feature yet scanning
> > > > > > with
> > > > > > on an
> > > > > > AP interface appears to work just fine.
> > > > > > ---
> > > > > >   drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211
> > > > > > .c |
> > > > > > 2 ++
> > > > > >   1 file changed, 2 insertions(+)
> > > > > > 
> > > > > > I've submitted this patch mainly to start a discussion
> > > > > > about
> > > > > > it. I
> > > > > > find it hard to believe that ALL brcmfmac devices support
> > > > > > AP
> > > > > > scanning
> > > > > > in which case this feature needs to be limited to those
> > > > > > devices
> > > > > > only. Trouble is there is no FW feature for AP scanning
> > > > > > AFAIK.
> > > > > > 
> > > > > > In any case I think this driver needs to sort out if it
> > > > > > supports
> > > > > > this
> > > > > > feature or not, and advertise as such rather than leaving
> > > > > > userspace
> > > > > > in the dark.
> > > > > 
> > > > > By the way, what are the typical use-cases for AP scanning?
> > > > > 
> > > > > I know that hostapd does a passive scan on the AP interface
> > > > > on
> > > > > the
> > > > > assumption that the driver/firmware will gather channel
> > > > > survey
> > > > > data,
> > > > > but
> > > > > that's not a universally applicable assumption. Not all
> > > > > implementations
> > > > > will do that.
> > > > 
> > > > We have someone wanting it for onboarding/configuring a new
> > > > headless
> > > > device. Where on boot, if it is unconfigured, it starts an AP
> > > > and
> > > > waits
> > > > for a client to configure it.
> > > > 
> > > > A client would connect, have the device scan and present
> > > > available
> > > > networks. The client then selects a network and provides
> > > > credentials.
> > > > The new device can then switch back to station mode and
> > > > connect.
> > > > 
> > > > This is a relatively common practice I've seen with IoT
> > > > devices.
> > > 
> > > Ah OK! Actually we do pretty much the same here at B&O with
> > > brcmfmac. But rather than starting the AP on the primary
> > > interface
> > > (the
> > > one default created by the driver), we add a separate AP
> > > interface
> > > with
> > > the equivalent of the following command:
> > > 
> > > # iw dev wlan0 add uap0 type __ap
> > > 
> > > Here wlan0 is the primary interface, and uap0 is what I call my
> > > AP.
> > > 
> > > In that case you can start the AP on uap0, but still do scanning
> > > on
> > > wlan0 (which remains in station mode). Don't quote me on it, but
> > > I
> > > think
> > > this is the canonical approach with this driver. Is it something
> > > you
> > > have considered?
> > 
> > Thanks, this does seem to work on brcmfmac. I had tried this on
> > other
> > hardware without any luck. I mentioned this to the user but since
> > the
> > AP scanning feature has been implemented they may want to still use
> > that, but who knows. I think finding out if brcmfmac is intended to
> > scan on the AP interface would still be good to know.
> 
> There is no easy answer to that. It really depends on the 
> device/firmware. To be honest I don't know if the older chips can 
> support it. Need to check that.

Thats what I figured.

> 
> What device are you specifically looking at?

I've tried on a Raspberry Pi 3, which is a BCM4345 I believe.

But I'm not too concerned about knowing for this one device. We really
would like a general way to know, i.e. the feature flag. If this is
possible to set based on some FW values that would be great to do.
Otherwise, if its not possible, saying "No it doesn't support it" is
also fine with me, and we can continue on assuming brcmfmac as a whole
doesn't support it.

What is confusing (to me) is the lack of the feature flag but the
driver still accepts scans on AP interfaces, as well as accepting the
NL80211_SCAN_FLAG_AP. I would expect CMD_TRIGGER scan to fail with "Not
Supported".

Thanks,
James

> 
> Regards,
> Arend


