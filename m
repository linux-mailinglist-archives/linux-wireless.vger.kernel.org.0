Return-Path: <linux-wireless+bounces-26487-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC4DEB2EC3A
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Aug 2025 05:41:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA7A7AA1AC5
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Aug 2025 03:39:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 621A32E03F1;
	Thu, 21 Aug 2025 03:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VsXLfTWs"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C39C61FBEA6;
	Thu, 21 Aug 2025 03:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755747552; cv=none; b=jxj2CAXPOcVFYAoj8yVqEG3dGWHyJAHE1yeRSChaBt8b7Gt5/+sAYDZvi+lvTgBnOkLP/YansiiMfv5jBaYsy8bOHjeN4vGLUUOE1yBReUs3yos1ItKZduhCZfvxWoT9mjiQYeQ/Op8+AlNkzfn9EwXA/g/CAxZQDeKhAWVro8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755747552; c=relaxed/simple;
	bh=JXIWevFOksAYag9a/xZl/nCs9ztRPXG6nzrXh7BAlRE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rlQ/GZ9QQGzuHRTTiLAPwyGcqUfnH+iPG9fTBcI+iUXRnE7KW8gVUedr/r7tuq/PVF16TyqPJxvuHMupjiKOm/jaJN+NdZzXK725DGARqMPpoGakvRVf1REEQqCrXeyuHuqNnkZHjVUuRcUufmPIb4XFPcz/Uer+D4MB/huSvcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VsXLfTWs; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-24457fe9704so4863575ad.0;
        Wed, 20 Aug 2025 20:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755747550; x=1756352350; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Z8uyqtJucGRhHAMPSIQ7cb4WnZTqHSO1ebBr3H7uCas=;
        b=VsXLfTWsYJvBU1ZGz6ne8hXs5gutupv1veVaPxZ6gx00Td3KAV9YWV3zKgX66+odoV
         ThFdVWsWLwXPm+lcOvylW9NXaIKOW9HdcgaYrdLXP8+oM6WAGRl0N2PnQZbVMqQELfqA
         8O/V1xLlH5THAR3/yaXHCIatwxfnhxXNmnvDLo5b6DSYyxIEzsPDzUabSnDPf7gPp3ML
         3v8xbZAHwVos9WHfGnUcNxNJe2KNX99t/555Ywrb26YFIwaKVDwYm33aaz0J4PEHbfJo
         Bt2bJXyjA1YTk5f1NyhGGjQKCb9cmRCkoKbF5rx/gCM4Np/++MCc4Rs84wOhSvZTNvLV
         0OJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755747550; x=1756352350;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z8uyqtJucGRhHAMPSIQ7cb4WnZTqHSO1ebBr3H7uCas=;
        b=OoO2tHDoCvmP8jEKwYyGVqRrrlbBqksWmQxOiiETfJHFJ1auoLGPxUS0FvFc/n57rE
         CsYHQiMER3iiw7oLYGxwbnj69+q3T5DTtgCE0lpQpVvuP1cRxcHvrx+Y9UYxb34xZH/f
         i3b00QiecEqbZsVUcEBalmh/akAVh4NWJuRqqyeJY8C+O6N7+Y1KM13plPT6+IiGWFPS
         XQqRshTNo40I9Zgs+LHICmBqXmaqi+5ffLEKsojw3fwLLkDKFEpROHn0PIffKHVEnAeO
         +mWSmmMK8FEbClzXIPyhWN388ypzzZ9jhriTMb/iQ2FALaAt2XEdd1UXNPycQXocwBJi
         vBtQ==
X-Forwarded-Encrypted: i=1; AJvYcCXSAK+glRByHdnuU7Jq2Gi/QiXVbhSBYJ6MIU53dfaiRHwJtjlFG7UKUytYajS3IC+peDwxm2ptGO+/j1A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyprGNlszoRCMDTh7rJs2rA1b48e82Dq9Pqnyk9wFQuAjPwZ3PC
	/0NkE3q+zI4jccpFj0vsKpg7OLrjj8M7AhfKfXkcpkT+XRjmYvXACR53FobYJQ==
X-Gm-Gg: ASbGncu6wR8/vA7xj2JX9uyTlb597cDHLqGLqGhPfBUVhhZO4uh7fHOvNkKQelngrg0
	ShMvnNXYFDejEtfHiMmSoNB3A1hWON8XgV8oyZ3LTywRaC/OfN8Qe9KKtf8DqLMwz3nDbaYQUUU
	wd/dCliUpedbC/GnDcVWo9/MYeg1Ig0NfijBrQecqfP3yAWo2P1hpV3TdGPwWs6yEyHeO4XUZK/
	xjVtO529ItZfZnT4R4/2HN6u/aZ7AAakJI6Y/qNgu+EQ1xSU9pDIQ8DPRxR8z5yZ8XYM1ZQwQfk
	/0rjyxVXOW+8BgwWk4hqPqyT+Kapc3f4NfP9dtxfTJdroTU3xB4H4GsczL5wnfdkL21lON7QZXP
	67Lfg
X-Google-Smtp-Source: AGHT+IHwuUrsCGRj99hLQ285uZapEb5o3oL6q6U0D5DJlzBFxoN/jLfLD8vBbPMDeM4DW+vxhrlf4Q==
X-Received: by 2002:a17:902:d50b:b0:242:fba2:b8e4 with SMTP id d9443c01a7336-245ff87d7cbmr15536745ad.56.1755747549584;
        Wed, 20 Aug 2025 20:39:09 -0700 (PDT)
