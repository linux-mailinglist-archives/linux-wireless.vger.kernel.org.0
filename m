Return-Path: <linux-wireless+bounces-21722-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 52605A93835
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Apr 2025 16:07:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2D9D8A59E5
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Apr 2025 14:06:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1001514A4CC;
	Fri, 18 Apr 2025 14:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jWI6/vnw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39A3813C914
	for <linux-wireless@vger.kernel.org>; Fri, 18 Apr 2025 14:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744985216; cv=none; b=Mp8vwLgTh2Tt+fxD58SBEFCc2YLnTTscr6eO/yNut49LkfbB5mdbYGXApC0UFuMMjdqhHLDfVaIrQpzK0BXDVTM1MOvs1TUmJgn3nZeyp0lZSR7Z11LH2EAd3HDKbnNjUiK4cDpn5j4lkZnIOC53Ay+R0j+Rq7WaOve801/nko0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744985216; c=relaxed/simple;
	bh=bzYPuHK+KivxQVwm2kxzNynQEE0Z0aBgCwxlsILMrps=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j8agQWOUTENm1LTZF9NFF1VEMzrAXbgS/5E4z0n/1TgBkgZytcopbnwbvqxXEW5ndMNZMltD/MSGTZ502WQtFasJsEDMdpBud1R0jC+XiHBN1/nRC3QmlVBdIfHj9SIeBk/bjYnnS6ZlUVB+i7/fkjxO2/l36+2ksORtrRmOwPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jWI6/vnw; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5e5c7d6b96fso3364533a12.3
        for <linux-wireless@vger.kernel.org>; Fri, 18 Apr 2025 07:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744985213; x=1745590013; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/lIZ3DxOqAfiCoTGTDWuyCsbkyBpOz9PRNe6OKoePbY=;
        b=jWI6/vnwofGaSeqK2TorCWGbYHEpGAUtKFvgLpgFqFNCl196PG4M22MLT/7dR8/E5x
         sSVg87pRxVYhlkV96jkzPskilWXTLz0cymrM/r9speRiic+eEmDJX6o9etcF0BTvQa6n
         3bKFKJVDc25YyJgZ2ZVbpaRQLyT/SoY6qpETK9+yvLthxGiz8H2CGNjhs/c6ho6BC8pY
         2V7QTQLF6VHPOhYxAqgKfQD9Dd+WYrMatpzF97iHc+L8WmG/jcryyL/fNInGFh+dYNR6
         pj8hGkxn7+QFpc9dzXa2fe/2BHFIZJBfTOtCvVjKIBaZWxfsI0VS4TOHCWHzTHTX8fUe
         RVUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744985213; x=1745590013;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/lIZ3DxOqAfiCoTGTDWuyCsbkyBpOz9PRNe6OKoePbY=;
        b=TWgT44B69j8JYMCYoC4y0BSafSXQCmHRlJsfmkViFSKiu12SUldTZtf+ihOKd5+joY
         aRKz68qK9KLEs1Pd59LcimHbVqcmYf2RTWsjNEeTJC9Zr7KqoPWqzqMLKTHsn5aCnfpN
         4cAoF5toHxyKSLNDYp+wy1LtO5eps4d1jRfqN361hFTT1L9c8jpgjMm1ZKBsAMRHSG+6
         PcfsLvHbScQ8QYtGMMZdf8hfWpDb5LPJOzxQYQi+72NyZEqcOiAY0xcuoDgHinXiV78q
         Cssq4u5X9pceB+ZrH648c9o6h9ynigATgGa42ZElD5aCUt6xuDvPvK5Gv9OAErKYCdJe
         +gtA==
X-Gm-Message-State: AOJu0Yx+RHVzVE7u2Pj40WFEU6u8HCX20uqpOUEq8wykcDaHU8ZyIFMB
	jJe07HZc+NfE+bZ6NpZ80xCyiQ8UsOkgjDvC4Tk2sWGfm7XsesEEPdp/7uQr
X-Gm-Gg: ASbGnctEjmm/FdI240Uk1oGamBsru1DauN1ENI59UjS4UerdkErqWAPlGvhDhF2jSNt
	Friu2pzjwGgwK9dHcCFGwDNxswVi2sZldpIUPsRn+kjL9zKcnS24uIgC0XljCsUDbF3IqPxaY4J
	yOg4Jw+oXRUsUnuD0ENethehSrtUfVigm65LOqy+7FLPkAc47EIgTKwbAntwv0vHqwjUMpWG6x0
	Dxicjiel72vcLm79GYIHA2tu6v7EF1VQ2I/QbImacqwf/f5RZS8TW2bGuJeXmYbkdPJh0e4AHTi
	QsqJXvHl6BbC/bsJp0ihMuAlCkonXEpDwB0u4TQVjwCx6ywfkSOkY/w0HLFOLVebkOQB7bjUYKG
	XQOP7QtwdXw==
