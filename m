Return-Path: <linux-wireless+bounces-26047-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 33585B152D0
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Jul 2025 20:28:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E458E7A760F
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Jul 2025 18:27:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ACF11DE4C3;
	Tue, 29 Jul 2025 18:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="k9PnZBDz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 557BF23496F
	for <linux-wireless@vger.kernel.org>; Tue, 29 Jul 2025 18:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753813695; cv=none; b=B1KQL08MtnqiREAU0GIpq/guj8sbyXEwF8OZrTPEjyQqXUbYInctUGxsHkDD8lNKWUNkiQzkDG8ufUbRp+eIdKdikwJ1hGsakS/yuQbsKgMGCowpCd9m6Cut2taYBob66puiugZ+J+nUWl8u+UxDpv+zsEltbrP72Q317rjyX4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753813695; c=relaxed/simple;
	bh=lMOnLS0VwxtEidxWiWAWCVrcvx0yHEOJ14h47dL6mgk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ltu8RMUXkTp1zQXATMuHqaBWulT/LBB+M5pfSb0jmg6tmvqoBhOb9J7uG9jEdBZ2Jh4jHn0azDaoVs34xQMzzHjNtyOwaPWlvo5JfzNnewKyfa6CgjlWawfm2sh7tPL9rc/M2apZnFEr+5xnITv2tV0Poz884iu6CZ1CrAtZ9J8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=k9PnZBDz; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1753813681;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=DOaP5vz8UTvnvKSp2Fkp0F+QZjKjpVri0xMUDcS+yUw=;
	b=k9PnZBDzaEgmOO9Ef6FzSoZb4H6Lbl6FunJ/LLbTqGJI3DxhWChomAK2ZTzsTv2MmPeuUF
	Wg3e3gq5drKt3rUAK+HHZaYXETgkLgu48yaXXQPcVSpPuFi10huce0WQ17xkMPeu3GJFfe
	h9EJd/cEtJIb1w12bP4Wad4VYmfuKdw=
From: Sean Anderson <sean.anderson@linux.dev>
To: Ping-Ke Shih <pkshih@realtek.com>,
	linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Sean Anderson <sean.anderson@linux.dev>
Subject: [PATCH] wifi: rtw89: Print only once for unsupported c2h classes
Date: Tue, 29 Jul 2025 14:27:43 -0400
Message-Id: <20250729182743.114733-1-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

There are more unsupported functions than just LOWRT_RTY. Improve on
commit 3b66519b023b ("wifi: rtw89: phy: add dummy c2h handler to avoid
warning message") by printing a message just once when we first
encounter an unsupported class. This prevents messages like

rtw89_8922ae 0000:81:00.0: PHY c2h class 2 not support

from filling up dmesg.

Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
---

 drivers/net/wireless/realtek/rtw89/phy.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/phy.c b/drivers/net/wireless/realtek/rtw89/phy.c
index f4eee642e5ce..5280ffd77b39 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.c
+++ b/drivers/net/wireless/realtek/rtw89/phy.c
@@ -3535,6 +3535,7 @@ void rtw89_phy_c2h_handle(struct rtw89_dev *rtwdev, struct sk_buff *skb,
 {
 	void (*handler)(struct rtw89_dev *rtwdev,
 			struct sk_buff *c2h, u32 len) = NULL;
+	static DECLARE_BITMAP(printed_support, U8_MAX);
 
 	switch (class) {
 	case RTW89_PHY_C2H_CLASS_RA:
@@ -3549,17 +3550,15 @@ void rtw89_phy_c2h_handle(struct rtw89_dev *rtwdev, struct sk_buff *skb,
 		if (func < ARRAY_SIZE(rtw89_phy_c2h_rfk_report_handler))
 			handler = rtw89_phy_c2h_rfk_report_handler[func];
 		break;
-	case RTW89_PHY_C2H_CLASS_DM:
-		if (func == RTW89_PHY_C2H_DM_FUNC_LOWRT_RTY)
-			return;
-		fallthrough;
 	default:
-		rtw89_info(rtwdev, "PHY c2h class %d not support\n", class);
+		if (!test_and_set_bit(class, printed_support))
+			rtw89_info(rtwdev, "PHY c2h class %d not supported\n",
+				   class);
 		return;
 	}
 	if (!handler) {
-		rtw89_info(rtwdev, "PHY c2h class %d func %d not support\n", class,
-			   func);
+		rtw89_info(rtwdev, "PHY c2h class %d func %d not supported\n",
+			   class, func);
 		return;
 	}
 	handler(rtwdev, skb, len);
-- 
2.35.1.1320.gc452695387.dirty