Received: from archlinux.lan ([2601:644:8200:acc7::1f6])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e7d524c88sm6799386b3a.76.2025.08.20.20.39.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 20:39:09 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
	=?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
	Manivannan Sadhasivam <mani@kernel.org>,
	linux-kernel@vger.kernel.org (open list),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/ACTIONS SEMI ARCHITECTURE),
	linux-actions@lists.infradead.org (moderated list:ARM/ACTIONS SEMI ARCHITECTURE)
Subject: [PATCH ath-next] wifi: ath9k: simplify eeprom format strings
Date: Wed, 20 Aug 2025 20:39:08 -0700
Message-ID: <20250821033908.638871-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

devm is already used here so might as well simplify the whole function
with devm_kasprintf.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/wireless/ath/ath9k/ath9k.h                |  2 +-
 drivers/net/wireless/ath/ath9k/ath9k_pci_owl_loader.c | 11 +----------
 drivers/net/wireless/ath/ath9k/init.c                 |  7 +++----
 drivers/net/wireless/ath/ath9k/rng.c                  |  4 ++--
 4 files changed, 7 insertions(+), 17 deletions(-)

diff --git a/drivers/net/wireless/ath/ath9k/ath9k.h b/drivers/net/wireless/ath/ath9k/ath9k.h
index 6e38aa7351e3..60aac2c50409 100644
--- a/drivers/net/wireless/ath/ath9k/ath9k.h
+++ b/drivers/net/wireless/ath/ath9k/ath9k.h
@@ -1076,7 +1076,7 @@ struct ath_softc {
 #ifdef CONFIG_ATH9K_HWRNG
 	struct hwrng rng_ops;
 	u32 rng_last;
-	char rng_name[sizeof("ath9k_65535")];
+	const char *rng_name;
 #endif
 };
 
diff --git a/drivers/net/wireless/ath/ath9k/ath9k_pci_owl_loader.c b/drivers/net/wireless/ath/ath9k/ath9k_pci_owl_loader.c
index fe1013a3a588..c4f8d1f98369 100644
--- a/drivers/net/wireless/ath/ath9k/ath9k_pci_owl_loader.c
+++ b/drivers/net/wireless/ath/ath9k/ath9k_pci_owl_loader.c
@@ -140,19 +140,10 @@ static void owl_fw_cb(const struct firmware *fw, void *context)
 static const char *owl_get_eeprom_name(struct pci_dev *pdev)
 {
 	struct device *dev = &pdev->dev;
-	char *eeprom_name;
 
 	dev_dbg(dev, "using auto-generated eeprom filename\n");
 
-	eeprom_name = devm_kzalloc(dev, EEPROM_FILENAME_LEN, GFP_KERNEL);
-	if (!eeprom_name)
-		return NULL;
-
-	/* this should match the pattern used in ath9k/init.c */
-	scnprintf(eeprom_name, EEPROM_FILENAME_LEN, "ath9k-eeprom-pci-%s.bin",
-		  dev_name(dev));
-
-	return eeprom_name;
+	return devm_kasprintf(dev, GFP_KERNEL, "ath9k-eeprom-pci-%s.bin", dev_name(dev));
 }
 
 static void owl_nvmem_work(struct work_struct *work)
diff --git a/drivers/net/wireless/ath/ath9k/init.c b/drivers/net/wireless/ath/ath9k/init.c
index ee951493e993..04903b5c611f 100644
--- a/drivers/net/wireless/ath/ath9k/init.c
+++ b/drivers/net/wireless/ath/ath9k/init.c
@@ -625,7 +625,7 @@ static int ath9k_of_init(struct ath_softc *sc)
 	struct ath_hw *ah = sc->sc_ah;
 	struct ath_common *common = ath9k_hw_common(ah);
 	enum ath_bus_type bus_type = common->bus_ops->ath_bus_type;
-	char eeprom_name[100];
+	const char *eeprom_name;
 	int ret;
 
 	if (!of_device_is_available(np))
@@ -635,9 +635,8 @@ static int ath9k_of_init(struct ath_softc *sc)
 
 	if (of_property_read_bool(np, "qca,no-eeprom")) {
 		/* ath9k-eeprom-<bus>-<id>.bin */
-		scnprintf(eeprom_name, sizeof(eeprom_name),
-			  "ath9k-eeprom-%s-%s.bin",
-			  ath_bus_type_to_string(bus_type), dev_name(ah->dev));
+		eeprom_name = devm_kasprintf(ah->dev, GFP_KERNEL, "ath9k-eeprom-%s-%s.bin",
+					     ath_bus_type_to_string(bus_type), dev_name(ah->dev));
 
 		ret = ath9k_eeprom_request(sc, eeprom_name);
 		if (ret)
diff --git a/drivers/net/wireless/ath/ath9k/rng.c b/drivers/net/wireless/ath/ath9k/rng.c
index e1def77591c6..7d549d18f605 100644
--- a/drivers/net/wireless/ath/ath9k/rng.c
+++ b/drivers/net/wireless/ath/ath9k/rng.c
@@ -103,8 +103,8 @@ void ath9k_rng_start(struct ath_softc *sc)
 	if (!AR_SREV_9300_20_OR_LATER(ah))
 		return;
 
-	snprintf(sc->rng_name, sizeof(sc->rng_name), "ath9k_%u",
-		 (atomic_inc_return(&serial) - 1) & U16_MAX);
+	sc->rng_name = devm_kasprintf(sc->dev, GFP_KERNEL, "ath9k_%u",
+				      (atomic_inc_return(&serial) - 1) & U16_MAX);
 	sc->rng_ops.name = sc->rng_name;
 	sc->rng_ops.read = ath9k_rng_read;
 	sc->rng_ops.quality = 320;
-- 
2.50.1


