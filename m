Return-Path: <linux-wireless+bounces-5798-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 05ADF896D4C
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Apr 2024 12:53:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36BBC1C26E76
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Apr 2024 10:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6F547317F;
	Wed,  3 Apr 2024 10:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="Bz5uJPRW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD61F1411D6
	for <linux-wireless@vger.kernel.org>; Wed,  3 Apr 2024 10:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712141569; cv=none; b=Pp2b93nMJVUChiSvUqP2SWb62sdnSUwhLsRRgijnQ/QoBLxUnwmgP26FoR71AUS6NICUkqVenNJSiadxorLt1y11xhXDLqKH9bHHSZ8Y0j21AoPJADm0vxWtkj56Fq9zMGyOitQ8uG4m0jZ2dfVcI5gbaOZvPGqdBMvo7Q6z63Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712141569; c=relaxed/simple;
	bh=+0hKOhgqBsmGI7VoeFqWOQwM0SZXh84wljtnBWsmjjo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=e4SQjg3E3s+VuxYcjg3O9MDSFh9NoKpwyEvv9Fu5PSCXndvKAcj60dfLY82OizCZL7IsCsczdyZvHlbyBg1BK/kxXWOa3D3WmcmZNjAEHl0ds1evdrRgq26NUuuCmdGAFOiIbkSVQoo7jwzsUz0oCo1wXOSkansWp6N8SjgeKS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=Bz5uJPRW; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=Bi8CmWyYC3S1OMhHBGv7//trnZFH8HiYjc/gqU4+eZo=; b=Bz5uJPRWqBMRaLiO9bu5bzX6Ug
	Zux7MwEMiFN6QfRaclhKNcLQcCrQEQotHYHWpbKmaSuJVuVrZZc7eRjF4o75Q08y8feoslj68uF2K
	tW7zhi8Y22hsjfQno5pdVH1tGcBaVZ6ot5Q3OoznekA4d4aiYgrybPsXIwv4MayBM5nQ=;
Received: from p54ae9c93.dip0.t-ipconnect.de ([84.174.156.147] helo=localhost.localdomain)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
	(Exim 4.94.2)
	(envelope-from <nbd@nbd.name>)
	id 1rrxt2-00CgfA-Rj
	for linux-wireless@vger.kernel.org; Wed, 03 Apr 2024 12:30:32 +0200
From: Felix Fietkau <nbd@nbd.name>
To: linux-wireless@vger.kernel.org
Subject: [PATCH 01/13] wifi: mt76: mt7915: initialize rssi on adding stations
Date: Wed,  3 Apr 2024 12:30:20 +0200
Message-ID: <20240403103032.54823-1-nbd@nbd.name>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Improves initial rate selection after connecting

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mt7915/main.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/main.c b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
index 3709d18da0e6..49d5b459fb44 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
@@ -744,6 +744,7 @@ int mt7915_mac_sta_add(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 	struct mt7915_vif *mvif = (struct mt7915_vif *)vif->drv_priv;
 	bool ext_phy = mvif->phy != &dev->phy;
 	int ret, idx;
+	u32 addr;
 
 	idx = mt76_wcid_alloc(dev->mt76.wcid_mask, MT7915_WTBL_STA);
 	if (idx < 0)
@@ -767,6 +768,9 @@ int mt7915_mac_sta_add(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 	if (ret)
 		return ret;
 
+	addr = mt7915_mac_wtbl_lmac_addr(dev, msta->wcid.idx, 30);
+	mt76_rmw_field(dev, addr, GENMASK(7, 0), 0xa0);
+
 	return mt7915_mcu_add_rate_ctrl(dev, vif, sta, false);
 }
 
-- 
2.43.0


