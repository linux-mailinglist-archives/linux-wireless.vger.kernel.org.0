Return-Path: <linux-wireless+bounces-10951-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 476F49477E2
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Aug 2024 11:03:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2FFB1F22853
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Aug 2024 09:03:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0680413D8B1;
	Mon,  5 Aug 2024 09:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="R4o5KS5a"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30FC315380B
	for <linux-wireless@vger.kernel.org>; Mon,  5 Aug 2024 09:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722848479; cv=none; b=ucvzXWZgUSskgW8m+nEXWNtEMBh70u91Ny7YHG8M25Ps2g74Pq9H9PteqWohJx0zrC7CR6SYgTiTRsOkgb47mA0qOdvYnTPnQ7Jq9cdb2MmHQQuJBe9cKNtTaHTQMTN5TAXHKS0ZGxeS/ESJT3ytjUeUuehVtomsywgBkMOOiVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722848479; c=relaxed/simple;
	bh=B5Rs+cz04j/+Mfq/rA0wZTmq3ySFxTO+cqspNnVuhA4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qOB53navrh11sYfEa/R8NBkuNE6Z1ig2NRokW+FWeTfP9o+Go5a1hwr4utTdIR8+OHEEAJAFwT1CjA546y6QBk8/vKAjmq/BxIWz2dqL0hIc4nNcFAdyco1UtDsIVZd4eQAlb3qC5n7Co9g4Xw3eLj03tK2HghjDncHtWduQIes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=R4o5KS5a; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 47591F5J03834779, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1722848475; bh=B5Rs+cz04j/+Mfq/rA0wZTmq3ySFxTO+cqspNnVuhA4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=R4o5KS5apMOuH0bqpZ+O59jwshdWPIDlDwuOxmtVj3Jr0kodvjXVOyVIgspkFONpl
	 CepnBNe+cOqsO4QEO0hQ9jCm7k/MkSwZw4I/u4QjKA035jXl32lpokQc+tMqSeTdgD
	 nw9lzQ9/tLTZW+eTB7/22LLcfcjAx+ALig64L09wuv04VYsBETJrw1wxqo4hskfDVf
	 WqQtiouxvWn46BbQ3S8/nBiUPsoNzX8TQCh+LWtXJjcVlKAQhAeJVQH1IeaXtJcdLR
	 naeKxachyBub1myj8rzeaR2fP79flt7XW1LGKm/jHJgPjPiEmvQlc9whlJFIrgw/pD
	 RmzD1Z9UGZbuw==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 47591F5J03834779
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Mon, 5 Aug 2024 17:01:15 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 5 Aug 2024 17:01:16 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 5 Aug
 2024 17:01:15 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <timlee@realtek.com>
Subject: [PATCH 5/5] wifi: rtw89: wow: add net-detect support for 8852c
Date: Mon, 5 Aug 2024 17:00:28 +0800
Message-ID: <20240805090028.27768-6-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240805090028.27768-1-pkshih@realtek.com>
References: <20240805090028.27768-1-pkshih@realtek.com>
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

From: Chin-Yen Lee <timlee@realtek.com>

Enable net-detect in WoWLan stub of 8852c, and declare
net-detect support up to 8 SSIDs.

Signed-off-by: Chin-Yen Lee <timlee@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/rtw8852c.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c.c b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
index 244f50e72549..dc1da9ff055c 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
@@ -2850,10 +2850,12 @@ static const struct rtw89_chanctx_listener rtw8852c_chanctx_listener = {
 
 #ifdef CONFIG_PM
 static const struct wiphy_wowlan_support rtw_wowlan_stub_8852c = {
-	.flags = WIPHY_WOWLAN_MAGIC_PKT | WIPHY_WOWLAN_DISCONNECT,
+	.flags = WIPHY_WOWLAN_MAGIC_PKT | WIPHY_WOWLAN_DISCONNECT |
+		 WIPHY_WOWLAN_NET_DETECT,
 	.n_patterns = RTW89_MAX_PATTERN_NUM,
 	.pattern_max_len = RTW89_MAX_PATTERN_SIZE,
 	.pattern_min_len = 1,
+	.max_nd_match_sets = RTW89_SCANOFLD_MAX_SSID,
 };
 #endif
 
-- 
2.25.1


