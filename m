Return-Path: <linux-wireless+bounces-13203-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90277985EFB
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Sep 2024 15:48:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50BE928A39C
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Sep 2024 13:48:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FA4421A63D;
	Wed, 25 Sep 2024 12:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DQO3kOWf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D65421A642;
	Wed, 25 Sep 2024 12:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727266420; cv=none; b=Ef7FTgwu4I4Q1x6Y0ENXBRz/gnb2WypU7BimjTUlXUrlxTU0Q+Hw2NyfIIYhEJs8m7mpHmnf43qev/baLL53jE5UFRARpSIvQD1Ky5no8j18P5gqjoP4Is5/rGOWko0Kr6gNZ1uUD0W6Cof4Vok1f69vHR0H0i07/jLz2KUo7FU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727266420; c=relaxed/simple;
	bh=XhfPoPjMGZJ4e9xKiYa7H3zimc7LARC0zTQHcSvNCKg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C+3mUP1YAz+bk1D49pM+xpDq4XH+G7aWCV03VHoHjNob6BFnmijLymBfp51l6Ai6llgBPLZuI/6ESCV2tUVwjQtooQsDR1Fk2vWuIOqiIjzWYa7qzcY8l6JMTnP4BSq1o9YfwVi9fsLGX6fmqAZH1m0DjwTWFSwIq/vW4RcUJTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DQO3kOWf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BE3AC4CEC3;
	Wed, 25 Sep 2024 12:13:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727266420;
	bh=XhfPoPjMGZJ4e9xKiYa7H3zimc7LARC0zTQHcSvNCKg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DQO3kOWfzYyW1iISpwMlUeP+XIQg3/XvKCk04zRKtQUSvnTryMExJdKLi6Jn1FotZ
	 8gwbMQQd0krJpdLrDr8HxZnYrc8RepdKYRwwAf7BvAATug5OL0sqClfDzLLsYaGmX/
	 pkJByqyvdF3lnbi0AExhmFOeCtDfprQv81dlYQkpUqHET0paUbw6KXyFKPhtfopW6b
	 6YHML7MEqyIHLnBl6BMQcNgQuKy0GWoIGyLXkU9OwbJ4J0RgkkXMsaUsirZASgQgXt
	 1uiimirktcYYNjE0A09Os/DJHe1VIyFByALDPKQs5LSug2fon6FG11FlJhOnDnMVtf
	 F4OP8HRUlOx+g==
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
	StanleyYP.Wang@mediatek.com,
	johannes.berg@intel.com,
	dmantipov@yandex.ru,
	greearb@candelatech.com,
	meichia.chiu@mediatek.com,
	linux-wireless@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH AUTOSEL 6.6 052/139] wifi: mt76: mt7915: add dummy HW offload of IEEE 802.11 fragmentation
Date: Wed, 25 Sep 2024 08:07:52 -0400
Message-ID: <20240925121137.1307574-52-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925121137.1307574-1-sashal@kernel.org>
References: <20240925121137.1307574-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.52
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
index 35fdf4f98d80b..2fabef0ec42e5 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
@@ -386,6 +386,7 @@ mt7915_init_wiphy(struct mt7915_phy *phy)
 	ieee80211_hw_set(hw, SUPPORTS_RX_DECAP_OFFLOAD);
 	ieee80211_hw_set(hw, SUPPORTS_MULTI_BSSID);
 	ieee80211_hw_set(hw, WANT_MONITOR_VIF);
+	ieee80211_hw_set(hw, SUPPORTS_TX_FRAG);
 
 	hw->max_tx_fragments = 4;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/main.c b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
index 260fe00d7dc6d..f0f4f7d1d600d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
@@ -1562,6 +1562,12 @@ mt7915_twt_teardown_request(struct ieee80211_hw *hw,
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
@@ -1688,6 +1694,7 @@ const struct ieee80211_ops mt7915_ops = {
 	.sta_set_decap_offload = mt7915_sta_set_decap_offload,
 	.add_twt_setup = mt7915_mac_add_twt_setup,
 	.twt_teardown_request = mt7915_twt_teardown_request,
+	.set_frag_threshold = mt7915_set_frag_threshold,
 	CFG80211_TESTMODE_CMD(mt76_testmode_cmd)
 	CFG80211_TESTMODE_DUMP(mt76_testmode_dump)
 #ifdef CONFIG_MAC80211_DEBUGFS
-- 
2.43.0


