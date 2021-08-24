Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C4753F60CB
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Aug 2021 16:44:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238012AbhHXOoo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 24 Aug 2021 10:44:44 -0400
Received: from phobos.denx.de ([85.214.62.61]:37600 "EHLO phobos.denx.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237963AbhHXOon (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 24 Aug 2021 10:44:43 -0400
Received: from localhost.localdomain (unknown [IPv6:2804:14c:485:504a:4cbe:6a59:9f33:374b])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: festevam@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id BDDE38020E;
        Tue, 24 Aug 2021 16:43:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1629816238;
        bh=1k67/hZ/m3v4Vrx+dVgJeJKIDgujFmuuGBL8bL7tIm0=;
        h=From:To:Cc:Subject:Date:From;
        b=eq7bEq0F3hBf7FqYmOxA5OYwIumfXuBCs1YSG+N/JiJdImhdO80WomZ1+BJ4WgNOu
         s6x9x/jL1x7UUQTn0DcgVXTBizHuUlCk/eUiYoDCJqUS560IzJfx9PVm03zr/tp2QU
         jqijbC+a2XSJVnNx3x1Fh2Tc6VWzb+i/h4iheRvhTQjgNfdzUTrxPZLH2d2kMqrpps
         oZqO9+4u7ZITkjlb+b9afrVufiOBZ1Q4dIzs/d8ev8kQGZZ2t/lgidCcof2EuMmkR1
         ACIeby9HJfeb7gb7k81jWQ3WNYXGLVtCM0OjHf3EVN7c0QKe+XVufzPXlfNqzUKAko
         cDW7Aziuh9lww==
From:   Fabio Estevam <festevam@denx.de>
To:     kvalo@codeaurora.org
Cc:     kuba@kernel.org, ath10k@lists.infradead.org,
        linux-wireless@vger.kernel.org, paulmck@kernel.org, marex@denx.de,
        wgong@codeaurora.org, alagusankar@silex-india.com,
        erik.stromdahl@gmail.com, Fabio Estevam <festevam@denx.de>
Subject: [PATCH] ath10k: sdio: Add missing BH locking around napi_schdule()
Date:   Tue, 24 Aug 2021 11:43:39 -0300
Message-Id: <20210824144339.2796122-1-festevam@denx.de>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.2 at phobos.denx.de
X-Virus-Status: Clean
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On a i.MX-based board with a QCA9377 Wifi chip, the following errors
are seen after launching the 'hostapd' application:

hostapd /etc/wifi.conf
Configuration file: /etc/wifi.conf
wlan0: interface state UNINITIALIZED->COUNTRY_UPDATE
NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #08!!!
Using interface wlan0 with hwaddr 00:1f:7b:31:04:a0 and ssid "thessid"
IPv6: ADDRCONF(NETDEV_CHANGE): wlan0: link becomes ready
wlan0: interface state COUNTRY_UPDATE->ENABLED
wlan0: AP-ENABLED
NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #08!!!
NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #08!!!
NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #08!!!
NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #08!!!
...

Fix this problem by adding the BH locking around napi-schedule(),
in the same way it was done in commit e63052a5dd3c ("mlx5e: add
add missing BH locking around napi_schdule()").

Its commit log provides the following explanation:

"It's not correct to call napi_schedule() in pure process
context. Because we use __raise_softirq_irqoff() we require
callers to be in a context which will eventually lead to
softirq handling (hardirq, bh disabled, etc.).
    
With code as is users will see:
    
NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #08!!!
"

Fixes: cfee8793a74d ("ath10k: enable napi on RX path for sdio")
Signed-off-by: Fabio Estevam <festevam@denx.de>
---
 drivers/net/wireless/ath/ath10k/sdio.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath10k/sdio.c b/drivers/net/wireless/ath/ath10k/sdio.c
index b746052737e0..eb705214f3f0 100644
--- a/drivers/net/wireless/ath/ath10k/sdio.c
+++ b/drivers/net/wireless/ath/ath10k/sdio.c
@@ -1363,8 +1363,11 @@ static void ath10k_rx_indication_async_work(struct work_struct *work)
 		ep->ep_ops.ep_rx_complete(ar, skb);
 	}
 
-	if (test_bit(ATH10K_FLAG_CORE_REGISTERED, &ar->dev_flags))
+	if (test_bit(ATH10K_FLAG_CORE_REGISTERED, &ar->dev_flags)) {
+		local_bh_disable();
 		napi_schedule(&ar->napi);
+		local_bh_enable();
+	}
 }
 
 static int ath10k_sdio_read_rtc_state(struct ath10k_sdio *ar_sdio, unsigned char *state)
-- 
2.25.1

