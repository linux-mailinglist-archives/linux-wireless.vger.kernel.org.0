Return-Path: <linux-wireless+bounces-23688-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 154C9ACDAC0
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Jun 2025 11:17:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4B501898481
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Jun 2025 09:17:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D7851EFF81;
	Wed,  4 Jun 2025 09:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b="Lb5UNkV2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp9.infineon.com (smtp9.infineon.com [217.10.52.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 606D5223DCF
	for <linux-wireless@vger.kernel.org>; Wed,  4 Jun 2025 09:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.10.52.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749028650; cv=none; b=dd2R7PDgl4cozK35W0Ca40DIwQES7q7qKpb4rFqkwEy7rhOziT3kQOr02CbA4Gx2069gHM6AqkcOGjoslB863rQSHRdip/n+okpseL6J7oNEKFNM6Zk31XgWavMY5+M3C85Cp9WTLWqOm31Ei+qr4km5TzXqMX/001YpGnV8PqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749028650; c=relaxed/simple;
	bh=CyqMLRryBn9l9XIH2T7ru7R5sDOJbbCDv+b4CO0v3NQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M66cDMlo2PxLJlXy+Qoib4WFV8roTFFNWx4A/KY5qj+yG0+TRT9ycmYq1r59DaX1jUfeW0vOY76aV9izLeZa01Vjubd+znndCOT1CYEMGZfBY91llwBxAag94F3v0zybIv7kFoIqjIHAHFgM97Z3T3WZt03om1rbl7bilGukEqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com; spf=pass smtp.mailfrom=infineon.com; dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b=Lb5UNkV2; arc=none smtp.client-ip=217.10.52.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infineon.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1749028649; x=1780564649;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CyqMLRryBn9l9XIH2T7ru7R5sDOJbbCDv+b4CO0v3NQ=;
  b=Lb5UNkV2GHeU1kx/dGJ1Kr7jqDLygOr+QRlMIgUSPV1v+QR9PEDrxbK2
   frbFHX7MAL+RrorXalUF+ILRLfWy4Z0GsayVvbTllWmVrj6C+lfANZM98
   FCpV0ipXtVlZwwyYadV0KGhlM2Btzzc1On3D2QLKtxiFHYLM/ktpoK8MV
   0=;
X-CSE-ConnectionGUID: 4FI2pH4gRcigrLY/tUs9ow==
X-CSE-MsgGUID: SSPwCDCATHW2wNFVhF6yzg==
X-IronPort-AV: E=McAfee;i="6700,10204,11453"; a="53598474"
X-IronPort-AV: E=Sophos;i="6.16,208,1744063200"; 
   d="scan'208";a="53598474"
Received: from unknown (HELO MUCSE814.infineon.com) ([172.23.29.40])
  by smtp9.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2025 11:17:27 +0200
Received: from MUCSE835.infineon.com (172.23.7.107) by MUCSE814.infineon.com
 (172.23.29.40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 4 Jun
 2025 11:17:26 +0200
Received: from iot-wlan-dev-u03.aus.cypress.com (10.161.6.196) by
 MUCSE835.infineon.com (172.23.7.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 4 Jun 2025 11:17:24 +0200
From: Ian Lin <ian.lin@infineon.com>
To: <johannes@sipsolutions.net>, <arend.vanspriel@broadcom.com>
CC: <linux-wireless@vger.kernel.org>, <brcm80211@lists.linux.dev>,
	<carter.chen@infineon.com>, <double.lo@infineon.com>,
	<vinoth.sampath@infineon.com>, <gokulkumar.sivakumar@infineon.com>,
	<ian.lin@infineon.com>
Subject: [PATCH wireless-next 2/4] wifi: brcmfmac: revise SoftAP channel setting
Date: Wed, 4 Jun 2025 04:16:27 -0500
Message-ID: <20250604091629.3943-3-ian.lin@infineon.com>
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

Fmac need to update "chanspec" iovar for each SoftAP creation
because firmware will update the chanspec to current bsscfg
for each bss. If it doesn't update then the wrong chanspec
will be shown on the result of 'wl -i [interface] status'
command. No need to handle channel resource reusing for mbss
mode by the host driver, it should be covered by firmware.

Signed-off-by: Ting-Ying Li <tingying.li@cypress.com>
Signed-off-by: Ian Lin <ian.lin@infineon.com>
---
 .../broadcom/brcm80211/brcmfmac/cfg80211.c    | 20 +++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
index 2e06fd0dbb2a..820dc5fee730 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
@@ -5248,17 +5248,17 @@ brcmf_cfg80211_start_ap(struct wiphy *wiphy, struct net_device *ndev,
 				 err);
 			goto exit;
 		}
-		if (!mbss) {
-			/* Firmware 10.x requires setting channel after enabling
-			 * AP and before bringing interface up.
-			 */
-			err = brcmf_fil_iovar_int_set(ifp, "chanspec", chanspec);
-			if (err < 0) {
-				bphy_err(drvr, "Set Channel failed: chspec=%d, %d\n",
-					 chanspec, err);
-				goto exit;
-			}
+
+		/* Firmware 10.x requires setting channel after enabling
+		 * AP and before bringing interface up.
+		 */
+		err = brcmf_fil_iovar_int_set(ifp, "chanspec", chanspec);
+		if (err < 0) {
+			bphy_err(drvr, "Set Channel failed: chspec=%d, %d\n",
+				 chanspec, err);
+			goto exit;
 		}
+
 		err = brcmf_fil_cmd_int_set(ifp, BRCMF_C_UP, 1);
 		if (err < 0) {
 			bphy_err(drvr, "BRCMF_C_UP error (%d)\n", err);
-- 
2.25.0


