Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 02DD8116196
	for <lists+linux-wireless@lfdr.de>; Sun,  8 Dec 2019 14:15:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726378AbfLHNIL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 8 Dec 2019 08:08:11 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:45521 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726236AbfLHNIL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 8 Dec 2019 08:08:11 -0500
Received: by mail-oi1-f195.google.com with SMTP id v10so3954999oiv.12
        for <linux-wireless@vger.kernel.org>; Sun, 08 Dec 2019 05:08:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=lC7P0FBJUGF4bNXci3S3/nn4wlfzs4fsmux0mqMbvpc=;
        b=HC2fgWfv2ONMCP/Y7rFjejl9JP1KC7FS0nnD5kxpmTnOLwBAbZJmxqBzv5Q1hAzKIq
         eU3BKNeIk+g4EescBAYonL7hruC/Owku8OBxFvJRCgx1+S+U/WFyTLAVYNmOfu5nWYdc
         7wvLpNNf1PYXH0v3ayW2ybdzN2WwSkdK63udAXN6P59DCwgT4s9UG/AZsLVBfl+MYtWO
         KrQfVJQtAMBg6A01nrvTAgBpgGN4CSai3nobQ4mP8sjH88/fayTcHwQDjok/NFCN+P0N
         tl1BpzV/+8h+YyNeTVAnlLs8D4yOrzV2HeoTUA1MqIhrIR/qRKv5FTq66LXqIXLzVO2A
         ib2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=lC7P0FBJUGF4bNXci3S3/nn4wlfzs4fsmux0mqMbvpc=;
        b=m/D14ZdC6sH1PIhkX2k/dT2Yyxb7QYEGKoWJXXO92YBtIom9iAzRSDa9xmkv7F84Fn
         suij7T7H/IfDTVktpGc0/ngdJSlNqniSZ8VvRn2kw93gejaYFUNYmOrsd7cWhm0bWr1w
         TFociOPy3++MN6nrJxWBDuMLsWC4F6R7iPl3jO3Zv/YfpXfGh+nCiM/OFcSEgSIvWSr7
         N0kmf18Zalpp79set17tn3BINYe8iMYle+51Hd1jKc1mZ+msCtGYZgllGJ7+PYViez11
         zvdpMH1wwl+Oh3zCsoV/JqA0dLCf1NkzATkd97+jkPPIo2L7YER6817ygPm6xK/sJf+t
         2PEw==
X-Gm-Message-State: APjAAAWj1ID2CmN2FzQp4/fCd0WKWiXJHRQcNk7UpTvaGcp+VaM7YaXE
        zkgivd3FgzUaSKX4nX4oHqg=
X-Google-Smtp-Source: APXvYqyyVePm4fjoITID/i7PtkFqmuWOI3wu1KNmWm2C3dh+dgAabgg2UFq7FTYvCdIR83Mj9ggmOg==
X-Received: by 2002:aca:f305:: with SMTP id r5mr21138513oih.174.1575810490482;
        Sun, 08 Dec 2019 05:08:10 -0800 (PST)
Received: from hari-Latitude-E6430.utdallas.edu (cpe-76-184-237-208.tx.res.rr.com. [76.184.237.208])
        by smtp.gmail.com with ESMTPSA id w12sm7030004otk.75.2019.12.08.05.08.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Dec 2019 05:08:09 -0800 (PST)
From:   Hari Nagalla <hnagalla@gmail.com>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, maitalm@ti.com, hnagalla@gmail.com
Subject: [[PATCH mac80211] 1/1] ieee80211: mesh: handle secured PREQ frames
Date:   Sun,  8 Dec 2019 07:07:49 -0600
Message-Id: <20191208130750.5402-1-hnagalla@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Maital Hahn <maitalm@ti.com>

Add handling of encrypted broadcast action frames (Group addressed privacy)
Up until now all broadcast action frames and management were not encrypted.

When we send Mesh path selection action frames we need to send a broadcast
action frame which is encrypted.

Change applied to tx.c file adding a case where we handle these specific cases
which are defined in the spec in Table 8-38 Category values (Group addressed privacy)

Code: 13 - Mesh
Code: 14 - Multihop

Signed-off-by: Chen Loewy <c-loewy@ti.com>
Signed-off-by: Maital Hahn <maitalm@ti.com>
Signed-off-by: Hari Nagalla <hnagalla@gmail.com>
---
 include/linux/ieee80211.h | 19 +++++++++++++++++++
 net/mac80211/tx.c         | 13 ++++++++++---
 2 files changed, 29 insertions(+), 3 deletions(-)

diff --git a/include/linux/ieee80211.h b/include/linux/ieee80211.h
index c83478271c2e..6c84af4f7171 100644
--- a/include/linux/ieee80211.h
+++ b/include/linux/ieee80211.h
@@ -3025,6 +3025,25 @@ static inline bool ieee80211_is_robust_mgmt_frame(struct sk_buff *skb)
 	return _ieee80211_is_robust_mgmt_frame((void *)skb->data);
 }
 
+static inline bool ieee80211_is_not_group_privacy(struct ieee80211_hdr *hdr)
+{
+	if (ieee80211_is_action(hdr->frame_control)) {
+		u8 *category;
+
+		/*
+		 * Action frames, excluding Public Action frames, are Robust
+		 * Management Frames. However, if we are looking at a Protected
+		 * frame, skip the check since the data may be encrypted and
+		 * the frame has already been found to be a Robust Management
+		 * Frame (by the other end).
+		 */
+		category = ((u8 *)hdr) + 24;
+		return *category != WLAN_CATEGORY_MESH_ACTION &&
+			*category != WLAN_CATEGORY_MULTIHOP_ACTION;
+	}
+
+	return true;
+}
 /**
  * ieee80211_is_public_action - check if frame is a public action frame
  * @hdr: the frame
diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index 2f726cde9998..ed8f561142a3 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -468,12 +468,19 @@ ieee80211_tx_h_multicast_ps_buf(struct ieee80211_tx_data *tx)
 static int ieee80211_use_mfp(__le16 fc, struct sta_info *sta,
 			     struct sk_buff *skb)
 {
-	if (!ieee80211_is_mgmt(fc))
-		return 0;
 
-	if (sta == NULL || !test_sta_flag(sta, WLAN_STA_MFP))
+	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)skb->data;
+
+	if (!ieee80211_is_mgmt(fc))
 		return 0;
 
+	if (is_multicast_ether_addr(hdr->addr1)) {
+		if (!ieee80211_is_not_group_privacy(hdr))
+			return 1;
+	} else {
+		if (sta == NULL || !test_sta_flag(sta, WLAN_STA_MFP))
+			return 0;
+	}
 	if (!ieee80211_is_robust_mgmt_frame(skb))
 		return 0;
 
-- 
2.17.1

