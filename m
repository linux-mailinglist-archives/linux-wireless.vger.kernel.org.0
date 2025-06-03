Return-Path: <linux-wireless+bounces-23566-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 85C68ACCB05
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Jun 2025 18:11:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4316C1709B8
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Jun 2025 16:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAC9323C8D6;
	Tue,  3 Jun 2025 16:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b="bJCzms2h"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp11.infineon.com (smtp11.infineon.com [217.10.52.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B874C231833
	for <linux-wireless@vger.kernel.org>; Tue,  3 Jun 2025 16:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.10.52.105
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748967108; cv=none; b=jvK3szPjcnzrb4ROArucpoD7GB4bRsrZc7hauCEmdwY5WB3HqUoiP4JN8YjszlWaBuQIvIVaSf/r6ziLuRoD0PtbM8SBO/oSxvgqnUCAQmriA2x2UJtM534+mVu6WGRY7aSTP4foPfQ5ANyTAuVwUt1AXJecgK4aAvb0uuJS9TY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748967108; c=relaxed/simple;
	bh=Uowr0sIP+wDxmN8p1DSg+tWmGaoaZ/UnJmKUP1z6qyc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lbFNb8qDnwoA1Fl4nuPikl1DI9QEuoub5bYIFfEmvhh+FL2+sGEFwgO+RFCwkeqooS6/ll6CsP/wTiFWBWAcBUR7DFOXfuTmxKjKS0eUPGeoPL7SrmXAfB0R45DD21tiJZWrVc6K7uZS89n+8Tbg3kuDZEM5e3FhpefMU4it7cE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com; spf=pass smtp.mailfrom=infineon.com; dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b=bJCzms2h; arc=none smtp.client-ip=217.10.52.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infineon.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1748967107; x=1780503107;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Uowr0sIP+wDxmN8p1DSg+tWmGaoaZ/UnJmKUP1z6qyc=;
  b=bJCzms2hhB/6Ow6Kq/5BCb9afGLxIJHcsWBHtWE8rzkLQLdme9EwJZ6N
   nCiEeFP3h0uzQcNS2QMFKFDF1zGjGX5Mr+tJcuwBbpjCV8JLyf3C+FOED
   CUym9Lyv0BTntCGDOVv7YUpsyUgzmY0Y9TiGJYDl5EjT2fyTG8J3IS2qH
   w=;
X-CSE-ConnectionGUID: 7ZZkmH2TSAWVwhlONpmB3A==
X-CSE-MsgGUID: 7r/IemI7R7i2pb86uwmtRw==
X-IronPort-AV: E=McAfee;i="6700,10204,11453"; a="97700373"
X-IronPort-AV: E=Sophos;i="6.16,206,1744063200"; 
   d="scan'208";a="97700373"
Received: from unknown (HELO MUCSE814.infineon.com) ([172.23.29.40])
  by smtp11.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2025 18:11:45 +0200
Received: from MUCSE827.infineon.com (172.23.29.20) by MUCSE814.infineon.com
 (172.23.29.40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 3 Jun
 2025 18:11:44 +0200
Received: from ISCN5CG14747PP.infineon.com (10.161.6.196) by
 MUCSE827.infineon.com (172.23.29.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 3 Jun 2025 18:11:42 +0200
From: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>
To: Johannes Berg <johannes@sipsolutions.net>, Arend van Spriel
	<arend.vanspriel@broadcom.com>, Ajay Singh <ajay.kathat@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>
CC: <linux-wireless@vger.kernel.org>, <brcm80211@lists.linux.dev>,
	<wlan-kernel-dev-list@infineon.com>, <gokulkumar.sivakumar@infineon.com>
Subject: [PATCH wireless-next v3 4/5] wifi: wilc1000: reject SET_BSS if any changed AP BSS param is not supported
Date: Tue, 3 Jun 2025 21:40:56 +0530
Message-ID: <20250603161057.19101-5-gokulkumar.sivakumar@infineon.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250603161057.19101-1-gokulkumar.sivakumar@infineon.com>
References: <20250603161057.19101-1-gokulkumar.sivakumar@infineon.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MUCSE803.infineon.com (172.23.29.29) To
 MUCSE827.infineon.com (172.23.29.20)

Since the driver currently does not support setting any of the AP BSS
parameters, reject the entire SET_BSS operation instead of misleading the
userspace that the operation is fully successful.

Signed-off-by: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>
---
 drivers/net/wireless/microchip/wilc1000/cfg80211.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/wireless/microchip/wilc1000/cfg80211.c b/drivers/net/wireless/microchip/wilc1000/cfg80211.c
index e7aa0f991923..98776ef9195b 100644
--- a/drivers/net/wireless/microchip/wilc1000/cfg80211.c
+++ b/drivers/net/wireless/microchip/wilc1000/cfg80211.c
@@ -797,6 +797,12 @@ static int get_station(struct wiphy *wiphy, struct net_device *dev,
 static int change_bss(struct wiphy *wiphy, struct net_device *dev,
 		      struct bss_parameters *params)
 {
+	/* Reject the operation if any of the AP BSS params that got changed are not
+	 * supported by the driver for explicit configuration.
+	 */
+	if (params->changed)
+		return -EOPNOTSUPP;
+
 	return 0;
 }
 
-- 
2.47.0


