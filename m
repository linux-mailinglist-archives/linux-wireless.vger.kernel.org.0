Return-Path: <linux-wireless+bounces-7161-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 357B08BBAA6
	for <lists+linux-wireless@lfdr.de>; Sat,  4 May 2024 13:19:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 384351C20D41
	for <lists+linux-wireless@lfdr.de>; Sat,  4 May 2024 11:19:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 916981B812;
	Sat,  4 May 2024 11:19:28 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1D2B18C3D
	for <linux-wireless@vger.kernel.org>; Sat,  4 May 2024 11:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714821568; cv=none; b=QqpOSU3herHil/MLw091hYgIr233EJQp/797zkZ93Sx6MaiGGxAnb+4z1W0gycZYRWYfo90FuprmgQI1E1sqQFxID7wZwCbe+8wJnESkmzMe9ZpYdCjDAm4GuegxYtdFlRlt7r0ceKg8eF0kMFQl7qD63kH95gNdKIkKuKtFlhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714821568; c=relaxed/simple;
	bh=IkaCTM8ZOoAL9UcNF7S5h0VYV9IUC8ipKJGvXAfOmfM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BWgogCHu6YB3nx9oOV5ImUjHKbjwmhHqlr/eLJar4bWTgtDpkJOYS6XoqcLu2VgF5EsdTo8qE+3AnRq+4s8CVX1/AeF5vX9hOb6fr9CHSet61PWtuDH7DZ/ONTt40oDqPSBcQpX22VBgPNF0Y75qh5sqFvq5V8Rdsi/ZeK/i7y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 444BJMrQ4197679, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 444BJMrQ4197679
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 4 May 2024 19:19:22 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sat, 4 May 2024 19:19:22 +0800
Received: from [127.0.1.1] (172.16.16.175) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Sat, 4 May
 2024 19:19:22 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <rtl8821cerfe2@gmail.com>
Subject: [PATCH] wifi: rtlwifi: 8192d: initialize rate_mask in rtl92de_update_hal_rate_mask()
Date: Sat, 4 May 2024 19:19:16 +0800
Message-ID: <20240504111916.31445-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
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
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback

le32p_replace_bits() only updates partial bits of rate_mask, and gcc warns
below. Set initial value to avoid warnings, and prevent random value of
missed bits (bit 6 of rate_mask.macid_and_short_gi).

In file included from ./include/linux/fortify-string.h:5,
                 from ./include/linux/string.h:369,
                 from ./include/linux/bitmap.h:13,
                 from ./include/linux/cpumask.h:13,
                 from ./include/linux/sched.h:16,
                 from drivers/net/wireless/realtek/rtlwifi/rtl8192d/../wifi.h:9,
                 from drivers/net/wireless/realtek/rtlwifi/rtl8192d/hw_common.c:4:
In function 'le32p_replace_bits',
    inlined from 'rtl92de_update_hal_rate_mask.isra' at drivers/net/wireless/realtek/rtlwifi/rtl8192d/hw_common.c:986:2:
./include/linux/bitfield.h:189:15: warning: 'rate_mask' is used uninitialized [-Wuninitialized]
  189 |         *p = (*p & ~to(field)) | type##_encode_bits(val, field);        \
      |               ^~
./include/linux/bitfield.h:196:9: note: in expansion of macro '____MAKE_OP'
  196 |         ____MAKE_OP(le##size,u##size,cpu_to_le##size,le##size##_to_cpu) \
      |         ^~~~~~~~~~~
./include/linux/bitfield.h:201:1: note: in expansion of macro '__MAKE_OP'
  201 | __MAKE_OP(32)
      | ^~~~~~~~~
drivers/net/wireless/realtek/rtlwifi/rtl8192d/hw_common.c: In function 'rtl92de_update_hal_rate_mask.isra':
drivers/net/wireless/realtek/rtlwifi/rtl8192d/hw_common.c:863:37: note: 'rate_mask' declared here
  863 |         struct rtl92d_rate_mask_h2c rate_mask;
      |                                     ^~~~~~~~~

Fixes: 014bba73b525 ("wifi: rtlwifi: Adjust rtl8192d-common for USB")
Cc: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtlwifi/rtl8192d/hw_common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192d/hw_common.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192d/hw_common.c
index 920bfb4eaaef..6570d5e168e9 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192d/hw_common.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192d/hw_common.c
@@ -857,10 +857,10 @@ static void rtl92de_update_hal_rate_mask(struct ieee80211_hw *hw,
 {
 	struct rtl_hal *rtlhal = rtl_hal(rtl_priv(hw));
 	struct rtl_mac *mac = rtl_mac(rtl_priv(hw));
+	struct rtl92d_rate_mask_h2c rate_mask = {};
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 	struct rtl_phy *rtlphy = &rtlpriv->phy;
 	struct rtl_sta_info *sta_entry = NULL;
-	struct rtl92d_rate_mask_h2c rate_mask;
 	enum wireless_mode wirelessmode;
 	bool shortgi = false;
 	u8 curshortgi_40mhz;
-- 
2.25.1


