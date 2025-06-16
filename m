Return-Path: <linux-wireless+bounces-24148-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CBC19ADADEC
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Jun 2025 13:01:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A5B71701AA
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Jun 2025 11:01:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E269726D4C7;
	Mon, 16 Jun 2025 11:01:39 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from RTEXH36506.realtek.com.tw (unknown [122.146.120.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E10B1F130A
	for <linux-wireless@vger.kernel.org>; Mon, 16 Jun 2025 11:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=122.146.120.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750071699; cv=none; b=YSOkRKDVesFcHwh/T7nAynw12mipaZ4i4jvbDzBXe3tmbiskrxYseCHCPW7GCARluUd3YIF6EI3BAzwpdkGrF0Px7x5S3D64HjtmS6KEJHRJM4tw+7hL0MH7ys3MG5WznYAfTukKCqxcaNRRtvfLgI26g5EXcVWqRUufQBs84ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750071699; c=relaxed/simple;
	bh=7a1NpH7xFF0Ziy64QlUa3xd6Szov8JD8mAVLHdpTLeM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PYKLoHTamtJrEMly6xbf3ZH/amkUVZvv9MOJ7niQXCbeIfuZA+aAGRpcy7WPqKNNh6qY8sT9616cVyRyAimDIxMGzeKXobfYz3GESF0YuyZp2htaUCcKwq9ciHGY0HShS6+VcQr3cV8hJGgamDjwv73rE+0vbMp1ZTdWauJPAL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=122.146.120.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 16 Jun 2025 17:03:48 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 16 Jun
 2025 17:03:48 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <ku920601@realtek.com>
Subject: [PATCH rtw-next 10/11] wifi: rtw89: coex: RTL8852B coexistence Wi-Fi firmware support for v0.29.122.0
Date: Mon, 16 Jun 2025 17:02:51 +0800
Message-ID: <20250616090252.51098-11-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250616090252.51098-1-pkshih@realtek.com>
References: <20250616090252.51098-1-pkshih@realtek.com>
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

From: Ching-Te Ku <ku920601@realtek.com>

Add format version of Wi-Fi firmware commands/events for firmware
version v0.29.122.0.

Signed-off-by: Ching-Te Ku <ku920601@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/coex.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/coex.c b/drivers/net/wireless/realtek/rtw89/coex.c
index f6b482b20dc7..9eecd8e6bfad 100644
--- a/drivers/net/wireless/realtek/rtw89/coex.c
+++ b/drivers/net/wireless/realtek/rtw89/coex.c
@@ -205,6 +205,14 @@ static const struct rtw89_btc_ver rtw89_btc_ver_defs[] = {
 	 .fwevntrptl = 0, .fwc2hfunc = 1, .drvinfo_type = 0, .info_buf = 1280,
 	 .max_role_num = 5, .fcxosi = 0,  .fcxmlo = 0,   .bt_desired = 7,
 	},
+	{RTL8852B, RTW89_FW_VER_CODE(0, 29, 122, 0),
+	 .fcxbtcrpt = 8, .fcxtdma = 7,    .fcxslots = 7, .fcxcysta = 7,
+	 .fcxstep = 7,   .fcxnullsta = 7, .fcxmreg = 7,  .fcxgpiodbg = 7,
+	 .fcxbtver = 7,  .fcxbtscan = 7,  .fcxbtafh = 7, .fcxbtdevinfo = 7,
+	 .fwlrole = 7,   .frptmap = 3,    .fcxctrl = 7,  .fcxinit = 7,
+	 .fwevntrptl = 1, .fwc2hfunc = 2, .drvinfo_type = 1, .info_buf = 1800,
+	 .max_role_num = 6, .fcxosi = 0,  .fcxmlo = 0,   .bt_desired = 8,
+	},
 	{RTL8852B, RTW89_FW_VER_CODE(0, 29, 29, 0),
 	 .fcxbtcrpt = 105, .fcxtdma = 3,  .fcxslots = 1, .fcxcysta = 5,
 	 .fcxstep = 3,   .fcxnullsta = 2, .fcxmreg = 2,  .fcxgpiodbg = 1,
-- 
2.25.1


