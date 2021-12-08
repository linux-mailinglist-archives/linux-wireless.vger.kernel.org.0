Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E33C146DB89
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Dec 2021 19:50:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239375AbhLHSxf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 8 Dec 2021 13:53:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbhLHSxf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 8 Dec 2021 13:53:35 -0500
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEE0FC061746
        for <linux-wireless@vger.kernel.org>; Wed,  8 Dec 2021 10:50:02 -0800 (PST)
Received: by mail-il1-x131.google.com with SMTP id 15so3091022ilq.2
        for <linux-wireless@vger.kernel.org>; Wed, 08 Dec 2021 10:50:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=egauge.net; s=google;
        h=message-id:subject:from:to:cc:date:organization:user-agent
         :mime-version:content-transfer-encoding;
        bh=AMl4I+gAvM+xFCC8jYJSsNrNg8ityUWmdDdk0eKsq4U=;
        b=DJhqWdmuPdfEYSMU0uyHRApVlEycwACzHXqwrPe22ICA+BAeNl5U/BpKJ4Y4qaHkfB
         e9VLSMcPDDVdYnfCDIQhFcoGXP6RWxHolSH5KfnosgrPFkMcw55IDi4FY/Hnpztxnp0E
         hmvywiCWxdFgSTdtDq7/cC20FaN4iyzs6OM73SS6q8MJrpg0QIqNYpW/MXeK1qHLbztd
         q6hl8sSbaCHeqzOX1wRG7yyzoy0Fpa25otpA7CpOPzFoRnkHHgJi552lXT4UnFWLuDNX
         DXi+AqcbSBkKiQZR8uZfwvJS0hTUrlIZqUEpRokYby3nOT/XXlueMXgocYUdT9qMeI8C
         c0jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:organization
         :user-agent:mime-version:content-transfer-encoding;
        bh=AMl4I+gAvM+xFCC8jYJSsNrNg8ityUWmdDdk0eKsq4U=;
        b=RXYvQ6Oc5I4+7lqrnFbgTC3hLVwOrB/6ObDsADsRka+3Cxf4ajTQtLR9bXh1/2FHGV
         ZXgdWpph/wbE3UjlqDMf0OPswL25YIjz6GdV9Tjuefu5ogI5KJjgt6LkSA1lYdjsLppP
         KcSiI79836OFfKDHAjYEWCHVpvlVnU/qaTiBqn1MomnsSL3Lp3cOKz2JiyIqSs7hBfCt
         8rGxqWZ6ry+z+17fizciqqDZv7N1M02sIgWhldlj1v+Aco7RSBFBXbIFvUIs0babIlAq
         NI197iwnk72PrgNScmAHMhZSCSwTw9ahCWuk6UKk3wHNZH5Cz8gWSwI6AtvFhGheyQBV
         Q6aQ==
X-Gm-Message-State: AOAM531cie8DmpK6/7tAzC/8iVu3qS4SYmOckCPjuulrNH/uG8PpGBEV
        4t8LdYbUQ8Gro6fcg3KDHUN7
X-Google-Smtp-Source: ABdhPJw8yQ8+pEdmAcYzpBobSWwOfsLyYn8nw00q0i9kdKM88zDTRs9ipAUv9EdTDe1XG7sxK+8JyA==
X-Received: by 2002:a05:6e02:1545:: with SMTP id j5mr8983051ilu.20.1638989402285;
        Wed, 08 Dec 2021 10:50:02 -0800 (PST)
Received: from bixby.lan (c-73-181-115-211.hsd1.co.comcast.net. [73.181.115.211])
        by smtp.gmail.com with ESMTPSA id u4sm2448763ilv.66.2021.12.08.10.50.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Dec 2021 10:50:01 -0800 (PST)
Message-ID: <0baed35e98144bc7e29681264caf954b659cd481.camel@egauge.net>
Subject: RFC: wilc1000 module parameter to disable chip sleep
From:   David Mosberger-Tang <davidm@egauge.net>
To:     Ajay Singh <ajay.kathat@microchip.com>
Cc:     Claudiu Beznea <claudiu.beznea@microchip.com>,
        linux-wireless <linux-wireless@vger.kernel.org>
Date:   Wed, 08 Dec 2021 11:50:00 -0700
Organization: eGauge Systems LLC
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

At least on our SAMA5-based platform, the chip-sleep in the wilc1000
driver degrades WILC1000 transmit throughput by more than three times,
without providing significant power-savings.  Because of that, I have
been considering adding a module parameter that would make the chip
sleep optional.  Something along these lines:

