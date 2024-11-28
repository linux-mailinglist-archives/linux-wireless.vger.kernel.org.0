Return-Path: <linux-wireless+bounces-15771-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DDC29DB2A1
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Nov 2024 06:55:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C1F1CB22081
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Nov 2024 05:55:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B743513DBB1;
	Thu, 28 Nov 2024 05:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="QkywSCSy"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E1CC13D61B
	for <linux-wireless@vger.kernel.org>; Thu, 28 Nov 2024 05:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732773295; cv=none; b=q4FB5w3JtTe+4lt/WHNiIyD9pN1b0CKa+VrfOHV5rvoxC6UWpdy4rbsupmDmJ3aWqQuhR/4cSAgV513Zzcs4/+NfXlJGB8T9nluaeXgaBWB+midtE8GPuVJwXAZcmqG5i7OR0XVYJQgobI1TdSSvEFIwWJ3k991bPgVRcBDZBHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732773295; c=relaxed/simple;
	bh=+jI9wWnVd2nCZ1E3+Q4SFyfczOkiiGmw6JF54e22RBs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C8OHRYefwNXA9eEYwGGMEwwiTn7JEwpdcRo/p1XL+n96vYc7O1guiWMEPj1J01yfrC/f20ZSvrZd81/lK9psEA3qDljE1X2uosHC8vQbHTKXI4EFex7T/s+rNsKx759X+o3ZNtinQlNSg3YnqsMfL4OU06EqUXSDIqautEkkIaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=QkywSCSy; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4AS5sp5533960096, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1732773291; bh=+jI9wWnVd2nCZ1E3+Q4SFyfczOkiiGmw6JF54e22RBs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=QkywSCSyTStCx87VkkwsG3QguUbLUfzHdsw6/pNr4+uDQAAp+IpjPy59TMDY/O2jy
	 oRQ2ApdjHI49g9HimO7G7aSo9vbzdTWai6Z/4K64sY0KNCC331hEilKpYFr8ydsiU1
	 Z3KrgZL578kkDlVGs9hzzwLe3y225yiHOK8H6UpMZOq/m+TjCIlkGWxD44TLlSFgof
	 OMhzQgey2sdfS3+ncqsR3Etnt9jHqD3JKlm0vYjaaWO6otMjFLyi4Ae95juvEbZgWR
	 7NE95s31HaLwbEYL9cfXx1whOhTZK4b/8XUUm+JGHb9TtAd9a7SpeZ4HkwtESOLbYi
	 XZsvo6mHRh0vg==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 4AS5sp5533960096
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Thu, 28 Nov 2024 13:54:51 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 28 Nov 2024 13:54:51 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 28 Nov
 2024 13:54:50 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <gary.chang@realtek.com>, <phhuang@realtek.com>, <kevin_yang@realtek.com>
Subject: [PATCH 2/6] wifi: rtw89: 8852b: add beacon filter and CQM support
Date: Thu, 28 Nov 2024 13:54:29 +0800
Message-ID: <20241128055433.11851-3-pkshih@realtek.com>
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

Declare beacon filter and connection monitor for 8852B.
This offloads connection monitor mechanism to firmware, and this
is required for the MCC feature.

Signed-off-by: Po-Hao Huang <phhuang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/fw.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index a0408fcd6799..3fba37b8013a 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -709,6 +709,7 @@ static const struct __fw_feat_cfg fw_feat_tbl[] = {
 	__CFG_FW_FEAT(RTL8852B, ge, 0, 29, 26, 0, TX_WAKE),
 	__CFG_FW_FEAT(RTL8852B, ge, 0, 29, 29, 0, CRASH_TRIGGER),
 	__CFG_FW_FEAT(RTL8852B, ge, 0, 29, 29, 0, SCAN_OFFLOAD),
+	__CFG_FW_FEAT(RTL8852B, ge, 0, 29, 29, 7, BEACON_FILTER),
 	__CFG_FW_FEAT(RTL8852B, lt, 0, 29, 30, 0, NO_WOW_CPU_IO_RX),
 	__CFG_FW_FEAT(RTL8852BT, ge, 0, 29, 74, 0, NO_LPS_PG),
 	__CFG_FW_FEAT(RTL8852BT, ge, 0, 29, 74, 0, TX_WAKE),
-- 
2.25.1


