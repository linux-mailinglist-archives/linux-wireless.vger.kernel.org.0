Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FAED46F2D6
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Dec 2021 19:16:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241733AbhLISTd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 9 Dec 2021 13:19:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237501AbhLISTb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 9 Dec 2021 13:19:31 -0500
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45013C061746
        for <linux-wireless@vger.kernel.org>; Thu,  9 Dec 2021 10:15:58 -0800 (PST)
Received: by mail-il1-x12d.google.com with SMTP id d14so3770587ila.1
        for <linux-wireless@vger.kernel.org>; Thu, 09 Dec 2021 10:15:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=egauge.net; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:user-agent:mime-version:content-transfer-encoding;
        bh=dFns64ufLqL975ldn7IT9bs+MSnRRPtkiO/EFdARXbk=;
        b=ont+UNLfF7BxKeGp4GahNh0FU9a1g4B8psf1iUv6es1RBt/BHgb+CMwjytQEomFRlU
         MAPgMRmtYkJEtdgNrsc8WjdHw+cYrb0szTTJt46XfQSv4ar1XIc+3HHhTomksMXy7iVz
         QXdFRElkbaLWqmsntOWgTXPT4E0XqYIbaZEcMzlg3jsA+HX0XxuRvhvQGoZEsiRTTn9m
         M3NxVh6Anxg+QEzBlDvgqe/EGIjMLK1txrKL2wyLKy2cr/Rj0Iy33jqFYkyPkn9gM4gD
         /rKQLv7ysxwLdRZ6f/ffh09olR1o2HjOW7VaN22l2I3i95gpPpPKkXJeG5QUsEz18dIQ
         tccQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=dFns64ufLqL975ldn7IT9bs+MSnRRPtkiO/EFdARXbk=;
        b=UUaMJzSgPIWhDHkJqm0xMRNc3zAqfbL93Lf/QYVAcuOG/iZ5ZixKHVky/e7Ji7pBBC
         RSG/uiRyCBhBu7elKgf0ofokFMhCx30dp/y5InYyIEJkd0Gy+Q1umDiqhoBZiR/QDGan
         hGTT2CNpc53UYhi5R2YiG+2Vt1Tz1JptPE/E5mZgeLTgdDhX4Gp2s7akkOAcZymbIzAs
         rjiE8m/p7VZivbEP4wgj/JPfNO6r/7UrOWJ1u6M8jqCEAkqCHg4qADUi9NDZO0G7iQmf
         J10i1lSuxgr5WOW9cFRd01Upz8Yrbr/LDrKAvpqcJPVtZ4BEzPTtu+eVmQoQiZqboHij
         ybOw==
X-Gm-Message-State: AOAM531/224DfHCtFL0N56SaS8Gil/mwE29hWl4J4kSzsaTIpWeF8m7d
        g2aQFGvab+/2Vb/z7P8uu6QZ
X-Google-Smtp-Source: ABdhPJxdvuc9q9RFwGbbi129JLHMfVd2JJc50vOFOCfvK3AOayW88hNHuhSkQNYL4E1hRhGoOuIXdQ==
X-Received: by 2002:a92:ca46:: with SMTP id q6mr14067120ilo.54.1639073757472;
        Thu, 09 Dec 2021 10:15:57 -0800 (PST)
Received: from bixby.lan (c-73-181-115-211.hsd1.co.comcast.net. [73.181.115.211])
        by smtp.gmail.com with ESMTPSA id b25sm248812iob.27.2021.12.09.10.15.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Dec 2021 10:15:57 -0800 (PST)
Message-ID: <a03e133e46ff305dbad796913b79c994c91581d5.camel@egauge.net>
Subject: Re: RFC: wilc1000 module parameter to disable chip sleep
From:   David Mosberger-Tang <davidm@egauge.net>
To:     Ajay.Kathat@microchip.com
Cc:     Claudiu.Beznea@microchip.com, linux-wireless@vger.kernel.org
Date:   Thu, 09 Dec 2021 11:15:56 -0700
In-Reply-To: <4bf158ac-18d0-6feb-fbef-dc0739d74487@microchip.com>
References: <0baed35e98144bc7e29681264caf954b659cd481.camel@egauge.net>
         <4bf158ac-18d0-6feb-fbef-dc0739d74487@microchip.com>
Organization: eGauge Systems LLC
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

[Sorry, my first email was accidentally had the patch appended as a MIME
 attachment.]

On Thu, 2021-12-09 at 09:20 +0000, Ajay.Kathat@microchip.com wrote:
> On 09/12/21 00:20, David Mosberger-Tang wrote:

> The "chip_wakeup" & "chip_allow_sleep" API's are required to configure 
> the wake-up registers in wilc. These registers must be configured 
> correctly when the power save mode is enabled.

I see.

