Return-Path: <linux-wireless+bounces-9810-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCBD191ED7F
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Jul 2024 05:39:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23E4B1C20DC2
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Jul 2024 03:39:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 735A3168A8;
	Tue,  2 Jul 2024 03:39:01 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F87F49621
	for <linux-wireless@vger.kernel.org>; Tue,  2 Jul 2024 03:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719891541; cv=none; b=BsijUUPcFBAKhIdll2qejz1BbSjuhex3H5qN1e1wuZ7YigI+Kh6fbiXK/JnGxuSfIYO0PeLiNWjswiqdGGoxEZ0zres44OPuHzDnrevDtm9cVPRwMAnVYEhivvpxlm/xjIj6sOsTfTjxkwC5jc3XK5MEBx5A8J1jOiv3t1BIVQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719891541; c=relaxed/simple;
	bh=o0311/Dyhxq5JgAgyosUnRv2MG9yNIeE9hxUokCbzKc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=J8OooaHQu1ekxSm/rxsMxxHRQLJkzdHCAOFiYaYJLQ9HiBL3sP/Ga/7geyH/vbLEfCl7M1gus3dKqT36NsiwdVOwiT9afswRuxW0Er9MIIQR90D+MXlioeQdfuXYav7QEcRu/4rwta5L7voX2ZH16INjS0L053VTLmAV3I9PrDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4623ctnrF395839, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 4623ctnrF395839
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Tue, 2 Jul 2024 11:38:55 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 2 Jul 2024 11:38:56 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Tue, 2 Jul
 2024 11:38:55 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <kevin_yang@realtek.com>
Subject: [PATCH 1/2] wifi: rtw89: mac: parse MRC C2H failure report
Date: Tue, 2 Jul 2024 11:38:32 +0800
Message-ID: <20240702033833.9447-1-pkshih@realtek.com>
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

From: Zong-Zhe Yang <kevin_yang@realtek.com>

MRC (multi-role concurrency) has a C2H event for status report. Newer
FW will report some kinds of failures. We parse them now and show by
debug log.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/mac.c | 40 ++++++++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/mac.h | 10 ++++++
 2 files changed, 50 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index 73462f3343e3..e2399796aeb1 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -5202,6 +5202,46 @@ rtw89_mac_c2h_mrc_status_rpt(struct rtw89_dev *rtwdev, struct sk_buff *c2h, u32
 	case RTW89_MAC_MRC_DEL_SCH_OK:
 		func = H2C_FUNC_DEL_MRC;
 		break;
+	case RTW89_MAC_MRC_EMPTY_SCH_FAIL:
+		rtw89_debug(rtwdev, RTW89_DBG_CHAN,
+			    "MRC C2H STS RPT: empty sch fail\n");
+		return;
+	case RTW89_MAC_MRC_ROLE_NOT_EXIST_FAIL:
+		rtw89_debug(rtwdev, RTW89_DBG_CHAN,
+			    "MRC C2H STS RPT: role not exist fail\n");
+		return;
+	case RTW89_MAC_MRC_DATA_NOT_FOUND_FAIL:
+		rtw89_debug(rtwdev, RTW89_DBG_CHAN,
+			    "MRC C2H STS RPT: data not found fail\n");
+		return;
+	case RTW89_MAC_MRC_GET_NEXT_SLOT_FAIL:
+		rtw89_debug(rtwdev, RTW89_DBG_CHAN,
+			    "MRC C2H STS RPT: get next slot fail\n");
+		return;
+	case RTW89_MAC_MRC_ALT_ROLE_FAIL:
+		rtw89_debug(rtwdev, RTW89_DBG_CHAN,
+			    "MRC C2H STS RPT: alt role fail\n");
+		return;
+	case RTW89_MAC_MRC_ADD_PSTIMER_FAIL:
+		rtw89_debug(rtwdev, RTW89_DBG_CHAN,
+			    "MRC C2H STS RPT: add ps timer fail\n");
+		return;
+	case RTW89_MAC_MRC_MALLOC_FAIL:
+		rtw89_debug(rtwdev, RTW89_DBG_CHAN,
+			    "MRC C2H STS RPT: malloc fail\n");
+		return;
+	case RTW89_MAC_MRC_SWITCH_CH_FAIL:
+		rtw89_debug(rtwdev, RTW89_DBG_CHAN,
+			    "MRC C2H STS RPT: switch ch fail\n");
+		return;
+	case RTW89_MAC_MRC_TXNULL0_FAIL:
+		rtw89_debug(rtwdev, RTW89_DBG_CHAN,
+			    "MRC C2H STS RPT: tx null-0 fail\n");
+		return;
+	case RTW89_MAC_MRC_PORT_FUNC_EN_FAIL:
+		rtw89_debug(rtwdev, RTW89_DBG_CHAN,
+			    "MRC C2H STS RPT: port func en fail\n");
+		return;
 	default:
 		rtw89_debug(rtwdev, RTW89_DBG_CHAN,
 			    "invalid MRC C2H STS RPT: status %d\n", status);
diff --git a/drivers/net/wireless/realtek/rtw89/mac.h b/drivers/net/wireless/realtek/rtw89/mac.h
index cc9f914d440c..d5895516b3ed 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.h
+++ b/drivers/net/wireless/realtek/rtw89/mac.h
@@ -466,6 +466,16 @@ enum rtw89_mac_mrc_status {
 	RTW89_MAC_MRC_START_SCH_OK = 0,
 	RTW89_MAC_MRC_STOP_SCH_OK = 1,
 	RTW89_MAC_MRC_DEL_SCH_OK = 2,
+	RTW89_MAC_MRC_EMPTY_SCH_FAIL = 16,
+	RTW89_MAC_MRC_ROLE_NOT_EXIST_FAIL = 17,
+	RTW89_MAC_MRC_DATA_NOT_FOUND_FAIL = 18,
+	RTW89_MAC_MRC_GET_NEXT_SLOT_FAIL = 19,
+	RTW89_MAC_MRC_ALT_ROLE_FAIL = 20,
+	RTW89_MAC_MRC_ADD_PSTIMER_FAIL = 21,
+	RTW89_MAC_MRC_MALLOC_FAIL = 22,
+	RTW89_MAC_MRC_SWITCH_CH_FAIL = 23,
+	RTW89_MAC_MRC_TXNULL0_FAIL = 24,
+	RTW89_MAC_MRC_PORT_FUNC_EN_FAIL = 25,
 };
 
 struct rtw89_mac_ax_coex {
-- 
2.25.1


