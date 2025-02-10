Return-Path: <linux-wireless+bounces-18693-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 07CD9A2E42E
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Feb 2025 07:30:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7D6C3A6558
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Feb 2025 06:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1907B1925BF;
	Mon, 10 Feb 2025 06:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XnbtOL3C"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD5218E25;
	Mon, 10 Feb 2025 06:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739169041; cv=none; b=ABFMn4R7qkHGNTIFOxNg0woNwT48+NdIHgovfeBg5RaoEcA0nkr7wco88Ru7qPuIV2Hc0sTCZflI9R0dHyEr9DnXJeZEB3yKCEBTw/qbs57jR1UZghzT8L7sQMRqLm4jrySVuknXvZ0l/rsIN9lRZr4aCuO1tGczdB2cQQ7j/28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739169041; c=relaxed/simple;
	bh=yOXqDxX7xqnaXxzmNml1TaIF3BOBC57MeLf4S1YzI0k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eYceBPMNzsSyXcMQH5SPPPIFs04De+9GLFllfW3T7193ibPb0KV+oMIU3vbwpCZOh5KgZj6qHBLr17oLD2/XQN9yfulBV9lx7A3RvGjPd0hKHChwyqiZWW4Rv4FwEQxcgpjWPkQr7fFeRAqbyWFLivd+kDjWqCzfX37WxnTGmXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XnbtOL3C; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-21f74c4e586so21778595ad.0;
        Sun, 09 Feb 2025 22:30:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739169038; x=1739773838; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ce1ptGyW5z6SnlbvfugnAJ/T3Weg5xPZTleJuf7DPDE=;
        b=XnbtOL3CfnnZ4tAGXvzWZx4gOgqbfQAxPlym5nEXyDD1deSkngmDHcUINT9nZbwJvg
         8LE1x8gAJ7Z01XBpLTvXBQFRW6hAWcwyJ81E1+4pgKH2vSFBjhyp0tB7MusZa2D4I7rg
         KcO2c0m3XTQ5p2mNg0KR/8PXF6NQLTNcD3PR7z5pFC3I0ytLlkupAOpxfK0WWZ1QuOgz
         BrAvfFnt12lO4GZuuon+EaDDuKkM68pC0EB7HdvRJP90a7ZNDYMK9aZVDZ8/YsZUjM+P
         TzOa7hwrhFPB6JVP1bEiPGSCYX0Cx4hfP2KDJOL1CRBR1nV7WlIgDcEG5hJjc6iUSPBq
         SUiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739169038; x=1739773838;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ce1ptGyW5z6SnlbvfugnAJ/T3Weg5xPZTleJuf7DPDE=;
        b=g3lvJrI5zRen1kPppxImDnxYsrFQFLIFtNq2TLNzBwmKTofcvwRZdYm1BWYpeTZXFc
         Sbj2jf4DFixnbQfTEGF1wBt/a81gYLwbIm/iZgY4inids0vtU5J+jZ5ax3ynNDkTzc5y
         huicXzVE2r7FRd17DExLpRh3X+YCuU2BowHkGKz0c13qcOZw7OWiuJX7hlOBI7eJKui9
         PK3/r7+ZK3YuorFuZjd08D1CpUZd283N0FsKPnWzRc2yYkx4Wm76Y4/gh0mPhouLpA/k
         RgU/wmda5ZOdk8m1dTfKzRV0LLWpNbXKosRFTSzXrTgNHwaEAXddj6/iTOeg8oqXDuX8
         FpPg==
X-Forwarded-Encrypted: i=1; AJvYcCU6mAVf/wgAuwiVYzsmq0i8oUOeuX031kRJ8HdeHxt9132mqgL+6uO/gwkF0XwWlFg2JqLh4tNOx0XvVJcr9Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YwL4s8fLCyFwX+yPrPD5Iesaw+DqDAQYJ+cM5BJ/O9sxAtQNRYv
	vuU0YFbDcSMqSPVKuAW8yRZf0HKRjfksM7l3uZg2rHslVWhYgMsdh8lXyL6A
