Return-Path: <linux-wireless+bounces-25739-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54B5AB0BCFD
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Jul 2025 08:52:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79A11175BFE
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Jul 2025 06:52:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BB1821E0BA;
	Mon, 21 Jul 2025 06:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="hEFs2fH8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 084111FBEBD
	for <linux-wireless@vger.kernel.org>; Mon, 21 Jul 2025 06:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753080735; cv=none; b=Y/a28BZDXZrhkEfhgolRedeX6XQMarlAEjGL8g6zZ8z4TVgS1l6600SQwpt3+y8FbbBsZiY65QMkzm3nfO/MI2JvDl098PPCDNfg5bvST6BtIivU93TfvsMXmnSMufL2pW5gYlK1zbppd1T+gzX/l2JwqhwBLt6f7F39zRD7xj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753080735; c=relaxed/simple;
	bh=6Kw4sRprm09eOvSpZ0K6aWkjfGPvMZb2JFpTuSw9YBc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uv8ALzORNbYhQlsdNenDsCiW73d/8Scg8ScKAqQoUFiZb4KVhaGI41o7gP9pEqzhlTfyaCPmtGm5l61XJ3t8GfZWsl59YTzcIJYRjIrGGRw35imkmg50ZP+ph2Ve8byyldW2c2TdH9PJIud2lL4X9QVlik7mLOYzq6hYGbe8j3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=hEFs2fH8; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 35c94b0e65ff11f0b33aeb1e7f16c2b6-20250721
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=T886H/dnZdUeqCXioJKPFF7Rj/tJtdjMOt5YLUblaQc=;
	b=hEFs2fH8FomEC3A8rqgqsOiMs5oRWSaZFgUWItNNzoTuuGjD9f/ZEIw3QkejrnsXi1rcg2EhdKEvgesR8EjqCY8p91Wix0ZEEoLzvkhGwotdVNFYE+dwbM73a9FNpcmP3Hmgq/nMIswpbnQshyR42oo8++KxlfFlOPODvtfnmmM=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.2,REQID:8d2ba401-9b20-4072-a008-f75ce9f941fa,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:9eb4ff7,CLOUDID:0424a984-a7ec-4748-8ac1-dca5703e241f,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|50,EDM:-3,IP:ni
	l,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 35c94b0e65ff11f0b33aeb1e7f16c2b6-20250721
