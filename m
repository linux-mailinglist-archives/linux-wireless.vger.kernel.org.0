Return-Path: <linux-wireless+bounces-35963-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mMrULACc+mkMQQMAu9opvQ
	(envelope-from <linux-wireless+bounces-35963-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 06 May 2026 03:40:16 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 46B0F4D556B
	for <lists+linux-wireless@lfdr.de>; Wed, 06 May 2026 03:40:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2B73F3025AD1
	for <lists+linux-wireless@lfdr.de>; Wed,  6 May 2026 01:40:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35AF3280035;
	Wed,  6 May 2026 01:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MxWw1EJy"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 404B82773CA
	for <linux-wireless@vger.kernel.org>; Wed,  6 May 2026 01:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778031603; cv=none; b=lDlm4iZ7D4xsa4c+e4pbvIGRMSTrkUIHxekaeyfIihxGT2iJvlFNpHr65dHBIvwjFWffdzIPEOGAOMtQTUb38OrNVURzXXm9EHN7EPWp5XA7nDAGFF0uHjJeq6P74NjSWmS6OTeIUf5BbE+8xmUj04gq4lHhO7Iz0QGL3VTh5tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778031603; c=relaxed/simple;
	bh=P5GGRaMT2aaO6cv++PtfWsFBVuVNFRyIWoxv/wx8yfg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WOWNavO729LTA3DwIOOpISi3+Bz6MQX9h06x8/RviBIIIi8nIihPFf/ImDq/MzDeGr3GGCYFgAsXc8xzeHE91oc3tOZgWzGaL3XfvtzbVGvAuskTocex8rgq5NqhN2UGqWJmeeV3uKvHt5/V/5+rh1HTsF5GCnpWQnr/vSfLrbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MxWw1EJy; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-67b6da5a618so9756987a12.2
        for <linux-wireless@vger.kernel.org>; Tue, 05 May 2026 18:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778031600; x=1778636400; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=04ncidu2w9RP0dQrMmKnvCZ7U/5L1OOGEwGtLj11dxw=;
        b=MxWw1EJyJ6uauqAfxHJf9xfrXi+VFTBOdPLd64SyWLLFQGGsLGdqCSrV6JwYRpOyOI
         +ovEDpDd9zo6F30u0fwf72fXQ5bktrBmC+mxqpaVYcLCBUdVfgm0xrsYn0iB5aQybo+9
         hjJJgLEmJmqvtGqxXXbhHeYbRQArglug0YQ2XCr1rQiYM7k/8V88+wQOF1IB9mys/Qcq
         Q5IaLFMESHOPgUr2ewC0vZFcSY5i8nQ3jo3DL2D34jZ8IsfFQj8AtzhuellZpRD+fuyO
         DBMfe7W1QHBFYV8cR3PjkCE8RolGyXXVNFfjqEmoyrXPdci5R5tEar+Ov+k01lURbB6h
         r8lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778031600; x=1778636400;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=04ncidu2w9RP0dQrMmKnvCZ7U/5L1OOGEwGtLj11dxw=;
        b=rGiP2vtKy7k1cfZT5bWFVyTlVU+NkRBsZxhhCR6kezD0DzYmoreRJwyGsqVQNAmti3
         wBjSrnjbqZrBnaRYi6L7cp+NW7gmcHWLtX8Jvm5q3y9TKjJVatkuVvo/a+5PnwtbuP+8
         nibNRCnUmjb+BQVVVygWGPi2V1em4ZsMl7MRk05aNdeVcaIezdXslZ2uOoW/IzgEPyBF
         jHM2h78h80ZHXVgmorpuAxrkSWuCwxpAWjFP6fnrJPqQ2xsLd4Y/3lsmVD7TaULc64D/
         Jrri8v5RWVvpVn6f//jI3bv/PFoi5vN6k7TQ8qESi8a5KfhaxJr1Atw1k3cllQmW+6va
         V80w==
X-Gm-Message-State: AOJu0YydKEOVybc/gOwPaWSkvhuc1hhmXOL6lrmJVyPGWHXgBpEEAu3r
	98LYvoz9DBe4lBkGwAeuUN2OgR8ymRrBqC4ZIrGGLEWh1zaa0ldJer3K
X-Gm-Gg: AeBDiet6lpD6MCmWenl8BLIFYRMu2AnLZs7uf8GKATn7LTr9cfRBFIa+xVE7GEe2lNa
	6NSBIs4GjBrLfK4hjTYj2U/giOuO+9I1wMbQJnB3Av7pzYPLro3h1e3IbbldWcH2zly/j1woXfH
	brpb621QQz28t1uiKxl49757IMTnV+11xM3qEAi9MiBtFNChYW2nDYQCJCLVcV0m25s23HUr9Dc
	T9rntYN2485sPJkcgLhgDW3/yUnNZOLWnX2omG/OHs72GaUM4o4Lle+VSc4MA8hqt5rH3vPbM6H
	hQdbISDNCoL2BacTHYkp5CeNeulZxgzvtxlx2xbS55JFQHiyfUGPzoIFbQapJjXkXlGKRGRr+pg
	wSxlObd5NM8vdlcmMqBVjmjFKKm+hg0wObv3WpQCtWq8JtDyIoZfTNYwlFq+ijNh+eTYxQqlyeB
	huv1DWGp3KXhbeZNfiamGiEgkcFw60kUxOpghBDCPQBVcGjRjfPtYIDjSO/0RI2v0s+yb/hH7EN
	IOSImbP1NYQMUvE1w++YgT9TJFpb9umug==
X-Received: by 2002:a05:6402:a58b:20b0:676:d85a:5faf with SMTP id 4fb4d7f45d1cf-67d63d855e2mr287194a12.9.1778031599366;
        Tue, 05 May 2026 18:39:59 -0700 (PDT)
Received: from KURWA.angora-ide.ts.net (mm-195-107-126-178.vitebsk.dynamic.pppoe.byfly.by. [178.126.107.195])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-67cd904fe68sm849388a12.0.2026.05.05.18.39.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 18:39:58 -0700 (PDT)
From: ElXreno <elxreno@gmail.com>
Date: Wed, 06 May 2026 04:39:15 +0300
Subject: [PATCH v2 1/2] wifi: mt76: route TDLS-peer frames as 3-addr non-DS
 in HW encap
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260506-mt7925-tdls-fixes-v2-1-46aa826ba8bb@gmail.com>
References: <20260506-mt7925-tdls-fixes-v2-0-46aa826ba8bb@gmail.com>
In-Reply-To: <20260506-mt7925-tdls-fixes-v2-0-46aa826ba8bb@gmail.com>
To: Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>, 
 Ryder Lee <ryder.lee@mediatek.com>, Shayne Chen <shayne.chen@mediatek.com>, 
 Sean Wang <sean.wang@mediatek.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Ming Yen Hsieh <mingyen.hsieh@mediatek.com>, 
 Deren Wu <deren.wu@mediatek.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 ElXreno <elxreno@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=7203; i=elxreno@gmail.com;
 h=from:subject:message-id; bh=P5GGRaMT2aaO6cv++PtfWsFBVuVNFRyIWoxv/wx8yfg=;
 b=owJ4nJvAy8zAJXa0WDmKX5v/EeNptSSGzF+z37CkRks8YFK1O3i6MfHWBs38PUVOqrP26k6r3
 OJ977nJoS8dpSwMYlwMsmKKLDzn9tbmLKtbMrmeKwNmDisTyBAGLk4BmMgCHoafjDOtp26wYNxz
 Kzg7cdfWd8xmjgvrFonlvHN9zeFS4GG7lpHhno1S27m34vs2//vjuJ7d1TtvY+Qy2ZzrPQ3bVzT
 kS7jwAAA/IkcZ
X-Developer-Key: i=elxreno@gmail.com; a=openpgp;
 fpr=0CCEBD7D6CA67EA4937F0A68C573235A0F2B0FE2
X-Rspamd-Queue-Id: 46B0F4D556B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-35963-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[nbd.name,kernel.org,mediatek.com,gmail.com,collabora.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[elxreno@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

With HW TX encap offload enabled, the mt76 firmware builds the 802.11
header for the 802.3 frame using the per-WCID context. For a STATION
vif the HDR_TRANS TLV currently sets ToDS=1, which makes the firmware
default to the BSSID as A1 and emit STA->AP-formatted frames
regardless of which peer the WCID points to.

For TDLS-paired peers this is wrong. Data frames go on air addressed
to the AP, the AP MAC-ACKs and silently drops them per IEEE 802.11z
(an AP must not forward to a TDLS-paired peer). Management and
control frames bypass the HW encap path and still reach the peer;
only user data fails.

Add MT_WCID_FLAG_TDLS_PEER, set it in mt7915, mt7921, mt7925 and
mt7996 sta-add paths when sta->tdls is true, and override the
HDR_TRANS TLV in mt76_connac_mcu_wtbl_hdr_trans_tlv() (Connac2 -
mt7915 / mt7921 / mt7922), mt7925_mcu_sta_hdr_trans_tlv() (mt7925)
and mt7996_mcu_sta_hdr_trans_tlv() (mt7996) to set ToDS=0, FromDS=0
when the flag is set. The 3-addr non-DS form matches what 802.11z
uses for direct links; the firmware then constructs the frame with
A1=peer rather than A1=BSSID. HW encap offload remains enabled for
AP and any non-TDLS traffic.

Verified on mt7925e + Samsung S938B over a 5 GHz HE 80 MHz channel
with iperf3 -t 30 to the TDLS peer:

  before fix:  over the TDLS direct link, 7 TDLS Setup action
               frames and 3 RTS frames reach the peer; 0 QoS
               Data frames make it through (mgmt/control paths
               bypass HW encap, the data path does not). iperf3
               stalls.
  after fix:   2.90 GBytes transferred at 830 Mbit/s sustained,
               0 TCP retransmits.

mt7915, mt7921, mt7922 and mt7996 are not regression-tested in this
change for lack of hardware. Their HDR_TRANS handling mirrors the
verified mt7925 change; the firmware behavior is shared across these
chips.

Signed-off-by: ElXreno <elxreno@gmail.com>
Assisted-by: Claude:claude-opus-4-7 bpftrace tcpdump
---
 drivers/net/wireless/mediatek/mt76/mt76.h            | 1 +
 drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c | 5 +++++
 drivers/net/wireless/mediatek/mt76/mt7915/main.c     | 3 +++
 drivers/net/wireless/mediatek/mt76/mt7921/main.c     | 3 +++
 drivers/net/wireless/mediatek/mt76/mt7925/main.c     | 3 +++
 drivers/net/wireless/mediatek/mt76/mt7925/mcu.c      | 5 +++++
 drivers/net/wireless/mediatek/mt76/mt7996/main.c     | 3 +++
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.c      | 5 +++++
 8 files changed, 28 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 527bef97e122..07955555f84d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -361,6 +361,7 @@ enum mt76_wcid_flags {
 	MT_WCID_FLAG_PS,
 	MT_WCID_FLAG_4ADDR,
 	MT_WCID_FLAG_HDR_TRANS,
+	MT_WCID_FLAG_TDLS_PEER,
 };
 
 #define MT76_N_WCIDS 1088
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
index 89bd52ea8bf7..f61d0625ef51 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
@@ -491,6 +491,11 @@ void mt76_connac_mcu_wtbl_hdr_trans_tlv(struct sk_buff *skb,
 		htr->to_ds = true;
 		htr->from_ds = true;
 	}
+
+	if (test_bit(MT_WCID_FLAG_TDLS_PEER, &wcid->flags)) {
+		htr->to_ds = false;
+		htr->from_ds = false;
+	}
 }
 EXPORT_SYMBOL_GPL(mt76_connac_mcu_wtbl_hdr_trans_tlv);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/main.c b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
index e1d83052aa6d..51643a48ed15 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
@@ -760,6 +760,9 @@ int mt7915_mac_sta_add(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 	msta->wcid.phy_idx = ext_phy;
 	msta->jiffies = jiffies;
 
+	if (sta->tdls)
+		set_bit(MT_WCID_FLAG_TDLS_PEER, &msta->wcid.flags);
+
 	ewma_avg_signal_init(&msta->avg_ack_signal);
 
 	mt7915_mac_wtbl_update(dev, idx,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
index 3d74fabe7408..d39cb881d75e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
@@ -828,6 +828,9 @@ int mt7921_mac_sta_add(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 	msta->deflink.last_txs = jiffies;
 	msta->deflink.sta = msta;
 
+	if (sta->tdls)
+		set_bit(MT_WCID_FLAG_TDLS_PEER, &msta->deflink.wcid.flags);
+
 	ret = mt76_connac_pm_wake(&dev->mphy, &dev->pm);
 	if (ret)
 		return ret;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/main.c b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
index 73d3722739d0..61330e3c18b2 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
@@ -887,6 +887,9 @@ static int mt7925_mac_link_sta_add(struct mt76_dev *mdev,
 	mlink->wcid.link_valid = !!link_sta->sta->valid_links;
 	mlink->sta = msta;
 
+	if (link_sta->sta->tdls)
+		set_bit(MT_WCID_FLAG_TDLS_PEER, &mlink->wcid.flags);
+
 	wcid = &mlink->wcid;
 	ewma_signal_init(&wcid->rssi);
 	rcu_assign_pointer(dev->mt76.wcid[wcid->idx], wcid);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
index 22bad3cba8df..333cacfaca9c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
@@ -1091,6 +1091,11 @@ mt7925_mcu_sta_hdr_trans_tlv(struct sk_buff *skb,
 		hdr_trans->to_ds = true;
 		hdr_trans->from_ds = true;
 	}
+
+	if (test_bit(MT_WCID_FLAG_TDLS_PEER, &wcid->flags)) {
+		hdr_trans->to_ds = false;
+		hdr_trans->from_ds = false;
+	}
 }
 
 int mt7925_mcu_wtbl_update_hdr_trans(struct mt792x_dev *dev,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/main.c b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
index a8a6552d49f6..9b8db6efb5ac 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
@@ -1164,6 +1164,9 @@ mt7996_mac_sta_init_link(struct mt7996_dev *dev,
 	msta_link->wcid.link_valid = !!sta->valid_links;
 	msta_link->wcid.def_wcid = &msta->deflink.wcid;
 
+	if (link_sta->sta->tdls)
+		set_bit(MT_WCID_FLAG_TDLS_PEER, &msta_link->wcid.flags);
+
 	ewma_avg_signal_init(&msta_link->avg_ack_signal);
 	ewma_signal_init(&msta_link->wcid.rssi);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
index 16420375112d..6aaf3ed94221 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
@@ -2139,6 +2139,11 @@ mt7996_mcu_sta_hdr_trans_tlv(struct mt7996_dev *dev, struct sk_buff *skb,
 		hdr_trans->from_ds = true;
 		hdr_trans->mesh = true;
 	}
+
+	if (test_bit(MT_WCID_FLAG_TDLS_PEER, &wcid->flags)) {
+		hdr_trans->to_ds = false;
+		hdr_trans->from_ds = false;
+	}
 }
 
 static enum mcu_mmps_mode

-- 
2.53.0


