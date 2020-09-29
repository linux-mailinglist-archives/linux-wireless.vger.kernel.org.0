Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33B0127DB23
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Sep 2020 23:53:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728262AbgI2VxJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 29 Sep 2020 17:53:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728142AbgI2VxI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 29 Sep 2020 17:53:08 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92047C0613D0
        for <linux-wireless@vger.kernel.org>; Tue, 29 Sep 2020 14:53:08 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id 197so5020479pge.8
        for <linux-wireless@vger.kernel.org>; Tue, 29 Sep 2020 14:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=laptop-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=f/gWOu1TrRoNXxwTjONo7o5+Ij7ibEG5IfBYm/+HET8=;
        b=E33XYTuKaxFZeZYJMW6eTtEGrlyGXTkwcx/zyYE4FwwLi+COEW+yWd/+0Cf95/WGtY
         gA86BU5Drjiy9diRFKDvzElxjUhLaGUOgLxvPHqm4KrxiVokwNDSCtjIpcES/TpEIpc6
         dVmJeB/tex75y/Bc/sY6UtXa0A77E3dRr5L+1KAoi+AbU1W6Vt9GYfXyFtcOrRf/wp6Q
         D0a6jDjLfVX1kaG9HLQV63nTT6mPqCav4kqlRwsiC9ZYjBegbY+4NXor8wgJHhd2Y461
         EpM2ZClNwNHNBuUJ9Q6GRMia0EL2Pv5QHFBk+FzsVmbnGLFb638dkqk6/2raUfpv9cRX
         /G4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=f/gWOu1TrRoNXxwTjONo7o5+Ij7ibEG5IfBYm/+HET8=;
        b=JXygRnO8Ca4lOfTC1LxftmaTOAu+NPcUtD0CYSX5VswgRGB+GxCKY+Tspg6369+l+9
         NZz7dxruGwyCt/SiWoDvydYWNWsr+CUKxEuojN/nAHXM3WOgccP1HSF4IQzpSPg2w2pd
         0xesCW1pFVI5JhZhNm1WPC5s4ULJUmCXRg0Xzs7lsqCnqjiQfUdfXHJE1Lrl7WRxVuBb
         DHbQP6er/g0DSugGR5Uz6Wm4h+1snjRp6ZxkjYXhYKa6jTtMrih2RZWkXIZopgnrzg7C
         rJd4yl9Yv1VXV23UMWENpLryq5F343DS2xlXQ9IfTjrpARaxVhTH+xwNV9dp9Iwv0Vja
         IrtA==
X-Gm-Message-State: AOAM532Sxmps4dJepU17o3hwzKvJB1EH4N92IXNlVb4mw910vHFjozgd
        fjMP24rDl7oRzKuiPdn5A0x+cg==
X-Google-Smtp-Source: ABdhPJzIeNXHHc94ebLFB9qkrPXXAtz33vlk/UqWEatHhLEUSYCsDM/sIDsnSGbSOH4e+0OMNyZK5g==
X-Received: by 2002:a63:2845:: with SMTP id o66mr4631601pgo.77.1601416387878;
        Tue, 29 Sep 2020 14:53:07 -0700 (PDT)
Received: from esk ([1.129.134.212])
        by smtp.gmail.com with ESMTPSA id l79sm6516011pfd.210.2020.09.29.14.53.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 29 Sep 2020 14:53:07 -0700 (PDT)
Received: from james by esk with local (Exim 4.90_1)
        (envelope-from <quozl@laptop.org>)
        id 1kNNYV-0004eb-0z; Wed, 30 Sep 2020 07:53:03 +1000
Date:   Wed, 30 Sep 2020 07:53:03 +1000
From:   James Cameron <quozl@laptop.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        linux-doc@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Chris Snook <chris.snook@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Christian Benvenuti <benve@cisco.com>,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Govindarajulu Varadarajan <_govind@gmx.com>,
        Vishal Kulkarni <vishal@chelsio.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Edward Cree <ecree@solarflare.com>,
        libertas-dev@lists.infradead.org, brcm80211-dev-list@cypress.com,
        brcm80211-dev-list.pdl@broadcom.com,
        Ping-Ke Shih <pkshih@realtek.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Intel Linux Wireless <linuxwifi@intel.com>,
        Russell King <linux@armlinux.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        intel-wired-lan@lists.osuosl.org,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Martin Habets <mhabets@solarflare.com>,
        Ulrich Kunitz <kune@deine-taler.de>,
        Jay Cliburn <jcliburn@gmail.com>,
        Paul McKenney <paulmck@kernel.org>,
        Stanislaw Gruszka <stf_xl@wp.pl>, Jouni Malinen <j@w1.fi>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Pascal Terjan <pterjan@google.com>,
        Amitkumar Karwar <amitkarwar@gmail.com>,
        Wright Feng <wright.feng@cypress.com>,
        Daniel Drake <dsd@gentoo.org>,
        Pensando Drivers <drivers@pensando.io>,
        Kalle Valo <kvalo@codeaurora.org>,
        Franky Lin <franky.lin@broadcom.com>,
        Solarflare linux maintainers <linux-net-drivers@solarflare.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Chi-Hsien Lin <chi-hsien.lin@cypress.com>,
        Xinming Hu <huxinming820@gmail.com>, netdev@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-wireless@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ganapathi Bhat <ganapathi.bhat@nxp.com>,
        Stanislav Yakovlev <stas.yakovlev@gmail.com>,
        Jon Mason <jdmason@kudzu.us>,
        Shannon Nelson <snelson@pensando.io>,
        Dave Miller <davem@davemloft.net>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [patch V2 33/36] net: libertas: Use netif_rx_any_context()
Message-ID: <20200929215302.GB16571@laptop.org>
References: <20200929202509.673358734@linutronix.de>
 <20200929203502.769744809@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200929203502.769744809@linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, Sep 29, 2020 at 10:25:42PM +0200, Thomas Gleixner wrote:
> From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> 
> The usage of in_interrupt() in non-core code is phased out. Ideally the
> information of the calling context should be passed by the callers or the
> functions be split as appropriate.
> 
> libertas uses in_interupt() to select the netif_rx*() variant which matches
> the calling context. The attempt to consolidate the code by passing an
> arguemnt or by distangling it failed due lack of knowledge about this
> driver and because the call chains are hard to follow.
> 
> As a stop gap use netif_rx_any_context() which invokes the correct code
> path depending on context and confines the in_interrupt() usage to core
> code.
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Acked-by: Kalle Valo <kvalo@codeaurora.org>

Reviewed-by: James Cameron <quozl@laptop.org>

-- 
James Cameron
http://quozl.netrek.org/
