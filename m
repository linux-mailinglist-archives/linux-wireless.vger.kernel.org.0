Return-Path: <linux-wireless+bounces-23689-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFCE3ACDAC1
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Jun 2025 11:17:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BC0A3A51A9
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Jun 2025 09:17:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0E6C22F770;
	Wed,  4 Jun 2025 09:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b="Qf45TxzD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp11.infineon.com (smtp11.infineon.com [217.10.52.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4B7D28C852
	for <linux-wireless@vger.kernel.org>; Wed,  4 Jun 2025 09:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.10.52.105
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749028652; cv=none; b=Bo2q6dU0sdGI/Q9BrOZGk/KJijMhI5c7b3AjSN68LFSSxIskTI/cnNxCF3LGWsiI5mAecEZIKCqpsbzkYmBvBUoy7RVHng+4ka7JhligY7S0sVt7HY4yhVhr4omD0tfmZy8ikpb2KnAt6IgsURdB+gHCnHHPYjE+h+pwoRtO9s8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749028652; c=relaxed/simple;
	bh=LKNvXTo84MWzYran1behIq/Jj5ZiNQ9EmI8LiVEefZY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sFh5+AZ2ScH3X12v7CU95qvZDJjfIjP31pXANV7hpbh43mKgKl4z7NMTKEMweMcKK2ZO/aSSNSMXhYGQdqpsn7I+js8R094YkgP53r5CFJtt9kl60cw0WsP1qL3yumvj6AB1Iv9lQB78Qh/UIF81zEp9NdwRaPqi5mkIZdNvRnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com; spf=pass smtp.mailfrom=infineon.com; dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b=Qf45TxzD; arc=none smtp.client-ip=217.10.52.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infineon.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1749028651; x=1780564651;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LKNvXTo84MWzYran1behIq/Jj5ZiNQ9EmI8LiVEefZY=;
  b=Qf45TxzDNWNroiyjZYDBNSRwWc/APh/nik1J/kFnIIIGKvUT6Cp4bAPa
   ZiP5gLT/OVlGsEkSOivSDUW+nfkljCGdLQutt2MyEUmBVoA1bAhc7TbVY
   +XWZEye2P5XroUk/k0Y43h3EgzdpZCSLJuH+V05Vd1w4cARO4vU7Zbdo/
   w=;
X-CSE-ConnectionGUID: Tz2lSurhQY+TpIxwdc1xbg==
X-CSE-MsgGUID: pPEtBT14RVe5dC77V4KPNw==
X-IronPort-AV: E=McAfee;i="6700,10204,11453"; a="97807167"
X-IronPort-AV: E=Sophos;i="6.16,208,1744063200"; 
   d="scan'208";a="97807167"
Received: from unknown (HELO MUCSE812.infineon.com) ([172.23.29.38])
  by smtp11.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2025 11:17:29 +0200
Received: from MUCSE835.infineon.com (172.23.7.107) by MUCSE812.infineon.com
 (172.23.29.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 4 Jun
 2025 11:17:28 +0200
Received: from iot-wlan-dev-u03.aus.cypress.com (10.161.6.196) by
 MUCSE835.infineon.com (172.23.7.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 4 Jun 2025 11:17:26 +0200
From: Ian Lin <ian.lin@infineon.com>
To: <johannes@sipsolutions.net>, <arend.vanspriel@broadcom.com>
CC: <linux-wireless@vger.kernel.org>, <brcm80211@lists.linux.dev>,
	<carter.chen@infineon.com>, <double.lo@infineon.com>,
	<vinoth.sampath@infineon.com>, <gokulkumar.sivakumar@infineon.com>,
	<ian.lin@infineon.com>
Subject: [PATCH wireless-next 3/4] wifi: brcmfmac: Improve the delay during scan
Date: Wed, 4 Jun 2025 04:16:28 -0500
Message-ID: <20250604091629.3943-4-ian.lin@infineon.com>
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

From: Kurt Lee <kurt.lee@cypress.com>

wpa_supplicant sends NL80211_CMD_GET_SURVEY command every time after
normal scan, which causes brcmfmac surveying each channel again.
Currently brcmfmac implments brcmf_cfg80211_dump_survey focusing on AP
mode, thus this change will return the request other than AP mode.

Signed-off-by: Kurt Lee <kurt.lee@cypress.com>
Signed-off-by: Ian Lin <ian.lin@infineon.com>
---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
index 820dc5fee730..e23cd6fc0f56 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
@@ -8122,6 +8122,9 @@ brcmf_cfg80211_dump_survey(struct wiphy *wiphy, struct net_device *ndev,
 
 	brcmf_dbg(TRACE, "Enter: channel idx=%d\n", idx);
 
+	if (!brcmf_is_apmode(ifp->vif))
+		return -ENOENT;
+
 	/* Do not run survey when VIF in CONNECTING / CONNECTED states */
 	if ((test_bit(BRCMF_VIF_STATUS_CONNECTING, &ifp->vif->sme_state)) ||
 	    (test_bit(BRCMF_VIF_STATUS_CONNECTED, &ifp->vif->sme_state))) {
-- 
2.25.0


