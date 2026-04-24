Return-Path: <linux-wireless+bounces-35260-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SOXmDiQb62lTIgAAu9opvQ
	(envelope-from <linux-wireless+bounces-35260-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Apr 2026 09:26:28 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 93FB045AB0F
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Apr 2026 09:26:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 993FB300F9D8
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Apr 2026 07:26:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2346431E84E;
	Fri, 24 Apr 2026 07:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="JMm7TInL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63CD027FD74
	for <linux-wireless@vger.kernel.org>; Fri, 24 Apr 2026 07:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777015585; cv=none; b=hoUMY9nX1xhPuaQZkAZbI5jdENL8Jp0Ygg4DTe9WejFH72M+twrsrFseKd16fFf5h27Iukp3LYD407rIKYdfnRmX59m2t8k37IfauyYSUMf23pWwlMBGJUmtZiMqcj0CQPm5RNi4i3Aocx6fipnd5/867ptH7ueC63UdXPWh56I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777015585; c=relaxed/simple;
	bh=wTkPufixk//E+cvyXZpM3VBB81NKIitrpUfkE+bZjvQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BTOlxH3xxPc2afvO1r2uwZy4radkhfk6RWKshTR/ENw3daKPMQNT0mvxwmi4EaAZvZPw0w+YJjMMVmQzPHI6pDZtHW4JJ/hXabfoNE4DgfG2fCceZYslkEBwnxFhXQz9gtRFImWyQowsnYvXbMIE9R0baClrkaWT9ZnUhOAwpRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=JMm7TInL; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 63O7QKMn8417389, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1777015580; bh=JaiLy6TuoN2PUufXBsQ74P35S/uTpp5z0NqPy65OtmI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=JMm7TInLxASDQb7llq0DmyiUF9oYOTWycIOzKpVrWEoLAA2unVAHxZW840lRa4971
	 1wSo1ml9NvUbRgm2F5LXGwEV4koCsSuEgWOwtVdBUgiqQk3YvmMoSn9piuHoXUa8cE
	 jrE9IQJRE4GxW2Baz8lzk9VYjZlS35hdIYKoH0W/YIRE/OU3ge+7VfVyXN+dR22cdL
	 tsAv5rUuo6858ZN0+TmqgqfGmukCUb+WnXWFPB1WHvS0iLL5dAGpqXpzgG/PzoiZMu
	 EYEZVoB+BM9P5l7pGCFQKAi4PybeUi5FXQ2P92bzQktRmGIPqrDNc6K/HCtxoZerXD
	 Yq14/1qVjhedg==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.26/5.94) with ESMTPS id 63O7QKMn8417389
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Fri, 24 Apr 2026 15:26:20 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Fri, 24 Apr 2026 15:26:21 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS05.realtek.com.tw (10.21.1.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Fri, 24 Apr 2026 15:26:19 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS06.realtek.com.tw
 (10.21.1.56) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Fri, 24 Apr 2026 15:26:19 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <dian_syuan0116@realtek.com>
Subject: [PATCH rtw-next 1/3] wifi: rtw89: pci: no need to wait CLK ready for RTL8922DE
Date: Fri, 24 Apr 2026 15:25:50 +0800
Message-ID: <20260424072552.59220-2-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260424072552.59220-1-pkshih@realtek.com>
References: <20260424072552.59220-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Rspamd-Queue-Id: 93FB045AB0F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-35260-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	DKIM_TRACE(0.00)[realtek.com:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_SEVEN(0.00)[7]

The bit is to wait for CLK ready when entering PCIE L1SS. However, a
certain host might not enable CLK for a situation, causing device state
stuck and trigger PCIE SER. Unset this bit as default like earlier chips.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/pci.h    |  2 ++
 drivers/net/wireless/realtek/rtw89/pci_be.c | 12 ++++++++++++
 2 files changed, 14 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/pci.h b/drivers/net/wireless/realtek/rtw89/pci.h
index e7da37b9da7d..d0d1e2b99698 100644
--- a/drivers/net/wireless/realtek/rtw89/pci.h
+++ b/drivers/net/wireless/realtek/rtw89/pci.h
@@ -33,6 +33,8 @@
 #define RAC_REG_REV2			0x1B
 #define BAC_CMU_EN_DLY_MASK		GENMASK(15, 12)
 #define PCIE_DPHY_DLY_25US		0x1
+#define RAC_ANA14			0x14
+#define EIEOS_L1SS_WAIT_CLKRDY		BIT(2)
 #define RAC_ANA19			0x19
 #define B_PCIE_BIT_RD_SEL		BIT(2)
 #define RAC_REG_FLD_0			0x1D
diff --git a/drivers/net/wireless/realtek/rtw89/pci_be.c b/drivers/net/wireless/realtek/rtw89/pci_be.c
index dfffec1ff3c7..473d491eb3f4 100644
--- a/drivers/net/wireless/realtek/rtw89/pci_be.c
+++ b/drivers/net/wireless/realtek/rtw89/pci_be.c
@@ -83,6 +83,17 @@ static void _patch_pcie_power_wake_be(struct rtw89_dev *rtwdev, bool power_up)
 		rtw89_write32_clr(rtwdev, R_BE_HCI_OPT_CTRL, BIT_WAKE_CTRL_V1);
 }
 
+static void _patch_pre_init_be(struct rtw89_dev *rtwdev)
+{
+	struct rtw89_hal *hal = &rtwdev->hal;
+
+	if (!(rtwdev->chip->chip_id == RTL8922D && hal->cid == RTL8922D_CID7090))
+		return;
+
+	rtw89_write16_clr(rtwdev, R_RAC_DIRECT_OFFSET_BE_LANE0_G2 +
+				  RAC_ANA14 * RAC_MULT, EIEOS_L1SS_WAIT_CLKRDY);
+}
+
 static void rtw89_pci_set_io_rcy_be(struct rtw89_dev *rtwdev)
 {
 	const struct rtw89_pci_info *info = rtwdev->pci_info;
@@ -475,6 +486,7 @@ static int rtw89_pci_ops_mac_pre_init_be(struct rtw89_dev *rtwdev)
 
 	rtw89_pci_set_io_rcy_be(rtwdev);
 	_patch_pcie_power_wake_be(rtwdev, true);
+	_patch_pre_init_be(rtwdev);
 	rtw89_pci_ctrl_wpdma_pcie_be(rtwdev, false);
 	rtw89_pci_ctrl_trxdma_pcie_be(rtwdev, MAC_AX_PCIE_DISABLE,
 				      MAC_AX_PCIE_DISABLE, MAC_AX_PCIE_DISABLE);
-- 
2.25.1


