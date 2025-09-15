Return-Path: <linux-wireless+bounces-27284-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 580DCB570A8
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Sep 2025 08:53:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6800189CAC8
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Sep 2025 06:54:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB1352C029C;
	Mon, 15 Sep 2025 06:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="EHclCo+N"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4FE22C028B
	for <linux-wireless@vger.kernel.org>; Mon, 15 Sep 2025 06:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757919221; cv=none; b=G52N4o8IjZDslBBt6JiEG7LNLGB3qUNP2HEiS/LyaXKmqVqnedy+/rpjIPDKJEyLnZ+FzZc49SwtPUDhTpEEDJTYQwnpnRYEOqkmpLz2X3MWpjqyylj19aSWpBmgmx3ITEL5LXX2ofTrO6xX45KF5XloSqMqVXa0+TACOTyun8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757919221; c=relaxed/simple;
	bh=rjw0He/8FsWw6v5G6ZTBcunMTVHVe33hBfbn9TtaEcA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RmEjyLaL8Q3LIKf9ExFLbgpOvb3CQE0PulMFvt3hDX/MjzK5v5JazsfiBWHpMickwk7NFNvUl2xva2UDJrWQhhfN+HCmFVMjAuCVUY18d5rmUJPTtt5YDvg2JKjGjcgFZoaePZ2Ab2PXZCh2bThijC9HrYCHdcrDgLpPi5cnDL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=EHclCo+N; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 58F6raG93591125, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1757919216; bh=9wUBPkyypGK1PzcjCAu9pWz8ZLtKM+cF0ovghLjB68Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=EHclCo+NEn2mAwPxRJh8pU9iAPIOq4WlIKBENFJbs0RklIvs1mPgrl8A942d7tX6X
	 VwDDBe0YVIcjoPPyesB/nnO7LqKS+X1INP6VBvpHpMWzcJIE+r9Oq6o/j3OoOeaJyp
	 G8TMMkCaS+C5p4KoFgacos/wlUIoejIQfyhYyGtSpeTM0E/OzxFzdDv+jU5nFxJz6i
	 vRkkATRdSvnxpH/1T7sZJX24Gyv/2jZ8O76+eXRNlVVg9zfOCbAEGwXAkCX7HnB2JS
	 vkw/IfC6SoDjCqnk6KcxrsgAcahTEobgot3vN7r1bSJFeCkYIssGc8PuctiXR3yZXn
	 oCERQbjMH7+0A==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 58F6raG93591125
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Mon, 15 Sep 2025 14:53:36 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Mon, 15 Sep 2025 14:53:36 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTKEXHMBS06.realtek.com.tw
 (10.21.1.56) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.27; Mon, 15 Sep
 2025 14:53:36 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <gary.chang@realtek.com>, <damon.chen@realtek.com>,
        <kevin_yang@realtek.com>
Subject: [PATCH rtw-next 01/11] wifi: rtw89: chan: allow callers to check if a link has no managed chanctx
Date: Mon, 15 Sep 2025 14:52:03 +0800
Message-ID: <20250915065213.38659-2-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250915065213.38659-1-pkshih@realtek.com>
References: <20250915065213.38659-1-pkshih@realtek.com>
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

From: Zong-Zhe Yang <kevin_yang@realtek.com>

Originally, to directly align with the chanctx design, getter of managed
chanctx returned a default channel when a link doesn't own a chanctx yet.
Then, callers could simply use the return without trivial NULL checking.

But in MLD HW settings of next chip, there will be a special case that a
caller needs to check if a link has owned chanctx or not to determine
CCK hardware circuit working on HW-x. So, add a func *_or_null for this
first.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/chan.c | 11 ++++++++++-
 drivers/net/wireless/realtek/rtw89/chan.h | 10 ++++++++--
 2 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/chan.c b/drivers/net/wireless/realtek/rtw89/chan.c
index f7d1c5d3b92e..86f1b39a967f 100644
--- a/drivers/net/wireless/realtek/rtw89/chan.c
+++ b/drivers/net/wireless/realtek/rtw89/chan.c
@@ -281,6 +281,7 @@ void rtw89_entity_init(struct rtw89_dev *rtwdev)
 {
 	struct rtw89_hal *hal = &rtwdev->hal;
 	struct rtw89_entity_mgnt *mgnt = &hal->entity_mgnt;
+	int i, j;
 
 	hal->entity_pause = false;
 	bitmap_zero(hal->entity_map, NUM_OF_RTW89_CHANCTX);
@@ -289,6 +290,11 @@ void rtw89_entity_init(struct rtw89_dev *rtwdev)
 
 	INIT_LIST_HEAD(&mgnt->active_list);
 
+	for (i = 0; i < RTW89_MAX_INTERFACE_NUM; i++) {
+		for (j = 0; j < __RTW89_MLD_MAX_LINK_NUM; j++)
+			mgnt->chanctx_tbl[i][j] = RTW89_CHANCTX_IDLE;
+	}
+
 	rtw89_config_default_chandef(rtwdev);
 }
 
@@ -353,7 +359,7 @@ static void rtw89_normalize_link_chanctx(struct rtw89_dev *rtwdev,
 
 const struct rtw89_chan *__rtw89_mgnt_chan_get(struct rtw89_dev *rtwdev,
 					       const char *caller_message,
-					       u8 link_index)
+					       u8 link_index, bool nullchk)
 {
 	struct rtw89_hal *hal = &rtwdev->hal;
 	struct rtw89_entity_mgnt *mgnt = &hal->entity_mgnt;
@@ -400,6 +406,9 @@ const struct rtw89_chan *__rtw89_mgnt_chan_get(struct rtw89_dev *rtwdev,
 	return rtw89_chan_get(rtwdev, chanctx_idx);
 
 dflt:
+	if (unlikely(nullchk))
+		return NULL;
+
 	rtw89_debug(rtwdev, RTW89_DBG_CHAN,
 		    "%s (%s): prefetch NULL on link index %u\n",
 		    __func__, caller_message ?: "", link_index);
diff --git a/drivers/net/wireless/realtek/rtw89/chan.h b/drivers/net/wireless/realtek/rtw89/chan.h
index b1175419f92b..5b22764d5329 100644
--- a/drivers/net/wireless/realtek/rtw89/chan.h
+++ b/drivers/net/wireless/realtek/rtw89/chan.h
@@ -180,10 +180,16 @@ void rtw89_chanctx_proceed(struct rtw89_dev *rtwdev,
 
 const struct rtw89_chan *__rtw89_mgnt_chan_get(struct rtw89_dev *rtwdev,
 					       const char *caller_message,
-					       u8 link_index);
+					       u8 link_index, bool nullchk);
 
 #define rtw89_mgnt_chan_get(rtwdev, link_index) \
-	__rtw89_mgnt_chan_get(rtwdev, __func__, link_index)
+	__rtw89_mgnt_chan_get(rtwdev, __func__, link_index, false)
+
+static inline const struct rtw89_chan *
+rtw89_mgnt_chan_get_or_null(struct rtw89_dev *rtwdev, u8 link_index)
+{
+	return __rtw89_mgnt_chan_get(rtwdev, NULL, link_index, true);
+}
 
 struct rtw89_mcc_links_info {
 	struct rtw89_vif_link *links[NUM_OF_RTW89_MCC_ROLES];
-- 
2.25.1


