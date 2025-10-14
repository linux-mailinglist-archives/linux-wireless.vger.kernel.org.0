Return-Path: <linux-wireless+bounces-27966-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CAFEBD75D1
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Oct 2025 07:08:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5F1E94E65CF
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Oct 2025 05:08:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3035F1E9905;
	Tue, 14 Oct 2025 05:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BlN/OcwJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A820C75809
	for <linux-wireless@vger.kernel.org>; Tue, 14 Oct 2025 05:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760418525; cv=none; b=kaB9xDMEl7QumsjW5zOtjj24vlYUfyWtagoQ3/nULxVACKcqZze7IKvVe74SZhVHiLrGunvGfBtvvTBX9633dhJn0Ycvmqgq/Fc7f9VkW7lGL5DAC2th00hf3T9XS1VtdzjbaPpK0BsJCalLZ87cQi6r/4dY6R9Pn22D5R65mvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760418525; c=relaxed/simple;
	bh=hiNjZwxJJo1X69EqwOZbH5S5zv0mjdM4IbnMX1cmpqw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jqrzoRdFwZOBhw4q0roR/UQtYTef4aHr4kVUBkvehpy7tcqAOG3gt6Xv69uN7suZ8Y6W55k4umpcgd/c1bt04AkET1hzTys5TqabqomQhlUPTDwvzURyut4nc+Z5VNl28OBgaKPd0/i9l7DkAAdXSL5c0eTaY9SBt/Squ+S2vJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BlN/OcwJ; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-28e8c5d64d8so45218285ad.1
        for <linux-wireless@vger.kernel.org>; Mon, 13 Oct 2025 22:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760418523; x=1761023323; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=h1w46zoCvtGYydFKbWpCCDQMNSytOz7VPd57KZ8FzLk=;
        b=BlN/OcwJklROy+eTL1C+klhIc4KnqEDPEna9IrA6wQzyU7F9WYchz5BvNYWC8+sCp1
         hXZDkjCtCOO7HXJMdJwPx9bqyrysWqS4jh9NcGUI3wJtefk7n+ruJPL9Nj+Ag5mQng7f
         FotOWRq+ahjmAJb+ZF+8cMx9trRVCqtJCD/cqgVU4Q2tY15coi4A7AuOvgot67CQRD/p
         qyuEOK5up1hhHxR3dCLRwu7mVk0vJOivZ/qwh0cqCuZMVp9e2hvynHJvud1Zm4gu95Fj
         h4fWpjL61f+S5Txlks29Smm2vluPx3nB7VGxV9Vd+/pgzzNWacV734eXkkJZLwOTkL2C
         QK9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760418523; x=1761023323;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h1w46zoCvtGYydFKbWpCCDQMNSytOz7VPd57KZ8FzLk=;
        b=VTdhW4m/UCcsgdfg8QHQZ+Hg5U+8MsK5moh6YYMQb/WYZaWg25Z+07kkI376YFIyXo
         5WsEOdI80+A5xOGLdPFeAiyHUL/Wz/UjtZBSKmLWP0xi9H0RYojBbcDjYWhJlKTUPTbx
         gEe397TYZ29zoLtfQxGiaE9YFmyP2vcapY0On974RqH8Zmp8oyQMDnTOEHIzFCj+7m3Q
         NnG34bQAkeJSsmMb4huFPhelx9h3538PQsydgakFo8hiwvQiRHpGw2NUVgBfZThs6JOK
         ppiN7GT3iatB2uXpLq84W251U8+d9BJTP+MYRTfQD8G1CMtprCDdm2Nj0EIa7laFH67r
         qC4A==
X-Gm-Message-State: AOJu0YxD9fwcRCMXRsOIn0YpRnv9KHXLMRGncHVHv9YabZwQqt+IGe5/
	pMPUCGuf695jvjp0Kidc+m/cDwU945CZVPIPBLnOMbQkDFByLPqa8UoPWyteIQ==
X-Gm-Gg: ASbGnctTRJnFP/LPPLgj1T88/fMbc8sVPO2WwvegePNwWMO74eKmnjoJTQQM76MD35h
	KiPUh5KYoywXUPi/N1lL8TBLcVb7nFzsWD/EVvxz408b7KgZp3RFz9eU2xhKdyJZNoay07gHoNm
	JKIRLXfbkO2t8r9sPKkyhEWc+bqiUoD7xzZvmalq+dLbYeC6ROQsdAO9L0FYk6205ChrK2I06a6
	ID/n3Wqlju2NsG/duholwEB2+08C1xqsx6wX5sm8IeiNwKRCLabHOIjLqs04xXZoh2EdF+SZYZ/
	xCTB3qG9xwgXzjmy7G9S8DUHGmW+iupTTFTXxAuKywrEBoW3sIZsXQP4QjW6iZUKPgIBUu/oTaA
	Mm20Wt8vgWaTyTMz9bwyYk07fjUBuF0MLtzrKr2v0pAHqcaCfpsNHsT9/WsgxLIAhJfpSqJaXpA
	==
