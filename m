Return-Path: <linux-wireless+bounces-21040-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D836CA785E7
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Apr 2025 02:55:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FAF4188936A
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Apr 2025 00:55:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F3F3C2D1;
	Wed,  2 Apr 2025 00:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=david-bauer.net header.i=@david-bauer.net header.b="Ycc4JtKw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgate01.uberspace.is (mailgate01.uberspace.is [95.143.172.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB852F2F
	for <linux-wireless@vger.kernel.org>; Wed,  2 Apr 2025 00:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.143.172.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743555315; cv=none; b=b7Ui+uvl9YsHGAt+edyVgRzqO+F4GNWEM1hH/D/8Tj+ZMAbCZc+lF4eWPkgjqvYlASw93Wdth8+By2w+NChNyafTbgIU49I52wgDeDRMClaigAhKN7SCbk7xsVNah5CEpJHH35TSLjfN4msdTuq1zTVRALDNMO7iTWbwaARXxDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743555315; c=relaxed/simple;
	bh=ZDX/F/uaex4ndiB551575kE2oTtysLodPUsWsi6X8BQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GEkZAN9Qvzj5IG23UT6CDwLrcOMcHDTfH9p/9iR8QlN3NdhaE2ko2Y6ifbYSqtE/XQJBZ5URZTqr3LgtYiGwLpeALo4qZRyPYJBitxoopbEDD4xuG3QJC6X9ADf3jYBwoJ5rvjYKDq57rMPNOliBKXdWkP9OOam2uqT4gEH7Oq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=david-bauer.net; spf=pass smtp.mailfrom=david-bauer.net; dkim=pass (4096-bit key) header.d=david-bauer.net header.i=@david-bauer.net header.b=Ycc4JtKw; arc=none smtp.client-ip=95.143.172.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=david-bauer.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=david-bauer.net
Received: from perseus.uberspace.de (perseus.uberspace.de [95.143.172.134])
	by mailgate01.uberspace.is (Postfix) with ESMTPS id 1705060A43
	for <linux-wireless@vger.kernel.org>; Wed,  2 Apr 2025 02:46:24 +0200 (CEST)
Received: (qmail 23192 invoked by uid 988); 2 Apr 2025 00:46:23 -0000
Authentication-Results: perseus.uberspace.de;
	auth=pass (plain)
Received: from unknown (HELO unkown) (::1)
	by perseus.uberspace.de (Haraka/3.0.1) with ESMTPSA; Wed, 02 Apr 2025 02:46:23 +0200
From: David Bauer <mail@david-bauer.net>
To: Felix Fietkau <nbd@nbd.name>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Ryder Lee <ryder.lee@mediatek.com>,
	Shayne Chen <shayne.chen@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH 3/3] mt7915: mcu: re-init MCU before loading FW patch
Date: Wed,  2 Apr 2025 02:45:27 +0200
Message-ID: <20250402004528.1036715-3-mail@david-bauer.net>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250402004528.1036715-1-mail@david-bauer.net>
References: <20250402004528.1036715-1-mail@david-bauer.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Bar: /
X-Rspamd-Report: SUSPICIOUS_RECIPS(1.5) BAYES_HAM(-2.999999) MID_CONTAINS_FROM(1) MIME_GOOD(-0.1) R_MISSING_CHARSET(0.5)
X-Rspamd-Score: -0.099999
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=david-bauer.net; s=uberspace;
	h=from:to:cc:subject:date;
	bh=ZDX/F/uaex4ndiB551575kE2oTtysLodPUsWsi6X8BQ=;
	b=Ycc4JtKw/MQH+qC74VcmTdBWEb/Kw9qqatf42KdbSJM79kDfAr51QTqkK0mA/AdZnwy2rvV+r6
	Kqrvl7AE1fDHgDP32FkpUdwQbTOCmQt0Hj8A8sK+31WXUnBNJBHG6nZwGq6LqGwZeIhbflsD18J/
	HvHCrVLcniISeJPI2P6BNx8VmR+TakIaNQZbEBp+K6YM1LoaPj2UtM4J/GpQq5CVj2WFuZFnFb2Y
	gCQLIgjZKCitFR8Sr8EyERX/F+lAao2SOzDMHKLBdOD9vVUrSO52cr0e6oh5ndbXA2+1wpTIMfVB
	phmA3c9vUlHOsXdIHHLdBkcSBk51QjeX4StnEpyQBsAau02Ep4yse6g4TLgIKM5MKD4wcGk9EnHP
	p9n+9tyb5pH6sUhPKoWChxdK/JFiOvwSVYPaSPJn3n0/jDJ8dAjfmdmgsQnrBLdaM0eMUXYR0A8z
	zkx+LmUQ+bBWH5v2t/b6wHsvMnd5y7VQDqJq1tslqzyctmLRqc7/A8m/QN492a4i4swpVURHXoRP
	nYID2YffFTsONxXmEFxZhPR0frZR7zrOqVDPs93FspR+mtRqospCOPisja59xVBPao2t3RcI22vA
	gp3AfwpBd3RtEtZwby7trfO1UvQyMZodd8LozqkcaMG537T+DPYBcePw9O1h5P/ueksKot4pesJ2
	o=

Restart the MCU and release the patch semaphore before loading the MCU
patch firmware from the host.

This fixes failures upon error recovery in case the semaphore was
previously taken and never released by the host.

This happens from time to time upon triggering a full-chip error
recovery. Under this circumstance, the hardware restart fails and the
radio is rendered inoperational.

Signed-off-by: David Bauer <mail@david-bauer.net>
---
 .../net/wireless/mediatek/mt76/mt7915/mcu.c   | 25 +++++++++++--------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index d93a72d0a78a..41eba991acef 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -2097,16 +2097,21 @@ static int mt7915_load_firmware(struct mt7915_dev *dev)
 {
 	int ret;
 
-	/* make sure fw is download state */
-	if (mt7915_firmware_state(dev, false)) {
-		/* restart firmware once */
-		mt76_connac_mcu_restart(&dev->mt76);
-		ret = mt7915_firmware_state(dev, false);
-		if (ret) {
-			dev_err(dev->mt76.dev,
-				"Firmware is not ready for download\n");
-			return ret;
-		}
+	/* Release Semaphore if taken by previous failed attempt */
+	ret = mt76_connac_mcu_patch_sem_ctrl(&dev->mt76, false);
+	if (ret != PATCH_REL_SEM_SUCCESS) {
+		dev_err(dev->mt76.dev, "Could not release semaphore\n");
+		/* Continue anyways */
+	}
+
+	/* Always restart MCU firmware */
+	mt76_connac_mcu_restart(&dev->mt76);
+
+	/* Check if MCU is ready */
+	ret = mt7915_firmware_state(dev, false);
+	if (ret) {
+		dev_err(dev->mt76.dev, "Firmware did not enter download state\n");
+		return ret;
 	}
 
 	ret = mt76_connac2_load_patch(&dev->mt76, fw_name_var(dev, ROM_PATCH));
-- 
2.47.2


