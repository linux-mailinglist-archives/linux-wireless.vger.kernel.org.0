Return-Path: <linux-wireless+bounces-37952-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id RZhbLWrmN2qKVQcAu9opvQ
	(envelope-from <linux-wireless+bounces-37952-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 21 Jun 2026 15:26:02 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 59C666AAE20
	for <lists+linux-wireless@lfdr.de>; Sun, 21 Jun 2026 15:26:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=YXek3R+B;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37952-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37952-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3E6EC301DDB5
	for <lists+linux-wireless@lfdr.de>; Sun, 21 Jun 2026 13:25:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD1F92459FE;
	Sun, 21 Jun 2026 13:25:46 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D53B61DF73A
	for <linux-wireless@vger.kernel.org>; Sun, 21 Jun 2026 13:25:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782048346; cv=none; b=r+MEbUaXk530AgIAFDSNHMTCJ2bIGiGolnov09TuDwt+uUbysOLn8RjZGIpnxjNTWJlJMQTZJefJjauZ9Q0z8OmSWBqI/19NHRTevdxTL78op/GoqO0HRKWh+yY3WgjRNHJhYdqA52OIqS43Xm0W03IzdE6YflrmPqU83GF61uM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782048346; c=relaxed/simple;
	bh=G3qVVoQrmZytdbwbishlSRW3JCyOlh7yM7zW9Rbcd58=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mgMryMMSywysye6mqJiiTp7Nd0SkLhRiacG/q2ymddv95tOXQB8WS0TPXHpizdLuodRuUf7aj/3vYuSUVIO1VrH7PXJ6w5X5AgeM8Ts2infNxgZ+YqafacYI/B0jdCFLGPZSCaZTkKC5N7WPTEDU9PchWJYE1Y9w716ZNk1tBSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YXek3R+B; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 176841F000E9;
	Sun, 21 Jun 2026 13:25:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782048345;
	bh=AI6d2N3sDXbYp77PzMe7UrlZuHh7qiXZM6tZz7y4a1Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=YXek3R+B63O/Z4YfSE2o3X9L0YkvgGFgbbxiXuG9CjhizcRgyH4NTaaE/XyrbXfz4
	 1yCH1cOhYJZl2TPyCcDyyfETrOiYFSvWM0T4y/4FjgG9G4JAvQOkl9+VwgGoWqfG3D
	 e4k7jeF2oJII5YRZ+5Tx5SWHIMtXnb4w1gfSbUi0/DJrUNotIRHFIQfIsXP1nEGTwL
	 2BRixjo2eMtJxlW3woVT0xh0tyKHJs1fR2G4kv28ubOlKUJ22cfjdxnL7yGH0TGzz7
	 oHunUFtPLv7A10AOe4oyUER7U3HkxVW6xjrlKKrZsy0K/KAEs3ZvuR/gOxaPhPz+qJ
	 ueYMkL6B+QHXg==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Sun, 21 Jun 2026 15:25:02 +0200
Subject: [PATCH 4/4] wifi: mt76: mt7996: fix possible NULL-pointer deref in
 mt7996_mcu_sta_bfer_eht()
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260621-mt76_connac_get_he_phy_cap-fix-v1-4-ed4ccf7a0363@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-37952-lists,linux-wireless=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 59C666AAE20

mt76_connac_get_eht_phy_cap routine can theoretically return NULL so
check cap pointer before dereferencing it.

Fixes: ba01944adee9f ("wifi: mt76: mt7996: add EHT beamforming support")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
index c868b1356894..063097fad825 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
@@ -1924,14 +1924,19 @@ mt7996_mcu_sta_bfer_eht(struct ieee80211_link_sta *link_sta,
 	struct ieee80211_sta_eht_cap *pc = &link_sta->eht_cap;
 	struct ieee80211_eht_cap_elem_fixed *pe = &pc->eht_cap_elem;
 	struct ieee80211_eht_mcs_nss_supp *eht_nss = &pc->eht_mcs_nss_supp;
-	const struct ieee80211_sta_eht_cap *vc =
 		mt76_connac_get_eht_phy_cap(phy->mt76, vif);
-	const struct ieee80211_eht_cap_elem_fixed *ve = &vc->eht_cap_elem;
 	u8 nss_mcs = u8_get_bits(eht_nss->bw._80.rx_tx_mcs9_max_nss,
 				 IEEE80211_EHT_MCS_NSS_RX) - 1;
+	const struct ieee80211_eht_cap_elem_fixed *ve;
+	const struct ieee80211_sta_eht_cap *vc;
 	u8 snd_dim, sts;
 
+	vc = mt76_connac_get_eht_phy_cap(phy->mt76, vif);
+	if (!vc)
+		return;
+
 	bf->tx_mode = MT_PHY_TYPE_EHT_MU;
+	ve = &vc->eht_cap_elem;
 
 	mt7996_mcu_sta_sounding_rate(bf, phy);
 

-- 
2.54.0


