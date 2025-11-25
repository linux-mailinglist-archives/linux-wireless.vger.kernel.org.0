Return-Path: <linux-wireless+bounces-29337-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 21C7AC84DDB
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Nov 2025 13:04:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id F000334EEC4
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Nov 2025 12:04:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94F2E3148C5;
	Tue, 25 Nov 2025 12:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B4pyS2FM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE68D3191C0
	for <linux-wireless@vger.kernel.org>; Tue, 25 Nov 2025 12:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764072245; cv=none; b=tCq5+138tEcBzrGC5iDz9rVgow5NrsQ+qstBnvJoUEN4DFI/3FKnsjKwrVbrL6ixhHdDkRih3ZcajQkowbFteGT1Xh6so3Ia8lJl1fAaTDHPLCppYdXt+pvwwlojOUtYkVSqqgZ0+JtYpaqJU9bnGdurid3C+pBA486xFbVEQog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764072245; c=relaxed/simple;
	bh=+W5rZ9OC+EIVFuUZFaA2JdOT26gCnizEbfEW61N66ko=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jvy9dliTLnomPSs0k3b4837En+FXBDeFIy1OzVi9Nsa+bL7g6A76z2vmdKfIV0Zti7ySLj5liVTtVQ9HGIjq74/eHzfhCYAEjiKMOOsLcdgIOtD7Wlh4EtKXO7GKUlUVbfORl632nyLgroeDPQm0f4suryfoJTwER1aedltRueQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=B4pyS2FM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764072242;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=lFP3ngDvqDRLiQ8a/CTpFlKO0i4D5lfYim61XfA1mmg=;
	b=B4pyS2FMS08kKz+s8u0wd1UlI8ADXb7xq5Je0vctPHqXVDSRMAbfHHtIjXYwnUxBN1WHH4
	e5kK+OpJwilkAtD8pEtgzI1Q4Wi/btFmVTCs9lT2CLpormnZtqnz7P3i0NYC2PrUPCkMDw
	BjWX0iFlLk3AxIwhgXnzmLMfwQvnpcs=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-661-irWgXtyOPWWdRGk3g76rog-1; Tue,
 25 Nov 2025 07:03:58 -0500
X-MC-Unique: irWgXtyOPWWdRGk3g76rog-1
X-Mimecast-MFC-AGG-ID: irWgXtyOPWWdRGk3g76rog_1764072238
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B4BBA1956094;
	Tue, 25 Nov 2025 12:03:57 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.224.216])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2735F3003761;
	Tue, 25 Nov 2025 12:03:55 +0000 (UTC)
From: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
To: pkshih@realtek.com,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
Subject: [PATCH] wifi: rtw89: 8922a: set random mac if efuse contains zeroes
Date: Tue, 25 Nov 2025 13:03:39 +0100
Message-ID: <20251125120350.228288-1-jtornosm@redhat.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

I have some rtl8952ae devices with no permanent mac stored in efuse.

It could be properly saved and/or configured from user tools like
NetworkManager, but it would be desirable to be able to initialize it
somehow to get the device working by default.

So, in the same way as with other devices, if the mac address read from
efuse contains zeros, a random mac address is assigned to at least allow
operation, and the user is warned about this in case any action needs to
be considered.

Signed-off-by: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
---
 drivers/net/wireless/realtek/rtw89/rtw8922a.c | 22 +++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/rtw8922a.c b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
index 6aa19ad259ac..050307fa16d2 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8922a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
@@ -636,16 +636,30 @@ static int rtw8922a_read_efuse_rf(struct rtw89_dev *rtwdev, u8 *log_map)
 static int rtw8922a_read_efuse(struct rtw89_dev *rtwdev, u8 *log_map,
 			       enum rtw89_efuse_block block)
 {
+	struct rtw89_efuse *efuse = &rtwdev->efuse;
+	int ret;
+
 	switch (block) {
 	case RTW89_EFUSE_BLOCK_HCI_DIG_PCIE_SDIO:
-		return rtw8922a_read_efuse_pci_sdio(rtwdev, log_map);
+		ret = rtw8922a_read_efuse_pci_sdio(rtwdev, log_map);
+		break;
 	case RTW89_EFUSE_BLOCK_HCI_DIG_USB:
-		return rtw8922a_read_efuse_usb(rtwdev, log_map);
+		ret = rtw8922a_read_efuse_usb(rtwdev, log_map);
+		break;
 	case RTW89_EFUSE_BLOCK_RF:
-		return rtw8922a_read_efuse_rf(rtwdev, log_map);
+		ret = rtw8922a_read_efuse_rf(rtwdev, log_map);
+		break;
 	default:
-		return 0;
+		ret = 0;
+		break;
+	}
+
+	if (!ret && is_zero_ether_addr(efuse->addr)) {
+		rtw89_warn(rtwdev,"efuse mac address is zero, using random mac");
+		eth_random_addr(efuse->addr);
 	}
+
+	return ret;
 }
 
 #define THM_TRIM_POSITIVE_MASK BIT(6)
-- 
2.51.1