X-Gm-Gg: ASbGncud77a6giPLJVZJ+h3nhbPlWCFckGrk5pAS5NKTxayXgOFCFX1Qne/7huYeJcR
	4qGMH6rT1dqRTc7pEE4da6vmKcTpbwnXQACr/L6Q4GJPx5NUoxeES9KGyluB4FZzXr/SWeOzDAA
	uwcXqiHNTEOeQp/PJKpauftDlsK8swKdO1VbZZVW1R1PHV5YowP7ret5VXc5VKUpM7xcRjNrK9L
	Rfi3gOkmcz7jHUrAuCbKYu9kHdD29P8bPpLsQkO0eC1Bz3qMxUVAfQ79+l+P8G3SRVcCKVHWwls
	ImM3jwe9gm0f4jKFkSrsxKMnJAuNV9/LWjowwfsvjf2d3D5jneJuWDY1JuAG1I3/mA==
X-Google-Smtp-Source: AGHT+IHYmA7reksJzEtj3yGsB5Zbs0rERMYLgmfbFv2z8KWx3KQSfCMSEejmc42hPI39oUfMGE2ldg==
X-Received: by 2002:a17:903:13c6:b0:21a:8300:b9ce with SMTP id d9443c01a7336-21f4e7772e2mr232645665ad.49.1739169038289;
        Sun, 09 Feb 2025 22:30:38 -0800 (PST)
Received: from localhost.localdomain (118-232-8-190.dynamic.kbronet.com.tw. [118.232.8.190])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-21f3650ce87sm70823735ad.36.2025.02.09.22.30.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Feb 2025 22:30:38 -0800 (PST)
From: Zenm Chen <zenmchen@gmail.com>
To: stable@vger.kernel.org
Cc: pkshih@realtek.com,
	linux-wireless@vger.kernel.org,
	Zenm Chen <zenmchen@gmail.com>
Subject: [PATCH v6.12] wifi: rtw89: pci: disable PCIE wake bit when PCIE deinit
Date: Mon, 10 Feb 2025 14:30:26 +0800
Message-ID: <20250210063026.3128-1-zenmchen@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ping-Ke Shih <pkshih@realtek.com>

[ Upstream commit 9c1df813e08832c3836c254bc8a2f83ff22dbc06 ]

The PCIE wake bit is to control PCIE wake signal to host. When PCIE is
going down, clear this bit to prevent waking up host unexpectedly.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
Link: https://patch.msgid.link/20241111063835.15454-1-pkshih@realtek.com
Signed-off-by: Zenm Chen <zenmchen@gmail.com>
---
Some users of RTL8852BE chip may encounter a shutdown issue [1] and this
upstream patch fixes it, so backport it to kernel 6.12.

[1] https://github.com/lwfinger/rtw89/issues/372
---
 drivers/net/wireless/realtek/rtw89/pci.c    | 17 ++++++++++++++---
 drivers/net/wireless/realtek/rtw89/pci.h    | 11 +++++++++++
 drivers/net/wireless/realtek/rtw89/pci_be.c |  2 ++
 3 files changed, 27 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/pci.c b/drivers/net/wireless/realtek/rtw89/pci.c
index 5aef7fa37..0ac84f968 100644
--- a/drivers/net/wireless/realtek/rtw89/pci.c
+++ b/drivers/net/wireless/realtek/rtw89/pci.c
@@ -2492,7 +2492,7 @@ static int rtw89_pci_dphy_delay(struct rtw89_dev *rtwdev)
 				       PCIE_DPHY_DLY_25US, PCIE_PHY_GEN1);
 }
 
