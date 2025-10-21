Return-Path: <linux-wireless+bounces-28148-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B481DBF6D0C
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Oct 2025 15:37:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 43976504A9A
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Oct 2025 13:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD5E833892A;
	Tue, 21 Oct 2025 13:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="oON7/tZR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E03C3370FB
	for <linux-wireless@vger.kernel.org>; Tue, 21 Oct 2025 13:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761053670; cv=none; b=A7imiJP7/BbuV/8bA3m3+4ApFTI/FkjCV11DwfCPULoTFzDeFQx66wpPMzlfGJAJ6lYpit7locsWDsNNDNmqy4GDzg20nkuUbjWzoE/7MsioVK4FhbF14bSWNgD9pbefeMLof7zH+W3/Xcv2NlQkCkJaTQHAEyaBhxDi8KFr5gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761053670; c=relaxed/simple;
	bh=JZpR4q8gg6S14ey6cbBdpW4jqT+IP6pC6fW4zxosOyU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j0RsXOpj5tVNX47lZnD7S1iGmM1ryiKPp/wnWyZM4CekE7qJvpLJUSICJhDj9+ordLgT4UW4hX5FT4rrmRmYG6cFrVJMzyPr16p0s0CDU8CP9zD75jN0LGj2LXR3Bnplv30cD486JzzTL2xoiEzJrvd6k2cJPXQWEgUAOGd7QoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=oON7/tZR; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 59LDYLuhC3088101, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1761053661; bh=y4tjTwwTqvNCyy7xSSfLbopzcHbFUnI4y3dmD/vkVBU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=oON7/tZR3YreVh3w0743goQqFoBgoyGuN7mnyoKHnFo8KvEn+7dgiwKHFXBrHVJE6
	 4Rp29YbKY3iiRIpfYKitc5wvBQZsR2Patde00JCrkn9zZ2bh4LqkeTfpeViOCE6OBl
	 cOBhKd0ClGb8kf+KDLCPLRYCSaPZ8gA6QvRI/taTe8KVVGwjn0HscI+qlHMlAVL3o3
	 KOGSjQeYBlr+aYKWQQx09OaTxRNIPsTZL2jamJCUl1bx4makEsg69mDtafNGvaoldG
	 3JCj618DDeQ0OR2sankjeyjwuG75PNb+1EfTwmUMuc2O1H+aZWtaDeT7qmp9C6VpjD
	 Hk6I1y+qZ9+xA==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 59LDYLuhC3088101
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Tue, 21 Oct 2025 21:34:21 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Tue, 21 Oct 2025 21:34:21 +0800
Received: from RTKEXHMBS04.realtek.com.tw (10.21.1.54) by
 RTKEXHMBS06.realtek.com.tw (10.21.1.56) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Tue, 21 Oct 2025 21:34:21 +0800
Received: from [127.0.1.1] (10.22.225.127) by RTKEXHMBS04.realtek.com.tw
 (10.21.1.54) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.27 via Frontend
 Transport; Tue, 21 Oct 2025 21:34:21 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <timlee@realtek.com>, <emma_tsai@realtek.com>, <damon.chen@realtek.com>,
        <kevin_yang@realtek.com>
Subject: [rtw-next 5/8] wifi: rtw89: regd: apply ACPI policy even if country code is programmed
Date: Tue, 21 Oct 2025 21:33:59 +0800
Message-ID: <20251021133402.15467-6-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251021133402.15467-1-pkshih@realtek.com>
References: <20251021133402.15467-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Zong-Zhe Yang <kevin_yang@realtek.com>

There are regulatory related policy according to BIOS/ACPI configuration,
e.g. distro decides to disable some bands or some channels. Even if chip
has a programmed country code, these policy should still be applied within
regulatory notifier.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.h |  2 ++
 drivers/net/wireless/realtek/rtw89/regd.c | 22 +++++++++++-----------
 2 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 7c74ed3cfaf7..ae98d6866b30 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -5449,6 +5449,8 @@ struct rtw89_regd_ctrl {
 struct rtw89_regulatory_info {
 	struct rtw89_regd_ctrl ctrl;
 	const struct rtw89_regd *regd;
+	bool programmed;
+
 	enum rtw89_reg_6ghz_power reg_6ghz_power;
 	struct rtw89_reg_6ghz_tpe reg_6ghz_tpe;
 	bool txpwr_uk_follow_etsi;
diff --git a/drivers/net/wireless/realtek/rtw89/regd.c b/drivers/net/wireless/realtek/rtw89/regd.c
index 58582f8d2b74..209d84909f88 100644
--- a/drivers/net/wireless/realtek/rtw89/regd.c
+++ b/drivers/net/wireless/realtek/rtw89/regd.c
@@ -723,6 +723,8 @@ int rtw89_regd_init_hint(struct rtw89_dev *rtwdev)
 	chip_regd = rtw89_regd_find_reg_by_name(rtwdev, rtwdev->efuse.country_code);
 	if (!rtw89_regd_is_ww(chip_regd)) {
 		rtwdev->regulatory.regd = chip_regd;
+		rtwdev->regulatory.programmed = true;
+
 		/* Ignore country ie if there is a country domain programmed in chip */
 		wiphy->regulatory_flags |= REGULATORY_COUNTRY_IE_IGNORE;
 		wiphy->regulatory_flags |= REGULATORY_STRICT_REG;
@@ -867,11 +869,6 @@ static void rtw89_regd_notifier_apply(struct rtw89_dev *rtwdev,
 		wiphy->regulatory_flags |= REGULATORY_COUNTRY_IE_IGNORE;
 	else
 		wiphy->regulatory_flags &= ~REGULATORY_COUNTRY_IE_IGNORE;
-
-	rtw89_regd_apply_policy_unii4(rtwdev, wiphy);
-	rtw89_regd_apply_policy_6ghz(rtwdev, wiphy);
-	rtw89_regd_apply_policy_tas(rtwdev);
-	rtw89_regd_apply_policy_ant_gain(rtwdev);
 }
 
 static
@@ -883,19 +880,22 @@ void rtw89_regd_notifier(struct wiphy *wiphy, struct regulatory_request *request
 	wiphy_lock(wiphy);
 	rtw89_leave_ps_mode(rtwdev);
 
-	if (wiphy->regd) {
-		rtw89_debug(rtwdev, RTW89_DBG_REGD,
-			    "There is a country domain programmed in chip, ignore notifications\n");
-		goto exit;
-	}
+	if (rtwdev->regulatory.programmed)
+		goto policy;
+
 	rtw89_regd_notifier_apply(rtwdev, wiphy, request);
 	rtw89_debug_regd(rtwdev, rtwdev->regulatory.regd,
 			 "get from initiator %d, alpha2",
 			 request->initiator);
 
+policy:
+	rtw89_regd_apply_policy_unii4(rtwdev, wiphy);
+	rtw89_regd_apply_policy_6ghz(rtwdev, wiphy);
+	rtw89_regd_apply_policy_tas(rtwdev);
+	rtw89_regd_apply_policy_ant_gain(rtwdev);
+
 	rtw89_core_set_chip_txpwr(rtwdev);
 
-exit:
 	wiphy_unlock(wiphy);
 }
 
-- 
2.25.1


