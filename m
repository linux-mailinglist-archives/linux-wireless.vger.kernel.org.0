Return-Path: <linux-wireless+bounces-28238-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA7B3C08119
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Oct 2025 22:31:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1050F3B9A41
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Oct 2025 20:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FFB21F63D9;
	Fri, 24 Oct 2025 20:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UYb4K6AT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC9B82F532F
	for <linux-wireless@vger.kernel.org>; Fri, 24 Oct 2025 20:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761337866; cv=none; b=dyu6PO6vda9uMdCaVo/92PlFlhlVDpLLubMffZS0MpLZ6VkJ3xcFl8HzfQxkEa2Gw16VjKKsi+isQ5PjuMjuwAv2MrZBusfKY7JREF1Dmo1u4m7JRyK6ej/dKl62ZdWh43lornHNgo9ubAsE5EMqbaIe//GbP7lIyPO6wmVv8ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761337866; c=relaxed/simple;
	bh=xJtwGFmgtaU6iZWPKPQwz0rRnnmShy5v7UuQ8AmKrW8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZCJC7he1yJQkij94ghNma+5I0by1qYBSba/Llig/v6TNH7a1Y4UI9rLVr9QcJoNPU5r7w3fOmKNRxGXR7HSTQymLal5C6A9ccHIumqBk0LcXS+X6wZoGQg0AWP+HiEZPUbpwhKQN8id93TydkOp8GIG819zNkQ8xGJ/Wbg9IL2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UYb4K6AT; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-781206cce18so2649176b3a.0
        for <linux-wireless@vger.kernel.org>; Fri, 24 Oct 2025 13:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761337864; x=1761942664; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=V5tOUaj5VV1BEYhc/rWHWJcsKQ0Ib+ABYORFUkcDOxk=;
        b=UYb4K6ATI2oYlzgpCr3sPw133dpRvDGAD1BD5Pjl5rKCgDDDy1kKCNlLSawqhqux1k
         K56HedUowwBt/Vhw0VLIf+TmRTpQItOoGmkkG4mRCMIXxwkHasHKGnc7iExsWhiYzz+6
         KUxe8oxiyBSi12NcPWa3VZKg3qIhBvEHWtu/+U9W3BT/YNduCfiJueHgH5StGTCb5zcy
         h8U83kx0PamaUccO3u5IRwXOhyuKjsAIHfypZSbKjyW2OK4o9H7pYxStPTjGwRxNw7V2
         v0v6VEn27gxrrX7fV9fXM5EmtM/o07qcjFpOgieRFHKq9y8lVewPuyc7N8ej7VI/7COV
         uMQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761337864; x=1761942664;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V5tOUaj5VV1BEYhc/rWHWJcsKQ0Ib+ABYORFUkcDOxk=;
        b=lBE6XCDj+4lm2hkESnuSj1a3zc6qqctwDBXhcen9TWI14XntJTPT6KT5LmTPAZK7fw
         ojgUw2WTmQjRtFc94RpcbCOy47SVJp2+et3eeBUAFdOHyrIvY4/vy3bieruHtZ2oSTbp
         1zpib9Is8QZCXD3sdIX17toYKuuPd6SEX+PF3ymkOfCi8KiDZ7l158P6m57INa1FZR/R
         0KWiaRbLgWAwZsBfOpIsVz+MYsE1v8kLOfKfTtN/MzWlSc0aYHj1mU7AoJhlj3ryq23c
         ATz1x2UbhOWklVU9+x3WlyzcsowriH6kv4BuVuP4ZG73KITOr44oKqCrbluzF2iKqFE+
         4Z+g==
X-Gm-Message-State: AOJu0YwTW7z3B7Mm0eyORXPAArQjHFemsdcQylgN/R2Vs0kfbpvFVz+I
	QICWyNcYczxJrb8Qc5h4WHP/p6kNnY+HS0OI/i32/+ckvUzqfaCX2ENj/pBVgA==
