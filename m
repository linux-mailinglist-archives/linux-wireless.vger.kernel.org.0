Return-Path: <linux-wireless+bounces-26991-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A16BB434C9
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Sep 2025 09:57:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED3C358213C
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Sep 2025 07:57:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38E8E242D92;
	Thu,  4 Sep 2025 07:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yo9XcH+j"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D9332F775
	for <linux-wireless@vger.kernel.org>; Thu,  4 Sep 2025 07:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756972639; cv=none; b=LxttWWULabHAkfzWsexWjBJutZPC8DJzHInJXvKI0AQhkVweiLd+b+HQ4vKVqlvHQjUyyFIo6vwKhLJoaihLfhFk15/bLkVWIBkYrM56iBJA9m/Os7zygbfh/wTD4BcClIAlNOflpfO9WMETapME+Hr3/papmt/S+Zdm6UxCr54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756972639; c=relaxed/simple;
	bh=uOT9augq1THTn6rcZNU8gbe4Sm3lAPpWzSXT4I6JDmg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iAfvr8MXLxcX/pt1v+K3gIzeoP28NuxhDSkfzYGOssm4jEVvfEXlvPhKKvQGW/oCpc/tbhgJ6orGGbhJoK+Irdxemme3BKTuwf+N82DPzA+QVwMdHMnQKyY8cwcAnmWYjLDJZLPO9EsWHYbcuUveBAhiQRBpFbfAGSbA/uXNmd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yo9XcH+j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4975BC4CEF0;
	Thu,  4 Sep 2025 07:57:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756972638;
	bh=uOT9augq1THTn6rcZNU8gbe4Sm3lAPpWzSXT4I6JDmg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Yo9XcH+jSTIKxb91KKSGPv0SvyekPECqA3ocn8SMlKENyNd7YyKocl5495pLgDr1W
	 DfTJ+riG9k8J12pC6g9p7vnqCucjMl/J7vdWWB7djfYCZx4JdH0qJ4YMMLU9zjPOti
	 TsMR/YtJWW59qefg41gvuvLYb4G3T3TtBS3glEXtP7Vaiv+we6RfnlYqXKHJXs/nJv
	 ii8VHxDd2xp3OQeP3QXOPVbywFezGI4Lmh4zioWuvsSgInOMZluIXg66U6SaK33BXo
	 kFVUtMf+zcwNo06Q68GDmL4DIRBNoFzbrP7i04cNE6E1IVmil5eLysIiDWIPHFE6TM
	 TS228ay70UEXQ==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Thu, 04 Sep 2025 09:56:40 +0200
Subject: [PATCH mt76 2/4] wifi: mt76: mt7996: Add all active links to poll
 list in mt7996_mac_tx_free()
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250904-mt7996-mlo-more-fixes-v1-2-89d8fed67f20@kernel.org>
References: <20250904-mt7996-mlo-more-fixes-v1-0-89d8fed67f20@kernel.org>
In-Reply-To: <20250904-mt7996-mlo-more-fixes-v1-0-89d8fed67f20@kernel.org>
To: Felix Fietkau <nbd@nbd.name>, Ryder Lee <ryder.lee@mediatek.com>, 
 Shayne Chen <shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-wireless@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, Bo Jiao <Bo.Jiao@mediatek.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.2

Add all valid links to poll list for Airtime Fairness/AQL accounting when
tx-free event occurs.

Co-developed-by: Bo Jiao <Bo.Jiao@mediatek.com>
Signed-off-by: Bo Jiao <Bo.Jiao@mediatek.com>
Co-developed-by: Shayne Chen <shayne.chen@mediatek.com>
Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7996/mac.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
index 646c6f2f72918bbbdceddb5321c862f326d803b0..33eb05dc5fc4826b5752fcee923213e051107074 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
@@ -1249,6 +1249,9 @@ mt7996_mac_tx_free(struct mt7996_dev *dev, void *data, int len)
 		info = le32_to_cpu(*cur_info);
 		if (info & MT_TXFREE_INFO_PAIR) {
 			struct ieee80211_sta *sta;
+			unsigned long valid_links;
+			struct mt7996_sta *msta;
+			unsigned int id;
 			u16 idx;
 
 			idx = FIELD_GET(MT_TXFREE_INFO_WLAN_ID, info);
@@ -1261,7 +1264,21 @@ mt7996_mac_tx_free(struct mt7996_dev *dev, void *data, int len)
 			if (!link_sta)
 				goto next;
 
-			mt76_wcid_add_poll(&dev->mt76, wcid);
+			msta = (struct mt7996_sta *)sta->drv_priv;
+			valid_links = sta->valid_links ?: BIT(0);
+
+			/* For MLD STA, add all link's wcid to sta_poll_list */
+			for_each_set_bit(id, &valid_links,
+					 IEEE80211_MLD_MAX_NUM_LINKS) {
+				struct mt7996_sta_link *msta_link;
+
+				msta_link = rcu_dereference(msta->link[id]);
+				if (!msta_link)
+					continue;
+
+				mt76_wcid_add_poll(&dev->mt76,
+						   &msta_link->wcid);
+			}
 next:
 			/* ver 7 has a new DW with pair = 1, skip it */
 			if (ver == 7 && ((void *)(cur_info + 1) < end) &&

-- 
2.50.1


