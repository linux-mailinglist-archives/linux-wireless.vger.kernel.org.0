Return-Path: <linux-wireless+bounces-9269-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0824B90FC72
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Jun 2024 07:59:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBC7D1C215A4
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Jun 2024 05:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3BCD2744C;
	Thu, 20 Jun 2024 05:58:59 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E87313D552
	for <linux-wireless@vger.kernel.org>; Thu, 20 Jun 2024 05:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718863139; cv=none; b=iJHRdt+zU/HyfFL7PRsvlZ8jQzKhtKHxWtHrPTNhl3jAZOjTYvmVLZ8at2CQulgcnQdjQHKVutbaqTV64FHPHjlvGN/S4A+aI/S+U/R1YUvW8v6Eltji4sNfZXGriWDSisncgURP1V5CvAeiiXlW2qZIbkOZ1xjpgwP13ps3OFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718863139; c=relaxed/simple;
	bh=LFTv/l7aJz1A6zQBX2nzU8n+VHEcbTgxPy43ntT89OA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WcGQYBJYKmzkMjl7v0IQOYbScP46sG+2jR8dkuDo7nQtXVYDSTIMCMc8pip2GjJSN59aO53mOvMsMn9SZ4JMB4myp/kWf00TxhDro6SV7eMfe1SfrtguVUgHyDfKKK62kHHW1D01FtmSvLQw/gaOmxmCfNBZByAYjlobTS60l4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 45K5wtAwB2577685, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 45K5wtAwB2577685
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Thu, 20 Jun 2024 13:58:55 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 20 Jun 2024 13:58:55 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 20 Jun
 2024 13:58:55 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <gary.chang@realtek.com>
Subject: [PATCH 5/7] wifi: rtw89: wow: prevent to send unexpected H2C during download Firmware
Date: Thu, 20 Jun 2024 13:58:23 +0800
Message-ID: <20240620055825.17592-6-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240620055825.17592-1-pkshih@realtek.com>
References: <20240620055825.17592-1-pkshih@realtek.com>
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

From: Chih-Kang Chang <gary.chang@realtek.com>

While downloading Firmware in the resume flow, it is possible to receive
beacon and send H2C to Firmware. However, if Firmware receives unexpected
H2C during the download process, it will fail. Therefore, we prevent to
send unexpected H2C during download Firmware in WoWLAN mode.

Signed-off-by: Chih-Kang Chang <gary.chang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 87c38cdc691b..4acd4301d3c2 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -1921,7 +1921,8 @@ static void rtw89_vif_rx_stats_iter(void *data, u8 *mac,
 		return;
 
 	if (ieee80211_is_beacon(hdr->frame_control)) {
-		if (vif->type == NL80211_IFTYPE_STATION) {
+		if (vif->type == NL80211_IFTYPE_STATION &&
+		    !test_bit(RTW89_FLAG_WOWLAN, rtwdev->flags)) {
 			rtw89_vif_sync_bcn_tsf(rtwvif, hdr, skb->len);
 			rtw89_fw_h2c_rssi_offload(rtwdev, phy_ppdu);
 		}
-- 
2.25.1


