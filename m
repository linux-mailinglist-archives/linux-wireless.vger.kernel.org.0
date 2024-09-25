Return-Path: <linux-wireless+bounces-13166-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54A0E9859B6
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Sep 2024 13:59:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85E0B1C2119B
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Sep 2024 11:59:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46FE01AD405;
	Wed, 25 Sep 2024 11:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cKcslDF4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E32A1AD401;
	Wed, 25 Sep 2024 11:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727264402; cv=none; b=ZwB+tn/NGGhFcZbHgtSq2LpLaO2FTr8XfoYZcYmFHhLuK3+hsCRaq/GZcIHh/ASOvISpG9JxtjzfSpo7x1mnSHnHQI1IxB6bGjqOv2L51hUnnZZyetMDebmweSvuYU4ojTNEEdfssBrzQ3eWunwkKOjpArFfV/LqFEk5l3F74sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727264402; c=relaxed/simple;
	bh=6PxMxoP+cBtqX8JWuu7+PQTYn3lMoEZZBNkkOWF9CN4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nMPgP4R2qM6Z7X0cCVMOu0xdmWwWfMzY7m7ge1+PVTXeGM/nWE6tS+XZHpYn7gdH9xkXfU2rZaE/LKrI7hR/qeFvHPuBlVh994aALOgX5wB54azN2HRhIiEBjvGzjdQmV/JU+9COSa1H/xKDNt0mkiWZ3jyZbyBGejbMfn9oFc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cKcslDF4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4443CC4CECD;
	Wed, 25 Sep 2024 11:39:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727264401;
	bh=6PxMxoP+cBtqX8JWuu7+PQTYn3lMoEZZBNkkOWF9CN4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cKcslDF4mYQvo0jexm9uSndJjCI2F8kRRlIjmpddesjw++bOQqu3YrcJh0HkzEglG
	 MYya5InqTB6yEbdxI24waljq8s5+fcGE5HMdxJRQEw3YXzaUu5C/On1cx9ARuMU5pd
	 HZTyFAUwQEXQVMjV2cDnrkEEs3N0XsrtgWwBguF4cxGx/gqHktGH5AImCmFJTNRYfa
	 kbOCT0YAPpRWCTRDdmZdSdwo6/spfe2VFQqOSabIRiQ04w2DLXOy8UJazs4LQ/HuqT
	 9fzgMK1Aw9HzWHobYGQzSjZvuzNktLA+H8/1bt32zPM5dRyzytOLKhIVjKa0OqPcAP
	 NsAqjV1LekiFg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Benjamin Lin <benjamin-jw.lin@mediatek.com>,
	Felix Fietkau <nbd@nbd.name>,
	Sasha Levin <sashal@kernel.org>,
	lorenzo@kernel.org,
	ryder.lee@mediatek.com,
	kvalo@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	shayne.chen@mediatek.com,
	chui-hao.chiu@mediatek.com,
	howard-yh.hsu@mediatek.com,
	ruanjinjie@huawei.com,
	greearb@candelatech.com,
	dmantipov@yandex.ru,
	StanleyYP.Wang@mediatek.com,
	meichia.chiu@mediatek.com,
	linux-wireless@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH AUTOSEL 6.11 082/244] wifi: mt76: mt7915: add dummy HW offload of IEEE 802.11 fragmentation
Date: Wed, 25 Sep 2024 07:25:03 -0400
Message-ID: <20240925113641.1297102-82-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925113641.1297102-1-sashal@kernel.org>
References: <20240925113641.1297102-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11
Content-Transfer-Encoding: 8bit

From: Benjamin Lin <benjamin-jw.lin@mediatek.com>

[ Upstream commit f2cc859149240d910fdc6405717673e0b84bfda8 ]

Currently, CONNAC2 series do not support encryption for fragmented Tx frames.
Therefore, add dummy function mt7915_set_frag_threshold() to prevent SW
IEEE 802.11 fragmentation.

Signed-off-by: Benjamin Lin <benjamin-jw.lin@mediatek.com>
Link: https://patch.msgid.link/20240827093011.18621-16-nbd@nbd.name
Signed-off-by: Felix Fietkau <nbd@nbd.name>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7915/init.c | 1 +
 drivers/net/wireless/mediatek/mt76/mt7915/main.c | 7 +++++++
 2 files changed, 8 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/init.c b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
index a978f434dc5e6..511e0d04eb955 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
@@ -398,6 +398,7 @@ mt7915_init_wiphy(struct mt7915_phy *phy)
 	ieee80211_hw_set(hw, SUPPORTS_RX_DECAP_OFFLOAD);
 	ieee80211_hw_set(hw, SUPPORTS_MULTI_BSSID);
 	ieee80211_hw_set(hw, WANT_MONITOR_VIF);
+	ieee80211_hw_set(hw, SUPPORTS_TX_FRAG);
 
 	hw->max_tx_fragments = 4;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/main.c b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
index 049223df9beb1..0da1807ad8f7d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
@@ -1578,6 +1578,12 @@ mt7915_twt_teardown_request(struct ieee80211_hw *hw,
 	mutex_unlock(&dev->mt76.mutex);
 }
 
+static int
+mt7915_set_frag_threshold(struct ieee80211_hw *hw, u32 val)
+{
+	return 0;
+}
+
 static int
 mt7915_set_radar_background(struct ieee80211_hw *hw,
 			    struct cfg80211_chan_def *chandef)
@@ -1708,6 +1714,7 @@ const struct ieee80211_ops mt7915_ops = {
 	.sta_set_decap_offload = mt7915_sta_set_decap_offload,
 	.add_twt_setup = mt7915_mac_add_twt_setup,
 	.twt_teardown_request = mt7915_twt_teardown_request,
+	.set_frag_threshold = mt7915_set_frag_threshold,
 	CFG80211_TESTMODE_CMD(mt76_testmode_cmd)
 	CFG80211_TESTMODE_DUMP(mt76_testmode_dump)
 #ifdef CONFIG_MAC80211_DEBUGFS
-- 
2.43.0


