Return-Path: <linux-wireless+bounces-13490-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 525F798FD8F
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Oct 2024 08:55:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E1A41C20C42
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Oct 2024 06:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B3E11311B5;
	Fri,  4 Oct 2024 06:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="L2z0uwP3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F34885260
	for <linux-wireless@vger.kernel.org>; Fri,  4 Oct 2024 06:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728024899; cv=none; b=XE9SJWtLX3d6wk9yfNKXotcyoc4q0Nzg8dbPk37hpe4xmtXBFo091FC1yQKTtGJaBcayn618eYK/D7WK9/I9Y68ZVpNgD9TAkF3w1xqMYQOy66SI5tbH9i337MatjTQxivhkhDhwNuh1T5QNp+50oL0eGW5Xdhnrzvt9e155rLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728024899; c=relaxed/simple;
	bh=HYPBKX5tq7SY7voM9tvWNBKzYP9DqXRFrHNFmIDa7iA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UY5N+93FoIy56CEhxcEI2+mlUdDxP+TnYGHMC50sB+c3KIE4eQzkkGwSE0LPxgdfwnGvKo1NbyLZyWnWotxgUWdl2sKh4eqopqlwJdHz3h4ygPZjaAMHIOoLtfD9V/8lTQZT60JC4RPA0h1HuiGYXTtCNgpxpdqAqfZuefQ7ino=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=L2z0uwP3; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4946sqEtB1096020, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1728024892; bh=HYPBKX5tq7SY7voM9tvWNBKzYP9DqXRFrHNFmIDa7iA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=L2z0uwP3Afcp4kUrQZBkrMIlSUhBBuS1kpwTsZrdpXqCJNPi7UnsQZVWy+4JIzXMT
	 rVscGmcR0LRYOJErB/QCRuO4utYlb0l2DFYZpYakod9X62CTFrXzqqYTVDGVr+Jfie
	 Ep4GtBNrj55vdTeKddAeylKWcTNMiBm+TdhWh4ufMPTqcJv3h0BsfvuITujpLxWFVQ
	 p+wrMheznydqnRSt7zTry0158Ut4XtPMp36Vvym14afh1Q5bLNgtr5FHIXXBjfqUbh
	 ToMv+veNO/wlV6OIkdSb8p7tQiEDn3F4pV0T/XWmW961CnHyg37S2N59RatM2AUyVT
	 tI/+/UmgxabGw==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.05/5.92) with ESMTPS id 4946sqEtB1096020
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Fri, 4 Oct 2024 14:54:52 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 4 Oct 2024 14:54:53 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 4 Oct
 2024 14:54:52 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <timlee@realtek.com>
Subject: [PATCH] wifi: rtw89: wow: do not configure CPU IO to receive packets for old firmware
Date: Fri, 4 Oct 2024 14:54:08 +0800
Message-ID: <20241004065408.10261-1-pkshih@realtek.com>
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

From: Chin-Yen Lee <timlee@realtek.com>

The older firmware of 8852A and 8852B can't receive packets via
CPU IO function and will lead to WoWLAN fail if calling it.
So use firmware feature to distinguish.

Signed-off-by: Chin-Yen Lee <timlee@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.h | 1 +
 drivers/net/wireless/realtek/rtw89/fw.c   | 2 ++
 drivers/net/wireless/realtek/rtw89/mac.c  | 6 ++++++
 3 files changed, 9 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 598eee12339e..504a45f93e99 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -4442,6 +4442,7 @@ enum rtw89_fw_feature {
 	RTW89_FW_FEATURE_WOW_REASON_V1,
 	RTW89_FW_FEATURE_RFK_PRE_NOTIFY_V0,
 	RTW89_FW_FEATURE_RFK_RXDCK_V0,
+	RTW89_FW_FEATURE_NO_WOW_CPU_IO_RX,
 };
 
 struct rtw89_fw_suit {
diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 752a3c2536d4..2c2fdf21f065 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -665,11 +665,13 @@ static const struct __fw_feat_cfg fw_feat_tbl[] = {
 	__CFG_FW_FEAT(RTL8852A, ge, 0, 13, 35, 0, SCAN_OFFLOAD),
 	__CFG_FW_FEAT(RTL8852A, ge, 0, 13, 35, 0, TX_WAKE),
 	__CFG_FW_FEAT(RTL8852A, ge, 0, 13, 36, 0, CRASH_TRIGGER),
+	__CFG_FW_FEAT(RTL8852A, lt, 0, 13, 37, 0, NO_WOW_CPU_IO_RX),
 	__CFG_FW_FEAT(RTL8852A, lt, 0, 13, 38, 0, NO_PACKET_DROP),
 	__CFG_FW_FEAT(RTL8852B, ge, 0, 29, 26, 0, NO_LPS_PG),
 	__CFG_FW_FEAT(RTL8852B, ge, 0, 29, 26, 0, TX_WAKE),
 	__CFG_FW_FEAT(RTL8852B, ge, 0, 29, 29, 0, CRASH_TRIGGER),
 	__CFG_FW_FEAT(RTL8852B, ge, 0, 29, 29, 0, SCAN_OFFLOAD),
+	__CFG_FW_FEAT(RTL8852B, lt, 0, 29, 30, 0, NO_WOW_CPU_IO_RX),
 	__CFG_FW_FEAT(RTL8852BT, ge, 0, 29, 74, 0, NO_LPS_PG),
 	__CFG_FW_FEAT(RTL8852BT, ge, 0, 29, 74, 0, TX_WAKE),
 	__CFG_FW_FEAT(RTL8852BT, ge, 0, 29, 90, 0, CRASH_TRIGGER),
diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index b3f417003087..e09f926bb4a0 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -6521,6 +6521,9 @@ int rtw89_mac_cpu_io_rx(struct rtw89_dev *rtwdev, bool wow_enable)
 	struct rtw89_mac_c2h_info c2h_info = {};
 	u32 ret;
 
+	if (RTW89_CHK_FW_FEATURE(NO_WOW_CPU_IO_RX, &rtwdev->fw))
+		return 0;
+
 	h2c_info.id = RTW89_FWCMD_H2CREG_FUNC_WOW_CPUIO_RX_CTRL;
 	h2c_info.content_len = sizeof(h2c_info.u.hdr);
 	h2c_info.u.hdr.w0 = u32_encode_bits(wow_enable, RTW89_H2CREG_WOW_CPUIO_RX_CTRL_EN);
@@ -6557,6 +6560,9 @@ static int rtw89_wow_config_mac_ax(struct rtw89_dev *rtwdev, bool enable_wow)
 		rtw89_write32(rtwdev, R_AX_TF_FWD, 0);
 		rtw89_write32(rtwdev, R_AX_HW_RPT_FWD, 0);
 
+		if (RTW89_CHK_FW_FEATURE(NO_WOW_CPU_IO_RX, &rtwdev->fw))
+			return 0;
+
 		if (chip->chip_id == RTL8852A || rtw89_is_rtl885xb(rtwdev))
 			rtw89_write8(rtwdev, R_BE_DBG_WOW_READY, WOWLAN_NOT_READY);
 		else
-- 
2.25.1


