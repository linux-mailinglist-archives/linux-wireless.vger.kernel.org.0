Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 91CBF2450A
	for <lists+linux-wireless@lfdr.de>; Tue, 21 May 2019 02:23:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727213AbfEUAXT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 20 May 2019 20:23:19 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33130 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727043AbfEUAXS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 20 May 2019 20:23:18 -0400
Received: by mail-pf1-f196.google.com with SMTP id z28so8075388pfk.0
        for <linux-wireless@vger.kernel.org>; Mon, 20 May 2019 17:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LPu70Acl0dDSmwm46W0owNu3b5RSfGh3FzFKNjihb00=;
        b=MZQdLOQw3W9V15ULJxTQ96AipAiJ1kcuFGGW2c9VkUElP4pINsXi9UyEKmOKHIxKVz
         wbH2J3shvQbhbLV4ZTggOKN/KSP2TzN+miO9Q/uJDdjiIDVdhHg0R3n3qQh0fpFnEFvB
         jAif5optmrvx3phb9f3Hy8Am1MI4LkPVP+DZs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LPu70Acl0dDSmwm46W0owNu3b5RSfGh3FzFKNjihb00=;
        b=BfC/J2lO3KFmR4RR1STaZJMZAr94ZMLepW5cZcFp1xD3orDNm/YiONmwu8EVuN0X1c
         wGDCoaVxwuwfbJ+k64xgx4GrKNNfLvBAlJno4s4nKrK30JKboXVVttr1KDLUhu16kThW
         TnB0RvH/aEaKeHZDUXVJXkUznjX6Sd4pBRzIJKGLNabej6aBbWSb98oecmcZ3Hi7fNyc
         fLib+czzwyDq7xw3gYzMEda+Sz1v0QkSkMVxRmtDJNQPtrMIq8F9kvestUAcm5TfMeKO
         zLa1XtVIWAciXfchTNlcLThaQ0qyyJC2E43yCEy0aHGNHJhHxJK5FrM39KV+tjjqVfP7
         WYCw==
X-Gm-Message-State: APjAAAWEbOHA856LQHGZrP3+HO8GmgQu7Ys0QFZyHx1GfoHdnyWqLRpC
        igG23/a2Olebvgi014f7qNo6iA==
X-Google-Smtp-Source: APXvYqyHRvjDKJM7g5pNBmpglQaLaCNbnuq/wX0yAuGrBgJFe6RRW2bXvYhCXJl4QWmy07O1Y2HwHA==
X-Received: by 2002:aa7:9e51:: with SMTP id z17mr83145568pfq.212.1558398198034;
        Mon, 20 May 2019 17:23:18 -0700 (PDT)
Received: from google.com ([2620:15c:202:1:534:b7c0:a63c:460c])
        by smtp.gmail.com with ESMTPSA id j184sm19177690pge.83.2019.05.20.17.23.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 20 May 2019 17:23:16 -0700 (PDT)
Date:   Mon, 20 May 2019 17:23:14 -0700
From:   Brian Norris <briannorris@chromium.org>
To:     Avri Altman <Avri.Altman@wdc.com>
Cc:     Douglas Anderson <dianders@chromium.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        "linux-rockchip@lists.infradead.org" 
        <linux-rockchip@lists.infradead.org>,
        Double Lo <double.lo@cypress.com>,
        Madhan Mohan R <madhanmohan.r@cypress.com>,
        "mka@chromium.org" <mka@chromium.org>,
        Wright Feng <wright.feng@cypress.com>,
        Chi-Hsien Lin <chi-hsien.lin@cypress.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        "brcm80211-dev-list@cypress.com" <brcm80211-dev-list@cypress.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Martin Hicks <mort@bork.org>,
        Ritesh Harjani <riteshh@codeaurora.org>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Jiong Wu <lohengrin1024@gmail.com>,
        "brcm80211-dev-list.pdl@broadcom.com" 
        <brcm80211-dev-list.pdl@broadcom.com>,
        "David S. Miller" <davem@davemloft.net>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Naveen Gupta <naveen.gupta@cypress.com>
Subject: Re: [PATCH 0/3] brcmfmac: sdio: Deal better w/ transmission errors
 waking from sleep
Message-ID: <20190521002312.GA89786@google.com>
References: <20190517225420.176893-1-dianders@chromium.org>
 <SN6PR04MB49258D4FBE0B4D739E8BAF7EFC040@SN6PR04MB4925.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR04MB49258D4FBE0B4D739E8BAF7EFC040@SN6PR04MB4925.namprd04.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sat, May 18, 2019 at 03:09:44PM +0000, Avri Altman wrote:
> > 
> > This series attempts to deal better with the expected transmission
> > errors that we get when waking up the SDIO-based WiFi on
> > rk3288-veyron-minnie, rk3288-veyron-speedy, and rk3288-veyron-mickey.
> > 
> > Some details about those errors can be found in
> > <https://crbug.com/960222>, but to summarize it here: if we try to
> > send the wakeup command to the WiFi card at the same time it has
> > decided to wake up itself then it will behave badly on the SDIO bus.
> > This can cause timeouts or CRC errors.
> Wake-up itself: as part of a WoWlan, or d0i3?

Neither, IIUC. (It's definitely not WoWLAN, and D0i3 sounds like an
Intel thing.)

I believe it's a Broadcom-specific mode. See also Arend's response to
this thread:

http://lkml.kernel.org/linux-wireless/8c3fa57a-3843-947c-ec6b-a6144ccde1e9@broadcom.com

> Looks like this calls for a wifi driver fix, and not WA in the mmc driver.

Basically asked and answered in patch 2's thread:

https://lkml.kernel.org/lkml/20190520085201.GA1021@kunai/
