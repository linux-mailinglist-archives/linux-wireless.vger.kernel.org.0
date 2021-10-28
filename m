Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0897143F2CA
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Oct 2021 00:32:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231552AbhJ1Wep (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 28 Oct 2021 18:34:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231537AbhJ1Weo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 28 Oct 2021 18:34:44 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8621BC061348
        for <linux-wireless@vger.kernel.org>; Thu, 28 Oct 2021 15:32:16 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id h20so8621332ila.4
        for <linux-wireless@vger.kernel.org>; Thu, 28 Oct 2021 15:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=squareup.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=L+jfMjHAfLT8+QsPbqGqAjMOjnneHdZRDZAP9vlLKWs=;
        b=Uny7IrMZoQDiaNcxRaJwH5RbAUEh+rLUNczq9PSrZ4+ozTNt7LbNsZzBwWgL/gsOir
         0q9J0JU3YL1ILHZ90GuNixStAFiC84639sQI11qgAvlYO3NroCjdW8Vcl+8o6jyLCRVa
         k/PRLvHzN44GMee8RE8Rr4QyuWDT/21QchKkU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=L+jfMjHAfLT8+QsPbqGqAjMOjnneHdZRDZAP9vlLKWs=;
        b=bymrxb0a+SdcXr1a0QLHKyTvbsdInzN5ivF9vAuIrHmGhEZN7qFV3qSbQwU8tUpIpB
         9x5AwpQ44HuBQdPpCXfEpyiGrQ8zhQP5hKgr07c4LlKJPMaICVcHOLXAr0in43hmofwD
         Tv7Y4C+TMAvNpbMI6tZQu0PaT+HhCKfTo20rekdYApBBXj+RAfJso4sxrQ+xSh8wJpgq
         PcWepRS7Y9qjv/Jdek/89iDzVoKhNNLNTdfULVa398p6SUPdgcdXgV/8F1ZovAxHPtaY
         eDi6zRdq181Zq7F7574TqE0F4jgWfeYls+gyR1Pk3fDPYbOGzb+ouufBwY+jcxvRiEVk
         bjOw==
X-Gm-Message-State: AOAM531l2w9tK6Od3fiHFWRYWeyTSYsLkmPIyFdti4FFKFDKYcm1hpfA
        P/iIlV7GQgAYjvHxElN4vmPjDw==
X-Google-Smtp-Source: ABdhPJy/b2xM34DK4VBgQcTcs0aJO4LH7GHvWhLin/6oQNOQUqhLhCn7G08O8SA3bCFldiQYggMlVQ==
X-Received: by 2002:a92:ca48:: with SMTP id q8mr5247491ilo.173.1635460335609;
        Thu, 28 Oct 2021 15:32:15 -0700 (PDT)
Received: from localhost ([2600:6c50:4d00:cd01::382])
        by smtp.gmail.com with ESMTPSA id b4sm2153706iot.45.2021.10.28.15.32.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Oct 2021 15:32:15 -0700 (PDT)
From:   Benjamin Li <benl@squareup.com>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        linux-arm-msm@vger.kernel.org, Benjamin Li <benl@squareup.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] wcn36xx: populate band before determining rate on RX
Date:   Thu, 28 Oct 2021 15:31:29 -0700
Message-Id: <20211028223131.897548-1-benl@squareup.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

status.band is used in determination of status.rate -- for 5GHz on legacy
rates there is a linear shift between the BD descriptor's rate field and
the wcn36xx driver's rate table (wcn_5ghz_rates).

We have a special clause to populate status.band for hardware scan offload
frames. However, this block occurs after status.rate is already populated.
Correctly handle this dependency by moving the band block before the rate
block.

This patch addresses kernel warnings & missing scan results for 5GHz APs
that send their probe responses at the higher four legacy rates (24-54
Mbps), when using hardware scan offload:

  ------------[ cut here ]------------
  WARNING: CPU: 0 PID: 0 at net/mac80211/rx.c:4532 ieee80211_rx_napi+0x744/0x8d8
  Modules linked in: wcn36xx [...]
  CPU: 0 PID: 0 Comm: swapper/0 Tainted: G        W         4.19.107-g73909fa #1
  Hardware name: Square, Inc. T2 (all variants) (DT)
  Call trace:
  dump_backtrace+0x0/0x148
  show_stack+0x14/0x1c
  dump_stack+0xb8/0xf0
  __warn+0x2ac/0x2d8
  warn_slowpath_null+0x44/0x54
  ieee80211_rx_napi+0x744/0x8d8
  ieee80211_tasklet_handler+0xa4/0xe0
  tasklet_action_common+0xe0/0x118
  tasklet_action+0x20/0x28
  __do_softirq+0x108/0x1ec
  irq_exit+0xd4/0xd8
  __handle_domain_irq+0x84/0xbc
  gic_handle_irq+0x4c/0xb8
  el1_irq+0xe8/0x190
  lpm_cpuidle_enter+0x220/0x260
  cpuidle_enter_state+0x114/0x1c0
  cpuidle_enter+0x34/0x48
  do_idle+0x150/0x268
  cpu_startup_entry+0x20/0x24
  rest_init+0xd4/0xe0
  start_kernel+0x398/0x430
  ---[ end trace ae28cb759352b403 ]---

