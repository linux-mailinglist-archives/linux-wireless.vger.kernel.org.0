Return-Path: <linux-wireless+bounces-35317-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EG2ZKmwb7WnefQAAu9opvQ
	(envelope-from <linux-wireless+bounces-35317-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 25 Apr 2026 21:52:12 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F273467969
	for <lists+linux-wireless@lfdr.de>; Sat, 25 Apr 2026 21:52:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6268F302514C
	for <lists+linux-wireless@lfdr.de>; Sat, 25 Apr 2026 19:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D04C303A0D;
	Sat, 25 Apr 2026 19:52:02 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E57D43043DB
	for <linux-wireless@vger.kernel.org>; Sat, 25 Apr 2026 19:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777146722; cv=none; b=L251g1k1mddIbkOFFFbYMaEghxOSs1tnvG+1+recSEMmp8n07wgkchtgdTeRnTVmEFfneNKKk6e9J7ag2WwxG5SfbITikMWg/qJulh/Ug3sJpU+Z9gTpyWSqkq+6p3HwxJ6aPT25GppULpslvcu5HdiniPvd+gD40HIqHFf7M0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777146722; c=relaxed/simple;
	bh=qzOEeCBTyZMw4gqvcCB8EgzIG3HUyGXbIOAE3AQhyR8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d7lFI0Ej1Ac024cXSSzsnMeo14Dtk2Kygp+RJw/K591PUf70gZ/aRaJ6gOri7BqXm7PYs51iKUWkwDJZJ2ezHCBZalVVcMD29T0VxU6rJDbXyOe28FIEXgCKENaXBBwUuvbpLBolPWysKRPZTPzmbB7f9lBkuL6ljzTCR1WLeOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-7d1872504cbso7660469a34.0
        for <linux-wireless@vger.kernel.org>; Sat, 25 Apr 2026 12:52:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777146720; x=1777751520;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hZVhJi8Une3Tz7psy9kzkLO8wUTe2QsM/r5CE8L6bO0=;
        b=pKe1WvYGxN9GL6dVEkXYpln1910DEkVdiSrfRLoJr6iHWeweCMLNuCVszrURR+LkTY
         OBRlSXPaKRtntsSwyMjTxf8pz2NQ+sF25G+obfZ9fM+8j4T8M0DVxrq11V+fKuJ6ZzCd
         9x8uU/3d58NKWDCfNlIRnwtG1px/fZGeRPIK7tF4hEoecFESw31C9ACshFM3W6rDr+4P
         IwOEnPhNalZ1C8VGZHp2SA7ozGK0+xcD9G1PxP6blB19PhLT2jjH0+JQxT4g+8rSH47t
         ueKIv8AII/cJICGF5JXBtCe5ym2whpYELubaw1PHOpEH65zh2XqVeIX7P7sptYQ00jAg
         as4w==
X-Gm-Message-State: AOJu0YzEz/Z3yhNc2FaxltUE2WuNo7RQZZHuRAHDtsK5soveWhS04+G7
	cHavW8iXCet97/hRS0It42Rp2BJr0PRjuq2xeD3Tzbh39gXkzw/GtGsj
X-Gm-Gg: AeBDietAaBL2T+sbwyNRWZdO6+NIcMvFZ8qzVSaO900gAPuY5rWhc2VICpYcq6uOo1t
	wVnFReCB70QIRuxKfwd/YxEQWiMP9HE/HxA4HL+HeoT4OpVFZJquWPLysCXD1CIuBng8k2UQ64z
	iZUe7QJlwxCsM/3kysj/2wZLPYJmcNLHgtZqJMYdVFFdwgQ6gneKfMcHuRW1yFhIbnnjJ6f0xID
	L6HBXAq2SKCwM7PVgH2nZgDAwHasRuNpZ6iqYpzBy+6+OidnlK0TiJ3ErBFPQwJnrwdHmGbzVTV
	v1XCzUZa1mvj1KL8sRXRg+kre52cVdGnxZtg04L+OlEWWvfkDYy93wwBEWZbVuKN0lWp6P+s6E4
	Hl/tbpRkw6seGnjMUoFoshfTUIkcAcMi0tU9p/ZRv/bJhLgyfmRDrK4uC7YA2Y3BMuDZHwx4z4a
	zVP9ABtKF/24wD597AbB6Tu5FLbrsL5ovYDPiEL5m+iDSnZ3kQAvsrRmg3b/XaIxZSN2CCzI6xp
	g==
X-Received: by 2002:a05:6830:910:b0:7d7:ec47:79f6 with SMTP id 46e09a7af769-7dc956d9a71mr20139924a34.13.1777146719977;
        Sat, 25 Apr 2026 12:51:59 -0700 (PDT)
Received: from sean-HP-EliteBook-830-G6.attlocal.net ([2600:1702:5083:7610:2e29:c3c3:de27:ce76])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7dcd164d2c3sm13987624a34.24.2026.04.25.12.51.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Apr 2026 12:51:59 -0700 (PDT)
From: Sean Wang <sean.wang@kernel.org>
To: nbd@nbd.name,
	lorenzo.bianconi@redhat.com
Cc: linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	Sean Wang <sean.wang@mediatek.com>,
	Javier Tia <floss@jetm.me>
Subject: [PATCH v5 20/21] wifi: mt76: mt7925: add MT7927 PCIe support
Date: Sat, 25 Apr 2026 14:50:10 -0500
Message-ID: <20260425195011.790265-21-sean.wang@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260425195011.790265-1-sean.wang@kernel.org>
References: <20260425195011.790265-1-sean.wang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 6F273467969
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35317-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sean.wang@kernel.org,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	FROM_HAS_DN(0.00)[]

From: Sean Wang <sean.wang@mediatek.com>

Add the missing MT7927 device support in the mt7925 PCI path.
This ensures MT7927 is identified correctly and uses the proper
initialization flow.

Co-developed-by: Javier Tia <floss@jetm.me>
Signed-off-by: Javier Tia <floss@jetm.me>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7925/pci.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/pci.c b/drivers/net/wireless/mediatek/mt76/mt7925/pci.c
index 7455cf7eddc5..41e6ec9223e9 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/pci.c
@@ -16,6 +16,12 @@ static const struct pci_device_id mt7925_pci_device_table[] = {
 		.driver_data = (kernel_ulong_t)MT7925_FIRMWARE_WM },
 	{ PCI_DEVICE(PCI_VENDOR_ID_MEDIATEK, 0x0717),
 		.driver_data = (kernel_ulong_t)MT7925_FIRMWARE_WM },
+	{ PCI_DEVICE(PCI_VENDOR_ID_MEDIATEK, 0x7927),
+		.driver_data = (kernel_ulong_t)MT7927_FIRMWARE_WM },
+	{ PCI_DEVICE(PCI_VENDOR_ID_MEDIATEK, 0x6639),
+		.driver_data = (kernel_ulong_t)MT7927_FIRMWARE_WM },
+	{ PCI_DEVICE(PCI_VENDOR_ID_MEDIATEK, 0x0738),
+		.driver_data = (kernel_ulong_t)MT7927_FIRMWARE_WM },
 	{ },
 };
 
