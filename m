Return-Path: <linux-wireless+bounces-14196-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60E439A34E7
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Oct 2024 08:00:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23195283A22
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Oct 2024 06:00:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BB1C18BB97;
	Fri, 18 Oct 2024 05:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="N4GIXu4c"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B82C518B48C
	for <linux-wireless@vger.kernel.org>; Fri, 18 Oct 2024 05:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729231030; cv=none; b=P0OOp4gJMWTkjLCpMk42c6sfa8FopNF1zxXGRrGqYnnM+eCv/hiMQzpxzcLvejk3QiWs2KquQSVI56+TuPW8dsQ4jdMsFh4stVWkUgRUENxsUdmqEuzNzsXxt1l5djwp/JhmIk845vNzDmpSpY+/HGJFKzTP/S9FASnPWaIj7bM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729231030; c=relaxed/simple;
	bh=IE4FP5xuE6Bcrh658rowFsWRlPMVq/LUWWwihnyvIv0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DkDEp2Tgb/YlIuIhN7hAdyHG0EBZLMGfe2U/RzoN5Kfc219uvtm7EWhbUJIGqPZkNumuDgB3ZFlPnw4cMh3T2sxR8O2CdgIWh26+wj+dO+Vyoagjmwc3aN8EUa1/IY+I9NtzPuRFFXv7jGkTHPC9vqwgOjt2vvdyisZ0XPmN8JM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=N4GIXu4c; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 49I5v41b91589075, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1729231024; bh=IE4FP5xuE6Bcrh658rowFsWRlPMVq/LUWWwihnyvIv0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=N4GIXu4c/O9hPcysYwWuJ3c7mQBcbgrpmEOG8tCG+QXO/XrM3sZKao/zBRkOLdjTE
	 J3vH5zTcGG5OpFAAJr/BgetQdskA+4kUR+p1ebOYiRAT2wMwMl8bp+3nwcFoA5jt+6
	 6k45Ty+p6Vizpxp0EvjYR5YrwR9yA7aR2TNr3WBGYMLYjLWceJjKIb5pgZEC4w1XPI
	 3zCMOIrjCkpmHoi16NbkoqHdIBIA2QXnY6CEqGpWmFT5sVLTE5M3ZLCHgewr7x5vNZ
	 lBEDRnOrw2+wjOhKoAOumKtp3rEtjZAUKRvs3Syn/z/cEbuWY8hg8VRHmqFdjJJU0E
	 4/9ruTg83FE2Q==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 49I5v41b91589075
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Fri, 18 Oct 2024 13:57:04 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 18 Oct 2024 13:57:05 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 18 Oct
 2024 13:57:05 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
Subject: [PATCH] wifi: rtlwifi: use MODULE_FIRMWARE() to declare used firmware
Date: Fri, 18 Oct 2024 13:56:51 +0800
Message-ID: <20241018055651.21166-1-pkshih@realtek.com>
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

Some used firmware are missing to be added to MODULE_FIRMWARE().
Add them accordingly.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtlwifi/rtl8723ae/sw.c | 3 ++-
 drivers/net/wireless/realtek/rtlwifi/rtl8821ae/sw.c | 3 +++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8723ae/sw.c b/drivers/net/wireless/realtek/rtlwifi/rtl8723ae/sw.c
index 1b144fbd4d26..048744166a92 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8723ae/sw.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8723ae/sw.c
@@ -350,7 +350,8 @@ MODULE_AUTHOR("lizhaoming	<chaoming_li@realsil.com.cn>");
 MODULE_AUTHOR("Realtek WlanFAE	<wlanfae@realtek.com>");
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("Realtek 8723E 802.11n PCI wireless");
-MODULE_FIRMWARE("rtlwifi/rtl8723efw.bin");
+MODULE_FIRMWARE("rtlwifi/rtl8723fw.bin");
+MODULE_FIRMWARE("rtlwifi/rtl8723fw_B.bin");
 
 module_param_named(swenc, rtl8723e_mod_params.sw_crypto, bool, 0444);
 module_param_named(debug_level, rtl8723e_mod_params.debug_level, int, 0644);
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/sw.c b/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/sw.c
index a65503c5ae5a..b5266e560416 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/sw.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/sw.c
@@ -407,6 +407,9 @@ MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("Realtek 8821ae 802.11ac PCI wireless");
 MODULE_FIRMWARE("rtlwifi/rtl8821aefw.bin");
 MODULE_FIRMWARE("rtlwifi/rtl8821aefw_29.bin");
+MODULE_FIRMWARE("rtlwifi/rtl8821aefw_wowlan.bin");
+MODULE_FIRMWARE("rtlwifi/rtl8812aefw.bin");
+MODULE_FIRMWARE("rtlwifi/rtl8812aefw_wowlan.bin");
 
 module_param_named(swenc, rtl8821ae_mod_params.sw_crypto, bool, 0444);
 module_param_named(debug_level, rtl8821ae_mod_params.debug_level, int, 0644);
-- 
2.25.1


