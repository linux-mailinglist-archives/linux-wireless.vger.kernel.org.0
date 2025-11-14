Return-Path: <linux-wireless+bounces-28985-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D4AEC5D538
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Nov 2025 14:24:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7ADA54E437A
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Nov 2025 13:16:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 583433126D9;
	Fri, 14 Nov 2025 13:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W4RS5EfE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33AE33126A5
	for <linux-wireless@vger.kernel.org>; Fri, 14 Nov 2025 13:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763126197; cv=none; b=UdaeyygCPR2NSlqWlgz0rhHGAWPV+/BFKFKEjjgobg9zNLysvRm4JxuOCbLXeTIEV01iw3uQi0aA/qYW5QewCust7qsIM0Ct3oz0RvZICgWGhMhgAHYqQ/SqRhzO5KuDLuf6BHw8VFUoKMITQf/XtAmyEceSlBPFc8xqe6xLAe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763126197; c=relaxed/simple;
	bh=Vcbw/nbH6Zz2C0EOEfbBO4A1x5TNQygfQV5lmRNbtf8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kWCmksY3mo5fYeKrrAfAIBXA1z2st1vqif9Ld0CTypXspE5QRRk9VcrhqjYSBgP5CQ1gmrFAH2hUA3RjlB4qPu2PZ6UogFfccAEP04DvmzAD+rvtL6eSDxJRKdlRp2+1KROHUOAObbn9izPx2ClOyLTpbDzPw9xEScWDHEHypb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W4RS5EfE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63B29C16AAE;
	Fri, 14 Nov 2025 13:16:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763126196;
	bh=Vcbw/nbH6Zz2C0EOEfbBO4A1x5TNQygfQV5lmRNbtf8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=W4RS5EfEhc6Qtde7eGmYM6f7YK/73tC8grXFVGq0/xdE7KTlrJT93FhY7ihN9V4m6
	 7oF0eHku86lHdsMPtpsxzmruOqrQ5ewH6w8NtMiRY5JPfR4YeQk0THeYMZtt1lqmc8
	 YAfJlUNSxctoL6K5gEDOkNFDXxeLwmW4kpAzB728I0XfVJEXxVcwEl4HJFjrqgkmIz
	 BhsLjXcRQ6BRiUTD3AGViaHUCI16aC9B/IDOwNhRgq0mpx0OKM37YTxf71tcJop68d
	 YhIbop+5EVKy/7M2LMMt32fdx4aU4fSlmoHeNBDkjfPoJPcnmiEbDdljuKicRyKcz1
	 1bwfy9ZyQGEeA==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Fri, 14 Nov 2025 14:16:21 +0100
Subject: [PATCH mt76 1/4] wifi: mt76: mt7996: grab mt76 mutex in
 mt7996_mac_sta_event()
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251114-mt76-fix-missing-mtx-v1-1-259ebf11f654@kernel.org>
References: <20251114-mt76-fix-missing-mtx-v1-0-259ebf11f654@kernel.org>
In-Reply-To: <20251114-mt76-fix-missing-mtx-v1-0-259ebf11f654@kernel.org>
To: Felix Fietkau <nbd@nbd.name>, Ryder Lee <ryder.lee@mediatek.com>, 
 Shayne Chen <shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Bo Jiao <Bo.Jiao@mediatek.com>, Peter Chiu <chui-hao.chiu@mediatek.com>
Cc: linux-wireless@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.2

Grab mt76 mutex in mt7996_mac_sta_event routine in order to rely on
mt76_dereference() utility macro.

Fixes: ecd72f9695e7e ("wifi: mt76: mt7996: Support MLO in mt7996_mac_sta_event()")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7996/main.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/main.c b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
index 581314368c5ba566f6050bee86696c4654619176..ad8698cf16242489b92e23befab4d040abbdcac2 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
@@ -1160,12 +1160,15 @@ mt7996_mac_sta_event(struct mt7996_dev *dev, struct ieee80211_vif *vif,
 	unsigned long links = sta->valid_links;
 	struct ieee80211_link_sta *link_sta;
 	unsigned int link_id;
+	int err = 0;
+
+	mutex_lock(&dev->mt76.mutex);
 
 	for_each_sta_active_link(vif, sta, link_sta, link_id) {
 		struct ieee80211_bss_conf *link_conf;
 		struct mt7996_sta_link *msta_link;
 		struct mt7996_vif_link *link;
-		int i, err;
+		int i;
 
 		link_conf = link_conf_dereference_protected(vif, link_id);
 		if (!link_conf)
@@ -1185,12 +1188,12 @@ mt7996_mac_sta_event(struct mt7996_dev *dev, struct ieee80211_vif *vif,
 						 link, msta_link,
 						 CONN_STATE_CONNECT, true);
 			if (err)
-				return err;
+				goto unlock;
 
 			err = mt7996_mcu_add_rate_ctrl(dev, msta_link->sta, vif,
 						       link_id, false);
 			if (err)
-				return err;
+				goto unlock;
 
 			msta_link->wcid.tx_info |= MT_WCID_TX_INFO_SET;
 			break;
@@ -1199,7 +1202,7 @@ mt7996_mac_sta_event(struct mt7996_dev *dev, struct ieee80211_vif *vif,
 						 link, msta_link,
 						 CONN_STATE_PORT_SECURE, false);
 			if (err)
-				return err;
+				goto unlock;
 			break;
 		case MT76_STA_EVENT_DISASSOC:
 			for (i = 0; i < ARRAY_SIZE(msta_link->twt.flow); i++)
@@ -1219,8 +1222,10 @@ mt7996_mac_sta_event(struct mt7996_dev *dev, struct ieee80211_vif *vif,
 			break;
 		}
 	}
+unlock:
+	mutex_unlock(&dev->mt76.mutex);
 
-	return 0;
+	return err;
 }
 
 static void

-- 
2.51.1


