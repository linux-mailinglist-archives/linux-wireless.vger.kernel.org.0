Return-Path: <linux-wireless+bounces-35310-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +JMVBFAb7WnefQAAu9opvQ
	(envelope-from <linux-wireless+bounces-35310-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 25 Apr 2026 21:51:44 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 870E346793D
	for <lists+linux-wireless@lfdr.de>; Sat, 25 Apr 2026 21:51:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EF5A23017392
	for <lists+linux-wireless@lfdr.de>; Sat, 25 Apr 2026 19:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A237B303A0D;
	Sat, 25 Apr 2026 19:51:35 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E997305E28
	for <linux-wireless@vger.kernel.org>; Sat, 25 Apr 2026 19:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777146695; cv=none; b=rfdpkifFsDM3TZ1Dfgrj4u68dkl5tptpsBQKfDVGW2PEWaQ1EdTnWbsFFhEoaXgnhvCbktMQEMxLvKk+zFmSF57svbXRff+IrI1nettkTNSl8H+N5cxyEijG25AMZnarhZYRsx7duhs1UPBywa1nlSHGs7F1M02KBINYZzYbIAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777146695; c=relaxed/simple;
	bh=RQ552gCa4xsmxStoR2f2na91JPiNuVbYulDQ2eosFWk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RRPqMvn7IVUPzBZ3qaVeUxce7TN/45zRI5hNgwWOcY/qe0Cn9Ycv5YtrRVSMH9OE66mxFaeP6K9NL8c58LRlVkFae8dezysOtk6hsZAr8zapOcOw3KIn7IJTd9V/zVMNp9cdo4QnE6XPjfMzEU7vc9+5RCDMJJmxhOxroYoOihA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-7dcd9061b1aso4573900a34.2
        for <linux-wireless@vger.kernel.org>; Sat, 25 Apr 2026 12:51:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777146693; x=1777751493;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gKvYGV4TMUrux9536qByVnjjRcmL717VnswYtd09SmM=;
        b=OevBe8nZcsYLBz5QshigECHS60OfxdCrK0LIoXVmegiKJk0UxWDPCqX+o8CEH/AAM2
         hPHqlohhpPoEa2FNwCeSVpM6Z/oCIlX1hlNftrEFspbseHqdhOUSyNbKXalcCLAErWkN
         k4Ah02dfm5Ol3Sdc9LUCafS0x9FT9lV/dqjpBv2mbajHgl6lLDQ53NSM7ZdTQeS7EJ+d
         BOE/K69omybExfyvIjkPCu/N1wDbDUO1yX97ZEZ0UGXOEQ8sDkfpXdZ+CIH1I6irSNEz
         lFHzFTHg5kMHiHasor2LGqt8LU5NRUmjPkjkx0+jNAPJtsvEEdm9c+nr/7GZhWYPtk6w
         Qwsg==
X-Gm-Message-State: AOJu0YxbWkpYITSLiPe/6cKyY1E2ZrE/KCOfnn0RRRggq/n9zxnRuE4e
	nqoiW0WyOZccqsgZkHgTpt4KatpZjVC7+1/9u2U1QJPkfT3XhPKRVBeC
X-Gm-Gg: AeBDiesD01/3jn54Sugu/wUVAMICJ8ZPXivMYkpU0KLoknILJRov05Z4I/+7lcw01Qy
	oVDO3diSeblrKv9/opN2im+/P6IUdjqXJZHzmDnikDsOKNjWgvZiI+rNNRyq6EHobRGaeyaWd97
	OxhCeXYe6c7aFMYTWNqNTAFKalvgVP5nVkDl68XGpHP0/v1mpvXhDztMCp9At8i4vg6bcDWanQJ
	NhBzxJ/YUNr6LkaRDwkZrAShWao14vhk1tsKCKAArxV0zP7tx+P9TX82D50LOqN075UXNhA4vb3
	oBzZpmwUknZyIdV4zEXFOK/qvPmm33vkJFe48NZjc2GPOIvF+GYslM2LRqJg5aeHL24msgN2Gcc
	hXllHRzxbQ2xIaTdMOZFbOD9ZunOrst8Gm5NkHxjM+9edALnZMAja7GK4NCzNOOmlg+Nv+NT4R9
	1HvVyqVQP2rDXhKST20zHLVQYubO2v5DPlZhuchuVCYAJNDkebzb5d91QqbLbDbmB698wIi65Nw
	Q==
X-Received: by 2002:a05:6830:4392:b0:7de:298:5332 with SMTP id 46e09a7af769-7de029856acmr10430239a34.27.1777146693226;
        Sat, 25 Apr 2026 12:51:33 -0700 (PDT)
Received: from sean-HP-EliteBook-830-G6.attlocal.net ([2600:1702:5083:7610:2e29:c3c3:de27:ce76])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7dcd164d2c3sm13987624a34.24.2026.04.25.12.51.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Apr 2026 12:51:31 -0700 (PDT)
From: Sean Wang <sean.wang@kernel.org>
To: nbd@nbd.name,
	lorenzo.bianconi@redhat.com
Cc: linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	Sean Wang <sean.wang@mediatek.com>
Subject: [PATCH v5 13/21] wifi: mt76: mt792x: add MT7927 WFSYS reset support
Date: Sat, 25 Apr 2026 14:50:03 -0500
Message-ID: <20260425195011.790265-14-sean.wang@kernel.org>
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
X-Rspamd-Queue-Id: 870E346793D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35310-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sean.wang@kernel.org,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	FROM_HAS_DN(0.00)[]

From: Sean Wang <sean.wang@mediatek.com>

Add a dedicated MT7927 WFSYS reset path in mt792x_wfsys_reset().

Unlike the existing connac2/connac3 reset flow that toggles the WFSYS
software reset bit and waits for init-done, MT7927 reset is driven
through CBInfra and requires polling ROMCODE_INDEX until the MCU returns
to the idle value after reset.

Keep this dormant for now: no MT7927 PCI IDs are added by this patch, so
it only prepares the reset logic without making the driver bind to MT7927
hardware yet.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt792x_dma.c   | 57 ++++++++++++++++++-
 .../net/wireless/mediatek/mt76/mt792x_regs.h  | 11 ++++
 2 files changed, 67 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt792x_dma.c b/drivers/net/wireless/mediatek/mt76/mt792x_dma.c
index 002aece857b2..2835bf273154 100644
--- a/drivers/net/wireless/mediatek/mt76/mt792x_dma.c
+++ b/drivers/net/wireless/mediatek/mt76/mt792x_dma.c
@@ -370,7 +370,54 @@ int mt792x_poll_rx(struct napi_struct *napi, int budget)
 }
 EXPORT_SYMBOL_GPL(mt792x_poll_rx);
 
