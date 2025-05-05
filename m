Return-Path: <linux-wireless+bounces-22439-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 12318AA8CFE
	for <lists+linux-wireless@lfdr.de>; Mon,  5 May 2025 09:26:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2EF397A8502
	for <lists+linux-wireless@lfdr.de>; Mon,  5 May 2025 07:24:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 147861D5166;
	Mon,  5 May 2025 07:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="WRVYLl7A"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 339A31DE3B5
	for <linux-wireless@vger.kernel.org>; Mon,  5 May 2025 07:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746429927; cv=none; b=VAXDhv8W2I84YseFlWRcStPpyYZ9TXMYsxc8Mz375JUbVzYGjgtoPWj+WJP1feX4+uuYgNqZJHBCYNUm/awVGV/ztqa3PvMOhc2/b0iBxcuKHhvxLda2IHnPd6QNrCWBA1YOS/OFW5xGXN2FrNslCFjM5c+bWHcT4FnC7vUzhUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746429927; c=relaxed/simple;
	bh=ZYmPupv76G9uKVqT8DH2xqOYmIxUqZAKC9zqnQjTxBk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=byC4Z3gr1jOFQ0E7Wq6VIVL3d5SbNoQXvnaVSMaDIAGjBaulO7y10Q3oHsf08ZVfQLXvuHmOlMcHbyAsNb575ElHZStVhrdARyLdfQ0fXh/YHxyBeqWxnX9UhzLgdWFHil/mXapzvr2c36gSkiR9ALIX/AMN3+vdiYsAZJBnk9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=WRVYLl7A; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 5457PN8E03831288, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1746429923; bh=ZYmPupv76G9uKVqT8DH2xqOYmIxUqZAKC9zqnQjTxBk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=WRVYLl7AzkKXOB84bavbWZ5kwrovPMYsB5RPqZtfKF2UnugdDDjQUlDieAR9lISpq
	 Raz5+5eU+mdRqhw2gXNa7M5BOd+YYXnX/lQgAs8fy6epK4/OGQvkwM1Ewo4+HpTccY
	 nb0/zYm2UlSnIz68b8dcGEpOpWM6dXNeIcAECMActKzZ/L6OsfDg3IS+uIMRvrjShM
	 MCsGwXi1itG6EgxFKXTF9Ao+NsBG8uUEZTAUZE3ckV1E+1yzDQ2z4bYWEfMVQ5eVVS
	 SDD/dcao7vQOt0bU6vB4Fbz4dE+id0ILEhwHbWQ6OPX1p44nNgUlCaCWUleMUX3EJ2
	 m3qNoUwtNrtBA==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 5457PN8E03831288
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Mon, 5 May 2025 15:25:23 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 5 May 2025 15:25:22 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 5 May
 2025 15:25:22 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <phhuang@realtek.com>, <kevin_yang@realtek.com>
Subject: [PATCH rtw-next 09/11] wifi: rtw89: debug: add FW log component for MLO
Date: Mon, 5 May 2025 15:24:38 +0800
Message-ID: <20250505072440.45113-10-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250505072440.45113-1-pkshih@realtek.com>
References: <20250505072440.45113-1-pkshih@realtek.com>
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

This allows showing MLO related logs when FW debug mode is on.

Signed-off-by: Po-Hao Huang <phhuang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/fw.c | 2 +-
 drivers/net/wireless/realtek/rtw89/fw.h | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index deb4fb21d0e0..76350351dfb2 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -2510,7 +2510,7 @@ int rtw89_fw_h2c_fw_log(struct rtw89_dev *rtwdev, bool enable)
 	if (enable)
 		comp = BIT(RTW89_FW_LOG_COMP_INIT) | BIT(RTW89_FW_LOG_COMP_TASK) |
 		       BIT(RTW89_FW_LOG_COMP_PS) | BIT(RTW89_FW_LOG_COMP_ERROR) |
-		       BIT(RTW89_FW_LOG_COMP_SCAN);
+		       BIT(RTW89_FW_LOG_COMP_MLO) | BIT(RTW89_FW_LOG_COMP_SCAN);
 
 	skb = rtw89_fw_h2c_alloc_skb_with_hdr(rtwdev, H2C_LOG_CFG_LEN);
 	if (!skb) {
diff --git a/drivers/net/wireless/realtek/rtw89/fw.h b/drivers/net/wireless/realtek/rtw89/fw.h
index 207ec88ea456..0fcc824e41be 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.h
+++ b/drivers/net/wireless/realtek/rtw89/fw.h
@@ -199,6 +199,7 @@ enum rtw89_fw_log_comp {
 	RTW89_FW_LOG_COMP_TWT,
 	RTW89_FW_LOG_COMP_RF,
 	RTW89_FW_LOG_COMP_MCC = 20,
+	RTW89_FW_LOG_COMP_MLO = 26,
 	RTW89_FW_LOG_COMP_SCAN = 28,
 };
 
-- 
2.25.1


