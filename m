Return-Path: <linux-wireless+bounces-16917-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B128C9FEA67
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Dec 2024 20:42:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A802D1882910
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Dec 2024 19:42:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C88DD19CD0E;
	Mon, 30 Dec 2024 19:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="Cg/8cN/L"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF0B5199239
	for <linux-wireless@vger.kernel.org>; Mon, 30 Dec 2024 19:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735587734; cv=none; b=bo0YQBq8KXcXf0xzByWGNsu8ze8nSfPpJZi9MFrQLJkRisR68HDwf+tWp6Xzka7Lpl5kAa2OHLuGxXlclbPPZDfcZensIb6AS5MJJZChAfukXK8RAD8k4Zdm4NLjdJj3EqhIDPBjZGfy5jEZX8rerzklJpSU35WfSUTRElnasfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735587734; c=relaxed/simple;
	bh=pTf9uhR1HwlZ+soMlkK38UIRVXh9fqs8tsLEkzaLZW8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o2QNTAtt04DWrcjOy9C5z3JymR0pftKuHePzYW+WVaBQ24eTGKKyYF5rPFjL9B20EVV167PzK1zRKD5b8+dlG3fIdYt2g9OGS6ctWSWemC3ueNUi+I8oZSyPEECmrpp+ZWXqeG+QiHWbqoKRyCtVvMCGOYv77+KA/tZHtdXYQNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=Cg/8cN/L; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=WY6NKapy3IhvOS+IgMFpSYa19SNn9ZBnMgIOk5zBFec=; b=Cg/8cN/LG95eEwmck/Bg7/K37D
	h9hMxvmdwNWUvq53LAcLqS+ae5KtHLp3BxbB76AsbK3766GXp6RqwuoUBpd8r16DdWiSwaxFge4zH
	xQePn2aZOj/xUz+WDADqaNPAKYqZYypNNeYIItBDtSNyJOWfb8cgI1BmaEDwP8NfsNf4=;
Received: from p4ff13c5f.dip0.t-ipconnect.de ([79.241.60.95] helo=Maecks.lan)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1tSLeV-00GKzc-05
	for linux-wireless@vger.kernel.org;
	Mon, 30 Dec 2024 20:42:11 +0100
From: Felix Fietkau <nbd@nbd.name>
To: linux-wireless@vger.kernel.org
Subject: [PATCH 10/14] wifi: mt76: mt7915: hold dev->mutex while interacting with the thermal state
Date: Mon, 30 Dec 2024 20:41:58 +0100
Message-ID: <20241230194202.95065-10-nbd@nbd.name>
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

Avoid issuing MCU calls during a hardware restart

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mt7915/init.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/init.c b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
index 4282857d8ce9..c530435b19b5 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
@@ -53,7 +53,9 @@ static ssize_t mt7915_thermal_temp_show(struct device *dev,
 
 	switch (i) {
 	case 0:
+		mutex_lock(&phy->dev->mt76.mutex);
 		temperature = mt7915_mcu_get_temperature(phy);
+		mutex_unlock(&phy->dev->mt76.mutex);
 		if (temperature < 0)
 			return temperature;
 		/* display in millidegree celcius */
@@ -95,9 +97,8 @@ static ssize_t mt7915_thermal_temp_store(struct device *dev,
 	}
 
 	phy->throttle_temp[i - 1] = val;
-	mutex_unlock(&phy->dev->mt76.mutex);
-
 	ret = mt7915_mcu_set_thermal_protect(phy);
+	mutex_unlock(&phy->dev->mt76.mutex);
 	if (ret)
 		return ret;
 
@@ -159,7 +160,9 @@ mt7915_thermal_set_cur_throttle_state(struct thermal_cooling_device *cdev,
 	 * cooling_device convention: 0 = no cooling, more = more cooling
 	 * mcu convention: 1 = max cooling, more = less cooling
 	 */
+	mutex_lock(&phy->dev->mt76.mutex);
 	ret = mt7915_mcu_set_thermal_throttling(phy, throttling);
+	mutex_unlock(&phy->dev->mt76.mutex);
 	if (ret)
 		return ret;
 
-- 
2.47.1


