Return-Path: <linux-wireless+bounces-20966-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D015FA75995
	for <lists+linux-wireless@lfdr.de>; Sun, 30 Mar 2025 12:32:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C476167572
	for <lists+linux-wireless@lfdr.de>; Sun, 30 Mar 2025 10:32:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A868518A92D;
	Sun, 30 Mar 2025 10:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fw9SCgHK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33E981C32;
	Sun, 30 Mar 2025 10:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743330731; cv=none; b=uVZq62WUrBjl7kQbaY0nz2SV/fgEKepsOWfaUH1jKq5q9+LvtOwlJojNv+JecUWuetZht7GDVJk3qJ6TOYPNy2MhkR2zuLxl7ec2fth1V7fxO3IlJYC8eczUr4HBd77LjbXtwMnKB7uAVMA2/4KmaZCsARN0QWv44bwT7uFbThQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743330731; c=relaxed/simple;
	bh=4CsmiRTGPgjRJkOtRLEfCjNRl+x/o92qpy4n1tthYh0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=m8i/upQ2IYBDE83RLMjrRqFh+Dklcg2WKpGsORtvkA7X92GVVWpFKJXqY+w7FB+5rmoiln89S5TkMpGYmsiAUeYIxZTqPoJ29kp5GuMdYRK2JQVT8PkEZHmJsgtT+yGp4IHIIM6DaO/DJsHbZP0rt+LHTbrCdnySYpo1fGoX6WE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fw9SCgHK; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-224100e9a5cso67672755ad.2;
        Sun, 30 Mar 2025 03:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743330729; x=1743935529; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nC8MTZbIQ3cw2rW7vnWZ7qJLnzWQzFuLM6bwSWKD7+s=;
        b=Fw9SCgHKubXVQNMgOgSJsLL07CmmFbblVNDcofl0EmV3PabKGN4WHQgiYHVfvTHPpH
         4onV02tVwr+s7sgyvT81ZTsAI/+gkx6uRVCiy79ILWpQr+yfsykRI9au/h2tMDkmcMF6
         kgaPBXQqe0EFCuR7u4253fp+HfMX9VWIUdr3BlLeYEuZCSLEukPpp3g4Z2Fxpayr2pWK
         jr2bdOUeJf87cJaC8HQ2KF8/S7aSclYsS5zhprp+36otP7WeMdN+MDBTL817Gsjg6NVA
         3Krwzk5DTZOodXm9KHnRKOXRj5Mxu2ql9AijQ41gqa/z+KIWWaRCIPSeSEgec3Cc+OyJ
         CTsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743330729; x=1743935529;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nC8MTZbIQ3cw2rW7vnWZ7qJLnzWQzFuLM6bwSWKD7+s=;
        b=W/IcvFvs7F3J6gNJtDuQUMMKmjhh++goTQI98wEwbanrZfcrqYrEw5MNlrHZXKjHbY
         ThU05FyiLfQBbntmrTNayIOCpkBgEljO7i7hqMadIFHX9FtbRZ+vagmVq13nDneaye9u
         yJjcsObft66CGhnqbfcB0G1xBXb4246fh8kCYKqh25QmE8wlXwSYafr44aIK5PDiagGy
         tjvEPmq2rf2q+K57pxSAGLR+4QA/cg+HmE2bu4zIjcBCIc3hTXGUb4DFpTgFuSFyyaqj
         RvTyQOL+3qlkqFiJXKn5nrdqu/c2fgEJuAzy9nZtsbfK8i0I38J5vP1rNrpooAQ2u2h5
         w0VA==
X-Forwarded-Encrypted: i=1; AJvYcCUK2R2uDhWL0lHCyFniMOS7DqUVcHJGePfNjMOrnWlYYpu9AlZ+VZTuS7cT1oJ/4r/zYqTz013KbxubaQ0=@vger.kernel.org, AJvYcCXQmCzD2jbNUAX0nizWIev8svq4l7iHn8yjyfCL/LUW0nTB5kcCGNJ/iMhTTXcrsIDbIgGQYxFswQLBhNNaGM4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyF4SdvzZzNGMj3yU8xOLbM03aFNQAs/1/Yta/whBnbNXPdKMxM
	N3kuDcEUN79LG7rVS96GnE7IwuYMLRW7GmBXCerbG7TDReipXlu4