-int mt792x_wfsys_reset(struct mt792x_dev *dev)
+static void mt7927_sema_status_read(struct mt792x_dev *dev, u32 addr)
+{
+	u32 remap;
+
+	remap = mt76_rr(dev, MT7927_PCIE2AP_REMAP_WF_0_54);
+	mt76_wr(dev, MT7927_PCIE2AP_REMAP_WF_0_54,
+		(remap & ~MT7927_PCIE2AP_REMAP_WF_0_54_MASK) |
+		MT7927_PCIE2AP_REMAP_WF_0_54_VAL);
+	usleep_range(10, 20);
+
+	mt76_rr(dev, addr);
+
+	mt76_wr(dev, MT7927_PCIE2AP_REMAP_WF_0_54, remap);
+	usleep_range(10, 20);
+}
+
+static int mt7927_wfsys_reset(struct mt792x_dev *dev)
+{
+	struct mt76_dev *mdev = &dev->mt76;
+	u32 val;
+
+	mt7927_sema_status_read(dev, MT7927_SEMA_OWN_STA);
+
+	mt76_set(dev, MT7927_CBINFRA_RGU_WF_RST,
+		 MT7927_CBINFRA_RGU_WF_RST_WF_SUBSYS);
+	usleep_range(1000, 2000);
+
+	mt76_clear(dev, MT7927_CBINFRA_RGU_WF_RST,
+		   MT7927_CBINFRA_RGU_WF_RST_WF_SUBSYS);
+	usleep_range(5000, 10000);
+
+	mt76_wr(dev, MT7927_CBINFRA_MCU_OWN_SET, BIT(0));
+
+	if (!__mt76_poll_msec(mdev, MT7927_ROMCODE_INDEX, 0xffff,
+			      MT7927_MCU_IDLE_VALUE, 200)) {
+		val = mt76_rr(dev, MT7927_ROMCODE_INDEX);
+		dev_err(mdev->dev,
+			"MT7927 WFSYS reset timeout (ROMCODE_INDEX=0x%04x)\n",
+			val & 0xffff);
+		return -ETIMEDOUT;
+	}
+
+	mt7927_sema_status_read(dev, MT7927_SEMA_OWN_STA_REP);
+
+	return 0;
+}
+
+static int mt792x_wfsys_reset_default(struct mt792x_dev *dev)
 {
 	u32 addr = is_connac2(&dev->mt76) ? 0x18000140 : 0x7c000140;
 
@@ -384,5 +431,13 @@ int mt792x_wfsys_reset(struct mt792x_dev *dev)
 
 	return 0;
 }
+
+int mt792x_wfsys_reset(struct mt792x_dev *dev)
+{
+	if (is_mt7927(&dev->mt76))
+		return mt7927_wfsys_reset(dev);
+
+	return mt792x_wfsys_reset_default(dev);
+}
 EXPORT_SYMBOL_GPL(mt792x_wfsys_reset);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt792x_regs.h b/drivers/net/wireless/mediatek/mt76/mt792x_regs.h
index 20d27ae89aca..17504ef8e80d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt792x_regs.h
+++ b/drivers/net/wireless/mediatek/mt76/mt792x_regs.h
@@ -493,4 +493,15 @@
 #define WFSYS_SW_RST_B			BIT(0)
 #define WFSYS_SW_INIT_DONE		BIT(4)
 
+/* CBInfra registers - MT7927 combo chip */
+#define MT7927_CBINFRA_RGU_WF_RST		0x1f8600
+#define MT7927_CBINFRA_RGU_WF_RST_WF_SUBSYS	BIT(4)
+#define MT7927_CBINFRA_MCU_OWN_SET		0x1f5034
+#define MT7927_ROMCODE_INDEX			0xc1604
+#define MT7927_MCU_IDLE_VALUE			0x1d1e
+#define MT7927_PCIE2AP_REMAP_WF_0_54		0x21008
+#define MT7927_PCIE2AP_REMAP_WF_0_54_MASK	GENMASK(15, 0)
+#define MT7927_PCIE2AP_REMAP_WF_0_54_VAL	0x00001807
+#define MT7927_SEMA_OWN_STA			0x40000
+#define MT7927_SEMA_OWN_STA_REP			0x40400
 #endif /* __MT792X_REGS_H */
-- 
2.43.0


