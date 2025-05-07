Return-Path: <linux-wireless+bounces-22703-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BF2DDAAD3D3
	for <lists+linux-wireless@lfdr.de>; Wed,  7 May 2025 05:12:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0C7E1BA49BC
	for <lists+linux-wireless@lfdr.de>; Wed,  7 May 2025 03:12:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A82AA1A9B53;
	Wed,  7 May 2025 03:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="TrCcHU8q"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 239FA1AD3E5
	for <linux-wireless@vger.kernel.org>; Wed,  7 May 2025 03:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746587537; cv=none; b=ZiKQytTZ97qpKYAst7hx0tdKzkMD1SxYkVu44kV0/CaQwHSVlpZl/h9bRg42829JXdunC3U992D0AOYVxLhXNKXLe7VywDvnuxz/jbXnZNaWcpURnDkKqGiuS+dbkRdhFc9Mrb8dj+iFAkjwj3l6ygrBjRgOJm+1bM+E/Eqp9dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746587537; c=relaxed/simple;
	bh=+L2EmnJj6fl/TTWxddO/OB2DyeIDOfGMP+UbIVDsthg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=elc5cj1Y+d+t9kEwxRUyoQPgaA/tDz/9vDQKTVKQHR0vNWpbpw/NF1uuJx8zMrAshdqWPzXPjKbg9At3ysguWkYLohoummZ/YTP2uUZkMRMwoi/C850Y8zNLeSmvb+1REYYkJozUvn8kThPZP1AL2/wbj3oEfVlV0DfIwkrteZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=TrCcHU8q; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 5473CAFW03701007, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1746587531; bh=+L2EmnJj6fl/TTWxddO/OB2DyeIDOfGMP+UbIVDsthg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=TrCcHU8qDFidJDsosREEvUxl9+92/cg6HMuAGdHCFyHjllYHCHGqQC+fj34IGR6S2
	 Cq6zylCdryKIY8bzriLP8J8Qi0h1baWK3R5JEdpm2/lkeVF96M+Ma2kSyPa1CH0TBb
	 OXCFpryTcBN4xlhFQQuPKbUdXvVWpcwXbfDq/iGB7phA+mc6s/IHoCOz+dCF0614mG
	 oYFToePuMozQ5BJRPBDv4F0ZvRmuEpewnIftXpX8Al7M5ANmVQ8J18UA+8JX8MrxzL
	 7me0Dec4TZyT1sNTYdzmMg5b5q8MgHYFf89n4KkXn/Pn8K8QuJFVHpYOJ4DtEkuFEz
	 8OZk8kmSwezsQ==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 5473CAFW03701007
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Wed, 7 May 2025 11:12:10 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 7 May 2025 11:12:11 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 7 May
 2025 11:12:10 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <dian_syuan0116@realtek.com>
Subject: [PATCH rtw-next] wifi: rtw89: leave idle mode when setting WEP encryption for AP mode
Date: Wed, 7 May 2025 11:12:03 +0800
Message-ID: <20250507031203.8256-1-pkshih@realtek.com>
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

From: Dian-Syuan Yang <dian_syuan0116@realtek.com>

Due to mac80211 triggering the hardware to enter idle mode, it fails
to install WEP key causing connected station can't ping successfully.
Currently, it forces the hardware to leave idle mode before driver
adding WEP keys.

Signed-off-by: Dian-Syuan Yang <dian_syuan0116@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/cam.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/cam.c b/drivers/net/wireless/realtek/rtw89/cam.c
index 34316e64b777..385a238fe5cc 100644
--- a/drivers/net/wireless/realtek/rtw89/cam.c
+++ b/drivers/net/wireless/realtek/rtw89/cam.c
@@ -6,6 +6,7 @@
 #include "debug.h"
 #include "fw.h"
 #include "mac.h"
+#include "ps.h"
 
 static struct sk_buff *
 rtw89_cam_get_sec_key_cmd(struct rtw89_dev *rtwdev,
@@ -475,9 +476,11 @@ int rtw89_cam_sec_key_add(struct rtw89_dev *rtwdev,
 
 	switch (key->cipher) {
 	case WLAN_CIPHER_SUITE_WEP40:
+		rtw89_leave_ips_by_hwflags(rtwdev);
 		hw_key_type = RTW89_SEC_KEY_TYPE_WEP40;
 		break;
 	case WLAN_CIPHER_SUITE_WEP104:
+		rtw89_leave_ips_by_hwflags(rtwdev);
 		hw_key_type = RTW89_SEC_KEY_TYPE_WEP104;
 		break;
 	case WLAN_CIPHER_SUITE_TKIP:
-- 
2.25.1


