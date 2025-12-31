Return-Path: <linux-wireless+bounces-30218-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B045CEBA2B
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Dec 2025 10:09:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 82D8A30056E6
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Dec 2025 09:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D01A33112C2;
	Wed, 31 Dec 2025 09:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="hyXvwmv9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 095691F91E3
	for <linux-wireless@vger.kernel.org>; Wed, 31 Dec 2025 09:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767172055; cv=none; b=KzFdanAj/1dxubw5xga4c0Q8mTchvFH8stJjNANAwYWOF8yHbrIB3R0eDBIC4IGiDceaYBd8SmJzgqab5gUCnB3jWF8mS81GvA+NSYimhKkMFbN3EkVfwfBmYKZ1Kg7lMk4aRSK1PZUwK4rcEsB4r7Q+WXymAsq64LsVNTiWylU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767172055; c=relaxed/simple;
	bh=9nsRxJJ/gfJQ7CrWCV7Ux+K5KMwIdKJWvCX2otT8myU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GJZ+/7my8x5fyNvdUdG5nACXVlLdQrXdQw7eCUdV9xFSW1GpN7OQUn8rRZN/G1T+/h70Yb+1oQSGPa+9sZOAE1RJAjACo5qwFPXWcTzXVFNm1Gr5wBN2jveK0ucbQhuELBD/LV5G0I8Q/HOMf12AXTCIjzIaOgTRfggFqeA7YIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=hyXvwmv9; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5BV97VlV4881234, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1767172051; bh=GutKDDLs9QNembHb+nDemwtsTzfqcQf6qnbP4X4lEv8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=hyXvwmv9vNEl7tV5bew4FqJUDtkAMezBn906QcFr9qwdvetdhb5gyFDFQf3WjSJwv
	 lhce59oeugPqE8MH32dQuJQoEGTdO7Oea/xq9IHtUFXwZxE4DMAAgZcj/LEr3ypGui
	 tjr7J+rIqpxu/EAVfuwLKMfEr7qBTMw6pbPUsUxE8WO/A7BuRGXn/CIrXha2ljYM5S
	 Ec3PttyonPTYtYuO1Y1LWKcKQz8nT0/FL+0nEacNiYqOG4Wo8rBqnzmnMvQWl/YJDr
	 F3FWThG28Ltm3zQsd02VeE7izGlwVHfUh4bnWYDFCO3SUvLx4/QMTEKx8nNZHquSzi
	 EDi6EZXiEx4dA==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 5BV97VlV4881234
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Wed, 31 Dec 2025 17:07:31 +0800
Received: from RTKEXHMBS04.realtek.com.tw (10.21.1.54) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Wed, 31 Dec 2025 17:07:31 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS04.realtek.com.tw
 (10.21.1.54) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Wed, 31 Dec 2025 17:07:31 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <gary.chang@realtek.com>, <dian_syuan0116@realtek.com>,
        <damon.chen@realtek.com>, <kevin_yang@realtek.com>
Subject: [PATCH rtw-next 05/11] wifi: rtw89: fw: introduce helper for disabling FW feature configuration
Date: Wed, 31 Dec 2025 17:06:41 +0800
Message-ID: <20251231090647.56407-6-pkshih@realtek.com>
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

Some FW features (groups) may be valid only in a range of FW versions,
i.e. after some FW versions, they can no longer be used. So, introduce
some helper macros to configure this kind of things in FW feature table.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.h |  3 ++
 drivers/net/wireless/realtek/rtw89/fw.c   | 36 ++++++++++++++++++++++-
 2 files changed, 38 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 7b6dfab8e56c..8010ee070108 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -4815,6 +4815,9 @@ struct rtw89_fw_info {
 #define RTW89_SET_FW_FEATURE(_fw_feature, _fw) \
 	set_bit(_fw_feature, (_fw)->feature_map)
 
+#define RTW89_CLR_FW_FEATURE(_fw_feature, _fw) \
+	clear_bit(_fw_feature, (_fw)->feature_map)
+
 struct rtw89_cam_info {
 	DECLARE_BITMAP(addr_cam_map, RTW89_MAX_ADDR_CAM_NUM);
 	DECLARE_BITMAP(bssid_cam_map, RTW89_MAX_BSSID_CAM_NUM);
diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index d13c93fafb34..8804f5da88b1 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -812,6 +812,8 @@ struct __fw_feat_cfg {
 	enum rtw89_fw_feature feature;
 	u32 ver_code;
 	bool (*cond)(u32 suit_ver_code, u32 comp_ver_code);
+	bool disable;
+	int size;
 };
 
 #define __CFG_FW_FEAT(_chip, _cond, _maj, _min, _sub, _idx, _feat) \
@@ -822,6 +824,30 @@ struct __fw_feat_cfg {
 		.cond = __fw_feat_cond_ ## _cond, \
 	}
 
+#define __S_DIS_FW_FEAT(_chip, _cond, _maj, _min, _sub, _idx, _feat) \
+	{ \
+		.chip_id = _chip, \
+		.feature = RTW89_FW_FEATURE_ ## _feat, \
+		.ver_code = RTW89_FW_VER_CODE(_maj, _min, _sub, _idx), \
+		.cond = __fw_feat_cond_ ## _cond, \
+		.disable = true, \
+		.size = 1, \
+	}
+
+#define __G_DIS_FW_FEAT(_chip, _cond, _maj, _min, _sub, _idx, _grp) \
+	{ \
+		.chip_id = _chip, \
+		.feature = RTW89_FW_FEATURE_ ## _grp ## _MIN, \
+		.ver_code = RTW89_FW_VER_CODE(_maj, _min, _sub, _idx), \
+		.cond = __fw_feat_cond_ ## _cond, \
+		.disable = true, \
+		.size = RTW89_FW_FEATURE_ ## _grp ## _MAX - \
+			RTW89_FW_FEATURE_ ## _grp ## _MIN + 1, \
+	}
+
+#define __DIS_FW_FEAT(_chip, _cond, _maj, _min, _sub, _idx, _feat, _type) \
+	__##_type##_DIS_FW_FEAT(_chip, _cond, _maj, _min, _sub, _idx, _feat)
+
 static const struct __fw_feat_cfg fw_feat_tbl[] = {
 	__CFG_FW_FEAT(RTL8851B, ge, 0, 29, 37, 1, TX_WAKE),
 	__CFG_FW_FEAT(RTL8851B, ge, 0, 29, 37, 1, SCAN_OFFLOAD),
@@ -908,8 +934,16 @@ static void rtw89_fw_iterate_feature_cfg(struct rtw89_fw_info *fw,
 		if (chip->chip_id != ent->chip_id)
 			continue;
 
-		if (ent->cond(ver_code, ent->ver_code))
+		if (!ent->cond(ver_code, ent->ver_code))
+			continue;
+
+		if (!ent->disable) {
 			RTW89_SET_FW_FEATURE(ent->feature, fw);
+			continue;
+		}
+
+		for (int n = 0; n < ent->size; n++)
+			RTW89_CLR_FW_FEATURE(ent->feature + n, fw);
 	}
 }
 
-- 
2.25.1


