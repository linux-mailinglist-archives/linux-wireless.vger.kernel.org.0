Return-Path: <linux-wireless+bounces-36444-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KBfAChZ7BmqFkAIAu9opvQ
	(envelope-from <linux-wireless+bounces-36444-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 15 May 2026 03:47:02 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C33E548886
	for <lists+linux-wireless@lfdr.de>; Fri, 15 May 2026 03:47:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5A8A4306394E
	for <lists+linux-wireless@lfdr.de>; Fri, 15 May 2026 01:45:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ECC5235C01;
	Fri, 15 May 2026 01:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="CX15iRCm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3994212550
	for <linux-wireless@vger.kernel.org>; Fri, 15 May 2026 01:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778809510; cv=none; b=FfhX6j5QlKamI2cN6VuwK6cI4DE7hLxGyky3f9JRDL2tofmEu/inxreBPgh8tFPv7QHwBMTUxzNC2VjgaQudhAvlg1W4MNyVa9m/Cjubc6s2flmU1UP6lrUhcQrLlv6jUENKRMC466E/V/NzzeuJSQWIRPUlk/oo9DJgujFOGPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778809510; c=relaxed/simple;
	bh=+kmlRQJJSHDVYXoBEGKNvwsC2O49flIc7L0CfPuPMc8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T5idk5qwgvvIxjrUb9rEBRXFRL+gmNtGXKBll4e7DifSXx0QFh1KDTUGDm0hSIH5OvcRy/cNJVs0rurpUwhAq/r1LKvJPfHh+yO1XHI43zvdyP0auPzQO9UP1XTAAlNoMw2rLvPICEiwemKO5gWO4qyl33+boq22iyamTb6Pr2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=CX15iRCm; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 64F1j8tF52587149, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1778809508; bh=G1t2/oODqA+UmXKRZgdxi74kFgl1TB5Rz2LTsZlGjdU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=CX15iRCm4nav0DNxf8kdu3qVnA52dWeh6yjDAcrc3eMkjvPNp3xkXQPkV6EEyV2RE
	 1gimAXZxjXhnwxYkDG7DlCtLxqtxLpvQ1JAXA/OzNPG78SLYv0Mw8Pfpu3nyyOOAdT
	 Nq/artm2fTrP1yUHm77jVOdAXTPseBfbg7UB/fucOaLeqofTyBl9txk6r21GER4yX8
	 0/M9WdWjG7kA/scb/sZXdb/hnE5GITt64aDzWAxkwNEuYxnVsIZwzuXx3j7uDgF4lI
	 Jvs9gO5m8PgEs7pVZhZVC8c5IED0c2B8qBPdYP5ASTrTy9Gvv/ZhZczMgny1ste0Xm
	 dCXKXO380qKHQ==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.27/5.94) with ESMTPS id 64F1j8tF52587149
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Fri, 15 May 2026 09:45:08 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 15 May 2026 09:45:07 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS06.realtek.com.tw
 (10.21.1.56) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Fri, 15 May 2026 09:45:07 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <timlee@realtek.com>, <dian_syuan0116@realtek.com>, <phhuang@realtek.com>,
        <kevin_yang@realtek.com>
Subject: [PATCH rtw-next 05/13] wifi: rtw89: pci: not disable PCI completion timeout control for a variant of RTL8922DE
Date: Fri, 15 May 2026 09:44:25 +0800
Message-ID: <20260515014433.16168-6-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260515014433.16168-1-pkshih@realtek.com>
References: <20260515014433.16168-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Rspamd-Queue-Id: 9C33E548886
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-36444-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[realtek.com:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,realtek.com:email,realtek.com:mid,realtek.com:dkim]
X-Rspamd-Action: no action

The variant of RTL8922DE change the design, and no need to disable PCI
completion timeout. Apply the setting accordingly.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/pci.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/pci.c b/drivers/net/wireless/realtek/rtw89/pci.c
index f7107dc05b71..fe1152c560bd 100644
--- a/drivers/net/wireless/realtek/rtw89/pci.c
+++ b/drivers/net/wireless/realtek/rtw89/pci.c
@@ -4380,10 +4380,20 @@ static void rtw89_pci_l1ss_cfg(struct rtw89_dev *rtwdev)
 static void rtw89_pci_cpl_timeout_cfg(struct rtw89_dev *rtwdev)
 {
 	struct rtw89_pci *rtwpci = (struct rtw89_pci *)rtwdev->priv;
+	enum rtw89_core_chip_id chip_id = rtwdev->chip->chip_id;
+	struct rtw89_hal *hal = &rtwdev->hal;
 	struct pci_dev *pdev = rtwpci->pdev;
+	bool dis = true;
+
+	if (chip_id == RTL8922D && hal->cid == RTL8922D_CID7090)
+		dis = false;
 
-	pcie_capability_set_word(pdev, PCI_EXP_DEVCTL2,
-				 PCI_EXP_DEVCTL2_COMP_TMOUT_DIS);
+	if (dis)
+		pcie_capability_set_word(pdev, PCI_EXP_DEVCTL2,
+					 PCI_EXP_DEVCTL2_COMP_TMOUT_DIS);
+	else
+		pcie_capability_clear_word(pdev, PCI_EXP_DEVCTL2,
+					   PCI_EXP_DEVCTL2_COMP_TMOUT_DIS);
 }
 
 static int rtw89_pci_poll_io_idle_ax(struct rtw89_dev *rtwdev)
-- 
2.25.1


