Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF48F3FB8F7
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Aug 2021 17:26:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237516AbhH3P1o (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 30 Aug 2021 11:27:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232682AbhH3P1n (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 30 Aug 2021 11:27:43 -0400
Received: from mail-wr1-x464.google.com (mail-wr1-x464.google.com [IPv6:2a00:1450:4864:20::464])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22038C061764
        for <linux-wireless@vger.kernel.org>; Mon, 30 Aug 2021 08:26:50 -0700 (PDT)
Received: by mail-wr1-x464.google.com with SMTP id g18so15496770wrc.11
        for <linux-wireless@vger.kernel.org>; Mon, 30 Aug 2021 08:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flowbird.group; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hKytXfKHT59Xod3IwiVA4kFV4H40XsoUwHnnWsDGXc0=;
        b=Z932icKIw3uUCi64EfSeL+vGO+/OpdCHYCI8DE+yfeu5DECyTbd3Y6DRQYnuycrWJR
         XsY1O6sr1ZHqo696OrG3UoqomWIBVS0toJwSE/b8tWfW7cBXv3/+DYDOGQrG+xRt/Bpd
         3pIheicciu9l/L7Z4s3uLrkDtdTDelFHNQojKUMZG0M6nM2ZLAtS+BhonFQCcPTPW/DN
         7naO9Kl41Di8PLbiKuPdlKtIK2jgvRa1aWiDzFTfPhza5yAKz4v7ba66QQqJ7ysASFYx
         0Baym6J8lUQ3dlY1w4oNWl3pZzF/z14G3c9a10zhHkd0q2rU/DnErDh7NE6w0uxf/YCv
         BwbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hKytXfKHT59Xod3IwiVA4kFV4H40XsoUwHnnWsDGXc0=;
        b=Yuf8kqF8BvlAYYOKdAcipy3+5htteiXbPOjdmVbOJBMZO2NBZtt8jwgTv/aD+v1p2X
         dGBvs3WcTbRnuW3Da0L8EEj+xeduJLL8vzh97+7t48YuXU4qD3izXW+OdMS1k3Zh067c
         c5cUvfQfYcp2UTFrtxx6ee7uQzZjltyAkdO4bKj6qZym0fHij6lXeQ253oWWAcK1lckP
         /IrycmdTWT5zDG6Y3Y8VK6bmZmpFCbpzGX/k0qqHKHqEBNz3IbdQUjYF4UPkeoWC+vtP
         2LX6rrl9KUhtkRZ98InH+CaYhqxvPlHlwbNHIbwDZRZdMI1w3ap1Y/A7Zk28knXp6bC9
         IrwA==
X-Gm-Message-State: AOAM531U0RedBNAwWxsInpbpGRvp4HqkIPbo0ErqJdTVQIpNlo73MraF
        Xv7bbEQIibY/1OZOcKz8YFf5yY6Dh6bYj8HX5qzWRLpsqyU2mluLd+4n7CXCuddC4nDao1PaP2J
        wooD1uL6viYlhgHInq2Q8/3CPDourKC41tmSpMKZX4nlZtduIbKcXxha0q8y0O4cfws696+LIOa
        pJdi5CfpklwK6xzcQo+kIoGEfwZubAfw==
X-Google-Smtp-Source: ABdhPJwEpqTUb9kPmIjnj51HJH4HQ/quySUNXehPyJyYxgu/hGUg9F+Y8YvDOKYmZuB0smwv5n+SXTeyz/eP
X-Received: by 2002:adf:ed06:: with SMTP id a6mr26334252wro.3.1630337208524;
        Mon, 30 Aug 2021 08:26:48 -0700 (PDT)
Received: from mta1.parkeon.com ([185.149.63.251])
        by smtp-relay.gmail.com with ESMTPS id c17sm616766wmk.41.2021.08.30.08.26.48
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Mon, 30 Aug 2021 08:26:48 -0700 (PDT)
X-Relaying-Domain: flowbird.group
Received: from [172.16.13.38] (port=37560 helo=PC12445-BES.dynamic.besancon.parkeon.com)
        by mta1.parkeon.com with esmtp (Exim 4.71)
        (envelope-from <martin.fuzzey@flowbird.group>)
        id 1mKjBQ-0005mz-4S; Mon, 30 Aug 2021 17:26:48 +0200
From:   Martin Fuzzey <martin.fuzzey@flowbird.group>
To:     linux-wireless@vger.kernel.org
Cc:     Amitkumar Karwar <amitkarwar@gmail.com>,
        Siva Rebbagondla <siva8118@gmail.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Prameela Rani Garnepudi <prameela.j04cs@gmail.com>,
        linux-kernel@vger.kernel.org,
        Martin Fuzzey <martin.fuzzey@flowbird.group>
Subject: [PATCH v2 1/3] rsi: fix occasional initialisation failure with BT coex
Date:   Mon, 30 Aug 2021 17:26:44 +0200
Message-Id: <1630337206-12410-2-git-send-email-martin.fuzzey@flowbird.group>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1630337206-12410-1-git-send-email-martin.fuzzey@flowbird.group>
References: <1630337206-12410-1-git-send-email-martin.fuzzey@flowbird.group>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

When BT coexistence is enabled (eg oper mode 13, which is the default)
the initialisation on startup sometimes silently fails.

In a normal initialisation we see
	usb 1-1.3: Product: Wireless USB Network Module
	usb 1-1.3: Manufacturer: Redpine Signals, Inc.
	usb 1-1.3: SerialNumber: 000000000001
	rsi_91x: rsi_probe: Initialized os intf ops
	rsi_91x: rsi_load_9116_firmware: Loading chunk 0
	rsi_91x: rsi_load_9116_firmware: Loading chunk 1
	rsi_91x: rsi_load_9116_firmware: Loading chunk 2
	rsi_91x: Max Stations Allowed = 1

But sometimes the last log is missing and the wlan net device is
not created.

Running a userspace loop that resets the hardware via a GPIO shows the
problem occurring ~5/100 resets.

The problem does not occur in oper mode 1 (wifi only).

Adding logs shows that the initialisation state machine requests a MAC
reset via rsi_send_reset_mac() but the firmware does not reply, leading
to the initialisation sequence being incomplete.

Fix this by delaying attaching the BT adapter until the wifi
initialisation has completed.

With this applied I have done > 300 reset loops with no errors.

Fixes: 716b840c7641 ("rsi: handle BT traffic in driver")
Signed-off-by: Martin Fuzzey <martin.fuzzey@flowbird.group>
CC: stable@vger.kernel.org
---
 drivers/net/wireless/rsi/rsi_91x_main.c | 16 +++++++++++++---
 drivers/net/wireless/rsi/rsi_91x_mgmt.c |  3 +++
 drivers/net/wireless/rsi/rsi_main.h     |  2 ++
 3 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/rsi/rsi_91x_main.c b/drivers/net/wireless/rsi/rsi_91x_main.c
index d984832..143224a 100644
--- a/drivers/net/wireless/rsi/rsi_91x_main.c
+++ b/drivers/net/wireless/rsi/rsi_91x_main.c
@@ -211,9 +211,10 @@ int rsi_read_pkt(struct rsi_common *common, u8 *rx_pkt, s32 rcv_pkt_len)
 			bt_pkt_type = frame_desc[offset + BT_RX_PKT_TYPE_OFST];
 			if (bt_pkt_type == BT_CARD_READY_IND) {
 				rsi_dbg(INFO_ZONE, "BT Card ready recvd\n");
-				if (rsi_bt_ops.attach(common, &g_proto_ops))
-					rsi_dbg(ERR_ZONE,
-						"Failed to attach BT module\n");
+				if (common->fsm_state == FSM_MAC_INIT_DONE)
+					rsi_attach_bt(common);
+				else
+					common->bt_defer_attach = true;
 			} else {
 				if (common->bt_adapter)
 					rsi_bt_ops.recv_pkt(common->bt_adapter,
@@ -278,6 +279,15 @@ void rsi_set_bt_context(void *priv, void *bt_context)
 }
 #endif
 
+void rsi_attach_bt(struct rsi_common *common)
+{
+#ifdef CONFIG_RSI_COEX
+	if (rsi_bt_ops.attach(common, &g_proto_ops))
+		rsi_dbg(ERR_ZONE,
+			"Failed to attach BT module\n");
+#endif
+}
+
 /**
  * rsi_91x_init() - This function initializes os interface operations.
  * @oper_mode: One of DEV_OPMODE_*.
diff --git a/drivers/net/wireless/rsi/rsi_91x_mgmt.c b/drivers/net/wireless/rsi/rsi_91x_mgmt.c
index 891fd5f..a25742a 100644
--- a/drivers/net/wireless/rsi/rsi_91x_mgmt.c
+++ b/drivers/net/wireless/rsi/rsi_91x_mgmt.c
@@ -2071,6 +2071,9 @@ static int rsi_handle_ta_confirm_type(struct rsi_common *common,
 				if (common->reinit_hw) {
 					complete(&common->wlan_init_completion);
 				} else {
+					if (common->bt_defer_attach)
+						rsi_attach_bt(common);
+
 					return rsi_mac80211_attach(common);
 				}
 			}
diff --git a/drivers/net/wireless/rsi/rsi_main.h b/drivers/net/wireless/rsi/rsi_main.h
index 0f53585..a3e4fd5 100644
--- a/drivers/net/wireless/rsi/rsi_main.h
+++ b/drivers/net/wireless/rsi/rsi_main.h
@@ -320,6 +320,7 @@ struct rsi_common {
 	struct ieee80211_vif *roc_vif;
 
 	bool eapol4_confirm;
+	bool bt_defer_attach;
 	void *bt_adapter;
 
 	struct cfg80211_scan_request *hwscan;
@@ -401,5 +402,6 @@ struct rsi_host_intf_ops {
 
 enum rsi_host_intf rsi_get_host_intf(void *priv);
 void rsi_set_bt_context(void *priv, void *bt_context);
+void rsi_attach_bt(struct rsi_common *common);
 
 #endif
-- 
1.9.1

