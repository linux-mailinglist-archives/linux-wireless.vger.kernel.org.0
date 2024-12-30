Return-Path: <linux-wireless+bounces-16911-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6541B9FEA61
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Dec 2024 20:42:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB4653A2BEC
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Dec 2024 19:42:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B45F319ADBA;
	Mon, 30 Dec 2024 19:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="iVnNJdR9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36575198E7B
	for <linux-wireless@vger.kernel.org>; Mon, 30 Dec 2024 19:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735587733; cv=none; b=hULO1cekL3e44mf6slSOXwNv3Bpn8mrVLT+Wizvz9YGDy3wvW8/Bau2nAls9rc+arrLhQQs1Q/nf5FeqcStpwvxRxwHZZ/gvWCu7Ul1Aw5b3Bwxe6ggzxpvCV/1hIpRqLlEXcxt73Q0dM4lFTXHT8GiVV1eyGtN6rlpPin//oHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735587733; c=relaxed/simple;
	bh=vd9JiD/B3e8fjkfrC/RgEvOzdQUE6N2pK1Xmmc0sU1o=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oGbXbgNbz6KVbJoDdozC5laZhWNDlWjeNdXB4JKtTiFe0n85cpuS8OxRQTfXX463nPC+7n6JbAlLaxkWN3fph2F8M2vFInPAPoCTMu4j/SJdj7Ib2b9cZSYpr425vlM1hqx//ssXRI/stNuMJQVSGcbcTEVjqAElZgaPbHT1m30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=iVnNJdR9; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=P7dcwgYJvfEmpoDdeEwtA9iCJ7f8/wW3O7wo+gZKeZc=; b=iVnNJdR9uz4TB9X99jeGFJpG/H
	igqcmzCLqCVyCDSSig54CcVFDGNWfZeixZT+j7ngnBPWiLPOseQ58T23/Ef4sEz0zAR8XAXsqhZFp
	ERGXUvhpOK3VBLWXlesL3sRmXJJTLl9fiBtWcR/i/pfh2xlTyk/YJEeWPg77OV/Kfk38=;
Received: from p4ff13c5f.dip0.t-ipconnect.de ([79.241.60.95] helo=Maecks.lan)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1tSLeU-00GKzc-1N
	for linux-wireless@vger.kernel.org;
	Mon, 30 Dec 2024 20:42:10 +0100
From: Felix Fietkau <nbd@nbd.name>
To: linux-wireless@vger.kernel.org
Subject: [PATCH 07/14] wifi: mt76: mt7915: decrease timeout for commonly issued MCU commands
Date: Mon, 30 Dec 2024 20:41:55 +0100
Message-ID: <20241230194202.95065-7-nbd@nbd.name>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241230194202.95065-1-nbd@nbd.name>
References: <20241230194202.95065-1-nbd@nbd.name>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This allows faster recovery from firmware issues

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 .../net/wireless/mediatek/mt76/mt7915/mcu.c   | 21 +++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index 6efa1c95e953..7115394f6bd6 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -194,6 +194,25 @@ mt7915_mcu_parse_response(struct mt76_dev *mdev, int cmd,
 	return ret;
 }
 
+static void
+mt7915_mcu_set_timeout(struct mt76_dev *mdev, int cmd)
+{
+	if ((cmd & __MCU_CMD_FIELD_ID) != MCU_CMD_EXT_CID)
+		return;
+
+	switch (FIELD_GET(__MCU_CMD_FIELD_EXT_ID, cmd)) {
+	case MCU_EXT_CMD_THERMAL_CTRL:
+	case MCU_EXT_CMD_GET_MIB_INFO:
+	case MCU_EXT_CMD_PHY_STAT_INFO:
+	case MCU_EXT_CMD_STA_REC_UPDATE:
+	case MCU_EXT_CMD_BSS_INFO_UPDATE:
+		mdev->mcu.timeout = 2 * HZ;
+		return;
+	default:
+		break;
+	}
+}
+
 static int
 mt7915_mcu_send_message(struct mt76_dev *mdev, struct sk_buff *skb,
 			int cmd, int *wait_seq)
@@ -208,6 +227,8 @@ mt7915_mcu_send_message(struct mt76_dev *mdev, struct sk_buff *skb,
 	else
 		qid = MT_MCUQ_WM;
 
+	mt7915_mcu_set_timeout(mdev, cmd);
+
 	return mt76_tx_queue_skb_raw(dev, mdev->q_mcu[qid], skb, 0);
 }
 
-- 
2.47.1


