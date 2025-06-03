Return-Path: <linux-wireless+bounces-23569-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 594E5ACCB0D
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Jun 2025 18:12:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6410166F5A
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Jun 2025 16:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C93BD23E25A;
	Tue,  3 Jun 2025 16:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b="IJgeIeNE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp11.infineon.com (smtp11.infineon.com [217.10.52.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCFA323E338
	for <linux-wireless@vger.kernel.org>; Tue,  3 Jun 2025 16:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.10.52.105
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748967161; cv=none; b=NdBlXRYh9MxP/5LEGEv+7FHqZb9mY924KnNdEgammo2wU9pnPIh0YO7ftSxNuNzYTCEjKz/c76H6DbYIFAdmF3x9VPujU+Nf6FFot7d+8qRxNm2k+mq9cpZZVtCJOynllu0TGav0b5Zlj2Ybc5F7OLJ6e4UFmYeSil7Ae4r+PRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748967161; c=relaxed/simple;
	bh=QpxyJW3KI6dSN48T8NAe3BtLqrT4OD7XzH5S94D9Nec=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qhRRbo6hdOgDIqsJKSXurdiGQa/zb0Q7INI+s+nasIwrux+cjuA+tcqb4Z82dUBNPqsu9YJICoHJhoE7fxj+6oFfMu+4lK5h4Yh5uIwihYy6+HJJdibH422+YPAaghtEWj/Q/ArxEqRjpMPcKGrq3HfdFpNNpM4Kb31Pr3FsaJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com; spf=pass smtp.mailfrom=infineon.com; dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b=IJgeIeNE; arc=none smtp.client-ip=217.10.52.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infineon.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1748967160; x=1780503160;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QpxyJW3KI6dSN48T8NAe3BtLqrT4OD7XzH5S94D9Nec=;
  b=IJgeIeNE1oSikmJHzZYO0+L1Os17gzIeQrR+bpKui1KSpBq0tahDVf53
   e9ejPwG9z4loPE9Upkqe/JpR8buHbC8s8MBQ5+gXp7ZFx81nR+F9UPTLt
   jSrJCivunqdZTy9lDd4eh9oExDMZn46SKffSR9OQheXvGlsSM3LqUzSpI
   A=;
X-CSE-ConnectionGUID: QVlIz5A/SI+aAWu9I+8XvQ==
X-CSE-MsgGUID: Q65vbM3GRvWZaAWi1a1YAQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11453"; a="97700338"
X-IronPort-AV: E=Sophos;i="6.16,206,1744063200"; 
   d="scan'208";a="97700338"
Received: from unknown (HELO MUCSE819.infineon.com) ([172.23.29.45])
  by smtp11.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2025 18:11:31 +0200
Received: from MUCSE827.infineon.com (172.23.29.20) by MUCSE819.infineon.com
 (172.23.29.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 3 Jun 2025
 18:11:30 +0200
Received: from ISCN5CG14747PP.infineon.com (10.161.6.196) by
 MUCSE827.infineon.com (172.23.29.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 3 Jun 2025 18:11:28 +0200
From: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>
To: Johannes Berg <johannes@sipsolutions.net>, Arend van Spriel
	<arend.vanspriel@broadcom.com>, Ajay Singh <ajay.kathat@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>
CC: <linux-wireless@vger.kernel.org>, <brcm80211@lists.linux.dev>,
	<wlan-kernel-dev-list@infineon.com>, <gokulkumar.sivakumar@infineon.com>
Subject: [PATCH wireless-next v3 3/5] wifi: wil6210: reject SET_BSS if any changed AP BSS param is not supported
Date: Tue, 3 Jun 2025 21:40:55 +0530
Message-ID: <20250603161057.19101-4-gokulkumar.sivakumar@infineon.com>
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
X-ClientProxiedBy: MUCSE817.infineon.com (172.23.29.43) To
 MUCSE827.infineon.com (172.23.29.20)

The userspace can change more than one AP BSS Parameter in the SET_BSS
operation. Incase if any BSS param other than the currently supported
"ap_isolate" is passed by userspace, reject the entire SET_BSS operation
instead of misleading the userspace that the operation is fully successful.

Also add an individual check for the CFG80211_BSS_PARAM_CHANGED_AP_ISOLATE
flag, before handling "ap_isolate" value from the userspace. This addresses
case where driver unnecessarily checks the value of ap_isolate, even if the
userspace did not pass this param in the SET_BSS request.

Signed-off-by: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>
---
 drivers/net/wireless/ath/wil6210/cfg80211.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/wil6210/cfg80211.c b/drivers/net/wireless/ath/wil6210/cfg80211.c
index 5473c01cbe66..41df409f5fad 100644
--- a/drivers/net/wireless/ath/wil6210/cfg80211.c
+++ b/drivers/net/wireless/ath/wil6210/cfg80211.c
@@ -2416,7 +2416,15 @@ static int wil_cfg80211_change_bss(struct wiphy *wiphy,
 	struct wil6210_priv *wil = wiphy_to_wil(wiphy);
 	struct wil6210_vif *vif = ndev_to_vif(dev);
 
-	if (params->ap_isolate >= 0) {
+	/* Reject the operation if any of the AP BSS params that got changed are not
+	 * supported by the driver for explicit configuration.
+	 */
+	if (params->changed &
+	    ~(CFG80211_BSS_PARAM_CHANGED_AP_ISOLATE))
+		return -EOPNOTSUPP;
+
+	if (params->changed &
+	    CFG80211_BSS_PARAM_CHANGED_AP_ISOLATE) {
 		wil_dbg_misc(wil, "change_bss: ap_isolate MID %d, %d => %d\n",
 			     vif->mid, vif->ap_isolate, params->ap_isolate);
 		vif->ap_isolate = params->ap_isolate;
-- 
2.47.0


