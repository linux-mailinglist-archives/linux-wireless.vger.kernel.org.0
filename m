Return-Path: <linux-wireless+bounces-14214-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A05FB9A4241
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Oct 2024 17:23:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CCBB1F28D18
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Oct 2024 15:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF2E5201100;
	Fri, 18 Oct 2024 15:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g7i5uxKe"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79AC22010F0;
	Fri, 18 Oct 2024 15:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729264998; cv=none; b=cb01OBt0+4zts5JOcZWK/yWyA8Gxw4XEeRRS/AXg0DG6o6SKzB12yO6a5C+DcVMqqjCf8KpL6RwKfjd1U1esMGnAWgXk2TrEYZvVC/FWei3jMo688mTUc7E3WHQHassyKpk8KEsL0ULdyq3Ad+dU7nLRz/LG4puoiWcpjHGn0fE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729264998; c=relaxed/simple;
	bh=CxkuYeapXtUVsDlCc28E9Iy/192+YAlGn6UxeAQPmms=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sNWF46qbgq1uWc1Ys6xGcP8dK5wUmEo0+2t1OTMJmoHCOIjlFFBoksN7XO1hpzcVPl/EwL6wQKwq26BCAy3R4J1dyVws8G5m2OZdsluY6zZy6TdaJnbNAo0Y0a8RvxuQrZj/X093iwu3NVd2/WBTsU3a8Fqh3Kq3gtqb7bJGqtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g7i5uxKe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A732C4CEC3;
	Fri, 18 Oct 2024 15:23:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729264998;
	bh=CxkuYeapXtUVsDlCc28E9Iy/192+YAlGn6UxeAQPmms=;
	h=From:To:Cc:Subject:Date:From;
	b=g7i5uxKe3rT7ZBt81OUoHh5Jlsvi6b8SjgNVu4Q7C4YSr1EfvOLI6+2rfJn0hTc93
	 hk23hkFGzz14BUehPnEYg/8LDnRM2aqakciLnfv2bBanNV8A29bbz5dDjYWqmWnTFN
	 f6Ex1H69BKLwmmnJ8DIxUcp1tf2FINCLoYNHw2cE76bkrDmR8LGf1hmzEZy83ronnR
	 2qPAL1Qizt3xykcue85Eyuvcjht1d62aEVQMeqyNaGajaVONJk1lkH1qWdnvSE9l3W
	 buF1iBMIGu8PC9r6a8qMMYN6DmN7aYQUsurrtoO7c+N6Q2A6bh/RSSwUaLxjokcrda
	 rt7YURxOn3rCQ==
From: Arnd Bergmann <arnd@kernel.org>
To: Ping-Ke Shih <pkshih@realtek.com>,
	Kalle Valo <kvalo@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Zong-Zhe Yang <kevin_yang@realtek.com>,
	Kuan-Chung Chen <damon.chen@realtek.com>,
	Chih-Kang Chang <gary.chang@realtek.com>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH] rtw89: -Wenum-compare-conditional warnings
Date: Fri, 18 Oct 2024 15:23:07 +0000
Message-Id: <20241018152311.4023979-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

This is one of three drivers that trigger -Wenum-compare-conditional warnings
with clang:

drivers/net/wireless/realtek/rtw89/core.c:1806:14: error: conditional expression between different enumeration types ('enum nl80211_eht_gi' and 'enum nl80211_he_gi') [-Werror,-Wenum-compare-conditional]
 1806 |                 return eht ? NL80211_RATE_INFO_EHT_GI_0_8 :
      |                            ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 1807 |                              NL80211_RATE_INFO_HE_GI_0_8;
      |                              ~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/wireless/realtek/rtw89/core.c:1810:14: error: conditional expression between different enumeration types ('enum nl80211_eht_gi' and 'enum nl80211_he_gi') [-Werror,-Wenum-compare-conditional]
 1810 |                 return eht ? NL80211_RATE_INFO_EHT_GI_1_6 :
      |                            ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 1811 |                              NL80211_RATE_INFO_HE_GI_1_6;
      |                              ~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/wireless/realtek/rtw89/core.c:1813:14: error: conditional expression between different enumeration types ('enum nl80211_eht_gi' and 'enum nl80211_he_gi') [-Werror,-Wenum-compare-conditional]
 1813 |                 return eht ? NL80211_RATE_INFO_EHT_GI_3_2 :
      |                            ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 1814 |                              NL80211_RATE_INFO_HE_GI_3_2;
      |                              ~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/wireless/realtek/rtw89/core.c:1818:15: error: conditional expression between different enumeration types ('enum nl80211_eht_gi' and 'enum nl80211_he_gi') [-Werror,-Wenum-compare-conditional]
 1818 |                         return eht ? NL80211_RATE_INFO_EHT_GI_3_2 :
      |                                    ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 1819 |                                      NL80211_RATE_INFO_HE_GI_3_2;
      |                                      ~~~~~~~~~~~~~~~~~~~~~~~~~~~

