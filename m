Return-Path: <linux-wireless+bounces-28323-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id AD039C0FDA5
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Oct 2025 19:09:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3437E4F9E91
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Oct 2025 18:07:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C041316911;
	Mon, 27 Oct 2025 18:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G/Y5oNJn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BF9831A81C
	for <linux-wireless@vger.kernel.org>; Mon, 27 Oct 2025 18:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761588421; cv=none; b=JfORs/+kC/ym2nxiWRd+1cjbvSTCv74q59u5QO67fcV2poK2vfP6xL3tRW5tn+O0LklbPdULHABBG8eu5I/1t9EqDEz2PBa2nGflxgDqIz+1D53PFw6MmFJ8YvTtBiRSd2P/61mRGIipUEiKDjM7lBi3w3PRVqm/WwjkPfAwyvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761588421; c=relaxed/simple;
	bh=qurCehPtM9xeSnu8xN7CLjDJGyKjFe58N41J9IjlZ8k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=R1teX+aK8xjRtF7fJhRv/lVqFAiWI/HPOS2rejcXcQM8cf8JJxPfbiBaV8R9TvA5rHA62anowaPfoWgCDGI4dTWnX2dFydIZD/bumBiC/q8WRWQiRZG5ENcraoNBxYbv27Mw5Scphn1GVAGEjmw44uoWoYX4kiS1h+q1v63tLzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G/Y5oNJn; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4eb75e8e47eso56890251cf.0
        for <linux-wireless@vger.kernel.org>; Mon, 27 Oct 2025 11:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761588418; x=1762193218; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+UKcuUb7XULGoVq4L0fXwmW3xKPpWtrfaM+Kq/kuFPI=;
        b=G/Y5oNJntcFYfytKqEidSiZEeLuusWXRcAkwjAhGh47PtFcWFqTkZaDWWt+5TwLJBQ
         R6gISJ+uBx+fUllcEHlUqnG0ksOaoVNi2TeXRMmHWgh8EeGSd4Mu0yJaM5+7uq9q0Wi+
         t21XJo3h0jUVDxSneqB8I4U4iIH2ilquM2OsYFF0rjjbxXRTDgwXDm52rQe6LWRwy+Oz
         Qd8xfQslsFP/pQalACPmXKDivbqZH4wO6wl8GDUwrSkghSrMa0MiGDw7DG7ytMLi1oK7
         /mUJ6+i6K23Dc9q5piS+OUIKvPekv03EUmpFpMEJZoQzU3BiAYjR9SXB9d0GV/VfSGya
         XSbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761588418; x=1762193218;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+UKcuUb7XULGoVq4L0fXwmW3xKPpWtrfaM+Kq/kuFPI=;
        b=FgO+Vn9BhQKGBFjNNRIPwxLO7XjTRf9LjY6XBJDpLOHLLQDT36q0ep9M+u/8AJFbvX
         FbDtVrc4OIRUG29aE3lOdpzhMwiuPTMSd22fHDPhgGSQgv0HgfeHQqxfqq+UdTT9tZpT
         zwajsG8GH2MRSs0+mV7ft63Hc0mtNFIW/xAGLfcIThETupRzD7HIVqnEyDXC2tHKov5B
         jaxbG0ZIEwNFkGDoYH78myFz26USHP5lp6UHkKReKPWAUBZzmbuu3APr7FF1uJjfqRez
         usQIIP7HZxtTneK1slCJlcxvpHeITfKYEhSLoRlacbNKUYyuyIcGEhcT6c7L3z1Ew5/u
         Wusw==
X-Gm-Message-State: AOJu0YywEepqUeK8HzST4MMYvpqx8UiUCSlJom4L22WTadAEEUFgaW9p
	uozqXqQxIWqtzhS5cx/ideCzRqkXORPwZ7CsGTtnF0yhqKvR0TAw0joy6X392Q==
X-Gm-Gg: ASbGncuUEPsLfd/x9fk0ork6klYD6hcUm1/cJrhghHpXxILc63kDEit9Sux6Vwij0XD
	e/u59mOR81Nq1pYYVNlZrxwOPogTY3xXYE/w152vA+LwgD3MA3+tGAsInf5mC87Va8wyA1WmCCG
	5o/4p770mWezwvBUvLaFWes+A/b/qQk1xC2m4jNtv5PhFBvIes4vJnjdKNgxnQqXnmBWTUtPuWV
	ss3yqgHSzS14Q6kOhnl0lOLYRQrLjFpuZixU7iiU8VRq/QO+y/c89b9hUmVo/VkyISZBvG2B2VF
	0BdhLGhwnVVLHKsOMf/iggyNto63Qe+fS2AvexlMVroPZB6Ku/QHPUEzyLo0nTI9crSLqZ2y8dq
	yF7J90+spviCpF86el5vaaM31xj59rzoxYjyYhwRyeaHJ9K3W60sXN41ewQ==
X-Google-Smtp-Source: AGHT+IG1YtEHc0hSmIjWnUz0R4sCDCiHD5Zs26Y2Phxukq8yd1P1dZtt4RMgj+v3QtFQvXIQOWpK4Q==
X-Received: by 2002:a05:622a:15c3:b0:4e7:1d1d:944e with SMTP id d75a77b69052e-4ed089c22dbmr4894241cf.15.1761588418350;
        Mon, 27 Oct 2025 11:06:58 -0700 (PDT)
