Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B8F4320EB2
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Feb 2021 01:23:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230024AbhBVAXg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 21 Feb 2021 19:23:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbhBVAXe (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 21 Feb 2021 19:23:34 -0500
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B13A6C061574
        for <linux-wireless@vger.kernel.org>; Sun, 21 Feb 2021 16:22:54 -0800 (PST)
Received: by mail-il1-x131.google.com with SMTP id h18so1308135ils.2
        for <linux-wireless@vger.kernel.org>; Sun, 21 Feb 2021 16:22:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=egauge.net; s=google;
        h=message-id:subject:from:to:cc:date:organization:user-agent
         :mime-version:content-transfer-encoding;
        bh=h8sXftnuWoOIlOxeQC10YLx5roZ7sm+l8z4T99ZxVJw=;
        b=UZiXxU9fTG2G6P9IEk8k8CNePGdL9QE/0CS6RsvlWqKIY30eAfw+9UgEMz/EOcnKsj
         kKchfgtiMipfd0Yjix7n4YKxCTVplTwbsg8LV00r6ppmCQUJI2y2IbfNql2ndmIuHBKt
         Eb+UPhiMO+GEiihnpYE4+8ELaHvTV/SxgSXAIZlVO8yOCxW5deor2/G4PIPzH19VnQCz
         Lo636KqRKztNtrj67rkGlaqe496/ZR8sXaw7qUwhdAKlwLdq01Y4cdZR4nw85rgVRIK3
         FC8GbRM2xpVcXv2Y+aXqw1NrWW6MJJPYbJOzjRCeSsplS44ele3jJLS6IvW4uPN7FnX6
         bh7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:organization
         :user-agent:mime-version:content-transfer-encoding;
        bh=h8sXftnuWoOIlOxeQC10YLx5roZ7sm+l8z4T99ZxVJw=;
        b=qcdDFQF8lVO1+KtVhjAtT5rjmd/HvvTZmXzi9W6X4lN7IGDz3w5UROwDGz9iuNSTRf
         qVEsANxYTmr66B8Ix/bbQFx7tYsAaPi0m12EttdR2qOgl2hokGCl7qL76YIf26KSSWY7
         Sz8RKsu/5dIOuW2YTVAdUlA+THHBnKQjGU7ZdP2xg0CqOBgRagv9Jnul8xZC5r6Ayngi
         2HoRw2/P86YK0aJeCmj8aw7kmPHgbZ5YzovIiuMhBnYXTlN8TLPGQNzNjFzUABKBljCv
         OIR1JuTWic/JczinH6bk7EeBtXCefo1Fc21Vle2Djc8pyRVPyc5ifWGJXakO/RZQz4Yf
         X0cQ==
X-Gm-Message-State: AOAM531cRjVr2T2Mi2i4ktphwVsQDGK3UG8dGS1sE3eb+eTUU8w/1snM
        r0bYks6rhXBr5o5w73KSXhkfpFeZ/ZjDd4U=
X-Google-Smtp-Source: ABdhPJyPYPIqqo47seIvyhLWadyrQ8BjQcmox37XqdHC3+UTV6i45H/FZtNjYJ6Z3w9P/MXAOleMng==
X-Received: by 2002:a92:cda1:: with SMTP id g1mr12999883ild.267.1613953373756;
        Sun, 21 Feb 2021 16:22:53 -0800 (PST)
Received: from ?IPv6:2601:281:8300:4e0:c915:9fee:d41e:b60d? ([2601:281:8300:4e0:c915:9fee:d41e:b60d])
        by smtp.gmail.com with ESMTPSA id v1sm10485004ilm.35.2021.02.21.16.22.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Feb 2021 16:22:53 -0800 (PST)
Message-ID: <e8ed97f214f6087b7ac59298c8efe2d1144f7d55.camel@egauge.net>
Subject: wilc1000 driver
From:   David Mosberger-Tang <davidm@egauge.net>
To:     linux-wireless <linux-wireless@vger.kernel.org>
Cc:     Ajay Singh <ajay.kathat@microchip.com>, davidm@egauge.net
Date:   Sun, 21 Feb 2021 17:22:52 -0700
Organization: eGauge Systems LLC
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

So, I'd like to provide some patches for the wilc driver, but I'm
unclear what the most effective way to go about this is.

The driver in mainline (driver/net/wireless/microchip/wilc1000) only
seems to support WILC1000 (not WILC3000) and uses firmware:

  atmel/wilc1000_wifi_firmware-1.bin

whereas the linux-at91 driver (driver/staging/wilc1000) supports both
WILC1000 and WILC3000 and uses firmware

  mch/wilc1000_wifi_firmware.bin

(for WILC1000).

For the hardware I have (embedded system with WILC1000/SPI), the
mainline driver doesn't load, whereas the driver from linux-at91 does
load and work(mostly).

I'd really like to work off of mainline since it's much easier to track
things with a repository that's updated frequently, but it looks to me
like the mainline may be missing a lot of code that's already in
linux-at91.

What am I supposed to do?

  --david

