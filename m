Return-Path: <linux-wireless+bounces-26545-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C4254B309A4
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Aug 2025 00:53:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6EC20188A922
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Aug 2025 22:52:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC920258EFF;
	Thu, 21 Aug 2025 22:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T1ZogwSh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50E46A95E;
	Thu, 21 Aug 2025 22:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755816703; cv=none; b=WUk2aOlgef4iR3DXwhdqTcMXncssVDkGHkLOtludNuHdvga8BvCaRNhC2+dBQfuIjHIxLmpeWiSKSfSWuQhjLc2IjnLsO6CLbRnHBM1rrQRMbiUS3U7Xot4L+ZpFNBSV+zny1kx1aiybAhzD2aLpTx+Wl5hmcJeGQppKDVTeB+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755816703; c=relaxed/simple;
	bh=anQYtBR5+bsy67FFvTO7bcxuRFhwqvOVxwbIOeiRYUc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rvW+g+gS04FCouejWiyZopiYtKtoCtgEunMoq741SfKtWWRdOY155HnkiliDVlT8+4NdGALgopyPHixHcbDsRGWfcVvpRtbe8qJ3C7gKrOZZzlQdpBYRNX55rA6FaUDpgQvLG/k5WpIZGFN+I/LLduRBet9GEjrWI2YKixA0/jQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T1ZogwSh; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-76e2eb09041so1496258b3a.3;
        Thu, 21 Aug 2025 15:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755816701; x=1756421501; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JUhh1GmJ/Qz4pdwg/lcXmQC+CMN2oEjdZQxpe97lNUE=;
        b=T1ZogwShJz3kJHBTZtuQhcYopf1eLAPUyevrifw5ZADF+e7lkOaWRTewVZ7iCCfHMP
         a89Ivjb+ee10V64XLAm8tlldwDGinAfgBrnDiI3F3G1zM7MuggWCTdVfwGrH/oxYGSic
         jCTJyjtHmmYIv3MtDOdDn9iZQT4qncOmtWGJGZzrS04zdRps+Q6PMYqgVa6N0KVE6JbB
         ZsgIUru2R7o9tsb35Ug1ELCfl65G4GuXZXIUcZEEQK0oRJscgzJsKpByCCg3oOSkhaJQ
         5TjlbLBmfl0d+6Jg9DAI20fQXegciRPPSEShog8PLMxOxGf1aen+2GfVddwWUbMAnqIg
         hWsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755816701; x=1756421501;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JUhh1GmJ/Qz4pdwg/lcXmQC+CMN2oEjdZQxpe97lNUE=;
        b=Sexu9lVHUXmdGgKXOno/YLC0kf4ar0RDbR6/9sDShym7Ta2Bk10uT3zqjtKkE8o4iQ
         h0Tl/Yvl1GTFJQLrDyeCn9aWyOIhGbUp+6gUEwI04QVXhDXll8GAZdLRrl/GXmhmRGhA
         fRhM2hzrVmXUVcNOsexOk+8zohwbYRQyHY1UwCRAAof8EVbZDCFDVUoEPCgi6lh8onGO
         nD562dTyh3G2a5aI8YEYU8AV/rEEoqgCFrWPgozK6MtgpPNEkU84lB8nr+R3KrCxtNaO
         yqaqTPJ9kRncPfTlxdL/zqsEq/sd8BTAIwFM1lKsUIKcEhS5R+5PsOvxiZOUr4UhkLZf
         X2bQ==
X-Forwarded-Encrypted: i=1; AJvYcCVVTqlPjDuJyW2T1YGVUI3qy2C+/3XtTBw197kwZEK6ZNa9OchBdLcMkcBK8cFR8t5ek6mX+uEZyIiGY6Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmeE++gA2cLLYBuEZwSbzvVXWe/B93A3cV+CQpsTgXyaTDNme+
	NKw3EOv6i2pN5S/eQun1hOMs3GYiU0cxAXH3enNhpRQoRH1oAPTQED8z4JZUdA==
X-Gm-Gg: ASbGncsWXra+NOidSUXqLR+T5JTBmzz4z8i7OPv4UggtCHdKhutLz4LBdSISNi4MVJb
	j7Msr76zhm42D7UiyyrgQ7vtXbyokjRvDiOebB4JQwDHBXe5hePBbylRGwfMSlMIirR9QDapMz2
	8qEnj96j+ivsagCdyTtswLk3uELM0eoG6LPh+u+v1TtuYMERWwes4aDpAGps1n3Kq8vwsvUhkgi
	Kv3KvqIf7G4d+lQhQ+XrUgWhRdtAhjRU6wDlwHlEZeJIbG0FHeXBToSr/7mWATQ5acJoDZfZxsy
	SnDuhxxDXLPax3vsbIV5FeL6/ouG0r6pBsa9huhl9+9g+xLWwTge16VwRHlwp9kWUVVIiYcTLLf
	JzmyiWKHUQVySlnS3McXFFneDyubCEDvlKiHmkxBX+ZnWZGJcYrCdJ214wtKI8jSRPw==
X-Google-Smtp-Source: AGHT+IG+QlQjFX8nkVvH2M+ceOt5Hv2iyijKCoDiRbPdSbx0nl//cWPaD1uxBCWuti5JxURT/oNeqg==
X-Received: by 2002:a05:6a20:430b:b0:23d:54bd:92e6 with SMTP id adf61e73a8af0-24340d02428mr1134160637.29.1755816701292;
        Thu, 21 Aug 2025 15:51:41 -0700 (PDT)
Received: from archlinux.lan ([2601:644:8200:acc7::1f6])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b47640905aasm5600231a12.28.2025.08.21.15.51.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 15:51:40 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: Jeff Johnson <jjohnson@kernel.org>,
	miquel.raynal@bootlin.com,
	vasanthakumar.thiagarajan@oss.qualcomm.com,
	ath10k@lists.infradead.org (open list:QUALCOMM ATHEROS ATH10K WIRELESS DRIVER),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCHv3 ath-next] wifi: ath10k: add nvmem support for mac address
Date: Thu, 21 Aug 2025 15:51:39 -0700
Message-ID: <20250821225139.15406-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

device_get_mac_address is a generic way to get the MAC address which
lacks NVMEM support, which tends to be used on embedded platforms.

of_get_mac_address has NVMEM support and handles most of what
device_get_mac_address does. The only thing missing is ACPI which is not
used to store MAC addresses for ath10k chips.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 v2: keep device_get_mac_address and use of_get_mac_address_nvmem
 v3: back to of_get_mac_address
 drivers/net/wireless/ath/ath10k/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath10k/core.c b/drivers/net/wireless/ath/ath10k/core.c
index 6f78f1752cd6..2bf7a141d8c7 100644
--- a/drivers/net/wireless/ath/ath10k/core.c
+++ b/drivers/net/wireless/ath/ath10k/core.c
@@ -11,6 +11,7 @@
 #include <linux/module.h>
 #include <linux/firmware.h>
 #include <linux/of.h>
+#include <linux/of_net.h>
 #include <linux/property.h>
 #include <linux/dmi.h>
 #include <linux/ctype.h>
@@ -3456,7 +3457,7 @@ static int ath10k_core_probe_fw(struct ath10k *ar)
 		ath10k_debug_print_board_info(ar);
 	}
 
-	device_get_mac_address(ar->dev, ar->mac_addr);
+	of_get_mac_address(ar->dev->of_node, ar->mac_addr);
 
 	ret = ath10k_core_init_firmware_features(ar);
 	if (ret) {
-- 
2.50.1


