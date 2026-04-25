Return-Path: <linux-wireless+bounces-35304-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GCcSIjIb7WnefQAAu9opvQ
	(envelope-from <linux-wireless+bounces-35304-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 25 Apr 2026 21:51:14 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 495ED46790B
	for <lists+linux-wireless@lfdr.de>; Sat, 25 Apr 2026 21:51:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AA1B4300101B
	for <lists+linux-wireless@lfdr.de>; Sat, 25 Apr 2026 19:51:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9457B303C83;
	Sat, 25 Apr 2026 19:51:12 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 388BB303A0D
	for <linux-wireless@vger.kernel.org>; Sat, 25 Apr 2026 19:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777146672; cv=none; b=p1YS/V6ztyUOSTqjdqreKq0uwgvX9M3pBkPDEsNPSpFGud3D9oCrLdabNnuJDBx+SczaXJSvOe+Y9J5Ox+d1VE+ljjRoqF7WWQLfbj3ZxvdIUVggRd0nPoKs9quolfwlvWXAhO25mUmTCuSviiDKy3WjTDaRQ2EjgoiEqQK3npI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777146672; c=relaxed/simple;
	bh=bTibKqV5O3nLWtZvE5K01KvjJo6Y+I8Ua7FFWoXUlHw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P2kHuP4HFwNmOzdT8rpkH6I2Z0DCSLVvgGzokw9P/oVANu9hsbhnobq7YZUTgru4irotfNKboSMfS8LvblCgsnJXI41Iyf9UO3R3hSmNSvU5BRGd2ERIQJUo0mEn6jdskxqiMe/SKWZwcsq2dFqoKgv0ELfbbp4qL89LadlR74s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7dbca22dbfeso3852231a34.1
        for <linux-wireless@vger.kernel.org>; Sat, 25 Apr 2026 12:51:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777146670; x=1777751470;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MXD39Wztx5B19vyUuBgtwPNQEXtFgeFRMISpC6sm7Hw=;
        b=UyQiFbxr0dYtHAKj7bCSKqTlUB311yrPBDgq8hXpwLTiYSWZ5WUIAZ8IIssOcu/yv0
         msFZOOxLa02gch5YI28IzfHsyftPWnd0+zoWzjTPs3d6mAlH0SWgn4A5QM6aI+z7H/K5
         S/oweo7HYpjghZIkBL3StFsBeARw79c3GeDEAqaGitSfZmHwDNY9tDhnelb1L3M3bQJX
         ueGJhtsuejwSK7B+YKi+FHxMDRBpuDOqJaNhiZAsvGwA9pSfyaPkmVb71Lwef6C+KP8w
         XNkoB4P+livYs6QFOX3Gp7gWpDPhKzhG3LLKKqdkp7QRfn+qtrFQlklzu6BQm6Csygh9
         uOaw==
X-Gm-Message-State: AOJu0YzUlFSVNXWDrG4PSnU55RDw0xJuZgX+w2v3Mk0+35p4ZtAIGaHd
	SadT01egSv6+r4S5MbRMvbsP4mjWGhKO2jT7V7oCVHg7y5DswOODOBRS
X-Gm-Gg: AeBDievV5Wb6HryntmdxO9PzjlHvGAnw1uzZozfIYawbumgq4OPX8TCeigu3MVA2SU3
	Fum3sPikUc1+w6LBnwjXewlgezYo/LbTZERF3/fEUE0EuUxyUq3KmBBaKeT+angvgRmHbLOjn98
	6+0RiyhbWbLJezXuoMUe9jx/1xAuoRlOuke2inVXfXUTF6NjA/q94QFg9FPsRFOrB0UeBdHzKw5
	LnMH/YUaoiVLmpwN9dtUfEMFcSOFMQeGo2gkSiI7SfpIEt1dvzo3mZELBX/TKjywBC5kyPkqkVD
	hL+eB01oSMoisjLrxUWno7zqlEW8jsSzhYNtXwIpmuln1vTnUw0DLcIkSLSk/ZQlas2j5hMLUGE
	OFfGboStIlkOVfy0JUe2VNb7kyuinNhEjhc24VM83Bj23ibeJDcoWi0y1CyB3AO0xb20yzFuTnF
	qhJC+HWlE/UiQS70Jy4QdUIWdR87e373Kqr6p72wGtEhzBNhOGurkafdC6PZI6pxxmYGSbEJ7GV
	Q==
X-Received: by 2002:a05:6830:668e:b0:7dc:cdea:7d9 with SMTP id 46e09a7af769-7dccdea1007mr15389398a34.22.1777146670115;
        Sat, 25 Apr 2026 12:51:10 -0700 (PDT)
Received: from sean-HP-EliteBook-830-G6.attlocal.net ([2600:1702:5083:7610:2e29:c3c3:de27:ce76])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7dcd164d2c3sm13987624a34.24.2026.04.25.12.51.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Apr 2026 12:51:09 -0700 (PDT)
From: Sean Wang <sean.wang@kernel.org>
To: nbd@nbd.name,
	lorenzo.bianconi@redhat.com
Cc: linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	Javier Tia <floss@jetm.me>,
	Marcin FM <marcin@lgic.pl>,
	Cristian-Florin Radoi <radoi.chris@gmail.com>,
	George Salukvadze <giosal90@gmail.com>,
	Evgeny Kapusta <3193631@gmail.com>,
	Samu Toljamo <samu.toljamo@gmail.com>,
	Ariel Rosenfeld <ariel.rosenfeld.750@gmail.com>,
	Chapuis Dario <chapuisdario4@gmail.com>,
	=?UTF-8?q?Thibaut=20Fran=C3=A7ois?= <tibo@humeurlibre.fr>,
	=?UTF-8?q?=E5=BC=A0=E6=97=AD=E6=B6=B5?= <Loong.0x00@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>
Subject: [PATCH v5 07/21] wifi: mt76: mt7925: add MT7927 firmware paths
Date: Sat, 25 Apr 2026 14:49:57 -0500
Message-ID: <20260425195011.790265-8-sean.wang@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260425195011.790265-1-sean.wang@kernel.org>
References: <20260425195011.790265-1-sean.wang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 495ED46790B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,jetm.me,lgic.pl,gmail.com,humeurlibre.fr,mediatek.com];
	TAGGED_FROM(0.00)[bounces-35304-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sean.wang@kernel.org,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]