Received: from mtkmbs09n1.mediatek.inc [(172.21.101.35)] by mailgw02.mediatek.com
	(envelope-from <michael-cy.lee@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 366519228; Mon, 21 Jul 2025 14:52:04 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Mon, 21 Jul 2025 14:52:01 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Mon, 21 Jul 2025 14:52:01 +0800
From: Michael-CY Lee <michael-cy.lee@mediatek.com>
To: Johannes Berg <johannes@sipsolutions.net>
CC: linux-wireless <linux-wireless@vger.kernel.org>, Felix Fietkau
	<nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>, Evelyn Tsai
	<evelyn.tsai@mediatek.com>, Money Wang <money.wang@mediatek.com>,
	linux-mediatek <linux-mediatek@lists.infradead.org>, Michael-CY Lee
	<michael-cy.lee@mediatek.com>
Subject: [PATCH] wifi: mac80211: report "link_id" to upper layer when receiving unexpected frame
Date: Mon, 21 Jul 2025 14:51:59 +0800
Message-ID: <20250721065159.1740992-1-michael-cy.lee@mediatek.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK: N

The upper layer may require the "link_id" to properly handle
unexpected frames. For instance, if hostap, operating as an
AP MLD, receives a data frame from a non-associated STA,
it must send deauthentication to the link on which the STA is
operating.

Signed-off-by: Michael-CY Lee <michael-cy.lee@mediatek.com>
Reviewed-by: Money Wang <money.wang@mediatek.com>
---
 include/net/cfg80211.h | 10 ++++++----
 net/mac80211/rx.c      | 10 +++++-----
 net/wireless/nl80211.c | 22 ++++++++++++----------
 net/wireless/trace.h   | 17 ++++++++++-------
 4 files changed, 33 insertions(+), 26 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 44a1055a81ba..406626ff6cc8 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -9048,6 +9048,7 @@ void cfg80211_pmksa_candidate_notify(struct net_device *dev, int index,
 /**
  * cfg80211_rx_spurious_frame - inform userspace about a spurious frame
  * @dev: The device the frame matched to
+ * @link_id: the link the frame was received on, -1 if not applicable or unknown
  * @addr: the transmitter address
  * @gfp: context flags
  *
@@ -9057,13 +9058,14 @@ void cfg80211_pmksa_candidate_notify(struct net_device *dev, int index,
  * Return: %true if the frame was passed to userspace (or this failed
  * for a reason other than not having a subscription.)
  */
-bool cfg80211_rx_spurious_frame(struct net_device *dev,
-				const u8 *addr, gfp_t gfp);
+bool cfg80211_rx_spurious_frame(struct net_device *dev, const u8 *addr,
+				int link_id, gfp_t gfp);
 
 /**
  * cfg80211_rx_unexpected_4addr_frame - inform about unexpected WDS frame
  * @dev: The device the frame matched to
  * @addr: the transmitter address
+ * @link_id: the link the frame was received on, -1 if not applicable or unknown
  * @gfp: context flags
  *
  * This function is used in AP mode (only!) to inform userspace that
@@ -9073,8 +9075,8 @@ bool cfg80211_rx_spurious_frame(struct net_device *dev,
  * Return: %true if the frame was passed to userspace (or this failed
  * for a reason other than not having a subscription.)
  */
-bool cfg80211_rx_unexpected_4addr_frame(struct net_device *dev,
-					const u8 *addr, gfp_t gfp);
+bool cfg80211_rx_unexpected_4addr_frame(struct net_device *dev, const u8 *addr,
+					int link_id, gfp_t gfp);
 
 /**
  * cfg80211_probe_status - notify userspace about probe status
diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index 2ac8ccb838ff..1e2b6336f443 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -1532,9 +1532,8 @@ ieee80211_rx_h_check(struct ieee80211_rx_data *rx)
 		}
 
 		if (rx->sdata->vif.type == NL80211_IFTYPE_AP &&
-		    cfg80211_rx_spurious_frame(rx->sdata->dev,
-					       hdr->addr2,
-					       GFP_ATOMIC))
+		    cfg80211_rx_spurious_frame(rx->sdata->dev, hdr->addr2,
+					       rx->link_id, GFP_ATOMIC))
 			return RX_DROP_U_SPURIOUS;
 
 		return RX_DROP;
@@ -1872,7 +1871,7 @@ ieee80211_rx_h_sta_process(struct ieee80211_rx_data *rx)
 			if (!test_and_set_sta_flag(sta, WLAN_STA_4ADDR_EVENT))
 				cfg80211_rx_unexpected_4addr_frame(
 					rx->sdata->dev, sta->sta.addr,
-					GFP_ATOMIC);
+					rx->link_id, GFP_ATOMIC);
 			return RX_DROP_U_UNEXPECTED_4ADDR_FRAME;
 		}
 		/*
@@ -3191,7 +3190,8 @@ ieee80211_rx_h_data(struct ieee80211_rx_data *rx)
 		if (rx->sta &&
 		    !test_and_set_sta_flag(rx->sta, WLAN_STA_4ADDR_EVENT))
 			cfg80211_rx_unexpected_4addr_frame(
-				rx->sdata->dev, rx->sta->sta.addr, GFP_ATOMIC);
+				rx->sdata->dev, rx->sta->sta.addr, rx->link_id,
+				GFP_ATOMIC);
 		return RX_DROP;
 	}
 
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 1c808b08b747..b4bf44768dc8 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -19755,7 +19755,7 @@ void cfg80211_conn_failed(struct net_device *dev, const u8 *mac_addr,
 EXPORT_SYMBOL(cfg80211_conn_failed);
 
 static bool __nl80211_unexpected_frame(struct net_device *dev, u8 cmd,
-				       const u8 *addr, gfp_t gfp)
+				       const u8 *addr, int link_id, gfp_t gfp)
 {
 	struct wireless_dev *wdev = dev->ieee80211_ptr;
 	struct cfg80211_registered_device *rdev = wiphy_to_rdev(wdev->wiphy);
@@ -19778,7 +19778,9 @@ static bool __nl80211_unexpected_frame(struct net_device *dev, u8 cmd,
 
 	if (nla_put_u32(msg, NL80211_ATTR_WIPHY, rdev->wiphy_idx) ||
 	    nla_put_u32(msg, NL80211_ATTR_IFINDEX, dev->ifindex) ||
-	    nla_put(msg, NL80211_ATTR_MAC, ETH_ALEN, addr))
+	    nla_put(msg, NL80211_ATTR_MAC, ETH_ALEN, addr) ||
+	    (link_id >= 0 &&
+	     nla_put_u8(msg, NL80211_ATTR_MLO_LINK_ID, link_id)))
 		goto nla_put_failure;
 
 	genlmsg_end(msg, hdr);
@@ -19790,13 +19792,13 @@ static bool __nl80211_unexpected_frame(struct net_device *dev, u8 cmd,
 	return true;
 }
 
-bool cfg80211_rx_spurious_frame(struct net_device *dev,
-				const u8 *addr, gfp_t gfp)
+bool cfg80211_rx_spurious_frame(struct net_device *dev, const u8 *addr,
+				int link_id, gfp_t gfp)
 {
 	struct wireless_dev *wdev = dev->ieee80211_ptr;
 	bool ret;
 
-	trace_cfg80211_rx_spurious_frame(dev, addr);
+	trace_cfg80211_rx_spurious_frame(dev, addr, link_id);
 
 	if (WARN_ON(wdev->iftype != NL80211_IFTYPE_AP &&
 		    wdev->iftype != NL80211_IFTYPE_P2P_GO)) {
@@ -19804,19 +19806,19 @@ bool cfg80211_rx_spurious_frame(struct net_device *dev,
 		return false;
 	}
 	ret = __nl80211_unexpected_frame(dev, NL80211_CMD_UNEXPECTED_FRAME,
-					 addr, gfp);
+					 addr, link_id, gfp);
 	trace_cfg80211_return_bool(ret);
 	return ret;
 }
 EXPORT_SYMBOL(cfg80211_rx_spurious_frame);
 
-bool cfg80211_rx_unexpected_4addr_frame(struct net_device *dev,
-					const u8 *addr, gfp_t gfp)
+bool cfg80211_rx_unexpected_4addr_frame(struct net_device *dev, const u8 *addr,
+					int link_id, gfp_t gfp)
 {
 	struct wireless_dev *wdev = dev->ieee80211_ptr;
 	bool ret;
 
-	trace_cfg80211_rx_unexpected_4addr_frame(dev, addr);
+	trace_cfg80211_rx_unexpected_4addr_frame(dev, addr, link_id);
 
 	if (WARN_ON(wdev->iftype != NL80211_IFTYPE_AP &&
 		    wdev->iftype != NL80211_IFTYPE_P2P_GO &&
@@ -19826,7 +19828,7 @@ bool cfg80211_rx_unexpected_4addr_frame(struct net_device *dev,
 	}
 	ret = __nl80211_unexpected_frame(dev,
 					 NL80211_CMD_UNEXPECTED_4ADDR_FRAME,
-					 addr, gfp);
+					 addr, link_id, gfp);
 	trace_cfg80211_return_bool(ret);
 	return ret;
 }
diff --git a/net/wireless/trace.h b/net/wireless/trace.h
index a07d88d61bec..34c584a215e5 100644
--- a/net/wireless/trace.h
+++ b/net/wireless/trace.h
@@ -3570,27 +3570,30 @@ TRACE_EVENT(cfg80211_cac_event,
 );
 
 DECLARE_EVENT_CLASS(cfg80211_rx_evt,
-	TP_PROTO(struct net_device *netdev, const u8 *addr),
-	TP_ARGS(netdev, addr),
+	TP_PROTO(struct net_device *netdev, const u8 *addr, int link_id),
+	TP_ARGS(netdev, addr, link_id),
 	TP_STRUCT__entry(
 		NETDEV_ENTRY
 		MAC_ENTRY(addr)
+		__field(int, link_id)
 	),
 	TP_fast_assign(
 		NETDEV_ASSIGN;
 		MAC_ASSIGN(addr, addr);
+		__entry->link_id = link_id;
 	),
-	TP_printk(NETDEV_PR_FMT ", %pM", NETDEV_PR_ARG, __entry->addr)
+	TP_printk(NETDEV_PR_FMT ", %pM, link_id:%d", NETDEV_PR_ARG,
+		  __entry->addr, __entry->link_id)
 );
 
 DEFINE_EVENT(cfg80211_rx_evt, cfg80211_rx_spurious_frame,
-	TP_PROTO(struct net_device *netdev, const u8 *addr),
-	TP_ARGS(netdev, addr)
+	TP_PROTO(struct net_device *netdev, const u8 *addr, int link_id),
+	TP_ARGS(netdev, addr, link_id)
 );
 
 DEFINE_EVENT(cfg80211_rx_evt, cfg80211_rx_unexpected_4addr_frame,
-	TP_PROTO(struct net_device *netdev, const u8 *addr),
-	TP_ARGS(netdev, addr)
+	TP_PROTO(struct net_device *netdev, const u8 *addr, int link_id),
+	TP_ARGS(netdev, addr, link_id)
 );
 
 TRACE_EVENT(cfg80211_ibss_joined,
-- 
2.25.1


