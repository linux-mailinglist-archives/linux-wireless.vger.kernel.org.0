Return-Path: <linux-wireless+bounces-22441-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C57A9AA8CFF
	for <lists+linux-wireless@lfdr.de>; Mon,  5 May 2025 09:26:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36895172496
	for <lists+linux-wireless@lfdr.de>; Mon,  5 May 2025 07:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4647F1DB546;
	Mon,  5 May 2025 07:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="GGxvLPfT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C2AC1DB13E
	for <linux-wireless@vger.kernel.org>; Mon,  5 May 2025 07:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746429934; cv=none; b=DhYskH1LJhLRxWXM4l8VP+9YtLgODeGEktyOR2imnBJm9jH+OEphDxM2CukBC1y0Yqwf2jQFLUqEF7gilY0iqjZdm9AzFT8mwOcXotFF9KPP/6zas5fad/1lBJrwPtct7F9ScIf/THlNebsFmdTIq1D3TkH2S3sfiZ1/jMJPRno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746429934; c=relaxed/simple;
	bh=YSDoewFXL4OD/hSXyJxeGOqe+eKCMe2gpoUG2b99b4E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m70u6xnYBTZCdxT7Xsyy2j/r9l4d0IgS7rzu8YAEzMJPzIkT6IRc06MOVsxbiDssPGhOt5+d64DYPsyQjzMM0GoUyEwx+CT+AB3ThCgK6ZSq4ppGLCCrdn4fqFLkL90VzotUJR6PTpqAdaBpqaEOWnMPbBj8OKwrT8qYVbQxPTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=GGxvLPfT; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 5457PTvG43831300, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1746429929; bh=YSDoewFXL4OD/hSXyJxeGOqe+eKCMe2gpoUG2b99b4E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=GGxvLPfTAQeG0/Sp2N7Ou66d4/VKl+kbK/6kK0hYhSGv6e7+2TKAWct89GcQxp3Xx
	 QOlEB/MZR+SMrLpSQ+y9VnROFx+UlCIIskrOckp+gP8LZSm+USHZHa9voX/T2yRKpQ
	 LUMsjyLAdFEtpAvKiDPg8xAP5Y4vmCGw81e3YVBvJ2olPuGNFez3fpTsoHZXYquGkf
	 YVdSaR+MwKGCog8NO3ALV8O06xvx6SYruEQJXLht4DR+0JaEbe7XTWGa0ZaERlttnd
	 XbLX56IM30KR1ppA+HJ0cQ2Z5aPwMPpbKKn99/ljSuYtNQNsGQSH9cfhnJE9HpBSVi
	 SoXkG92zlwMnw==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 5457PTvG43831300
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Mon, 5 May 2025 15:25:29 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 5 May 2025 15:25:29 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 5 May
 2025 15:25:28 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <phhuang@realtek.com>, <kevin_yang@realtek.com>
Subject: [PATCH rtw-next 11/11] wifi: rtw89: declare MLO support if prerequisites are met
Date: Mon, 5 May 2025 15:24:40 +0800
Message-ID: <20250505072440.45113-12-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250505072440.45113-1-pkshih@realtek.com>
References: <20250505072440.45113-1-pkshih@realtek.com>
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

When the following prerequisites are met, driver will enable support_mlo.
It means that driver will declare WIPHY_FLAG_SUPPORTS_MLO, and then deal
with MLO related things.

The main prerequisites are as below.
1. all prerequisites for running with chanctx
2. FW feature NOTIFY_AP_INFO

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 22a0c54de716..0b6fb30cbf52 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -5666,13 +5666,13 @@ struct rtw89_dev *rtw89_alloc_ieee80211_hw(struct device *device,
 	if (!hw)
 		goto err;
 
-	/* TODO: When driver MLO arch. is done, determine whether to support MLO
-	 * according to the following conditions.
-	 * 1. run with chanctx_ops
-	 * 2. chip->support_link_num != 0
-	 * 3. FW feature supports AP_LINK_PS
+	/* Currently, our AP_LINK_PS handling only works for non-MLD softap
+	 * or MLD-single-link softap. If RTW89_MLD_NON_STA_LINK_NUM enlarges,
+	 * please tweak entire AP_LINKS_PS handling before supporting MLO.
 	 */
-	support_mlo = false;
+	support_mlo = !no_chanctx && chip->support_link_num &&
+		      RTW89_CHK_FW_FEATURE(NOTIFY_AP_INFO, &early_fw) &&
+		      RTW89_MLD_NON_STA_LINK_NUM == 1;
 
 	hw->wiphy->iface_combinations = rtw89_iface_combs;
 
-- 
2.25.1


