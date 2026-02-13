Return-Path: <linux-wireless+bounces-31806-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GEbtDhbCjmkMEgEAu9opvQ
	(envelope-from <linux-wireless+bounces-31806-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Feb 2026 07:17:58 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E35921333A5
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Feb 2026 07:17:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D4618302F430
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Feb 2026 06:17:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09D151DE8BF;
	Fri, 13 Feb 2026 06:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="QA5HvSUJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 968341DA62E
	for <linux-wireless@vger.kernel.org>; Fri, 13 Feb 2026 06:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770963474; cv=none; b=RaQTC/QYffIR0geFbil+HiDOmhYdfPj7tiIW3D00Rgi2Hgv5egoALKEOqFKQDHwNdd1sOooh9PEEE7HSxinaY/Bx+9pAjOHz41i8FRyuSTZeLcQzStOrkzLaNd1Fxaw4JKs+VHIlLwo/U1RqNFmzzyIPhLB0Ttpjuwy6UwKA0dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770963474; c=relaxed/simple;
	bh=3QIcvK4tB/Jf/LGy2MBfkBfeWp6g8cETUd5JKftu9YE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ubJM41aK69ugdAxH0hjoHt5yCHNWhHI0eZSZn25b+wkRwGpP89yUp+ncllS3ChI4+lspBHwMD8O1003Ooio235aE7tHczdVJuFbGIGHJoDsyob5me+HA9xFObwjFXxQ+ZO87j1QjGsCHI9cbBfxZBgPOcv3qiZOwWVwK7DXXaCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=QA5HvSUJ; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 61D6HpEJ21419696, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1770963471; bh=1yqOa7fYHfj3RgwIXfw/d0HCqewJ9RKu3rf9J967Twg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=QA5HvSUJo+nCvOkSnQL6o4EovU8ZwmXEdZWwWJCFl0ODhM5/rVi/f2Mxmfsb+oWAY
	 7oi3iV5mCOnFJJIGgQZ9b2UfBsPdqVZmxv4vdWigxZVr+Ww0LXFcWPiL1iSqP1qOCh
	 RZgrxEYQW5YgnYLJtY39xSDVZ3sDAJf1JLwEzB7SPKPwH5yxFYMr5MuWznzRfwCu4H
	 4wm/TPz05eNQNH2gYxr4ZxLigNiL7vV7JMHACzHmTTKeSjJLUmFNh5ThOijmCwAWKm
	 dIXaQZKj7mg8RIvR5jexjCDxVCMN5pG/aJwgjlThLoBpC5YnIQvBXnmrk1J7sRKfxr
	 Nrc69rAe8WQXQ==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 61D6HpEJ21419696
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Fri, 13 Feb 2026 14:17:51 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Fri, 13 Feb 2026 14:17:51 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS05.realtek.com.tw (10.21.1.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Fri, 13 Feb 2026 14:17:51 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS05.realtek.com.tw
 (10.21.1.55) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Fri, 13 Feb 2026 14:17:51 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <damon.chen@realtek.com>, <kevin_yang@realtek.com>
Subject: [PATCH rtw-next 12/12] wifi: rtw89: ser: post-recover DMAC state to prevent LPS
Date: Fri, 13 Feb 2026 14:15:52 +0800
Message-ID: <20260213061552.29997-13-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260213061552.29997-1-pkshih@realtek.com>
References: <20260213061552.29997-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-31806-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[realtek.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,realtek.com:mid,realtek.com:dkim,realtek.com:email];
	RCPT_COUNT_THREE(0.00)[3];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: E35921333A5
X-Rspamd-Action: no action

From: Zong-Zhe Yang <kevin_yang@realtek.com>

If entering LPS during SER (system error recovery), IMR might fail to
be re-enabled after SER. Then, the next SER would not be noticed well.
After FW v0.35.100.0, Wi-Fi 7 chipsets adjust the order in which SER
recovers DMAC state to prevent LPS from being in the middle of SER.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.h | 1 +
 drivers/net/wireless/realtek/rtw89/fw.c   | 1 +
 drivers/net/wireless/realtek/rtw89/mac.c  | 7 ++++++-
 3 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 5d1cec20bc80..cf0cc718f41c 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -4796,6 +4796,7 @@ enum rtw89_fw_feature {
 	RTW89_FW_FEATURE_SER_L1_BY_EVENT,
 	RTW89_FW_FEATURE_SIM_SER_L0L1_BY_HALT_H2C,
 	RTW89_FW_FEATURE_LPS_ML_INFO_V1,
+	RTW89_FW_FEATURE_SER_POST_RECOVER_DMAC,
 
 	NUM_OF_RTW89_FW_FEATURES,
 };
diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 67154e666ba2..c035e89e75dd 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -923,6 +923,7 @@ static const struct __fw_feat_cfg fw_feat_tbl[] = {
 	__CFG_FW_FEAT(RTL8922A, ge, 0, 35, 84, 0, RFK_PRE_NOTIFY_MCC_V1),
 	__CFG_FW_FEAT(RTL8922A, lt, 0, 35, 84, 0, ADDR_CAM_V0),
 	__CFG_FW_FEAT(RTL8922A, ge, 0, 35, 97, 0, SIM_SER_L0L1_BY_HALT_H2C),
+	__CFG_FW_FEAT(RTL8922A, ge, 0, 35, 100, 0, SER_POST_RECOVER_DMAC),
 };
 
 static void rtw89_fw_iterate_feature_cfg(struct rtw89_fw_info *fw,
diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index 243cc02ad24e..923f39e39a26 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -826,7 +826,9 @@ u32 rtw89_mac_get_err_status(struct rtw89_dev *rtwdev)
 	}
 
 	err = rtw89_read32(rtwdev, R_AX_HALT_C2H);
-	rtw89_write32(rtwdev, R_AX_HALT_C2H_CTRL, 0);
+
+	if (!RTW89_CHK_FW_FEATURE(SER_POST_RECOVER_DMAC, &rtwdev->fw))
+		rtw89_write32(rtwdev, R_AX_HALT_C2H_CTRL, 0);
 
 	err_scnr = RTW89_ERROR_SCENARIO(err);
 	if (err_scnr == RTW89_WCPU_CPU_EXCEPTION)
@@ -846,6 +848,9 @@ u32 rtw89_mac_get_err_status(struct rtw89_dev *rtwdev)
 	if (chip->chip_gen != RTW89_CHIP_AX)
 		rtw89_write32(rtwdev, R_AX_HALT_C2H, 0);
 
+	if (RTW89_CHK_FW_FEATURE(SER_POST_RECOVER_DMAC, &rtwdev->fw))
+		rtw89_write32(rtwdev, R_AX_HALT_C2H_CTRL, 0);
+
 	return err;
 }
 EXPORT_SYMBOL(rtw89_mac_get_err_status);
-- 
2.25.1


