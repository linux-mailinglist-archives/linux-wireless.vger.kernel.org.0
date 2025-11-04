Return-Path: <linux-wireless+bounces-28523-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B57B0C30318
	for <lists+linux-wireless@lfdr.de>; Tue, 04 Nov 2025 10:15:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A2ABB4F677E
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Nov 2025 09:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 641583128AA;
	Tue,  4 Nov 2025 09:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="s+TL2Is4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B86AE3126CC
	for <linux-wireless@vger.kernel.org>; Tue,  4 Nov 2025 09:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762247455; cv=none; b=o8E5gKs+aJVV5hPtfdZnnQid96su5oYCVfFcTFa3uhi4yLUWIK7OoMq4BuzS6legKCb/TJJNIZi78y30wCxLkekfkDDqglzaHXXdDo3aAey8g4hxDHyJ1Pu4F+f8ogsVWmRXGONPKzU5aQGAmqbo4AWIQtHs689uruioCa30XOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762247455; c=relaxed/simple;
	bh=U1UWoKVjGfYHNbkQxpcxDj9OZzUaQOgPtd5EJshipzg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aiziGh1CnlDE2qDJpCPuZ4Wd0mF51Bp+ql1zDDSoECEjSTxM5HkA8EqYwvOh63gwuKoaRHwPlVSNYoTrMZWKJuAk4P5YOEqLC+FvrdIsoWMoUDxw/IPsel5L7iWnpTNJKZFGhpIT+8Ch08Mz1gBGckhLq3j1OJZNe/6GsOMLh9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=s+TL2Is4; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5A49AnbI63073293, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1762247449; bh=5tIngcGLrKvsiSH9duKM5iELC5/PlN6cG2MQMGWOoYw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type;
	b=s+TL2Is4wSfeqBYs5bcCbV2UAAOWYCclObuh3nd2+wvgOyx9LCJBUI10ygIpAukfT
	 aivYFm0WgODprhfrkTisYGItV1m2JkIz+m3GVeuPnOUeoYd/kD8oV0GI/2+jvVTqk3
	 uADh/TLZn2JE46fsyvX4rgfjjVvspDCKvJlcP2o6FhZ2nrN2Q2IH+Li0vqvLMS6wyg
	 O7p/bmN3YhXqEur5Jry700SRPdAAox5KxJ2vgrChuSgiFSCh4gLnbZWHP/1m95chmG
	 8qygaUhQ7glTjkIxl5flXyS3esoW2GEzUw/XU3K/LnUpP0qZlUkhl8baKv6TyV6slh
	 ++b7bsFaup1WA==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 5A49AnbI63073293
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Tue, 4 Nov 2025 17:10:49 +0800
Received: from RTKEXHMBS03.realtek.com.tw (10.21.1.53) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Tue, 4 Nov 2025 17:10:49 +0800
Received: from [127.0.1.1] (172.21.146.58) by RTKEXHMBS03.realtek.com.tw
 (10.21.1.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.27 via Frontend
 Transport; Tue, 4 Nov 2025 17:10:49 +0800
From: <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <damon.chen@realtek.com>
Subject: [PATCH rtw-next 1/8] wifi: rtw89: pci: add to read PCI configuration space from common code
Date: Tue, 4 Nov 2025 17:14:06 +0800
Message-ID: <1762247653-26864-2-git-send-email-pkshih@realtek.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1762247653-26864-1-git-send-email-pkshih@realtek.com>
References: <1762247653-26864-1-git-send-email-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

From: Ping-Ke Shih <pkshih@realtek.com>

Normally only access PCI device in pci.c. However for debug purpose,
a set of registers predefined in firmware element including PCI
configuration space should be read for diagnosis.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.h | 13 +++++++++++++
 drivers/net/wireless/realtek/rtw89/mac.h  |  2 --
 drivers/net/wireless/realtek/rtw89/pci.c  | 16 ++++++++++++++++
 3 files changed, 29 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 97cb0e5f0898..fd0e1a68ecc4 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -39,6 +39,8 @@ extern const struct ieee80211_ops rtw89_ops;
 #define RFREG_MASK 0xfffff
 #define INV_RF_DATA 0xffffffff
 #define BYPASS_CR_DATA 0xbabecafe
+#define RTW89_R32_EA 0xEAEAEAEA
+#define RTW89_R32_DEAD 0xDEADBEEF
 
 #define RTW89_TRACK_WORK_PERIOD	round_jiffies_relative(HZ * 2)
 #define RTW89_TRACK_PS_WORK_PERIOD msecs_to_jiffies(100)
@@ -3654,6 +3656,8 @@ struct rtw89_hci_ops {
 	void (*write16)(struct rtw89_dev *rtwdev, u32 addr, u16 data);
 	void (*write32)(struct rtw89_dev *rtwdev, u32 addr, u32 data);
 
+	u32 (*read32_pci_cfg)(struct rtw89_dev *rtwdev, u32 addr);
+
 	int (*mac_pre_init)(struct rtw89_dev *rtwdev);
 	int (*mac_pre_deinit)(struct rtw89_dev *rtwdev);
 	int (*mac_post_init)(struct rtw89_dev *rtwdev);
@@ -6634,6 +6638,15 @@ rtw89_write_rf(struct rtw89_dev *rtwdev, enum rtw89_rf_path rf_path,
 	mutex_unlock(&rtwdev->rf_mutex);
 }
 
+static inline u32 rtw89_read32_pci_cfg(struct rtw89_dev *rtwdev, u32 addr)
+{
+	if (rtwdev->hci.type != RTW89_HCI_TYPE_PCIE ||
+	    !rtwdev->hci.ops->read32_pci_cfg)
+		return RTW89_R32_EA;
+
+	return rtwdev->hci.ops->read32_pci_cfg(rtwdev, addr);
+}
+
 static inline struct ieee80211_txq *rtw89_txq_to_txq(struct rtw89_txq *rtwtxq)
 {
 	void *p = rtwtxq;
diff --git a/drivers/net/wireless/realtek/rtw89/mac.h b/drivers/net/wireless/realtek/rtw89/mac.h
index 46302f4aa3d9..d9c854c37452 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.h
+++ b/drivers/net/wireless/realtek/rtw89/mac.h
@@ -574,8 +574,6 @@ enum rtw89_mac_bf_rrsc_rate {
 	RTW89_MAC_BF_RRSC_MAX = 32
 };
 
-#define RTW89_R32_EA		0xEAEAEAEA
-#define RTW89_R32_DEAD		0xDEADBEEF
 #define MAC_REG_POOL_COUNT	10
 #define ACCESS_CMAC(_addr) \
 	({typeof(_addr) __addr = (_addr); \
diff --git a/drivers/net/wireless/realtek/rtw89/pci.c b/drivers/net/wireless/realtek/rtw89/pci.c
index 0ee5f8579447..8fe9f6208c54 100644
--- a/drivers/net/wireless/realtek/rtw89/pci.c
+++ b/drivers/net/wireless/realtek/rtw89/pci.c
@@ -2064,6 +2064,20 @@ static void rtw89_pci_ops_write32(struct rtw89_dev *rtwdev, u32 addr, u32 data)
 	writel(data, rtwpci->mmap + addr);
 }
 
+static u32 rtw89_pci_ops_read32_pci_cfg(struct rtw89_dev *rtwdev, u32 addr)
+{
+	struct rtw89_pci *rtwpci = (struct rtw89_pci *)rtwdev->priv;
+	struct pci_dev *pdev = rtwpci->pdev;
+	u32 value;
+	int ret;
+
+	ret = pci_read_config_dword(pdev, addr, &value);
+	if (ret)
+		return RTW89_R32_EA;
+
+	return value;
+}
+
 static void rtw89_pci_ctrl_dma_trx(struct rtw89_dev *rtwdev, bool enable)
 {
 	const struct rtw89_pci_info *info = rtwdev->pci_info;
@@ -4683,6 +4697,8 @@ static const struct rtw89_hci_ops rtw89_pci_ops = {
 	.write16	= rtw89_pci_ops_write16,
 	.write32	= rtw89_pci_ops_write32,
 
+	.read32_pci_cfg	= rtw89_pci_ops_read32_pci_cfg,
+
 	.mac_pre_init	= rtw89_pci_ops_mac_pre_init,
 	.mac_pre_deinit	= rtw89_pci_ops_mac_pre_deinit,
 	.mac_post_init	= rtw89_pci_ops_mac_post_init,
-- 
2.25.1


