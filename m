Return-Path: <linux-wireless+bounces-24130-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A052FADAB68
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Jun 2025 11:04:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5639F170BEA
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Jun 2025 09:04:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0B981991CD;
	Mon, 16 Jun 2025 09:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="MqzXUECm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 876E21A7253
	for <linux-wireless@vger.kernel.org>; Mon, 16 Jun 2025 09:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750064640; cv=none; b=EcrrBKgdlvuqJdCC8p6OWH+Zrg41nMxka5m62Bs6DFCxnH3QS/kN2lOXYMqRza0nhhGW8g4FD33UNk+U3B1JnglGgaNVCQF+ca6H18BGjmg7jCwSZDM1H0WIrjRH+DbAmGesFJWqYfPCetprqBoxMzT2XXwVZSG1iP7MY++DB/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750064640; c=relaxed/simple;
	bh=+VDiFumdgMwveyNEVU+Fh4Jgow3pc+CyeDYGt1aa3j0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eGOlSYq9QzHIixD53D93cS/gDDvuR4Z3ibxYMDd5zOqIDokAokDjQgM5TMZFaH/yiDPoCK/Y9mAnQLXN6PY6qbMeLWtMxKj7mA/hMhGVAIJdBiQ3LW7EeZyAcN4GSvAyPHlBSNQWFOYA8s+A5nYQjAOmqii3CaH65oQH4klRUPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=MqzXUECm; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 55G93tswE175679, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1750064635; bh=jbJbIVIh6GG4KtRZexiu+FnLNT4lCHnW2l1FVWDoBO8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=MqzXUECmukxnRGGIRimcnd6z1L4meeDXNq6ahAQvZbXwbuF0MTS2UecZQuKW8SFue
	 MKVy05/ZUqzlO+xi7+fw7TxxzKbUCtKHaNJCjFTSpefpdIrz0Q9DWWPOytL/gHMDKv
	 IzuNHBpRYHduHQHjbwRpfwia/CUN0sooewOr7qXpsSIyfsqik+WbVFv5jxVHrvkg52
	 HU81YFaEjLWdCFm6xM2GwaTKnde5x/wmM4Jxgb1zddusQ12nQ207SFt3D5rNK7Yn8O
	 OiitBawlqFAp7Bmcx7tlt+naOK8cWNuFjdUgB0ySHDV+PfqukslDqR2tHTkKfspHMB
	 CO15cmYqBiRrA==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 55G93tswE175679
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Mon, 16 Jun 2025 17:03:55 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 16 Jun 2025 17:03:31 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 16 Jun
 2025 17:03:30 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <ku920601@realtek.com>
Subject: [PATCH rtw-next 04/11] wifi: rtw89: coex: RTL8922A add Wi-Fi firmware support for v0.35.71.0
Date: Mon, 16 Jun 2025 17:02:45 +0800
Message-ID: <20250616090252.51098-5-pkshih@realtek.com>
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

The latest Wi-Fi firmware no feature update with Wi-Fi/Bluetooth
coexistence. The patch describe the features support version.

Signed-off-by: Ching-Te Ku <ku920601@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/coex.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/coex.c b/drivers/net/wireless/realtek/rtw89/coex.c
index d02725aad6c7..a4c4b56e7fdd 100644
--- a/drivers/net/wireless/realtek/rtw89/coex.c
+++ b/drivers/net/wireless/realtek/rtw89/coex.c
@@ -149,6 +149,14 @@ static const struct rtw89_btc_ver rtw89_btc_ver_defs[] = {
 	 .fwevntrptl = 1, .fwc2hfunc = 2, .drvinfo_type = 1, .info_buf = 1800,
 	 .max_role_num = 6, .fcxosi = 0,  .fcxmlo = 0,
 	},
+	{RTL8922A, RTW89_FW_VER_CODE(0, 35, 71, 0),
+	 .fcxbtcrpt = 8, .fcxtdma = 7,    .fcxslots = 7, .fcxcysta = 7,
+	 .fcxstep = 7,   .fcxnullsta = 7, .fcxmreg = 7,  .fcxgpiodbg = 7,
+	 .fcxbtver = 7,  .fcxbtscan = 7,  .fcxbtafh = 7, .fcxbtdevinfo = 7,
+	 .fwlrole = 8,   .frptmap = 4,    .fcxctrl = 7,  .fcxinit = 7,
+	 .fwevntrptl = 1, .fwc2hfunc = 3, .drvinfo_type = 2, .info_buf = 1800,
+	 .max_role_num = 6, .fcxosi = 1,  .fcxmlo = 1,
+	},
 	{RTL8922A, RTW89_FW_VER_CODE(0, 35, 63, 0),
 	 .fcxbtcrpt = 8, .fcxtdma = 7,    .fcxslots = 7, .fcxcysta = 7,
 	 .fcxstep = 7,   .fcxnullsta = 7, .fcxmreg = 7,  .fcxgpiodbg = 7,
-- 
2.25.1


