Return-Path: <linux-wireless+bounces-17728-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B39B7A165C1
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Jan 2025 04:40:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B1A057A0353
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Jan 2025 03:40:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D41B7E1;
	Mon, 20 Jan 2025 03:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="GoemFzMK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48C373A1DB
	for <linux-wireless@vger.kernel.org>; Mon, 20 Jan 2025 03:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737344424; cv=none; b=eyu4XEKvr2sFKRKUTu8V+iepO/n4bmR57pERx5eHKM/708Ap6hf5B5uBXTbua+qrSqB4reYPthU2nh6GhZ0ArlQvU6jjMDjweCNMpUB2OyXA1nwYjRggiMUAOrrgU3tfE/lkcj27fEpTMHgniRXImy/uqruXEy2O6aAPrR9QSbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737344424; c=relaxed/simple;
	bh=NV+Wujs8G53HaN41NUrvzs4xC6WYfyc3qRQTDiBLhkY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=R83i5+NeRfhirn1sFDjBY8Fgt7goWeP/lv3JzMcTGZUO0yEelbiHIwetJrATRMhgSvwuGNvotUX678BfuJDuCvLoZIRa+RIWpiejtkbq2sTJfXpfykC5FzoxPi9kzCFimVgHuY5LAtnM/hjoqAkbwEdGZ6LqgIjPM8tfo/JZPeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=GoemFzMK; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 50K3eJlfD2664320, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1737344419; bh=NV+Wujs8G53HaN41NUrvzs4xC6WYfyc3qRQTDiBLhkY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=GoemFzMKz1o14PY3WIf6M6/XAQXZnMGK6OqXKLwKAJPUz6PMuMV9R4mtQw1h+ph0+
	 GjRc4deq0BhcA9ez4wPhSkv3Am29BNnhr6paODiEkTo2RaTLM9gpWgT9HB+YmEhTVt
	 mJSWWx4sPapi1iObFGnxiF4O8JnGMPv8WzIAgwWdEpQHqCdPY7wgJYOWATz7Fy53KY
	 rfhFXF7z91U/0CImMDvgCjC3gvZctl3fjHPONrMpNLZ+zqKErp6GPcwsNm9k3qsFf5
	 umcCYVoW0PpLrgrc0MlnkNjHDx3LdjGO9Djbo1EZ3G9HVZsQjkdwUCado4tAXDyraI
	 8sjN6dCB0zNiA==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 50K3eJlfD2664320
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Mon, 20 Jan 2025 11:40:19 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 20 Jan 2025 11:40:20 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 20 Jan
 2025 11:40:19 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <kevin_yang@realtek.com>
Subject: [PATCH] wifi: rtw89: cleanup unused rtwdev::roc_work
Date: Mon, 20 Jan 2025 11:40:04 +0800
Message-ID: <20250120034004.21135-1-pkshih@realtek.com>
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

From: Zong-Zhe Yang <kevin_yang@realtek.com>

The needed one was moved to rtwvif::roc_work. And, rtwdev::roc_work is
unused. So, remove it.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 0f2a46e36b04..e4f2c3100833 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -5701,7 +5701,6 @@ struct rtw89_dev {
 	struct delayed_work coex_rfk_chk_work;
 	struct delayed_work cfo_track_work;
 	struct delayed_work forbid_ba_work;
-	struct delayed_work roc_work;
 	struct delayed_work antdiv_work;
 	struct rtw89_ppdu_sts_info ppdu_sts;
 	u8 total_sta_assoc;
-- 
2.25.1


