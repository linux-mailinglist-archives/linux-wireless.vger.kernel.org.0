Return-Path: <linux-wireless+bounces-22288-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 44FD5AA58A0
	for <lists+linux-wireless@lfdr.de>; Thu,  1 May 2025 01:23:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA30A4C6492
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Apr 2025 23:23:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E04F22A4DA;
	Wed, 30 Apr 2025 23:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="f4oClCMS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D34D8225A29
	for <linux-wireless@vger.kernel.org>; Wed, 30 Apr 2025 23:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.154.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746055373; cv=none; b=OvomvUlnuS3hnPKsHkpKW4TlkeObTvXMPenPDUzM/9p8Sc42BmgIQYAV1OwbqP/i6kHWqnu1T1hewymCGKmNt22Ue0HjKIZ2+oq1IvwZpGrDgiI21bLQmHyb/lnYIhHQcqnkqceZUtSXLZfEXQeFUXdwdwdwtrMnY+EphYKQPwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746055373; c=relaxed/simple;
	bh=DE3eCq2LVGeEwvO51X68M4zn56MhnhKlt4oPZIE10R8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pou2Ss8j3D2DJN48Z1oxWDNchAjGvqiGlxXg3a6UuXLt8dKqN9Ju3Gaa7Z0NDp+2d3F9pNtXfIJ9Rx2sPyCMq7CHdwxhcLFhp47Jj8b4Cg3HlPqoSv97+P5WUY953IUBv8rQiqkwXbPAAExFl7URVgJdigu03G6dafU7wVTjjTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=f4oClCMS; arc=none smtp.client-ip=67.231.154.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
Received: from engine.ppe-hosted.com (unknown [10.110.48.12])
	by dispatch1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 1D80560107;
	Wed, 30 Apr 2025 23:22:44 +0000 (UTC)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 7D869980066;
	Wed, 30 Apr 2025 23:22:42 +0000 (UTC)
Received: from carkeek.lan (unknown [50.251.239.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id 9579413C2B1;
	Wed, 30 Apr 2025 16:22:41 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 9579413C2B1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1746055361;
	bh=DE3eCq2LVGeEwvO51X68M4zn56MhnhKlt4oPZIE10R8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=f4oClCMSNiJEOKRVL3ZocrQ75aIZp0atYNB9ib9t8XY7wQ7oxQvB1pp0965tEXd+a
	 7wZ42VIUNQuv05GBa6hmWdBqKriBoqhvDjOEygB9bzxYQiRwBsEtlk06PSascwpMvb
	 bzRpXponkYFbcu77ueTGGdhwYPbKmaH2U6nSrR98=
From: Rory Little <rory@candelatech.com>
To: nbd@nbd.name,
	lorenzo@kernel.org,
	ryder.lee@mediatek.com
Cc: shayne.chen@mediatek.com,
	sean.wang@mediatek.com,
	linux-wireless@vger.kernel.org
Subject: [PATCH mt76 v2 1/4] wifi: mt76: mt7996: Add per-radio phy debugfs directories.
Date: Wed, 30 Apr 2025 16:22:22 -0700
Message-ID: <20250430232225.3943242-2-rory@candelatech.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250430232225.3943242-1-rory@candelatech.com>
References: <20250430232225.3943242-1-rory@candelatech.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MDID: 1746055363-94Da6_6eFQYQ
X-PPE-STACK: {"stack":"us5"}
X-MDID-O:
 us5;at1;1746055363;94Da6_6eFQYQ;<rory@candelatech.com>;f49eb8a899f4a60c9b856bf22a60d609
X-PPE-TRUSTED: V=1;DIR=OUT;

These can be used instead of reporting just from the first phy, or using
one file for all phys, as has been done previously.

Signed-off-by: Rory Little <rory@candelatech.com>
---
 .../wireless/mediatek/mt76/mt7996/debugfs.c   | 25 +++++++++++++++++++
 .../wireless/mediatek/mt76/mt7996/mt7996.h    |  2 ++
 2 files changed, 27 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/debugfs.c b/drivers/net/wireless/mediatek/mt76/mt7996/debugfs.c
index 4a28db17a287..3548b2bd9b72 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/debugfs.c
@@ -842,9 +842,28 @@ mt7996_rf_regval_set(void *data, u64 val)
 DEFINE_DEBUGFS_ATTRIBUTE(fops_rf_regval, mt7996_rf_regval_get,
 			 mt7996_rf_regval_set, "0x%08llx\n");
 
+static int
+mt7996_init_radio_phy_debugfs(struct mt7996_phy *phy)
+{
+	struct dentry *dir;
+	char fname[12];
+
+	snprintf(fname, sizeof(fname), "radio_phy%d", phy->mt76->band_idx);
+	dir = debugfs_create_dir(fname, phy->dev->debugfs_dir);
+
+	if (IS_ERR_OR_NULL(dir))
+		return -ENOMEM;
+
+	phy->debugfs_dir = dir;
+
+	return 0;
+}
+
 int mt7996_init_debugfs(struct mt7996_dev *dev)
 {
+	int err;
 	struct dentry *dir;
+	struct mt7996_phy *phy;
 
 	dir = mt76_register_debugfs_fops(&dev->mphy, NULL);
 	if (!dir)
@@ -877,6 +896,12 @@ int mt7996_init_debugfs(struct mt7996_dev *dev)
 
 	dev->debugfs_dir = dir;
 
+	mt7996_for_each_phy(dev, phy) {
+		err = mt7996_init_radio_phy_debugfs(phy);
+		if (err)
+			return err;
+	}
+
 	return 0;
 }
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
index 43e646ed6094..3300b7c8e4d2 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
@@ -296,6 +296,8 @@ struct mt7996_phy {
 
 	bool has_aux_rx;
 	bool counter_reset;
+
+	struct dentry *debugfs_dir;
 };
 
 struct mt7996_dev {
-- 
2.45.2


