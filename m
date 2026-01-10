Return-Path: <linux-wireless+bounces-30619-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 12E14D0CD19
	for <lists+linux-wireless@lfdr.de>; Sat, 10 Jan 2026 03:20:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1A1E3300EE62
	for <lists+linux-wireless@lfdr.de>; Sat, 10 Jan 2026 02:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C836D2A1CF;
	Sat, 10 Jan 2026 02:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="E1Up8XaA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7BE26BB5B
	for <linux-wireless@vger.kernel.org>; Sat, 10 Jan 2026 02:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768011650; cv=none; b=tOqvG3Ceza3DJ1ZDLU50OeZIop5t/8IJpVeLyl82eDjiUAIH5hLob0p0Ef762SmnrQS8ajtmMLU0N20lhOXsd62l4aPQ4/JXia1VYFabvtfqWu4a5tGrR5OcwiXitPx0SxBPboD3NY+eTcQd6qO4omcjMRJTFq9q6/g/toDGvxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768011650; c=relaxed/simple;
	bh=V/ecfgg7Nwvm2nuxiAYsZ1IvRor6KtiC0RF8m9jx53s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fMHQRAoahT9xzrQW5jE4oMikL9G5/UsOK6619b0MXzdwfTPZzvGzGJkpTEchGgU7vFDJdQOvEMyn/kx7a8vGueFP0JhRpqGa3DLWZQe33Icsy4EbdZan5EtXRxfM8O1d+KJuHrBWsUahOWwZ2m0KYtFzaH2aj+k+k6hxEFTo+GM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=E1Up8XaA; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 60A2KkZG2241732, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1768011646; bh=/thsXm5LVRS/b1ITEm4RRDNXmhEkzZzJDo+6oUBLh04=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=E1Up8XaA4/sNGmoJqb50/qwgT/Dbc/nfXzFx4pxLYi9oyTnWQpJ8k6zteTK4MIskp
	 YITg0LVhfi0kFUF4pFWAObRq5uLNz2wS6Skk8K2iV5GEZtyg128V5G8isyOWR/L7Cl
	 zDHyuBcDmKE3e7QObWxPwytRRl/+47hFCCSxG/hWhvY9d4/IsFlNnAY3lIcj5obWW9
	 Q0QIWZ8QZ2H8RNZ+EH7EmR8KCb6FtfhcHLPqDVukloTgdIEdFiP+dExPeOHKk+V4FY
	 jeH424YJ0MrFitwwPzn57Ky1nwICqBPp7Xi/lPs46eXwgE405GHcQVKKLzSTdM2fZU
	 YsiIEDRoM1XRg==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 60A2KkZG2241732
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Sat, 10 Jan 2026 10:20:46 +0800
Received: from RTKEXHMBS04.realtek.com.tw (10.21.1.54) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Sat, 10 Jan 2026 10:20:45 +0800
Received: from [127.0.1.1] (172.21.40.76) by RTKEXHMBS04.realtek.com.tw
 (10.21.1.54) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Sat, 10 Jan 2026 10:20:45 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <timlee@realtek.com>, <damon.chen@realtek.com>
Subject: [PATCH rtw-next 5/8] wifi: rtw89: align CUSTID defined by firmware
Date: Sat, 10 Jan 2026 10:20:16 +0800
Message-ID: <20260110022019.2254969-6-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260110022019.2254969-1-pkshih@realtek.com>
References: <20260110022019.2254969-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Firmware does customized features by CUSTID, so align the ID definition
to have expected features enabled.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.h | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index ef67d8d3cd70..1fd6292fe775 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -5161,13 +5161,15 @@ enum rtw89_quirks {
 };
 
 enum rtw89_custid {
-	RTW89_CUSTID_NONE,
-	RTW89_CUSTID_ACER,
-	RTW89_CUSTID_AMD,
-	RTW89_CUSTID_ASUS,
-	RTW89_CUSTID_DELL,
-	RTW89_CUSTID_HP,
-	RTW89_CUSTID_LENOVO,
+	RTW89_CUSTID_NONE = 0,
+	RTW89_CUSTID_HP = 1,
+	RTW89_CUSTID_ASUS = 2,
+	RTW89_CUSTID_ACER = 3,
+	RTW89_CUSTID_LENOVO = 4,
+	RTW89_CUSTID_NEC = 5,
+	RTW89_CUSTID_AMD = 6,
+	RTW89_CUSTID_FUJITSU = 7,
+	RTW89_CUSTID_DELL = 8,
 };
 
 enum rtw89_pkt_drop_sel {
-- 
2.25.1


