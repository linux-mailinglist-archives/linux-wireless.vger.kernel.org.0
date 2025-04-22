Return-Path: <linux-wireless+bounces-21814-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 232C7A95AAB
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Apr 2025 03:47:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BBDF27A30B1
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Apr 2025 01:46:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B532C1624EA;
	Tue, 22 Apr 2025 01:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="rA0bG0Dc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F38B8645
	for <linux-wireless@vger.kernel.org>; Tue, 22 Apr 2025 01:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745286448; cv=none; b=fq4aMObBssPcruepk1nNnGNq5n1ZG/K4B6K+rIdj7GUx6yvWFLDAWA4FcujShqfMTUmEVhE4Kj2GBA99mgIrysZUnCJEBKRgdiGGaJ7+BAH9tFqSlBNdaWrG5R0axZCn1FWsAlt5jtCj4v9Cx+/tYBf+JmveTgzbGrPK2+XG5Iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745286448; c=relaxed/simple;
	bh=qtLD2oiorJMRJ2jfgoY3SkXEbnNmi2vsd6SeNIq2SQU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Lkx6Uy/Dqkt0EuSccAczLyldSrkzooYeJCS4P+G4UHANBfFgpC23uwjPwBEVmkbUYZk4dtPjuur2EzsmXHz112Zt4bSynrI4um85nt8AwUYFqKkZlPxP6DW1S3/2FndaSIK2f2Ps23pe9OqOpQIPtJEGm0oWyApsxGNas0dKqjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=rA0bG0Dc; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 53M1lP3C13859575, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1745286445; bh=qtLD2oiorJMRJ2jfgoY3SkXEbnNmi2vsd6SeNIq2SQU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=rA0bG0DcW5x1PNY1f8BH16MQ+k4VpvTrQ0Ysj90x3ninmJvr90x1sn6U7kt2Mh2kb
	 8ybMClYTSwgoLc1GfYD7xf114BbsdxcbwhQ1cmvzrFtZgEn4tAQsZq5PoHmMEQKsYu
	 TFHNSfxsymmXnPCDnj54chnw7VG4ftIDpm6iB7dlwwFtn4ebO/lbdt6VTAPeHUcAJN
	 XgnkYd6ie4awBVNoJ/dAuuPw1o59CKcKFujVOt4doI5E5Ix7Y4bk+DH8wqJ1ZVfaoG
	 G8/ZXKSvAs25vEwcWocufc4pn20PJshzKs7O6k6oFefSV4wcaUucfHXNYkrHK33BdK
	 EfIi4UgAvk9QA==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 53M1lP3C13859575
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Tue, 22 Apr 2025 09:47:25 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 22 Apr 2025 09:47:25 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Tue, 22 Apr
 2025 09:47:24 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <damon.chen@realtek.com>, <kevin_yang@realtek.com>
Subject: [PATCH rtw-next 09/12] wifi: rtw89: mcc: update entire plan when courtesy config changes
Date: Tue, 22 Apr 2025 09:46:17 +0800
Message-ID: <20250422014620.18421-10-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250422014620.18421-1-pkshih@realtek.com>
References: <20250422014620.18421-1-pkshih@realtek.com>
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

From: Zong-Zhe Yang <kevin_yang@realtek.com>

MCC has a courtesy mechanism which allows one role to use another's
duration in a given cycle. Courtesy mechanism will be enabled when
one role has a not perfect duration. Otherwise, not. When MCC updates,
duration of each role will be re-calculated. And then, the new courtesy
config might be different from the old one. However, to change courtesy
config, the entire MCC plan requires to be renewed when MCC updates.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/chan.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/chan.c b/drivers/net/wireless/realtek/rtw89/chan.c
index 530f8c52efe8..ac88f51c679b 100644
--- a/drivers/net/wireless/realtek/rtw89/chan.c
+++ b/drivers/net/wireless/realtek/rtw89/chan.c
@@ -2142,6 +2142,7 @@ static int rtw89_mcc_update(struct rtw89_dev *rtwdev)
 	struct rtw89_mcc_info *mcc = &rtwdev->mcc;
 	struct rtw89_mcc_config *config = &mcc->config;
 	struct rtw89_mcc_config old_cfg = *config;
+	bool courtesy_changed;
 	bool sync_changed;
 	int ret;
 
@@ -2154,8 +2155,15 @@ static int rtw89_mcc_update(struct rtw89_dev *rtwdev)
 	if (ret)
 		return ret;
 
+	if (memcmp(&old_cfg.pattern.courtesy, &config->pattern.courtesy,
+		   sizeof(old_cfg.pattern.courtesy)) == 0)
+		courtesy_changed = false;
+	else
+		courtesy_changed = true;
+
 	if (old_cfg.pattern.plan != RTW89_MCC_PLAN_NO_BT ||
-	    config->pattern.plan != RTW89_MCC_PLAN_NO_BT) {
+	    config->pattern.plan != RTW89_MCC_PLAN_NO_BT ||
+	    courtesy_changed) {
 		if (rtw89_concurrent_via_mrc(rtwdev))
 			ret = __mrc_fw_start(rtwdev, true);
 		else
-- 
2.25.1


