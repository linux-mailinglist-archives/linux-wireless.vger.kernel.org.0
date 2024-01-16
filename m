Return-Path: <linux-wireless+bounces-1964-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 46B8B82EAAE
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Jan 2024 09:10:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D99AE1F23658
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Jan 2024 08:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89D3011C8B;
	Tue, 16 Jan 2024 08:10:26 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C96A911C83
	for <linux-wireless@vger.kernel.org>; Tue, 16 Jan 2024 08:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 40G8A8420147641, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 40G8A8420147641
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Jan 2024 16:10:08 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.17; Tue, 16 Jan 2024 16:10:08 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Tue, 16 Jan
 2024 16:10:08 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <Jes.Sorensen@gmail.com>, <kvalo@kernel.org>
CC: <martin.kaistra@linutronix.de>, <lkp@intel.com>,
        <linux-wireless@vger.kernel.org>
Subject: [PATCH 2/2] wifi: rtl8xxxu: make instances of iface limit and combination to be static const
Date: Tue, 16 Jan 2024 16:09:45 +0800
Message-ID: <20240116080945.20172-2-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240116080945.20172-1-pkshih@realtek.com>
References: <20240116080945.20172-1-pkshih@realtek.com>
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

rtl8xxxu_limits and rtl8xxxu_combinations can be static const, so add
modifiers as desire. Otherwise, Sparse reports warnings

rtl8xxxu_core.c:7677:30: warning: symbol 'rtl8xxxu_limits' was not declared. Should it be static?
rtl8xxxu_core.c:7682:36: warning: symbol 'rtl8xxxu_combinations' was not declared. Should it be static?

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
index 98700f3ad6f9..3b954c2fe448 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
@@ -7674,12 +7674,12 @@ static void rtl8xxxu_deinit_led(struct rtl8xxxu_priv *priv)
 	led_classdev_unregister(led);
 }
 
-struct ieee80211_iface_limit rtl8xxxu_limits[] = {
+static const struct ieee80211_iface_limit rtl8xxxu_limits[] = {
 	{ .max = 2, .types = BIT(NL80211_IFTYPE_STATION), },
 	{ .max = 1, .types = BIT(NL80211_IFTYPE_AP), },
 };
 
-struct ieee80211_iface_combination rtl8xxxu_combinations[] = {
+static const struct ieee80211_iface_combination rtl8xxxu_combinations[] = {
 	{
 		.limits = rtl8xxxu_limits,
 		.n_limits = ARRAY_SIZE(rtl8xxxu_limits),
-- 
2.25.1


