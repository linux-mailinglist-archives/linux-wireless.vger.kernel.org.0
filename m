Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 729201F9FCE
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Jun 2020 20:59:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731410AbgFOS6b (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 15 Jun 2020 14:58:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731387AbgFOS60 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 15 Jun 2020 14:58:26 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4EA3C08C5C5
        for <linux-wireless@vger.kernel.org>; Mon, 15 Jun 2020 11:58:24 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id n141so16819092qke.2
        for <linux-wireless@vger.kernel.org>; Mon, 15 Jun 2020 11:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ogzWVexVKpi+yf06GApbiQKLooA3A6vya/Qu53dz5sI=;
        b=B79KaIJ0c/ww8HMtAlyFH2XjxV7yynKBJIWwJHZ+zW3YLHuCCz9Bbiwsd2WzFuQLPj
         AFf5Hg0Lqd/XvxHRpc9Uh/4vnlvXaITDgihFpq8wunarv4UVftdSwWHlY7Zs6O9gurGh
         IE5GaopbWKe7DlaPUx/EPeh0He+mTIL/wqUz367myp2ljsairUj+5vVlWMjYvyLYdFxp
         yylSrzx5rdvX7s5Lrdyjcy+vzWB+YunSNoTcuzE3AgfFM4I5Skeao2I26rxVl1af8CRx
         y19r67M7mx7zcJG+Kyz2nHe2SegGgVU7ADSwtl1Rh91OJTnONTAEuipSUQQypIEpgb9A
         T36g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ogzWVexVKpi+yf06GApbiQKLooA3A6vya/Qu53dz5sI=;
        b=DIwllZwEFv064CVxWpTVjhWYVkkSb9tkCa8DmWxv3V9RWmnj331+wNApHRTPWU9TL9
         XRAMk1KAU1VdyT72uh9ur4zUMO6QDg8Vt1O0ByzxBM9abRKMvHrricSFhr1iZUWq+jFA
         Qhlt5AeBM2pTix6EB8PMl6X4Ifov7BEdWzxtBHH2McDEzzb2BQFCrti9nHBPc7rToQDy
         fFMKeiXg1UkAJDN3fKECE81y0j9UfaIC8yNHQ1cyCNiu1+SLrumUJrwiFsI0koAcQWyD
         Q63LSh4NOupALnclkIxKyz+GHM6QeNk59xPPiDM2wHqhbXKaDoHrkrYxYkwaKOPC5fo2
         6EUg==
X-Gm-Message-State: AOAM5335QexsyJ7PeVU7Fx6pWx4an2t6bisk1K1UJFDJhyyvdaxhS1j1
        7logfswG+I896aeyqUYSzLggyw==
X-Google-Smtp-Source: ABdhPJygSobk4Dm93WtmDBaO2t3cPn7PZD+tDnBnapk86ninzx0O9WOhG6qnekVgX9A+5fj3vrdD7Q==
X-Received: by 2002:a37:812:: with SMTP id 18mr17402635qki.296.1592247503264;
        Mon, 15 Jun 2020 11:58:23 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id m13sm13228785qta.90.2020.06.15.11.58.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 11:58:22 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.93)
        (envelope-from <jgg@ziepe.ca>)
        id 1jkuJK-008kGo-AN; Mon, 15 Jun 2020 15:58:22 -0300
Date:   Mon, 15 Jun 2020 15:58:22 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Cc:     Kieran Bingham <kieran.bingham@ideasonboard.com>,
        linux-renesas-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-gpio@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-rdma@vger.kernel.org,
        linux-input@vger.kernel.org, linux-mtd@lists.infradead.org,
        netdev@vger.kernel.org, ath10k@lists.infradead.org,
        linux-wireless@vger.kernel.org, linux-scsi@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-usb@vger.kernel.org,
        virtualization@lists.linux-foundation.org, linux-mm@kvack.org
Subject: Re: [PATCH 00/17] spelling.txt: /decriptors/descriptors/
Message-ID: <20200615185822.GA2084429@ziepe.ca>
References: <20200609124610.3445662-1-kieran.bingham+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200609124610.3445662-1-kieran.bingham+renesas@ideasonboard.com>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, Jun 09, 2020 at 01:45:53PM +0100, Kieran Bingham wrote:
> I wouldn't normally go through spelling fixes, but I caught sight of
> this typo twice, and then foolishly grepped the tree for it, and saw how
> pervasive it was.
> 
> so here I am ... fixing a typo globally... but with an addition in
> scripts/spelling.txt so it shouldn't re-appear ;-)
> 
> Cc: linux-arm-kernel@lists.infradead.org (moderated list:TI DAVINCI MACHINE SUPPORT)
> Cc: linux-kernel@vger.kernel.org (open list)
> Cc: linux-pm@vger.kernel.org (open list:DEVICE FREQUENCY EVENT (DEVFREQ-EVENT))
> Cc: linux-gpio@vger.kernel.org (open list:GPIO SUBSYSTEM)
> Cc: dri-devel@lists.freedesktop.org (open list:DRM DRIVERS)
> Cc: linux-rdma@vger.kernel.org (open list:HFI1 DRIVER)
> Cc: linux-input@vger.kernel.org (open list:INPUT (KEYBOARD, MOUSE, JOYSTICK, TOUCHSCREEN)...)
> Cc: linux-mtd@lists.infradead.org (open list:NAND FLASH SUBSYSTEM)
> Cc: netdev@vger.kernel.org (open list:NETWORKING DRIVERS)
> Cc: ath10k@lists.infradead.org (open list:QUALCOMM ATHEROS ATH10K WIRELESS DRIVER)
> Cc: linux-wireless@vger.kernel.org (open list:NETWORKING DRIVERS (WIRELESS))
> Cc: linux-scsi@vger.kernel.org (open list:IBM Power Virtual FC Device Drivers)
> Cc: linuxppc-dev@lists.ozlabs.org (open list:LINUX FOR POWERPC (32-BIT AND 64-BIT))
> Cc: linux-usb@vger.kernel.org (open list:USB SUBSYSTEM)
> Cc: virtualization@lists.linux-foundation.org (open list:VIRTIO CORE AND NET DRIVERS)
> Cc: linux-mm@kvack.org (open list:MEMORY MANAGEMENT)
> 
> 
> Kieran Bingham (17):
>   arch: arm: mach-davinci: Fix trivial spelling
>   drivers: infiniband: Fix trivial spelling
>   drivers: infiniband: Fix trivial spelling

I took these two RDMA patches and merged them, thanks

Jason
