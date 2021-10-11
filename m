Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB174429880
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Oct 2021 22:55:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235089AbhJKU5P (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 11 Oct 2021 16:57:15 -0400
Received: from dispatch1-us1.ppe-hosted.com ([67.231.154.184]:46084 "EHLO
        dispatch1-us1.ppe-hosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235142AbhJKU4M (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 11 Oct 2021 16:56:12 -0400
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mx1-us1.ppe-hosted.com (unknown [10.110.50.11])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 1283E1A0073
        for <linux-wireless@vger.kernel.org>; Mon, 11 Oct 2021 20:54:10 +0000 (UTC)
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id DE32414006E
        for <linux-wireless@vger.kernel.org>; Mon, 11 Oct 2021 20:54:09 +0000 (UTC)
Received: from ben-dt4.candelatech.com (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        by mail3.candelatech.com (Postfix) with ESMTP id 74B8513C2B1;
        Mon, 11 Oct 2021 13:54:09 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 74B8513C2B1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1633985649;
        bh=4VHlRT0i3AHuPwgp6knvT1aWevlxz8o7Yp6iuexbJ7c=;
        h=From:To:Cc:Subject:Date:From;
        b=Z3qbXAmnnHjAEYBfZ1Ri2KqtWTege8Tx9+cgXI3uevT62Zmc1c422mOpA7HvG1SaP
         SN+z6cnn88C5mwJaBISOkk+xIs8freYWACv1aLGULT+vH6MxMxTMDIAlVGuZSR0DCU
         rIzh42MZjt22Q15wJvUAHwtFVRlWxTwApGEwdM1s=
From:   greearb@candelatech.com
To:     linux-wireless@vger.kernel.org
Cc:     Ben Greear <greearb@candelatech.com>
Subject: [PATCH] mt76: mt7915: add debugging for MCU command timeouts.
Date:   Mon, 11 Oct 2021 13:54:06 -0700
Message-Id: <20211011205406.23485-1-greearb@candelatech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MDID: 1633985650-aQIId4PmDtyZ
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ben Greear <greearb@candelatech.com>

Print information about whether the message is the first timeout,
and also print info if we manage to recover after a timeout.

Signed-off-by: Ben Greear <greearb@candelatech.com>
---

NOTE:  Not sure this is really something folks would want upstream, but
maybe it helps someone else trying to debug this driver.

 drivers/net/wireless/mediatek/mt76/mt76.h     |  2 ++
 .../net/wireless/mediatek/mt76/mt7915/mcu.c   | 35 +++++++++++++++++--
 2 files changed, 34 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 2e1a1004ed30..3b64d288c7c2 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -686,6 +686,8 @@ struct mt76_dev {
 	struct device *dev;
 
 	struct mt76_mcu mcu;
+	u32 first_failed_mcu_cmd; /* for debugging */
+	u32 last_successful_mcu_cmd; /* for debugging */
 
 	struct net_device napi_dev;
 	struct net_device tx_napi_dev;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index 51241b443cc5..e97cdeae785f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -323,14 +323,43 @@ mt7915_mcu_parse_response(struct mt76_dev *mdev, int cmd,
 	int ret = 0;
 
 	if (!skb) {
-		dev_err(mdev->dev, "Message %08x (seq %d) timeout\n",
-			cmd, seq);
+		const char* first = "Secondary";
+
+		if (!mdev->first_failed_mcu_cmd)
+			first = "Initial";
+
+		dev_err(mdev->dev, "MCU: %s Failure: Message %08x (cid %lx ext_cid: %lx seq %d) timeout.  Last successful cmd: 0x%x\n",
+			first,
+			cmd, FIELD_GET(__MCU_CMD_FIELD_ID, cmd),
+			FIELD_GET(__MCU_CMD_FIELD_EXT_ID, cmd), seq,
+			mdev->last_successful_mcu_cmd);
+
+		if (!mdev->first_failed_mcu_cmd)
+			mdev->first_failed_mcu_cmd = cmd;
 		return -ETIMEDOUT;
 	}
 
+	mdev->last_successful_mcu_cmd = cmd;
+
+	if (mdev->first_failed_mcu_cmd) {
+		dev_err(mdev->dev, "MCU: First success after failure: Message %08x (cid %lx ext_cid: %lx seq %d)\n",
+			cmd, FIELD_GET(__MCU_CMD_FIELD_ID, cmd),
+			FIELD_GET(__MCU_CMD_FIELD_EXT_ID, cmd), seq);
+		mdev->first_failed_mcu_cmd = 0;
+	}
+	else {
+		// verbose debugging
+		//dev_err(mdev->dev, "MCU: OK response to message %08x (cid %lx ext_cid: %lx seq %d)\n",
+		//	cmd, FIELD_GET(__MCU_CMD_FIELD_ID, cmd),
+		//	FIELD_GET(__MCU_CMD_FIELD_EXT_ID, cmd), seq);
+	}
+
 	rxd = (struct mt7915_mcu_rxd *)skb->data;
-	if (seq != rxd->seq)
+	if (seq != rxd->seq) {
+		dev_err(mdev->dev, "ERROR: MCU:  Sequence mismatch in response, seq: %d  rxd->seq: %d cmd: %0x\n",
+			seq, rxd->seq, cmd);
 		return -EAGAIN;
+	}
 
 	if (cmd == MCU_CMD(PATCH_SEM_CONTROL)) {
 		skb_pull(skb, sizeof(*rxd) - 4);
-- 
2.20.1

