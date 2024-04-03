Return-Path: <linux-wireless+bounces-5800-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BE4B896D4E
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Apr 2024 12:53:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C8D91F2C56D
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Apr 2024 10:53:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F66F13A245;
	Wed,  3 Apr 2024 10:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="QTUdVgdm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CE0B136989
	for <linux-wireless@vger.kernel.org>; Wed,  3 Apr 2024 10:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712141578; cv=none; b=BWhLD6j9QlfKMr8hlqo08iiKNrYT9ddNDB5/3rm8CWUZzoON9faoCpvVRjLnd/FmXGYrtyQcPKSPEdjnQRY8pY+9LSW2M71c/eX8w+I3rHcr4n9sJxVkCivu9SXvyHtULjfKs8x0U2vTcZE4rWKRuv3zBtIWw25Yq15HQjlJ4/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712141578; c=relaxed/simple;
	bh=NmZfMWWiAiW7lkg0ljsyNcUyTJWYaciOvsYO0qRt6j4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fz4e1CWNffcWFBFBrfU+LFcGX10JAVD57oa3jLlzvBfhWZA4PFJuoqci1zeXnISHaPzY/KyJv2yCNVn5kR9JXobH+4Fzgv1dLqIClOPLrUjdwjA2wAWS817I3Yea9gLzn8fCs6JZPJ5P6jNqzLcEAt1sSVIJOUNpBJkz3I2udsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=QTUdVgdm; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=aGJ0TLncanEet7ffoqEAYZmRD569y9Qq5VdyPo9myiY=; b=QTUdVgdmoGjrupBttTqEN0Dnvi
	TfktjktilgGkE4QVb6cN+lJPf+Ou+8rxXnhdgOGqVuTnGVuVskHJbaiRzF+EdFnjP0hBgVvZg6oRH
	Kp5v9c9d5utn+dlyVNVye3xnF1mlOhRGv0JE3TX6pnPGIXBOo1F2buzCGsVBUpRxq7po=;
Received: from p54ae9c93.dip0.t-ipconnect.de ([84.174.156.147] helo=localhost.localdomain)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
	(Exim 4.94.2)
	(envelope-from <nbd@nbd.name>)
	id 1rrxt3-00CgfA-At
	for linux-wireless@vger.kernel.org; Wed, 03 Apr 2024 12:30:33 +0200
From: Felix Fietkau <nbd@nbd.name>
To: linux-wireless@vger.kernel.org
Subject: [PATCH 04/13] wifi: mt76: mt7915: fix mcu command format for mt7915 tx stats
Date: Wed,  3 Apr 2024 12:30:23 +0200
Message-ID: <20240403103032.54823-4-nbd@nbd.name>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240403103032.54823-1-nbd@nbd.name>
References: <20240403103032.54823-1-nbd@nbd.name>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Peter Chiu <chui-hao.chiu@mediatek.com>

The mcu command format are different for mt7915 and mt7986.
Fix the mt7915_mcu_wed_wa_tx_stats to support mt7915 and mt7986.

Signed-off-by: Peter Chiu <chui-hao.chiu@mediatek.com>
Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 .../net/wireless/mediatek/mt76/mt7915/mcu.c   | 36 ++++++++++++-------
 1 file changed, 24 insertions(+), 12 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index b7157bdb3103..11f81b233d46 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -3801,30 +3801,38 @@ int mt7915_mcu_wed_wa_tx_stats(struct mt7915_dev *dev, u16 wlan_idx)
 {
 	struct {
 		__le32 cmd;
-		__le32 num;
-		__le32 __rsv;
-		__le16 wlan_idx;
-	} req = {
+		__le32 arg0;
+		__le32 arg1;
+		__le16 arg2;
+	} __packed req = {
 		.cmd = cpu_to_le32(0x15),
-		.num = cpu_to_le32(1),
-		.wlan_idx = cpu_to_le16(wlan_idx),
 	};
 	struct mt7915_mcu_wa_tx_stat {
-		__le16 wlan_idx;
-		u8 __rsv[2];
+		__le16 wcid;
+		u8 __rsv2[2];
 
 		/* tx_bytes is deprecated since WA byte counter uses u32,
 		 * which easily leads to overflow.
 		 */
 		__le32 tx_bytes;
 		__le32 tx_packets;
-	} *res;
+	} __packed *res;
 	struct mt76_wcid *wcid;
 	struct sk_buff *skb;
-	int ret;
+	int ret, len;
+	u16 ret_wcid;
+
+	if (is_mt7915(&dev->mt76)) {
+		req.arg0 = cpu_to_le32(wlan_idx);
+		len = sizeof(req) - sizeof(req.arg2);
+	} else {
+		req.arg0 = cpu_to_le32(1);
+		req.arg2 = cpu_to_le16(wlan_idx);
+		len = sizeof(req);
+	}
 
 	ret = mt76_mcu_send_and_get_msg(&dev->mt76, MCU_WA_PARAM_CMD(QUERY),
-					&req, sizeof(req), true, &skb);
+					&req, len, true, &skb);
 	if (ret)
 		return ret;
 
@@ -3833,7 +3841,11 @@ int mt7915_mcu_wed_wa_tx_stats(struct mt7915_dev *dev, u16 wlan_idx)
 
 	res = (struct mt7915_mcu_wa_tx_stat *)skb->data;
 
-	if (le16_to_cpu(res->wlan_idx) != wlan_idx) {
+	ret_wcid = le16_to_cpu(res->wcid);
+	if (is_mt7915(&dev->mt76))
+		ret_wcid &= 0xff;
+
+	if (ret_wcid != wlan_idx) {
 		ret = -EINVAL;
 		goto out;
 	}
-- 
2.43.0