-static void rtw89_pci_power_wake(struct rtw89_dev *rtwdev, bool pwr_up)
+static void rtw89_pci_power_wake_ax(struct rtw89_dev *rtwdev, bool pwr_up)
 {
 	if (pwr_up)
 		rtw89_write32_set(rtwdev, R_AX_HCI_OPT_CTRL, BIT_WAKE_CTRL);
@@ -2799,6 +2799,8 @@ static int rtw89_pci_ops_deinit(struct rtw89_dev *rtwdev)
 {
 	const struct rtw89_pci_info *info = rtwdev->pci_info;
 
+	rtw89_pci_power_wake(rtwdev, false);
+
 	if (rtwdev->chip->chip_id == RTL8852A) {
 		/* ltr sw trigger */
 		rtw89_write32_set(rtwdev, R_AX_LTR_CTRL_0, B_AX_APP_LTR_IDLE);
@@ -2841,7 +2843,7 @@ static int rtw89_pci_ops_mac_pre_init_ax(struct rtw89_dev *rtwdev)
 		return ret;
 	}
 
-	rtw89_pci_power_wake(rtwdev, true);
+	rtw89_pci_power_wake_ax(rtwdev, true);
 	rtw89_pci_autoload_hang(rtwdev);
 	rtw89_pci_l12_vmain(rtwdev);
 	rtw89_pci_gen2_force_ib(rtwdev);
@@ -2886,6 +2888,13 @@ static int rtw89_pci_ops_mac_pre_init_ax(struct rtw89_dev *rtwdev)
 	return 0;
 }
 
+static int rtw89_pci_ops_mac_pre_deinit_ax(struct rtw89_dev *rtwdev)
+{
+	rtw89_pci_power_wake_ax(rtwdev, false);
+
+	return 0;
+}
+
 int rtw89_pci_ltr_set(struct rtw89_dev *rtwdev, bool en)
 {
 	u32 val;
@@ -4264,7 +4273,7 @@ const struct rtw89_pci_gen_def rtw89_pci_gen_ax = {
 					    B_AX_RDU_INT},
 
 	.mac_pre_init = rtw89_pci_ops_mac_pre_init_ax,
-	.mac_pre_deinit = NULL,
+	.mac_pre_deinit = rtw89_pci_ops_mac_pre_deinit_ax,
 	.mac_post_init = rtw89_pci_ops_mac_post_init_ax,
 
 	.clr_idx_all = rtw89_pci_clr_idx_all_ax,
@@ -4280,6 +4289,8 @@ const struct rtw89_pci_gen_def rtw89_pci_gen_ax = {
 	.aspm_set = rtw89_pci_aspm_set_ax,
 	.clkreq_set = rtw89_pci_clkreq_set_ax,
 	.l1ss_set = rtw89_pci_l1ss_set_ax,
+
+	.power_wake = rtw89_pci_power_wake_ax,
 };
 EXPORT_SYMBOL(rtw89_pci_gen_ax);
 
diff --git a/drivers/net/wireless/realtek/rtw89/pci.h b/drivers/net/wireless/realtek/rtw89/pci.h
index 48c3ab735..0ea4dcb84 100644
--- a/drivers/net/wireless/realtek/rtw89/pci.h
+++ b/drivers/net/wireless/realtek/rtw89/pci.h
@@ -1276,6 +1276,8 @@ struct rtw89_pci_gen_def {
 	void (*aspm_set)(struct rtw89_dev *rtwdev, bool enable);
 	void (*clkreq_set)(struct rtw89_dev *rtwdev, bool enable);
 	void (*l1ss_set)(struct rtw89_dev *rtwdev, bool enable);
+
+	void (*power_wake)(struct rtw89_dev *rtwdev, bool pwr_up);
 };
 
 struct rtw89_pci_info {
@@ -1766,4 +1768,13 @@ static inline int rtw89_pci_poll_txdma_ch_idle(struct rtw89_dev *rtwdev)
 
 	return gen_def->poll_txdma_ch_idle(rtwdev);
 }
+
+static inline void rtw89_pci_power_wake(struct rtw89_dev *rtwdev, bool pwr_up)
+{
+	const struct rtw89_pci_info *info = rtwdev->pci_info;
+	const struct rtw89_pci_gen_def *gen_def = info->gen_def;
+
+	gen_def->power_wake(rtwdev, pwr_up);
+}
+
 #endif
diff --git a/drivers/net/wireless/realtek/rtw89/pci_be.c b/drivers/net/wireless/realtek/rtw89/pci_be.c
index 7cc328222..2f0d9ff25 100644
--- a/drivers/net/wireless/realtek/rtw89/pci_be.c
+++ b/drivers/net/wireless/realtek/rtw89/pci_be.c
@@ -614,5 +614,7 @@ const struct rtw89_pci_gen_def rtw89_pci_gen_be = {
 	.aspm_set = rtw89_pci_aspm_set_be,
 	.clkreq_set = rtw89_pci_clkreq_set_be,
 	.l1ss_set = rtw89_pci_l1ss_set_be,
+
+	.power_wake = _patch_pcie_power_wake_be,
 };
 EXPORT_SYMBOL(rtw89_pci_gen_be);
-- 
2.48.1


