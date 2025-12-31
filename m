Return-Path: <linux-wireless+bounces-30219-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D0F93CEBA13
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Dec 2025 10:07:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 569C7300A961
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Dec 2025 09:07:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38569313545;
	Wed, 31 Dec 2025 09:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="eC8djfSC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A82A31197A
	for <linux-wireless@vger.kernel.org>; Wed, 31 Dec 2025 09:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767172061; cv=none; b=fJB4gAlOmaDXpW8qxYIXLJUmRrukGiFcs7kGMSwLAu7jkWZ/Cf8Y+g7AVWkO3bzkQucHszMApuY5598zK6WfGLpO3YyYn7iRBH6Ixg3ppCF9Tt/fl8aHu272NtHcm/DggWjn8RuY7U9eJlZh+UKti563W3X7GB2gH/RowNjSBKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767172061; c=relaxed/simple;
	bh=0zlPz4txT3l5p9GHPNRvAqcNzL15ijbodBzV1jUqFyQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q6UOKxcS7usrwzrYZUe7aLhQsgizrStiN4ijySPqaPGUgvzNPN08u50eeXIujsfrkN9wWyDGHFiMW06xol01Xr9e8O/auleAFSkj/rQ2KK2DI5jGVDj0OBAeMn905XgDcG3LhfCj/TurH3Pti44hluqgmCGMv9/JEDCAc1U11SU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=eC8djfSC; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5BV97b6mA881246, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1767172057; bh=9+Yuqype8kSKslnZhDTJD0EkNCGOjmGRTDKXF8V7H84=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=eC8djfSCoU8KsoeoOuLvkO3rbxSg0RJejdYpYXUocdyU6ZVYuuCUs+Ho+rujgL2Rv
	 2ORKyx/o3r5ZcYw0RH2vPzFxVGkJ1sBjOfMnO0JTyQknreuZkB5gSwxY53GRnU1DlJ
	 DsaZr/fnD2d+hg1hIqSPsyIAG4LOEiriMQh8SNUOaUIf/r6bFzOM2zU4bshM+j6Lwi
	 Hsu32JeBZND3k0Ld0NRkhBb9OzFXyqN5FzqO/wFOZG5go88BqmOJDQaVkm0Ku82ENp
	 e3dyLW2zJ8KSJ/B5oK2IZSuD0Mg6iDuvI45uktMaONpO7Bj6OdKsxOFmXz0mrVsSrV
	 jqG3Ui7mCjBIA==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 5BV97b6mA881246
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Wed, 31 Dec 2025 17:07:37 +0800
Received: from RTKEXHMBS04.realtek.com.tw (10.21.1.54) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Wed, 31 Dec 2025 17:07:37 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS04.realtek.com.tw
 (10.21.1.54) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Wed, 31 Dec 2025 17:07:37 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <gary.chang@realtek.com>, <dian_syuan0116@realtek.com>,
        <damon.chen@realtek.com>, <kevin_yang@realtek.com>
Subject: [PATCH rtw-next 06/11] wifi: rtw89: 8922a: tweak RFK_PRE_NOTIFY FW feature configuration to align handling
Date: Wed, 31 Dec 2025 17:06:42 +0800
Message-ID: <20251231090647.56407-7-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251231090647.56407-1-pkshih@realtek.com>
References: <20251231090647.56407-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Zong-Zhe Yang <kevin_yang@realtek.com>

In the FW feature table, V0 and V1 was configured by lt, less than. So, V1
flag was also set in the range of V0. However, in RFK_PRE_NOTIFY handling,
rtw89_fw_h2c_rf_pre_ntfy, V1 is tested before V0. Things would process as
V1 even if V0 should be used.

Tweak FW feature configuration by ge, greater or equal, to align handling.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/fw.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 8804f5da88b1..067f6f0ea101 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -897,6 +897,7 @@ static const struct __fw_feat_cfg fw_feat_tbl[] = {
 	__CFG_FW_FEAT(RTL8852C, ge, 0, 27, 129, 1, BEACON_TRACKING),
 	__CFG_FW_FEAT(RTL8852C, ge, 0, 29, 94, 0, SER_L1_BY_EVENT),
 	__CFG_FW_FEAT(RTL8852C, ge, 0, 29, 130, 0, SIM_SER_L0L1_BY_HALT_H2C),
+	__CFG_FW_FEAT(RTL8922A, ge, 0, 0, 0, 0, RFK_PRE_NOTIFY_V0),
 	__CFG_FW_FEAT(RTL8922A, ge, 0, 34, 30, 0, CRASH_TRIGGER_TYPE_0),
 	__CFG_FW_FEAT(RTL8922A, ge, 0, 34, 11, 0, MACID_PAUSE_SLEEP),
 	__CFG_FW_FEAT(RTL8922A, ge, 0, 34, 35, 0, SCAN_OFFLOAD),
@@ -905,12 +906,11 @@ static const struct __fw_feat_cfg fw_feat_tbl[] = {
 	__CFG_FW_FEAT(RTL8922A, ge, 0, 35, 12, 0, BEACON_FILTER),
 	__CFG_FW_FEAT(RTL8922A, ge, 0, 35, 22, 0, WOW_REASON_V1),
 	__CFG_FW_FEAT(RTL8922A, lt, 0, 35, 28, 0, RFK_IQK_V0),
-	__CFG_FW_FEAT(RTL8922A, lt, 0, 35, 31, 0, RFK_PRE_NOTIFY_V0),
+	__CFG_FW_FEAT(RTL8922A, ge, 0, 35, 31, 0, RFK_PRE_NOTIFY_V1),
 	__CFG_FW_FEAT(RTL8922A, lt, 0, 35, 31, 0, LPS_CH_INFO),
 	__CFG_FW_FEAT(RTL8922A, lt, 0, 35, 42, 0, RFK_RXDCK_V0),
 	__CFG_FW_FEAT(RTL8922A, ge, 0, 35, 46, 0, NOTIFY_AP_INFO),
 	__CFG_FW_FEAT(RTL8922A, lt, 0, 35, 47, 0, CH_INFO_BE_V0),
-	__CFG_FW_FEAT(RTL8922A, lt, 0, 35, 49, 0, RFK_PRE_NOTIFY_V1),
 	__CFG_FW_FEAT(RTL8922A, ge, 0, 35, 49, 0, RFK_PRE_NOTIFY_V2),
 	__CFG_FW_FEAT(RTL8922A, lt, 0, 35, 51, 0, NO_PHYCAP_P1),
 	__CFG_FW_FEAT(RTL8922A, lt, 0, 35, 64, 0, NO_POWER_DIFFERENCE),
-- 
2.25.1


