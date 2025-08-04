Return-Path: <linux-wireless+bounces-26110-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA86AB199D1
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Aug 2025 03:23:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C9621892490
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Aug 2025 01:24:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CEAA1EDA2B;
	Mon,  4 Aug 2025 01:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="QqFi7QEe"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6DBF1E9B31
	for <linux-wireless@vger.kernel.org>; Mon,  4 Aug 2025 01:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754270626; cv=none; b=X5v63VL1XlQ58CQ3crJ2z/Vewdu8skOz6/oogL6/FVyI/kgu5g/wbMRxL1c2pq83eHH7ZodDHebTggWCK4qJLK/pDWvNrjt/qTbk/uPeuX2VvnOwnZ3Z45pWbvzzLGCHyL03cu5oVc3Ji5ELMmP1YtCw51Epr5iR+eZl8i8gqYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754270626; c=relaxed/simple;
	bh=0QXGOWQSEJjwD+TtLLCb+Nil5prlf20p1Kkx5FhbjYc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XrA/NeEaQO5DUlZ2v7FFbWDsw6DbgTpU4yyIbbDbbeI8T/a/bpQZqtOq4G+kOfvfQiNlfPqLr1mRhUcx3oz1QkvPADQl+CkW1s0HvZyrX8NYOWITDMcJmNEw2vhlAb90hngK6YHrbxQSK6QeJRaJeOWAw75SGDLnAf+g9K6+bAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=QqFi7QEe; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5741NKJY03190088, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1754270600; bh=3TswCnP1jBCWLVM66OwgtUc0qkOS0YO8suAQL9RtR+Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=QqFi7QEeuO/35qTcB1DuZ55Vj6mLsvyFJI7KDfEhgUUzjJWoD/TYD4OJZUpJ3o6M7
	 HL1ZtScUiWXUDeexqNS+GwZ+m4toOlJI/h594mOi99FOEtasC76bIKGfM7dvl8xj13
	 bXcCUPXTJPyiKqeySQ3S4aEaQYywVLy7dVa9PLvtlmwBOjy8Clj+kIUVAc8sRBG/hg
	 fcJdbXnU7oCJmf0uvMdwEXAA6r1X9IKTidjq9HYFc2n/1VffaY33V7bUQZyiNCTey5
	 fKZog39soCUA+LC11riwHUL5GBoYZ+Y0EYr/hWE7Ii2+000A4kWqpJNSGLNrVT8yzL
	 xgZ6LE/3Uj7/A==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 5741NKJY03190088
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 4 Aug 2025 09:23:20 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 4 Aug 2025 09:23:21 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTKEXHMBS06.realtek.com.tw
 (10.21.1.56) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 4 Aug
 2025 09:23:20 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <rtl8821cerfe2@gmail.com>, <sean.anderson@linux.dev>
Subject: [PATCH rtw-next 1/2] wifi: rtw89: print just once for unknown C2H events
Date: Mon, 4 Aug 2025 09:22:33 +0800
Message-ID: <20250804012234.8913-2-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250804012234.8913-1-pkshih@realtek.com>
References: <20250804012234.8913-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTKEXHMBS06.realtek.com.tw (10.21.1.56)

When driver receives new or unknown C2H events, it print out messages
repeatedly once events are received, like

  rtw89_8922ae 0000:81:00.0: PHY c2h class 2 not support

To avoid the thousands of messages, use rtw89_info_once() instead. Also,
print out class/func for unknown (undefined) class.

Reported-by: Sean Anderson <sean.anderson@linux.dev>
Closes: https://lore.kernel.org/linux-wireless/20250729204437.164320-1-sean.anderson@linux.dev/
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/debug.h | 1 +
 drivers/net/wireless/realtek/rtw89/mac.c   | 7 +++----
 drivers/net/wireless/realtek/rtw89/phy.c   | 7 +++----
 3 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/debug.h b/drivers/net/wireless/realtek/rtw89/debug.h
index fc690f7c55dc..a364e7adb079 100644
--- a/drivers/net/wireless/realtek/rtw89/debug.h
+++ b/drivers/net/wireless/realtek/rtw89/debug.h
@@ -56,6 +56,7 @@ static inline void rtw89_debugfs_deinit(struct rtw89_dev *rtwdev) {}
 #endif
 
 #define rtw89_info(rtwdev, a...) dev_info((rtwdev)->dev, ##a)
+#define rtw89_info_once(rtwdev, a...) dev_info_once((rtwdev)->dev, ##a)
 #define rtw89_warn(rtwdev, a...) dev_warn((rtwdev)->dev, ##a)
 #define rtw89_err(rtwdev, a...) dev_err((rtwdev)->dev, ##a)
 
diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index 5a5da9d9c0c5..ef17a307b770 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -5813,12 +5813,11 @@ void rtw89_mac_c2h_handle(struct rtw89_dev *rtwdev, struct sk_buff *skb,
 	case RTW89_MAC_C2H_CLASS_ROLE:
 		return;
 	default:
-		rtw89_info(rtwdev, "MAC c2h class %d not support\n", class);
-		return;
+		break;
 	}
 	if (!handler) {
-		rtw89_info(rtwdev, "MAC c2h class %d func %d not support\n", class,
-			   func);
+		rtw89_info_once(rtwdev, "MAC c2h class %d func %d not support\n",
+				class, func);
 		return;
 	}
 	handler(rtwdev, skb, len);
diff --git a/drivers/net/wireless/realtek/rtw89/phy.c b/drivers/net/wireless/realtek/rtw89/phy.c
index d607577b353c..01a03d2de3ff 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.c
+++ b/drivers/net/wireless/realtek/rtw89/phy.c
@@ -3626,12 +3626,11 @@ void rtw89_phy_c2h_handle(struct rtw89_dev *rtwdev, struct sk_buff *skb,
 			handler = rtw89_phy_c2h_dm_handler[func];
 		break;
 	default:
-		rtw89_info(rtwdev, "PHY c2h class %d not support\n", class);
-		return;
+		break;
 	}
 	if (!handler) {
-		rtw89_info(rtwdev, "PHY c2h class %d func %d not support\n", class,
-			   func);
+		rtw89_info_once(rtwdev, "PHY c2h class %d func %d not support\n",
+				class, func);
 		return;
 	}
 	handler(rtwdev, skb, len);
-- 
2.25.1


