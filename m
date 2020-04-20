Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38C381B08A1
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2020 13:59:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727000AbgDTL64 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 20 Apr 2020 07:58:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:43946 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726451AbgDTL6z (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 20 Apr 2020 07:58:55 -0400
Received: from localhost.localdomain.com (unknown [151.48.159.126])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E7AF22072B;
        Mon, 20 Apr 2020 11:58:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587383935;
        bh=vr296BXTacwYCW7+S+TQrYUYxiozu97XI9e3sys14XY=;
        h=From:To:Cc:Subject:Date:From;
        b=Za8/hECa0PmiHeZTX4RPJ1kGonEEJ1JJcZmYV0j6L8LdpPk9Qg3BNdlDtFH9bstIT
         Xcd3t7xy/XVeR7gvt2EyjiFb8qZReZUNKFq/80pIvnYy6l7YL8nGY4Sg0QzWfXgL2L
         VUV0ye/c2IsgK6maKLpOgkRHIxLYoGLGMKP58grs=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com, linux-mediatek@lists.infradead.org
Subject: [PATCH] mt76: mt7615: parse mcu return code for unified commands
Date:   Mon, 20 Apr 2020 13:58:44 +0200
Message-Id: <73930f50680e6c5fb54a9eacf07003a4e22f2570.1587383612.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.25.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add return code parsing for the following unified commands:
- MCU_UNI_CMD_DEV_INFO_UPDATE
- MCU_UNI_CMD_BSS_INFO_UPDATE
- MCU_UNI_CMD_STA_REC_UPDATE

Co-developed-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7615/mcu.c | 10 ++++++++++
 drivers/net/wireless/mediatek/mt76/mt7615/mcu.h |  6 ++++++
 2 files changed, 16 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
index 703b6996a3d8..d448bbeba1c1 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -187,6 +187,16 @@ mt7615_mcu_parse_response(struct mt7615_dev *dev, int cmd,
 		skb_pull(skb, sizeof(*rxd));
 		ret = le32_to_cpu(*(__le32 *)skb->data);
 		break;
+	case MCU_UNI_CMD_DEV_INFO_UPDATE:
+	case MCU_UNI_CMD_BSS_INFO_UPDATE:
+	case MCU_UNI_CMD_STA_REC_UPDATE: {
+		struct mt7615_mcu_uni_event *event;
+
+		skb_pull(skb, sizeof(*rxd));
+		event = (struct mt7615_mcu_uni_event *)skb->data;
+		ret = le32_to_cpu(event->status);
+		break;
+	}
 	default:
 		break;
 	}
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.h b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.h
index 5440f24a834a..032b5f98608e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.h
@@ -282,6 +282,12 @@ enum {
 	MCU_UNI_CMD_STA_REC_UPDATE = MCU_UNI_PREFIX | 0x03,
 };
 
+struct mt7615_mcu_uni_event {
+	u8 cid;
+	u8 pad[3];
+	__le32 status; /* 0: success, others: fail */
+} __packed;
+
 struct mt7615_mcu_scan_ssid {
 	__le32 ssid_len;
 	u8 ssid[IEEE80211_MAX_SSID_LEN];
-- 
2.25.3

