Return-Path: <linux-wireless+bounces-31433-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id Q/3iMK4AgGlo1QIAu9opvQ
	(envelope-from <linux-wireless+bounces-31433-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 02 Feb 2026 02:41:02 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id DA47EC7C7E
	for <lists+linux-wireless@lfdr.de>; Mon, 02 Feb 2026 02:41:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 76707300107C
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Feb 2026 01:40:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21FBC6DCE1;
	Mon,  2 Feb 2026 01:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="X2a67yz2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D8595464D
	for <linux-wireless@vger.kernel.org>; Mon,  2 Feb 2026 01:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769996456; cv=none; b=qfkx76SEOZL7ZBNZFFXqp92HfektG9RB3Fgd5hGwZcuJsUsYNC+s6Oxo8j7hGQfcahgaQAHOyNkmhryd464blbfWn1o4cXZaHKxnVjDum+W6OThx+B4ftiW9SA6i8U8KGn7IPos8IrdrKw5MGdMP8xIWnkmSMr+LVSwUSBAueLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769996456; c=relaxed/simple;
	bh=ANl910oa30g3dfMTS0CnmxjjWkWdmTUBumajbGdUEAg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kPk18bwjhQm9a4exhYW10YR1RYr5H/Nsu7frTyDPeUNcKknNMTrjk33kiiS6LlwqCP5Qc4k0jbB2GEHTAI+8Wbveh6smWQiFodmWG5FE050B+0H1NJn16tmU+qevB1omYWU8O9SD7gTBMHPPa0XNe3fHrefipXd2smiApVlSEKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=X2a67yz2; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6121en9731862600, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1769996449; bh=VMjGj7G5TJTzr1rhe2cfXwxZLawWaGZOLS4TieOzmj4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=X2a67yz2bc/OW3DE3dNk7BD9uhIQcwnop5qgTcJHdZ0IvAiSZBDv5+ReWwQFeMVnr
	 7No9skejr5E3+/LS1ZfpQCcnT588VDjvd21neKweoHSIbvotJ+E2rWTmOKraXOPage
	 W/8XdZVuj0wj4cJeYwsZvuLqb3aTLdxLl9J/XfYN3R0VljRVlYw86XwikA2bVsae9w
	 twmFzv36UXic6WGFAwYdyXDbRIFCbO1Uzns11bzPB9oZbkXYT4TiOPKeVkdU7qAv9g
	 vuNeuCdylnRT78R6aHjewSbvjTxfuhX6iU9URUzzvqINgi8ypaHaXO0av1nHdAxWoK
	 VqYVX1HDDWjmw==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 6121en9731862600
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 2 Feb 2026 09:40:49 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 2 Feb 2026 09:40:50 +0800
Received: from RTKEXHMBS03.realtek.com.tw (10.21.1.53) by
 RTKEXHMBS06.realtek.com.tw (10.21.1.56) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 2 Feb 2026 09:40:50 +0800
Received: from [127.0.1.1] (172.21.40.76) by RTKEXHMBS03.realtek.com.tw
 (10.21.1.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Mon, 2 Feb 2026 09:40:50 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <iohann.tachy@gmail.com>
Subject: [PATCH rtw-next] wifi: rtw89: pci: add quirks to avoid using PCI DAC for X99 board across chips
Date: Mon, 2 Feb 2026 09:40:49 +0800
Message-ID: <20260202014049.11783-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31433-lists,linux-wireless=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	DKIM_TRACE(0.00)[realtek.com:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: DA47EC7C7E
X-Rspamd-Action: no action

RTL8852BE can't enable 36-bits DMA on Intel X99 motherboard, which isn't
a sold combination so add quirk across all chips, not only on specific chip
RTL8852BE,

Reported-by: Iohann Tachy <iohann.tachy@gmail.com>
Closes: https://lore.kernel.org/linux-wireless/CAPVS0eLR5KCmBEkGHnSxwKQM0hwCSaL0TSaTMNT_GJQK1sT8hg@mail.gmail.com/T/#m976028ea900ea6f2c5fbbd1ff14a92377227f555
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.h |  1 +
 drivers/net/wireless/realtek/rtw89/pci.c  | 16 ++++++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 4778957d6b2d..0c894ba73a65 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -5205,6 +5205,7 @@ enum rtw89_flags {
 
 enum rtw89_quirks {
 	RTW89_QUIRK_PCI_BER,
+	RTW89_QUIRK_PCI_NO_DAC,
 	RTW89_QUIRK_THERMAL_PROT_120C,
 	RTW89_QUIRK_THERMAL_PROT_110C,
 
diff --git a/drivers/net/wireless/realtek/rtw89/pci.c b/drivers/net/wireless/realtek/rtw89/pci.c
index 43c61b3dc969..fded15b2029f 100644
--- a/drivers/net/wireless/realtek/rtw89/pci.c
+++ b/drivers/net/wireless/realtek/rtw89/pci.c
@@ -19,6 +19,18 @@ MODULE_PARM_DESC(disable_clkreq, "Set Y to disable PCI clkreq support");
 MODULE_PARM_DESC(disable_aspm_l1, "Set Y to disable PCI ASPM L1 support");
 MODULE_PARM_DESC(disable_aspm_l1ss, "Set Y to disable PCI L1SS support");
 
+static const struct dmi_system_id rtw89_pci_quirks[] = {
+	{
+		.ident = "MACHINIST X99-RS9",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "MACHINIST"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "X99-RS9"),
+		},
+		.driver_data = (void *)RTW89_QUIRK_PCI_NO_DAC,
+	},
+	{},
+};
+
 static int rtw89_pci_get_phy_offset_by_link_speed(struct rtw89_dev *rtwdev,
 						  u32 *phy_offset)
 {
@@ -3305,6 +3317,9 @@ static bool rtw89_pci_is_dac_compatible_bridge(struct rtw89_dev *rtwdev)
 	if (!bridge)
 		return false;
 
+	if (test_bit(RTW89_QUIRK_PCI_NO_DAC, rtwdev->quirks))
+		return false;
+
 	switch (bridge->vendor) {
 	case PCI_VENDOR_ID_INTEL:
 		return true;
@@ -4765,6 +4780,7 @@ int rtw89_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	rtwdev->hci.cpwm_addr = pci_info->cpwm_addr;
 
 	rtw89_check_quirks(rtwdev, info->quirks);
+	rtw89_check_quirks(rtwdev, rtw89_pci_quirks);
 	rtw89_check_pci_ssid_quirks(rtwdev, pdev, pci_info->ssid_quirks);
 
 	SET_IEEE80211_DEV(rtwdev->hw, &pdev->dev);

base-commit: 4c1552473acf03cad828884b4e1c90b97a89b265
-- 
2.25.1


