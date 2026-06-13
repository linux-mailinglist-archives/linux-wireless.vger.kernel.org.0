Return-Path: <linux-wireless+bounces-37776-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id EoxJDP/dLWohlwQAu9opvQ
	(envelope-from <linux-wireless+bounces-37776-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 14 Jun 2026 00:47:27 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B94AC67FF4C
	for <lists+linux-wireless@lfdr.de>; Sun, 14 Jun 2026 00:47:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37776-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37776-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3251C30054C2
	for <lists+linux-wireless@lfdr.de>; Sat, 13 Jun 2026 22:47:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1B262032D;
	Sat, 13 Jun 2026 22:47:25 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EE8E3290AF
	for <linux-wireless@vger.kernel.org>; Sat, 13 Jun 2026 22:47:24 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781390845; cv=none; b=uFSnvjnHhtZ1EHshs8+Nj8cQhBJ7sWslkeaym2M0Mql6JJq2bK+RmV/d+NHwlTn1tlLpUQb3r78HRvhJ8dQBHF6onxCXDMVT6NCt4PUSCAOpcWYoBOcRdy0GHeC0fFJZBXSrG3XNw3iJQIfz9Kf1Vsq8sh2qkKGCdYW5tnr1TJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781390845; c=relaxed/simple;
	bh=ORq2sJZ5tHptn9+4XnrSaRFDK3YU0Dh4V17qcKhgiQM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ME7YVnSopN7Hcbo+/GTbAyhYDm+nLCNNc3zwussTVPoWhCTr5HaiEy360Z6OUt6UV/NmFDfzIyjG/LSXTQ3OEbUxD5SIq5+nGTerc6BL075P3m4HM0FCLLyC2LfvNSqZNC8PUbGqM6WFKSCxn27s0c8LlWvvkixatDU3wvReZzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.82.54
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-138501f8c04so807319c88.1
        for <linux-wireless@vger.kernel.org>; Sat, 13 Jun 2026 15:47:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781390844; x=1781995644;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4LAVcEQDdglp6OEtODuDMvvqd/PwbISrhunyPv7tH68=;
        b=bnL337ZcHW6hsBhZiIw+ay6lpQ3xQoSDzLJmB4gQZO5Zusxz9julhSiKtQTIH97Mhg
         39bhyWIpfuY+runPlRSGfMFL/UoWgmhUZB1Mu0oGUfpMEJ8oiwIMFcxvBg/JfhEwk5Tu
         s/TVagFdkUHeRB8yULarm9sq0WoX3LRac+Y60NVlK7FVdlvm6WpX63yq0T+j4OtFeCVb
         R9dPAhFj/MSPm2CqVANqxvdxaBaL6VZPeEg3OPJZax3mxMpyd+3uzLLdOxluurxFDJVv
         2CxX3Nft9q8wktIVFwCXYp2zRQqFHcUV7qonzpikB4yVmLMGLsJHReN+7zLGESgIhWQ9
         bQIg==
X-Gm-Message-State: AOJu0YyHNAsxcZNK8Lwqmrbwe1p8fkWBswHjO9yfBL81LTzD8s8cmdu2
	FxZlx8cW1ZajruQPUlE1zNrze3kzLNzDdCXUMN7ez4Ynw8LlRwkD4Mhu
X-Gm-Gg: Acq92OE1evedwwPOmsoBas/oBE5o1WZbjCux6w2FxYoDt7/LiFzvjCLhUsrOEfuX4m8
	KPWvCoV7EIpeA3NqqlAltfLhQrKhJRNYHSJNY7Oz1G+zZdCzwRZG+/+LSgXsy0QHigumQ9jlhpD
	4KcOkl9G/iW2Jy441IXGbB+L7hqdmrzh2K9Kr/3Mr3wPbY3TC6/DRijNdAu+IZPclOzESaLER50
	JVLdaheosplhbVG03WVVkwZoWRbGvrxNakqmn9bBfltlkouDyrR1eqrjGWvOryoDjvH6mFvTFrO
	cqa/P28EGEuGGYmMBDw8RXzUSHXRW/Nvd5oyc8MTM7AZF2HDR84URcJrCVMKVmJ/ASbZO3cOL90
	WmxMfSh0Q/KAYwDfmU6xROhMOGIZuZzLyUzPMxUbx3zzhMLfDyJ4fwfFNw06Gqtg6pcFX/Xt9NN
	nfzNjNaX2AXxJEqE0vK+jIVm8Aw/EaAmLNtiwXgi/pXOb52prfTA6dQQEHnWH8Xy8790TWI59IB
	pQ5FZvJA2j3XKFblwgtF+dQW0OfJZjetf+etWwy
X-Received: by 2002:a05:7022:43a4:b0:138:3613:dbb with SMTP id a92af1059eb24-1386f240408mr2221497c88.5.1781390843584;
        Sat, 13 Jun 2026 15:47:23 -0700 (PDT)
Received: from sean-HP-EliteBook-830-G6.. (114-34-228-194.hinet-ip.hinet.net. [114.34.228.194])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1384b97bf09sm6345380c88.14.2026.06.13.15.47.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jun 2026 15:47:23 -0700 (PDT)
From: Sean Wang <sean.wang@kernel.org>
To: Felix Fietkau <nbd@nbd.name>,
	Lorenzo Bianconi <lorenzo@kernel.org>
Cc: linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	Sean Wang <sean.wang@mediatek.com>
Subject: [PATCH 5/5] wifi: mt76: mt7927u: enable USB RX aggregation
Date: Sat, 13 Jun 2026 17:46:55 -0500
Message-ID: <20260613224655.2405686-6-sean.wang@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260613224655.2405686-1-sean.wang@kernel.org>
References: <20260613224655.2405686-1-sean.wang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:nbd@nbd.name,m:lorenzo@kernel.org,m:linux-wireless@vger.kernel.org,m:linux-mediatek@lists.infradead.org,m:sean.wang@mediatek.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-37776-lists,linux-wireless=lfdr.de];
	FORGED_SENDER(0.00)[sean.wang@kernel.org,linux-wireless@vger.kernel.org];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[sean.wang@kernel.org,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mediatek.com:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B94AC67FF4C

From: Sean Wang <sean.wang@mediatek.com>

Enable USB RX aggregation on MT7927u with vendor driver parameters for
alignment, padding and buffer size. According to the vendor driver, the
hardware should run RX aggregation with USB SG disabled.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7925/usb.c |  6 +++++-
 drivers/net/wireless/mediatek/mt76/usb.c        | 11 +++++++++++
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/usb.c b/drivers/net/wireless/mediatek/mt76/mt7925/usb.c
index a0bfe6f09ae4..42d13bc6ebbc 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/usb.c
@@ -5,7 +5,6 @@
 #include <linux/module.h>
 #include <linux/sizes.h>
 #include <linux/usb.h>
-
 #include "mt7925.h"
 #include "mcu.h"
 #include "mac.h"
@@ -235,6 +234,11 @@ static int mt7925u_probe(struct usb_interface *usb_intf,
 		mdev->rev = (0x7927 << 16) | (mdev->rev & 0xff);
 	}
 
+	if (is_mt7927(mdev))
+		mt76u_enable_rx_aggr(mdev, MT7927_USB_RX_AGGR_ALIGN,
+				     MT7927_USB_RX_AGGR_PADDING,
+				     MT7927_USB_RX_AGGR_BUF_SIZE);
+
 	if (mt76_get_field(dev, MT_CONN_ON_MISC, MT_TOP_MISC2_FW_N9_RDY)) {
 		ret = mt792xu_wfsys_reset(dev);
 		if (ret)
diff --git a/drivers/net/wireless/mediatek/mt76/usb.c b/drivers/net/wireless/mediatek/mt76/usb.c
index 10ad2b024985..f0df510904c5 100644
--- a/drivers/net/wireless/mediatek/mt76/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/usb.c
@@ -1300,6 +1300,17 @@ static const struct mt76_queue_ops usb_queue_ops = {
 	.kick = mt76u_tx_kick,
 };
 
+void mt76u_enable_rx_aggr(struct mt76_dev *dev, int align, int padding,
+			  int buf_size)
+{
+	dev->usb.sg_en = false;
+	dev->usb.rx_aggr.enable = true;
+	dev->usb.rx_aggr.align = align;
+	dev->usb.rx_aggr.padding = padding;
+	dev->usb.rx_aggr.buf_size = buf_size;
+}
+EXPORT_SYMBOL_GPL(mt76u_enable_rx_aggr);
+
 int __mt76u_init(struct mt76_dev *dev, struct usb_interface *intf,
 		 struct mt76_bus_ops *ops)
 {
-- 
2.43.0


