Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3147836E6F6
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Apr 2021 10:19:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232455AbhD2ISg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 29 Apr 2021 04:18:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230071AbhD2ISg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 29 Apr 2021 04:18:36 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1128EC06138B
        for <linux-wireless@vger.kernel.org>; Thu, 29 Apr 2021 01:17:50 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id z16so5681066pga.1
        for <linux-wireless@vger.kernel.org>; Thu, 29 Apr 2021 01:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=user-agent:from:to:subject:date:message-id:mime-version;
        bh=YDrZhDTorDYr8K6DyNqJ1O/LB9Vtp40eiSoUA9mZRhc=;
        b=PO/fnKldpJmtkYwBjW9Gh/aPckWci/Uy0wSV8dad3ccuC+k2dgyzuKnX16BNe7ukPQ
         1DfyhQ+80KzTzFe98Yvgswuqwdc2EuWjQLvDVPVXBGBdTQ+Mjl99LzV4KSISqivmxUuI
         CRa/HTOhFLZbiCjHtE8L7Qr8ga2EO/cnt38wUWij2JHkYV5O6d4+1bL/wVbPCBr9brst
         UCSur9TQX1G6lA3WqglaFFHph8zERAcNnPxZObEIzL9W3AMRT2Cya8PNXVI0xdB3qusD
         RZBMUKxmats7z7ekHPTCT+WcfRI6J/6mzqm7bk4hbD2ooWRpQ9Mro0hoLpjXiMFdE0Dg
         XoYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:user-agent:from:to:subject:date:message-id
         :mime-version;
        bh=YDrZhDTorDYr8K6DyNqJ1O/LB9Vtp40eiSoUA9mZRhc=;
        b=RbEDiVIPUvNobn96xXH1PrJpW/fqFQgSyIRdMCAPWGC3ICpAalUsRmJ1sFJUBypjGa
         zt97afuDgrEfSTCPUBICcPj3JhguB5jda+7UplFi9lhNwp1eY6upcrrMgjUvyxpJmChE
         Esx0FBfxw/mz1aQM/Hpn2eI1CxHOVuYcUL9+iaSFvHH8vz0eUA28ZK5gky13xYtH+/fx
         x9q9iNGFj4YtRs9wrw/PsERB9jx5yQEHYmQuOVeKtXtye6yom4Z+w2GFqxKg4iuxfDiE
         awnQRc5TOZ8z+g2u2yG2sslwYqx3Tn1QmeLmnBt/U3eMxgcyIN3jcbIMBfEDabfSkp7S
         d4MA==
X-Gm-Message-State: AOAM5330sdLC9Fh/nlmX17tSGcyMVYCdF2EjdlSUPCguZNLJxN9KV9az
        vm6YKf2CYvqUJOTb9VlPqWhCiJWLXpA=
X-Google-Smtp-Source: ABdhPJxwi+p55wIB7gdilBBHMIjdyCsTky1gFTIX3Jr0BGvCzuBM+gd11iOSCVcqB7MEDI47rLWRqQ==
X-Received: by 2002:a05:6a00:781:b029:27c:d3f6:d019 with SMTP id g1-20020a056a000781b029027cd3f6d019mr7541821pfu.42.1619684269431;
        Thu, 29 Apr 2021 01:17:49 -0700 (PDT)
Received: from localhost (14-202-110-190.static.tpgi.com.au. [14.202.110.190])
        by smtp.gmail.com with ESMTPSA id bf3sm1615044pjb.16.2021.04.29.01.17.48
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Apr 2021 01:17:49 -0700 (PDT)
User-agent: mu4e 1.4.15; emacs 27.1
From:   Alexis <flexibeast@gmail.com>
To:     linux-wireless@vger.kernel.org
Subject: rtw_8821ce: "rfe 4 isn't supported". Asus D509DA laptop.
Date:   Thu, 29 Apr 2021 18:17:45 +1000
Message-ID: <8735v9sdw6.fsf@ada>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


Hi all,

i've just acquired an Asus D509DA, and wifi isn't working:

    rtw_8821ce 0000:01:00.0: enabling device (0000 -> 0003)
    rtw_8821ce 0000:01:00.0: Firmware version 24.8.0, H2C version 
    12
    rtw_8821ce 0000:01:00.0: rfe 4 isn't supported
    rtw_8821ce 0000:01:00.0: failed to setup chip efuse info
    rtw_8821ce 0000:01:00.0: failed to setup chip information

`uname -a`:

    Linux voidlinux 5.11.16_1 #1 SMP 1619045101 x86_64 GNU/Linux

Void firmware package:

    linux-firmware-network-20210315_2

Some previous mentions of this issue on this list:

    https://marc.info/?l=linux-wireless&m=159981742905028
    https://www.spinics.net/lists/linux-wireless/msg206075.html

Some other mentions elsewhere:

    https://bugzilla.kernel.org/show_bug.cgi?id=212435
    https://github.com/tomaspinho/rtl8821ce/issues/142

Please let me know if there's any further information i can 
provide. i'm not subscribed to the list.

Thanks!


Alexis.
