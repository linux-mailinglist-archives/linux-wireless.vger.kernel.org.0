Return-Path: <linux-wireless+bounces-27697-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 042C6BA8FFD
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Sep 2025 13:25:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3BB31C0539
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Sep 2025 11:25:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E636E1922FD;
	Mon, 29 Sep 2025 11:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="as90G04S"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA484824BD
	for <linux-wireless@vger.kernel.org>; Mon, 29 Sep 2025 11:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759145136; cv=none; b=gH79FeWj9nMkzSkL7a+UQ2LKRhcDpAUkgmrsMWayP7koXzh3kldFKC6aP+ZT3NIOr4IvkMEhwheJ+F4v2XUVtbp6qEIyTw3G1RZaF7RC+vGkznp1sSPdEpp3Okc+PJ8EXxFA1MBqbO3OVBDSAef3ewEbnB1vhvMegNb0WcdslU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759145136; c=relaxed/simple;
	bh=mgoQN81IfLTCxc6XS2gSZrPJUTcoMvVUTi8CzjTdy4s=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=CQ0j5paC8bW3/R0ajMgH0ZFZ1D5tiVtf0ZVCLSV+0zdd+7sq6h9j8YMHX8lNqIALWUHkImXJ5jw8FE6v1PPQ2lpsxbnM0fKdLjJcpfWuYvpgzUB5wK+I6CWw/66gqAwUHu/vi2kINKJlUU4PiZDlbQCXO1Thwi2nNdpGuberfwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=as90G04S; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=d8ngw17hiiMCFVoitBUXvI+b9O0QLPbkviCtej4wAFw=; b=as90G04SZq+GtbUnEZ+uxEJt7C
	bgSmLC1G7MJAcDVTNhxXb3L+CBYob67zOp7/e0mScntTakCXSNqiC59FEdLheoz0Fh1DSs7vfuIN+
	YtH+6TnoN9xIkTGIb2hgWxn8a5qQFzW6DDMDtPCYwl60crCkQdBVAWBMjjfeTMXQbqJs=;
Received: from p4ff13580.dip0.t-ipconnect.de ([79.241.53.128] helo=Maecks.lan)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1v3Bsi-00ESEo-08
	for linux-wireless@vger.kernel.org;
	Mon, 29 Sep 2025 13:17:24 +0200
From: Felix Fietkau <nbd@nbd.name>
To: linux-wireless@vger.kernel.org
Subject: [PATCH] wifi: mt76: mt7996: fix null pointer deref in mt7996_conf_tx()
Date: Mon, 29 Sep 2025 13:17:23 +0200
Message-ID: <20250929111723.52486-1-nbd@nbd.name>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If a link does not have an assigned channel yet, mt7996_vif_link returns
NULL. We still need to store the updated queue settings in that case, and
apply them later.
Move the location of the queue params to within struct mt7996_vif_link.

Fixes: c0df2f0caa8d ("wifi: mt76: mt7996: prepare mt7996_mcu_set_tx for MLO support")
Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mt7996/main.c   | 6 +++---
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.c    | 5 ++++-
 drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h | 7 ++++++-
 3 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/main.c b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
index 581314368c5b..b53ca702591c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
@@ -665,8 +665,8 @@ mt7996_conf_tx(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	       unsigned int link_id, u16 queue,
 	       const struct ieee80211_tx_queue_params *params)
 {
-	struct mt7996_dev *dev = mt7996_hw_dev(hw);
-	struct mt7996_vif_link *mlink = mt7996_vif_link(dev, vif, link_id);
+	struct mt7996_vif *mvif = (struct mt7996_vif *)vif->drv_priv;
+	struct mt7996_vif_link_info *link_info = &mvif->link_info[link_id];
 	static const u8 mq_to_aci[] = {
 		[IEEE80211_AC_VO] = 3,
 		[IEEE80211_AC_VI] = 2,
@@ -675,7 +675,7 @@ mt7996_conf_tx(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	};
 
 	/* firmware uses access class index */
-	mlink->queue_params[mq_to_aci[queue]] = *params;
+	link_info->queue_params[mq_to_aci[queue]] = *params;
 	/* no need to update right away, we'll get BSS_CHANGED_QOS */
 
 	return 0;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
index 0347ee0c2dd7..afa6a43bd51e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
@@ -3414,6 +3414,9 @@ int mt7996_mcu_set_tx(struct mt7996_dev *dev, struct ieee80211_vif *vif,
 #define WMM_PARAM_SET		(WMM_AIFS_SET | WMM_CW_MIN_SET | \
 				 WMM_CW_MAX_SET | WMM_TXOP_SET)
 	struct mt7996_vif_link *link = mt7996_vif_conf_link(dev, vif, link_conf);
+	struct mt7996_vif *mvif = (struct mt7996_vif *)vif->drv_priv;
+	unsigned int link_id = link_conf->link_id;
+	struct mt7996_vif_link_info *link_info = &mvif->link_info[link_id];
 	struct {
 		u8 bss_idx;
 		u8 __rsv[3];
@@ -3431,7 +3434,7 @@ int mt7996_mcu_set_tx(struct mt7996_dev *dev, struct ieee80211_vif *vif,
 	skb_put_data(skb, &hdr, sizeof(hdr));
 
 	for (ac = 0; ac < IEEE80211_NUM_ACS; ac++) {
-		struct ieee80211_tx_queue_params *q = &link->queue_params[ac];
+		struct ieee80211_tx_queue_params *q = &link_info->queue_params[ac];
 		struct edca *e;
 		struct tlv *tlv;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
index 8ec2acdb3319..718e4d4ad85f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
@@ -253,16 +253,21 @@ struct mt7996_vif_link {
 	struct mt7996_sta_link msta_link;
 	struct mt7996_phy *phy;
 
-	struct ieee80211_tx_queue_params queue_params[IEEE80211_NUM_ACS];
 	struct cfg80211_bitrate_mask bitrate_mask;
 
 	u8 mld_idx;
 };
 
+struct mt7996_vif_link_info {
+	struct ieee80211_tx_queue_params queue_params[IEEE80211_NUM_ACS];
+};
+
 struct mt7996_vif {
 	struct mt7996_vif_link deflink; /* must be first */
 	struct mt76_vif_data mt76;
 
+	struct mt7996_vif_link_info link_info[IEEE80211_MLD_MAX_NUM_LINKS];
+
 	u8 mld_group_idx;
 	u8 mld_remap_idx;
 };
-- 
2.51.0


