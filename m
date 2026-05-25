Return-Path: <linux-wireless+bounces-36866-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iMeaC90KFGr6JAcAu9opvQ
	(envelope-from <linux-wireless+bounces-36866-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 25 May 2026 10:39:57 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C9D455C7E62
	for <lists+linux-wireless@lfdr.de>; Mon, 25 May 2026 10:39:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 89696300233E
	for <lists+linux-wireless@lfdr.de>; Mon, 25 May 2026 08:39:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F12AE3E16B9;
	Mon, 25 May 2026 08:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b="d2WAT/hd"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp14.infineon.com (smtp14.infineon.com [217.10.52.160])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D83C83D413C
	for <linux-wireless@vger.kernel.org>; Mon, 25 May 2026 08:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.10.52.160
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779698392; cv=none; b=M1thaUSHu4vthCL8zePKjAl2s5vzSJSTWrueW5u5uPvYZbs0+hYnOvqPZCUChAYAsAEaLb3+uwtLoYeiKKogg2+m+UQDX/AtMdDUEGHz1sGrir4/3+zCliOyG4kVG7Dk6pH/ZDO2Hr9fySzK/9Cx8/bPjyaFpPB3CCpRq2QGUqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779698392; c=relaxed/simple;
	bh=pfwsV2I3u+kTQSx7r04knF5DzPb7SzmDCDZNzj12D4s=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qpTK4xFM7Jpr7/0PV7yj1CJaoQlf9uZzuYC9wNQ3SuKfD4HQ0MehKLeXlRdRXmWA3++HI1rGFfRUJRnW4yljXPJy0izSaLgMv9a2k1Wc0IsGt9F900omWtzx9O2YxT0i3Gp64MEzbnMiWbPFPu67QHMl0DNQ4NAreuag56zaii4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=infineon.com; spf=pass smtp.mailfrom=infineon.com; dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b=d2WAT/hd; arc=none smtp.client-ip=217.10.52.160
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=infineon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infineon.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1779698392; x=1811234392;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=pfwsV2I3u+kTQSx7r04knF5DzPb7SzmDCDZNzj12D4s=;
  b=d2WAT/hdL2a3o7fkw6LYtsrDYmbQ7/GybXs/6n3st9pZ1f6s2PKR/nhq
   DItdSwHgT2UFzA1xqoaO/B3V+JmGn1/U2styRABfzZ+MXqXViBI6XP92O
   RUuuus63TMGqSfNKmnIc8N5V3224TG+LkqWTg5HzuANn8I4FBpkMHeftY
   w=;
X-CSE-ConnectionGUID: z61yv10MSPuw/zq99QXDjw==
X-CSE-MsgGUID: 3UVJPKnDRXeRnpWQZkkWDg==
X-IronPort-AV: E=McAfee;i="6800,10657,11796"; a="131236022"
X-IronPort-AV: E=Sophos;i="6.24,167,1774306800"; 
   d="scan'208";a="131236022"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO MUCSE812.infineon.com) ([172.23.29.38])
  by smtp14.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2026 10:39:43 +0200
Received: from MUCSE826.infineon.com (172.23.29.19) by MUCSE812.infineon.com
 (172.23.29.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 25 May
 2026 10:39:42 +0200
Received: from ISCN5CG3192MLP.infineon.com (10.161.6.196) by
 MUCSE826.infineon.com (172.23.29.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 25 May 2026 10:39:39 +0200
From: Shelley Yang <shelley.yang@infineon.com>
To: <linux-wireless@vger.kernel.org>
CC: Johannes Berg <johannes@sipsolutions.net>,
	<wlan-kernel-dev-list@infineon.com>, Shelley Yang
	<shelley.yang@infineon.com>, Phil Elwell <phil@raspberrypi.com>
Subject: [PATCH] wifi: brcmfmac: 43430 and 43455 are CYW parts
Date: Mon, 25 May 2026 16:39:26 +0800
Message-ID: <20260525083926.583964-1-shelley.yang@infineon.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MUCSE808.infineon.com (172.23.29.34) To
 MUCSE826.infineon.com (172.23.29.19)
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[infineon.com,quarantine];
	R_DKIM_ALLOW(-0.20)[infineon.com:s=IFXMAIL];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-36866-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[infineon.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[shelley.yang@infineon.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infineon.com:email,infineon.com:mid,infineon.com:dkim,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,raspberrypi.com:email]
X-Rspamd-Queue-Id: C9D455C7E62
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Phil Elwell <phil@raspberrypi.com>

The brcmfmac driver uses the SDIO vendor ID values to identify which
vendor's driver extensions to use. However, the Cypress/Infineon devices
have a vendor ID of 02d0, which is Broadcom.

In order to use the Cypress driver extensions, modify the static mapping
for "43430", "4345" (sic) and "43455"
to indicate that they are Cypress parts.

Signed-off-by: Phil Elwell <phil@raspberrypi.com>
Signed-off-by: Shelley Yang <shelley.yang@infineon.com>
---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
index d24b80e492e0..5926811c5411 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
@@ -988,10 +988,10 @@ static const struct sdio_device_id brcmf_sdmmc_ids[] = {
 	BRCMF_SDIO_DEVICE(SDIO_DEVICE_ID_BROADCOM_43364, WCC),
 	BRCMF_SDIO_DEVICE(SDIO_DEVICE_ID_BROADCOM_4335_4339, WCC),
 	BRCMF_SDIO_DEVICE(SDIO_DEVICE_ID_BROADCOM_4339, WCC),
-	BRCMF_SDIO_DEVICE(SDIO_DEVICE_ID_BROADCOM_43430, WCC),
+	BRCMF_SDIO_DEVICE(SDIO_DEVICE_ID_BROADCOM_43430, CYW),
 	BRCMF_SDIO_DEVICE(SDIO_DEVICE_ID_BROADCOM_43439, WCC),
-	BRCMF_SDIO_DEVICE(SDIO_DEVICE_ID_BROADCOM_4345, WCC),
-	BRCMF_SDIO_DEVICE(SDIO_DEVICE_ID_BROADCOM_43455, WCC),
+	BRCMF_SDIO_DEVICE(SDIO_DEVICE_ID_BROADCOM_4345, CYW),
+	BRCMF_SDIO_DEVICE(SDIO_DEVICE_ID_BROADCOM_43455, CYW),
 	BRCMF_SDIO_DEVICE(SDIO_DEVICE_ID_BROADCOM_4354, WCC),
 	BRCMF_SDIO_DEVICE(SDIO_DEVICE_ID_BROADCOM_4356, WCC),
 	BRCMF_SDIO_DEVICE(SDIO_DEVICE_ID_BROADCOM_4359, WCC),
-- 
2.25.1


