Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A15A24C5201
	for <lists+linux-wireless@lfdr.de>; Sat, 26 Feb 2022 00:22:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239273AbiBYXXG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 25 Feb 2022 18:23:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230190AbiBYXXE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 25 Feb 2022 18:23:04 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EBBBE000
        for <linux-wireless@vger.kernel.org>; Fri, 25 Feb 2022 15:22:29 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id l9so5582689pls.6
        for <linux-wireless@vger.kernel.org>; Fri, 25 Feb 2022 15:22:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=iJJAVDBQSh6AOfhds2yTYrWXIpidmhb39ntfqx9tLPQ=;
        b=K0zjraaLtgW4iX5Re7oZNzBz5b/KZfPxMdR88sL9xFfWe3rvkitIQxw37HmzTwuWe1
         RK0y57/UsY7izrFp7Y8f364lPyCnbzGfSAfVOwPwjeFUo9pg92s9QIOfHOt0PjX7JBjA
         0N8xkgi6PHqypjUWBL0q8UPorOvIP161Rsh85vCBbh2oR6Zyd6bTuPPCAZSjaGbe906b
         U/gn3chND7a7GVUonsNRqOuRiGTp7nBt+cILnTxYAEEu0DwQUmo4952BjqVMQ/mQjsnw
         219nv3nnZzP15A0RI065WxCYwplvWtao7GT7iIf8aJhKgxoQsxU+vgGI/k2DudZL0JUS
         djKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=iJJAVDBQSh6AOfhds2yTYrWXIpidmhb39ntfqx9tLPQ=;
        b=us9IpHlBADVe8oEKXepOwlQgNdxzNLNZsVf2o4078kKA2xDnZ/QG35f1fBsgpcXFDS
         RN0QKutIvzc1/wff3cnaPRSlywHFnCzYLmLa2EQiXuTvPn3TviyhF/mRufaHSPp3sgQs
         rgcW9sx5plkE3Tb1yewG/LUeIwxtiXyYTURuvoyqvkd158buo+0X9VSwrJ6XrxV8y53Q
         jC6zBdgymUQ9vTMlTDCU8iRfnrxYRE9ET0hiG9DW7JnoH4l8+AaKrtq6xUA2PU3z5WFQ
         B1dy1AYm9YPcPp8ss+krBy54Q2saeEIyIkYU4lsBJ8IHtgejyqr9c/9UWru064ygNUsH
         I5RA==
X-Gm-Message-State: AOAM5327nKBqGwiVz4d3JzZD+LQABt89ux7z0fG4LxNcDGKSlBzkPlYf
        up7T4wXU50O5mJWRXfLA6H4S9HtWdL0=
X-Google-Smtp-Source: ABdhPJxgjKUdwOTdVubn7G1dpxbokrJ6q+Rh61z7Y4ulaNJJdYXMtd6Hm9CW/j5WX6Nwmg0YiQZ8Uw==
X-Received: by 2002:a17:902:ce09:b0:14f:dec2:9849 with SMTP id k9-20020a170902ce0900b0014fdec29849mr9806939plg.74.1645831348421;
        Fri, 25 Feb 2022 15:22:28 -0800 (PST)
Received: from [192.168.254.15] ([50.45.187.22])
        by smtp.gmail.com with ESMTPSA id u12-20020a17090ae00c00b001bc46eae696sm10207224pjy.32.2022.02.25.15.22.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Feb 2022 15:22:28 -0800 (PST)
Message-ID: <a6fc2d3b3fbd4ed2149fd85a21f7aae8f7fdc926.camel@gmail.com>
Subject: Re: [PATCH] brcmfmac: include missing AP scan feature
From:   James Prestwood <prestwoj@gmail.com>
To:     Alvin =?UTF-8?Q?=C5=A0ipraga?= <ALSI@bang-olufsen.dk>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Date:   Fri, 25 Feb 2022 15:22:27 -0800
In-Reply-To: <87o82ud09z.fsf@bang-olufsen.dk>
References: <20220224181809.2808754-1-prestwoj@gmail.com>
         <87o82ud09z.fsf@bang-olufsen.dk>
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

On Fri, 2022-02-25 at 22:55 +0000, Alvin Šipraga wrote:
> Hi James,
> 
> James Prestwood <prestwoj@gmail.com> writes:
> 
> > This driver does not advertise this feature yet scanning with on an
> > AP interface appears to work just fine.
> > ---
> >  drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > I've submitted this patch mainly to start a discussion about it. I
> > find it hard to believe that ALL brcmfmac devices support AP
> > scanning
> > in which case this feature needs to be limited to those devices
> > only. Trouble is there is no FW feature for AP scanning AFAIK.
> > 
> > In any case I think this driver needs to sort out if it supports
> > this
> > feature or not, and advertise as such rather than leaving userspace
> > in the dark.
> 
> By the way, what are the typical use-cases for AP scanning?
> 
> I know that hostapd does a passive scan on the AP interface on the
> assumption that the driver/firmware will gather channel survey data,
> but
> that's not a universally applicable assumption. Not all
> implementations
> will do that.

We have someone wanting it for onboarding/configuring a new headless
device. Where on boot, if it is unconfigured, it starts an AP and waits
for a client to configure it.

A client would connect, have the device scan and present available
networks. The client then selects a network and provides credentials.
The new device can then switch back to station mode and connect.

This is a relatively common practice I've seen with IoT devices.

Other than this I cant see much else of a use case besides, like you
mentioned, gathering survey data to choose a low load channel (ACS its
called I think?)

Sadly this onboarding use case is quite perfect for DPP, but since
Apple came up with their own protocol DPP won't work for any products
that want cross compatibility...

> 
> Kind regards,
> Alvin
> 
> > 
> > diff --git
> > a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
> > b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
> > index fb727778312c..b6a50e65dbf6 100644
> > --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
> > +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
> > @@ -7729,6 +7729,8 @@ struct brcmf_cfg80211_info
> > *brcmf_cfg80211_attach(struct brcmf_pub *drvr,
> >  #endif
> >         }
> >  
> > +       wiphy->features |= NL80211_FEATURE_AP_SCAN;
> > +
> >         return cfg;
> >  
> >  detach:


