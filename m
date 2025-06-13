Return-Path: <linux-wireless+bounces-24085-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B349AD7FC6
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Jun 2025 02:52:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBDA73B6A20
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Jun 2025 00:52:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E2D21A08DB;
	Fri, 13 Jun 2025 00:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mMtNsi1j"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B00B1E50E;
	Fri, 13 Jun 2025 00:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749775946; cv=none; b=Bn81xjK3MX/jdmX9z/Tz5lmIIh1c3WZN5/Oq7pqzTrO1jl+UlkZaiHscak/WyG7nDI6YACPRT5+m4JYniLPCBMsqVnNaYMIRe3ck0t1j3W5EqLjVnjR+tvQhZvECm9j3NJnd31WpfAk/mUmC7wGrfCguw4Kc7h2ss6SCFxMgkr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749775946; c=relaxed/simple;
	bh=zYnEt50T6HH6yXctm14L1LYMIn+qqVY7N987qbg5Y2U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VroWaDWHN1HU/pNbabmphfLHifmf3aW/w61rjPRbWCFrUNS8t2E0Dg4tS35ML/IvFKGVQBySf3Du1+UYp9C3/wDb2dQRZBTW5l1boJenclMflnyWyw3us3BPM/N3UsDQFWknw/Ie3cLbRc8y4qF0kYVr/mNXQ2HkkrLNlevUEHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mMtNsi1j; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2352400344aso15093875ad.2;
        Thu, 12 Jun 2025 17:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749775944; x=1750380744; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Vs8aFDDa/6pS7nm7uFvj1j/mB5OzAhtsWOm1HgHPobg=;
        b=mMtNsi1j2Ndwqv7XxPBjw3W8/lP/HL0D7/cWh//3IjqlGApqFLE1PVCOOIRZAzcr6Y
         g6sNSNTxd16VqQc3xaoRp/D83c/GFaLg/Vw6tG3kPFyZuEBEAX6m5P9AbGpgGVw0UcGk
         mLwmzfhKRBfj9/ts9uI4l7kUxCKvbEMDpTpvjptQfPpmgCO9kJYh4b44LKo/6AlH/00r
         cpzlB0CTNVZfHdmT1QPSWbYUGd/pE800V0MQJo9fZXNn/DXI6YjIOgtNAPKV4mSfrssm
         MbvJIIQX6Irlu0q3nxhjIw5kq/7ry4z/1IPadFbvy/fguHhRnmMwVtk2phvM2vLS0TwY
         CCig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749775944; x=1750380744;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Vs8aFDDa/6pS7nm7uFvj1j/mB5OzAhtsWOm1HgHPobg=;
        b=XFuOt0wFsSRKyMwAmIl8BEPTnj4zoHogwkV6Hzf3l7oLluSnqexbVN++WnjCycoqGG
         CpbQl8lBWMAiELGSY3P21njFVu3lsbZo7+NLqaZkhE197Akr1NhlyT8Ee7S3POaX33EF
         oApVy2HW5iYu+o9Oy6CH8Jx6QH/zRwjok0sJwojzkNV9pOHxYQ/8Vel6PerclbJwPzND
         p2tZBucroIt/dmNnwgyB3oOImtQWPItp3zd30JK9wGuNJK+Pt8W6VWTGzOoahBF4+LJs
         XbZjiW0Aej1Ysf9rEcRsdFWn97MQrCItxcSyy4dOEiNMYsPwJ6+RiY/sQS2ZTNX61xto
         IrVw==
X-Forwarded-Encrypted: i=1; AJvYcCWIcMVIrBYol2PcfncZMSIkQRhOKxTBccT7Td7159Wj8gXpOGYn0cTGrSktQH39ixz/B5J5I6O9bVdJG1Ym9Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YxT9gSqwk4dck6iA16rfSLkRzHy+8/slG0zll8MxCeMKLg5NiIv
	J2h+1Lcn7cZS/BjfMEUd0rY9+2LQF/Kh6REeDbb16PYSV8D6ISJ+tP8jXODsu8/e
X-Gm-Gg: ASbGncsfn5SIDq21fKcOxUS7/XbQ0v/TwQIw7zMbevOpolKQXDw9ooZ+k7bYheL5wjI
	dM29kIl6LsdinO1sJL/rwwG+iULYX5FhPQAJTh1JbjFcNigUpsxFghPioyquAegvJDW6waHtTqv
	Bf7JXYaPzZ5ak2IZctERhXGFE9rxLS14XcNnu41aLUxWSbHDxLyUSDb6bsiD5jy2Z7NWL2haEVU
	/G6Hg9xLju03i8xXsE4XOeYQraTqYCbEMn+kRE1IBaRjHRkQiKWz/hafsC1DRS82KzItsO3vS/T
	CLWlL44AZf3bobc02ddkb6qDaRXA+xvy8YKFqBn8P+kJWHuQjGX2DweWoNnNrNOm4q+ythdm3Mf
	QpPdjNf4FnutcvJkuDLl+rT/rCRcstrq/FruE
X-Google-Smtp-Source: AGHT+IEtoe5vHbBt2WbXNyPZhE8AKhdqj1K6DasQKeIxnxdt7FVU0e1I2peb55IXVOZ27WRtFplSUA==
X-Received: by 2002:a17:903:1b6b:b0:223:65dc:4580 with SMTP id d9443c01a7336-2365de4ae41mr14756705ad.52.1749775943557;
        Thu, 12 Jun 2025 17:52:23 -0700 (PDT)
Received: from localhost.localdomain (118-232-8-190.dynamic.kbronet.com.tw. [118.232.8.190])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-2365deb049asm3351015ad.182.2025.06.12.17.52.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jun 2025 17:52:23 -0700 (PDT)
From: Zenm Chen <zenmchen@gmail.com>
To: stable@vger.kernel.org
Cc: pkshih@realtek.com,
	zenmchen@gmail.com,
	linux-wireless@vger.kernel.org
Subject: [PATCH 6.6.y] wifi: rtw89: pci: use DBI function for 8852AE/8852BE/8851BE
Date: Fri, 13 Jun 2025 08:52:19 +0800
Message-ID: <20250613005219.3408-1-zenmchen@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chin-Yen Lee <timlee@realtek.com>

[ Upstream commit 9496d62f3877bc0f97b415bc04af98d092878026 ]

Sometimes driver can't use kernel API pci_read/write_config_byte
to access the PCI config space of above address 0x100 due to
the negotiated PCI setting. 8852AE/8852BE/8851BE provide another
way called DBI function, which belongs to WiFi mac and could
access all PCI config space for this case.

Link: https://lore.kernel.org/linux-wireless/79fe81b7db7148b9a7da2353c16d70fb@realtek.com/T/#t
Signed-off-by: Chin-Yen Lee <timlee@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
Signed-off-by: Kalle Valo <kvalo@kernel.org>
Link: https://msgid.link/20240103012346.6822-1-pkshih@realtek.com
Signed-off-by: Zenm Chen <zenmchen@gmail.com>
---
Without this patch applied, the rtw89 driver in kernel 6.6.y may fail to 
initialize the RTL8852BE chip and print the error messages below on
some platforms [1].

[ 13.449168] rtw89_8852be_git 0000:02:00.0: [ERR]pci config read 719
[ 13.449754] rtw89_8852be_git 0000:02:00.0: [ERR] pcie autok fail -22
[ 13.450353] rtw89_8852be_git 0000:02:00.0: failed to setup chip information
[ 13.455857] rtw89_8852be_git: probe of 0000:02:00.0 failed with error -22

[1] https://github.com/a5a5aa555oo/rtw89/issues/3

---
 drivers/net/wireless/realtek/rtw89/pci.c | 69 +++++++++++++++++++++++-
 drivers/net/wireless/realtek/rtw89/pci.h |  1 +
 2 files changed, 68 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/pci.c b/drivers/net/wireless/realtek/rtw89/pci.c
index 30cc6e03c..33b2543ee 100644
--- a/drivers/net/wireless/realtek/rtw89/pci.c
+++ b/drivers/net/wireless/realtek/rtw89/pci.c
@@ -1822,22 +1822,87 @@ static int rtw89_write16_mdio_clr(struct rtw89_dev *rtwdev, u8 addr, u16 mask, u
 	return 0;
 }
 
+static int rtw89_dbi_write8(struct rtw89_dev *rtwdev, u16 addr, u8 data)
+{
+	u16 addr_2lsb = addr & B_AX_DBI_2LSB;
+	u16 write_addr;
+	u8 flag;
+	int ret;
+
+	write_addr = addr & B_AX_DBI_ADDR_MSK;
+	write_addr |= u16_encode_bits(BIT(addr_2lsb), B_AX_DBI_WREN_MSK);
+	rtw89_write8(rtwdev, R_AX_DBI_WDATA + addr_2lsb, data);
+	rtw89_write16(rtwdev, R_AX_DBI_FLAG, write_addr);
+	rtw89_write8(rtwdev, R_AX_DBI_FLAG + 2, B_AX_DBI_WFLAG >> 16);
+
+	ret = read_poll_timeout_atomic(rtw89_read8, flag, !flag, 10,
+				       10 * RTW89_PCI_WR_RETRY_CNT, false,
+				       rtwdev, R_AX_DBI_FLAG + 2);
+	if (ret)
+		rtw89_err(rtwdev, "failed to write DBI register, addr=0x%X\n",
+			  addr);
+
+	return ret;
+}
+
+static int rtw89_dbi_read8(struct rtw89_dev *rtwdev, u16 addr, u8 *value)
+{
+	u16 read_addr = addr & B_AX_DBI_ADDR_MSK;
+	u8 flag;
+	int ret;
+
+	rtw89_write16(rtwdev, R_AX_DBI_FLAG, read_addr);
+	rtw89_write8(rtwdev, R_AX_DBI_FLAG + 2, B_AX_DBI_RFLAG >> 16);
+
+	ret = read_poll_timeout_atomic(rtw89_read8, flag, !flag, 10,
+				       10 * RTW89_PCI_WR_RETRY_CNT, false,
+				       rtwdev, R_AX_DBI_FLAG + 2);
+	if (ret) {
+		rtw89_err(rtwdev, "failed to read DBI register, addr=0x%X\n",
+			  addr);
+		return ret;
+	}
+
+	read_addr = R_AX_DBI_RDATA + (addr & 3);
+	*value = rtw89_read8(rtwdev, read_addr);
+
+	return 0;
+}
+
 static int rtw89_pci_write_config_byte(struct rtw89_dev *rtwdev, u16 addr,
 				       u8 data)
 {
 	struct rtw89_pci *rtwpci = (struct rtw89_pci *)rtwdev->priv;
+	enum rtw89_core_chip_id chip_id = rtwdev->chip->chip_id;
 	struct pci_dev *pdev = rtwpci->pdev;
+	int ret;
+
+	ret = pci_write_config_byte(pdev, addr, data);
+	if (!ret)
+		return 0;
 
-	return pci_write_config_byte(pdev, addr, data);
+	if (chip_id == RTL8852A || chip_id == RTL8852B || chip_id == RTL8851B)
+		ret = rtw89_dbi_write8(rtwdev, addr, data);
+
+	return ret;
 }
 
 static int rtw89_pci_read_config_byte(struct rtw89_dev *rtwdev, u16 addr,
 				      u8 *value)
 {
 	struct rtw89_pci *rtwpci = (struct rtw89_pci *)rtwdev->priv;
+	enum rtw89_core_chip_id chip_id = rtwdev->chip->chip_id;
 	struct pci_dev *pdev = rtwpci->pdev;
+	int ret;
 
-	return pci_read_config_byte(pdev, addr, value);
+	ret = pci_read_config_byte(pdev, addr, value);
+	if (!ret)
+		return 0;
+
+	if (chip_id == RTL8852A || chip_id == RTL8852B || chip_id == RTL8851B)
+		ret = rtw89_dbi_read8(rtwdev, addr, value);
+
+	return ret;
 }
 
 static int rtw89_pci_config_byte_set(struct rtw89_dev *rtwdev, u16 addr,
diff --git a/drivers/net/wireless/realtek/rtw89/pci.h b/drivers/net/wireless/realtek/rtw89/pci.h
index 4259b79b1..119c0608b 100644
--- a/drivers/net/wireless/realtek/rtw89/pci.h
+++ b/drivers/net/wireless/realtek/rtw89/pci.h
@@ -42,6 +42,7 @@
 #define B_AX_DBI_WFLAG			BIT(16)
 #define B_AX_DBI_WREN_MSK		GENMASK(15, 12)
 #define B_AX_DBI_ADDR_MSK		GENMASK(11, 2)
+#define B_AX_DBI_2LSB			GENMASK(1, 0)
 #define R_AX_DBI_WDATA			0x1094
 #define R_AX_DBI_RDATA			0x1098
 
-- 
2.49.0