X-Gm-Gg: ASbGncs+0nrroiZ4PVV16ONZXOBZYJTjedltf+jIEQZqqWeu71iMUCsxylTtzdfYANn
	LNGPiaIc5DlI/dvObaU9pyKJhfmYDv25N1lmw+XAoqkP1gPacfgQrnyFmPUU/gHt4HIYpEtdZcr
	GI5dshtF8uWMgNXxlHVbU0LatmJkA/OmPBD8fVEAhXYLWbuxXHKRE9odQrbEarP6tPQE2TPa+rt
	E1HUqH1iUsQfWwhDX4kfa5k9TjQQugN7lLgU55ELWkin4YRChQ14hZT6xdpoRdMmJhirceI39k7
	/qyZjCST12oLWIdeAV7NuLQbdm/ni92fGE4soaVAwZY+7+FUM+J09voHhi5WssloUBjnP1M=
X-Google-Smtp-Source: AGHT+IF2U0LzXGyGzaSSSOSuiBfH1sRfywjZs24Sy+5pYInOUAquWdNQ3Ifee87/AniJGorJuPkWbw==
X-Received: by 2002:a05:6a00:174b:b0:736:4d44:8b77 with SMTP id d2e1a72fcca58-7398035e5a0mr9197373b3a.8.1743330729403;
        Sun, 30 Mar 2025 03:32:09 -0700 (PDT)
Received: from localhost.localdomain ([49.37.217.226])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-73970e29377sm5111720b3a.66.2025.03.30.03.32.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Mar 2025 03:32:08 -0700 (PDT)
From: Abdun Nihaal <abdun.nihaal@gmail.com>
To: johannes@sipsolutions.net
Cc: nicolas.ferre@microchip.com,
	alexandre.belloni@bootlin.com,
	claudiu.beznea@tuxon.dev,
	erick.archer@outlook.com,
	kvalo@kernel.org,
	miriam.rachel.korenblit@intel.com,
	emmanuel.grumbach@intel.com,
	abdun.nihaal@gmail.com,
	linville@tuxdriver.com,
	khoroshilov@ispras.ru,
	linux-wireless@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] wifi: at76c50x: fix use after free access in at76_disconnect
Date: Sun, 30 Mar 2025 16:01:10 +0530
Message-ID: <20250330103110.44080-1-abdun.nihaal@gmail.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The memory pointed to by priv is freed at the end of at76_delete_device
function (using ieee80211_free_hw). But the code then accesses the udev
field of the freed object to put the USB device. This may also lead to a
memory leak of the usb device. Fix this by using udev from interface.

Fixes: 29e20aa6c6af ("at76c50x-usb: fix use after free on failure path in at76_probe()")
Signed-off-by: Abdun Nihaal <abdun.nihaal@gmail.com>
---
V1 -> V2 : Add subsystem name in commit header message

 drivers/net/wireless/atmel/at76c50x-usb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/atmel/at76c50x-usb.c b/drivers/net/wireless/atmel/at76c50x-usb.c
index 504e05ea30f2..97ea7ab0f491 100644
--- a/drivers/net/wireless/atmel/at76c50x-usb.c
+++ b/drivers/net/wireless/atmel/at76c50x-usb.c
@@ -2552,7 +2552,7 @@ static void at76_disconnect(struct usb_interface *interface)
 
 	wiphy_info(priv->hw->wiphy, "disconnecting\n");
 	at76_delete_device(priv);
-	usb_put_dev(priv->udev);
+	usb_put_dev(interface_to_usbdev(interface));
 	dev_info(&interface->dev, "disconnected\n");
 }
 
-- 
2.47.2