X-Google-Smtp-Source: AGHT+IFBv/pjNzRJIKP7NS0jHQ2HGYXoiDJzsM3PJZaEWiyn91ehnTTQEt42pX7up1zTubYQE+UIBA==
X-Received: by 2002:a17:903:2d0:b0:25e:78db:4a0d with SMTP id d9443c01a7336-290273eddd5mr287646635ad.36.1760418522740;
        Mon, 13 Oct 2025 22:08:42 -0700 (PDT)
Received: from ryzen ([2601:644:8200:ac2f::ea0])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29055badc54sm84752255ad.37.2025.10.13.22.08.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 22:08:42 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: Stanislaw Gruszka <stf_xl@wp.pl>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] wifi: rt2x00: check retval for of_get_mac_address
Date: Mon, 13 Oct 2025 22:08:33 -0700
Message-ID: <20251014050833.46377-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

of_get_mac_address can return -EPROBE_DEFER when nvmem is not probed yet
for whatever reason. In this case, nvmem mac assignments will not work.

Based on the function path, this change only has effect for rt2800soc.c
and rt2800pci.c. The former tends to use nvmem for assignments.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/wireless/ralink/rt2x00/rt2800lib.c |  4 +++-
 drivers/net/wireless/ralink/rt2x00/rt2x00.h    |  2 +-
 drivers/net/wireless/ralink/rt2x00/rt2x00dev.c | 10 ++++++++--
 3 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/ralink/rt2x00/rt2800lib.c b/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
index b312b40f4aa3..af19153697ed 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
@@ -11010,7 +11010,9 @@ static int rt2800_validate_eeprom(struct rt2x00_dev *rt2x00dev)
 	 * Start validation of the data that has been read.
 	 */
 	mac = rt2800_eeprom_addr(rt2x00dev, EEPROM_MAC_ADDR_0);
-	rt2x00lib_set_mac_address(rt2x00dev, mac);
+	retval = rt2x00lib_set_mac_address(rt2x00dev, mac);
+	if (retval)
+		return retval;
 
 	word = rt2800_eeprom_read(rt2x00dev, EEPROM_NIC_CONF0);
 	if (word == 0xffff) {
diff --git a/drivers/net/wireless/ralink/rt2x00/rt2x00.h b/drivers/net/wireless/ralink/rt2x00/rt2x00.h
index 0b67b09695b6..4d6437deaa9a 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2x00.h
+++ b/drivers/net/wireless/ralink/rt2x00/rt2x00.h
@@ -1416,7 +1416,7 @@ static inline void rt2x00debug_dump_frame(struct rt2x00_dev *rt2x00dev,
  */
 u32 rt2x00lib_get_bssidx(struct rt2x00_dev *rt2x00dev,
 			 struct ieee80211_vif *vif);
-void rt2x00lib_set_mac_address(struct rt2x00_dev *rt2x00dev, u8 *eeprom_mac_addr);
+int rt2x00lib_set_mac_address(struct rt2x00_dev *rt2x00dev, u8 *eeprom_mac_addr);
 
 /*
  * Interrupt context handlers.
diff --git a/drivers/net/wireless/ralink/rt2x00/rt2x00dev.c b/drivers/net/wireless/ralink/rt2x00/rt2x00dev.c
index ee667e1a7937..4af132acadb6 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2x00dev.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt2x00dev.c
@@ -984,14 +984,20 @@ static void rt2x00lib_rate(struct ieee80211_rate *entry,
 		entry->flags |= IEEE80211_RATE_SHORT_PREAMBLE;
 }
 
-void rt2x00lib_set_mac_address(struct rt2x00_dev *rt2x00dev, u8 *eeprom_mac_addr)
+int rt2x00lib_set_mac_address(struct rt2x00_dev *rt2x00dev, u8 *eeprom_mac_addr)
 {
-	of_get_mac_address(rt2x00dev->dev->of_node, eeprom_mac_addr);
+	int ret;
+
+	ret = of_get_mac_address(rt2x00dev->dev->of_node, eeprom_mac_addr);
+	if (ret == -EPROBE_DEFER)
+		return ret;
 
 	if (!is_valid_ether_addr(eeprom_mac_addr)) {
 		eth_random_addr(eeprom_mac_addr);
 		rt2x00_eeprom_dbg(rt2x00dev, "MAC: %pM\n", eeprom_mac_addr);
 	}
+
+	return 0;
 }
 EXPORT_SYMBOL_GPL(rt2x00lib_set_mac_address);
 
-- 
2.51.0


