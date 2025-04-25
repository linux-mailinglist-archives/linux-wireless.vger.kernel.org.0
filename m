Return-Path: <linux-wireless+bounces-22090-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8676EA9D66F
	for <lists+linux-wireless@lfdr.de>; Sat, 26 Apr 2025 01:54:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C4957A73A9
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Apr 2025 23:52:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8002297A6B;
	Fri, 25 Apr 2025 23:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="jYMm9avp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74CD92973DF;
	Fri, 25 Apr 2025 23:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745625232; cv=none; b=EPrHEdLBc9zH5PZjfdZhhnNcqSczhxAV5WH3e1ZNblQbyyuH0Ty6uhNBEwYmOZPy/k6Z5Rnc8hHbgpnEOEg8YJzePVTAgJUh/RmsOFOlMf1QcxNEo0Tyl0kt4BxlBs1tzycedOQQjX3+Fse6N7kSU3J3NdszYlPeiQ+1kGaXl5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745625232; c=relaxed/simple;
	bh=DfeUcwLQhZHttJw8aimTseOrW2w7UvKeVd0ur7aobO8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pB+5Zqt8QQlDb80wSCq/DUT8+e82JJ/mhFV01RA1RO+pHeNULh3pjpp7blvCebJE4l/Api4UJFWgJhx0NPLqWi+JQjrT3WoIRWUV96fcC8GJWSAjy1wkaT4UyEqkqhf3qO9EMmikW/1FNg5CODSgjwGjpLZAvA4nmD6KhHwMNnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=jYMm9avp; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=w5pZrBFL/u9982/vWkPNm+XymCrUQB2ffhg1beVcaYc=; b=jYMm9avpniqeulyG
	iRvA9AVLXltbCFqQF5jY44AIq/7BLhQYu48tFmvhACgldGy+qlRG7Gk+SpjwptfbTFRpC9ufvA0OT
	G+ddKErDbbBwvgVcB/TB3jLwGPKhFHJrJc59fiwLIrbg/QH/5fwk+txi/zrZEdJS2lOYKvRdMVFHV
	8Lw2iwcuSsJnpwpV/sfHrxfuq7uKdJQbN14RWOfZHySTNR7MVFBGryhFs2rmY711g3BFZKBJqGuMZ
	mqzTScdTxZtEt+bJ1ttM/EKKjoiqsadDPSIEI7QtlAelc2Y6q8xBs7dNM+GeepfrJ+2PffDarZNwx
	h6ut+B4h0FLD2PhVZQ==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1u8SrW-00Dznj-0U;
	Fri, 25 Apr 2025 23:53:42 +0000
From: linux@treblig.org
To: pkshih@realtek.com,
	linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH 3/3] wifi: rtlwifi: Remove unused rtl_bb_delay()
Date: Sat, 26 Apr 2025 00:53:40 +0100
Message-ID: <20250425235340.288340-4-linux@treblig.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250425235340.288340-1-linux@treblig.org>
References: <20250425235340.288340-1-linux@treblig.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

The last use of rtl_bb_delay() was removed in 2014's
commit 5c99f04fec93 ("rtlwifi: rtl8723be: Update driver to match Realtek
release of 06/28/14")

Remove it.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 drivers/net/wireless/realtek/rtlwifi/core.c | 11 -----------
 drivers/net/wireless/realtek/rtlwifi/core.h |  1 -
 2 files changed, 12 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/core.c b/drivers/net/wireless/realtek/rtlwifi/core.c
index 7537f04b1930..819cf519e66e 100644
--- a/drivers/net/wireless/realtek/rtlwifi/core.c
+++ b/drivers/net/wireless/realtek/rtlwifi/core.c
@@ -58,17 +58,6 @@ void rtl_rfreg_delay(struct ieee80211_hw *hw, enum radio_path rfpath, u32 addr,
 }
 EXPORT_SYMBOL(rtl_rfreg_delay);
 
-void rtl_bb_delay(struct ieee80211_hw *hw, u32 addr, u32 data)
-{
-	if (addr >= 0xf9 && addr <= 0xfe) {
-		rtl_addr_delay(addr);
-	} else {
-		rtl_set_bbreg(hw, addr, MASKDWORD, data);
-		udelay(1);
-	}
-}
-EXPORT_SYMBOL(rtl_bb_delay);
-
 static void rtl_fw_do_work(const struct firmware *firmware, void *context,
 			   bool is_wow)
 {
diff --git a/drivers/net/wireless/realtek/rtlwifi/core.h b/drivers/net/wireless/realtek/rtlwifi/core.h
index 42c2d9e13bb8..45225d89ac5e 100644
--- a/drivers/net/wireless/realtek/rtlwifi/core.h
+++ b/drivers/net/wireless/realtek/rtlwifi/core.h
@@ -58,7 +58,6 @@ void rtl_wowlan_fw_cb(const struct firmware *firmware, void *context);
 void rtl_addr_delay(u32 addr);
 void rtl_rfreg_delay(struct ieee80211_hw *hw, enum radio_path rfpath, u32 addr,
 		     u32 mask, u32 data);
-void rtl_bb_delay(struct ieee80211_hw *hw, u32 addr, u32 data);
 bool rtl_cmd_send_packet(struct ieee80211_hw *hw, struct sk_buff *skb);
 bool rtl_btc_status_false(void);
 void rtl_dm_diginit(struct ieee80211_hw *hw, u32 cur_igval);
-- 
2.49.0


