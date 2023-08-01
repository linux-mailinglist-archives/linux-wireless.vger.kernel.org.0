Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C35A76BB7C
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Aug 2023 19:40:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230155AbjHARkG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 1 Aug 2023 13:40:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230116AbjHARkE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 1 Aug 2023 13:40:04 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DDFDE53
        for <linux-wireless@vger.kernel.org>; Tue,  1 Aug 2023 10:40:03 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1b8ad356f03so36712475ad.1
        for <linux-wireless@vger.kernel.org>; Tue, 01 Aug 2023 10:40:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1690911602; x=1691516402;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mMncvfrTbUudxjatb8C4ivngCmSho+E5Peq7MMmoG/k=;
        b=NUPE7f8XFaaWrHoxuppbk+BtdfaIpZpAWvilUXmSHqBnx7qX9mJS3ZsIxOqQjCDpRl
         op9LZ8BCZHZX1CGFE6QpFJsc5niP+XRqf36kMxyWNuqzSjTvWNmvSiWD5nUkDkHjKOGt
         WGOXK9MdPzwmwD883wMmcPNnPbDztDF7UJSl0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690911602; x=1691516402;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mMncvfrTbUudxjatb8C4ivngCmSho+E5Peq7MMmoG/k=;
        b=Lgjz5xsnTxfKeDQoxRmaGQtFamdHttVc21EAWPg1hNQZA3OE+P/Jclq0//Us0gWfbV
         qkAZja+35S+Icgqt3GNhuWSNMmzsP65gh5i9Yuj57vPYAxNwjs6UgmfyUsJmby2fKcVl
         tArgZsmEH7uxiNClJ2McBigJnD2p2ec08vvVOVKW2Uavgmx8GYhOP6BBIxerjqeKowN8
         f37CzedqWLH/TverZ/2GpeF30/vNMVYPmzn8/lwt1GQueBClSfyYOs9M9jRQGyCM9Q1C
         l32XOR0o5SN47SsjxSYXpXF6hQzXmO4Shg0FcfTN/bLJ/nm0nMIEJtVjswYgZWFtV+/R
         PbmA==
X-Gm-Message-State: ABy/qLboanTZZiUs8a12dz8dkItkbLCPJqRYAZXQ3qKvSQEFlzkFhoTL
        xWtUISWOoMoyhciyLJHG/44m+A==
X-Google-Smtp-Source: APBJJlE1TvsdzbCCaowhYUcqZmLan/QTov1viF4+KSHEieN6pBG612eAr4RKCfqJlcM1Dyoruwl+tg==
X-Received: by 2002:a17:902:aa46:b0:1b8:9002:c9ee with SMTP id c6-20020a170902aa4600b001b89002c9eemr11990242plr.1.1690911602533;
        Tue, 01 Aug 2023 10:40:02 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:1c1f:af3f:7a1e:7fc2])
        by smtp.gmail.com with ESMTPSA id iz20-20020a170902ef9400b001b9ecee9f81sm10804136plb.129.2023.08.01.10.40.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Aug 2023 10:40:02 -0700 (PDT)
Date:   Tue, 1 Aug 2023 10:40:00 -0700
From:   Brian Norris <briannorris@chromium.org>
To:     David Lin <yu-hao.lin@nxp.com>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        Sharvari Harisangam <sharvari.harisangam@nxp.com>,
        Pete Hsieh <tsung-hsien.hsieh@nxp.com>
Subject: Re: [EXT] Re: [PATCH] wifi: mwifiex: added code to support host mlme.
Message-ID: <ZMlDcG5wJPMNZ8Fo@google.com>
References: <PA4PR04MB9638100B3F21D083F386C6D9D106A@PA4PR04MB9638.eurprd04.prod.outlook.com>
 <CA+ASDXMx46aLztpKHqtS_Ab_yV_0GvRdWinf4C9o=9zqtTGehQ@mail.gmail.com>
 <PA4PR04MB9638F315ECAE762875B5FEE3D10AA@PA4PR04MB9638.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <PA4PR04MB9638F315ECAE762875B5FEE3D10AA@PA4PR04MB9638.eurprd04.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, Aug 01, 2023 at 05:50:03AM +0000, David Lin wrote:
> 
> > From: Brian Norris <briannorris@chromium.org>
> > Wait, your company can't afford to have anyone respond to maintainer mail
> > for years [1], but you can afford to add new features? Crazy.
> >
> 
> This feature is needed for WPA3.

Yeah, I read the description.

> > On Thu, Jul 27, 2023 at 11:19 PM David Lin <yu-hao.lin@nxp.com> wrote:
> > >
> > > 1. For station mode first.
> > > 2. This feature is a must for WPA3.
> > > 3. The code is tested with IW416. There is no guarantee for other chips.
> >
> > ^^ That's not a good sign.
> >
> > > Signed-off-by: David Lin <yu-hao.lin@nxp.com>
> >
> > >  drivers/net/wireless/marvell/mwifiex/util.c   |  74 ++++
> > >  14 files changed, 558 insertions(+), 13 deletions(-)
> >
> > > --- a/drivers/net/wireless/marvell/mwifiex/main.c
> > > +++ b/drivers/net/wireless/marvell/mwifiex/main.c
> > > @@ -28,6 +28,10 @@ module_param(driver_mode, ushort, 0);
> > > MODULE_PARM_DESC(driver_mode,
> > >                  "station=0x1(default), ap-sta=0x3, station-p2p=0x5,
> > > ap-sta-p2p=0x7");
> > >
> > > +bool host_mlme;
> > > +module_param(host_mlme, bool, 0);
> > > +MODULE_PARM_DESC(host_mlme, "Host MLME support enable:1,
> > disable:0");
> > > +
> >
> > I hear Kalle doesn't like module parameters like this. They're a cop out on
> > properly supporting features (also, see your own commit message). I'd have to
> > dig through the archives to find the latest advice and rules on this.
> >
> > Overall, I'm not enthusiastic about this change.
> 
> The parameter 'host_mlme' is added to protect original code. It will be disabled as default.

Right, I read the code too.

The point is, module parameters (or debugfs files) for controlling core
protocol functionality are highly discouraged here. See the following,
for some additional notes about this:

https://lore.kernel.org/linux-wireless/87d09u7tyr.fsf@codeaurora.org/
Subject: Re: [PATCH] rtw88: disable TX-AMSDU on 2.4G band

I really need to work on writing this up for the wiki...

On a constructive note: why do you want the module parameter at all?
Because you don't trust the code at all? Because you don't trust it for
the chips you haven't tested? Because you you don't trust it for the
firmware version(s) you haven't tested?

If you don't trust the code at all, don't except us to merge your patch.

If you don't trust it for certain chips or firmware versions, then
detect those at runtime to properly disable the feature. (And, I highly
suspect that not all firmware versions will support this. Don't make the
user guess.)

Basically, for the cases you care about enabling a new feature on for
production use, it shouldn't require playing with module parameters.

Side note: I think you probably shouldn't be advertising things like
NL80211_FEATURE_SAE with this feature disabled; that'll likely confuse
user space into thinking it can try WPA3, when it'll just fail as soon
as they try it.

Brian
