Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91E193ACA9B
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Jun 2021 14:08:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233279AbhFRMKW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 18 Jun 2021 08:10:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231193AbhFRMKW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 18 Jun 2021 08:10:22 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2BC7C061574
        for <linux-wireless@vger.kernel.org>; Fri, 18 Jun 2021 05:08:09 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id e33so7657002pgm.3
        for <linux-wireless@vger.kernel.org>; Fri, 18 Jun 2021 05:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=heitbaum.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+wo2kXhd+PsQx6gHas6Q+TtBe39B+DCdmIQElhUmvzw=;
        b=IwpeYt5Dsp60bHXwUhDQney5msqWefnPVzpwDd2fxeMfjHpb4om820J+K9BsT7pnmi
         E5yxhMoSRJggWd4WtXC1RnoWhdZPLDX64p4WS46vXaXlIYGUDNfwJalpHxBVpSodi1qB
         dg8WGwQTq7wTTzpALqNXi2kn3fMdIRVMKqudQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+wo2kXhd+PsQx6gHas6Q+TtBe39B+DCdmIQElhUmvzw=;
        b=HPAwVKvFQDIuy4mxtG3xu41MmYFEB7W3bHR7rEwR5AoXEz09LPN/ZZ4nNAq6p2rkdk
         crYpiNrz8oRlN5QLlPNXwzZnhyQAGaXFrrg2sTslRz6JcgklnEVSl08+NPKJf9le89it
         iL8Rz+TPTIEq2KUAujv9doid0PvCmDLdrR6pg8COmkuIwLqELzApfkbUZBPVSamYlM9g
         QdGsXc8zEf/WWm+7Ak6ZnAzNaKvFja4pywjhyjkd4pzJ6aHy5Ra+HYVW1uRpavHiN63l
         caiTkF21KeXhONb+IIjE9M9sxE/6NmYXggQqorPRmn5C2tbEYtzvZTntzIT+FMThQ0GG
         FCiw==
X-Gm-Message-State: AOAM532JlO0V4gm+zbFypsjZImHBbbN4NaS0Xwkt25UaHi4+q24F01Iq
        gBJXvdH54jPrikCzjjEF1tdO6Q==
X-Google-Smtp-Source: ABdhPJyoimbUKw1dU9PmF/clm4O8y2OgxYQffUahf/+XvpeXbEH2D7jT5AHeuI/gm0q58AG2CzhKtA==
X-Received: by 2002:a63:d117:: with SMTP id k23mr9731941pgg.60.1624018089298;
        Fri, 18 Jun 2021 05:08:09 -0700 (PDT)
Received: from a10ccbacb817 ([124.170.38.181])
        by smtp.gmail.com with ESMTPSA id v6sm9292224pgk.33.2021.06.18.05.08.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 18 Jun 2021 05:08:08 -0700 (PDT)
Date:   Fri, 18 Jun 2021 12:08:02 +0000
From:   Rudi Heitbaum <rudi@heitbaum.com>
To:     yhchuang@realtek.com, pkshih@realtek.com, tehuang@realtek.com
Cc:     kvalo@codeaurora.org, linux-wireless@vger.kernel.org,
        johannes@sipsolutions.net, Larry.Finger@lwfinger.net,
        sgruszka@redhat.com, briannorris@chromium.org,
        gregkh@linuxfoundation.org, chewitt@libreelec.tv
Subject: rtw88: SDIO Support
Message-ID: <20210618120758.GA20@a10ccbacb817>
References: <1555653004-1795-1-git-send-email-yhchuang@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1555653004-1795-1-git-send-email-yhchuang@realtek.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Realtek Team,

I was hoping to get an update on your progress with SDIO in the rtw88
mainline driver? Is there a WIP or prerelease available?

The UART BT is working in Mainline, but was hoping to include wireless
in the device tree kernel updates.

Thanks

Rudi

On Fri, Apr 19, 2019 at 01:49:50PM +0800, yhchuang@realtek.com wrote:
> From: Yan-Hsuan Chuang <yhchuang@realtek.com>

...

> And for now, only PCI buses (RTL8xxxE) are supported. We will add support
> for USB and SDIO in the future. The bus interface abstraction can be seen
> in this driver such as hci.h. Most of the hardware setting are the same
> except for some TRX path or probing setup should be separated.

...

> Missing feature:
> 
>  * WOW/PNO
>  * USB & SDIO bus (such as RTL8xxxU/RTL8xxxS)
>  * BT coexistence (8822B/8822C are combo ICs)

...

> The next patch set should have BT coexistence code since RTL8822B/C are
> combo ICs, and the driver for BT can be found after Linux Kernel v4.20.
> So it is better to add it first to make WiFi + BT work concurrently.
