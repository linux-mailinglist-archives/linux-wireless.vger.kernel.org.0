Return-Path: <linux-wireless+bounces-23921-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 351A4AD31CA
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Jun 2025 11:23:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93B2E161B9C
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Jun 2025 09:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C73F028B7C3;
	Tue, 10 Jun 2025 09:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EuNhUTci"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89C6C28BA8A;
	Tue, 10 Jun 2025 09:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749547365; cv=none; b=DHDVjgIGH77EQ1vVBSLCcJW0KoSFd7q6YLnEVxC3F/rGv7GC2sEt9BQOruqfKI3jpj/3djI2fn2/naHDuwAUFgICYmJBYJlDuHiPRwJkohLb869DHE8EIHaQaSUxcygnJGFzZ5vnvdKgMs2d4lVqOcNTKVMMgBZMt1O0OxI/6RY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749547365; c=relaxed/simple;
	bh=GGWJX/CY8ZcfVf5nxDMlSkEjgxBWRwIXN/J9cI7AzLQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SpGz5RnlHJcEQ6NlVehZAYjf3FcblIz1j8lTLsYMInZJ0YUu5wxw9QwdOS9YX55eFo9l95/MKr08uee/zMYkK1pZ3XH+MKBrUbM4Z1l5v9xtWkUea7Rp7C8H3uSeC5TvtAvAF3hhbb7d1D9CHhQspSrZoMzaEkiwy7u4NHCWyeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EuNhUTci; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1CA6C4CEF4;
	Tue, 10 Jun 2025 09:22:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749547365;
	bh=GGWJX/CY8ZcfVf5nxDMlSkEjgxBWRwIXN/J9cI7AzLQ=;
	h=From:To:Cc:Subject:Date:From;
	b=EuNhUTciueW3kiJXHmvipGRrTOmrfjAQsd7UYwr6MKVhCIfWliFI6z+Gv2ui6OpOo
	 honYtOlD1FSf0URAjnfBHGYciP62Xb23IoTE7vynrYS+kNQXPAwgitxASVHwpkPYiT
	 QdL5GBGfqD+HWMk2n2B4xe2QgvGhfsEsnkR17ZoqP8gmECqJcDdHotz1LjxNVZ1sw1
	 LGFCL55oQ7BLlpa+5tnlW6tpkBRbe0fMgCyns0HWJUKwhrdFc6tDUyjYB31sOL3twm
	 1gysbNymqouUXYeZcqPnb7KZOZMqXxWdFetlqtjvP3/GUmaISrFfUAOfTE0scuKE/F
	 Y5ZnUvNJ4g/3g==
From: Arnd Bergmann <arnd@kernel.org>
To: Ping-Ke Shih <pkshih@realtek.com>,
	Nathan Chancellor <nathan@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	Colin Ian King <colin.i.king@gmail.com>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH] wifi: rtlwifi: avoid stack size warning for _read_eeprom_info
Date: Tue, 10 Jun 2025 11:22:23 +0200
Message-Id: <20250610092240.2639751-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

txpower_info_{2g,5g} are too big to fit on the stack, but in most of the
rtlwifi variants this stays below the warning limit for stack frames.
In rtl8192ee and a few others, I see a case where clang decides to fully
inline this into rtl92ee_read_eeprom_info, triggering this warning:

drivers/net/wireless/realtek/rtlwifi/rtl8192ee/hw.c:2178:6: error: stack frame size (1312) exceeds limit (1280) in 'rtl92ee_read_eeprom_info' [-Werror,-Wframe-larger-than]

Mark _rtl92ee_read_txpower_info_from_hwpg() as noinline_for_stack to
and mark _rtl92ee_get_chnl_group() as __always_inline to make clang
behave the same way as gcc. Inlining _rtl92ee_get_chnl_group helps
let the compiler see that the index is always in range. The same
change appears to be necessary in all rtlwifi variants.

A more thorough approach would be to avoid the use of the two structures
on the stack entirely and combine them with the struct rtl_efuse
data that is dynamically allocated and holds the same information.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/net/wireless/realtek/rtlwifi/rtl8188ee/hw.c | 6 +++---
 drivers/net/wireless/realtek/rtlwifi/rtl8192ce/hw.c | 6 +++---
 drivers/net/wireless/realtek/rtlwifi/rtl8192cu/hw.c | 6 +++---
 drivers/net/wireless/realtek/rtlwifi/rtl8192ee/hw.c | 7 ++++---
 drivers/net/wireless/realtek/rtlwifi/rtl8723ae/hw.c | 6 +++---
 drivers/net/wireless/realtek/rtlwifi/rtl8723be/hw.c | 6 +++---
 drivers/net/wireless/realtek/rtlwifi/rtl8821ae/hw.c | 6 +++---
 7 files changed, 22 insertions(+), 21 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/hw.c b/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/hw.c
index d122f1eb345e..53c32e1de7e4 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/hw.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/hw.c
@@ -1738,9 +1738,9 @@ static void read_power_value_fromprom(struct ieee80211_hw *hw,
 	}
 }
 
