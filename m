Return-Path: <linux-wireless+bounces-27296-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 178F8B57214
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Sep 2025 09:59:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA1B817BA1B
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Sep 2025 07:59:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B4D12EA147;
	Mon, 15 Sep 2025 07:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="ogS3/4fo"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A355C2E92D1
	for <linux-wireless@vger.kernel.org>; Mon, 15 Sep 2025 07:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757923161; cv=none; b=FDdulOJK/VbJr52ai7+sQs/zyByjsWtphr+2E65XOukWN8ero+Y4NRtrGD3zGvSHcWjItTNb4hlghNHR4xhNHqZ046s4lNxGobthNDYGSBfoU7CNwYGtKvuhIopv/d/my2oD9mN+NDGME9/hR14P+4VIKeYW+NDhxK0hN6yJxyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757923161; c=relaxed/simple;
	bh=gFFKxbVC93qHMrdETfv0xGm/epqLleLHf/XZiCSJODA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U8qvhBVdbkS8uLn4SFrwxR7ByFPXnkax7y6wij6hSI/PvsASRdGL+49Iu0MZqfFzYSgr3NwWQBJJpByVscZcu74wTzP5r8YgveNRzftzq1iatpI8dl6a98Sh18coRH9kwZty5/Eh8Lq56cZcECB8ng8cwFPrPH45Oqd24I1TDEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=ogS3/4fo; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=ms1Xmu1XrttBTHSIyWHoV0h0dKbcUWcT5McBKDgEue0=; b=ogS3/4fo6eKFz6rG4O8tgol6W4
	+k9lvnrSE7SBwI+n9aB/niK6vyoJKFtqhmG7liaK8oT5FmBYxvJ4gb6Og7UMuDu2lzDaKL/pPq5Fv
	lRmt9dhAJqlL11QoZ5dLKgmReDERLzCJrWwSMGWOGuKM5/huRK0FwcGAHujB+09Gwwl4=;
Received: from p5b206816.dip0.t-ipconnect.de ([91.32.104.22] helo=Maecks.lan)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1uy47D-0078GN-1R
	for linux-wireless@vger.kernel.org;
	Mon, 15 Sep 2025 09:59:11 +0200
From: Felix Fietkau <nbd@nbd.name>
To: linux-wireless@vger.kernel.org
Subject: [PATCH mt76 03/15] wifi: mt76: mt7996: decrease timeout for commonly issued MCU commands
Date: Mon, 15 Sep 2025 09:58:58 +0200
Message-ID: <20250915075910.47558-3-nbd@nbd.name>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250915075910.47558-1-nbd@nbd.name>
References: <20250915075910.47558-1-nbd@nbd.name>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This allows faster recovery from firmware issues.
Based on patch by Chad Monroe and ported from mt7915.

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 .../net/wireless/mediatek/mt76/mt7996/mcu.c   | 26 ++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
index 1c89d235026d..29552ab16089 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
@@ -242,6 +242,30 @@ mt7996_mcu_parse_response(struct mt76_dev *mdev, int cmd,
 	return ret;
 }
 
+static void
+mt7996_mcu_set_timeout(struct mt76_dev *mdev, int cmd)
+{
+	mdev->mcu.timeout = 5 * HZ;
+
+	if (!(cmd & __MCU_CMD_FIELD_UNI))
+		return;
+
+	switch (FIELD_GET(__MCU_CMD_FIELD_ID, cmd)) {
+	case MCU_UNI_CMD_THERMAL:
+	case MCU_UNI_CMD_TWT:
+	case MCU_UNI_CMD_GET_MIB_INFO:
+	case MCU_UNI_CMD_STA_REC_UPDATE:
+	case MCU_UNI_CMD_BSS_INFO_UPDATE:
+		mdev->mcu.timeout = 2 * HZ;
+		return;
+	case MCU_UNI_CMD_EFUSE_CTRL:
+		mdev->mcu.timeout = 20 * HZ;
+		return;
+	default:
+		break;
+	}
+}
+
 static int
 mt7996_mcu_send_message(struct mt76_dev *mdev, struct sk_buff *skb,
 			int cmd, int *wait_seq)
@@ -255,7 +279,7 @@ mt7996_mcu_send_message(struct mt76_dev *mdev, struct sk_buff *skb,
 	u32 val;
 	u8 seq;
 
-	mdev->mcu.timeout = 20 * HZ;
+	mt7996_mcu_set_timeout(mdev, cmd);
 
 	seq = ++dev->mt76.mcu.msg_seq & 0xf;
 	if (!seq)
-- 
2.51.0