@@ -376,7 +382,8 @@ static int mt7925_pci_probe(struct pci_dev *pdev,
 	if (ret)
 		goto err_free_pci_vec;
 
-	is_mt7927_hw = (pdev->device == 0x6639 || pdev->device == 0x7927);
+	is_mt7927_hw = (pdev->device == 0x6639 || pdev->device == 0x7927 ||
+			pdev->device == 0x0738);
 
 	/* MT7927: ASPM L1 causes unreliable WFDMA register access */
 	if (mt7925_disable_aspm || is_mt7927_hw)
@@ -436,6 +443,13 @@ static int mt7925_pci_probe(struct pci_dev *pdev,
 
 	dev_info(mdev->dev, "ASIC revision: %04x\n", mdev->rev);
 
+	if (is_mt7927_hw && mt76_chip(mdev) != 0x7927) {
+		dev_info(mdev->dev,
+			 "MT7927 raw CHIPID=0x%04x, forcing chip=0x7927\n",
+			 mt76_chip(mdev));
+		mdev->rev = (0x7927 << 16) | (mdev->rev & 0xff);
+	}
+
 	mt76_rmw_field(dev, MT_HW_EMI_CTL, MT_HW_EMI_CTL_SLPPROT_EN, 1);
 
 	ret = mt792x_wfsys_reset(dev);
-- 
2.43.0