X-Google-Smtp-Source: AGHT+IGOi/k4ZeiKW4rZcvEqAhRbovjWJpoA5m6ijbvhURg8kW0FDSV1hUbn/2RISPZ4RGoeuXqJeQ==
X-Received: by 2002:a05:6402:2391:b0:5f6:31f3:d744 with SMTP id 4fb4d7f45d1cf-5f631f3d7aamr670645a12.11.1744985211305;
        Fri, 18 Apr 2025 07:06:51 -0700 (PDT)
Received: from systol.god.lan (157-21-254-92.ftth.glasoperator.nl. [92.254.21.157])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5f625592cffsm1004787a12.35.2025.04.18.07.06.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Apr 2025 07:06:51 -0700 (PDT)
From: Henk Vergonet <henk.vergonet@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: Felix Fietkau <nbd@nbd.name>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Henk Vergonet <henk.vergonet@gmail.com>
Subject: [PATCH] [PATCH v2] wifi: mt76x2: Add support for LiteOn WN4516R and WN4519R
Date: Fri, 18 Apr 2025 16:06:31 +0200
Message-ID: <20250418140631.31014-1-henk.vergonet@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <aAJHqxIcw6J3yWoU@lore-desk>
References: <aAJHqxIcw6J3yWoU@lore-desk>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Ads support for:
 - LiteOn WN4516R
 - LiteOn WN4519R
 Both use:
 - A nonstandard USB connector
 - Mediatek chipset MT7600U
 - ASIC revision: 76320044

Disabled VHT support on ASIC revision 76320044:

 This fixes the 5G connectibity issue on LiteOn WN4519R module
 see https://github.com/openwrt/mt76/issues/971

 And may also fix the 5G issues on the XBox One Wireless Adapter
 see https://github.com/openwrt/mt76/issues/200

 I have looked at the FCC info related to the MT7632U chip as mentioned in here:
 https://github.com/openwrt/mt76/issues/459
 These confirm the chipset does not support 'ac' mode and hence VHT should be turned of.

Signed-off-by: Henk Vergonet <henk.vergonet@gmail.com>
---
 drivers/net/wireless/mediatek/mt76/mt76x2/usb.c      |  2 ++
 drivers/net/wireless/mediatek/mt76/mt76x2/usb_init.c | 12 +++++++++++-
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76x2/usb.c b/drivers/net/wireless/mediatek/mt76/mt76x2/usb.c
index 84ef80ab4afb..96cecc576a98 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x2/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x2/usb.c
@@ -17,6 +17,8 @@ static const struct usb_device_id mt76x2u_device_table[] = {
 	{ USB_DEVICE(0x057c, 0x8503) },	/* Avm FRITZ!WLAN AC860 */
 	{ USB_DEVICE(0x7392, 0xb711) },	/* Edimax EW 7722 UAC */
 	{ USB_DEVICE(0x0e8d, 0x7632) },	/* HC-M7662BU1 */
+	{ USB_DEVICE(0x0471, 0x2126) }, /* LiteOn WN4516R module, nonstandard USB connector */
+	{ USB_DEVICE(0x0471, 0x7600) }, /* LiteOn WN4519R module, nonstandard USB connector */
 	{ USB_DEVICE(0x2c4e, 0x0103) },	/* Mercury UD13 */
 	{ USB_DEVICE(0x0846, 0x9014) },	/* Netgear WNDA3100v3 */
 	{ USB_DEVICE(0x0846, 0x9053) },	/* Netgear A6210 */
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x2/usb_init.c b/drivers/net/wireless/mediatek/mt76/mt76x2/usb_init.c
index 33a14365ec9b..eb5e957f2f1b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x2/usb_init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x2/usb_init.c
@@ -191,6 +191,7 @@ int mt76x2u_register_device(struct mt76x02_dev *dev)
 {
 	struct ieee80211_hw *hw = mt76_hw(dev);
 	struct mt76_usb *usb = &dev->mt76.usb;
+	bool vht;
 	int err;
 
 	INIT_DELAYED_WORK(&dev->cal_work, mt76x2u_phy_calibrate);
@@ -217,7 +218,16 @@ int mt76x2u_register_device(struct mt76x02_dev *dev)
 
 	/* check hw sg support in order to enable AMSDU */
 	hw->max_tx_fragments = dev->mt76.usb.sg_en ? MT_TX_SG_MAX_SIZE : 1;
-	err = mt76_register_device(&dev->mt76, true, mt76x02_rates,
+	switch (dev->mt76.rev) {
+		/* these ASIC revisions do not support VHT */
+	case 0x76320044:
+		vht = false;
+		break;
+	default:
+		vht = true;
+		break;
+	}
+	err = mt76_register_device(&dev->mt76, vht, mt76x02_rates,
 				   ARRAY_SIZE(mt76x02_rates));
 	if (err)
 		goto fail;
-- 
2.45.2


