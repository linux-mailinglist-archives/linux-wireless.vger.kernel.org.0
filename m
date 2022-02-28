Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 821CB4C7261
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Feb 2022 18:17:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233115AbiB1RSQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 28 Feb 2022 12:18:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232939AbiB1RSP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 28 Feb 2022 12:18:15 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62F572BDA
        for <linux-wireless@vger.kernel.org>; Mon, 28 Feb 2022 09:17:35 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id z2so11307865plg.8
        for <linux-wireless@vger.kernel.org>; Mon, 28 Feb 2022 09:17:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=AwHFnOfKiZ+ZJybJUq80J+EgaNxqRxIbxDNB2mJrmqs=;
        b=TGcVgAYoCK4lJb9yRRxrHHQamt8hVs90rVIBgNQhXYSVaCiotYjn/iH53u3XvvERRv
         rVduwYp6HISVDDCehS6Q/qzwSlZ37iXvo54gaRkHy04kgSzhNaNcae7RkfEPRaM3rRlS
         EaRf2f7kQy48W8KGAzKAKxh5WsdxMY9kaeiHOPxFnpQN4c2p3uRSNF10EcR5EP/L26/Z
         7/nxheVBKXM0FR0Kiss877w8EqNOYc4c/wimwjkOy05oRw+PYO/+xhqlt6Obzcdv/gJG
         JnaDdPngnIObJ7jlW9J5lHP8xgyT+TnA7ld827Fp9ifgRYd08a3Y+G/p9clBKbAdGOnA
         v1Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=AwHFnOfKiZ+ZJybJUq80J+EgaNxqRxIbxDNB2mJrmqs=;
        b=dEbF01SV2vRH40QN6u1w7aq/bofveXaRcIUofizpa+N8cQEYHbHtQKnavJTAi/Dqvb
         nGVGzzui10kT+sa4esLFl06AJ2UDKs5YcuRf1dZaWE4Iho71I2KmDx8Arbq9daWeBY+y
         p3ePdNT4TwXHBaQ3kIuTtlRYeHMZhhqkkYvowDiKY6HUU+vS4kijNFSHjdzqifgIXHn6
         njuLwbGIJcwtan6/V4+iA77AX+A0i1J4zCRSebxvBkI3ALvmBLG8CjSQa2akyRNkZeX+
         e3sLC3SXlXMx21HK8+9RQLul7/tck7D4nLEyjKHkNMuNGpjwHCJ8yLwtbrhDC5ShxI8z
         rCvQ==
X-Gm-Message-State: AOAM531uBlNa2hUwYP4wlhIhW8KwkYfh433jWUEXDj33qp5TUwF5BSvX
        hWxNDtdrBC021JABjkyqqR0G05hYk7w=
X-Google-Smtp-Source: ABdhPJyufPomMJPdLuuAfhzmV7ziEgy27aVk3BV48y5vsviBT/H5gSf1ySDc62DLrz0BBsyfgU3oCg==
X-Received: by 2002:a17:90a:c08a:b0:1bc:b573:2fe4 with SMTP id o10-20020a17090ac08a00b001bcb5732fe4mr17694412pjs.194.1646068654798;
        Mon, 28 Feb 2022 09:17:34 -0800 (PST)
Received: from [192.168.254.15] ([50.45.187.22])
        by smtp.gmail.com with ESMTPSA id b17-20020a056a000a9100b004e1b7cdb8fdsm14621076pfl.70.2022.02.28.09.17.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 09:17:34 -0800 (PST)
Message-ID: <50df7d732efb392a6669d89e0893b17f8cec4204.camel@gmail.com>
Subject: Re: [PATCH] brcmfmac: include missing AP scan feature
From:   James Prestwood <prestwoj@gmail.com>
To:     Alvin =?UTF-8?Q?=C5=A0ipraga?= <ALSI@bang-olufsen.dk>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Date:   Mon, 28 Feb 2022 09:17:33 -0800
In-Reply-To: <87k0dhdg0d.fsf@bang-olufsen.dk>
References: <20220224181809.2808754-1-prestwoj@gmail.com>
         <87o82ud09z.fsf@bang-olufsen.dk>
         <a6fc2d3b3fbd4ed2149fd85a21f7aae8f7fdc926.camel@gmail.com>
         <87k0dhdg0d.fsf@bang-olufsen.dk>
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

