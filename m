Return-Path: <linux-wireless+bounces-24513-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 05326AE950E
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Jun 2025 07:07:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64EBF4A4A61
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Jun 2025 05:07:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D534211A31;
	Thu, 26 Jun 2025 05:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b="HG95pDcG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp11.infineon.com (smtp11.infineon.com [217.10.52.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A50038FB9
	for <linux-wireless@vger.kernel.org>; Thu, 26 Jun 2025 05:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.10.52.105
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750914446; cv=none; b=o7hXAX/XqXomlPOjbJekdIz08xiK9rzsr37TeMTY5WhFdetYWLz94WBpGWkdYwA1TYtcgKyeEVgn3un/+w2QRNqMoqVOBDPL8nzjPWaBmbN+J4Xl4n9GeBqqh4uHz5dc3PNacJR1zX03F7ZGoTxrybLEWGDSXY1oWM0D9HguGvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750914446; c=relaxed/simple;
	bh=AKzivFgfGZhK3wNXIzhi9adSJDcnzcuv1iu4Tm7CEEA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tIpLieRvElMmW/G4pkZn9Ub0wcatEtQAFnmuV5sSKoBEX1Xg0nkRliLnrznQXh22ejj4mdAFavUslDApPE4OICEyxGd714mG/5ffOLvCwI2bqql7Z/HXqcRqTRP0RCqbUsFbeySbNhobNb7STuBq41AeOrVtEp9Jl7asEUv33Tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com; spf=pass smtp.mailfrom=infineon.com; dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b=HG95pDcG; arc=none smtp.client-ip=217.10.52.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infineon.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1750914445; x=1782450445;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=AKzivFgfGZhK3wNXIzhi9adSJDcnzcuv1iu4Tm7CEEA=;
  b=HG95pDcGBnKKYtyuFeJcBRX8OSWsJfuTSYeKHtr353VChQuJoQVGOMsn
   CALZE9UFztS0aKn28n8hZepSB1fvbBX06b/heVbSxFrh87vQZMncIkr2V
   n/+UXlc6mSEqnJsfFcv7wGT3iRHPpPoTlgJe9yE2DYgHKz59Vi6G0TEec
   k=;
X-CSE-ConnectionGUID: vyOfOD71QpGY40oDNjpARg==
X-CSE-MsgGUID: HhGv3IpLR3a5jVKNVkZdWg==
X-IronPort-AV: E=McAfee;i="6800,10657,11475"; a="100358752"
X-IronPort-AV: E=Sophos;i="6.16,266,1744063200"; 
   d="scan'208";a="100358752"
Received: from unknown (HELO MUCSE819.infineon.com) ([172.23.29.45])
  by smtp11.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2025 07:07:23 +0200
Received: from MUCSE827.infineon.com (172.23.29.20) by MUCSE819.infineon.com
 (172.23.29.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 26 Jun
 2025 07:07:22 +0200
Received: from ISCN5CG14747PP.infineon.com (10.161.6.196) by
 MUCSE827.infineon.com (172.23.29.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 26 Jun 2025 07:07:20 +0200
From: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>
To: Arend van Spriel <arend.vanspriel@broadcom.com>, Johannes Berg
	<johannes.berg@intel.com>
CC: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>,
	<linux-wireless@vger.kernel.org>, <brcm80211@lists.linux.dev>,
	<wlan-kernel-dev-list@infineon.com>
Subject: [PATCH wireless-next RESEND] wifi: brcmfmac: fix P2P discovery failure in P2P peer due to missing P2P IE
Date: Thu, 26 Jun 2025 10:37:02 +0530
Message-ID: <20250626050706.7271-1-gokulkumar.sivakumar@infineon.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MUCSE819.infineon.com (172.23.29.45) To
 MUCSE827.infineon.com (172.23.29.20)

After commit bd99a3013bdc ("brcmfmac: move configuration of probe request
IEs"), the probe request MGMT IE addition operation brcmf_vif_set_mgmt_ie()
got moved from the brcmf_p2p_scan_prep() to the brcmf_cfg80211_scan().

Because of this, as part of the scan request handler for the P2P Discovery,
vif struct used for adding the Probe Request P2P IE in firmware got changed
from the P2PAPI_BSSCFG_DEVICE vif to P2PAPI_BSSCFG_PRIMARY vif incorrectly.
So the firmware stopped adding P2P IE to the outgoing P2P Discovery probe
requests frames and the other P2P peers were unable to discover this device
causing a regression on the P2P feature.

To fix this, while setting the P2P IE in firmware, properly use the vif of
the P2P discovery wdev on which the driver received the P2P scan request.
This is done by not changing the vif pointer, until brcmf_vif_set_mgmt_ie()
is completed.

Fixes: bd99a3013bdc ("brcmfmac: move configuration of probe request IEs")
Signed-off-by: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>
---
 .../net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c   | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
index 4b70845e1a26..075b99478e65 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
@@ -1545,10 +1545,6 @@ brcmf_cfg80211_scan(struct wiphy *wiphy, struct cfg80211_scan_request *request)
 		return -EAGAIN;
 	}
 
-	/* If scan req comes for p2p0, send it over primary I/F */
-	if (vif == cfg->p2p.bss_idx[P2PAPI_BSSCFG_DEVICE].vif)
-		vif = cfg->p2p.bss_idx[P2PAPI_BSSCFG_PRIMARY].vif;
-
 	brcmf_dbg(SCAN, "START ESCAN\n");
 
 	cfg->scan_request = request;
@@ -1564,6 +1560,10 @@ brcmf_cfg80211_scan(struct wiphy *wiphy, struct cfg80211_scan_request *request)
 	if (err)
 		goto scan_out;
 
+	/* If scan req comes for p2p0, send it over primary I/F */
+	if (vif == cfg->p2p.bss_idx[P2PAPI_BSSCFG_DEVICE].vif)
+		vif = cfg->p2p.bss_idx[P2PAPI_BSSCFG_PRIMARY].vif;
+
 	err = brcmf_do_escan(vif->ifp, request);
 	if (err)
 		goto scan_out;
-- 
2.43.0


