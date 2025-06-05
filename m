Return-Path: <linux-wireless+bounces-23765-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BB50ACEEA6
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Jun 2025 13:42:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48B343ACC2E
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Jun 2025 11:42:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68D26219A80;
	Thu,  5 Jun 2025 11:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="i2YqrKZ9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 109E8218858
	for <linux-wireless@vger.kernel.org>; Thu,  5 Jun 2025 11:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749123757; cv=none; b=ngYTgSrFEQ1sH7JqUZWEOhbMberCSi6AZQvwv8bcZBvSzAu9OeewUuggmUuuZtLDT8cgZjwwT38NRSblK4OQijW9pbXeuFey86+xahe6wnaetjTN+de0hkZs46mPlOFK3MDRsKBSapRX8GMH/iU/4gqVhFb0NLeJYnbKGPRMGT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749123757; c=relaxed/simple;
	bh=Vja08rwYEnkJTc6auw4AiUYfjFKoN41F8igd2MvMLYg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bYXTcEI/4NDVvgHrsTD1XyCxPE/1bmF0L0WiH/ifuA+a9SGH53dUM2E6nfeVq6oI9qIgVysWNCxmW7S4C8perbTqJV/nLM19uHx6L1F+3aKtvwyPrL3SeiOGxe/8fyM/NT1uE20O7/NC8pdfOhZg5vpt4RGcPmtOHQMUvefVQOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=i2YqrKZ9; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 555BgW5T11471111, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1749123752; bh=RPqQ1b7dlAR6Rzl/v4VBiwjAx8XDYtaclwo9hOFTY/0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=i2YqrKZ9y4/ZsVDBx+Bxt30uEUmnyEJnNVvhwEnfSFwcg+wgqNnUMvMHv4dwlJy1/
	 dQc46AwJ4b4ridliFaZNzMcUZfXy6rOL4WuS7puW3lffWO9uLQDabs0dxljrsjK7UM
	 Em94xcQwztYCc4gcLvOrXEvfByVkRuqA3DaxJiXMK+WIWor1wfv9HMhGWc/+/PdCxx
	 +PZ5ngTBQNMlSCloGcTbdwS1nZohh3Pq8Ffi2/Ad+T30yyElHiXaNkUEW75lIhaRIp
	 /bTPa2btzYOolw5MfXQcIeGsbEFcy9wFFtHFtyYku2jbcYNf6pIjTQwBJFV9p5EguP
	 LyXryRBwQhHEw==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 555BgW5T11471111
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Thu, 5 Jun 2025 19:42:32 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 5 Jun 2025 19:42:33 +0800
Received: from [127.0.1.1] (10.22.226.54) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 5 Jun
 2025 19:42:31 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <echuang@realtek.com>, <damon.chen@realtek.com>, <phhuang@realtek.com>,
        <kevin_yang@realtek.com>
Subject: [PATCH rtw-next 2/5] wifi: rtw89: chan: re-config default chandef only when none is registered
Date: Thu, 5 Jun 2025 19:42:04 +0800
Message-ID: <20250605114207.12381-3-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250605114207.12381-1-pkshih@realtek.com>
References: <20250605114207.12381-1-pkshih@realtek.com>
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

Previously, default chandef is configured if no chanctx is active, i.e. no
chanctx is assigned to some vif. For normal cases, it's fine. However, for
impending CSA support, need to consider that one chanctx may be added, or
called registered, ahead without being assigned immediately. Then, it will
keep inactive, and might be covered by the default one when re-calculating
chanctxs happens in certain sequences. So now, don't re-config the default
chandef unless no chanctx is registered.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/chan.c | 5 ++++-
 drivers/net/wireless/realtek/rtw89/chan.h | 1 +
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/chan.c b/drivers/net/wireless/realtek/rtw89/chan.c
index 5e7f3c3bf1a6..31e15f472740 100644
--- a/drivers/net/wireless/realtek/rtw89/chan.c
+++ b/drivers/net/wireless/realtek/rtw89/chan.c
@@ -269,6 +269,8 @@ static void rtw89_entity_calculate_weight(struct rtw89_dev *rtwdev,
 	struct rtw89_vif *rtwvif;
 	int idx;
 
+	w->registered_chanctxs = bitmap_weight(hal->entity_map, NUM_OF_RTW89_CHANCTX);
+
 	for_each_set_bit(idx, hal->entity_map, NUM_OF_RTW89_CHANCTX) {
 		cfg = hal->chanctx[idx].cfg;
 		if (!cfg) {
@@ -477,7 +479,8 @@ enum rtw89_entity_mode rtw89_entity_recalc(struct rtw89_dev *rtwdev)
 		bitmap_zero(recalc_map, NUM_OF_RTW89_CHANCTX);
 		fallthrough;
 	case 0:
-		rtw89_config_default_chandef(rtwdev);
+		if (!w.registered_chanctxs)
+			rtw89_config_default_chandef(rtwdev);
 		set_bit(RTW89_CHANCTX_0, recalc_map);
 		fallthrough;
 	case 1:
diff --git a/drivers/net/wireless/realtek/rtw89/chan.h b/drivers/net/wireless/realtek/rtw89/chan.h
index 2a25563593af..c75260eca71d 100644
--- a/drivers/net/wireless/realtek/rtw89/chan.h
+++ b/drivers/net/wireless/realtek/rtw89/chan.h
@@ -58,6 +58,7 @@ struct rtw89_chanctx_cb_parm {
 };
 
 struct rtw89_entity_weight {
+	unsigned int registered_chanctxs;
 	unsigned int active_chanctxs;
 	unsigned int active_roles;
 };
-- 
2.25.1


