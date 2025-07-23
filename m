Return-Path: <linux-wireless+bounces-25945-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4382FB0F6D0
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Jul 2025 17:18:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C0C917DC45
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Jul 2025 15:17:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DC262E5B19;
	Wed, 23 Jul 2025 15:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KVEdQX4X"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76D6C27AC30
	for <linux-wireless@vger.kernel.org>; Wed, 23 Jul 2025 15:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753283854; cv=none; b=ui55p+YI9ZpniA8dJAfrfnHiA2LrhIUIdQaIYvUTxsQwsm79fcmLTHKRZwEPqWbpomxXrRtUlWaPyBIFgVMUckuboTysslG3LC3IHT34WeJHjkYlqFWK00YYCduBMnsQS8WZWcn7q6Oy+2+IGrxcvdZXl/4HWhxqwWwcmS1NLR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753283854; c=relaxed/simple;
	bh=MA8ZbvE1J3PPDlcH0g2YgcyEbtX84MehRZGqOnAU60M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Aewhlkc5hpz8Ytl5C6nMwJMk6bXITEwJG1FsDuurdO+O/vRAJ8PdKUk5LVX4N/Ubxy2pzKTZYKxmSSzsr/UN8iEG84HfOGbQyNndYSqrhiSXqmkxtE3sj7GPX3nWyclYgbKb/+exQR9+wzy+maLA1trIS8WSiYUv5ACJhnDs53Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KVEdQX4X; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4562977c203so2083485e9.0
        for <linux-wireless@vger.kernel.org>; Wed, 23 Jul 2025 08:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753283850; x=1753888650; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QH3Bmj1nRypEnbgaEcMRD8rwjZvZ8KOcrCvcSAcVPGM=;
        b=KVEdQX4XQy3B6s0L0yEUY3sUL6XYAUeqWZwUJgjjpEtVVodH0vQ34NicD/BCFIvPQA
         VGPtGlMF3DA96dF6mbNHv9dF3zYN/lezHoWBmMwrcixvvAo5XkKv2as6G2WGd1PxqOjN
         5HLVdjnrXZDX8qa5Id5dKoFYrIiLXsNpc1CfsWdyeiXpDKeUI1ii6OuI+0/W+/1OxO7r
         NCZ2Cod6i3Tl3XPn4j34UzrKzUVGqpPivf01u+Zw6S7eW1Anf8FMyd9jd2bZauN1OhsF
         Nov5/lUVh6mPY9X6Em+AvxF6ll2ajXQdOUW0Xi1y/ZHfbj6PHCZjRfQufYoHibi8d4VK
         nkKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753283850; x=1753888650;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QH3Bmj1nRypEnbgaEcMRD8rwjZvZ8KOcrCvcSAcVPGM=;
        b=S9E4CF34nGTZ+oFpwo2/bwyDSYU+0k3mdcsJVwZm0d/3IrfIpBXt9q3Xp1SG5vGWWx
         6hDAPcjOGbC0n09xXWC2AuVss2s/dt+1sKQxcrCWVbb3ZZUEqRRt8DYXbafhcyJVLdo2
         3NfUkLEe+36RpfbnblmYxlVg8xj6YUuWdZrFGcK0d/YiA/BDjKWt8sA4ugzsZ5anruxz
         ipISuIUMPIyWQttaNki8dXfQQtmnuMI2eV1NDXvpqeBdIaqpx5I7HsspNBDVy1u4m09G
         b55QI++I2IJbDytLK2BzewHfbyRzs9n3OIvgjCIhujjacLN0Co3Cv3nDcCg9KaZr4V3x
         E5dg==
X-Gm-Message-State: AOJu0YwM8o2wrGmw5VDMSyce7xND254ij6/vKAMJQ889NpJgZbK4R7Cd
	xwX/yohO3e+xAoEVm9/mMlizur6S0ZuA7tNM+OSb969tsYN40rEBu1UAG+DIO2gUInI=
X-Gm-Gg: ASbGnct5j+Y67RgMNFNOUsxgJQt0VR/k/TVqZwc2AaxNPn8hLu2VnkYyRUn5a6rHtHt
	P3stylQR1uJ74nenewNshPUrGvhlowHwpfkpPGYG2pxSAdHedeysl1QI6rGzeC/xn2xoNLmDYZu
	jQqBTEg5qRrYWoaGSRvRpGDcx3Ntkqhi7fyJEmHkyhh9bTLxMA6iyTJkiKZMHyycDYd+OFCEx8i
	92rGQxKYt0ktHaoqtVijWjkMSbp2fkNMABrCcEDC45m2r9hqI1g3fCgD59rMpucDQO775H/jNur
	LJDaURj3Uh8ec6iowrxsVIz4gdety0xncxYsDwWE5nIeQvd3OAyEh3An3vx8kE2HQVeRTASmub3
	VQAZKgdyJhLGihWIYQyFiYTOIt+RbIsMaSf5L0B3gVfekxJDc+iioxiTnxwxF9WgaKAC5asPjng
	==