Hi Alvin,

On Sat, 2022-02-26 at 11:27 +0000, Alvin Šipraga wrote:
> Hi James,
> 
> James Prestwood <prestwoj@gmail.com> writes:
> 
> > Hi Alvin,
> > 
> > On Fri, 2022-02-25 at 22:55 +0000, Alvin Šipraga wrote:
> > > Hi James,
> > > 
> > > James Prestwood <prestwoj@gmail.com> writes:
> > > 
> > > > This driver does not advertise this feature yet scanning with
> > > > on an
> > > > AP interface appears to work just fine.
> > > > ---
> > > >  drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c |
> > > > 2 ++
> > > >  1 file changed, 2 insertions(+)
> > > > 
> > > > I've submitted this patch mainly to start a discussion about
> > > > it. I
> > > > find it hard to believe that ALL brcmfmac devices support AP
> > > > scanning
> > > > in which case this feature needs to be limited to those devices
> > > > only. Trouble is there is no FW feature for AP scanning AFAIK.
> > > > 
> > > > In any case I think this driver needs to sort out if it
> > > > supports
> > > > this
> > > > feature or not, and advertise as such rather than leaving
> > > > userspace
> > > > in the dark.
> > > 
> > > By the way, what are the typical use-cases for AP scanning?
> > > 
> > > I know that hostapd does a passive scan on the AP interface on
> > > the
> > > assumption that the driver/firmware will gather channel survey
> > > data,
> > > but
> > > that's not a universally applicable assumption. Not all
> > > implementations
> > > will do that.
> > 
> > We have someone wanting it for onboarding/configuring a new
> > headless
> > device. Where on boot, if it is unconfigured, it starts an AP and
> > waits
> > for a client to configure it.
> > 
> > A client would connect, have the device scan and present available
> > networks. The client then selects a network and provides
> > credentials.
> > The new device can then switch back to station mode and connect.
> > 
> > This is a relatively common practice I've seen with IoT devices.
> 
> Ah OK! Actually we do pretty much the same here at B&O with
> brcmfmac. But rather than starting the AP on the primary interface
> (the
> one default created by the driver), we add a separate AP interface
> with
> the equivalent of the following command:
> 
> # iw dev wlan0 add uap0 type __ap
> 
> Here wlan0 is the primary interface, and uap0 is what I call my AP.
> 
> In that case you can start the AP on uap0, but still do scanning on
> wlan0 (which remains in station mode). Don't quote me on it, but I
> think
> this is the canonical approach with this driver. Is it something you
> have considered?

Thanks, this does seem to work on brcmfmac. I had tried this on other
hardware without any luck. I mentioned this to the user but since the
AP scanning feature has been implemented they may want to still use
that, but who knows. I think finding out if brcmfmac is intended to
scan on the AP interface would still be good to know.

> > 
> > Other than this I cant see much else of a use case besides, like
> > you
> > mentioned, gathering survey data to choose a low load channel (ACS
> > its
> > called I think?)
> 
> Yes, see hostap/src/ap/acs.c.
> 
> See also
> https://lore.kernel.org/linux-wireless/96652669-0cad-8cdb-fbe1-4df0f7161102@bang-olufsen.dk/
> for some grumblings of mine on this API.
> 
> > 
> > Sadly this onboarding use case is quite perfect for DPP, but since
> > Apple came up with their own protocol DPP won't work for any
> > products
> > that want cross compatibility...
> 
> Yes, this is a real shame. And I highly doubt that Apple will abandon
> their own protocol.
> 
> > 
> > > 
> > > Kind regards,
> > > Alvin
> > > 
> > > > 
> > > > diff --git
> > > > a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
> > > > b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
> > > > index fb727778312c..b6a50e65dbf6 100644
> > > > ---
> > > > a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
> > > > +++
> > > > b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
> > > > @@ -7729,6 +7729,8 @@ struct brcmf_cfg80211_info
> > > > *brcmf_cfg80211_attach(struct brcmf_pub *drvr,
> > > >  #endif
> > > >         }
> > > >  
> > > > +       wiphy->features |= NL80211_FEATURE_AP_SCAN;
> > > > +
> > > >         return cfg;
> > > >  
> > > >  detach:


