Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7EBB3A575C
	for <lists+linux-wireless@lfdr.de>; Sun, 13 Jun 2021 11:34:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231424AbhFMJgJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 13 Jun 2021 05:36:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230255AbhFMJgJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 13 Jun 2021 05:36:09 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF2C2C061574
        for <linux-wireless@vger.kernel.org>; Sun, 13 Jun 2021 02:33:54 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id i94so10927180wri.4
        for <linux-wireless@vger.kernel.org>; Sun, 13 Jun 2021 02:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:subject:message-id:in-reply-to:references:reply-to
         :mime-version:content-transfer-encoding;
        bh=kXu0ZkdSLyVjOlphVreWhdeDA/Vpu2xsRBgVsgVowlg=;
        b=l5Tk9JD3R3ocPN5jPFXEj6s+RrMasX8bcrx2PLTcNUT1O6drLlDNLZocJxVxqot/n9
         gpHf+8HZSMmfhdlYfVQKiomCSy4/M+iTeTlQ5195RNVeCvwKM/NdASSXat9pdY1rJsRr
         hMZ4l0l+C1mOV6//iulhgHoh8pR3Mr8fH0DmC5Nb63lM/3gFEbWHlohYNm92BcknbKfl
         Jk084n7Rw0F3ieZwnVYVlKgqXqUK4BzJh95YchMduE5ERg5HUb/eBME8lUcgT58E43uj
         hOi93VOnmsbVrqLjTo5lenGZ5maYhU5AkeCVnLBuDY+u8kKN2YrbCBWnTCguuq9IJ2OH
         b7dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:subject:message-id:in-reply-to
         :references:reply-to:mime-version:content-transfer-encoding;
        bh=kXu0ZkdSLyVjOlphVreWhdeDA/Vpu2xsRBgVsgVowlg=;
        b=S+leTy0DRh9uM7zFurwIrUdeoHDfHqYffRcPj1aTuSBnwgNu3YCFQ5rtaM/u38WeVU
         1HiyQBIdJ4PVQg9+b+QjTvZKzxAJJV3+1b62arsBKN8MxrI8Lpr3iKC9HR8PlDVnqOKi
         kE9UGWu96WeUsO4d84CoeRw0Xrb3sIn9BYU6lsorwZvyOiIUU5gUWUSKV17TKm/PjSqK
         5VcWwYuo69260YClwUczLo5eFsUaflEe1ypuNYMwjgJYcqL9zkBmEhV78D5ba4J6t4Sd
         tgvDuHoWgaCKKaF8ehmAYMDNVShkTrvXsKPIEg2L1u/aY3pdq0bR+HaA4S0YzPZBea7Y
         IMHg==
X-Gm-Message-State: AOAM530ppM272aZNrmUbEWzIpPtu/NXbny6k5fDUdLw4QzIrX1JbTJXy
        eLZtyGAuz2ITyM2MHaGFd631gqrEP4JLeg==
X-Google-Smtp-Source: ABdhPJzuPVHO2OTcQW8RK+eYD9eVMSMppKVOKluU4ldzz83Q8Wf73zZYZBQQt13r1wGIX6sRWCNmrg==
X-Received: by 2002:a5d:444e:: with SMTP id x14mr13533199wrr.200.1623576831441;
        Sun, 13 Jun 2021 02:33:51 -0700 (PDT)
Received: from ptb (static-188-208-229-77.ipcom.comunitel.net. [77.229.208.188])
        by smtp.gmail.com with ESMTPSA id s62sm17724538wms.13.2021.06.13.02.33.51
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Jun 2021 02:33:51 -0700 (PDT)
From:   Peter Breuer <peter.t.breuer@gmail.com>
X-Google-Original-From: Peter Breuer <Peter.T.Breuer@gmail.com>
Date:   Sun, 13 Jun 2021 10:33:47 +0100
To:     linux-wireless@vger.kernel.org
Subject: Re: ipw2200 driver no longer sets encrypted WEP in ipw2200 device?
Message-ID: <20210613103347.0c2148bd@ptb>
In-Reply-To: <20210610131139.4fce5404@ptb>
References: <20210610131139.4fce5404@ptb>
Reply-To: Peter.T.Breuer@gmail.com
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; i686-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This list is so offically dead! Still, I have a clue for you:

On Thu, 10 Jun 2021 13:11:39 +0100
Peter Breuer <Peter.T.Breuer@gmail.com> wrote:

> Hello - has somebody disabled encrypted WEP in ipw2200 firmwares, or
> done something global that would have an equivalent effect, perhaps

Same issue with WPA1 or 2. Plaintext is OK except the signal keeps
dropping, and the same is true even from my modern mobile phone.

The clue is this note from TP-Link:

  https://www.tp-link.com/en/support/faq/2303/
  TP-Link has officially begun to launch our 802.11AX class wireless
  routers.  However, some Intel WLAN adapters with old driver can't
  detect the wireless signal of our routers.  Please upgrade the driver
  of your WLAN card to the latest if you have this issue.

  Intel has also released a FAQ for its compatibility issue:
  https://www.intel.com/content/www/us/en/support/articles/000054799/network-and-i-o/wireless-networking.html

I imagine the issue is broad (TP-Link would downplay it) and might be a
major messup.  Blame Intel for not predicting your future mistake ,
would you ..  heh heh and see what happens.

Has anything of these Intel driver changes made it into a recent kernel?

See where brand loyalty gets you ...

PTB
