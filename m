Return-Path: <linux-wireless+bounces-37012-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AHWEBsgEF2qz0wcAu9opvQ
	(envelope-from <linux-wireless+bounces-37012-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 27 May 2026 16:50:48 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E54A5E632C
	for <lists+linux-wireless@lfdr.de>; Wed, 27 May 2026 16:50:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 948B1300DDFB
	for <lists+linux-wireless@lfdr.de>; Wed, 27 May 2026 14:47:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07E40364950;
	Wed, 27 May 2026 14:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=justthetip.ca header.i=@justthetip.ca header.b="T8jual49"
X-Original-To: linux-wireless@vger.kernel.org
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BA81372EEF
	for <linux-wireless@vger.kernel.org>; Wed, 27 May 2026 14:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779893267; cv=none; b=Y369yFViDQulrcb/sNYH5npIk+NffkiGlWk+Q7ZJuoBWseSsCm4xM5e4qfoHzbsxVW6EakTREBgwGt4k9K/Qoma82hIm+XiDvzoLQPsGbr0XmrBb6tC8bmO5FK6NCrIJORWKo3A5yTthhZ96gfOG91zgkBMw8Z5rHguurhwA0AA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779893267; c=relaxed/simple;
	bh=9K54xMwDMsZ7cLaJmXuDvcs9SL3Y/hGhAGd5zI54DoE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V1XyeC8LJqOI2689/SV9zFb0Pl3sDj1kR1zCkvAKgA+o1VRZ2JO2Pbl4Q1UA1lV1KY8XqIBGVBGNChfKIDbKwIwXvBiV30K5legXUOPo1Et/qB+j9QkyGXFaFU4Qm9BTaOooIYDZPBmzkb2ABQlQDoIlfjeYFLOX4XGeemr/VQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=justthetip.ca; spf=pass smtp.mailfrom=justthetip.ca; dkim=pass (2048-bit key) header.d=justthetip.ca header.i=@justthetip.ca header.b=T8jual49; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=justthetip.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=justthetip.ca
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=justthetip.ca;
	s=key1; t=1779893263;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GWgTKavmgNtbnrQrCEy1dI23oxS2X59cmPGG/1Wg2P8=;
	b=T8jual49eWiH6n70Wjg80rwzRa9xLO2zoFPJtRDmec/4sTvTOmCis49v1DaDBsUUmu9qeL
	dp3xexVjTPtzew4iyeSvUHZFlLEEKPWghyqXnfinDm8FHFYvsaAYnlEyl6rvti5ikL06Tx
	3p/qFRK94OWJEQrFE/WGZs6zj+6vOWZ6KhN2FgrbDizTGkpV7QL2puETMlAuK1rEU8F/eE
	pihoX/m93GlCVxDmo5sn5adCurT8kkewecfU8nHphhzo5YawJiuw0K2MeCFE522qkeDKPF
	NW/zrsfEVoTAqR/qKuCST6qrtvSJtHDmMfQki7GvVz/alz2QZPhM15N9gJeiNw==
From: Devin Wittmayer <lucid_duck@justthetip.ca>
To: linux-wireless@vger.kernel.org
Cc: Felix Fietkau <nbd@nbd.name>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Sean Wang <sean.wang@kernel.org>,
	Ryder Lee <ryder.lee@mediatek.com>,
	linux-mediatek@lists.infradead.org,
	Nick Morrow <morrownr@gmail.com>,
	Devin Wittmayer <lucid_duck@justthetip.ca>
Subject: [PATCH wireless-next v2] wifi: mt76: mt7925: add Netgear A8500 USB device ID
Date: Wed, 27 May 2026 07:47:35 -0700
Message-ID: <20260527144735.10254-1-lucid_duck@justthetip.ca>
In-Reply-To: <20260326190346.415226-1-lucid_duck@justthetip.ca>
References: <20260326190346.415226-1-lucid_duck@justthetip.ca>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[justthetip.ca,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[justthetip.ca:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[nbd.name,kernel.org,mediatek.com,lists.infradead.org,gmail.com,justthetip.ca];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-37012-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[justthetip.ca:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lucid_duck@justthetip.ca,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 7E54A5E632C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add USB device ID for the Netgear A8500 (0846:9050) which uses
the mt7925 chipset.

Signed-off-by: Devin Wittmayer <lucid_duck@justthetip.ca>
---
Changes in v2 (Sean Wang):
- Drop the Cc: stable tag.
- Use full name in Signed-off-by.

v1: https://lore.kernel.org/linux-wireless/20260326190346.415226-1-lucid_duck@justthetip.ca/
---
 drivers/net/wireless/mediatek/mt76/mt7925/usb.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/usb.c b/drivers/net/wireless/mediatek/mt76/mt7925/usb.c
index d9968f03856d..e44f0cafde01 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/usb.c
@@ -12,6 +12,9 @@
 static const struct usb_device_id mt7925u_device_table[] = {
 	{ USB_DEVICE_AND_INTERFACE_INFO(0x0e8d, 0x7925, 0xff, 0xff, 0xff),
 		.driver_info = (kernel_ulong_t)MT7925_FIRMWARE_WM },
+	/* Netgear, Inc. A8500 */
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x0846, 0x9050, 0xff, 0xff, 0xff),
+		.driver_info = (kernel_ulong_t)MT7925_FIRMWARE_WM },
 	/* Netgear, Inc. A9000 */
 	{ USB_DEVICE_AND_INTERFACE_INFO(0x0846, 0x9072, 0xff, 0xff, 0xff),
 		.driver_info = (kernel_ulong_t)MT7925_FIRMWARE_WM },
-- 
2.54.0


