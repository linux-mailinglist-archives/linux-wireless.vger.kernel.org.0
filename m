Return-Path: <linux-wireless+bounces-22137-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 530D3A9EF03
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Apr 2025 13:26:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE96917E1D2
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Apr 2025 11:26:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD2DF25D536;
	Mon, 28 Apr 2025 11:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="Q4twCd2Z"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF01025E800
	for <linux-wireless@vger.kernel.org>; Mon, 28 Apr 2025 11:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745839559; cv=none; b=lQlmf9zYesFuHO28uqBOi1Lc0MsUoRbJ6VD1RLSFchpZVAFNjnizQbR07oFC3t7Lbu8HW8evEQMGlVaeg+LcHlewqeJlrDaq5NwU+i/0MR0J6uyvQ8tA56Hby/rrJBrQ3mZ+L0ky+9ISQR0CNphxGZnZeGu1qjv3filoPpQ5HvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745839559; c=relaxed/simple;
	bh=bz643eCITrwLmZ6aGH6hiu8jcG/Gc2bzWLl/h7lAX/w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b6nmE59VXQVDlgNw64m0MuwDWQt4TKkUXaN2RbwxBWweYcrvGGO76kwJyWpIJ9g9mrFM8pdVaabJ0vSFvIZ7B8EwpRUEYrQrKmC49H/hFkrtOrXJPCRs5GRwjKiD41Fg+eAjhSjjcoI4E0RmjboSF4ZJ0v3ElmJ1yCKm+Hek7Tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=Q4twCd2Z; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 53SBPul162101264, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1745839556; bh=bz643eCITrwLmZ6aGH6hiu8jcG/Gc2bzWLl/h7lAX/w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=Q4twCd2ZZaLNTHLWaPbHkatt+4QGTJ3gO8Cato79bxw6yl7kc58SOjl95I5b05yI4
	 T3jEiKijYUAQiKt3NhGa1xGoK3ixUPXv6dyqKhDqKLXPOI8UO4R8Tpi/hd2yY9cgxe
	 tjX9X6oqnNEhTHlzREsermlib/nIONh7Hfp/kXZynm0OtWJvmK0jnrKdwJqAO+TadD
	 v8pXU3bKAn8DKTxGzSvY/QHAMITbXJ486txAIOC+Pv6aKoanVTtpzutflM1Dz3O5zA
	 lD4PiOUZF63jOOKFZL69U/RZDnx5zS8buBuvs5A/GIKScAWA/8LYHZgCGXe2eXYOmD
	 O+ezLeagFBsaw==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 53SBPul162101264
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Mon, 28 Apr 2025 19:25:56 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 28 Apr 2025 19:25:56 +0800
Received: from [127.0.1.1] (172.16.19.226) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 28 Apr
 2025 19:25:55 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <phhuang@realtek.com>, <kevin_yang@realtek.com>
Subject: [PATCH rtw-next 07/10] wifi: rtw89: add MLD capabilities declaration
Date: Mon, 28 Apr 2025 19:24:53 +0800
Message-ID: <20250428112456.13165-8-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250428112456.13165-1-pkshih@realtek.com>
References: <20250428112456.13165-1-pkshih@realtek.com>
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

From: Po-Hao Huang <phhuang@realtek.com>

Add MLD capabilities so association requests can carry multi-link
element with correct content.

Signed-off-by: Po-Hao Huang <phhuang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 93e7889eec96..fe482a923e8e 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -203,6 +203,23 @@ static const struct ieee80211_iface_combination rtw89_iface_combs[] = {
 	},
 };
 
+static const u8 rtw89_ext_capa_sta[] = {
+	[2] = WLAN_EXT_CAPA3_MULTI_BSSID_SUPPORT,
+	[7] = WLAN_EXT_CAPA8_OPMODE_NOTIF,
+};
+
+static const struct wiphy_iftype_ext_capab rtw89_iftypes_ext_capa[] = {
+	{
+		.iftype = NL80211_IFTYPE_STATION,
+		.extended_capabilities = rtw89_ext_capa_sta,
+		.extended_capabilities_mask = rtw89_ext_capa_sta,
+		.extended_capabilities_len = sizeof(rtw89_ext_capa_sta),
+		/* relevant only if EHT is supported */
+		.eml_capabilities = 0,
+		.mld_capa_and_ops = 0,
+	},
+};
+
 #define RTW89_6GHZ_SPAN_HEAD 6145
 #define RTW89_6GHZ_SPAN_IDX(center_freq) \
 	((((int)(center_freq) - RTW89_6GHZ_SPAN_HEAD) / 5) / 2)
@@ -5316,8 +5333,11 @@ static int rtw89_core_register_hw(struct rtw89_dev *rtwdev)
 	if (chip->chip_gen == RTW89_CHIP_BE)
 		hw->wiphy->flags |= WIPHY_FLAG_DISABLE_WEXT;
 
-	if (rtwdev->support_mlo)
+	if (rtwdev->support_mlo) {
 		hw->wiphy->flags |= WIPHY_FLAG_SUPPORTS_MLO;
+		hw->wiphy->iftype_ext_capab = rtw89_iftypes_ext_capa;
+		hw->wiphy->num_iftype_ext_capab = ARRAY_SIZE(rtw89_iftypes_ext_capa);
+	}
 
 	hw->wiphy->features |= NL80211_FEATURE_SCAN_RANDOM_MAC_ADDR;
 
-- 
2.25.1