Received: from ryzen ([2601:644:8000:8e26::ea0])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4eba37fa7b9sm55446871cf.17.2025.10.27.11.06.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 11:06:57 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: Stanislaw Gruszka <stf_xl@wp.pl>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCHv2 wireless-next] wifi: rt2x00: add nvmem eeprom support
Date: Mon, 27 Oct 2025 11:06:38 -0700
Message-ID: <20251027180639.3797-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some embedded platforms have eeproms located in flash. Add nvmem support
to handle this. Support is added for PCI and SOC backends.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 v2: add wireless-next tag and fix the patch actually applying.
 .../net/wireless/ralink/rt2x00/rt2800lib.c    | 31 +++++++++++++++++++
 .../net/wireless/ralink/rt2x00/rt2800lib.h    |  2 ++
 .../net/wireless/ralink/rt2x00/rt2800pci.c    |  3 ++
 .../net/wireless/ralink/rt2x00/rt2800soc.c    |  6 +++-
 4 files changed, 41 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ralink/rt2x00/rt2800lib.c b/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
index f07152fa3725..65d0f805459c 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
@@ -24,6 +24,7 @@
 #include <linux/crc-ccitt.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/nvmem-consumer.h>
 #include <linux/slab.h>

 #include "rt2x00.h"
@@ -10962,6 +10963,36 @@ int rt2800_read_eeprom_efuse(struct rt2x00_dev *rt2x00dev)
 }
 EXPORT_SYMBOL_GPL(rt2800_read_eeprom_efuse);

+int rt2800_read_eeprom_nvmem(struct rt2x00_dev *rt2x00dev)
+{
+	struct device_node *np = rt2x00dev->dev->of_node;
+	unsigned int len = rt2x00dev->ops->eeprom_size;
+	struct nvmem_cell *cell;
+	const void *data;
+	size_t retlen;
+
+	cell = of_nvmem_cell_get(np, "eeprom");
+	if (IS_ERR(cell))
+		return PTR_ERR(cell);
+
+	data = nvmem_cell_read(cell, &retlen);
+	nvmem_cell_put(cell);
+
+	if (IS_ERR(data))
+		return PTR_ERR(data);
+
+	if (retlen != len) {
+		dev_err(rt2x00dev->dev, "invalid eeprom size, required: 0x%04x\n", len);
+		kfree(data);
+		return -EINVAL;
+	}
+
+	memcpy(rt2x00dev->eeprom, data, len);
+	kfree(data);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(rt2800_read_eeprom_nvmem);
+
 static u8 rt2800_get_txmixer_gain_24g(struct rt2x00_dev *rt2x00dev)
 {
 	u16 word;
diff --git a/drivers/net/wireless/ralink/rt2x00/rt2800lib.h b/drivers/net/wireless/ralink/rt2x00/rt2800lib.h
index 620a3d9872ce..a3c3a751f57e 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2800lib.h
+++ b/drivers/net/wireless/ralink/rt2x00/rt2800lib.h
@@ -248,6 +248,8 @@ void rt2800_disable_radio(struct rt2x00_dev *rt2x00dev);
 int rt2800_efuse_detect(struct rt2x00_dev *rt2x00dev);
 int rt2800_read_eeprom_efuse(struct rt2x00_dev *rt2x00dev);

+int rt2800_read_eeprom_nvmem(struct rt2x00_dev *rt2x00dev);
+
 int rt2800_probe_hw(struct rt2x00_dev *rt2x00dev);

 void rt2800_get_key_seq(struct ieee80211_hw *hw,
diff --git a/drivers/net/wireless/ralink/rt2x00/rt2800pci.c b/drivers/net/wireless/ralink/rt2x00/rt2800pci.c
index 14c45aba836f..4fa14bb573ad 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2800pci.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt2800pci.c
@@ -278,6 +278,9 @@ static int rt2800pci_read_eeprom(struct rt2x00_dev *rt2x00dev)
 {
 	int retval;

+	if (!rt2800_read_eeprom_nvmem(rt2x00dev))
+		return 0;
+
 	if (rt2800pci_efuse_detect(rt2x00dev))
 		retval = rt2800pci_read_eeprom_efuse(rt2x00dev);
 	else
diff --git a/drivers/net/wireless/ralink/rt2x00/rt2800soc.c b/drivers/net/wireless/ralink/rt2x00/rt2800soc.c
index 8f510a84e7f1..5c29201b34c8 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2800soc.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt2800soc.c
@@ -92,8 +92,12 @@ static int rt2800soc_set_device_state(struct rt2x00_dev *rt2x00dev,

 static int rt2800soc_read_eeprom(struct rt2x00_dev *rt2x00dev)
 {
-	void __iomem *base_addr = ioremap(0x1F040000, EEPROM_SIZE);
+	void __iomem *base_addr;

+	if (!rt2800_read_eeprom_nvmem(rt2x00dev))
+		return 0;
+
+	base_addr = ioremap(0x1F040000, EEPROM_SIZE);
 	if (!base_addr)
 		return -ENOMEM;

--
2.51.1


