Return-Path: <linux-wireless+bounces-14849-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C999B9BA66C
	for <lists+linux-wireless@lfdr.de>; Sun,  3 Nov 2024 16:39:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F44FB20EE2
	for <lists+linux-wireless@lfdr.de>; Sun,  3 Nov 2024 15:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CC7B187350;
	Sun,  3 Nov 2024 15:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="k89PUUnl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DAE2170A01;
	Sun,  3 Nov 2024 15:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730648349; cv=none; b=kYatG+1C0PwHOfVMlaHXiL+UM94uOCcDzrEXQ5mqBaXPl0hd4ht0g01UyTnUTlNlNwB5zcEvMNK1SJfi1fLuhYkLLYu0vA7F5YQrrr5ICgXd6LRd7AaM4C5LJH2ahChTXHBgEGXNaSs6PgWvDBk6Ah/lnoHWoGBx+l+zeFCuNjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730648349; c=relaxed/simple;
	bh=/qbn+Pd3oIBgfObvF6LHb4lvvo2uaHOE6T4OTjmhW54=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gvf60OtmwDKGymywvu4I5e+w5dAIWy2PZ/ED5gBYiTWUt2x/tQ4YhoP1sX9yeuoSHJoQkuZ976YG+RNNDg6EzhjemvtCFEmFOiW86mdtaAi4ykATEE6uaYG+scWVYhcZREkIaKSxEdRJ87VxF1CMNxS+0k1tYIf2iF0VQjm0eqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=k89PUUnl; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=lSEkuKEdaE1JdTruufXmwcarX+kHRCnCzmOMFP7aTz8=; b=k89PUUnlv18S9ZwE
	kIs4gRND+xEGtFUiMEDT5Aiqkl/LwEivtG5dR/nz0sxQBNDjOdcoyKNdsHY0ksyypkHcj9XuclSyh
	URlqdSXvUltOnPowDuwD0w6g9pHnUDU7HntGnM3NHh/EnoMj2zoiZfRX+CDBvmOmMT5U8VoccCIg/
	RY9bUABHmdVgDmeQ1zYVkB/rSbnFabclJ4ktMqE52OZZknpXNdSXsqXz/sxoPdfyfQqIatyGl+mtF
	vybUuRZNLSjRHeg++JffdnmW+GgxNvSzWGLG0ygU8fPDw+7xmNLHlPft+iz4L6hBYI7i1mEen1k77
	s7QjAIYNHfg5Iw5CNA==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1t7cgt-00FBKZ-37;
	Sun, 03 Nov 2024 15:38:59 +0000
From: linux@treblig.org
To: pkshih@realtek.com,
	kvalo@kernel.org,
	linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH 2/2] rtlwifi: Remove more unused functions
Date: Sun,  3 Nov 2024 15:38:57 +0000
Message-ID: <20241103153857.255450-3-linux@treblig.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241103153857.255450-1-linux@treblig.org>
References: <20241103153857.255450-1-linux@treblig.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

exhalbtc_dbg_control(), exhalbtc_stack_update_profile_info(),
exhalbtc_set_hci_version(), and exhalbtc_set_bt_patch_version() are
unused since their addition in 2014 by
commit aa45a673b291 ("rtlwifi: btcoexist: Add new mini driver")

Remove them.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 .../realtek/rtlwifi/btcoexist/halbtcoutsrc.c  | 34 -------------------
 .../realtek/rtlwifi/btcoexist/halbtcoutsrc.h  |  6 ----
 2 files changed, 40 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtcoutsrc.c b/drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtcoutsrc.c
index 74c4504065c0..478cca33e5e3 100644
--- a/drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtcoutsrc.c
+++ b/drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtcoutsrc.c
@@ -1782,22 +1782,6 @@ void exhalbtc_periodical(struct btc_coexist *btcoexist)
 	halbtc_normal_low_power(btcoexist);
 }
 
-void exhalbtc_dbg_control(struct btc_coexist *btcoexist,
-			  u8 code, u8 len, u8 *data)
-{
-	if (!halbtc_is_bt_coexist_available(btcoexist))
-		return;
-	btcoexist->statistics.cnt_dbg_ctrl++;
-
-	halbtc_leave_low_power(btcoexist);
-
-	halbtc_normal_low_power(btcoexist);
-}
-
-void exhalbtc_stack_update_profile_info(void)
-{
-}
-
 void exhalbtc_update_min_bt_rssi(struct btc_coexist *btcoexist, s8 bt_rssi)
 {
 	if (!halbtc_is_bt_coexist_available(btcoexist))
@@ -1806,24 +1790,6 @@ void exhalbtc_update_min_bt_rssi(struct btc_coexist *btcoexist, s8 bt_rssi)
 	btcoexist->stack_info.min_bt_rssi = bt_rssi;
 }
 
-void exhalbtc_set_hci_version(struct btc_coexist *btcoexist, u16 hci_version)
-{
-	if (!halbtc_is_bt_coexist_available(btcoexist))
-		return;
-
-	btcoexist->stack_info.hci_version = hci_version;
-}
-
-void exhalbtc_set_bt_patch_version(struct btc_coexist *btcoexist,
-				   u16 bt_hci_version, u16 bt_patch_version)
-{
-	if (!halbtc_is_bt_coexist_available(btcoexist))
-		return;
-
-	btcoexist->bt_info.bt_real_fw_ver = bt_patch_version;
-	btcoexist->bt_info.bt_hci_ver = bt_hci_version;
-}
-
 void exhalbtc_set_chip_type(struct btc_coexist *btcoexist, u8 chip_type)
 {
 	switch (chip_type) {
diff --git a/drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtcoutsrc.h b/drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtcoutsrc.h
index 5d146fcb7852..d8d88a989806 100644
--- a/drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtcoutsrc.h
+++ b/drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtcoutsrc.h
@@ -766,12 +766,6 @@ void exhalbtc_bt_info_notify(struct btc_coexist *btcoexist, u8 *tmp_buf,
 void exhalbtc_halt_notify(struct btc_coexist *btcoexist);
 void exhalbtc_pnp_notify(struct btc_coexist *btcoexist, u8 pnp_state);
 void exhalbtc_periodical(struct btc_coexist *btcoexist);
-void exhalbtc_dbg_control(struct btc_coexist *btcoexist, u8 code, u8 len,
-			  u8 *data);
-void exhalbtc_stack_update_profile_info(void);
-void exhalbtc_set_hci_version(struct btc_coexist *btcoexist, u16 hci_version);
-void exhalbtc_set_bt_patch_version(struct btc_coexist *btcoexist,
-				   u16 bt_hci_version, u16 bt_patch_version);
 void exhalbtc_update_min_bt_rssi(struct btc_coexist *btcoexist, s8 bt_rssi);
 void exhalbtc_set_bt_exist(struct btc_coexist *btcoexist, bool bt_exist);
 void exhalbtc_set_chip_type(struct btc_coexist *btcoexist, u8 chip_type);
-- 
2.47.0


