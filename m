Return-Path: <linux-wireless+bounces-38028-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id VA+WA9dJO2piVggAu9opvQ
	(envelope-from <linux-wireless+bounces-38028-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Jun 2026 05:07:03 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DB13F6BB066
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Jun 2026 05:07:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=mediatek.com header.s=dk header.b=RMq5bKH7;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38028-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38028-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=mediatek.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 52DB130A78B3
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Jun 2026 03:05:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 574F530568F;
	Wed, 24 Jun 2026 03:05:55 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A45372EEE9E
	for <linux-wireless@vger.kernel.org>; Wed, 24 Jun 2026 03:05:52 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782270355; cv=none; b=pA73fsvb4QGzMVhaQuGeLQnO5+r4NSKBGAmsYOOGE3pgdpir+jg3yS9Nw2V3xD7WfbAknWhaivcgxxDIc6vuZJ1uE5ecP7Ah/daq4BIWEfMAg4thgZKEvSLuaWLjwb6JVW7PAN5BU3z+irv2dBxO5YueAsg6NgljHJ93uOf4noI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782270355; c=relaxed/simple;
	bh=yklzPpBnEGLl9MOs8d6uAhHYK0T1lxAMcDlCJtu5fUI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=N0YFcUFPjzwcgchnBcmDNqQ3fok4kP2agkimgD3wfL/EQ8F2gjWfoiRgWE569E6YeSd0yPhqNEe68WBSU/IV5ZDhpORmUYFmSOBl881pkw/TmXIH5/LoysBn+QWulSQQ+bnY0l9h6Pd+9V2outP3souVSPMYm+HQVCVivg58MjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=RMq5bKH7; arc=none smtp.client-ip=210.61.82.184
X-UUID: 96919ea86f7911f18dc8c9802ae25ab1-20260624
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=2eZ75O7x3e8enqehiGd6zaRF5hMlFKzbSAUTfVWZPS0=;
	b=RMq5bKH73vlxy+mxM475ghj3XMcz1DuouaDwnWSmilw3Uq7OqChFA4d/t2//xxZxzuH0STAW/pJVhj7CEoYRV4CqTIje4/roJ2nF/4S5sC89Fzp3RSn/pCq3r1FbzrmcwtmLHwsYLBjA8r6VvkiR7tKknx7BgwD1DUukru2enhg=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.17,REQID:e8dedd6f-6d14-488a-a408-9f9393b9f487,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:d497b38,CLOUDID:8d415428-5828-476d-aebd-a08d0b641e9a,B
	ulkID:nil,BulkQuantity:0,SF:102|836|865|888|898,TC:-5,Content:0|15|50,EDM:
	-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1,COL:0,OSI:0,OSA:0,AV:
	0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 96919ea86f7911f18dc8c9802ae25ab1-20260624
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
	(envelope-from <eason.lai@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 192216690; Wed, 24 Jun 2026 11:05:43 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 24 Jun 2026 11:05:42 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Wed, 24 Jun 2026 11:05:42 +0800
From: Eason Lai <eason.lai@mediatek.com>
To: <nbd@nbd.name>, <lorenzo@kernel.org>
CC: <linux-wireless@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
	<Yf.Luo@mediatek.com>, <kun.wu@mediatek.com>, <deren.wu@mediatek.com>,
	<sean.wang@mediatek.com>, <quan.zhou@mediatek.com>, <ryder.lee@mediatek.com>,
	<leon.yen@mediatek.com>, <litien.chang@mediatek.com>, <jb.tsai@mediatek.com>,
	<eason.lai@mediatek.com>, Eason Lai <Eason.Lai@mediatek.com>
Subject: [PATCH v4 1/1] wifi: mt76: mt792x: fix use-after-free in mt76_rx_poll_complete
Date: Wed, 24 Jun 2026 11:05:11 +0800
Message-ID: <20260624030511.1197942-1-eason.lai@mediatek.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[mediatek.com,quarantine];
	R_DKIM_ALLOW(-0.20)[mediatek.com:s=dk];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_FROM(0.00)[bounces-38028-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[eason.lai@mediatek.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:nbd@nbd.name,m:lorenzo@kernel.org,m:linux-wireless@vger.kernel.org,m:linux-mediatek@lists.infradead.org,m:Yf.Luo@mediatek.com,m:kun.wu@mediatek.com,m:deren.wu@mediatek.com,m:sean.wang@mediatek.com,m:quan.zhou@mediatek.com,m:ryder.lee@mediatek.com,m:leon.yen@mediatek.com,m:litien.chang@mediatek.com,m:jb.tsai@mediatek.com,m:eason.lai@mediatek.com,m:Eason.Lai@mediatek.com,s:lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[eason.lai@mediatek.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[mediatek.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mediatek.com:dkim,mediatek.com:email,mediatek.com:mid,mediatek.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DB13F6BB066

From: Eason Lai <Eason.Lai@mediatek.com>

A use-after-free issue occurs in mt76_rx_poll_complete due to a race
condition. The STA has already been removed, but the rx_status still
had a pointer to the wcid in the STA.

Set the links' wcid pointers to be NULL for a MLD in
mt7925_sta_pre_rcu_remove()

BUG: KASAN: invalid-access in mt76_rx_poll_complete+0x280/0x470
Call trace:
dump_backtrace+0xec/0x128
show_stack+0x18/0x28
dump_stack_lvl+0x40/0xc8
print_report+0x1b8/0x710
kasan_report+0xe0/0x144
do_bad_area+0x120/0x260
do_tag_check_fault+0x20/0x34
do_mem_abort+0x54/0xa8
el1_abort+0x3c/0x5c
el1h_64_sync_handler+0x40/0xcc
el1h_64_sync+0x7c/0x80
mt76_rx_poll_complete+0x280/0x470
mt76_dma_rx_poll+0x114/0x51c
mt792x_poll_rx+0x60/0xf8
napi_threaded_poll_loop+0xe0/0x450
napi_threaded_poll+0x80/0x9c
kthread+0x11c/0x158
ret_from_fork+0x10/0x20

Fixes: c948b5da6bbe ("wifi: mt76: mt7925: add Mediatek Wi-Fi7 driver for
mt7925 chips")

Signed-off-by: Eason Lai <Eason.Lai@mediatek.com>
---
v2: fix mt76x02 build errors
v3: fix mt76x02 build error due to variable set but not used
v4: fix use-after-free in MLO
---
 .../net/wireless/mediatek/mt76/mt7925/main.c  | 36 ++++++++++++++++++-
 1 file changed, 35 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/main.c b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
index 73d3722739d0..e3fb6392eda2 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
@@ -2410,6 +2410,40 @@ static void mt7925_channel_switch_rx_beacon(struct ieee80211_hw *hw,
 	}
 }
 
+static void mt7925_sta_pre_rcu_remove(struct ieee80211_hw *hw,
+				      struct ieee80211_vif *vif,
+				      struct ieee80211_sta *sta)
+{
+	struct mt76_phy *phy = hw->priv;
+	struct mt76_dev *dev = phy->dev;
+	struct mt76_wcid *wcid = (struct mt76_wcid *)sta->drv_priv;
+
+	mutex_lock(&dev->mutex);
+	spin_lock_bh(&dev->status_lock);
+
+	if (ieee80211_vif_is_mld(vif)) {
+		struct mt792x_sta *msta = (struct mt792x_sta *)sta->drv_priv;
+		struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
+		unsigned long valid = mvif->valid_links;
+		struct mt792x_link_sta *mlink;
+		unsigned int link_id;
+
+		for_each_set_bit(link_id, &valid, IEEE80211_MLD_MAX_NUM_LINKS) {
+			mlink = mt792x_sta_to_link(msta, link_id);
+			if (!mlink || !mlink->wcid.sta)
+				continue;
+			if (mlink->wcid.idx < ARRAY_SIZE(dev->wcid))
+				rcu_assign_pointer(dev->wcid[mlink->wcid.idx],
+						   NULL);
+		}
+	} else {
+		rcu_assign_pointer(dev->wcid[wcid->idx], NULL);
+	}
+
+	spin_unlock_bh(&dev->status_lock);
+	mutex_unlock(&dev->mutex);
+}
+
 const struct ieee80211_ops mt7925_ops = {
 	.tx = mt792x_tx,
 	.start = mt7925_start,
@@ -2422,7 +2456,7 @@ const struct ieee80211_ops mt7925_ops = {
 	.start_ap = mt7925_start_ap,
 	.stop_ap = mt7925_stop_ap,
 	.sta_state = mt76_sta_state,
-	.sta_pre_rcu_remove = mt76_sta_pre_rcu_remove,
+	.sta_pre_rcu_remove = mt7925_sta_pre_rcu_remove,
 	.set_key = mt7925_set_key,
 	.sta_set_decap_offload = mt7925_sta_set_decap_offload,
 #if IS_ENABLED(CONFIG_IPV6)
-- 
2.45.2


