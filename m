Return-Path: <linux-wireless+bounces-30136-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A97EACDF8D9
	for <lists+linux-wireless@lfdr.de>; Sat, 27 Dec 2025 12:22:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 14FD830056C5
	for <lists+linux-wireless@lfdr.de>; Sat, 27 Dec 2025 11:22:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 914EF3126B7;
	Sat, 27 Dec 2025 11:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nf3hzGa3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FCC9275AE1
	for <linux-wireless@vger.kernel.org>; Sat, 27 Dec 2025 11:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766834547; cv=none; b=GLHCVpSVGbweY8GhAdGNQPYCFLvniYDmDogpw+axbuKoZYOOuLUvVz1Ay+hvGNbexAMhBmA8ajJuWxHfmolKyDw6mlKMLsopFo2IF8EszR/AA2nW0YOCspJJe+wR9FLo/Cbv4wjKTS6ei0NcND8P5j2ydN+WEUr7GdZ32qe+D6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766834547; c=relaxed/simple;
	bh=hJ1/Pt690VOGyijqKMuzTxghALMJw8XB3grVwRALNis=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fMeSrNkph0ck4Ma7QWsEsR7ycqiA25eBJNKtf7V2Y+Ql6eRlMDjBcM94EgrHqE8sXXbpZoDWyMnqz5qrvwwaWyEE+437rqfGE5Hk1PHbL2R96Y6TjZdDKemyWNMmmbGjkFdvG0tL70E6mqm8PURT28AVNr5Ldsp4EpWoPx18Ufk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nf3hzGa3; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-43284ed32a0so416598f8f.3
        for <linux-wireless@vger.kernel.org>; Sat, 27 Dec 2025 03:22:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766834544; x=1767439344; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=n2DCKn6B7Bg+9KQ/LRQRtOwwU8XjtNRI/VbbXHcbXNg=;
        b=nf3hzGa3nYYzQuX5ztEGK4LYnmn/fH5S+I7ukBX0HjkfxM42E5ITffL8rf+JD0Yr2T
         Ne8tngt/z62GPF8ElTnXFJVt+55C0G8qRrQqWJHbzFdTGtV0Vaqv9d51/8jpr+roQwSV
         bGrvZ3CZI86ttJOqdXDpuu8tFIR2G3TP7l8XOuYZ1ZrHBlktkBrH+RlVzN3yYlIPt5DU
         V90Ms1zdsKkJC6Y6wXWufqvsYEQoT1WIBGgwi6VcycHJJhm8QAzox2/ZZVO/q4ocQLuv
         aHZpPUmc8M2qDyHa+XlyP8w1+GCnE4Lk0YGUc2Hf2e/HVmN5cntflDSVYUQcdnI5459q
         zv6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766834544; x=1767439344;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n2DCKn6B7Bg+9KQ/LRQRtOwwU8XjtNRI/VbbXHcbXNg=;
        b=M6CRpRNoqEqh4dusSQ6h5IOaD7g9mn7OTsMvKta9ANyX35Twj69aEjEbE7qC/MLpQe
         yAFRs0GmfhtQ2hf8I3yDdkiJ7XysXqGH9mfazzks2EJjRhZZLvKpJK5VB5OGaE2rqMYI
         bcIUH3KGO2N2lK0QzTwzKD26BZry05n4oBM6b972njIfxuw0pZQK8fe3gQncX7U5defY
         IAEqWDn8wheao3sf1NkzJ+5eMVy3pNBat3bScDtITEdIyXYtGv24JCnEtfgGxbqAw6Qx
         DtFjgVFnn/dinJhBDontiVlVG6Cn609RUa8OA5Dk1u5LvGkig16HjoCuHX+hKoWw6HlK
         L/mw==
X-Forwarded-Encrypted: i=1; AJvYcCVDDe5ESgkQKbsQg5PY7QaabkEjnAwZ8vIy9cXG2LTEax624pnzhRzTeMO5Tj7EADrPvwVPP7uGZpDTaPpOpA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwnBfq7nGgDQbJf2TE6dCfMiz5zKE6hjpquGSRxkC0RJVjSmfHC
	SINDHvZKhGv2WpGYJQzm9TEn4IadvYFThgwlen6As0UHekN2CaJZowf2
X-Gm-Gg: AY/fxX4dU8PJdHWnMHN+jzKcLsH8vdLh4mNL+Uy6yQLho0S7MsajHoop9Cscd71LbIX
	sAZdLln/wP29wQ1No8aJtUoS3OnRIAkFZRM8mpDB1T+YOjD2WZGnohR/SS7Ce3kWAx6/cUFMnhC
	YdHXb55I0sWde1j0Du/NFOVne96J6QmTZqNbBbmNxuoj/qkBo+ndbHiyq/z7+IcpW3yJvsGJGld
	3tk1sTUtMasM7JKtPk/DVYeIsoeQMPiREAVoh+CMStg+nTwOYc1NFbLNZr9Wtgc3EicS1kR5VdH
	hNitWr2bMidW/hzEuOEoOALHdpWAf8ex9QpLSCFnDQFgt3LP0SDkm+UHWHNazwlQuTqNI237i74
	Q1+5Pzj3tkFMgcr06nGYCpNUyBVjzxKDVPBMKBf4BVtK+hglZu7i9/gfXHhi6lXQ215K3xaaQ+H
	GEcXFsVIdUt8PuMUk=
