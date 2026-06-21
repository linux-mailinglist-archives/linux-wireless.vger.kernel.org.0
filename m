Return-Path: <linux-wireless+bounces-37951-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ncunAGXmN2qJVQcAu9opvQ
	(envelope-from <linux-wireless+bounces-37951-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 21 Jun 2026 15:25:57 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7826F6AAE1C
	for <lists+linux-wireless@lfdr.de>; Sun, 21 Jun 2026 15:25:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=WXn1f4Xg;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37951-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37951-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9CE7D301CC13
	for <lists+linux-wireless@lfdr.de>; Sun, 21 Jun 2026 13:25:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 681C23655DB;
	Sun, 21 Jun 2026 13:25:44 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CD931DF73A
	for <linux-wireless@vger.kernel.org>; Sun, 21 Jun 2026 13:25:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782048344; cv=none; b=MEZ/cC8eHxSzIbzO3qBfyPrMZ2gJTHbHvNmz4a+xlh79ZbMVsMlikphCnGgMl03edbqvQy5DujJ10/K25Y4mJGsjYWPXb+ZhwDBbxjVHV3kPmyDrIUYLccXFSaYktyfcm9jiGubkESOjnFDgB93dDpmqnF7tEI4h4GImcU5f3mI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782048344; c=relaxed/simple;
	bh=uXvrwwuGzaFnHlMiF+IpGDniSgkffS+pmEB3m7W1/y0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Q5/pdzyUajvRrsCNzUHDowvJZShmWfiqS2ELpyYq/1mXph9DBnaBRP4yca96SBiorA7eusxAGGdQAUIqCW6raDQpJlAa4yNyQnJl6NajGwNWUhyA/IeQkzpnO6yerkETDZ+01Rv9vnYNWTbcfHFN9vA7OjKfziEE/y8aKVCFdR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WXn1f4Xg; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 994711F000E9;
	Sun, 21 Jun 2026 13:25:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782048343;
	bh=O+3Q274QQqI7fHg3RmAuv+m1smQF9cdSN9rwOrdkNuc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=WXn1f4Xg2jyfZPr5uSnNsJPg7qMGI1QlyPjLJUNjr7NDtTyIUCij9K32qIx8PkKMl
	 oexA2W/MtOSkKfZBkUeK53Oq5uySOy9S9HThwxToRmU4S1/XwCpsGrX305aUG5Xam/
	 cIojjAgD5Av/hgcFS15nRjUst1dwBDAJ7Hze92p/RjksguaiC/78CKbcq8Ezt6v2Ao
	 uvzovWSyi46uVi1nAScYCJnni8+DPhWLKBBvHLAVvWmVtmzvsDzDVvADGhHrlhanSf
	 UIypUPHRJGK21lDgY8n//VI9KVnSz1P09LKL5xeMP/Fn5oLXrxwF/0/d+oN5/9I6Us
	 V9gxl4zSC1IHw==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Sun, 21 Jun 2026 15:25:01 +0200
Subject: [PATCH 3/4] wifi: mt76: mt7996: check pointer returned by
 mt76_connac_get_he_phy_cap()
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260621-mt76_connac_get_he_phy_cap-fix-v1-3-ed4ccf7a0363@kernel.org>
References: <20260621-mt76_connac_get_he_phy_cap-fix-v1-0-ed4ccf7a0363@kernel.org>
In-Reply-To: <20260621-mt76_connac_get_he_phy_cap-fix-v1-0-ed4ccf7a0363@kernel.org>
To: Felix Fietkau <nbd@nbd.name>, Ryder Lee <ryder.lee@mediatek.com>, 
 Shayne Chen <shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Leon Yen <leon.yen@mediatek.com>, Hao Zhang <hao.zhang@mediatek.com>, 
 Nelson Yu <nelson.yu@mediatek.com>, Rong Yan <rong.yan@mediatek.com>, 
 Money Wang <Money.Wang@mediatek.com>, Bo Jiao <Bo.Jiao@mediatek.com>, 
 StanleyYP Wang <StanleyYP.Wang@mediatek.com>, 
 Howard Hsu <howard-yh.hsu@mediatek.com>, 
 Evelyn Tsai <evelyn.tsai@mediatek.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>, 
 Mingyen Hsieh <mingyen.hsieh@mediatek.com>
Cc: linux-wireless@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, Quan Zhou <quan.zhou@mediatek.com>, 
 Deren Wu <deren.wu@mediatek.com>, MeiChia Chiu <meichia.chiu@mediatek.com>
X-Mailer: b4 0.14.3
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-37951-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:nbd@nbd.name,m:ryder.lee@mediatek.com,m:shayne.chen@mediatek.com,m:sean.wang@mediatek.com,m:matthias.bgg@gmail.com,m:angelogioacchino.delregno@collabora.com,m:leon.yen@mediatek.com,m:hao.zhang@mediatek.com,m:nelson.yu@mediatek.com,m:rong.yan@mediatek.com,m:Money.Wang@mediatek.com,m:Bo.Jiao@mediatek.com,m:StanleyYP.Wang@mediatek.com,m:howard-yh.hsu@mediatek.com,m:evelyn.tsai@mediatek.com,m:lorenzo@kernel.org,m:mingyen.hsieh@mediatek.com,m:linux-wireless@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-mediatek@lists.infradead.org,m:quan.zhou@mediatek.com,m:deren.wu@mediatek.com,m:meichia.chiu@mediatek.com,m:matthiasbgg@gmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[nbd.name,mediatek.com,gmail.com,collabora.com,kernel.org];
	FORGED_SENDER(0.00)[lorenzo@kernel.org,linux-wireless@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7826F6AAE1C

mt76_connac_get_he_phy_cap routine can theoretically return NULL so
check cap pointer before dereferencing it.

Fixes: 98686cd21624c ("wifi: mt76: mt7996: add driver for MediaTek Wi-Fi 7 (802.11be) devices")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
index f119f023bcd5..c868b1356894 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
@@ -935,6 +935,8 @@ mt7996_mcu_bss_he_tlv(struct sk_buff *skb, struct ieee80211_vif *vif,
 	struct tlv *tlv;
 
 	cap = mt76_connac_get_he_phy_cap(phy->mt76, vif);
+	if (!cap)
+		return;
 
 	tlv = mt7996_mcu_add_uni_tlv(skb, UNI_BSS_INFO_HE_BASIC, sizeof(*he));
 
@@ -1855,17 +1857,18 @@ mt7996_mcu_sta_bfer_he(struct ieee80211_link_sta *link_sta,
 {
 	struct ieee80211_sta_he_cap *pc = &link_sta->he_cap;
 	struct ieee80211_he_cap_elem *pe = &pc->he_cap_elem;
-	const struct ieee80211_sta_he_cap *vc =
-		mt76_connac_get_he_phy_cap(phy->mt76, vif);
-	const struct ieee80211_he_cap_elem *ve = &vc->he_cap_elem;
 	u16 mcs_map = le16_to_cpu(pc->he_mcs_nss_supp.rx_mcs_80);
 	u8 nss_mcs = mt7996_mcu_get_sta_nss(mcs_map);
+	const struct ieee80211_he_cap_elem *ve;
+	const struct ieee80211_sta_he_cap *vc;
 	u8 snd_dim, sts;
 
+	vc = mt76_connac_get_he_phy_cap(phy->mt76, vif);
 	if (!vc)
 		return;
 
 	bf->tx_mode = MT_PHY_TYPE_HE_SU;
+	ve = &vc->he_cap_elem;
 
 	mt7996_mcu_sta_sounding_rate(bf, phy);
 

-- 
2.54.0