X-Google-Smtp-Source: AGHT+IGu3VDEGCUSGNoRSVAS+Q5HQzGqJhlH9gOWUervO+NhGT1wkA/mP6f8zpUMSp1mHfuL42FsLA==
X-Received: by 2002:a05:600c:1c97:b0:453:76e2:5b16 with SMTP id 5b1f17b1804b1-4586a8ce60amr9372705e9.0.1753283850154;
        Wed, 23 Jul 2025 08:17:30 -0700 (PDT)
Received: from pop-os.localdomain (208.77.11.37.dynamic.jazztel.es. [37.11.77.208])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4586918086dsm26310805e9.6.2025.07.23.08.17.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 08:17:29 -0700 (PDT)
From: =?UTF-8?q?Miguel=20Garc=C3=ADa?= <miguelgarciaroman8@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: briannorris@chromium.org,
	johannes@sipsolutions.net,
	=?UTF-8?q?Miguel=20Garc=C3=ADa?= <miguelgarciaroman8@gmail.com>
Subject: Re: [PATCH v2] wifi: pcie: replace deprecated strcpy() with strscpy()
Date: Wed, 23 Jul 2025 17:17:18 +0200
Message-Id: <20250723151718.367623-1-miguelgarciaroman8@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <aG1lcWYjk9GARp1P@google.com>
References: <aG1lcWYjk9GARp1P@google.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Signed-off-by: Miguel García <miguelgarciaroman8@gmail.com>

v2 fixes:
 - Drop redundant comment line.
 - Restore whitespace around version/magic.
 - Use “wifi:” prefix in subject.
---
 drivers/net/wireless/marvell/mwifiex/pcie.c | 35 +++++++++++++++------
 1 file changed, 25 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/pcie.c b/drivers/net/wireless/marvell/mwifiex/pcie.c
index a760de191fce..fe93f5219a6d 100644
--- a/drivers/net/wireless/marvell/mwifiex/pcie.c
+++ b/drivers/net/wireless/marvell/mwifiex/pcie.c
@@ -3098,9 +3098,7 @@ static int mwifiex_pcie_request_irq(struct mwifiex_adapter *adapter)
 }
 
 /*
- * This function gets the firmware name for downloading by revision id
- *
- * Read revision id register to get revision id
+ * Get firmware name for download by revision ID
  */
 static void mwifiex_pcie_get_fw_name(struct mwifiex_adapter *adapter)
 {
@@ -3110,39 +3108,56 @@ static void mwifiex_pcie_get_fw_name(struct mwifiex_adapter *adapter)
 
 	switch (card->dev->device) {
 	case PCIE_DEVICE_ID_MARVELL_88W8766P:
-		strcpy(adapter->fw_name, PCIE8766_DEFAULT_FW_NAME);
+		strscpy(adapter->fw_name,
+			PCIE8766_DEFAULT_FW_NAME,
+			sizeof(adapter->fw_name));
 		break;
+
 	case PCIE_DEVICE_ID_MARVELL_88W8897:
 		mwifiex_write_reg(adapter, 0x0c58, 0x80c00000);
 		mwifiex_read_reg(adapter, 0x0c58, &revision_id);
 		revision_id &= 0xff00;
+
 		switch (revision_id) {
 		case PCIE8897_A0:
-			strcpy(adapter->fw_name, PCIE8897_A0_FW_NAME);
+			strscpy(adapter->fw_name,
+				PCIE8897_A0_FW_NAME,
+				sizeof(adapter->fw_name));
 			break;
 		case PCIE8897_B0:
-			strcpy(adapter->fw_name, PCIE8897_B0_FW_NAME);
+			strscpy(adapter->fw_name,
+				PCIE8897_B0_FW_NAME,
+				sizeof(adapter->fw_name));
 			break;
 		default:
-			strcpy(adapter->fw_name, PCIE8897_DEFAULT_FW_NAME);
-
+			strscpy(adapter->fw_name,
+				PCIE8897_DEFAULT_FW_NAME,
+				sizeof(adapter->fw_name));
 			break;
 		}
 		break;
+
 	case PCIE_DEVICE_ID_MARVELL_88W8997:
 		mwifiex_read_reg(adapter, 0x8, &revision_id);
 		mwifiex_read_reg(adapter, 0x0cd0, &version);
 		mwifiex_read_reg(adapter, 0x0cd4, &magic);
+
 		revision_id &= 0xff;
 		version &= 0x7;
 		magic &= 0xff;
+
 		if (revision_id == PCIE8997_A1 &&
 		    magic == CHIP_MAGIC_VALUE &&
 		    version == CHIP_VER_PCIEUART)
-			strcpy(adapter->fw_name, PCIEUART8997_FW_NAME_V4);
+			strscpy(adapter->fw_name,
+				PCIEUART8997_FW_NAME_V4,
+				sizeof(adapter->fw_name));
 		else
-			strcpy(adapter->fw_name, PCIEUSB8997_FW_NAME_V4);
+			strscpy(adapter->fw_name,
+				PCIEUSB8997_FW_NAME_V4,
+				sizeof(adapter->fw_name));
 		break;
+
 	default:
 		break;
 	}
-- 
2.34.1


