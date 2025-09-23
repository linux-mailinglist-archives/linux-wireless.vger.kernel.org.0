Return-Path: <linux-wireless+bounces-27619-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F90FB9703C
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Sep 2025 19:23:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 031363A62F6
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Sep 2025 17:23:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC14627A44A;
	Tue, 23 Sep 2025 17:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="sN0se039"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68BE217A5BE
	for <linux-wireless@vger.kernel.org>; Tue, 23 Sep 2025 17:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758648225; cv=none; b=ofgZRx8aS6PEfvpG6Y2qS49TIaWlHnH08PLArWt4GBzuu4gamthMB5tqp5CYBNI+Csv6vysSLwXXaeUxncxqLKphiUqxn/b8Y+mk7bWJuCZZ/9/rf6y/IM9PaPnFJpEedZHDldqUM8D9fijd/5vCm+KBxDNSyMJmLvMz5SWfdfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758648225; c=relaxed/simple;
	bh=RxC9D3qyilQSxGCG9alnzeYom6d57LHh6dNNUTKFGM4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gGi9ZJAiGeK1mY1i2l/F1I+sWBSFwoDLZk7wewhdR4ALIAWJNnhgUxfI9mJPQpjaIvkW37iYbk8WDbJfJQeHZeikj7Qrm0WoeK0SX3v7RG0W7DMPCbGpAtIcmD5m+nwgMQyXUrmuxkDtT1gTqwH+KMU/NrWUDT7n+bUmS4gASQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=sN0se039; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 09dbb11498a211f0b33aeb1e7f16c2b6-20250924
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=EEoXe+t7vDX31Uq89cn+wkq8RDH/6C6K+Ng/cRXgJmM=;
	b=sN0se039/y3HsB8eambKZyq4m90RbkyMFbd0a3EKzjjK2bsUlQGHZvKXazwPqxyDYsAnB9DEpjLuXP2XGgMRuyH5lcErxJ+V2zQIVWklIxjE+T9uZoacCAn9Bryqjs8ZoTxpnD0aI1U5P9dYNTlePz85zBtU7CixqDKjPx9WCgA=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.4,REQID:4114fb82-1f31-4eba-bbbf-528449c7aa5f,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:1ca6b93,CLOUDID:904dc521-c299-443d-bb51-d77d2f000e20,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102|836|888|898,TC:-5,Content:0|15|5
	0,EDM:-3,IP:nil,URL:0,File:130,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,
	OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 09dbb11498a211f0b33aeb1e7f16c2b6-20250924
Received: from mtkmbs09n2.mediatek.inc [(172.21.101.94)] by mailgw02.mediatek.com
	(envelope-from <ryder.lee@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1478686377; Wed, 24 Sep 2025 01:23:36 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Wed, 24 Sep 2025 01:23:25 +0800
Received: from mussdccf250.eus.mediatek.inc (10.73.250.250) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1748.10 via Frontend Transport; Wed, 24 Sep 2025 01:23:24 +0800
From: Ryder Lee <ryder.lee@mediatek.com>
To: <linux-wireless@vger.kernel.org>, Johannes Berg
	<johannes@sipsolutions.net>
CC: Shayne Chen <shayne.chen@mediatek.com>, Evelyn Tsai
	<evelyn.tsai@mediatek.com>, Felix Fietkau <nbd@nbd.name>, Money Wang
	<money.wang@mediatek.com>, Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH v2] wifi: cfg80211/mac80211: validate radio frequency range for monitor mode
Date: Tue, 23 Sep 2025 17:23:22 +0000
Message-ID: <700b8284e845d96654eb98431f8eeb5a81503862.1758647858.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N

In multi-radio devices, it is possible to have an MLD AP and a monitor
interface active at the same time. In such cases, monitor mode may not
be able to specify a fixed channel and could end up capturing frames
from all radios, including those outside the intended frequency bands.

This patch adds frequency validation for monitor mode. Received frames
are now only processed if their frequency fall within the allowed ranges
of the radios specified by the interface's radio_mask.

This prevents monitor mode from capturing frames outside the supported radio.

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
change since v2: fix build error
change since v1: fix email address
---
 include/net/cfg80211.h | 14 ++++++++++++
 net/mac80211/rx.c      | 49 ++++++++++++++++++++++++++++++++++++++++++
 net/wireless/util.c    |  6 +++---
 3 files changed, 66 insertions(+), 3 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 4072a67c9cc9..c6f6f9a0d97b 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -1002,6 +1002,7 @@ const struct cfg80211_chan_def *
 cfg80211_chandef_compatible(const struct cfg80211_chan_def *chandef1,
 			    const struct cfg80211_chan_def *chandef2);
 