-static void _rtl88ee_read_txpower_info_from_hwpg(struct ieee80211_hw *hw,
-						 bool autoload_fail,
-						 u8 *hwinfo)
+static noinline_for_stack void
+_rtl88ee_read_txpower_info_from_hwpg(struct ieee80211_hw *hw,
+				     bool autoload_fail, u8 *hwinfo)
 {
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 	struct rtl_efuse *rtlefuse = rtl_efuse(rtl_priv(hw));
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192ce/hw.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192ce/hw.c
index 0bc915723b93..5ca6b49e73c7 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192ce/hw.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192ce/hw.c
@@ -1412,9 +1412,9 @@ void rtl92ce_update_interrupt_mask(struct ieee80211_hw *hw,
 	rtl92ce_enable_interrupt(hw);
 }
 
-static void _rtl92ce_read_txpower_info_from_hwpg(struct ieee80211_hw *hw,
-						 bool autoload_fail,
-						 u8 *hwinfo)
+static noinline_for_stack void
+_rtl92ce_read_txpower_info_from_hwpg(struct ieee80211_hw *hw,
+				     bool autoload_fail, u8 *hwinfo)
 {
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 	struct rtl_efuse *rtlefuse = rtl_efuse(rtl_priv(hw));
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/hw.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/hw.c
index 0195c9a3e9e8..ec5d558609fe 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/hw.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/hw.c
@@ -95,9 +95,9 @@ static void _rtl92cu_phy_param_tab_init(struct ieee80211_hw *hw)
 	}
 }
 
-static void _rtl92cu_read_txpower_info_from_hwpg(struct ieee80211_hw *hw,
-						 bool autoload_fail,
-						 u8 *hwinfo)
+static noinline_for_stack void
+_rtl92cu_read_txpower_info_from_hwpg(struct ieee80211_hw *hw,
+				     bool autoload_fail, u8 *hwinfo)
 {
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 	struct rtl_efuse *rtlefuse = rtl_efuse(rtl_priv(hw));
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192ee/hw.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192ee/hw.c
index d4da5cdc8414..48a3c94606be 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192ee/hw.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192ee/hw.c
@@ -1731,7 +1731,7 @@ void rtl92ee_update_interrupt_mask(struct ieee80211_hw *hw,
 	rtl92ee_enable_interrupt(hw);
 }
 
-static u8 _rtl92ee_get_chnl_group(u8 chnl)
+static __always_inline u8 _rtl92ee_get_chnl_group(u8 chnl)
 {
 	u8 group = 0;
 
@@ -2009,8 +2009,9 @@ static void _rtl8192ee_read_power_value_fromprom(struct ieee80211_hw *hw,
 	}
 }
 
-static void _rtl92ee_read_txpower_info_from_hwpg(struct ieee80211_hw *hw,
-						 bool autoload_fail, u8 *hwinfo)
+static noinline_for_stack void
+_rtl92ee_read_txpower_info_from_hwpg(struct ieee80211_hw *hw,
+				     bool autoload_fail, u8 *hwinfo)
 {
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 	struct rtl_efuse *efu = rtl_efuse(rtl_priv(hw));
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8723ae/hw.c b/drivers/net/wireless/realtek/rtlwifi/rtl8723ae/hw.c
index 6991713a66d0..21b827f519b6 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8723ae/hw.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8723ae/hw.c
@@ -1381,9 +1381,9 @@ static u8 _rtl8723e_get_chnl_group(u8 chnl)
 	return group;
 }
 
-static void _rtl8723e_read_txpower_info_from_hwpg(struct ieee80211_hw *hw,
-						  bool autoload_fail,
-						  u8 *hwinfo)
+static noinline_for_stack void
+_rtl8723e_read_txpower_info_from_hwpg(struct ieee80211_hw *hw,
+				      bool autoload_fail, u8 *hwinfo)
 {
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 	struct rtl_efuse *rtlefuse = rtl_efuse(rtl_priv(hw));
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8723be/hw.c b/drivers/net/wireless/realtek/rtlwifi/rtl8723be/hw.c
index bcfc53af4c1a..e1f811218894 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8723be/hw.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8723be/hw.c
@@ -1935,9 +1935,9 @@ static void _rtl8723be_read_power_value_fromprom(struct ieee80211_hw *hw,
 	}
 }
 
-static void _rtl8723be_read_txpower_info_from_hwpg(struct ieee80211_hw *hw,
-						   bool autoload_fail,
-						   u8 *hwinfo)
+static noinline_for_stack void
+_rtl8723be_read_txpower_info_from_hwpg(struct ieee80211_hw *hw,
+				       bool autoload_fail, u8 *hwinfo)
 {
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 	struct rtl_efuse *rtlefuse = rtl_efuse(rtl_priv(hw));
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/hw.c b/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/hw.c
index f4b232f038a9..8c51f4d36820 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/hw.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/hw.c
@@ -2782,9 +2782,9 @@ static void _rtl8812ae_read_txpower_info_from_hwpg(struct ieee80211_hw *hw,
 	"eeprom_regulatory = 0x%x\n", rtlefuse->eeprom_regulatory);
 }
 #endif
-static void _rtl8821ae_read_txpower_info_from_hwpg(struct ieee80211_hw *hw,
-						 bool autoload_fail,
-						 u8 *hwinfo)
+static noinline_for_stack void
+_rtl8821ae_read_txpower_info_from_hwpg(struct ieee80211_hw *hw,
+				       bool autoload_fail, u8 *hwinfo)
 {
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 	struct rtl_efuse *rtlefuse = rtl_efuse(rtl_priv(hw));
-- 
2.39.5