Fixes: 8a27ca394782 ("wcn36xx: Correct band/freq reporting on RX")
Signed-off-by: Benjamin Li <benl@squareup.com>
---
 drivers/net/wireless/ath/wcn36xx/txrx.c | 37 +++++++++++++------------
 1 file changed, 19 insertions(+), 18 deletions(-)

diff --git a/drivers/net/wireless/ath/wcn36xx/txrx.c b/drivers/net/wireless/ath/wcn36xx/txrx.c
index 75951ccbc840e..f0a9f069a92a9 100644
--- a/drivers/net/wireless/ath/wcn36xx/txrx.c
+++ b/drivers/net/wireless/ath/wcn36xx/txrx.c
@@ -314,8 +314,6 @@ int wcn36xx_rx_skb(struct wcn36xx *wcn, struct sk_buff *skb)
 	fc = __le16_to_cpu(hdr->frame_control);
 	sn = IEEE80211_SEQ_TO_SN(__le16_to_cpu(hdr->seq_ctrl));
 
-	status.freq = WCN36XX_CENTER_FREQ(wcn);
-	status.band = WCN36XX_BAND(wcn);
 	status.mactime = 10;
 	status.signal = -get_rssi0(bd);
 	status.antenna = 1;
@@ -327,6 +325,25 @@ int wcn36xx_rx_skb(struct wcn36xx *wcn, struct sk_buff *skb)
 
 	wcn36xx_dbg(WCN36XX_DBG_RX, "status.flags=%x\n", status.flag);
 
+	if (bd->scan_learn) {
+		/* If packet originate from hardware scanning, extract the
+		 * band/channel from bd descriptor.
+		 */
+		u8 hwch = (bd->reserved0 << 4) + bd->rx_ch;
+
+		if (bd->rf_band != 1 && hwch <= sizeof(ab_rx_ch_map) && hwch >= 1) {
+			status.band = NL80211_BAND_5GHZ;
+			status.freq = ieee80211_channel_to_frequency(ab_rx_ch_map[hwch - 1],
+								     status.band);
+		} else {
+			status.band = NL80211_BAND_2GHZ;
+			status.freq = ieee80211_channel_to_frequency(hwch, status.band);
+		}
+	} else {
+		status.band = WCN36XX_BAND(wcn);
+		status.freq = WCN36XX_CENTER_FREQ(wcn);
+	}
+
 	if (bd->rate_id < ARRAY_SIZE(wcn36xx_rate_table)) {
 		rate = &wcn36xx_rate_table[bd->rate_id];
 		status.encoding = rate->encoding;
@@ -353,22 +370,6 @@ int wcn36xx_rx_skb(struct wcn36xx *wcn, struct sk_buff *skb)
 	    ieee80211_is_probe_resp(hdr->frame_control))
 		status.boottime_ns = ktime_get_boottime_ns();
 
-	if (bd->scan_learn) {
-		/* If packet originates from hardware scanning, extract the
-		 * band/channel from bd descriptor.
-		 */
-		u8 hwch = (bd->reserved0 << 4) + bd->rx_ch;
-
-		if (bd->rf_band != 1 && hwch <= sizeof(ab_rx_ch_map) && hwch >= 1) {
-			status.band = NL80211_BAND_5GHZ;
-			status.freq = ieee80211_channel_to_frequency(ab_rx_ch_map[hwch - 1],
-								     status.band);
-		} else {
-			status.band = NL80211_BAND_2GHZ;
-			status.freq = ieee80211_channel_to_frequency(hwch, status.band);
-		}
-	}
-
 	memcpy(IEEE80211_SKB_RXCB(skb), &status, sizeof(status));
 
 	if (ieee80211_is_beacon(hdr->frame_control)) {
-- 
2.25.1

