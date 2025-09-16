Return-Path: <linux-wireless+bounces-27351-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 020F2B7D8A5
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Sep 2025 14:30:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6225C16A1C4
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Sep 2025 22:19:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22A05288AD;
	Tue, 16 Sep 2025 22:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b="UuA6Aoyw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp11.infineon.com (smtp11.infineon.com [217.10.52.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1A9828725B
	for <linux-wireless@vger.kernel.org>; Tue, 16 Sep 2025 22:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.10.52.105
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758061168; cv=none; b=SJP2ArhBMnB+CZSlxKLp2rSOOdetXN19dFgpGC4tVbxopSZuLYmIruTou7pB//87mzV/Piyj//CEkL19Pw1mC7Uu+ymuCWGcDsrpidU6/AcJ9krKtVpGalx4zdI0Jckqi4DfYE34dvqtErwGQzMPGMrHclvn03WpPM8cQPFvZwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758061168; c=relaxed/simple;
	bh=K2wqqx1eXXS2Vw54gLAYkLkkvDTFBVLYClMsHCgzgSg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ORBJekcARgsh3zkdImVZq5EbrM4atG4BA7lRrk5wp0+WpAOwmplIwiD8qyVSj4V/1UJXZ7/waMyf1rFwrra+DVc/3qCkvl4mhKb3qlrBwxKF1JmmarMruaaFrGfZpxa61R3oDgjI3uVFQl0TQlut74dMuhh9/xDGpkG4EDEBkr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com; spf=pass smtp.mailfrom=infineon.com; dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b=UuA6Aoyw; arc=none smtp.client-ip=217.10.52.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infineon.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1758061167; x=1789597167;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=K2wqqx1eXXS2Vw54gLAYkLkkvDTFBVLYClMsHCgzgSg=;
  b=UuA6AoywM+eNWpVROrJ3o6ifOa720+5Agn8Us1eSmOjjkhC83TBYUQnV
   G6xMKcromaXWBk4EtSJVxDnSBp+MhMKmKNaapTjtuAB6bzKoMFiFoW2Zd
   gR7ykvhFJJ5fHPVQBbUWmbm9IXIZu+KJ/LpyaY8+gbcwSKFy1ev5vDTOh
   c=;
X-CSE-ConnectionGUID: Ezo5MwwBTeGBo/7wYIakyQ==
X-CSE-MsgGUID: VqwgqVHOSB6rkVhH3DSg0Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11555"; a="110918087"
X-IronPort-AV: E=Sophos;i="6.18,270,1751234400"; 
   d="scan'208";a="110918087"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO MUCSE819.infineon.com) ([172.23.29.45])
  by smtp11.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2025 00:19:25 +0200
Received: from MUCSE827.infineon.com (172.23.29.20) by MUCSE819.infineon.com
 (172.23.29.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.36; Wed, 17 Sep
 2025 00:19:23 +0200
Received: from ISCN5CG14747PP.infineon.com (10.161.6.196) by
 MUCSE827.infineon.com (172.23.29.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.36; Wed, 17 Sep 2025 00:19:21 +0200
From: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>
To: <linux-wireless@vger.kernel.org>, Johannes Berg
	<johannes@sipsolutions.net>
CC: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>,
	<wlan-kernel-dev-list@infineon.com>
Subject: [PATCH wireless-next 04/57] mmc: sdio: add SDIO Device ID of new Infineon(Cypress) Wi-Fi+Bluetooth chips
Date: Wed, 17 Sep 2025 03:47:19 +0530
Message-ID: <20250916221821.4387-5-gokulkumar.sivakumar@infineon.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250916221821.4387-1-gokulkumar.sivakumar@infineon.com>
References: <20250916221821.4387-1-gokulkumar.sivakumar@infineon.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MUCSE813.infineon.com (172.23.29.39) To
 MUCSE827.infineon.com (172.23.29.20)

Add the SDIO Device IDs of new Generation Infineon(Cypress) SDIO chipsets,
which gets enumerated with the Cypress SDIO Vendor ID (0x04b4).

Signed-off-by: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>
---
 include/linux/mmc/sdio_ids.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/mmc/sdio_ids.h b/include/linux/mmc/sdio_ids.h
index 673cbdf43453..44ed76e89539 100644
--- a/include/linux/mmc/sdio_ids.h
+++ b/include/linux/mmc/sdio_ids.h
@@ -81,6 +81,10 @@
 
 #define SDIO_VENDOR_ID_CYPRESS			0x04b4
 #define SDIO_DEVICE_ID_BROADCOM_CYPRESS_43439	0xbd3d
+#define SDIO_DEVICE_ID_CYPRESS_55572		0xbd31
+#define SDIO_DEVICE_ID_CYPRESS_55500		0xbd3e
+#define SDIO_DEVICE_ID_CYPRESS_43022		0xbd3f
+#define SDIO_DEVICE_ID_CYPRESS_55900		0xbd40
 
 #define SDIO_VENDOR_ID_MARVELL			0x02df
 #define SDIO_DEVICE_ID_MARVELL_LIBERTAS		0x9103
-- 
2.25.1


