Return-Path: <linux-wireless+bounces-3955-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CE43860FB6
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Feb 2024 11:44:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E68EAB23104
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Feb 2024 10:44:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F638823C5;
	Fri, 23 Feb 2024 10:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="nf18CKLV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E008B78B76
	for <linux-wireless@vger.kernel.org>; Fri, 23 Feb 2024 10:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708684830; cv=none; b=IWlpFvzXbxqHp4od/YE/jeeDordQ+chtL/6PMzq3r7+rDT12fLk+XFb0qa+rq4z4uHPIjugqz5loQRtXwFx7txlYnkpsPB1ZX+mADvjE64zbfVnMm8MfllhGWk8GMxCMrxwU7tEKkcUBEnmHe6/+9xinS9EpeTmBi7DCWbcUaBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708684830; c=relaxed/simple;
	bh=+Gr3Ipr443mZim7xnwxl3rD8DEyiRZx3BXMhBd8FS7E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FeJyhBP8YANecE6UTPGkFBhw5kP/EP21g/NoLCx1Q31RTLX5YigF/e0dqXqJFh7aeqVtlaJFyD0gaZwX9mG+fzNCxCyT6B0xSFr5xYXQd6ee8qvW198E/pjlADCfv5sWFHjw9fKNnzDLhLx6B9uorN7cQGcVCNtkvHn4vk3pg04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=nf18CKLV; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=umHP/K0gXpuQ/ZwiQAapxzWawC0PBFAVBcinEnJX5PA=;
	t=1708684828; x=1709894428; b=nf18CKLVIfZxhIkzhFyzFWcmVW5HNS/9jDF0NqS2+Hn7QHN
	jUoEh+QE6GyGaV9tILMiim+6aODWZqsdvEO/LzvdGrqz1w0rC/vTEpkcfu1aVkLsAtvBspexhyN4d
	lIWje/419utrJE8RtO3Si3ovfGKMsqLiMSz7F/NxyoRyMFEUeT08F1gnLp1Omx7TYLHXf9Sqsp2Pq
	Jm/Ce4sNKIzrDGSvHgCL4yqc3ahD6Jisg8FPxKmSsDzDIzqiIJHovwZ1NWoHPMLhuS7nLE+Ttw+Xk
	pJcaB2n2mvAEICGaYH0oIy812vajczuYX1t89vfr+PCAmLvylp2UrtdqF4EB0ewg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rdSyg-000000051om-1m2X;
	Fri, 23 Feb 2024 11:40:26 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 3/5] wifi: rt2x00: silence sparse warnings
Date: Fri, 23 Feb 2024 11:40:25 +0100
Message-ID: <20240223114023.ce0c714124e9.I2b5710b761f63522574fbe7654d37151c31e0b77@changeid>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240223114023.c64e2d348453.Iccc4ace1116721a044e5f31f40ea7709e72145f3@changeid>
References: <20240223114023.c64e2d348453.Iccc4ace1116721a044e5f31f40ea7709e72145f3@changeid>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

Clearly writing __le32 was intended here, so just put the
right casts into the code to silence sparse about it.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 drivers/net/wireless/ralink/rt2x00/rt2800lib.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/ralink/rt2x00/rt2800lib.c b/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
index aaf31857ae1e..3bb81bcff0ac 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
@@ -10946,13 +10946,13 @@ static void rt2800_efuse_read(struct rt2x00_dev *rt2x00dev, unsigned int i)
 	/* Apparently the data is read from end to start */
 	reg = rt2800_register_read_lock(rt2x00dev, efuse_data3_reg);
 	/* The returned value is in CPU order, but eeprom is le */
-	*(u32 *)&rt2x00dev->eeprom[i] = cpu_to_le32(reg);
+	*(__le32 *)&rt2x00dev->eeprom[i] = cpu_to_le32(reg);
 	reg = rt2800_register_read_lock(rt2x00dev, efuse_data2_reg);
-	*(u32 *)&rt2x00dev->eeprom[i + 2] = cpu_to_le32(reg);
+	*(__le32 *)&rt2x00dev->eeprom[i + 2] = cpu_to_le32(reg);
 	reg = rt2800_register_read_lock(rt2x00dev, efuse_data1_reg);
-	*(u32 *)&rt2x00dev->eeprom[i + 4] = cpu_to_le32(reg);
+	*(__le32 *)&rt2x00dev->eeprom[i + 4] = cpu_to_le32(reg);
 	reg = rt2800_register_read_lock(rt2x00dev, efuse_data0_reg);
-	*(u32 *)&rt2x00dev->eeprom[i + 6] = cpu_to_le32(reg);
+	*(__le32 *)&rt2x00dev->eeprom[i + 6] = cpu_to_le32(reg);
 
 	mutex_unlock(&rt2x00dev->csr_mutex);
 }
-- 
2.43.2


