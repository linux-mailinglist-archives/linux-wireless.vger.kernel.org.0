Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 514C232ED94
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Mar 2021 16:01:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229965AbhCEPAp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 5 Mar 2021 10:00:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229971AbhCEPAT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 5 Mar 2021 10:00:19 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEE28C061574;
        Fri,  5 Mar 2021 07:00:18 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id w7so1710590wmb.5;
        Fri, 05 Mar 2021 07:00:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Y2H8czy4HWKYT33LVWK4xxuIgGxYNVC0YsC4IjH3YU4=;
        b=tFNvcKaWr3p2qbdNI7ESZo/lZdwe60EhEb+qVwy5rhd2H1dXWtHXKZ5nWBywJyF82N
         rlspaSoX7C8ftpLNYjtIzyK46LgPQ98/NQYLrYsQtXqftLjgnH1tWNeR3JxKgFkT9rMa
         RPLG+wRmoBf43XiSY1MJVE7PiPrb4r5txz59dX4TRSmUwBsWPeaJn5B2bfcczvsLAp1t
         bIyOtpzv2ReTKFTBUumuraxsDKdOzxud0mQWnEAq5fvLjuF/gJP+dxrCEHK2PmmzzF6H
         uk0waWBNocs4c8AWScey4js0JRP631Az8GzxGtyxGPJzHZAtSADDz2JR3TjUZXu6D7nY
         Jq8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Y2H8czy4HWKYT33LVWK4xxuIgGxYNVC0YsC4IjH3YU4=;
        b=g+8GNIsrS60YMNJN6DHuyiwV/ZJ/dcqUdd9rxmKvgPyceaxCv9K5xj8T7KYq3j/cqB
         xESO9bv/vfqvXXGMBMuSLV271yXdPh8xY17AY68tYsKBCSRIJL+RZBiSwvEuC/evUMsR
         fURC2LNeHhaWH8rbP++QPHUuklBBQtw8BGonuD5+GFO7Swm/X/9tnC5GGkDA9DfqgqWA
         yhoDP40HEOaOxH1mQOfKfSMhinZpgbsw/EOWhq8VoVCcOVoWqI0RKdkLcWOutTesGNdL
         H9qKnvIE0K0PBqqsIeTXILAoRkao19t0w8uKJ7m6IvyVzQjE2vP284bLMRFX4goe3efb
         rqtA==
X-Gm-Message-State: AOAM530EXyEqlG8dDtwYHA8B0LNLG3hnYBgjSMbGZaE0pqj+Nwcg186r
        vL3WZMsG6rJFKOdD0sa1w7c=
X-Google-Smtp-Source: ABdhPJxntrDeo/Jx3XF//2yFpFLbmkKQx5cmQmD6DeUjjBs7BlfgKVpNN4GQdpGoHA+h0NuLyHboLw==
X-Received: by 2002:a05:600c:1405:: with SMTP id g5mr9157287wmi.140.1614956417493;
        Fri, 05 Mar 2021 07:00:17 -0800 (PST)
Received: from ubuntudesktop (205.158.32.217.dyn.plus.net. [217.32.158.205])
        by smtp.gmail.com with ESMTPSA id j20sm4489167wmp.30.2021.03.05.07.00.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Mar 2021 07:00:16 -0800 (PST)
Date:   Fri, 5 Mar 2021 15:00:14 +0000
From:   Lee <leegib@gmail.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8192e: Fix possible buffer overflow in
 _rtl92e_wx_set_scan
Message-ID: <20210305150014.GA627584@ubuntudesktop>
References: <20210226114829.316980-1-leegib@gmail.com>
 <20210226134333.GA2087@kadam>
 <20210226140526.GG2222@kadam>
 <20210301132535.GR2087@kadam>
 <20210305082228.GG2222@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210305082228.GG2222@kadam>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


Hi Dan,

Do you think any of these could be potential issues:

driver/staging/

rtl8192e/rtllib_rx.c:2442
wlan-ng/cfg80211.c:316
rtl8723bs/os_dep/ioctl_cfg80211.c:1591
rtl8723bs/os_dep/ioctl_cfg80211.c:2738

and if so, findable via Smatch?

Regards,
Lee


On Fri, Mar 05, 2021 at 11:22:28AM +0300, Dan Carpenter wrote:
> Actually, I looked through a bunch of these and they're mostly false
> positives outside of staging.  I guess there are a few ways the ->ssid
> can be changed.  Via netlink, from the network or from the an ioctl.
> 
> I still have a couple questions, but so far as I can see it's mostly the
> ioctl which has problems.
> 
> I really want Smatch to be able to figure the netlink stuff...  That
> should be doable.
> 
> regards,
> dan carpenter
> 
