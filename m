Return-Path: <linux-wireless+bounces-13457-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DD3D98ED5E
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Oct 2024 12:53:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 164841F23151
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Oct 2024 10:53:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB9921459E4;
	Thu,  3 Oct 2024 10:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="SLZF5r9l"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FFFC153836
	for <linux-wireless@vger.kernel.org>; Thu,  3 Oct 2024 10:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727952767; cv=none; b=f8eavSNZopBlVP5qrZrfNIC7XoBtG1YcLr/iDpmvofZaYco1mIKBvhVYITnbfGaz9PPOCMM3lWbEOiQPtewoTBX1uQChJrC2fZ9juPfL+h0mA03cbdlgN3/3S8zYdsoiB3dz8dxKci0iTJtHuFNqAZhGj0e+BHH1+LfzCh5YosY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727952767; c=relaxed/simple;
	bh=CYc0qkUmAKlCl0XZj4Q5KizTg5KHu1EW/4ItczLJEbo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U4udQyERghwRieWj6lMKAwx6SGsYb7YIIOXidp7oPjaO4IPiqSAK2SWjiVon5lWTT3tRS35FLwA0TaZTpkArCH2O5dG4vBAuKC/8ObwZa1WBuuod+GXtM+6wGTss826l9zdMNcEL+7aPekAm561cVM5ME6sIobRbOq1UxBQ2FuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=SLZF5r9l; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 493AqhOT33828700, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1727952763; bh=CYc0qkUmAKlCl0XZj4Q5KizTg5KHu1EW/4ItczLJEbo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=SLZF5r9lxWAWdBpVGuoJUAUYXw593//ZIWSuYO5Wv/HARzN6VePxxz/bMUoJGVvyY
	 mPPDG8xw4CSu4xvcbg5en1mcYPvkv0Ck4e/RT2IlBybz877xBHQMP38RInLArPNbZi
	 IEgRIkiMw6YvnXT0/UR8SEnatVLTBd3EP9MdMY3xn5drP7nhTOAjriOUiD6UbKe7X6
	 FQq9hoIDZC/YzchV/QLb0UloIHw/Afms6B0dPzYXkxu5VdRJqUct8yGcPevqoZ13Xz
	 vxb5OUcnNi1Y2q6deTDPehYraOsD0XvXXZac8rhBpslVKJbmNtnzkUd6RDqSzMrN5Y
	 fJ6UMDq6Q3rKQ==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.05/5.92) with ESMTPS id 493AqhOT33828700
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Thu, 3 Oct 2024 18:52:43 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 3 Oct 2024 18:52:43 +0800
Received: from [127.0.1.1] (172.16.22.72) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 3 Oct
 2024 18:52:42 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <ku920601@realtek.com>
Subject: [PATCH 3/4] wifi: rtw89: coex: Solved BT PAN profile idle decrease Wi-Fi throughput
Date: Thu, 3 Oct 2024 18:51:39 +0800
Message-ID: <20241003105140.10867-4-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241003105140.10867-1-pkshih@realtek.com>
References: <20241003105140.10867-1-pkshih@realtek.com>
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

From: Ching-Te Ku <ku920601@realtek.com>

Some Bluetooth device will make up connection as PAN link, though the
connection is idle, it will still report the PAN link is active. The
coexistence mechanism will enable TDMA to protect the PAN, it makes
Wi-Fi throughput degrade at least 50%. But the link is idle, don't
need so much bandwidth. Add TDMA case to let Wi-Fi can do traffic 80%
bandwidth.

Signed-off-by: Ching-Te Ku <ku920601@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/coex.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/coex.c b/drivers/net/wireless/realtek/rtw89/coex.c
index 1c0169e2927e..3350e982ca5a 100644
--- a/drivers/net/wireless/realtek/rtw89/coex.c
+++ b/drivers/net/wireless/realtek/rtw89/coex.c
@@ -4636,12 +4636,21 @@ static void _action_bt_a2dpsink(struct rtw89_dev *rtwdev)
 static void _action_bt_pan(struct rtw89_dev *rtwdev)
 {
 	struct rtw89_btc *btc = &rtwdev->btc;
+	struct rtw89_btc_bt_link_info *bt_linfo = &btc->cx.bt.link_info;
+	struct rtw89_btc_bt_a2dp_desc a2dp = bt_linfo->a2dp_desc;
+	struct rtw89_btc_bt_pan_desc pan = bt_linfo->pan_desc;
 
 	_set_ant(rtwdev, NM_EXEC, BTC_PHY_ALL, BTC_ANT_W2G);
 
 	switch (btc->cx.state_map) {
 	case BTC_WBUSY_BNOSCAN: /* wl-busy + bt-PAN */
-		_set_policy(rtwdev, BTC_CXP_PFIX_TD5050, BTC_ACT_BT_PAN);
+		if (a2dp.active || !pan.exist) {
+			btc->dm.slot_dur[CXST_W1] = 80;
+			btc->dm.slot_dur[CXST_B1] = 20;
+			_set_policy(rtwdev, BTC_CXP_PFIX_TDW1B1, BTC_ACT_BT_PAN);
+		} else {
+			_set_policy(rtwdev, BTC_CXP_PFIX_TD5050, BTC_ACT_BT_PAN);
+		}
 		break;
 	case BTC_WBUSY_BSCAN: /* wl-busy + bt-inq + bt-PAN */
 		_set_policy(rtwdev, BTC_CXP_PFIX_TD3070, BTC_ACT_BT_PAN);
-- 
2.25.1


