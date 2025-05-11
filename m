Return-Path: <linux-wireless+bounces-22835-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 14E95AB2668
	for <lists+linux-wireless@lfdr.de>; Sun, 11 May 2025 05:53:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02FE67B0EC3
	for <lists+linux-wireless@lfdr.de>; Sun, 11 May 2025 03:51:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B6C318B47E;
	Sun, 11 May 2025 03:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="eWx2rTLs"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F0A61885B8
	for <linux-wireless@vger.kernel.org>; Sun, 11 May 2025 03:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746935571; cv=none; b=muTyaUGk5yMQfaSHMdiAKydSD9et6cSKNwt32Ujcz99eZxlvGsX+N/j5a/jr8HhvZI8/pTrUptNJhhiJ+H/o+WWpVJ/P/My3SHLGUl6qBdDhZg9azCOkvNLCi02FtWszsg+otxsIxzJ4pNTdeocSju/44//XKDq0xqb9k5REHZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746935571; c=relaxed/simple;
	bh=6kd7W2yV7IVYikrigN8SJRyfk8xW+bqV+SGZMUAhm7c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dMKct1Yx1XgW1Ev35TfWVx8u1t0u5xujetwMEp1lMtgY0meZJzlT2n0FXxUjdBxZUOhxhRlvwssRpH+w2ayxj2feM9kxT2GxabjhVaGMN8nFmqDccHk0XCK6g6d54JNDqy3BvNSjlvuI2H4dfMGDby4PFhkYXfAuCcP2ZsJORBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=eWx2rTLs; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 54B3qeexF3302879, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1746935560; bh=6kd7W2yV7IVYikrigN8SJRyfk8xW+bqV+SGZMUAhm7c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=eWx2rTLsHn4RMwA/4JtSku5VUXqVJ+qH7Hn/+CS8ESWGuQ9/+rGUsahR9uQ7wr7UU
	 NFbzW+OSAxFCTROTzRevNf8zzGamTZYjbWrxsxiKri0BUgcbh3OmYBulKbJhcDlMLD
	 aoX4S/+NcxrjmvCMxQVmS0SeQHpoC4YjueXMV/XIBng41vUhtpUmGhC5LzPfwkfIA8
	 c+oVdN8/Tsk73jiInaB7RCM/LyfwMq1yWdJcJnNPrgcXGMlo/SjCv7O8Etfc9Uu+FT
	 2y9lYLm39SqLC/KhD7rG1hL2UuZGSGnwjKw/DENVwB8QhaEIX8goE0QXU3xj23s2cR
	 EWohGZ52nRkIQ==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 54B3qeexF3302879
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Sun, 11 May 2025 11:52:40 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 11 May 2025 11:52:40 +0800
Received: from [127.0.1.1] (10.22.224.86) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Sun, 11 May
 2025 11:52:40 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <kevin_yang@realtek.com>
Subject: [PATCH rtw-next 2/6] wifi: rtw89: mcc: drop queued chanctx changes when stopping
Date: Sun, 11 May 2025 11:52:13 +0800
Message-ID: <20250511035217.10410-3-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250511035217.10410-1-pkshih@realtek.com>
References: <20250511035217.10410-1-pkshih@realtek.com>
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

When MCC is about to stop, there may be some chanctx changes which are
queued for work but have not yet been run. To avoid these changes from
being processed in a wrong state (e.g. next new MCC instance), cancel
the queued work and drop queued changes.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/chan.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/chan.c b/drivers/net/wireless/realtek/rtw89/chan.c
index ff476bde39ab..e733564abc7a 100644
--- a/drivers/net/wireless/realtek/rtw89/chan.c
+++ b/drivers/net/wireless/realtek/rtw89/chan.c
@@ -2150,6 +2150,7 @@ static int rtw89_mcc_stop_sel_iterator(struct rtw89_dev *rtwdev,
 static void rtw89_mcc_stop(struct rtw89_dev *rtwdev,
 			   const struct rtw89_chanctx_pause_parm *pause)
 {
+	struct rtw89_hal *hal = &rtwdev->hal;
 	struct rtw89_mcc_info *mcc = &rtwdev->mcc;
 	struct rtw89_mcc_role *ref = &mcc->role_ref;
 	struct rtw89_mcc_stop_sel sel = {
@@ -2157,6 +2158,11 @@ static void rtw89_mcc_stop(struct rtw89_dev *rtwdev,
 	};
 	int ret;
 
+	if (!pause) {
+		wiphy_delayed_work_cancel(rtwdev->hw->wiphy, &rtwdev->chanctx_work);
+		bitmap_zero(hal->changes, NUM_OF_RTW89_CHANCTX_CHANGES);
+	}
+
 	/* by default, stop at ref */
 	rtw89_iterate_mcc_roles(rtwdev, rtw89_mcc_stop_sel_iterator, &sel);
 	if (!sel.filled)
-- 
2.25.1


