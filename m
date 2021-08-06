Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A27EC3E287B
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Aug 2021 12:23:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245018AbhHFKXu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 6 Aug 2021 06:23:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244954AbhHFKXq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 6 Aug 2021 06:23:46 -0400
Received: from mail-wr1-x464.google.com (mail-wr1-x464.google.com [IPv6:2a00:1450:4864:20::464])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20899C06179B
        for <linux-wireless@vger.kernel.org>; Fri,  6 Aug 2021 03:23:27 -0700 (PDT)
Received: by mail-wr1-x464.google.com with SMTP id d8so10420335wrm.4
        for <linux-wireless@vger.kernel.org>; Fri, 06 Aug 2021 03:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flowbird.group; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qphV1UcRjge2f2QoEepAIJxuHV1jIZ3jSQsxy+knXZI=;
        b=ujfmDI2AAQF+MurXTHnpo8P27V1ad3GsXKIziWkct345KS2TZTsy/si3spwPOw99H/
         /W4pmjid9yhJuYH01O9I22vUGtTGOonlos5vfzHrmSUjtCWeMziE+paiLEDkv2QSJDkl
         YYwVtYrIsxtS5RiWNl1WY/VlXrqHFk76G6SO2Cse/ckpnfK5pcirXIv4SoUktPO1xenM
         wAfddU8kFPOhfhlvvdfAmXcPuapeRen5Ahb5wi20G/P9JZp4hBC3J9lB9R2ws4lofBy5
         EbxM0EUxAFLGK+sfipmX6F17QS2xALQNwt/ElNbpLn69GlC/yW4S+lE2mpnKiDh/56W1
         vJ8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qphV1UcRjge2f2QoEepAIJxuHV1jIZ3jSQsxy+knXZI=;
        b=Ttw8isnlWD5GERLlFs/f7BndFMEvNxvp0Ca3SsTahehkSmCcp4wzyTkRaowDU7c5A/
         JrNhK8aFZzpsm2vLLwXFQ4ux7cuUBK7giHKHOCxVZr0VQHULy5r5Wau4Nsc9bGO2X9Z3
         yLDg9LRbDamZRtlO7zMaodyhSOzYzMV4IwvkoU3NO3pk1ZOxNU9XXXDe1NpazVALedd3
         RDjXRSORWCM0/yKNemnBWooLMkX7TIGfPE1oV/e8hlGJ80vpGY8Q2agnG7pguPQee0n3
         pYBGVuW/2oKXsMAysioHH8rwuRm/oRKk5moXleObKklJ6YsBKHP/KXrFfJ9XRs9tTs8v
         J1Qg==
X-Gm-Message-State: AOAM531RTyuj/LtqbBU/+QjdDeY6EvtZBhDtQ1RIQQWizcT0d+tbAr3J
        +IYCrBceA05gJvJ+UOaJChJ+ODzlSYhfPfzGj2vvL0UnvQ1olAQ3W/qKd7w074owvUT4ufT7nvD
        bOuh2IUM8Jx0mjV92VSe9854uoP0jH0eNy3OCMYzeeS8a+6XffQ3upPXWuc28QJynh45AKEleG3
        2oKKV7vhvQuD0RTwl6rO1ViWhoCH7eIA==
X-Google-Smtp-Source: ABdhPJyF93LVLizAR3yDMuYiFK8gpPsMnZgLNQ0LXZr08VSCOKJo1OIj2kfK+jcjsA4FKVpdqH9AGs4IBB20
X-Received: by 2002:a05:6000:2c6:: with SMTP id o6mr9924660wry.241.1628245405557;
        Fri, 06 Aug 2021 03:23:25 -0700 (PDT)
Received: from mta1.parkeon.com ([185.149.63.251])
        by smtp-relay.gmail.com with ESMTPS id u11sm309269wrg.5.2021.08.06.03.23.25
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Fri, 06 Aug 2021 03:23:25 -0700 (PDT)
X-Relaying-Domain: flowbird.group
Received: from [172.16.12.14] (port=47598 helo=PC12445-BES.dynamic.besancon.parkeon.com)
        by mta1.parkeon.com with esmtp (Exim 4.71)
        (envelope-from <martin.fuzzey@flowbird.group>)
        id 1mBx0f-0006b1-3G; Fri, 06 Aug 2021 12:23:25 +0200
From:   Martin Fuzzey <martin.fuzzey@flowbird.group>
To:     linux-wireless@vger.kernel.org
Cc:     Amitkumar Karwar <amitkarwar@gmail.com>,
        Siva Rebbagondla <siva8118@gmail.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Prameela Rani Garnepudi <prameela.j04cs@gmail.com>,
        linux-kernel@vger.kernel.org,
        Martin Fuzzey <martin.fuzzey@flowbird.group>
Subject: [PATCH 1/3] rsi: fix occasional initialisation failure with BT coex
Date:   Fri,  6 Aug 2021 12:23:21 +0200
Message-Id: <1628245403-2517-2-git-send-email-martin.fuzzey@flowbird.group>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1628245403-2517-1-git-send-email-martin.fuzzey@flowbird.group>
References: <1628245403-2517-1-git-send-email-martin.fuzzey@flowbird.group>
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
 drivers/net/wireless/rsi/rsi_main.h     |  3 ++-
 3 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/rsi/rsi_91x_main.c b/drivers/net/wireless/rsi/rsi_91x_main.c
index 29d8304..aece1d3 100644
--- a/drivers/net/wireless/rsi/rsi_91x_main.c
+++ b/drivers/net/wireless/rsi/rsi_91x_main.c
@@ -210,9 +210,10 @@ int rsi_read_pkt(struct rsi_common *common, u8 *rx_pkt, s32 rcv_pkt_len)
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
@@ -277,6 +278,15 @@ void rsi_set_bt_context(void *priv, void *bt_context)
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
  * @void: Void.
diff --git a/drivers/net/wireless/rsi/rsi_91x_mgmt.c b/drivers/net/wireless/rsi/rsi_91x_mgmt.c
index ed67f65..50c4b9b 100644
--- a/drivers/net/wireless/rsi/rsi_91x_mgmt.c
+++ b/drivers/net/wireless/rsi/rsi_91x_mgmt.c
@@ -2056,6 +2056,9 @@ static int rsi_handle_ta_confirm_type(struct rsi_common *common,
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
index b3e25bc..b983cc5 100644
--- a/drivers/net/wireless/rsi/rsi_main.h
+++ b/drivers/net/wireless/rsi/rsi_main.h
@@ -320,6 +320,7 @@ struct rsi_common {
 	struct ieee80211_vif *roc_vif;
 
 	bool eapol4_confirm;
+	bool bt_defer_attach;
 	void *bt_adapter;
 
 	struct cfg80211_scan_request *hwscan;
@@ -401,5 +402,5 @@ struct rsi_host_intf_ops {
 
 enum rsi_host_intf rsi_get_host_intf(void *priv);
 void rsi_set_bt_context(void *priv, void *bt_context);
-
+void rsi_attach_bt(struct rsi_common *common);
 #endif
-- 
1.9.1