+
 /**
  * nl80211_chan_width_to_mhz - get the channel width in MHz
  * @chan_width: the channel width from &enum nl80211_chan_width
@@ -6775,6 +6776,19 @@ static inline bool cfg80211_channel_is_psc(struct ieee80211_channel *chan)
 	return ieee80211_frequency_to_channel(chan->center_freq) % 16 == 5;
 }
 
+/**
+ * ieee80211_radio_freq_range_valid - Check if the radio supports the
+ * specified frequency range
+ *
+ * @radio: wiphy radio
+ * @freq: the frequency (in KHz) to be queried
+ * @width: the bandwidth (in KHz) to be queried
+ *
+ * Return: whether or not the given frequency range is valid for the given radio
+ */
+bool ieee80211_radio_freq_range_valid(const struct wiphy_radio *radio,
+				      u32 freq, u32 width);
+
 /**
  * cfg80211_radio_chandef_valid - Check if the radio supports the chandef
  *
diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index 4d4ff4d4917a..f91c2e00abb2 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -763,6 +763,51 @@ ieee80211_make_monitor_skb(struct ieee80211_local *local,
 	return skb;
 }
 
+static bool
+ieee80211_validate_monitor_radio(struct ieee80211_sub_if_data *sdata,
+				 struct ieee80211_local *local,
+				 struct ieee80211_rx_status *status)
+{
+	struct wiphy *wiphy = local->hw.wiphy;
+	int i, freq, bw;
+
+	if (!wiphy->n_radio)
+		return true;
+
+	switch (status->bw) {
+	case RATE_INFO_BW_20:
+		bw = 20000;
+		break;
+	case RATE_INFO_BW_40:
+		bw = 40000;
+		break;
+	case RATE_INFO_BW_80:
+		bw = 80000;
+		break;
+	case RATE_INFO_BW_160:
+		bw = 160000;
+		break;
+	case RATE_INFO_BW_320:
+		bw = 320000;
+		break;
+	default:
+		return false;
+	}
+
+	freq = MHZ_TO_KHZ(status->freq);
+
+	for (i = 0; i < wiphy->n_radio; i++) {
+		if (!(sdata->wdev.radio_mask & BIT(i)))
+			continue;
+
+		if (!ieee80211_radio_freq_range_valid(&wiphy->radio[i], freq, bw))
+			continue;
+
+		return true;
+	}
+	return false;
+}
+
 /*
  * This function copies a received frame to all monitor interfaces and
  * returns a cleaned-up SKB that no longer includes the FCS nor the
@@ -855,6 +900,10 @@ ieee80211_rx_monitor(struct ieee80211_local *local, struct sk_buff *origskb,
 		    chandef->chan->center_freq != status->freq)
 			continue;
 
+		if (ieee80211_hw_check(&local->hw, NO_VIRTUAL_MONITOR) &&
+		    !ieee80211_validate_monitor_radio(sdata, local, status))
+			continue;
+
 		if (!prev_sdata) {
 			prev_sdata = sdata;
 			continue;
diff --git a/net/wireless/util.c b/net/wireless/util.c
index 55925d6f800f..e477925d35e6 100644
--- a/net/wireless/util.c
+++ b/net/wireless/util.c
@@ -2969,9 +2969,8 @@ cfg80211_get_iftype_ext_capa(struct wiphy *wiphy, enum nl80211_iftype type)
 }
 EXPORT_SYMBOL(cfg80211_get_iftype_ext_capa);
 
-static bool
-ieee80211_radio_freq_range_valid(const struct wiphy_radio *radio,
-				 u32 freq, u32 width)
+bool ieee80211_radio_freq_range_valid(const struct wiphy_radio *radio,
+				      u32 freq, u32 width)
 {
 	const struct wiphy_radio_freq_range *r;
 	int i;
@@ -2985,6 +2984,7 @@ ieee80211_radio_freq_range_valid(const struct wiphy_radio *radio,
 
 	return false;
 }
+EXPORT_SYMBOL(ieee80211_radio_freq_range_valid);
 
 bool cfg80211_radio_chandef_valid(const struct wiphy_radio *radio,
 				  const struct cfg80211_chan_def *chandef)
-- 
2.45.2


