Return-Path: <linux-wireless+bounces-34004-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UKe3BQyExWlc+wQAu9opvQ
	(envelope-from <linux-wireless+bounces-34004-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2026 20:07:56 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B9EEE33AB8B
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2026 20:07:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6298630A11A4
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2026 19:04:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05DC823B612;
	Thu, 26 Mar 2026 19:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=justthetip.ca header.i=@justthetip.ca header.b="TjMDUMtI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E9963328E6
	for <linux-wireless@vger.kernel.org>; Thu, 26 Mar 2026 19:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774551844; cv=none; b=hOaUcpFqnUmsjDhSIOOoBUPlJ8+VuDV3Sbd1ETpcQQ7DSw2oFQAHQPY9X/iV4goICXc+WZPdccm8AKYvrc7LDDPTVIW1R0e8wmgY/sHTv1LAfltlOEZo7OS9cIXyDabv7VejffSFZMA9NAwJhA81QdQ8k2JtGUr7swBtFakqJao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774551844; c=relaxed/simple;
	bh=vBUk8AlvIl2Sm9Ya8jdpATcn3CTWo+D4uwNu5b4d3xc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=upPvEl0Wr5pOe68sngUheU5ob+2/DHmqcf+kOcDpgg2DPQ03ANI5eKKhy42DyGaPobie9pntB+u6MOJL0xyp13ntw9o5qLcFbgSIJXYuarlqFgyLkocZwCrgs6VarMejN6VF59th5t8hH6cj3lsOdcHfrYPrPwvA2uPC3HBkOMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=justthetip.ca; spf=pass smtp.mailfrom=justthetip.ca; dkim=pass (2048-bit key) header.d=justthetip.ca header.i=@justthetip.ca header.b=TjMDUMtI; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=justthetip.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=justthetip.ca
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=justthetip.ca;
	s=key1; t=1774551831;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=2nKOrQu/q+fU5meJzN4ZZdsdpjtXwGQWpbKXuDrdLOI=;
	b=TjMDUMtIJ/7IoigppoL+DTJfUqlnRSf24SQVC7lanDwzSqZxyQBsw+n1+8rndwlh1yijiK
	Riz+vX7YLNG/U1IWLFmMMJL6mqCF7JRrj+Yw5pBOtFzDuPlY+iDlAFMN/zOISl7q3cjaHb
	ttHK6cEq/t6K06Mjc+HlIOtb9XhZBnPmNfA7cKq+Heshge4pY2bcBjvf1xFD81gzA26s8I
	BoqVg/LTaesJZrN44CwR+sHYVNI8S77aXS3WLqOA3H7Xo2Ze1XghhtjKHND9IGSar13iYF
	ouOue0c9C5v7Ea0SUIzzb/C6+QEX79WMP8yiBfsY3q966LQ3tXGYbM5eyM1ylA==
From: Lucid Duck <lucid_duck@justthetip.ca>
To: nbd@nbd.name,
	lorenzo.bianconi@redhat.com
Cc: sean.wang@mediatek.com,
	linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	morrownr@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH wireless-next] wifi: mt76: mt7925: add Netgear A8500 USB device ID
Date: Thu, 26 Mar 2026 12:03:46 -0700
Message-ID: <20260326190346.415226-1-lucid_duck@justthetip.ca>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[justthetip.ca:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[mediatek.com,vger.kernel.org,lists.infradead.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TAGGED_FROM(0.00)[bounces-34004-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[justthetip.ca:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lucid_duck@justthetip.ca,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_SEVEN(0.00)[7];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: B9EEE33AB8B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add USB device ID for the Netgear A8500 (0846:9050) which uses
the mt7925 chipset.

Cc: stable@vger.kernel.org
Signed-off-by: Lucid Duck <lucid_duck@justthetip.ca>
---
 drivers/net/wireless/mediatek/mt76/mt7925/usb.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/usb.c b/drivers/net/wireless/mediatek/mt76/mt7925/usb.c
index d9968f038..e44f0cafd 100644
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
2.53.0


