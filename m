Return-Path: <linux-wireless+bounces-4471-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F22FB87572A
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Mar 2024 20:30:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 39C25B21D9C
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Mar 2024 19:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CC4A1369A6;
	Thu,  7 Mar 2024 19:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="WkwWvxhE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF6531369A4
	for <linux-wireless@vger.kernel.org>; Thu,  7 Mar 2024 19:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.154.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709839808; cv=none; b=BHflqogCYk2MKoSDRsrn1OKJwDp1/hleuJ7iKnR2syXQvlJtewlcBqw4k++qQKwjpJx2BS0vjnX2cD7idtHlAck+InEQNipkuwhNQ/9hOHgUmkjvgQKZTRt/DKQTumURBNrcIfOio5JzmW3TSYighYELdO3c++tqvAJT70Ii1/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709839808; c=relaxed/simple;
	bh=PxmoAJnoMO8QQY9kPszditvML+bPeaKTD4C00Ht/1Rk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Fpms6xsjUxnmeLynnt+CoayG+UqQTqouY7tnrtYp4HEkOTc/NyBN98N+Km5x7eyduHCmLxafvXUgzJTDEVhIEFnpo2jUqM/e1rwoO4Lla91oUs0gnVhDnJL+h8EUOHmCRNO1kYdwBQvk5bVqJnSzP5l4A93P8ChQZ4kuD0H3YDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=WkwWvxhE; arc=none smtp.client-ip=67.231.154.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id E49128007D
	for <linux-wireless@vger.kernel.org>; Thu,  7 Mar 2024 19:29:58 +0000 (UTC)
Received: from ben-dt5.candelatech.com (unknown [50.251.239.81])
	by mail3.candelatech.com (Postfix) with ESMTP id 63B6E13C2B0;
	Thu,  7 Mar 2024 11:29:58 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 63B6E13C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1709839798;
	bh=PxmoAJnoMO8QQY9kPszditvML+bPeaKTD4C00Ht/1Rk=;
	h=From:To:Cc:Subject:Date:From;
	b=WkwWvxhEvfWznD5nqVILPb6EzG8FHhcMQDRWVnRJmlcljsOmS46xxEmplE52oAoNm
	 rdYDAFgmM2NxMYNBwst2C9b9zBx8OGIZgg2ZFuI0xZfX90qSP5wmDXyvzC2nUk4cYU
	 gIxAJHAdJ+dHh80yP98DBkrPk9iNQdWidSdYWQ5o=
From: greearb@candelatech.com
To: linux-wireless@vger.kernel.org
Cc: Ben Greear <greearb@candelatech.com>
Subject: [PATCH 1/6] wifi: mt76: mt7996:  add debugging for MCU command timeouts.
Date: Thu,  7 Mar 2024 11:29:46 -0800
Message-ID: <20240307192951.3271156-1-greearb@candelatech.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MDID: 1709839799-I5RMuBD_6oGZ
X-MDID-O:
 us5;at1;1709839799;I5RMuBD_6oGZ;<greearb@candelatech.com>;f7146c1849a4b08a52804beb1c1cdf45

From: Ben Greear <greearb@candelatech.com>

Print information about whether the message is the first timeout,
and also print info if we manage to recover after a timeout.

Signed-off-by: Ben Greear <greearb@candelatech.com>
---
 drivers/net/wireless/mediatek/mt76/mt76.h     |  2 ++
 .../net/wireless/mediatek/mt76/mt7996/mcu.c   | 31 +++++++++++++++++--
 2 files changed, 30 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index b20c34d5a0f7..c341915e4d62 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -829,6 +829,8 @@ struct mt76_dev {
 	struct device *dma_dev;
 
 	struct mt76_mcu mcu;
+	u32 first_failed_mcu_cmd; /* for debugging */
+	u32 last_successful_mcu_cmd; /* for debugging */
 
 	struct net_device napi_dev;
 	struct net_device tx_napi_dev;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
index 699be57309c2..a858a0914bf0 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
@@ -200,14 +200,39 @@ mt7996_mcu_parse_response(struct mt76_dev *mdev, int cmd,
 	int ret = 0;
 
 	if (!skb) {
-		dev_err(mdev->dev, "Message %08x (seq %d) timeout\n",
-			cmd, seq);
+		const char *first = "Secondary";
+
+		if (!mdev->first_failed_mcu_cmd)
+			first = "Initial";
+
+		dev_err(mdev->dev,
+			"MCU: %s Failure: Message %08x (cid %lx ext_cid: %lx seq %d) timeout.  Last successful cmd: 0x%x\n",
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
+
 	rxd = (struct mt7996_mcu_rxd *)skb->data;
-	if (seq != rxd->seq)
+	if (seq != rxd->seq) {
+		/* This can happen if the previous request didn't wait (which is normal).
+		 * Quietly return EAGAIN in that case, it is not something to warn about.
+		 */
 		return -EAGAIN;
+	}
 
 	if (cmd == MCU_CMD(PATCH_SEM_CONTROL)) {
 		skb_pull(skb, sizeof(*rxd) - 4);
-- 
2.42.0


