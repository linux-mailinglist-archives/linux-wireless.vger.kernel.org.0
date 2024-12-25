Return-Path: <linux-wireless+bounces-16797-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CEC459FC52F
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Dec 2024 13:28:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 386E17A16E5
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Dec 2024 12:28:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B67B14A09F;
	Wed, 25 Dec 2024 12:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="m50iWf5x"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE4D385626
	for <linux-wireless@vger.kernel.org>; Wed, 25 Dec 2024 12:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735129730; cv=none; b=PONFyqLpBkNIBqVgXP6tnERdGh8+HSwbOQ23vlpSRY4XYhXuaPDyh4JDJZfCgOaOwwAqBXNPI+QYQM/kbrBYeWCJtFAwg3A3+pjsguTstjWU2Gnp1oAJmdza4TG1j969m/oyEXofa94Y2jPwQwtLNFsBYd73JsendVe1gISi+As=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735129730; c=relaxed/simple;
	bh=jJuSRB+Osh0sVgYlayOqAN2yX2/rZV9sa9BgG6QyZMQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=N6aLMaMIao71zvsEL4s25zfFyhzjANxI230feUSItVRAxwCsxPFATBL/coqe+Wk1N5VYEeD5genKJHoEsR5HKwjODC76Xk7mNzgdA0LvrOwBNPaF043Z2rh3ZsIeRJeGQEulDRlfbm9aWpnBaXV5H113/w4ragbgO6NrdvGnf0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=m50iWf5x; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4BPCSiuzE856092, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1735129724; bh=jJuSRB+Osh0sVgYlayOqAN2yX2/rZV9sa9BgG6QyZMQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=m50iWf5xZ/F4+I3hgiC5VvU0CJaD2ndQfH7cwIfw/8GsPVRGU6tbqwK+jcOBY/uvh
	 fpao04DWV3I36iTp/xqFYzMe0c5f5PVB9/s7ny+rmocFjNil+zJWDdBsZW1oNwIdLA
	 cBtToyhSB5isDFnDFmIqX7Q5Ix9WbUp0rasNDXIMK5oZZcpYPuE/f05eyYOVW3CU/y
	 QOLu3Jw2xjMUPK0LmVc1GgRa1HVAIchziqeTUw2zzxcvYezWqw7lpI6C2wiiOc7MrX
	 89tkWv7TToFVsCCfApobIkQIB18Rf+o77GGDb9cyC/o4aRiLUd11w761ls6AOG1Box
	 YuZkE96eVojNA==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 4BPCSiuzE856092
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Wed, 25 Dec 2024 20:28:44 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 25 Dec 2024 20:28:44 +0800
Received: from [127.0.1.1] (172.16.17.30) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 25 Dec
 2024 20:28:31 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <timlee@realtek.com>
Subject: [PATCH] wifi: rtw89: pci: disable PCI completion timeout control
Date: Wed, 25 Dec 2024 20:28:04 +0800
Message-ID: <20241225122804.10214-1-pkshih@realtek.com>
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

Realtek's chips follow suggestion of PCIe spec to design the max timeout of
PCI completion, but some PCIe host reply too slow to meet it and lead PCI
AER. Disable PCI completion timeout function via PCI configuration to
avoid the AER.

Signed-off-by: Chin-Yen Lee <timlee@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/pci.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/pci.c b/drivers/net/wireless/realtek/rtw89/pci.c
index c3a027735d0f..516160147191 100644
--- a/drivers/net/wireless/realtek/rtw89/pci.c
+++ b/drivers/net/wireless/realtek/rtw89/pci.c
@@ -4078,6 +4078,15 @@ static void rtw89_pci_l1ss_cfg(struct rtw89_dev *rtwdev)
 		rtw89_pci_l1ss_set(rtwdev, true);
 }
 
+static void rtw89_pci_cpl_timeout_cfg(struct rtw89_dev *rtwdev)
+{
+	struct rtw89_pci *rtwpci = (struct rtw89_pci *)rtwdev->priv;
+	struct pci_dev *pdev = rtwpci->pdev;
+
+	pcie_capability_set_word(pdev, PCI_EXP_DEVCTL2,
+				 PCI_EXP_DEVCTL2_COMP_TMOUT_DIS);
+}
+
 static int rtw89_pci_poll_io_idle_ax(struct rtw89_dev *rtwdev)
 {
 	int ret = 0;
@@ -4291,6 +4300,7 @@ void rtw89_pci_basic_cfg(struct rtw89_dev *rtwdev, bool resume)
 
 	rtw89_pci_disable_eq(rtwdev);
 	rtw89_pci_filter_out(rtwdev);
+	rtw89_pci_cpl_timeout_cfg(rtwdev);
 	rtw89_pci_link_cfg(rtwdev);
 	rtw89_pci_l1ss_cfg(rtwdev);
 }
-- 
2.25.1