diff --git a/drivers/net/wireless/microchip/wilc1000/wlan.c b/drivers/net/wireless/microchip/wilc1000/wlan.c
index 757bd4471fd4..421672488100 100644
--- a/drivers/net/wireless/microchip/wilc1000/wlan.c
+++ b/drivers/net/wireless/microchip/wilc1000/wlan.c
@@ -10,6 +10,12 @@
 #include "cfg80211.h"
 #include "wlan_cfg.h"
 
+static bool enable_sleep;
+module_param(enable_sleep, bool, 0644);
+MODULE_PARM_DESC(enable_sleep,
+		 "Enable chip sleep whenever the host is done communicating\n"
+		 "\t\t\twith the WILC1000 chip.");
+
 static inline bool is_wilc1000(u32 id)
 {
 	return (id & (~WILC_CHIP_REV_FIELD)) == WILC_1000_BASE_ID;
@@ -18,13 +24,13 @@ static inline bool is_wilc1000(u32 id)
 static inline void acquire_bus(struct wilc *wilc, enum bus_acquire acquire)
 {
 	mutex_lock(&wilc->hif_cs);
-	if (acquire == WILC_BUS_ACQUIRE_AND_WAKEUP)
+	if (enable_sleep && acquire == WILC_BUS_ACQUIRE_AND_WAKEUP)
 		chip_wakeup(wilc);
 }
 
 static inline void release_bus(struct wilc *wilc, enum bus_release release)
 {
-	if (release == WILC_BUS_RELEASE_ALLOW_SLEEP)
+	if (enable_sleep && release == WILC_BUS_RELEASE_ALLOW_SLEEP)
 		chip_allow_sleep(wilc);
 	mutex_unlock(&wilc->hif_cs);
 }

However, based on the numbers below, I'm now wondering if it wouldn't
make more sense to remove the chip-sleep code altogether.

Here is what I see: on a system configured for minimum power consumption
(all unnecessary daemons disabled, Ethernet unplugged) I measured 1,180 mW
when the WILC chip is in RESET (the ENABLE pin is always high on our platform).

With the wilc1000-spi/wilc1000 modules loaded and the WILC chip
running but without being associated with a WLAN network, measured
power consumption was 1,460 mW, regardless of whether chip sleep was
enabled or disabled.

On the other hand, chip-sleep makes a huge difference for TX
throughput and also reduces RX throughput, but to a smaller
extent.  Specifically, I used ttcp to measure throughput on the
test system 5 times in a row, both in TX and RX direction
(TX meaning "ttcp -t" is run from the test system to a desktop
machine):

TX throughput ("./ttcp -t DESKTOPIPADDR" on the DUT):
enable_sleep=1: 16777216 bytes in 41.22 real seconds = 397.50 KB/sec +++
enable_sleep=1: 16777216 bytes in 40.67 real seconds = 402.81 KB/sec +++
enable_sleep=1: 16777216 bytes in 41.08 real seconds = 398.83 KB/sec +++
enable_sleep=1: 16777216 bytes in 41.35 real seconds = 396.25 KB/sec +++

enable_sleep=0: 16777216 bytes in 11.12 real seconds = 1472.78 KB/sec +++
enable_sleep=0: 16777216 bytes in 10.76 real seconds = 1523.10 KB/sec +++
enable_sleep=0: 16777216 bytes in 11.83 real seconds = 1385.21 KB/sec +++
enable_sleep=0: 16777216 bytes in 10.94 real seconds = 1497.66 KB/sec +++
enable_sleep=0: 16777216 bytes in 10.13 real seconds = 1617.21 KB/sec +++

RX throughput ("./ttcp -r" on the DUT):

enable_sleep=1: 16777216 bytes in 8.44 real seconds = 1941.97 KB/sec +++
enable_sleep=1: wilc1000, w/ sleep: 16777216 bytes in 12.69 real seconds = 1290.94 KB/sec +++
enable_sleep=1: 16777216 bytes in 12.79 real seconds = 1280.93 KB/sec +++
enable_sleep=1: 16777216 bytes in 12.39 real seconds = 1322.33 KB/sec +++

enable_sleep=0: 16777216 bytes in 5.83 real seconds = 2811.94 KB/sec +++
enable_sleep=0: 16777216 bytes in 5.75 real seconds = 2848.09 KB/sec +++
enable_sleep=0: 16777216 bytes in 5.97 real seconds = 2744.44 KB/sec +++
enable_sleep=0: 16777216 bytes in 6.11 real seconds = 2681.96 KB/sec +++
enable_sleep=0: 16777216 bytes in 6.01 real seconds = 2724.09 KB/sec +++

From what I can tell, the chip-sleep code either isn't working or the chip
sleep just isn't making any real difference in power consumption.

Given this, is there any reason to keep the chip-sleep code around?

  --david