X-Google-Smtp-Source: AGHT+IGoRHV/ozBfOoLVpES4DLCNbHxVqZI4mSyjVxLpUFm4/9hj62ouP1sKgmo+lauX8G4qDDvyKA==
X-Received: by 2002:a05:6000:609:b0:431:342:ad41 with SMTP id ffacd0b85a97d-4324e6fa1a7mr32037027f8f.61.1766834543655;
        Sat, 27 Dec 2025 03:22:23 -0800 (PST)
Received: from toolbox.. ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324e9ba877sm49898600f8f.0.2025.12.27.03.22.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Dec 2025 03:22:23 -0800 (PST)
From: Christian Hewitt <christianshewitt@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Cc: Daniel Golle <daniel@makrotopia.org>
Subject: [PATCH v2] wifi: mt7601u: check multiple firmware paths
Date: Sat, 27 Dec 2025 11:22:19 +0000
Message-Id: <20251227112219.2768439-1-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The linux-firmware repo moved mt7601u.bin from its root folder to
the mediatek sub-folder some time ago, but the driver still tries
to load firmware from the old location. Users might have firmware
in either location so update the driver to check both.

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
The firmware was moved in [0]. Changes were requested to a previous
patch [1] to accomodate backwards compatibility but there was no
follow-up from the original author. So here's my novice attempt at
the requested improvement.

Current kernel with firmware in /usr/lib/firmware/mediatek/mt7601u.bin:

Nov 07 12:43:13.398922 LibreELEC kernel: mt7601u 1-1.3:1.0: ASIC revision: 76010001 MAC revision: 76010500
Nov 07 12:43:13.402276 LibreELEC kernel: mt7601u 1-1.3:1.0: Direct firmware load for mt7601u.bin failed with error -2
Nov 07 12:43:13.405524 LibreELEC kernel: mt7601u 1-1.3:1.0: probe with driver mt7601u failed with error -2

And with the patch:

Nov 07 12:43:13.274633 LibreELEC kernel: mt7601u 1-1.3:1.0: ASIC revision: 76010001 MAC revision: 76010500
Nov 07 12:43:13.311200 LibreELEC kernel: mt7601u 1-1.3:1.0: Firmware Version: 0.1.00 Build: 7640 Build time: 201302052146____
Nov 07 12:43:13.704693 LibreELEC kernel: mt7601u 1-1.3:1.0: EEPROM ver:0c fae:00

[0] https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git/commit/?id=8451c2b1d529dc1a49328ac9235d3cf5bb8a8fcb
[1] https://patchwork.kernel.org/project/linux-wireless/patch/fefcbf36f13873ae0d97438a0156b87e7e1ae64e.1684191377.git.daniel@makrotopia.org/

Changes since v1:
- Reword patch description and comment to make the problem clearer
- Fix checkpatch warning for static const array declaration

 drivers/net/wireless/mediatek/mt7601u/mcu.c | 15 ++++++++++++++-
 drivers/net/wireless/mediatek/mt7601u/usb.h |  1 +
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt7601u/mcu.c b/drivers/net/wireless/mediatek/mt7601u/mcu.c
index 1b5cc271a9e1..bad6ca821400 100644
--- a/drivers/net/wireless/mediatek/mt7601u/mcu.c
+++ b/drivers/net/wireless/mediatek/mt7601u/mcu.c
@@ -403,12 +403,18 @@ mt7601u_upload_firmware(struct mt7601u_dev *dev, const struct mt76_fw *fw)
 	return ret;
 }
 
+static const char * const mt7601u_fw_paths[] = {
+	"mediatek/" MT7601U_FIRMWARE,
+	MT7601U_FIRMWARE,
+};
+
 static int mt7601u_load_firmware(struct mt7601u_dev *dev)
 {
 	const struct firmware *fw;
 	const struct mt76_fw_header *hdr;
 	int len, ret;
 	u32 val;
+	int i;
 
 	mt7601u_wr(dev, MT_USB_DMA_CFG, (MT_USB_DMA_CFG_RX_BULK_EN |
 					 MT_USB_DMA_CFG_TX_BULK_EN));
@@ -416,7 +422,14 @@ static int mt7601u_load_firmware(struct mt7601u_dev *dev)
 	if (firmware_running(dev))
 		return firmware_request_cache(dev->dev, MT7601U_FIRMWARE);
 
-	ret = request_firmware(&fw, MT7601U_FIRMWARE, dev->dev);
+	/* Try loading firmware from multiple locations */
+	fw = NULL;
+	for (i = 0; i < MT7601U_FIRMWARE_PATHS; i++) {
+		ret = request_firmware(&fw, mt7601u_fw_paths[i], dev->dev);
+		if (ret == 0)
+			break;
+	}
+
 	if (ret)
 		return ret;
 
diff --git a/drivers/net/wireless/mediatek/mt7601u/usb.h b/drivers/net/wireless/mediatek/mt7601u/usb.h
index 9fdf35970339..723025f84483 100644
--- a/drivers/net/wireless/mediatek/mt7601u/usb.h
+++ b/drivers/net/wireless/mediatek/mt7601u/usb.h
@@ -9,6 +9,7 @@
 #include "mt7601u.h"
 
 #define MT7601U_FIRMWARE	"mt7601u.bin"
+#define MT7601U_FIRMWARE_PATHS	ARRAY_SIZE(mt7601u_fw_paths)
 
 #define MT_VEND_REQ_MAX_RETRY	10
 #define MT_VEND_REQ_TOUT_MS	300
-- 
2.34.1

