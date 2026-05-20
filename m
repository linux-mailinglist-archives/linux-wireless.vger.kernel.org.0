Return-Path: <linux-wireless+bounces-36706-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mE2GOYqsDWqP1QUAu9opvQ
	(envelope-from <linux-wireless+bounces-36706-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 20 May 2026 14:43:54 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D55FB58E088
	for <lists+linux-wireless@lfdr.de>; Wed, 20 May 2026 14:43:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 290CF304782A
	for <lists+linux-wireless@lfdr.de>; Wed, 20 May 2026 12:40:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 252693A2E3F;
	Wed, 20 May 2026 12:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="KabxXC3t"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 832423DFC60
	for <linux-wireless@vger.kernel.org>; Wed, 20 May 2026 12:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779280718; cv=none; b=Pe25279k5KFqcxoVN8GSfH2FrqJl+xtsmiks46C8+igy9gaJf5LGSPZ0/17mmKdln/bp5uhBYBWPivb9a51Am8CBafqR3xHKluxlfnDqnfH9Xmdekx12j3SuYnkRxlXnL4Xfy6ueOcj5R70lC2wtOEcJRTsaPM2PV23tPsWhGwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779280718; c=relaxed/simple;
	bh=lmXbOyC+v4tjS/XdG8kNZS5KRYXbe1ijw9XYp5c5Tk8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Rfyfjp61QNuhhPFqIH/kJ1B13PXWkdWoMLVBqgJXFGNozI3OR65lzEHtA1IptGyKRVmkGt+HqhfGwuvMyReUF3Ep/zy+D0WDpWV2q431Y/AZx4cgL5ruZBGcSGViD3qcOOa1hN7AmgKelhYTzw+PzLQHOCPJPAMtSeFUhSRh/e4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=KabxXC3t; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 64KCcX9U1095469, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1779280714; bh=zPpKdCw3OIzbwbmkx81C/yk2X1YwX8WoraxPCq+a4po=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=KabxXC3tAXZv02KbcK0qpJBQG6Er7onHrQjUeBNQb2cdS8/gSBH5yIsRo3IcgVKK3
	 NSs2mSYdKQwJHgeTCxf5rCsLNWgK0xWGE3r+kxhRCLfFCCi5xJqjfaAiVZFmHcQHg3
	 ZwhgTbkD4vX//BxkQwSHyBcLxk7b9Dyc+Re3xeMLaWZxoRiCE9QcAbsTjRC6r6BXKY
	 vHvyD9I+GBcuXp4dFVjM3eXiVuZljvN/Go7MNOpa501H60DuTPBpFyJ6oy06PxEslF
	 8LiaLrNsXgJ9B4rWike3Uh3CgJcJxH9DpDOAqqDIG1wk7U8e5F8TfncajbB5Cp4tp9
	 9wPCHCXp39qgA==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.28/5.94) with ESMTPS id 64KCcX9U1095469
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Wed, 20 May 2026 20:38:33 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 20 May 2026 20:38:34 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS05.realtek.com.tw (10.21.1.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 20 May 2026 20:38:34 +0800
Received: from [127.0.1.1] (172.21.40.76) by RTKEXHMBS05.realtek.com.tw
 (10.21.1.55) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Wed, 20 May 2026 20:38:34 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <kevin_yang@realtek.com>
Subject: [PATCH rtw-next 2/7] wifi: rtw89: 8922d: refactor digital power compensation to support new format
Date: Wed, 20 May 2026 20:38:18 +0800
Message-ID: <20260520123823.1792954-3-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260520123823.1792954-1-pkshih@realtek.com>
References: <20260520123823.1792954-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-36706-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo];
	DKIM_TRACE(0.00)[realtek.com:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: D55FB58E088
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Because base settings of digital power compensation can be shared across
all bands, the settings are divided into two parts -- base and individual
values per bands. Refactor the code to be reuse with new format.

No change logic at all.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/rtw8922d.c | 31 +++++++++++++------
 1 file changed, 22 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/rtw8922d.c b/drivers/net/wireless/realtek/rtw89/rtw8922d.c
index c6c37e25e4c8..af2df4adfa85 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8922d.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8922d.c
@@ -2118,29 +2118,42 @@ static void rtw8922d_set_digital_pwr_comp(struct rtw89_dev *rtwdev,
 					  enum rtw89_rf_path path,
 					  enum rtw89_phy_idx phy_idx)
 {
-#define DIGITAL_PWR_COMP_REG_NUM 22
+#define DIGITAL_PWR_COMP_BASE_NUM 7
+#define DIGITAL_PWR_COMP_VALS_NUM 15
 	static const u32 pw_comp_cr[2] = {R_RX_PATH0_TBL0_BE4, R_RX_PATH1_TBL0_BE4};
-	const __le32 (*pwr_comp_val)[2][RTW89_TX_COMP_BAND_NR]
-				    [BB_PATH_NUM_8922D][DIGITAL_PWR_COMP_REG_NUM];
+	const struct {
+		struct {
+			__le32 base[DIGITAL_PWR_COMP_BASE_NUM];
+			__le32 vals[DIGITAL_PWR_COMP_VALS_NUM];
+		} sets[2][RTW89_TX_COMP_BAND_NR][BB_PATH_NUM_8922D];
+	} *pwr_comp_v0;
 	struct rtw89_fw_elm_info *elm_info = &rtwdev->fw.elm_info;
 	const struct rtw89_fw_element_hdr *txcomp_elm = elm_info->tx_comp;
-	const __le32 *digital_pwr_comp;
+	const __le32 (*comp_base)[DIGITAL_PWR_COMP_BASE_NUM];
+	const __le32 (*comp_vals)[DIGITAL_PWR_COMP_VALS_NUM];
 	u32 addr, val;
 	u32 i;
 
-	if (sizeof(*pwr_comp_val) != le32_to_cpu(txcomp_elm->size)) {
+	if (sizeof(*pwr_comp_v0) == le32_to_cpu(txcomp_elm->size)) {
+		pwr_comp_v0 = (const void *)txcomp_elm->u.common.contents;
+		comp_base = &pwr_comp_v0->sets[nss][chan->tx_comp_band][path].base;
+		comp_vals = &pwr_comp_v0->sets[nss][chan->tx_comp_band][path].vals;
+	} else {
 		rtw89_debug(rtwdev, RTW89_DBG_UNEXP,
 			    "incorrect power comp size %d\n",
 			    le32_to_cpu(txcomp_elm->size));
 		return;
 	}
 
-	pwr_comp_val = (const void *)txcomp_elm->u.common.contents;
-	digital_pwr_comp = (*pwr_comp_val)[nss][chan->tx_comp_band][path];
 	addr = pw_comp_cr[path];
 
-	for (i = 0; i < DIGITAL_PWR_COMP_REG_NUM; i++, addr += 4) {
-		val = le32_to_cpu(digital_pwr_comp[i]);
+	for (i = 0; i < ARRAY_SIZE(*comp_base); i++, addr += 4) {
+		val = le32_to_cpu((*comp_base)[i]);
+		rtw89_phy_write32_idx(rtwdev, addr, MASKDWORD, val, phy_idx);
+	}
+
+	for (i = 0; i < ARRAY_SIZE(*comp_vals); i++, addr += 4) {
+		val = le32_to_cpu((*comp_vals)[i]);
 		rtw89_phy_write32_idx(rtwdev, addr, MASKDWORD, val, phy_idx);
 	}
 }
-- 
2.25.1


