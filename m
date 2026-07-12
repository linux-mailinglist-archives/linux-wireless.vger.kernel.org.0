Return-Path: <linux-wireless+bounces-38908-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Uh6KKScOU2qEWQMAu9opvQ
	(envelope-from <linux-wireless+bounces-38908-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 12 Jul 2026 05:46:47 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4943A743B7F
	for <lists+linux-wireless@lfdr.de>; Sun, 12 Jul 2026 05:46:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=realtek.com header.s=dkim header.b="S2q/TPjy";
	dmarc=pass (policy=none) header.from=realtek.com;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38908-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38908-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7FE0F3006691
	for <lists+linux-wireless@lfdr.de>; Sun, 12 Jul 2026 03:46:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 521102AD37;
	Sun, 12 Jul 2026 03:46:45 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3E72846A
	for <linux-wireless@vger.kernel.org>; Sun, 12 Jul 2026 03:46:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783828005; cv=none; b=qSlw64Qzih5yHwoAadHbtp8SrdfdR+V1HBqNsViVMYc7VcUaqnuGptXyTM03yy+5m/nNbVmJnwin+gVYQKLuzXFur1SPL/4pISgfUM+eHxv+IuBrMi/O8mXAni6lbqgDkaM6X+jAwartC5mOywd28BiGHFlRZChXat3YASgyrm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783828005; c=relaxed/simple;
	bh=lWdMsGIMMlbToZsMzFKVEAONmUpeAAqQIvt8EhSUxZI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xb+n71FOLkikS4lj1AfCLqyvWs+SMhZg/iSTzyakfzcmhHKM4XTL2Gln3Rn1GCdZGE275TQXzOQD398JL90uUxOMo82Qt8dRks0QKJKw1EXBQ17kbEU2UKlxVOLAEF0tYhrL9WZRuXNUhV+iZoA15MAJtt1d4tiOzDlRqNVPiAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=S2q/TPjy; arc=none smtp.client-ip=211.75.126.72
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 66C3kfodF535699, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1783828001; bh=w9fL0gWzlWlrLJVFp5ww0YMM9Hnkdt99qar+s1CE3Fw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=S2q/TPjyeE4d+zMERhpgKSwEDaSmocAOn7AIXewTWIyz7zLXssodNmkgBWrYUb+lo
	 /bEy6dxhv0E45rpgCdIm3apDGrknLonWQsj1HCXFqUuHV7tcBFh28RD+kZu4hbAwhu
	 Vo8TR9zCeTPRuXoZ8tFjZ1NWX5mASqCcV+ePK6E2R/GZDDg/DS/FHZTY+dbZWNX2QH
	 PxqFurAljl2AFSS9IffpbcaNlMCOzSy1QGdTdtaCjcORBlxlLYpF5rAnJUak6r0uwK
	 U66IcJPwBPphAl3GqPLHwfmdamq7qsUbYeG48FtZD/rsCPcFPg25tiHTHnYs9mUcH+
	 Fd/VFYzPUFwRA==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 66C3kfodF535699
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
	for <linux-wireless@vger.kernel.org>; Sun, 12 Jul 2026 11:46:41 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Sun, 12 Jul 2026 11:46:41 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS06.realtek.com.tw
 (10.21.1.56) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Sun, 12 Jul 2026 11:46:41 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <echuang@realtek.com>, <kevin_yang@realtek.com>
Subject: [PATCH rtw-next 7/8] wifi: rtw89: fw: do bb_preinit before downloading firmware
Date: Sun, 12 Jul 2026 11:45:05 +0800
Message-ID: <20260712034506.53209-8-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260712034506.53209-1-pkshih@realtek.com>
References: <20260712034506.53209-1-pkshih@realtek.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-38908-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linux-wireless@vger.kernel.org,m:echuang@realtek.com,m:kevin_yang@realtek.com,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,realtek.com:from_mime,realtek.com:email,realtek.com:mid,realtek.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4943A743B7F

The firmware access BB registers while initialization, so driver should
do bb_preinit before downloading firmware. Otherwise, it might get BB IO
stuck and throw error.

  rtw89_8922de 0000:04:00.0: loaded firmware rtw89/rtw8922d_fw.bin
  rtw89_8922de 0000:04:00.0: Firmware version 0.35.111.7 (51c56e7b), cmd version 1, type 14
  rtw89_8922de 0000:04:00.0: Firmware version 0.35.111.7 (51c56e7b), cmd version 1, type 15
  rtw89_8922de 0000:04:00.0: fw unexpected status 6
  rtw89_8922de 0000:04:00.0: download firmware fail
  rtw89_8922de 0000:04:00.0: [ERR]fwdl 0x1E0 = 0x8000012
  rtw89_8922de 0000:04:00.0: [ERR]fwdl 0x78F0 = 0x290900
  rtw89_8922de 0000:04:00.0: [ERR]fw PC = 0x201445f2
  rtw89_8922de 0000:04:00.0: [ERR]fw PC = 0x201445f2
  rtw89_8922de 0000:04:00.0: [ERR]fw PC = 0x201445f2
  rtw89_8922de 0000:04:00.0: [ERR]fw PC = 0x201445f2
  rtw89_8922de 0000:04:00.0: [ERR]fw PC = 0x201445f2
  rtw89_8922de 0000:04:00.0: [ERR]fw PC = 0x201445f2
  rtw89_8922de 0000:04:00.0: [ERR]fw PC = 0x201445f2
  rtw89_8922de 0000:04:00.0: [ERR]fw PC = 0x201445f2
  rtw89_8922de 0000:04:00.0: [ERR]fw PC = 0x201445f2
  rtw89_8922de 0000:04:00.0: [ERR]fw PC = 0x201445f2
  rtw89_8922de 0000:04:00.0: [ERR]fw PC = 0x201445f2
  rtw89_8922de 0000:04:00.0: [ERR]fw PC = 0x201445f2
  rtw89_8922de 0000:04:00.0: [ERR]fw PC = 0x201445f2
  rtw89_8922de 0000:04:00.0: [ERR]fw PC = 0x201445f2
  rtw89_8922de 0000:04:00.0: [ERR]fw PC = 0x201445f2
  rtw89_8922de 0000:04:00.0: [ERR]H2C path ready

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.c | 12 +++++++++++-
 drivers/net/wireless/realtek/rtw89/mac.c  |  7 ++++---
 drivers/net/wireless/realtek/rtw89/mac.h  |  3 ++-
 3 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 0343cd1a0ee1..3950792651c1 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -7197,9 +7197,19 @@ int rtw89_core_mlsr_switch(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif,
 static int rtw89_chip_efuse_info_setup(struct rtw89_dev *rtwdev)
 {
 	const struct rtw89_mac_gen_def *mac = rtwdev->chip->mac_def;
+	const struct rtw89_chip_info *chip = rtwdev->chip;
+	bool bb_preinit = false;
 	int ret;
 
-	ret = rtw89_mac_partial_init(rtwdev, false);
+	/*
+	 * Normally in probe stage, we don't need to do BB pre-initialization.
+	 * However, RTL8922D firmware can access BB registers at firmware
+	 * initial state, so initialize it to avoid BB IO stuck in firmware.
+	 */
+	if (chip->chip_id == RTL8922D)
+		bb_preinit = true;
+
+	ret = rtw89_mac_partial_init(rtwdev, false, bb_preinit);
 	if (ret)
 		return ret;
 
diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index a63f34440554..accc5cdfaa3d 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -4308,13 +4308,14 @@ int rtw89_mac_disable_bb_rf(struct rtw89_dev *rtwdev)
 }
 EXPORT_SYMBOL(rtw89_mac_disable_bb_rf);
 
-int rtw89_mac_partial_init(struct rtw89_dev *rtwdev, bool include_bb)
+int rtw89_mac_partial_init(struct rtw89_dev *rtwdev, bool include_bb,
+			   bool bb_preinit)
 {
 	int ret;
 
 	rtw89_mac_ctrl_hci_dma_trx(rtwdev, true);
 
-	if (include_bb) {
+	if (include_bb || bb_preinit) {
 		/* Only call BB preinit including configuration of BB MCU for
 		 * the chips which need to download BB MCU firmware. Otherwise,
 		 * calling preinit later to prevent touching registers affecting
@@ -4367,7 +4368,7 @@ int rtw89_mac_init(struct rtw89_dev *rtwdev)
 	bool include_bb = !!chip->bbmcu_nr;
 	int ret;
 
-	ret = rtw89_mac_partial_init(rtwdev, include_bb);
+	ret = rtw89_mac_partial_init(rtwdev, include_bb, include_bb);
 	if (ret)
 		goto fail;
 
diff --git a/drivers/net/wireless/realtek/rtw89/mac.h b/drivers/net/wireless/realtek/rtw89/mac.h
index c05f5ee0d2fd..493d2b9626a6 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.h
+++ b/drivers/net/wireless/realtek/rtw89/mac.h
@@ -1302,7 +1302,8 @@ rtw89_write32_port_set(struct rtw89_dev *rtwdev, struct rtw89_vif_link *rtwvif_l
 
 int rtw89_mac_pwr_on(struct rtw89_dev *rtwdev);
 void rtw89_mac_pwr_off(struct rtw89_dev *rtwdev);
-int rtw89_mac_partial_init(struct rtw89_dev *rtwdev, bool include_bb);
+int rtw89_mac_partial_init(struct rtw89_dev *rtwdev, bool include_bb,
+			   bool bb_preinit);
 int rtw89_mac_preinit(struct rtw89_dev *rtwdev);
 int rtw89_mac_init(struct rtw89_dev *rtwdev);
 int rtw89_mac_dle_init(struct rtw89_dev *rtwdev, enum rtw89_qta_mode mode,
-- 
2.25.1


