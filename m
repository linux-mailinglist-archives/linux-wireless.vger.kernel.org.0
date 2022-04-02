Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8F4A4F0474
	for <lists+linux-wireless@lfdr.de>; Sat,  2 Apr 2022 17:36:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237607AbiDBPi2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 2 Apr 2022 11:38:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237518AbiDBPiS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 2 Apr 2022 11:38:18 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 050CC143459
        for <linux-wireless@vger.kernel.org>; Sat,  2 Apr 2022 08:36:26 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id z12so9842521lfu.10
        for <linux-wireless@vger.kernel.org>; Sat, 02 Apr 2022 08:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sQp3E/tCtBXrNhoAsk/Z0N/SCGmUP8kpIty3COodPo0=;
        b=A65EsVXEABnj6gSYQg6vpas/3zrSi/rQORU3vmz8AqDExqUXj0Tz5FRs/ZowLKOOdn
         V5cIP2e7IMvKQP0u1xQjdgVDdDzVsIyC69JeKmbEUFjecNVpItjGInEDdtCRbb56S2rF
         q0deq9CGnM62VhbTdSLOjaZIIjdP/IOhyReGIFVxxtUCAO+myyQOWDOvPb80VLZk46I7
         y+G6uC49Dw5ebnH+jFHOFVWBQ7Vqf7V8ptcWOSDiUNRAIkUhd8WUMxIXMzFoQf+wEHtI
         CF8JuUUFJ/lBPYPy5ZSMWap9h5GqVQmhnXW+D3j28oxRnpijmFLGheIFA/oyNSLJQpj6
         B2sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sQp3E/tCtBXrNhoAsk/Z0N/SCGmUP8kpIty3COodPo0=;
        b=QDwqcq7lJieqLKHx3uRCZH/fO2/bYt3vw2KovLSQZfSU5KEkBuKZCDxc3HjvHCbfUI
         iloiPbmtWYJ1c8YB8XHsBDwk7RVXv84YyqS1IP6usPt/2szYezJvUex3+bYSfthSqNnf
         v1TUlPRhUvrhDv+DdrRslIplgS0OWde/oh/vqjTYkNrzHiSeccEzYNFunhWFP4ab4NTS
         Ij39hC/MEjP+XQgJQXU/RzPmXCPVMV+Md9uxzolMXKZwMWjk+K3xuVxOJFIY/HHrybyO
         WLpAWDq2tZTjgVh0BWcKwQ7XmFlQHnBZxXp9sZu0BseIJHwJr27VVqgU8N9ANJkWSwSd
         LCZg==
X-Gm-Message-State: AOAM533sixQ6zmhELlXmqqKvzLmA06XDOcW11FF/seVHlD1K6D1dfeI2
        00YsKVeOBFqcvQRaz9qkB/8vgSdTz6k=
X-Google-Smtp-Source: ABdhPJyHE4/QbkgpBXdGcPqWrtFCSZBwKxDLhQyBeLGnKHYRLR3VUzBdIk65DNiw2Ywg3Rrgo2bFrw==
X-Received: by 2002:ac2:4dbb:0:b0:44a:da57:33f5 with SMTP id h27-20020ac24dbb000000b0044ada5733f5mr5439929lfe.653.1648913784094;
        Sat, 02 Apr 2022 08:36:24 -0700 (PDT)
Received: from rsa-laptop.rossosh.lan ([217.25.229.52])
        by smtp.gmail.com with ESMTPSA id z18-20020a2e3512000000b0024b12b5044csm52884ljz.89.2022.04.02.08.36.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Apr 2022 08:36:23 -0700 (PDT)
From:   Sergey Ryazanov <ryazanov.s.a@gmail.com>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: [PATCH RFC 0/3] ath10k: add encapsulation offloading support
Date:   Sat,  2 Apr 2022 18:36:12 +0300
Message-Id: <20220402153615.9593-1-ryazanov.s.a@gmail.com>
X-Mailer: git-send-email 2.32.0
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

Hello,

this series introduces driver support for hardware encapsulation
offloading feature.

The main goal of the series is an overall improvement of system
performance. On a QCA9563+QCA9888-based access point in bridged mode,
encapsulation offloading increases TCP 16-streams DL throughput from
365 to 396 mbps (+8%) and UDP DL throughput from 436 to 483 mbps (+11%).

The series consist of three patches, the first two prepare the code, and
the last one introduces the offloading support itself. The first patch
reworks transmission status reporting to make it flexible enough to
support 802.11 and Ethernet encapsulated frames reporting. The second
patch reworks the module parameter that configures the main
encapsulation format of frames that are passed from the driver to the
hardware. It makes it possible to configure more encapsulation methods
than just raw or not-raw. And, as stated before, the third patch
actually introduces offloading support. It changes a couple of frame
analysis places along the xmit path and starts reporting offloading
support to mac80211 via the corresponding hw attribute.

The new feature has been extensively tested with QCA9888 and works well,
but it may introduces some regression for other untested chips. So the
series is just an RFC for now.

Sergey Ryazanov (3):
  ath10k: improve tx status reporting
  ath10k: turn rawmode into frame_mode
  ath10k: add encapsulation offloading support

 drivers/net/wireless/ath/ath10k/core.c | 11 +++--
 drivers/net/wireless/ath/ath10k/core.h |  1 +
 drivers/net/wireless/ath/ath10k/mac.c  | 67 +++++++++++++++++++++-----
 drivers/net/wireless/ath/ath10k/txrx.c | 12 ++++-
 4 files changed, 73 insertions(+), 18 deletions(-)

-- 
2.34.1

