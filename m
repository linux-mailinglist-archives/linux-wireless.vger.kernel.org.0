Return-Path: <linux-wireless+bounces-32821-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +EnrE0DRr2kfcgIAu9opvQ
	(envelope-from <linux-wireless+bounces-32821-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Mar 2026 09:07:28 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C929B246F35
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Mar 2026 09:07:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2D49E3180B33
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Mar 2026 08:03:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC4903ECBD5;
	Tue, 10 Mar 2026 08:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="ugbQQtEg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52AE132AABC
	for <linux-wireless@vger.kernel.org>; Tue, 10 Mar 2026 08:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773129787; cv=none; b=V0p36GNuUpGtXUi7S5uq6H9e8KTpiRI4tFvK9WfF1Sd/DQt3R+ITx+D+V610YdxmGcEA1fFA6jBqBfeLIJcL8CCUNyhTiY0KGvGfR6+RYTxelnjHBOzDIePOiskGil1SssabdVkVNRmlLUx8aLaky0FRJChwMo1exOa5VUMnX3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773129787; c=relaxed/simple;
	bh=YkMp96bSqV5X2xRqE1tA1hLrYrnuoiBM0ghiAwA6Rhk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eSdf4V8hUNu7ykLm8C9wEuTQqcWLsEc7ExEK4PyNJv+fovSjTAlAKtItbcrSP2n922stIUHL3fZ3YE9QKiaQH7GvMVof/QKYijVjUzLu7QLjVWWlsFcVUzWsaRW3W+BoZuidtcBvKSJ9g1Aqms7sBRlwKsAOgnjV7ScCbkgJSgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=ugbQQtEg; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 62A834MN02211483, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1773129784; bh=lEWIoFmKpIW3vukZl+YO2Wk0d4wEP3acT+dAieQvEZY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=ugbQQtEg/uypdc55h5YSnUh3Ah1G9ci8wKyVAdpRYrnGh910q0FSF5nKI1osF8GqA
	 Pkru+kH5s0ONPpJNQoDArS1fQbYbC9Gbm8Lxl7b3BYSJ4d24Ioa1UOcvFMqCIrUKZQ
	 +9u3JCaYrxXueCGDB5bDrqbqzs2RxmAQUA9SsPLxBBEUlgmjT14CBXRuZeM/BJGwyV
	 D6ZXuTAmKVxskgrL+zOv12YLzUxKhm98xQb0myGrD9u0qylVovkRCdr13R8esvNpaW
	 kl8LBA8n+1IdJlAqJGtmunQyKjGQKUDtiZ/2/JXIn8sHpyi3zHH6n8U7bAeWQJhmGR
	 fvSU+Zt8kBJ7g==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 62A834MN02211483
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Tue, 10 Mar 2026 16:03:04 +0800
Received: from RTKEXHMBS01.realtek.com.tw (172.21.6.40) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Tue, 10 Mar 2026 16:03:04 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS01.realtek.com.tw (172.21.6.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 10 Mar 2026 16:03:04 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS06.realtek.com.tw
 (10.21.1.56) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Tue, 10 Mar 2026 16:03:04 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <timlee@realtek.com>, <phhuang@realtek.com>, <kevin_yang@realtek.com>
Subject: [PATCH rtw-next 12/13] wifi: rtw89: Recalculate station aggregates when AMSDU length changes for MLO links
Date: Tue, 10 Mar 2026 16:01:45 +0800
Message-ID: <20260310080146.31113-13-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260310080146.31113-1-pkshih@realtek.com>
References: <20260310080146.31113-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Rspamd-Queue-Id: C929B246F35
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-32821-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	TO_DN_NONE(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[realtek.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[realtek.com:dkim,realtek.com:email,realtek.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

From: Po-Hao Huang <phhuang@realtek.com>

Currently, AMSDU length is updated per-link for MLO but not propagated
to the station aggregates, causing suboptimal TX throughput. This change
ensures station aggregates are recalculated when any link's AMSDU length
changes.

Signed-off-by: Po-Hao Huang <phhuang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/phy.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/phy.c b/drivers/net/wireless/realtek/rtw89/phy.c
index 0fa4d8d791f1..3a241738ac06 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.c
+++ b/drivers/net/wireless/realtek/rtw89/phy.c
@@ -3213,7 +3213,8 @@ struct rtw89_phy_iter_ra_data {
 
 static void __rtw89_phy_c2h_ra_rpt_iter(struct rtw89_sta_link *rtwsta_link,
 					struct ieee80211_link_sta *link_sta,
-					struct rtw89_phy_iter_ra_data *ra_data)
+					struct rtw89_phy_iter_ra_data *ra_data,
+					bool *changed)
 {
 	struct rtw89_dev *rtwdev = ra_data->rtwdev;
 	const struct rtw89_c2h_ra_rpt *c2h =
@@ -3222,7 +3223,7 @@ static void __rtw89_phy_c2h_ra_rpt_iter(struct rtw89_sta_link *rtwsta_link,
 	const struct rtw89_chip_info *chip = rtwdev->chip;
 	bool format_v1 = chip->chip_gen == RTW89_CHIP_BE;
 	u8 mode, rate, bw, giltf, mac_id;
-	u16 legacy_bitrate;
+	u16 legacy_bitrate, amsdu_len;
 	bool valid;
 	u8 mcs = 0;
 	u8 t;
@@ -3319,7 +3320,13 @@ static void __rtw89_phy_c2h_ra_rpt_iter(struct rtw89_sta_link *rtwsta_link,
 			     u16_encode_bits(mode, RTW89_HW_RATE_MASK_MOD) |
 			     u16_encode_bits(rate, RTW89_HW_RATE_MASK_VAL);
 	ra_report->might_fallback_legacy = mcs <= 2;
-	link_sta->agg.max_rc_amsdu_len = get_max_amsdu_len(rtwdev, ra_report);
+
+	amsdu_len = get_max_amsdu_len(rtwdev, ra_report);
+	if (link_sta->agg.max_rc_amsdu_len != amsdu_len) {
+		link_sta->agg.max_rc_amsdu_len = amsdu_len;
+		*changed = true;
+	}
+
 	rtwsta_link->max_agg_wait = link_sta->agg.max_rc_amsdu_len / 1500 - 1;
 }
 
@@ -3330,14 +3337,18 @@ static void rtw89_phy_c2h_ra_rpt_iter(void *data, struct ieee80211_sta *sta)
 	struct rtw89_sta_link *rtwsta_link;
 	struct ieee80211_link_sta *link_sta;
 	unsigned int link_id;
+	bool changed = false;
 
 	rcu_read_lock();
 
 	rtw89_sta_for_each_link(rtwsta, rtwsta_link, link_id) {
 		link_sta = rtw89_sta_rcu_dereference_link(rtwsta_link, false);
-		__rtw89_phy_c2h_ra_rpt_iter(rtwsta_link, link_sta, ra_data);
+		__rtw89_phy_c2h_ra_rpt_iter(rtwsta_link, link_sta, ra_data, &changed);
 	}
 
+	if (changed)
+		ieee80211_sta_recalc_aggregates(sta);
+
 	rcu_read_unlock();
 }
 
-- 
2.25.1


