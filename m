Return-Path: <linux-wireless+bounces-38739-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id r1HOAeDETGrGpQEAu9opvQ
	(envelope-from <linux-wireless+bounces-38739-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Jul 2026 11:20:32 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 69F1E719AB0
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Jul 2026 11:20:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=realtek.com header.s=dkim header.b=pDzVVFhu;
	dmarc=pass (policy=none) header.from=realtek.com;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38739-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38739-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 27D4F30AD8D6
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Jul 2026 09:13:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D56F330675;
	Tue,  7 Jul 2026 09:12:54 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E70E39446B
	for <linux-wireless@vger.kernel.org>; Tue,  7 Jul 2026 09:12:52 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783415574; cv=none; b=Fnjex/SH4QfffpSeelR8aGZtW/ezJfHkXcH+gS33izc6XgO0ZzJ4ZCdNbBtgmeYfMb7VH9gAdE1iOr0y7hYiERaY1DYGjVqPNvr02AAcpMAJ726sLX4HCcqF46QEJ1OsRoG/cTlWxEayBumqlX842xCMUAELUVt9YpCI3YHmu5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783415574; c=relaxed/simple;
	bh=qTXCKGJjKoD2Y6KITC6vX+PE1ZfendGZWqfk/dw4tFQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OQz8hAtmizz7y+2L2fs4R/9ib5gzHuurNuTqdPjLOIMpEEr9Szrj/qFmzKTj0OqOLR+8Xg3T38ACKS666bDFpu2JhuKmVxhe19wppA/X1ykosRcPP/N6UixbJf7vAeeaDEer7r3pJzO2ReVWj4FSqvYLEdyOrY0QBxezOrHRbgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=pDzVVFhu; arc=none smtp.client-ip=211.75.126.72
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6679CodnE1359656, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1783415570; bh=H/9EKYJqJxp+ZivJ5vkhzoXmSfwXK8oAwDfxhMWzU7E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=pDzVVFhuRNZiyuEGzf7UZRTkGZ2SpJYdFC4ritVz7M/cvVR21cbgaD5c0OtiXUdz9
	 CdQZWSRnUO4tZAEmc4EfeiMdm4jBSdMl+Ot5c7UmY9w0rAk3rR5WRULNlkyZT7c8b6
	 /OmDNcqQm8A/I/CgMQ+dvqrjh+tQsp2Zt7tuyjU2Wlc5kAaHiU9AYtFrei19t85Y3E
	 oVSkhTHpPQkT3hSus6ec2TaKyjeFk5fM2eyCyeCuJk/rNJgqAPDXKHApuWDTOYqzkt
	 ofxTbk1/jTPmkCggf8v4QCLQ87JGhEdviMQrQa4QB2voDbCgZbMLzlKbe54Nodw6rE
	 eHfoUo73fB8mw==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 6679CodnE1359656
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
	for <linux-wireless@vger.kernel.org>; Tue, 7 Jul 2026 17:12:50 +0800
Received: from RTKEXHMBS03.realtek.com.tw (10.21.1.53) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 7 Jul 2026 17:12:50 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS03.realtek.com.tw
 (10.21.1.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Tue, 7 Jul 2026 17:12:50 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <gary.chang@realtek.com>, <echuang@realtek.com>
Subject: [PATCH rtw-next 11/15] wifi: rtw89: 8922d: update scaling factor for RX path
Date: Tue, 7 Jul 2026 17:10:52 +0800
Message-ID: <20260707091056.42771-12-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260707091056.42771-1-pkshih@realtek.com>
References: <20260707091056.42771-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-38739-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linux-wireless@vger.kernel.org,m:gary.chang@realtek.com,m:echuang@realtek.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	DKIM_TRACE(0.00)[realtek.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[realtek.com:from_mime,realtek.com:email,realtek.com:mid,realtek.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 69F1E719AB0

Update the per-MCS calibration values of RX scaling factors on RX path
(1R or 2R) for BCC and LDPC coding schemes.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/reg.h      |  5 ++++
 drivers/net/wireless/realtek/rtw89/rtw8922d.c | 26 +++++++++++--------
 2 files changed, 20 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index 72f7b80fe1fb..2caefb929199 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -11002,6 +11002,11 @@
 #define R_RX_LDPC02_BE4 0x26834
 #define B_RX_LDPC10_BE4 GENMASK(17, 12)
 #define B_RX_LDPC11_BE4 GENMASK(23, 18)
+#define B_RX_LDPC12_BE4 GENMASK(29, 24)
+#define R_RX_LDPC03_BE4 0x26838
+#define B_RX_LDPC13_BE4 GENMASK(5, 0)
+#define B_RX_LDPC02_BE4 GENMASK(23, 18)
+#define B_RX_LDPC03_BE4 GENMASK(29, 24)
 #define R_RX_LDPC00_BE4 0x2683C
 #define B_RX_LDPC04_BE4 GENMASK(5, 0)
 #define B_RX_LDPC05_BE4 GENMASK(11, 6)
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8922d.c b/drivers/net/wireless/realtek/rtw89/rtw8922d.c
index 8ca07aeb377a..768434db14c6 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8922d.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8922d.c
@@ -2230,38 +2230,42 @@ static int rtw8922d_ctrl_rx_path_tmac(struct rtw89_dev *rtwdev,
 		rtw89_phy_write32_idx(rtwdev, R_RXCH_BCC1_BE4, B_RXCH_MCS6_BE4, 3, phy_idx);
 		rtw89_phy_write32_idx(rtwdev, R_RXCH_BCC1_BE4, B_RXCH_MCS7_BE4, 7, phy_idx);
 		rtw89_phy_write32_idx(rtwdev, R_RXCH_BCC1_BE4, B_RXCH_MCS8_BE4, 2, phy_idx);
-		rtw89_phy_write32_idx(rtwdev, R_RXCH_BCC1_BE4, B_RXCH_MCS9_BE4, 2, phy_idx);
 		rtw89_phy_write32_idx(rtwdev, R_RX_AWGN00_BE4, B_RX_AWGN04_BE4, 4, phy_idx);
 		rtw89_phy_write32_idx(rtwdev, R_RX_AWGN00_BE4, B_RX_AWGN07_BE4, 2, phy_idx);
 		rtw89_phy_write32_idx(rtwdev, R_RX_AWGN01_BE4, B_RX_AWGN09_BE4, 0, phy_idx);
 		rtw89_phy_write32_idx(rtwdev, R_RX_AWGN02_BE4, B_RX_AWGN11_BE4, 1, phy_idx);
-		rtw89_phy_write32_idx(rtwdev, R_RX_LDPC00_BE4, B_RX_LDPC04_BE4, 8, phy_idx);
-		rtw89_phy_write32_idx(rtwdev, R_RX_LDPC00_BE4, B_RX_LDPC05_BE4, 5, phy_idx);
-		rtw89_phy_write32_idx(rtwdev, R_RX_LDPC00_BE4, B_RX_LDPC06_BE4, 3, phy_idx);
-		rtw89_phy_write32_idx(rtwdev, R_RX_LDPC00_BE4, B_RX_LDPC07_BE4, 5, phy_idx);
-		rtw89_phy_write32_idx(rtwdev, R_RX_LDPC00_BE4, B_RX_LDPC08_BE4, 1, phy_idx);
-		rtw89_phy_write32_idx(rtwdev, R_RX_LDPC01_BE4, B_RX_LDPC09_BE4, 2, phy_idx);
-		rtw89_phy_write32_idx(rtwdev, R_RX_LDPC02_BE4, B_RX_LDPC10_BE4, 4, phy_idx);
-		rtw89_phy_write32_idx(rtwdev, R_RX_LDPC02_BE4, B_RX_LDPC11_BE4, 2, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_RX_LDPC03_BE4, B_RX_LDPC02_BE4, 0x6, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_RX_LDPC03_BE4, B_RX_LDPC03_BE4, 0xf, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_RX_LDPC00_BE4, B_RX_LDPC04_BE4, 0x10, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_RX_LDPC00_BE4, B_RX_LDPC05_BE4, 0xa, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_RX_LDPC00_BE4, B_RX_LDPC06_BE4, 0x8, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_RX_LDPC00_BE4, B_RX_LDPC07_BE4, 0x14, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_RX_LDPC01_BE4, B_RX_LDPC09_BE4, 0x14, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_RX_LDPC02_BE4, B_RX_LDPC10_BE4, 0xc, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_RX_LDPC02_BE4, B_RX_LDPC11_BE4, 0xb, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_RX_LDPC02_BE4, B_RX_LDPC12_BE4, 0x14, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_RX_LDPC03_BE4, B_RX_LDPC13_BE4, 0x2d, phy_idx);
 	} else {
 		rtw89_phy_write32_idx(rtwdev, R_RXCH_BCC0_BE4, B_RXCH_MCS4_BE4, 13, phy_idx);
 		rtw89_phy_write32_idx(rtwdev, R_RXCH_BCC1_BE4, B_RXCH_MCS5_BE4, 15, phy_idx);
 		rtw89_phy_write32_idx(rtwdev, R_RXCH_BCC1_BE4, B_RXCH_MCS6_BE4, 6, phy_idx);
 		rtw89_phy_write32_idx(rtwdev, R_RXCH_BCC1_BE4, B_RXCH_MCS7_BE4, 15, phy_idx);
 		rtw89_phy_write32_idx(rtwdev, R_RXCH_BCC1_BE4, B_RXCH_MCS8_BE4, 4, phy_idx);
-		rtw89_phy_write32_idx(rtwdev, R_RXCH_BCC1_BE4, B_RXCH_MCS9_BE4, 15, phy_idx);
 		rtw89_phy_write32_idx(rtwdev, R_RX_AWGN00_BE4, B_RX_AWGN04_BE4, 9, phy_idx);
 		rtw89_phy_write32_idx(rtwdev, R_RX_AWGN00_BE4, B_RX_AWGN07_BE4, 3, phy_idx);
 		rtw89_phy_write32_idx(rtwdev, R_RX_AWGN01_BE4, B_RX_AWGN09_BE4, 1, phy_idx);
 		rtw89_phy_write32_idx(rtwdev, R_RX_AWGN02_BE4, B_RX_AWGN11_BE4, 0, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_RX_LDPC03_BE4, B_RX_LDPC02_BE4, 0x3, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_RX_LDPC03_BE4, B_RX_LDPC03_BE4, 0x9, phy_idx);
 		rtw89_phy_write32_idx(rtwdev, R_RX_LDPC00_BE4, B_RX_LDPC04_BE4, 9, phy_idx);
 		rtw89_phy_write32_idx(rtwdev, R_RX_LDPC00_BE4, B_RX_LDPC05_BE4, 8, phy_idx);
 		rtw89_phy_write32_idx(rtwdev, R_RX_LDPC00_BE4, B_RX_LDPC06_BE4, 6, phy_idx);
 		rtw89_phy_write32_idx(rtwdev, R_RX_LDPC00_BE4, B_RX_LDPC07_BE4, 16, phy_idx);
-		rtw89_phy_write32_idx(rtwdev, R_RX_LDPC00_BE4, B_RX_LDPC08_BE4, 4, phy_idx);
 		rtw89_phy_write32_idx(rtwdev, R_RX_LDPC01_BE4, B_RX_LDPC09_BE4, 9, phy_idx);
 		rtw89_phy_write32_idx(rtwdev, R_RX_LDPC02_BE4, B_RX_LDPC10_BE4, 9, phy_idx);
 		rtw89_phy_write32_idx(rtwdev, R_RX_LDPC02_BE4, B_RX_LDPC11_BE4, 7, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_RX_LDPC02_BE4, B_RX_LDPC12_BE4, 0x17, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_RX_LDPC03_BE4, B_RX_LDPC13_BE4, 0x1a, phy_idx);
 	}
 
 	return 0;
-- 
2.25.1


