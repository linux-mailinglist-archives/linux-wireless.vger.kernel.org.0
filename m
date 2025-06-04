Return-Path: <linux-wireless+bounces-23687-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 701BAACDABF
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Jun 2025 11:17:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0A7D18983D5
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Jun 2025 09:17:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E01E828B51E;
	Wed,  4 Jun 2025 09:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b="HaFFLU9F"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp14.infineon.com (smtp14.infineon.com [217.10.52.160])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE01A1EFF81
	for <linux-wireless@vger.kernel.org>; Wed,  4 Jun 2025 09:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.10.52.160
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749028648; cv=none; b=ht7i4W64b1ovOZuEp3bOsvATYUlFrf9x/9SQutg/F0p+o4rHBajrQpr/ZcQjeuumvO7afL94QTtzpcZ0fNFEH5O76MTwdL2oKmdVa/WjEhlb6ckDyqUgYN4MRgeKtTsh6kDSWX9nloC7Um8sNzHClQ8JT6fyUiuRLi1KDt161ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749028648; c=relaxed/simple;
	bh=jaWYOlqJPw2BZWOHnti8Fj3X0sSIXuo768Cq7f6xCrI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Wge6iA0u29tNbrQN/NqK+OpioG7s4U39m21E45u8SO8efcUKd6kC6v6C51ZYXhw+2hkqzFiabM6kTEuFu0q9VvTqQI35XSaeUsXtYlogbxbO22ym7HXi+fQlo0Dz1ehs1KHIM1PCzrmV/0/a+EDC3SjvFU/H4NynkOFCvTfyTxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com; spf=pass smtp.mailfrom=infineon.com; dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b=HaFFLU9F; arc=none smtp.client-ip=217.10.52.160
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infineon.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1749028647; x=1780564647;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jaWYOlqJPw2BZWOHnti8Fj3X0sSIXuo768Cq7f6xCrI=;
  b=HaFFLU9Fgzq4eeko5/aUxwTNkcb24FidVc5LKRfPajVDZYSy6i1gzi+h
   q7G4GJUCIE1WJxzeOQz0+zEvPq07QIYaybqORvDvxw6LZwggetyl2HMNE
   I3NXBW7dDwGlnWyCjTk2L01INOWWSNWRB99YCCoE2chkevNXzeJKdPFDn
   U=;
X-CSE-ConnectionGUID: FHBpNLgtSuu/QKtHueU+qA==
X-CSE-MsgGUID: UPPv2IZZQ8+KFYIZoDyDMw==
X-IronPort-AV: E=McAfee;i="6700,10204,11453"; a="87259717"
X-IronPort-AV: E=Sophos;i="6.16,208,1744063200"; 
   d="scan'208";a="87259717"
Received: from unknown (HELO MUCSE819.infineon.com) ([172.23.29.45])
  by smtp14.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2025 11:17:24 +0200
Received: from MUCSE835.infineon.com (172.23.7.107) by MUCSE819.infineon.com
 (172.23.29.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 4 Jun 2025
 11:17:24 +0200
Received: from iot-wlan-dev-u03.aus.cypress.com (10.161.6.196) by
 MUCSE835.infineon.com (172.23.7.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 4 Jun 2025 11:17:22 +0200
From: Ian Lin <ian.lin@infineon.com>
To: <johannes@sipsolutions.net>, <arend.vanspriel@broadcom.com>
CC: <linux-wireless@vger.kernel.org>, <brcm80211@lists.linux.dev>,
	<carter.chen@infineon.com>, <double.lo@infineon.com>,
	<vinoth.sampath@infineon.com>, <gokulkumar.sivakumar@infineon.com>,
	<ian.lin@infineon.com>
Subject: [PATCH wireless-next 1/4] wifi: brcmfmac: don't allow arp/nd offload to be enabled if ap mode exists
Date: Wed, 4 Jun 2025 04:16:26 -0500
Message-ID: <20250604091629.3943-2-ian.lin@infineon.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20250604091629.3943-1-ian.lin@infineon.com>
References: <20250604091629.3943-1-ian.lin@infineon.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MUCSE802.infineon.com (172.23.29.28) To
 MUCSE835.infineon.com (172.23.7.107)

From: Ting-Ying Li <tingying.li@cypress.com>

Add a check to determine whether arp/nd offload enabling
request is allowed. If there is any interface acts as ap
mode and is operating, reject the request of arp offload
enabling from cfg80211.

Signed-off-by: Ting-Ying Li <tingying.li@cypress.com>
Signed-off-by: Ian Lin <ian.lin@infineon.com>
---
 .../broadcom/brcm80211/brcmfmac/cfg80211.c      | 17 ++++++++++++++++-
 .../broadcom/brcm80211/brcmfmac/cfg80211.h      |  1 +
 .../wireless/broadcom/brcm80211/brcmfmac/core.c |  5 +++++
 3 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
index dc2383faddd1..2e06fd0dbb2a 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
@@ -1043,6 +1043,21 @@ void brcmf_set_mpc(struct brcmf_if *ifp, int mpc)
 	}
 }
 
+bool brcmf_is_apmode_operating(struct wiphy *wiphy)
+{
+	struct brcmf_cfg80211_info *cfg = wiphy_to_cfg(wiphy);
+	struct brcmf_cfg80211_vif *vif;
+	bool ret = false;
+
+	list_for_each_entry(vif, &cfg->vif_list, list) {
+		if (brcmf_is_apmode(vif) &&
+		    test_bit(BRCMF_VIF_STATUS_AP_CREATED, &vif->sme_state))
+			ret = true;
+	}
+
+	return ret;
+}
+
 static void brcmf_scan_params_v2_to_v1(struct brcmf_scan_params_v2_le *params_v2_le,
 				       struct brcmf_scan_params_le *params_le)
 {
@@ -5416,8 +5431,8 @@ static int brcmf_cfg80211_stop_ap(struct wiphy *wiphy, struct net_device *ndev,
 			bphy_err(drvr, "bss_enable config failed %d\n", err);
 	}
 	brcmf_set_mpc(ifp, 1);
-	brcmf_configure_arp_nd_offload(ifp, true);
 	clear_bit(BRCMF_VIF_STATUS_AP_CREATED, &ifp->vif->sme_state);
+	brcmf_configure_arp_nd_offload(ifp, true);
 	brcmf_net_setcarrier(ifp, false);
 
 	return err;
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.h b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.h
index b83485ec7b87..273c80f2d483 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.h
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.h
@@ -487,6 +487,7 @@ s32 brcmf_notify_escan_complete(struct brcmf_cfg80211_info *cfg,
 				struct brcmf_if *ifp, bool aborted,
 				bool fw_abort);
 void brcmf_set_mpc(struct brcmf_if *ndev, int mpc);
+bool brcmf_is_apmode_operating(struct wiphy *wiphy);
 void brcmf_abort_scanning(struct brcmf_cfg80211_info *cfg);
 void brcmf_cfg80211_free_netdev(struct net_device *ndev);
 
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
index 04f41c09deca..862a0336a0b5 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
@@ -98,6 +98,11 @@ void brcmf_configure_arp_nd_offload(struct brcmf_if *ifp, bool enable)
 	s32 err;
 	u32 mode;
 
+	if (enable && brcmf_is_apmode_operating(ifp->drvr->wiphy)) {
+		brcmf_dbg(TRACE, "Skip ARP/ND offload enable when soft AP is running\n");
+		return;
+	}
+
 	if (enable)
 		mode = BRCMF_ARP_OL_AGENT | BRCMF_ARP_OL_PEER_AUTO_REPLY;
 	else
-- 
2.25.0