From: Javier Tia <floss@jetm.me>

Add firmware path definitions for MT7927 WiFi firmware (WIFI_RAM_CODE
and PATCH_MCU) and the corresponding MODULE_FIRMWARE declarations. Add
MT7927 cases to mt792x_ram_name() and mt792x_patch_name() so the driver
loads the correct firmware for the 0x7927 chip ID.

PCI device table entries are deferred to a later patch to allow
infrastructure setup before device enablement.

Tested-by: Marcin FM <marcin@lgic.pl>
Tested-by: Cristian-Florin Radoi <radoi.chris@gmail.com>
Tested-by: George Salukvadze <giosal90@gmail.com>
Tested-by: Evgeny Kapusta <3193631@gmail.com>
Tested-by: Samu Toljamo <samu.toljamo@gmail.com>
Tested-by: Ariel Rosenfeld <ariel.rosenfeld.750@gmail.com>
Tested-by: Chapuis Dario <chapuisdario4@gmail.com>
Tested-by: Thibaut François <tibo@humeurlibre.fr>
Tested-by: 张旭涵 <Loong.0x00@gmail.com>
Reviewed-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Javier Tia <floss@jetm.me>
---
 drivers/net/wireless/mediatek/mt76/mt7925/pci.c | 2 ++
 drivers/net/wireless/mediatek/mt76/mt792x.h     | 6 ++++++
 2 files changed, 8 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/pci.c b/drivers/net/wireless/mediatek/mt76/mt7925/pci.c
index c4161754c01d..f820d5aeb723 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/pci.c
@@ -633,6 +633,8 @@ module_pci_driver(mt7925_pci_driver);
 MODULE_DEVICE_TABLE(pci, mt7925_pci_device_table);
 MODULE_FIRMWARE(MT7925_FIRMWARE_WM);
 MODULE_FIRMWARE(MT7925_ROM_PATCH);
+MODULE_FIRMWARE(MT7927_FIRMWARE_WM);
+MODULE_FIRMWARE(MT7927_ROM_PATCH);
 MODULE_AUTHOR("Deren Wu <deren.wu@mediatek.com>");
 MODULE_AUTHOR("Lorenzo Bianconi <lorenzo@kernel.org>");
 MODULE_DESCRIPTION("MediaTek MT7925E (PCIe) wireless driver");
diff --git a/drivers/net/wireless/mediatek/mt76/mt792x.h b/drivers/net/wireless/mediatek/mt76/mt792x.h
index 4ff93f2cd624..09840483fe2a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt792x.h
+++ b/drivers/net/wireless/mediatek/mt76/mt792x.h
@@ -46,12 +46,14 @@
 #define MT7921_FIRMWARE_WM	"mediatek/WIFI_RAM_CODE_MT7961_1.bin"
 #define MT7922_FIRMWARE_WM	"mediatek/WIFI_RAM_CODE_MT7922_1.bin"
 #define MT7925_FIRMWARE_WM	"mediatek/mt7925/WIFI_RAM_CODE_MT7925_1_1.bin"
+#define MT7927_FIRMWARE_WM	"mediatek/mt7927/WIFI_RAM_CODE_MT6639_2_1.bin"
 
 #define MT7902_ROM_PATCH	"mediatek/WIFI_MT7902_patch_mcu_1_1_hdr.bin"
 #define MT7920_ROM_PATCH	"mediatek/WIFI_MT7961_patch_mcu_1a_2_hdr.bin"
 #define MT7921_ROM_PATCH	"mediatek/WIFI_MT7961_patch_mcu_1_2_hdr.bin"
 #define MT7922_ROM_PATCH	"mediatek/WIFI_MT7922_patch_mcu_1_1_hdr.bin"
 #define MT7925_ROM_PATCH	"mediatek/mt7925/WIFI_MT7925_PATCH_MCU_1_1_hdr.bin"
+#define MT7927_ROM_PATCH	"mediatek/mt7927/WIFI_MT6639_PATCH_MCU_2_1_hdr.bin"
 
 #define MT792x_SDIO_HDR_TX_BYTES	GENMASK(15, 0)
 #define MT792x_SDIO_HDR_PKT_TYPE	GENMASK(17, 16)
@@ -459,6 +461,8 @@ static inline char *mt792x_ram_name(struct mt792x_dev *dev)
 		return MT7922_FIRMWARE_WM;
 	case 0x7925:
 		return MT7925_FIRMWARE_WM;
+	case 0x7927:
+		return MT7927_FIRMWARE_WM;
 	default:
 		return MT7921_FIRMWARE_WM;
 	}
@@ -475,6 +479,8 @@ static inline char *mt792x_patch_name(struct mt792x_dev *dev)
 		return MT7922_ROM_PATCH;
 	case 0x7925:
 		return MT7925_ROM_PATCH;
+	case 0x7927:
+		return MT7927_ROM_PATCH;
 	default:
 		return MT7921_ROM_PATCH;
 	}
-- 
2.43.0


