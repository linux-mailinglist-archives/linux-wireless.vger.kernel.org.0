Return-Path: <linux-wireless+bounces-23545-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FA2BACC462
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Jun 2025 12:34:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86D031667DF
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Jun 2025 10:34:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CA83229B0D;
	Tue,  3 Jun 2025 10:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b="Y6lniUji"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp2.infineon.com (smtp2.infineon.com [217.10.52.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB531226D08
	for <linux-wireless@vger.kernel.org>; Tue,  3 Jun 2025 10:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.10.52.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748946850; cv=none; b=qFX+0oiLrmRJwu4S6lzs+0ndfiIGfYoPuZljf9PToun34lmpMDkyWgf5XBUUVPWQ3twRjJcnYWo190/vhLTEGef0qCLQAArNju66vABUIDyRf70pLyrT2IjlOnnd1N7j+THLIuaeMuxeS7AjAXq7/TZK09fsFPY/6iFbQ1qBRKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748946850; c=relaxed/simple;
	bh=Uowr0sIP+wDxmN8p1DSg+tWmGaoaZ/UnJmKUP1z6qyc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gR8ROAMNlagCgUpLz2YsiYVJSuujjeZxJscVojdRR4XO011Hg9jAuQfj8ctH18UH99n857tAf4NVnBOV4tmrtvAvOFYP+AOTSaXYqQ+K/4HDHwzCTH9f61+FIlBXM1+k3dOr+xywyosEcHQl5nX6r8uCYh082sY+w37aGqc+CiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com; spf=pass smtp.mailfrom=infineon.com; dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b=Y6lniUji; arc=none smtp.client-ip=217.10.52.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infineon.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1748946849; x=1780482849;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Uowr0sIP+wDxmN8p1DSg+tWmGaoaZ/UnJmKUP1z6qyc=;
  b=Y6lniUji7HBizwPR9zbNbe24qnB1KFFLW4649avhFklk4gusYn/aExh0
   ztaaCzg/n4CWucSP3IJPJMct4UYSA05ElSIBs4jz75VhumR2Y5Pnw6vFV
   fNpH2ADCul4FxGtcZ28yoAr1rQSLvdExZv8sJXBcyn/eh0ThR03NVaz25
   c=;
X-CSE-ConnectionGUID: x9VJdPTPTLO7sPlu6pQv8Q==
X-CSE-MsgGUID: 6F5SPthrSTK0zmoYCShTIg==
X-IronPort-AV: E=McAfee;i="6700,10204,11451"; a="112926854"
X-IronPort-AV: E=Sophos;i="6.16,205,1744063200"; 
   d="scan'208";a="112926854"
Received: from unknown (HELO MUCSE814.infineon.com) ([172.23.29.40])
  by smtp2.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2025 12:34:07 +0200
Received: from MUCSE827.infineon.com (172.23.29.20) by MUCSE814.infineon.com
 (172.23.29.40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 3 Jun
 2025 12:34:06 +0200
Received: from ISCN5CG14747PP.infineon.com (10.161.6.196) by
 MUCSE827.infineon.com (172.23.29.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 3 Jun 2025 12:34:04 +0200
From: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>
To: Johannes Berg <johannes@sipsolutions.net>, Arend van Spriel
	<arend.vanspriel@broadcom.com>, Ajay Singh <ajay.kathat@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>
CC: <linux-wireless@vger.kernel.org>, <brcm80211@lists.linux.dev>,
	<wlan-kernel-dev-list@infineon.com>, <gokulkumar.sivakumar@infineon.com>
Subject: [PATCH wireless-next v2 4/5] wifi: wilc1000: reject SET_BSS if any changed AP BSS param is not supported
Date: Tue, 3 Jun 2025 16:02:51 +0530
Message-ID: <20250603103252.18039-5-gokulkumar.sivakumar@infineon.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250603103252.18039-1-gokulkumar.sivakumar@infineon.com>
References: <20250603103252.18039-1-gokulkumar.sivakumar@infineon.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MUCSE805.infineon.com (172.23.29.31) To
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


