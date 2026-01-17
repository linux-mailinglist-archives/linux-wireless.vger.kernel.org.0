Return-Path: <linux-wireless+bounces-30928-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D80BD38C55
	for <lists+linux-wireless@lfdr.de>; Sat, 17 Jan 2026 05:43:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1101030476BF
	for <lists+linux-wireless@lfdr.de>; Sat, 17 Jan 2026 04:42:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B4782D77EA;
	Sat, 17 Jan 2026 04:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="jw/sZkPS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEBF8325722
	for <linux-wireless@vger.kernel.org>; Sat, 17 Jan 2026 04:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768624963; cv=none; b=QuQTCP1FQXuimtOXV48DyBpgEKp6XBwT7FBqh83keQo07ie16aUgQnfJi3OtOhDoN8VtGvf3lU2Aw1e/GZ4SIPano9rSyoVIgRa96rjkINAqM3Y3XwiVY637SYphG7xmyluWyFIECkJdjwMzphyVLXMfTzKGebtjqmR1UrKZXHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768624963; c=relaxed/simple;
	bh=lVXskEl/eGnhrAg3O6htyeWXKlsc4gPBvg/g8Blpmhg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U/R82x1FYv5zVS2QeenfAfj02uc7bKIynwp8WT2N+zf9WwwiqVm0FvN4E/r42z7njANSHV+pNAjr/cJosbmUeLEOn3RXiOlMcP7gVGE7iUooXZnxC0QVEGp6jGgfOUbuMJuXmsHX/N23eCTI62Ii1FXL/oCKLTA5DJz5AfiDQCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=jw/sZkPS; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 60H4gdasF2464503, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1768624959; bh=c1d9ipkdK2I6/SyibJBt1pZNQSExO+8EiGizrUvq+qA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=jw/sZkPS7c/3bpYLy7F2yWxNEv84UP4DoHdGwVoC+0fzhvlk0bMj+BczxZdasSSXK
	 fE9y6fA/tP0sbdQzXDffy8eBaE38/HFuMpE0nJnve6Of4ISGQg7o3YV6SBZhsqHaeC
	 4spO6t3vTDAhnAB65Jkq3OqcYY8fBFvrHPSVJaxYBDQzy09KwLB08DWiEf8g9SHcZS
	 nT4Zuv4L2yOV0MND7w5Sfu3dz9kV8r4hybOvZTf6XuizsG4RyGm6mf+X3HdGCcToq0
	 P5DnM9gHfSNbpFgxfYoTRRp+a+X9VzWdmD67l/Zp4q2iHuoaS7cdgutZ76JX2QreNx
	 BeN4yHgPJYePg==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 60H4gdasF2464503
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Sat, 17 Jan 2026 12:42:39 +0800
Received: from RTKEXHMBS03.realtek.com.tw (10.21.1.53) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Sat, 17 Jan 2026 12:42:39 +0800
Received: from [127.0.1.1] (172.21.40.76) by RTKEXHMBS03.realtek.com.tw
 (10.21.1.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Sat, 17 Jan 2026 12:42:39 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <echuang@realtek.com>, <phhuang@realtek.com>, <kevin_yang@realtek.com>
Subject: [PATCH rtw-next 8/9] wifi: rtw89: mac: set force MBA duration to 0
Date: Sat, 17 Jan 2026 12:41:56 +0800
Message-ID: <20260117044157.2392958-9-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260117044157.2392958-1-pkshih@realtek.com>
References: <20260117044157.2392958-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Enable force MBA (Multi-user Block Ack) field to ensure trasnmiting
packet of duration field of MBA in multi-user block ack request is 0
as expected.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/mac_be.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/mac_be.c b/drivers/net/wireless/realtek/rtw89/mac_be.c
index e552711ffce4..1281f68aad4a 100644
--- a/drivers/net/wireless/realtek/rtw89/mac_be.c
+++ b/drivers/net/wireless/realtek/rtw89/mac_be.c
@@ -1328,6 +1328,9 @@ static int nav_ctrl_init_be(struct rtw89_dev *rtwdev, u8 mac_idx)
 	reg = rtw89_mac_reg_by_idx(rtwdev, R_BE_SPECIAL_TX_SETTING, mac_idx);
 	rtw89_write32_clr(rtwdev, reg, B_BE_BMC_NAV_PROTECT);
 
+	reg = rtw89_mac_reg_by_idx(rtwdev, R_BE_TRXPTCL_RESP_0, mac_idx);
+	rtw89_write32_set(rtwdev, reg, B_BE_WMAC_MBA_DUR_FORCE);
+
 	return 0;
 }
 
-- 
2.25.1