> > Here is what I see: on a system configured for minimum power consumption
> > (all unnecessary daemons disabled, Ethernet unplugged) I measured 1,180 mW
> > when the WILC chip is in RESET (the ENABLE pin is always high on our
> > platform).
> > 
> > With the wilc1000-spi/wilc1000 modules loaded and the WILC chip
> > running but without being associated with a WLAN network, measured
> > power consumption was 1,460 mW, regardless of whether chip sleep was
> > enabled or disabled.
> 
> Did you test by enabling the power-save mode with "wpa_supplicant" or 
> using "iw" command. For power consumption measurement, please try by 
> disabling the PSM mode.

No, I have not played with power-saving mode.  There are some disconcerting
messages when turning PSM on:

[ 1764.070375] wilc1000_spi spi1.0: Failed cmd, cmd (ca), resp (00)
[ 1764.076403] wilc1000_spi spi1.0: Failed cmd, read reg (000013f4)...

The driver does still work, but occasionally, I get long streams of these
messages, sometimes it gets to the point where there are so many that the
watchdog timer ends up rebooting the system.

> The chip-sleep code is needed to configure the registers properly for 
> wilc and not using these sequence would have impact on sending the data 
> to wilc, especially when the PS mode is enabled.

How about something along the patch below then?

With this patch, I see the following iperf3 performance (120 second average):

PSM on:
[  4]   0.00-120.00 sec  47.6 MBytes  3.33 Mbits/sec    0             sender

PSM off:
[  4]   0.00-120.00 sec   201 MBytes  14.0 Mbits/sec   12             sender

In terms of power consumption:

   baseline                : 1.2 W
   PSM on, idle            : 1.2 W
   PSM on, TX @ 3.33 Mbps  : 1.7 W
   PSM off, idle           : 1.5 W
   PSM off, TX @ 14.0 Mbps : 2.4 W

  --david

diff --git a/drivers/net/wireless/microchip/wilc1000/hif.c
b/drivers/net/wireless/microchip/wilc1000/hif.c
index 44e93cd5e3df..09aa5ced19d3 100644
--- a/drivers/net/wireless/microchip/wilc1000/hif.c
+++ b/drivers/net/wireless/microchip/wilc1000/hif.c
@@ -1912,6 +1912,7 @@ int wilc_edit_station(struct wilc_vif *vif, const u8 *mac,
 
 int wilc_set_power_mgmt(struct wilc_vif *vif, bool enabled, u32 timeout)
 {
+	struct wilc *wilc = vif->wilc;
 	struct wid wid;
 	int result;
 	s8 power_mode;
@@ -1927,6 +1928,8 @@ int wilc_set_power_mgmt(struct wilc_vif *vif, bool
enabled, u32 timeout)
 	result = wilc_send_config_pkt(vif, WILC_SET_CFG, &wid, 1);
 	if (result)
 		netdev_err(vif->ndev, "Failed to send power management\n");
+	else
+		wilc->power_save_mode = enabled;
 
 	return result;
 }
diff --git a/drivers/net/wireless/microchip/wilc1000/netdev.h
b/drivers/net/wireless/microchip/wilc1000/netdev.h
index 152408232d51..db149abc5d0d 100644
--- a/drivers/net/wireless/microchip/wilc1000/netdev.h
+++ b/drivers/net/wireless/microchip/wilc1000/netdev.h
@@ -267,6 +267,7 @@ struct wilc {
 
 	int clients_count;
 	struct workqueue_struct *hif_workqueue;
+	bool power_save_mode;
 	enum chip_ps_states chip_ps_state;
 	struct wilc_cfg cfg;
 	void *bus_data;
diff --git a/drivers/net/wireless/microchip/wilc1000/wlan.c
b/drivers/net/wireless/microchip/wilc1000/wlan.c
index ddd382996275..0e0e325d396e 100644
--- a/drivers/net/wireless/microchip/wilc1000/wlan.c
+++ b/drivers/net/wireless/microchip/wilc1000/wlan.c
@@ -18,13 +18,13 @@ static inline bool is_wilc1000(u32 id)
 static inline void acquire_bus(struct wilc *wilc, enum bus_acquire acquire)
 {
 	mutex_lock(&wilc->hif_cs);
-	if (acquire == WILC_BUS_ACQUIRE_AND_WAKEUP)
+	if (acquire == WILC_BUS_ACQUIRE_AND_WAKEUP && wilc->power_save_mode)
 		chip_wakeup(wilc);
 }
 
 static inline void release_bus(struct wilc *wilc, enum bus_release release)
 {
-	if (release == WILC_BUS_RELEASE_ALLOW_SLEEP)
+	if (release == WILC_BUS_RELEASE_ALLOW_SLEEP && wilc->power_save_mode)
 		chip_allow_sleep(wilc);
 	mutex_unlock(&wilc->hif_cs);
 }