In this case, all four warnings can be easily avoided by splitting the
function into two separate ones, in a way that helps readability as well,
at the expense of a few extra source lines.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/net/wireless/realtek/rtw89/core.c | 48 +++++++++++++++++------
 1 file changed, 37 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index bba5bde95bb4..62e873fa1659 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -1858,32 +1858,58 @@ static void rtw89_core_rx_process_phy_sts(struct rtw89_dev *rtwdev,
 					  phy_ppdu);
 }
 
-static u8 rtw89_rxdesc_to_nl_he_eht_gi(struct rtw89_dev *rtwdev,
-				       u8 desc_info_gi,
-				       bool rx_status, bool eht)
+static u8 rtw89_rxdesc_to_nl_he_gi(struct rtw89_dev *rtwdev,
+				   u8 desc_info_gi,
+				   bool rx_status)
+{
+	switch (desc_info_gi) {
+	case RTW89_GILTF_SGI_4XHE08:
+	case RTW89_GILTF_2XHE08:
+	case RTW89_GILTF_1XHE08:
+		return NL80211_RATE_INFO_HE_GI_0_8;
+	case RTW89_GILTF_2XHE16:
+	case RTW89_GILTF_1XHE16:
+		return NL80211_RATE_INFO_HE_GI_1_6;
+	case RTW89_GILTF_LGI_4XHE32:
+		return NL80211_RATE_INFO_HE_GI_3_2;
+	default:
+		rtw89_warn(rtwdev, "invalid gi_ltf=%d", desc_info_gi);
+		if (rx_status)
+			return NL80211_RATE_INFO_HE_GI_3_2;
+		return U8_MAX;
+	}
+}
+
+static u8 rtw89_rxdesc_to_nl_eht_gi(struct rtw89_dev *rtwdev,
+				    u8 desc_info_gi,
+				    bool rx_status)
 {
 	switch (desc_info_gi) {
 	case RTW89_GILTF_SGI_4XHE08:
 	case RTW89_GILTF_2XHE08:
 	case RTW89_GILTF_1XHE08:
-		return eht ? NL80211_RATE_INFO_EHT_GI_0_8 :
-			     NL80211_RATE_INFO_HE_GI_0_8;
+		return NL80211_RATE_INFO_EHT_GI_0_8;
 	case RTW89_GILTF_2XHE16:
 	case RTW89_GILTF_1XHE16:
-		return eht ? NL80211_RATE_INFO_EHT_GI_1_6 :
-			     NL80211_RATE_INFO_HE_GI_1_6;
+		return NL80211_RATE_INFO_EHT_GI_1_6;
 	case RTW89_GILTF_LGI_4XHE32:
-		return eht ? NL80211_RATE_INFO_EHT_GI_3_2 :
-			     NL80211_RATE_INFO_HE_GI_3_2;
+		return NL80211_RATE_INFO_EHT_GI_3_2;
 	default:
 		rtw89_warn(rtwdev, "invalid gi_ltf=%d", desc_info_gi);
 		if (rx_status)
-			return eht ? NL80211_RATE_INFO_EHT_GI_3_2 :
-				     NL80211_RATE_INFO_HE_GI_3_2;
+			return NL80211_RATE_INFO_EHT_GI_3_2;
 		return U8_MAX;
 	}
 }
 
+static u8 rtw89_rxdesc_to_nl_he_eht_gi(struct rtw89_dev *rtwdev,
+				       u8 desc_info_gi,
+				       bool rx_status, bool eht)
+{
+	return eht ? rtw89_rxdesc_to_nl_eht_gi(rtwdev, desc_info_gi, rx_status) :
+		     rtw89_rxdesc_to_nl_he_gi(rtwdev, desc_info_gi, rx_status);
+}
+
 static
 bool rtw89_check_rx_statu_gi_match(struct ieee80211_rx_status *status, u8 gi_ltf,
 				   bool eht)
-- 
2.39.5