X-Gm-Gg: ASbGncvyFsp5LCFtveC2eqOHtFN32CsImtc62zHahfE0ZDFdatS5PuW+wlxrvf/IjZ0
	HDXpQNQ7h05buml3nFPfEcQbkon+vAXQ2q9JiS0jtMZJXw0raw4pIOS2KULvuaUN95qWm2+sPlB
	5Iu7PVzjiEsf6kO98Tp8hJ5YOoh7Ne2mbncepb6RHWxOFUUVaxqziPKMnZe6zAg+2GVQWFQc2Wh
	sCrATunGOqpqlguCxZE0pvB9amgHJLbtoWOfuBt+YT0KL9NGyr//u1QxzH38qhYdSpvTAVtFPxv
	mNQeouftzZAtOGbzX+qzFNfYN962+mIA1jEGgN2tYxE8qGrk47di7Ds7VwUCj7Vq9iqdeArKB12
	+U4mhUuK0BYtPdzoU3Vdp8RllcOIaMc2gwn+BRwE2FgbAWuDdtTIzmaPiikZUEx0m+6bqQ2iYfR
	ITaphei3KjKWlyLzCCo1DvBYi2cyETPOAf
X-Google-Smtp-Source: AGHT+IGVhdsP8QTOQ18jvLJ4RAz9BWt5s+cwCt2z98ZkChyhoIbvucYAMe2Lu+MzsPCuii/xH164Fg==
X-Received: by 2002:a05:6a00:2c4:b0:78a:f4e6:847f with SMTP id d2e1a72fcca58-7a284c4bb71mr3428596b3a.6.1761337863656;
        Fri, 24 Oct 2025 13:31:03 -0700 (PDT)
Received: from ryzen ([2601:644:8000:8e26::ea0])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a414068cdcsm98552b3a.47.2025.10.24.13.31.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 13:31:03 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: Stanislaw Gruszka <stf_xl@wp.pl>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] wifi: rt2x00: add nvmem eeprom support
Date: Fri, 24 Oct 2025 13:30:46 -0700
Message-ID: <20251024203046.42275-1-rosenp@gmail.com>
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
 .../net/wireless/ralink/rt2x00/rt2800lib.c    | 31 +++++++++++++++++++
 .../net/wireless/ralink/rt2x00/rt2800lib.h    |  2 ++
 .../net/wireless/ralink/rt2x00/rt2800pci.c    |  3 ++
 .../net/wireless/ralink/rt2x00/rt2800soc.c    |  6 +++-
 4 files changed, 41 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ralink/rt2x00/rt2800lib.c b/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
index af19153697ed..f0d8b5140e1a 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
@@ -24,6 +24,7 @@
 #include <linux/clk.h>
 #include <linux/crc-ccitt.h>
 #include <linux/module.h>
+#include <linux/nvmem-consumer.h>
 
 #include "rt2x00.h"
 #include "rt2800lib.h"
@@ -10961,6 +10962,36 @@ int rt2800_read_eeprom_efuse(struct rt2x00_dev *rt2x00dev)
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
index 8c2e7b388832..c7b853195722 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2800pci.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt2800pci.c
@@ -274,6 +274,9 @@ static int rt2800pci_read_eeprom(struct rt2x00_dev *rt2x00dev)
 {
 	int retval;
 
+	if (!rt2800_read_eeprom_nvmem(rt2x00dev))
+		return 0;
+
 	if (rt2800pci_efuse_detect(rt2x00dev))
 		retval = rt2800pci_read_eeprom_efuse(rt2x00dev);
 	else
diff --git a/drivers/net/wireless/ralink/rt2x00/rt2800soc.c b/drivers/net/wireless/ralink/rt2x00/rt2800soc.c
index 24549072e324..4952afe02b62 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2800soc.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt2800soc.c
@@ -89,8 +89,12 @@ static int rt2800soc_set_device_state(struct rt2x00_dev *rt2x00dev,
 
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


