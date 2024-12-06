Return-Path: <linux-wireless+bounces-15953-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A4C79E670F
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Dec 2024 06:58:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07A0A16600D
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Dec 2024 05:58:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04825198A0F;
	Fri,  6 Dec 2024 05:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="n8vyEWb3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C905A1B87CF
	for <linux-wireless@vger.kernel.org>; Fri,  6 Dec 2024 05:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733464678; cv=none; b=BjNoQGq2M0mX3AHO2N5Ei1Z3ueYLamIv2tzd+qfZ1FbI+MmG5Zz9P4gIXE9dav6pB6FcoBmT1f2rXjCGa9+c96tCT/70dK0/p1t7tI/M1yCT56E3EkxBSxb/ekoe8DuOqb4B1nqCSGmIGNcsIbJlqs/GN3738ULhyorKID9N7yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733464678; c=relaxed/simple;
	bh=XhOiXx0EtMBR15jOu8aYN/7rWzYH6pX/E2PkUtg+QdI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LJCIO7n/hxNvOAyzhI9iHiTW2PxDgq3e9Y6vi/zTXucHriWKJG9p7qcp1CIjq2tNl2LYi69RxrBMiw9CvYjaa7feBFKgJe1T2LQbvGxGS2CVfa5cNZDZ6BfLUhwMFOZjRCZytpzTOMoLSjps8M7EM1ehg57pigUdCfnM8spqaJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=n8vyEWb3; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4B65vtqN74127940, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1733464675; bh=XhOiXx0EtMBR15jOu8aYN/7rWzYH6pX/E2PkUtg+QdI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=n8vyEWb3q6Uar+Zx5xgKd7+ju8rODBI0CKDlQEjKk4rj53zwDwk/GYhVjALQMwBXl
	 7uiU71AMe3EnnuzlY7uoOADfabYy1f6RPLrYWfAQQNCFE2Vq8ZzAs3iwIcwJoy4LTv
	 yB4kSADSlqeicMEdVtHV8RYQZzO24PzRJRSs+Ew0GkVuOIJffiCq0+PZfQ0Cra9cAp
	 NWPdACthMvI67qHf0LPZnZUZA/cJVB0pjR0L7mMZscQ5c/A40hzM/9Z4vl7HLYtrag
	 F+W8CzsEbDDZDVyoWP0a6ZrKzUr8uXPPIfENWALoFf7CHin+uVLG5g0Hlmm6wEc2hS
	 J9v5AwWXHirag==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 4B65vtqN74127940
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Fri, 6 Dec 2024 13:57:55 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 6 Dec 2024 13:57:55 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 6 Dec
 2024 13:57:54 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <gary.chang@realtek.com>, <echuang@realtek.com>, <damon.chen@realtek.com>,
        <kevin_yang@realtek.com>
Subject: [PATCH 5/7] wifi: rtw89: 8852c: disable ER SU when 4x HE-LTF and 0.8 GI capability differ
Date: Fri, 6 Dec 2024 13:57:14 +0800
Message-ID: <20241206055716.18598-6-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241206055716.18598-1-pkshih@realtek.com>
References: <20241206055716.18598-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

From: Kuan-Chung Chen <damon.chen@realtek.com>

Since hardware only has single one register for HE-LTF setting,
to prevent interoperability issues, 8852CE disables ER SU when
the AP can handle SU/MU with 4x HE-LTF and 0.8 GI, but does
not support ER SU with the same settings.

Signed-off-by: Kuan-Chung Chen <damon.chen@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.c | 24 ++++++++++++++++++-----
 drivers/net/wireless/realtek/rtw89/core.h | 10 ++++++++++
 2 files changed, 29 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index ee6ad185135c..f848185e2ced 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -3844,6 +3844,22 @@ int rtw89_core_sta_link_disconnect(struct rtw89_dev *rtwdev,
 	return ret;
 }
 
+static bool rtw89_sta_link_can_er(struct rtw89_dev *rtwdev,
+				  struct ieee80211_bss_conf *bss_conf,
+				  struct ieee80211_link_sta *link_sta)
+{
+	if (!bss_conf->he_support ||
+	    bss_conf->he_oper.params & IEEE80211_HE_OPERATION_ER_SU_DISABLE)
+		return false;
+
+	if (rtwdev->chip->chip_id == RTL8852C &&
+	    rtw89_sta_link_has_su_mu_4xhe08(link_sta) &&
+	    !rtw89_sta_link_has_er_su_4xhe08(link_sta))
+		return false;
+
+	return true;
+}
+
 int rtw89_core_sta_link_assoc(struct rtw89_dev *rtwdev,
 			      struct rtw89_vif_link *rtwvif_link,
 			      struct rtw89_sta_link *rtwsta_link)
@@ -3854,12 +3870,11 @@ int rtw89_core_sta_link_assoc(struct rtw89_dev *rtwdev,
 									 rtwsta_link);
 	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev,
 						       rtwvif_link->chanctx_idx);
+	struct ieee80211_link_sta *link_sta;
 	int ret;
 
 	if (vif->type == NL80211_IFTYPE_AP || sta->tdls) {
 		if (sta->tdls) {
-			struct ieee80211_link_sta *link_sta;
-
 			rcu_read_lock();
 
 			link_sta = rtw89_sta_rcu_dereference_link(rtwsta_link, true);
@@ -3910,9 +3925,8 @@ int rtw89_core_sta_link_assoc(struct rtw89_dev *rtwdev,
 		rcu_read_lock();
 
 		bss_conf = rtw89_vif_rcu_dereference_link(rtwvif_link, true);
-		if (bss_conf->he_support &&
-		    !(bss_conf->he_oper.params & IEEE80211_HE_OPERATION_ER_SU_DISABLE))
-			rtwsta_link->er_cap = true;
+		link_sta = rtw89_sta_rcu_dereference_link(rtwsta_link, true);
+		rtwsta_link->er_cap = rtw89_sta_link_can_er(rtwdev, bss_conf, link_sta);
 
 		rcu_read_unlock();
 
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 15967978bf4a..c2b5eeb4a4f1 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -6885,6 +6885,16 @@ bool rtw89_sta_link_has_su_mu_4xhe08(struct ieee80211_link_sta *link_sta)
 	return false;
 }
 
+static inline
+bool rtw89_sta_link_has_er_su_4xhe08(struct ieee80211_link_sta *link_sta)
+{
+	if (link_sta->he_cap.he_cap_elem.phy_cap_info[8] &
+	    IEEE80211_HE_PHY_CAP8_HE_ER_SU_PPDU_4XLTF_AND_08_US_GI)
+		return true;
+
+	return false;
+}
+
 static inline struct rtw89_fw_suit *rtw89_fw_suit_get(struct rtw89_dev *rtwdev,
 						      enum rtw89_fw_type type)
 {
-- 
2.25.1


