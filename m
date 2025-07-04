Return-Path: <linux-wireless+bounces-24822-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E5548AF93A6
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Jul 2025 15:08:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 808FC188141F
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Jul 2025 13:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3C442F7D00;
	Fri,  4 Jul 2025 13:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YVFxkFs5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFDA72D77E5
	for <linux-wireless@vger.kernel.org>; Fri,  4 Jul 2025 13:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751634512; cv=none; b=C/tc3pST+nj/AZtXxlCkJJ4R1aGNDJQ5kOdQlcN3PENtxjqXr9n95AKS/GuQuUcAR1Y2Er+UZP7hmpXtZFs48JOkoIVR78UcFStIu6ohmOU0HS7x7hYohpEf75u4lu98nFPDveLNsxsL2MVkHIO75j+W4KlaP6LuF3oS8ZVj0Ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751634512; c=relaxed/simple;
	bh=ILv/QO9c6pKGzlXGfDlAmwZqWVYtSQrj2CTzSCJrX6k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=L52cSLcmeTQJ9je1YWltwg8CHGVmGMaBsyYL+p86X0WC7aN8js6sm1FTD+SaQhLtipUYRQPoJj0/O+XOtZ5mtLVm+PJEjCSO9uTNWV9vOE3mRYjCepZyG2Gd7+qYfBIodAt9vrjsMg11KixmXLBHtlsVGgilNmSmkiofgkN5EuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YVFxkFs5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0CE6C4CEE3;
	Fri,  4 Jul 2025 13:08:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751634512;
	bh=ILv/QO9c6pKGzlXGfDlAmwZqWVYtSQrj2CTzSCJrX6k=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=YVFxkFs5oFczlYj9RTnTQrGJ2vZGkCS9vnrgBt2OswslWd2UtKnh/lhknqxxrMGuo
	 k/EdHY1KwlTa6zelKZ+NQJgaHRfYhq/TtfW9jt3y8VhwXeEs66Pe+2Pya+t8w6KZ+v
	 tEsZDtfe5vbecBItPX9Wns1pjLKNNeRg8ydLgpr7hOWrHPfLm7U6BH7EhBYvn0iCya
	 1cr1UAs9AUtl5hzYyBFqy47NXoawz0XIVMbwLj/7WkBJEWltqeqvnj0O5Y8JdcKeWW
	 aMX8q05Pdf+znpI7k96FxmB44BPfBo6eGmwCgylZlZDOrhl2iAzCMeKbRfUYcA20Xw
	 GBT/+rimA8MNQ==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Fri, 04 Jul 2025 15:08:07 +0200
Subject: [PATCH mt76 3/9] wifi: mt76: mt7996: Rely on
 for_each_sta_active_link() in mt7996_mcu_sta_mld_setup_tlv()
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250704-mt7996-mlo-fixes-v1-3-356456c73f43@kernel.org>
References: <20250704-mt7996-mlo-fixes-v1-0-356456c73f43@kernel.org>
In-Reply-To: <20250704-mt7996-mlo-fixes-v1-0-356456c73f43@kernel.org>
To: Felix Fietkau <nbd@nbd.name>, Ryder Lee <ryder.lee@mediatek.com>, 
 Shayne Chen <shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Bo Jiao <Bo.Jiao@mediatek.com>, Peter Chiu <chui-hao.chiu@mediatek.com>
Cc: linux-wireless@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.2

Reuse for_each_sta_active_link utility macro in
mt7996_mcu_sta_mld_setup_tlv routine.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
index 1bf5632cb0f754d49ec6201254d35652d23c0a8c..0374872db4777cc85eed594f7d977dd822927b6d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
@@ -2216,15 +2216,15 @@ mt7996_mcu_add_group(struct mt7996_dev *dev, struct ieee80211_vif *vif,
 
 static void
 mt7996_mcu_sta_mld_setup_tlv(struct mt7996_dev *dev, struct sk_buff *skb,
+			     struct ieee80211_vif *vif,
 			     struct ieee80211_sta *sta)
 {
 	struct mt7996_sta *msta = (struct mt7996_sta *)sta->drv_priv;
-	unsigned long links = sta->valid_links;
-	unsigned int nlinks = hweight16(links);
+	unsigned int nlinks = hweight16(sta->valid_links);
 	struct mld_setup_link *mld_setup_link;
+	struct ieee80211_link_sta *link_sta;
 	struct sta_rec_mld_setup *mld_setup;
 	struct mt7996_sta_link *msta_link;
-	struct ieee80211_vif *vif;
 	unsigned int link_id;
 	struct tlv *tlv;
 
@@ -2242,7 +2242,7 @@ mt7996_mcu_sta_mld_setup_tlv(struct mt7996_dev *dev, struct sk_buff *skb,
 	mld_setup->primary_id = cpu_to_le16(msta_link->wcid.idx);
 
 	if (nlinks > 1) {
-		link_id = __ffs(links & ~BIT(msta->deflink_id));
+		link_id = __ffs(sta->valid_links & ~BIT(msta->deflink_id));
 		msta_link = mt76_dereference(msta->link[link_id], &dev->mt76);
 		if (!msta_link)
 			return;
@@ -2250,9 +2250,8 @@ mt7996_mcu_sta_mld_setup_tlv(struct mt7996_dev *dev, struct sk_buff *skb,
 	mld_setup->seconed_id = cpu_to_le16(msta_link->wcid.idx);
 	mld_setup->link_num = nlinks;
 
-	vif = container_of((void *)msta->vif, struct ieee80211_vif, drv_priv);
 	mld_setup_link = (struct mld_setup_link *)mld_setup->link_info;
-	for_each_set_bit(link_id, &links, IEEE80211_MLD_MAX_NUM_LINKS) {
+	for_each_sta_active_link(vif, sta, link_sta, link_id) {
 		struct mt7996_vif_link *link;
 
 		msta_link = mt76_dereference(msta->link[link_id], &dev->mt76);
@@ -2344,7 +2343,8 @@ int mt7996_mcu_add_sta(struct mt7996_dev *dev,
 		mt7996_mcu_sta_muru_tlv(dev, skb, link_conf, link_sta);
 
 		if (sta->mlo) {
-			mt7996_mcu_sta_mld_setup_tlv(dev, skb, sta);
+			mt7996_mcu_sta_mld_setup_tlv(dev, skb, link_conf->vif,
+						     sta);
 			mt7996_mcu_sta_eht_mld_tlv(dev, skb, sta);
 		}
 	}

-- 
2.50.0


