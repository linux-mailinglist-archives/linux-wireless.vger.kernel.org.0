Return-Path: <linux-wireless+bounces-35700-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SJOmFL8X82llxAEAu9opvQ
	(envelope-from <linux-wireless+bounces-35700-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Apr 2026 10:50:07 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DFF4F49F6BF
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Apr 2026 10:50:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E70D23026587
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Apr 2026 08:45:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C96934EF1F;
	Thu, 30 Apr 2026 08:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="NZ10sXno"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FCD837F8C4
	for <linux-wireless@vger.kernel.org>; Thu, 30 Apr 2026 08:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777538738; cv=none; b=aVZKBBXkCEwHxCquxhPWMs+MwWGQpqltlyvX8HeE0wHyD9ihmF0mvcEv3n5nBxZgss0Q4mDBzq87kBROjymd1eD/rA3P5Rh7CFYoz+BnkpmJXmeRUgxVjJkUSAfJvsQI2jgQ0qch6jCmoxBNR+rQLgn6LVYhbwAzCiEKcPq/OGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777538738; c=relaxed/simple;
	bh=ImdTucmipgpin3B5U4SFV0/17GrOi5S8TDphF1itgF4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=it5xvf0DicUMleAetBX1BI6QtklKF5FUhCxvSeja0Q9mZxUSBwiZWoG6wjwaJhr5Tw5MYwsiIPKb+fjhq6FD+LWQn5u8JU7UVQt8TMUbcsfC8VcQ+1AcBe32jt2x8Sm6M0B/TA1MCWHbTHBpzch/0ZZrvK70w0u15rhl5KwNPUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=NZ10sXno; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: f07eda90447011f1a4e839cc21f16abe-20260430
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=pyCpsT7b7SRb/88qFqZE5GZhX/CG9ArTIUbXpWCjZN4=;
	b=NZ10sXno07xPrGq1ya/jsmHDG3hNoFV6LXCVt9q4+LD6lDR26IpDGMzP7/8FEydgjKter/mP1a8YBaPt3rUx8PwyZqoC1S4ieWdkzutkiS+jY0e5HIleupWnIdfTmOMTBKdVRZ8Ouv7oSZBioZKltd4uaBuER2P5FMXW0Qqkvkg=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:997ecc46-6bb6-4c0a-a6ce-bce419aced9a,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e7bac3a,CLOUDID:5e80c070-3b7f-4b26-b2f9-40f0deecb36d,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102|836|865|888|898,TC:-5,Content:0|
	15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1,COL:0,OSI:0
	,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: f07eda90447011f1a4e839cc21f16abe-20260430
Received: from mtkmbs09n1.mediatek.inc [(172.21.101.35)] by mailgw02.mediatek.com
	(envelope-from <jb.tsai@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1010018236; Thu, 30 Apr 2026 16:45:28 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 30 Apr 2026 16:45:27 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Thu, 30 Apr 2026 16:45:27 +0800
From: JB Tsai <jb.tsai@mediatek.com>
To: <nbd@nbd.name>, <lorenzo@kernel.org>
CC: <linux-wireless@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
	<Deren.Wu@mediatek.com>, <Sean.Wang@mediatek.com>, <Quan.Zhou@mediatek.com>,
	<Ryder.Lee@mediatek.com>, <Leon.Yen@mediatek.com>,
	<litien.chang@mediatek.com>, <eason.lai@mediatek.com>,
	<jb.tsai@mediatek.com>, Eason Lai <Eason.Lai@mediatek.com>
Subject: [PATCH] wifi: mt76: mt792x: fix use-after-free in  mt76_rx_poll_complete
Date: Thu, 30 Apr 2026 16:45:25 +0800
Message-ID: <20260430084525.3471313-1-jb.tsai@mediatek.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-MTK: N
X-Rspamd-Queue-Id: DFF4F49F6BF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[mediatek.com,quarantine];
	R_DKIM_ALLOW(-0.20)[mediatek.com:s=dk];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35700-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[mediatek.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jb.tsai@mediatek.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mediatek.com:email,mediatek.com:dkim,mediatek.com:mid]

From: Eason Lai <Eason.Lai@mediatek.com>=0D

A use-after-free issue occurs in mt76_rx_poll_complete due to a race=0D
condition. The STA has already been removed, but the rx_status still=0D
had a pointer to the wcid in the STA.=0D
=0D
Use wcid_idx instead of storing the wcid pointer, and look up the wcid=0D
via rcu_dereference() by wcid_idx.=0D
=0D
BUG: KASAN: invalid-access in mt76_rx_poll_complete+0x280/0x470 [mt76]=0D
Call trace:=0D
dump_backtrace+0xec/0x128=0D
show_stack+0x18/0x28=0D
dump_stack_lvl+0x40/0xc8=0D
print_report+0x1b8/0x710=0D
kasan_report+0xe0/0x144=0D
do_bad_area+0x120/0x260=0D
do_tag_check_fault+0x20/0x34=0D
do_mem_abort+0x54/0xa8=0D
el1_abort+0x3c/0x5c=0D
el1h_64_sync_handler+0x40/0xcc=0D
el1h_64_sync+0x7c/0x80=0D
mt76_rx_poll_complete+0x280/0x470=0D
mt76_dma_rx_poll+0x114/0x51c=0D
mt792x_poll_rx+0x60/0xf8=0D
napi_threaded_poll_loop+0xe0/0x450=0D
napi_threaded_poll+0x80/0x9c=0D
kthread+0x11c/0x158=0D
ret_from_fork+0x10/0x20=0D
=0D
Signed-off-by: Eason Lai <Eason.Lai@mediatek.com>=0D
---=0D
 drivers/net/wireless/mediatek/mt76/agg-rx.c   | 18 ++++---=0D
 drivers/net/wireless/mediatek/mt76/mac80211.c | 47 ++++++++-----------=0D
 drivers/net/wireless/mediatek/mt76/mt76.h     |  7 ++-=0D
 .../net/wireless/mediatek/mt76/mt7603/mac.c   |  6 ++-=0D
 .../net/wireless/mediatek/mt76/mt7615/mac.c   | 19 +++++---=0D
 .../net/wireless/mediatek/mt76/mt76_connac.h  |  3 +-=0D
 .../wireless/mediatek/mt76/mt76_connac_mac.c  | 12 ++++-=0D
 .../net/wireless/mediatek/mt76/mt7915/mac.c   | 16 +++++--=0D
 .../net/wireless/mediatek/mt76/mt7921/mac.c   | 13 +++--=0D
 .../net/wireless/mediatek/mt76/mt7925/mac.c   | 19 +++++---=0D
 .../net/wireless/mediatek/mt76/mt7996/mac.c   | 29 ++++++++----=0D
 11 files changed, 114 insertions(+), 75 deletions(-)=0D
=0D
diff --git a/drivers/net/wireless/mediatek/mt76/agg-rx.c b/drivers/net/wire=
less/mediatek/mt76/agg-rx.c=0D
index bf1babac3895..b72d13975466 100644=0D
--- a/drivers/net/wireless/mediatek/mt76/agg-rx.c=0D
+++ b/drivers/net/wireless/mediatek/mt76/agg-rx.c=0D
@@ -116,14 +116,15 @@ mt76_rx_aggr_reorder_work(struct work_struct *work)=0D
 }=0D
 =0D
 static void=0D
-mt76_rx_aggr_check_ctl(struct sk_buff *skb, struct sk_buff_head *frames)=0D
+mt76_rx_aggr_check_ctl(struct mt76_dev *dev, struct sk_buff *skb,=0D
+		       struct sk_buff_head *frames)=0D
 {=0D
 	struct mt76_rx_status *status =3D (struct mt76_rx_status *)skb->cb;=0D
 	struct ieee80211_bar *bar =3D mt76_skb_get_hdr(skb);=0D
-	struct mt76_wcid *wcid =3D status->wcid;=0D
 	struct mt76_rx_tid *tid;=0D
-	u8 tidno;=0D
+	struct mt76_wcid *wcid;=0D
 	u16 seqno;=0D
+	u8 tidno;=0D
 =0D
 	if (!ieee80211_is_ctl(bar->frame_control))=0D
 		return;=0D
@@ -131,6 +132,10 @@ mt76_rx_aggr_check_ctl(struct sk_buff *skb, struct sk_=
buff_head *frames)=0D
 	if (!ieee80211_is_back_req(bar->frame_control))=0D
 		return;=0D
 =0D
+	wcid =3D __mt76_wcid_ptr(dev, status->wcid_idx);=0D
+	if (!wcid)=0D
+		return;=0D
+=0D
 	status->qos_ctl =3D tidno =3D le16_to_cpu(bar->control) >> 12;=0D
 	seqno =3D IEEE80211_SEQ_TO_SN(le16_to_cpu(bar->start_seq_num));=0D
 	tid =3D rcu_dereference(wcid->aggr[tidno]);=0D
@@ -145,10 +150,11 @@ mt76_rx_aggr_check_ctl(struct sk_buff *skb, struct sk=
_buff_head *frames)=0D
 	spin_unlock_bh(&tid->lock);=0D
 }=0D
 =0D
-void mt76_rx_aggr_reorder(struct sk_buff *skb, struct sk_buff_head *frames=
)=0D
+void mt76_rx_aggr_reorder(struct mt76_dev *dev, struct sk_buff *skb,=0D
+			  struct sk_buff_head *frames)=0D
 {=0D
 	struct mt76_rx_status *status =3D (struct mt76_rx_status *)skb->cb;=0D
-	struct mt76_wcid *wcid =3D status->wcid;=0D
+	struct mt76_wcid *wcid =3D __mt76_wcid_ptr(dev, status->wcid_idx);=0D
 	struct ieee80211_sta *sta;=0D
 	struct mt76_rx_tid *tid;=0D
 	bool sn_less;=0D
@@ -164,7 +170,7 @@ void mt76_rx_aggr_reorder(struct sk_buff *skb, struct s=
k_buff_head *frames)=0D
 =0D
 	if (!status->aggr) {=0D
 		if (!(status->flag & RX_FLAG_8023))=0D
-			mt76_rx_aggr_check_ctl(skb, frames);=0D
+			mt76_rx_aggr_check_ctl(dev, skb, frames);=0D
 		return;=0D
 	}=0D
 =0D
diff --git a/drivers/net/wireless/mediatek/mt76/mac80211.c b/drivers/net/wi=
reless/mediatek/mt76/mac80211.c=0D
index 4ae5e4715a9c..2933b29782d3 100644=0D
--- a/drivers/net/wireless/mediatek/mt76/mac80211.c=0D
+++ b/drivers/net/wireless/mediatek/mt76/mac80211.c=0D
@@ -1283,21 +1283,24 @@ mt76_rx_convert(struct mt76_dev *dev, struct sk_buf=
f *skb,=0D
 	memcpy(status->chain_signal, mstat.chain_signal,=0D
 	       sizeof(mstat.chain_signal));=0D
 =0D
-	if (mstat.wcid) {=0D
-		status->link_valid =3D mstat.wcid->link_valid;=0D
-		status->link_id =3D mstat.wcid->link_id;=0D
-	}=0D
+	if (mstat.wcid_idx !=3D MT76_WCID_IDX_INVALID) {=0D
+		struct mt76_wcid *wcid =3D __mt76_wcid_ptr(dev, mstat.wcid_idx);=0D
 =0D
-	*sta =3D wcid_to_sta(mstat.wcid);=0D
+		if (wcid) {=0D
+			status->link_valid =3D wcid->link_valid;=0D
+			status->link_id =3D wcid->link_id;=0D
+			*sta =3D wcid_to_sta(wcid);=0D
+		}=0D
+	}=0D
 	*hw =3D mt76_phy_hw(dev, mstat.phy_idx);=0D
 }=0D
 =0D
 static void=0D
-mt76_check_ccmp_pn(struct sk_buff *skb)=0D
+mt76_check_ccmp_pn(struct mt76_dev *dev, struct sk_buff *skb)=0D
 {=0D
 	struct mt76_rx_status *status =3D (struct mt76_rx_status *)skb->cb;=0D
-	struct mt76_wcid *wcid =3D status->wcid;=0D
 	struct ieee80211_hdr *hdr;=0D
+	struct mt76_wcid *wcid;=0D
 	int security_idx;=0D
 	int ret;=0D
 =0D
@@ -1307,6 +1310,7 @@ mt76_check_ccmp_pn(struct sk_buff *skb)=0D
 	if (status->flag & RX_FLAG_ONLY_MONITOR)=0D
 		return;=0D
 =0D
+	wcid =3D __mt76_wcid_ptr(dev, status->wcid_idx);=0D
 	if (!wcid || !wcid->rx_check_pn)=0D
 		return;=0D
 =0D
@@ -1354,7 +1358,7 @@ static void=0D
 mt76_airtime_report(struct mt76_dev *dev, struct mt76_rx_status *status,=0D
 		    int len)=0D
 {=0D
-	struct mt76_wcid *wcid =3D status->wcid;=0D
+	struct mt76_wcid *wcid =3D __mt76_wcid_ptr(dev, status->wcid_idx);=0D
 	struct ieee80211_rx_status info =3D {=0D
 		.enc_flags =3D status->enc_flags,=0D
 		.rate_idx =3D status->rate_idx,=0D
@@ -1382,19 +1386,9 @@ mt76_airtime_report(struct mt76_dev *dev, struct mt7=
6_rx_status *status,=0D
 static void=0D
 mt76_airtime_flush_ampdu(struct mt76_dev *dev)=0D
 {=0D
-	struct mt76_wcid *wcid;=0D
-	int wcid_idx;=0D
-=0D
 	if (!dev->rx_ampdu_len)=0D
 		return;=0D
 =0D
-	wcid_idx =3D dev->rx_ampdu_status.wcid_idx;=0D
-	if (wcid_idx < ARRAY_SIZE(dev->wcid))=0D
-		wcid =3D rcu_dereference(dev->wcid[wcid_idx]);=0D
-	else=0D
-		wcid =3D NULL;=0D
-	dev->rx_ampdu_status.wcid =3D wcid;=0D
-=0D
 	mt76_airtime_report(dev, &dev->rx_ampdu_status, dev->rx_ampdu_len);=0D
 =0D
 	dev->rx_ampdu_len =3D 0;=0D
@@ -1405,7 +1399,7 @@ static void=0D
 mt76_airtime_check(struct mt76_dev *dev, struct sk_buff *skb)=0D
 {=0D
 	struct mt76_rx_status *status =3D (struct mt76_rx_status *)skb->cb;=0D
-	struct mt76_wcid *wcid =3D status->wcid;=0D
+	struct mt76_wcid *wcid =3D __mt76_wcid_ptr(dev, status->wcid_idx);=0D
 =0D
 	if (!(dev->drv->drv_flags & MT_DRV_SW_RX_AIRTIME))=0D
 		return;=0D
@@ -1418,8 +1412,6 @@ mt76_airtime_check(struct mt76_dev *dev, struct sk_bu=
ff *skb)=0D
 =0D
 		if (!ether_addr_equal(hdr->addr1, dev->phy.macaddr))=0D
 			return;=0D
-=0D
-		wcid =3D NULL;=0D
 	}=0D
 =0D
 	if (!(status->flag & RX_FLAG_AMPDU_DETAILS) ||=0D
@@ -1430,7 +1422,6 @@ mt76_airtime_check(struct mt76_dev *dev, struct sk_bu=
ff *skb)=0D
 		if (!dev->rx_ampdu_len ||=0D
 		    status->ampdu_ref !=3D dev->rx_ampdu_ref) {=0D
 			dev->rx_ampdu_status =3D *status;=0D
-			dev->rx_ampdu_status.wcid_idx =3D wcid ? wcid->idx : 0xff;=0D
 			dev->rx_ampdu_ref =3D status->ampdu_ref;=0D
 		}=0D
 =0D
@@ -1448,7 +1439,7 @@ mt76_check_sta(struct mt76_dev *dev, struct sk_buff *=
skb)=0D
 	struct ieee80211_hdr *hdr =3D mt76_skb_get_hdr(skb);=0D
 	struct ieee80211_sta *sta;=0D
 	struct ieee80211_hw *hw;=0D
-	struct mt76_wcid *wcid =3D status->wcid;=0D
+	struct mt76_wcid *wcid =3D __mt76_wcid_ptr(dev, status->wcid_idx);=0D
 	u8 tidno =3D status->qos_ctl & IEEE80211_QOS_CTL_TID_MASK;=0D
 	bool ps;=0D
 =0D
@@ -1456,8 +1447,10 @@ mt76_check_sta(struct mt76_dev *dev, struct sk_buff =
*skb)=0D
 	if (ieee80211_is_pspoll(hdr->frame_control) && !wcid &&=0D
 	    !(status->flag & RX_FLAG_8023)) {=0D
 		sta =3D ieee80211_find_sta_by_ifaddr(hw, hdr->addr2, NULL);=0D
-		if (sta)=0D
-			wcid =3D status->wcid =3D (struct mt76_wcid *)sta->drv_priv;=0D
+		if (sta) {=0D
+			wcid =3D (struct mt76_wcid *)sta->drv_priv;=0D
+			status->wcid_idx =3D wcid->idx;=0D
+		}=0D
 	}=0D
 =0D
 	mt76_airtime_check(dev, skb);=0D
@@ -1521,7 +1514,7 @@ void mt76_rx_complete(struct mt76_dev *dev, struct sk=
_buff_head *frames,=0D
 	while ((skb =3D __skb_dequeue(frames)) !=3D NULL) {=0D
 		struct sk_buff *nskb =3D skb_shinfo(skb)->frag_list;=0D
 =0D
-		mt76_check_ccmp_pn(skb);=0D
+		mt76_check_ccmp_pn(dev, skb);=0D
 		skb_shinfo(skb)->frag_list =3D NULL;=0D
 		mt76_rx_convert(dev, skb, &hw, &sta);=0D
 		ieee80211_rx_list(hw, sta, skb, &list);=0D
@@ -1563,7 +1556,7 @@ void mt76_rx_poll_complete(struct mt76_dev *dev, enum=
 mt76_rxq_id q,=0D
 		    mt76_npu_device_active(dev))=0D
 			__skb_queue_tail(&frames, skb);=0D
 		else=0D
-			mt76_rx_aggr_reorder(skb, &frames);=0D
+			mt76_rx_aggr_reorder(dev, skb, &frames);=0D
 	}=0D
 =0D
 	mt76_rx_complete(dev, &frames, napi);=0D
diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wirele=
ss/mediatek/mt76/mt76.h=0D
index 527bef97e122..fd449298fb11 100644=0D
--- a/drivers/net/wireless/mediatek/mt76/mt76.h=0D
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h=0D
@@ -364,6 +364,7 @@ enum mt76_wcid_flags {=0D
 };=0D
 =0D
 #define MT76_N_WCIDS 1088=0D
+#define MT76_WCID_IDX_INVALID		0xffff=0D
 #define MT76_BEACON_MON_MAX_MISS	7=0D
 =0D
 /* stored in ieee80211_tx_info::hw_queue */=0D
@@ -728,10 +729,7 @@ struct mt76_mmio {=0D
 };=0D
 =0D
 struct mt76_rx_status {=0D
-	union {=0D
-		struct mt76_wcid *wcid;=0D
 		u16 wcid_idx;=0D
-	};=0D
 =0D
 	u32 reorder_time;=0D
 =0D
@@ -1793,7 +1791,8 @@ void mt76_rx_complete(struct mt76_dev *dev, struct sk=
_buff_head *frames,=0D
 		      struct napi_struct *napi);=0D
 void mt76_rx_poll_complete(struct mt76_dev *dev, enum mt76_rxq_id q,=0D
 			   struct napi_struct *napi);=0D
-void mt76_rx_aggr_reorder(struct sk_buff *skb, struct sk_buff_head *frames=
);=0D
+void mt76_rx_aggr_reorder(struct mt76_dev *dev, struct sk_buff *skb,=0D
+			  struct sk_buff_head *frames);=0D
 void mt76_testmode_tx_pending(struct mt76_phy *phy);=0D
 void mt76_queue_tx_complete(struct mt76_dev *dev, struct mt76_queue *q,=0D
 			    struct mt76_queue_entry *e);=0D
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/mac.c b/drivers/net/=
wireless/mediatek/mt76/mt7603/mac.c=0D
index d3110eeb45d7..aeb890df808e 100644=0D
--- a/drivers/net/wireless/mediatek/mt76/mt7603/mac.c=0D
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/mac.c=0D
@@ -513,6 +513,7 @@ mt7603_mac_fill_rx(struct mt7603_dev *dev, struct sk_bu=
ff *skb)=0D
 	u32 rxd2 =3D le32_to_cpu(rxd[2]);=0D
 	bool unicast =3D rxd1 & MT_RXD1_NORMAL_U2M;=0D
 	bool insert_ccmp_hdr =3D false;=0D
+	struct mt76_wcid *wcid;=0D
 	bool remove_pad;=0D
 	int idx;=0D
 	int i;=0D
@@ -524,7 +525,8 @@ mt7603_mac_fill_rx(struct mt7603_dev *dev, struct sk_bu=
ff *skb)=0D
 	i >>=3D 1;=0D
 =0D
 	idx =3D FIELD_GET(MT_RXD2_NORMAL_WLAN_IDX, rxd2);=0D
-	status->wcid =3D mt7603_rx_get_wcid(dev, idx, unicast);=0D
+	wcid =3D mt7603_rx_get_wcid(dev, idx, unicast);=0D
+	status->wcid_idx =3D wcid ? wcid->idx : MT76_WCID_IDX_INVALID;=0D
 =0D
 	status->band =3D sband->band;=0D
 	if (i < sband->n_channels)=0D
@@ -672,7 +674,7 @@ mt7603_mac_fill_rx(struct mt7603_dev *dev, struct sk_bu=
ff *skb)=0D
 	}=0D
 =0D
 	hdr =3D (struct ieee80211_hdr *)skb->data;=0D
-	if (!status->wcid || !ieee80211_is_data_qos(hdr->frame_control))=0D
+	if (!wcid || !ieee80211_is_data_qos(hdr->frame_control))=0D
 		return 0;=0D
 =0D
 	status->aggr =3D unicast &&=0D
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c b/drivers/net/=
wireless/mediatek/mt76/mt7615/mac.c=0D
index ce0051468501..84be00a13930 100644=0D
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c=0D
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c=0D
@@ -246,17 +246,20 @@ static void mt7615_mac_fill_tm_rx(struct mt7615_phy *=
phy, __le32 *rxv)=0D
 }=0D
 =0D
 /* The HW does not translate the mac header to 802.3 for mesh point */=0D
-static int mt7615_reverse_frag0_hdr_trans(struct sk_buff *skb, u16 hdr_gap=
)=0D
+static int mt7615_reverse_frag0_hdr_trans(struct mt7615_dev *dev,=0D
+					  struct sk_buff *skb, u16 hdr_gap)=0D
 {=0D
 	struct mt76_rx_status *status =3D (struct mt76_rx_status *)skb->cb;=0D
 	struct ethhdr *eth_hdr =3D (struct ethhdr *)(skb->data + hdr_gap);=0D
-	struct mt7615_sta *msta =3D (struct mt7615_sta *)status->wcid;=0D
 	__le32 *rxd =3D (__le32 *)skb->data;=0D
 	struct ieee80211_sta *sta;=0D
 	struct ieee80211_vif *vif;=0D
 	struct ieee80211_hdr hdr;=0D
+	struct mt7615_sta *msta;=0D
 	u16 frame_control;=0D
 =0D
+	msta =3D (struct mt7615_sta *)mt76_wcid_ptr(dev, status->wcid_idx);=0D
+=0D
 	if (le32_get_bits(rxd[1], MT_RXD1_NORMAL_ADDR_TYPE) !=3D=0D
 	    MT_RXD1_NORMAL_U2M)=0D
 		return -EINVAL;=0D
@@ -335,6 +338,7 @@ static int mt7615_mac_fill_rx(struct mt7615_dev *dev, s=
truct sk_buff *skb)=0D
 	struct ieee80211_supported_band *sband;=0D
 	struct ieee80211_hdr *hdr;=0D
 	struct mt7615_phy *phy2;=0D
+	struct mt76_wcid *wcid;=0D
 	__le32 *rxd =3D (__le32 *)skb->data;=0D
 	u32 rxd0 =3D le32_to_cpu(rxd[0]);=0D
 	u32 rxd1 =3D le32_to_cpu(rxd[1]);=0D
@@ -378,12 +382,13 @@ static int mt7615_mac_fill_rx(struct mt7615_dev *dev,=
 struct sk_buff *skb)=0D
 =0D
 	unicast =3D (rxd1 & MT_RXD1_NORMAL_ADDR_TYPE) =3D=3D MT_RXD1_NORMAL_U2M;=
=0D
 	idx =3D FIELD_GET(MT_RXD2_NORMAL_WLAN_IDX, rxd2);=0D
-	status->wcid =3D mt7615_rx_get_wcid(dev, idx, unicast);=0D
+	wcid =3D mt7615_rx_get_wcid(dev, idx, unicast);=0D
+	status->wcid_idx =3D wcid ? wcid->idx : MT76_WCID_IDX_INVALID;=0D
 =0D
-	if (status->wcid) {=0D
+	if (wcid) {=0D
 		struct mt7615_sta *msta;=0D
 =0D
-		msta =3D container_of(status->wcid, struct mt7615_sta, wcid);=0D
+		msta =3D container_of(wcid, struct mt7615_sta, wcid);=0D
 		mt76_wcid_add_poll(&dev->mt76, &msta->wcid);=0D
 	}=0D
 =0D
@@ -590,7 +595,7 @@ static int mt7615_mac_fill_rx(struct mt7615_dev *dev, s=
truct sk_buff *skb)=0D
 =0D
 	hdr_gap =3D (u8 *)rxd - skb->data + 2 * remove_pad;=0D
 	if (hdr_trans && ieee80211_has_morefrags(fc)) {=0D
-		if (mt7615_reverse_frag0_hdr_trans(skb, hdr_gap))=0D
+		if (mt7615_reverse_frag0_hdr_trans(dev, skb, hdr_gap))=0D
 			return -EINVAL;=0D
 		hdr_trans =3D false;=0D
 	} else {=0D
@@ -638,7 +643,7 @@ static int mt7615_mac_fill_rx(struct mt7615_dev *dev, s=
truct sk_buff *skb)=0D
 		status->flag |=3D RX_FLAG_8023;=0D
 	}=0D
 =0D
-	if (!status->wcid || !ieee80211_is_data_qos(fc))=0D
+	if (!wcid || !ieee80211_is_data_qos(fc))=0D
 		return 0;=0D
 =0D
 	status->aggr =3D unicast &&=0D
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac.h b/drivers/net=
/wireless/mediatek/mt76/mt76_connac.h=0D
index 51423c7740bd..d9ae8d204442 100644=0D
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac.h=0D
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac.h=0D
@@ -448,7 +448,8 @@ bool mt76_connac2_mac_add_txs_skb(struct mt76_dev *dev,=
 struct mt76_wcid *wcid,=0D
 void mt76_connac2_mac_decode_he_radiotap(struct mt76_dev *dev,=0D
 					 struct sk_buff *skb,=0D
 					 __le32 *rxv, u32 mode);=0D
-int mt76_connac2_reverse_frag0_hdr_trans(struct ieee80211_vif *vif,=0D
+int mt76_connac2_reverse_frag0_hdr_trans(struct mt76_dev *dev,=0D
+					 struct ieee80211_vif *vif,=0D
 					 struct sk_buff *skb, u16 hdr_offset);=0D
 int mt76_connac2_mac_fill_rx_rate(struct mt76_dev *dev,=0D
 				  struct mt76_rx_status *status,=0D
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c b/drivers=
/net/wireless/mediatek/mt76/mt76_connac_mac.c=0D
index 0339e2e7ab60..376d59d517cc 100644=0D
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c=0D
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c=0D
@@ -952,7 +952,8 @@ void mt76_connac2_mac_decode_he_radiotap(struct mt76_de=
v *dev,=0D
 EXPORT_SYMBOL_GPL(mt76_connac2_mac_decode_he_radiotap);=0D
 =0D
 /* The HW does not translate the mac header to 802.3 for mesh point */=0D
-int mt76_connac2_reverse_frag0_hdr_trans(struct ieee80211_vif *vif,=0D
+int mt76_connac2_reverse_frag0_hdr_trans(struct mt76_dev *dev,=0D
+					 struct ieee80211_vif *vif,=0D
 					 struct sk_buff *skb, u16 hdr_offset)=0D
 {=0D
 	struct mt76_rx_status *status =3D (struct mt76_rx_status *)skb->cb;=0D
@@ -960,6 +961,7 @@ int mt76_connac2_reverse_frag0_hdr_trans(struct ieee802=
11_vif *vif,=0D
 	__le32 *rxd =3D (__le32 *)skb->data;=0D
 	struct ieee80211_sta *sta;=0D
 	struct ieee80211_hdr hdr;=0D
+	struct mt76_wcid *wcid;=0D
 	u16 frame_control;=0D
 =0D
 	if (le32_get_bits(rxd[3], MT_RXD3_NORMAL_ADDR_TYPE) !=3D=0D
@@ -969,7 +971,13 @@ int mt76_connac2_reverse_frag0_hdr_trans(struct ieee80=
211_vif *vif,=0D
 	if (!(le32_to_cpu(rxd[1]) & MT_RXD1_NORMAL_GROUP_4))=0D
 		return -EINVAL;=0D
 =0D
-	sta =3D container_of((void *)status->wcid, struct ieee80211_sta, drv_priv=
);=0D
+	wcid =3D __mt76_wcid_ptr(dev, status->wcid_idx);=0D
+	if (!wcid)=0D
+		return -EINVAL;=0D
+=0D
+	sta =3D container_of((void *)wcid, struct ieee80211_sta, drv_priv);=0D
+	if (!sta)=0D
+		return -EINVAL;=0D
 =0D
 	/* store the info from RXD and ethhdr to avoid being overridden */=0D
 	frame_control =3D le32_get_bits(rxd[6], MT_RXD6_FRAME_CONTROL);=0D
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/=
wireless/mediatek/mt76/mt7915/mac.c=0D
index cec2c4208255..30672713323f 100644=0D
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c=0D
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c=0D
@@ -280,6 +280,7 @@ mt7915_mac_fill_rx(struct mt7915_dev *dev, struct sk_bu=
ff *skb,=0D
 	u8 mode =3D 0, qos_ctl =3D 0;=0D
 	struct mt7915_sta *msta =3D NULL;=0D
 	u32 csum_status =3D *(u32 *)skb->cb;=0D
+	struct mt76_wcid *wcid;=0D
 	bool hdr_trans;=0D
 	u16 hdr_gap;=0D
 	u16 seq_ctrl =3D 0;=0D
@@ -313,10 +314,13 @@ mt7915_mac_fill_rx(struct mt7915_dev *dev, struct sk_=
buff *skb,=0D
 =0D
 	unicast =3D FIELD_GET(MT_RXD3_NORMAL_ADDR_TYPE, rxd3) =3D=3D MT_RXD3_NORM=
AL_U2M;=0D
 	idx =3D FIELD_GET(MT_RXD1_NORMAL_WLAN_IDX, rxd1);=0D
-	status->wcid =3D mt7915_rx_get_wcid(dev, idx, unicast);=0D
 =0D
-	if (status->wcid) {=0D
-		msta =3D container_of(status->wcid, struct mt7915_sta, wcid);=0D
+	wcid =3D mt7915_rx_get_wcid(dev, idx, unicast);=0D
+=0D
+	status->wcid_idx =3D wcid ? wcid->idx : MT76_WCID_IDX_INVALID;=0D
+=0D
+	if (wcid) {=0D
+		msta =3D container_of(wcid, struct mt7915_sta, wcid);=0D
 		mt76_wcid_add_poll(&dev->mt76, &msta->wcid);=0D
 	}=0D
 =0D
@@ -475,7 +479,8 @@ mt7915_mac_fill_rx(struct mt7915_dev *dev, struct sk_bu=
ff *skb,=0D
 =0D
 		vif =3D container_of((void *)msta->vif, struct ieee80211_vif,=0D
 				   drv_priv);=0D
-		err =3D mt76_connac2_reverse_frag0_hdr_trans(vif, skb, hdr_gap);=0D
+		err =3D mt76_connac2_reverse_frag0_hdr_trans(&dev->mt76, vif,=0D
+							   skb, hdr_gap);=0D
 		if (err)=0D
 			return err;=0D
 =0D
@@ -532,7 +537,8 @@ mt7915_mac_fill_rx(struct mt7915_dev *dev, struct sk_bu=
ff *skb,=0D
 	if (rxv && mode >=3D MT_PHY_TYPE_HE_SU && !(status->flag & RX_FLAG_8023))=
=0D
 		mt76_connac2_mac_decode_he_radiotap(&dev->mt76, skb, rxv, mode);=0D
 =0D
-	if (!status->wcid || !ieee80211_is_data_qos(fc))=0D
+	if (status->wcid_idx =3D=3D MT76_WCID_IDX_INVALID ||=0D
+	    !ieee80211_is_data_qos(fc))=0D
 		return 0;=0D
 =0D
 	status->aggr =3D unicast &&=0D
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c b/drivers/net/=
wireless/mediatek/mt76/mt7921/mac.c=0D
index 03b4960db73f..59c64b951678 100644=0D
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c=0D
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c=0D
@@ -184,6 +184,7 @@ mt7921_mac_fill_rx(struct mt792x_dev *dev, struct sk_bu=
ff *skb)=0D
 	u32 rxd4 =3D le32_to_cpu(rxd[4]);=0D
 	struct mt792x_sta *msta =3D NULL;=0D
 	struct mt792x_link_sta *mlink;=0D
+	struct mt76_wcid *wcid;=0D
 	u16 seq_ctrl =3D 0;=0D
 	__le16 fc =3D 0;=0D
 	u8 mode =3D 0;=0D
@@ -211,10 +212,11 @@ mt7921_mac_fill_rx(struct mt792x_dev *dev, struct sk_=
buff *skb)=0D
 	chfreq =3D FIELD_GET(MT_RXD3_NORMAL_CH_FREQ, rxd3);=0D
 	unicast =3D FIELD_GET(MT_RXD3_NORMAL_ADDR_TYPE, rxd3) =3D=3D MT_RXD3_NORM=
AL_U2M;=0D
 	idx =3D FIELD_GET(MT_RXD1_NORMAL_WLAN_IDX, rxd1);=0D
-	status->wcid =3D mt792x_rx_get_wcid(dev, idx, unicast);=0D
+	wcid =3D mt792x_rx_get_wcid(dev, idx, unicast);=0D
+	status->wcid_idx =3D wcid ? wcid->idx : MT76_WCID_IDX_INVALID;=0D
 =0D
-	if (status->wcid) {=0D
-		mlink =3D container_of(status->wcid, struct mt792x_link_sta, wcid);=0D
+	if (wcid) {=0D
+		mlink =3D container_of(wcid, struct mt792x_link_sta, wcid);=0D
 		msta =3D container_of(mlink, struct mt792x_sta, deflink);=0D
 		mt76_wcid_add_poll(&dev->mt76, &mlink->wcid);=0D
 	}=0D
@@ -395,7 +397,8 @@ mt7921_mac_fill_rx(struct mt792x_dev *dev, struct sk_bu=
ff *skb)=0D
 =0D
 		vif =3D container_of((void *)msta->vif, struct ieee80211_vif,=0D
 				   drv_priv);=0D
-		err =3D mt76_connac2_reverse_frag0_hdr_trans(vif, skb, hdr_gap);=0D
+		err =3D mt76_connac2_reverse_frag0_hdr_trans(&dev->mt76, vif,=0D
+							   skb, hdr_gap);=0D
 		if (err)=0D
 			return err;=0D
 =0D
@@ -433,7 +436,7 @@ mt7921_mac_fill_rx(struct mt792x_dev *dev, struct sk_bu=
ff *skb)=0D
 	if (rxv && mode >=3D MT_PHY_TYPE_HE_SU && !(status->flag & RX_FLAG_8023))=
=0D
 		mt76_connac2_mac_decode_he_radiotap(&dev->mt76, skb, rxv, mode);=0D
 =0D
-	if (!status->wcid || !ieee80211_is_data_qos(fc))=0D
+	if (!wcid || !ieee80211_is_data_qos(fc))=0D
 		return 0;=0D
 =0D
 	status->aggr =3D unicast && !ieee80211_is_qos_nullfunc(fc);=0D
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mac.c b/drivers/net/=
wireless/mediatek/mt76/mt7925/mac.c=0D
index c47bd812b66b..e429f78596e2 100644=0D
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mac.c=0D
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mac.c=0D
@@ -166,17 +166,20 @@ void mt7925_mac_set_fixed_rate_table(struct mt792x_de=
v *dev,=0D
 }=0D
 =0D
 /* The HW does not translate the mac header to 802.3 for mesh point */=0D
-static int mt7925_reverse_frag0_hdr_trans(struct sk_buff *skb, u16 hdr_gap=
)=0D
+static int mt7925_reverse_frag0_hdr_trans(struct mt792x_dev *dev,=0D
+					  struct sk_buff *skb, u16 hdr_gap)=0D
 {=0D
 	struct mt76_rx_status *status =3D (struct mt76_rx_status *)skb->cb;=0D
 	struct ethhdr *eth_hdr =3D (struct ethhdr *)(skb->data + hdr_gap);=0D
-	struct mt792x_sta *msta =3D (struct mt792x_sta *)status->wcid;=0D
 	__le32 *rxd =3D (__le32 *)skb->data;=0D
 	struct ieee80211_sta *sta;=0D
 	struct ieee80211_vif *vif;=0D
 	struct ieee80211_hdr hdr;=0D
+	struct mt792x_sta *msta;=0D
 	u16 frame_control;=0D
 =0D
+	msta =3D (struct mt792x_sta *)mt76_wcid_ptr(dev, status->wcid_idx);=0D
+=0D
 	if (le32_get_bits(rxd[3], MT_RXD3_NORMAL_ADDR_TYPE) !=3D=0D
 	    MT_RXD3_NORMAL_U2M)=0D
 		return -EINVAL;=0D
@@ -368,6 +371,7 @@ mt7925_mac_fill_rx(struct mt792x_dev *dev, struct sk_bu=
ff *skb)=0D
 	u32 rxd3 =3D le32_to_cpu(rxd[3]);=0D
 	u32 rxd4 =3D le32_to_cpu(rxd[4]);=0D
 	struct mt792x_link_sta *mlink;=0D
+	struct mt76_wcid *wcid;=0D
 	u8 mode =3D 0; /* , band_idx; */=0D
 	u16 seq_ctrl =3D 0;=0D
 	__le16 fc =3D 0;=0D
@@ -392,10 +396,11 @@ mt7925_mac_fill_rx(struct mt792x_dev *dev, struct sk_=
buff *skb)=0D
 	chfreq =3D FIELD_GET(MT_RXD3_NORMAL_CH_FREQ, rxd3);=0D
 	unicast =3D FIELD_GET(MT_RXD3_NORMAL_ADDR_TYPE, rxd3) =3D=3D MT_RXD3_NORM=
AL_U2M;=0D
 	idx =3D FIELD_GET(MT_RXD1_NORMAL_WLAN_IDX, rxd1);=0D
-	status->wcid =3D mt792x_rx_get_wcid(dev, idx, unicast);=0D
+	wcid =3D mt792x_rx_get_wcid(dev, idx, unicast);=0D
+	status->wcid_idx =3D wcid ? wcid->idx : MT76_WCID_IDX_INVALID;=0D
 =0D
-	if (status->wcid) {=0D
-		mlink =3D container_of(status->wcid, struct mt792x_link_sta, wcid);=0D
+	if (wcid) {=0D
+		mlink =3D container_of(wcid, struct mt792x_link_sta, wcid);=0D
 		mt76_wcid_add_poll(&dev->mt76, &mlink->wcid);=0D
 	}=0D
 =0D
@@ -545,7 +550,7 @@ mt7925_mac_fill_rx(struct mt792x_dev *dev, struct sk_bu=
ff *skb)=0D
 =0D
 	hdr_gap =3D (u8 *)rxd - skb->data + 2 * remove_pad;=0D
 	if (hdr_trans && ieee80211_has_morefrags(fc)) {=0D
-		if (mt7925_reverse_frag0_hdr_trans(skb, hdr_gap))=0D
+		if (mt7925_reverse_frag0_hdr_trans(dev, skb, hdr_gap))=0D
 			return -EINVAL;=0D
 		hdr_trans =3D false;=0D
 	} else {=0D
@@ -608,7 +613,7 @@ mt7925_mac_fill_rx(struct mt792x_dev *dev, struct sk_bu=
ff *skb)=0D
 		}=0D
 	}=0D
 =0D
-	if (!status->wcid || !ieee80211_is_data_qos(fc))=0D
+	if (!wcid || !ieee80211_is_data_qos(fc))=0D
 		return 0;=0D
 =0D
 	status->aggr =3D unicast && !ieee80211_is_qos_nullfunc(fc);=0D
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c b/drivers/net/=
wireless/mediatek/mt76/mt7996/mac.c=0D
index e2a83da3a09c..98c30957dd76 100644=0D
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c=0D
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c=0D
@@ -186,17 +186,19 @@ static void mt7996_mac_sta_poll(struct mt7996_dev *de=
v)=0D
 }=0D
 =0D
 /* The HW does not translate the mac header to 802.3 for mesh point */=0D
-static int mt7996_reverse_frag0_hdr_trans(struct sk_buff *skb, u16 hdr_gap=
)=0D
+static int mt7996_reverse_frag0_hdr_trans(struct mt7996_dev *dev,=0D
+					  struct sk_buff *skb, u16 hdr_gap)=0D
 {=0D
 	struct mt76_rx_status *status =3D (struct mt76_rx_status *)skb->cb;=0D
 	struct ethhdr *eth_hdr =3D (struct ethhdr *)(skb->data + hdr_gap);=0D
-	struct mt7996_sta_link *msta_link =3D (void *)status->wcid;=0D
-	struct mt7996_sta *msta =3D msta_link->sta;=0D
+	struct mt76_wcid *wcid =3D mt76_wcid_ptr(dev, status->wcid_idx);=0D
+	struct mt7996_sta_link *msta_link;=0D
 	struct ieee80211_bss_conf *link_conf;=0D
 	__le32 *rxd =3D (__le32 *)skb->data;=0D
 	struct ieee80211_sta *sta;=0D
 	struct ieee80211_vif *vif;=0D
 	struct ieee80211_hdr hdr;=0D
+	struct mt7996_sta *msta;=0D
 	u16 frame_control;=0D
 =0D
 	if (le32_get_bits(rxd[3], MT_RXD3_NORMAL_ADDR_TYPE) !=3D=0D
@@ -206,10 +208,16 @@ static int mt7996_reverse_frag0_hdr_trans(struct sk_b=
uff *skb, u16 hdr_gap)=0D
 	if (!(le32_to_cpu(rxd[1]) & MT_RXD1_NORMAL_GROUP_4))=0D
 		return -EINVAL;=0D
 =0D
+	if (!wcid)=0D
+		return -EINVAL;=0D
+=0D
+	msta_link =3D container_of(wcid, struct mt7996_sta_link, wcid);=0D
+	msta =3D msta_link->sta;=0D
+=0D
 	if (!msta || !msta->vif)=0D
 		return -EINVAL;=0D
 =0D
-	sta =3D wcid_to_sta(status->wcid);=0D
+	sta =3D wcid_to_sta(wcid);=0D
 	vif =3D container_of((void *)msta->vif, struct ieee80211_vif, drv_priv);=
=0D
 	link_conf =3D rcu_dereference(vif->link_conf[msta_link->wcid.link_id]);=0D
 	if (!link_conf)=0D
@@ -429,6 +437,7 @@ mt7996_mac_fill_rx(struct mt7996_dev *dev, enum mt76_rx=
q_id q,=0D
 	bool unicast, insert_ccmp_hdr =3D false;=0D
 	u8 remove_pad, amsdu_info, band_idx;=0D
 	u8 mode =3D 0, qos_ctl =3D 0;=0D
+	struct mt76_wcid *wcid;=0D
 	bool hdr_trans;=0D
 	u16 hdr_gap;=0D
 	u16 seq_ctrl =3D 0;=0D
@@ -461,12 +470,14 @@ mt7996_mac_fill_rx(struct mt7996_dev *dev, enum mt76_=
rxq_id q,=0D
 =0D
 	unicast =3D FIELD_GET(MT_RXD3_NORMAL_ADDR_TYPE, rxd3) =3D=3D MT_RXD3_NORM=
AL_U2M;=0D
 	idx =3D FIELD_GET(MT_RXD1_NORMAL_WLAN_IDX, rxd1);=0D
-	status->wcid =3D mt7996_rx_get_wcid(dev, idx, band_idx);=0D
 =0D
-	if (status->wcid) {=0D
+	wcid =3D mt7996_rx_get_wcid(dev, idx, band_idx);=0D
+	status->wcid_idx =3D wcid ? wcid->idx : MT76_WCID_IDX_INVALID;=0D
+=0D
+	if (wcid) {=0D
 		struct mt7996_sta_link *msta_link;=0D
 =0D
-		msta_link =3D container_of(status->wcid, struct mt7996_sta_link,=0D
+		msta_link =3D container_of(wcid, struct mt7996_sta_link,=0D
 					 wcid);=0D
 		msta =3D msta_link->sta;=0D
 		mt76_wcid_add_poll(&dev->mt76, &msta_link->wcid);=0D
@@ -620,7 +631,7 @@ mt7996_mac_fill_rx(struct mt7996_dev *dev, enum mt76_rx=
q_id q,=0D
 =0D
 	hdr_gap =3D (u8 *)rxd - skb->data + 2 * remove_pad;=0D
 	if (hdr_trans && ieee80211_has_morefrags(fc)) {=0D
-		if (mt7996_reverse_frag0_hdr_trans(skb, hdr_gap))=0D
+		if (mt7996_reverse_frag0_hdr_trans(dev, skb, hdr_gap))=0D
 			return -EINVAL;=0D
 		hdr_trans =3D false;=0D
 	} else {=0D
@@ -697,7 +708,7 @@ mt7996_mac_fill_rx(struct mt7996_dev *dev, enum mt76_rx=
q_id q,=0D
 		}=0D
 	}=0D
 =0D
-	if (!status->wcid || !ieee80211_is_data_qos(fc) || hw_aggr)=0D
+	if (!wcid || !ieee80211_is_data_qos(fc) || hw_aggr)=0D
 		return 0;=0D
 =0D
 	status->aggr =3D unicast &&=0D
-- =0D
2.45.2=0D
=0D

