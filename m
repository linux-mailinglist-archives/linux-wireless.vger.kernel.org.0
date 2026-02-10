Return-Path: <linux-wireless+bounces-31711-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UH22MOSSi2kVWQAAu9opvQ
	(envelope-from <linux-wireless+bounces-31711-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Feb 2026 21:19:48 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3737711F009
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Feb 2026 21:19:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AE58130488CD
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Feb 2026 20:19:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CA9E2FE07D;
	Tue, 10 Feb 2026 20:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=david-bauer.net header.i=@david-bauer.net header.b="RC9Kht1z"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgate02.uberspace.is (mailgate02.uberspace.is [185.26.156.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF919330305
	for <linux-wireless@vger.kernel.org>; Tue, 10 Feb 2026 20:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.26.156.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770754781; cv=none; b=HGC0VkqbUU3vGiCxd20w2kFXdAKshwpODFWYu/+nNU9qXEGp3i68c3sRBcEjuhaMbR6uMgSWpcqatLhrClclLsU0Nc80+f5O/MJSXCCUXf7Lo684XrO4mj2GzBeEPDIt0aMMhgohjqZDdOrZ64baOzLqjUPYIzbDJNKcj3Tb/4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770754781; c=relaxed/simple;
	bh=+iJygy5Rsph3wgdm2ihgiOtTPWuxGIOIgL9IIraZFsc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EkpBAtj7QZGmE1mIrTckHNqek5dYakV7pIjtcFZOh1ql+WR7PaVXXysAIDedUOLm5M+hoNFr4macY+Nyr4vIhdas/tM2ucRQta2zU+DeCU7fL58te21VogCK64kRGrTaG51uhC9TqaEp+iTC0H+antCg02wOIQhkzSxDRZwkS/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=david-bauer.net; spf=pass smtp.mailfrom=david-bauer.net; dkim=pass (4096-bit key) header.d=david-bauer.net header.i=@david-bauer.net header.b=RC9Kht1z; arc=none smtp.client-ip=185.26.156.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=david-bauer.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=david-bauer.net
Received: from perseus.uberspace.de (perseus.uberspace.de [95.143.172.134])
	by mailgate02.uberspace.is (Postfix) with ESMTPS id F1D52180325
	for <linux-wireless@vger.kernel.org>; Tue, 10 Feb 2026 21:19:29 +0100 (CET)
Received: (qmail 28944 invoked by uid 988); 10 Feb 2026 20:19:29 -0000
Authentication-Results: perseus.uberspace.de;
	auth=pass (plain)
Received: from unknown (HELO unkown) (::1)
	by perseus.uberspace.de (Haraka/3.1.1) with ESMTPSA; Tue, 10 Feb 2026 21:19:29 +0100
From: David Bauer <mail@david-bauer.net>
To: Felix Fietkau <nbd@nbd.name>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Ryder Lee <ryder.lee@mediatek.com>,
	Shayne Chen <shayne.chen@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH mt76] wifi: mt76: mt7915: sync station power save state
Date: Tue, 10 Feb 2026 21:19:14 +0100
Message-ID: <20260210201917.993424-1-mail@david-bauer.net>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Bar: /
X-Rspamd-Report: SUSPICIOUS_RECIPS(1.5) BAYES_HAM(-3) MID_CONTAINS_FROM(1) MIME_GOOD(-0.1) R_MISSING_CHARSET(0.5)
X-Rspamd-Score: -0.1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=david-bauer.net; s=uberspace;
	h=from:to:cc:subject:date;
	bh=+iJygy5Rsph3wgdm2ihgiOtTPWuxGIOIgL9IIraZFsc=;
	b=RC9Kht1zeY9OVpr4Eb3kudMKBbZdFnACKFC2IFZQRPkWWoE4rI1ToCk3lYpUisMmwqQh3rd0Ji
	R4+bbYFtW1zElJ31SHgumImP/uN5otpyaRyHh4irmmGKEL4DASpUCzYqERaquhicCNHJ7OH+IvSg
	853X61J+oHhxwPXXJ3UwjW5sLHBfYEhCDGmygbvnVyUrv/Pehn04oC1UvSTcRapuegwq/hE9xf7S
	uxkdIyjz1LJZRHoH/S1MxSkHsdXoTvxkiLrMsiu7vzeV6Xx1NTiErp1R+h0UKmsxZm15FNmhGoO+
	Ig8VA09VAwykr3ASxXgrD4BHm54dj/laleQAFGjnkHc/pmZWjmmel4MpmPMhKYgoYVxfbDSY1yyH
	X/csZYmHmaaZUiUiXTRiEGH8mnNmwjtXRlGXqjZof6xYqavPMgauEISq7GtMYLgMtiGqcAjeqKTI
	PEQCjURKpQbQvM5qLHafJUXTlRRGQi4gDrTZrkmF8tSKSUUER6YCGGnDN2f7RoDhlQWmyOTKcHHB
	PsMMR231EdKW0hmcYwJOQX3XEafrSmTT4CYb/kfU2ziWcQq8jAosEVCWvfR4PMOTTC9wIlgxgupp
	YaKCzDPLe8QM4BP8n205UFwxsjEbDAuUZ4ct6ZpxAhGcL0Hg8zd+vJB3uV0guY8yBJVMaVhRyEy4
	E=
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[david-bauer.net,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[david-bauer.net:s=uberspace];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[nbd.name,kernel.org,mediatek.com,gmail.com,collabora.com];
	TAGGED_FROM(0.00)[bounces-31711-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[david-bauer.net:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mail@david-bauer.net,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,david-bauer.net:mid,david-bauer.net:dkim,david-bauer.net:email]
X-Rspamd-Queue-Id: 3737711F009
X-Rspamd-Action: no action

Host receives a power save state change event everytime a station enters
or leaves PS mode. Use this unsolicited event to stop filling up TX
queues in firmware, as the hardware will buffer frames for stations in
power safe indefinitely.

Limit packets to be enqueued for sleeping STAs in order to manage the
packet backlog in the host-system while still being able to indicate
pending traffic to said STAs.

Signed-off-by: David Bauer <mail@david-bauer.net>
---
 .../net/wireless/mediatek/mt76/mt7915/main.c  |  1 +
 .../net/wireless/mediatek/mt76/mt7915/mcu.c   | 28 +++++++++++++++++++
 .../net/wireless/mediatek/mt76/mt7915/mcu.h   |  9 ++++++
 3 files changed, 38 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/main.c b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
index 90d5e79fbf74d..71b94db64ef6d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
@@ -1783,6 +1783,7 @@ const struct ieee80211_ops mt7915_ops = {
 	.sw_scan_complete = mt76_sw_scan_complete,
 	.release_buffered_frames = mt76_release_buffered_frames,
 	.get_txpower = mt76_get_txpower,
+	.set_tim = mt76_set_tim,
 	.set_sar_specs = mt7915_set_sar_specs,
 	.channel_switch_beacon = mt7915_channel_switch_beacon,
 	.get_stats = mt7915_get_stats,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index 00bff4d3aab80..8b4a5973b240c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -402,6 +402,31 @@ mt7915_mcu_rx_bcc_notify(struct mt7915_dev *dev, struct sk_buff *skb)
 			mt7915_mcu_cca_finish, mphy->hw);
 }
 
+static void mt7915_mcu_rx_ps_sync(struct mt7915_dev *dev, struct sk_buff *skb)
+{
+	struct mt7915_mcu_ps_notify *p;
+	struct ieee80211_sta *sta;
+	struct mt76_wcid *wcid;
+	u16 wcid_idx;
+
+	p = (struct mt7915_mcu_ps_notify *)skb->data;
+	wcid_idx = p->wtbl_lower | (p->wtbl_higher) << 8;
+
+	rcu_read_lock();
+	wcid = mt76_wcid_ptr(dev, wcid_idx);
+	if (!wcid)
+		goto out;
+
+	sta = wcid_to_sta(wcid);
+	if (!sta)
+		goto out;
+
+	ieee80211_sta_ps_transition_ni(sta, !!p->ps_bit);
+
+out:
+	rcu_read_unlock();
+}
+
 static void
 mt7915_mcu_rx_ext_event(struct mt7915_dev *dev, struct sk_buff *skb)
 {
@@ -424,6 +449,9 @@ mt7915_mcu_rx_ext_event(struct mt7915_dev *dev, struct sk_buff *skb)
 	case MCU_EXT_EVENT_BCC_NOTIFY:
 		mt7915_mcu_rx_bcc_notify(dev, skb);
 		break;
+	case MCU_EXT_EVENT_PS_SYNC:
+		mt7915_mcu_rx_ps_sync(dev, skb);
+		break;
 	default:
 		break;
 	}
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
index 3af11a075a2f4..836fe46393256 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
@@ -54,6 +54,15 @@ struct mt7915_mcu_bcc_notify {
 	u8 rsv;
 } __packed;
 
+struct mt7915_mcu_ps_notify {
+	struct mt76_connac2_mcu_rxd_hdr rxd;
+
+	u8 wtbl_lower;
+	u8 ps_bit;
+	u8 wtbl_higher;
+	u8 rsv;
+} __packed;
+
 struct mt7915_mcu_rdd_report {
 	struct mt76_connac2_mcu_rxd_hdr rxd;
 
-- 
2.51.0


