Return-Path: <linux-wireless+bounces-2215-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26648832078
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jan 2024 21:24:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D345728290F
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jan 2024 20:24:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFD5D2E652;
	Thu, 18 Jan 2024 20:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="cfMVRYQo"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D0592E650
	for <linux-wireless@vger.kernel.org>; Thu, 18 Jan 2024 20:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705609470; cv=none; b=GAYcfCvWWqneaneoyAGu/s3D179R8eTPoN5j047enCJR16LrCpfDzuLXJlivJOkSMSUdvFqBLg+Aq8Mra6u6LfdPFVszMm35vrIdm3IWyIsu0axIMRLeUGDqSi5zSYx3PmEsMv7R7pJZYDVB88WSh7Z1JWQdw7UQPm+vcs0gODo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705609470; c=relaxed/simple;
	bh=o/GY+3kLDIGwB7enL0iyA1BkpUidxFI98NcIW3WkRrk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NvBBkh8cSh5H6gxzOGWeXF3zVdvlPg+C7kgwzc9nBsKpAnzvQoTJiTyw3LpNfzyf8lNy7z66Gx4cJ69yOnutvH1J7dxfak8SIMfzuT8jVHjMOEpJm8qxOWbIv2HV3XMS3ilnszqST1tE4mjFb9Ei/Kt06lahj3Ng72xEd+I4Q40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=cfMVRYQo; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=O5pFZlFuGXTjnRDTH6yNouSKV4frCuDHNN0xl6h5Vl8=; b=cfMVRYQofz7cbIUJgwBbxZf6Su
	GVNgYlVjycq32ApKdyMNfORyoS6m4L2pw5PKq17z5Uh9RIrwsaCImDJFYVmbO42z2rDHrVVYYFFcV
	KniWznl9uqKw83EKdYSnyrrOhhJ0nmLdV1bBK24OMKVeIz8gsrdeg2fd+15GgXsnr/FI=;
Received: from p200300daa7090900680536e7cb8d8cd3.dip0.t-ipconnect.de ([2003:da:a709:900:6805:36e7:cb8d:8cd3] helo=Maecks.lan)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
	(Exim 4.94.2)
	(envelope-from <nbd@nbd.name>)
	id 1rQYQz-0054tJ-14
	for linux-wireless@vger.kernel.org; Thu, 18 Jan 2024 20:52:17 +0100
From: Felix Fietkau <nbd@nbd.name>
To: linux-wireless@vger.kernel.org
Subject: [PATCH 3/5] wifi: mt76: mt7915: fix error recovery with WED enabled
Date: Thu, 18 Jan 2024 20:52:14 +0100
Message-ID: <20240118195216.80974-3-nbd@nbd.name>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240118195216.80974-1-nbd@nbd.name>
References: <20240118195216.80974-1-nbd@nbd.name>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Do not clear the interrupt mask register on MT7915, since that prevents
MCU_CMD interrupts from being reported, thus causing timeouts during the
reset sequence. Defer stopping WED until tx/rx processing activity has
stopped.

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mt7915/mac.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index b01edbed969c..e45361111f9b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -1520,12 +1520,6 @@ void mt7915_mac_reset_work(struct work_struct *work)
 	if (!(READ_ONCE(dev->recovery.state) & MT_MCU_CMD_STOP_DMA))
 		return;
 
-	if (mtk_wed_device_active(&dev->mt76.mmio.wed)) {
-		mtk_wed_device_stop(&dev->mt76.mmio.wed);
-		if (!is_mt798x(&dev->mt76))
-			mt76_wr(dev, MT_INT_WED_MASK_CSR, 0);
-	}
-
 	ieee80211_stop_queues(mt76_hw(dev));
 	if (ext_phy)
 		ieee80211_stop_queues(ext_phy->hw);
@@ -1545,6 +1539,9 @@ void mt7915_mac_reset_work(struct work_struct *work)
 
 	mutex_lock(&dev->mt76.mutex);
 
+	if (mtk_wed_device_active(&dev->mt76.mmio.wed))
+		mtk_wed_device_stop(&dev->mt76.mmio.wed);
+
 	mt76_wr(dev, MT_MCU_INT_EVENT, MT_MCU_INT_EVENT_DMA_STOPPED);
 
 	if (mt7915_wait_reset_state(dev, MT_MCU_CMD_RESET_DONE)) {
-- 
2.43.0


