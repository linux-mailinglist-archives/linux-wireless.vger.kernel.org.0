Return-Path: <linux-wireless+bounces-15772-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EDB49DB2A2
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Nov 2024 06:55:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04B19282963
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Nov 2024 05:55:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CA7813DDB5;
	Thu, 28 Nov 2024 05:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="pnb6Mkex"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5083A13D61B
	for <linux-wireless@vger.kernel.org>; Thu, 28 Nov 2024 05:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732773299; cv=none; b=Xkgtq5Ktkj7z+gE/5lnuq3ZI0mVDC7U+zEVFM9kqTil0KD+mbkawBfKNZ6W+GhVRKivY4vg2syowBoqB7HNbYvrLzeNJ81R0IfNagMoqSytJ3x5AfgZ2OBdom5RQ10LNnG8v4/D/gAD0bnbGEjmA5SC3u903Cev11zhlmxsCpNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732773299; c=relaxed/simple;
	bh=OY+HDKWb9t25cK6iRuGMHAbBfZG9Z7jbRWClcOi8D4s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dOX9fGDQ+6WEye27mRYaXmcAVBW9NhOGs2JSbU8cJ/tSsHXb3ErHHkduQjXrCPXJhrrCsaLd/+SS0KOZL/VfUQlrbcz8bZysG+za5XD8oTswgxJ7oYmgZ63SnJMVBPUhg3A3eiyKPVYLyuJu4EbrcL4ojC1NLM/lAAf2eDu43iM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=pnb6Mkex; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4AS5ss5D33960102, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1732773294; bh=OY+HDKWb9t25cK6iRuGMHAbBfZG9Z7jbRWClcOi8D4s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=pnb6MkexWxkbxrDQ2pAR9LPk9c5ylA7lQml63h4G/7MEAxPSSCEb091OyLCBQLrkE
	 1qKbGT5vEOuQ0J0WIMAhfbHcudy6XtLjP/L7GdUztIYoVRBXLXnP23zCUyZwSTWKgD
	 GfXvkr+ENO9fcfJ4M90JGIBkftzjGaO8v8xsT0dHYd6vTX5tXV8oMPJQVOTRriGmNT
	 ueXDR7wgPx2dhtpy3BVEpGWhDiF147POPt6pOfu9O7wgaYq5S/JJWa0NCzZwHGZKLe
	 mG8OmoYBEaiZVzDJ8N7OU2zpazClcysb0yRrY5RAkcNos2BU3wePvSBnWJ6SAZL5Ev
	 y1fucqv7M6TYw==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 4AS5ss5D33960102
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Thu, 28 Nov 2024 13:54:54 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 28 Nov 2024 13:54:55 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 28 Nov
 2024 13:54:54 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <gary.chang@realtek.com>, <phhuang@realtek.com>, <kevin_yang@realtek.com>
Subject: [PATCH 3/6] wifi: rtw89: 8852bt: add beacon filter and CQM support
Date: Thu, 28 Nov 2024 13:54:30 +0800
Message-ID: <20241128055433.11851-4-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241128055433.11851-1-pkshih@realtek.com>
References: <20241128055433.11851-1-pkshih@realtek.com>
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

Declare beacon filter and connection monitor for 8852BT.
This offloads connection monitor mechanism to firmware, and this
is required for the MCC feature.

Signed-off-by: Po-Hao Huang <phhuang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/fw.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 3fba37b8013a..c604ea1d39f1 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -715,6 +715,7 @@ static const struct __fw_feat_cfg fw_feat_tbl[] = {
 	__CFG_FW_FEAT(RTL8852BT, ge, 0, 29, 74, 0, TX_WAKE),
 	__CFG_FW_FEAT(RTL8852BT, ge, 0, 29, 90, 0, CRASH_TRIGGER),
 	__CFG_FW_FEAT(RTL8852BT, ge, 0, 29, 91, 0, SCAN_OFFLOAD),
+	__CFG_FW_FEAT(RTL8852BT, ge, 0, 29, 110, 0, BEACON_FILTER),
 	__CFG_FW_FEAT(RTL8852C, le, 0, 27, 33, 0, NO_DEEP_PS),
 	__CFG_FW_FEAT(RTL8852C, ge, 0, 27, 34, 0, TX_WAKE),
 	__CFG_FW_FEAT(RTL8852C, ge, 0, 27, 36, 0, SCAN_OFFLOAD),
-- 
2.25.1


