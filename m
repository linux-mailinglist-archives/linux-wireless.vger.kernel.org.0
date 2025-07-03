Return-Path: <linux-wireless+bounces-24789-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85704AF729B
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Jul 2025 13:39:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 690394E2C21
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Jul 2025 11:37:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6612D23B630;
	Thu,  3 Jul 2025 11:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b="EpeLuLZF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp14.infineon.com (smtp14.infineon.com [217.10.52.160])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C6AB261591
	for <linux-wireless@vger.kernel.org>; Thu,  3 Jul 2025 11:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.10.52.160
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751542655; cv=none; b=SlIzDnwOa1u4SiRAVnjYVlKeA8gVseGHxYsHBAtWu3kuQFOvj6roPIPFubdmiQt5tFWk9sf+gItF/+TkV5erL/qz/cJX65QET85gpmlIm6xSuScpOkTBRmClTaRj+64dKTp3Xup2MRtSPSGxEPEwnUsnTXaUraQEvGTQTN6sFx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751542655; c=relaxed/simple;
	bh=afAQNldEH9D37rnb+6FmjpuPSAP5CJbJLlvdHp4Z0MQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NaSu5qvfEO7ShR/K9a4C6DX6YSOn8HHQcla33HHp2dP0x3PjsU+hT4zWmYL3ynp5cFGz/1PM79Lg9zCx0gY4WJ5t6rNBeld1CqbN1YXEHdL65m3tHk3Ao+4y8nWyKL8FSz8u85JDty2vddFBzwZY4XmUpb7AigmvWnfjcOt+JVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com; spf=pass smtp.mailfrom=infineon.com; dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b=EpeLuLZF; arc=none smtp.client-ip=217.10.52.160
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infineon.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1751542652; x=1783078652;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=afAQNldEH9D37rnb+6FmjpuPSAP5CJbJLlvdHp4Z0MQ=;
  b=EpeLuLZFdJxAFSSqowTu4MHOlpsts0wxu+L842YrktIDGpUWLdp8IpDA
   yX3TEs08vi4+tnHttZzQJzte5wpmDCHs3Y4zvepTAZZPt4y1AFskFWj9G
   cHIhFD8/1s4c9WTqCOqoLtKuPd954hHROevdgCDkofBVSR1zZK8Wvo5AB
   4=;
X-CSE-ConnectionGUID: vxXFY7DbQJCnlYJh9FkGcA==
X-CSE-MsgGUID: Utn8g6mrTvSzm0U8uyfaiQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11482"; a="90407361"
X-IronPort-AV: E=Sophos;i="6.16,284,1744063200"; 
   d="scan'208";a="90407361"
Received: from unknown (HELO MUCSE819.infineon.com) ([172.23.29.45])
  by smtp14.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2025 13:36:20 +0200
Received: from MUCSE827.infineon.com (172.23.29.20) by MUCSE819.infineon.com
 (172.23.29.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 3 Jul
 2025 13:36:19 +0200
Received: from ISCN5CG14747PP.infineon.com (10.161.6.196) by
 MUCSE827.infineon.com (172.23.29.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 3 Jul 2025 13:36:17 +0200
From: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>
To: Johannes Berg <johannes@sipsolutions.net>, Arend van Spriel
	<arend.vanspriel@broadcom.com>
CC: <linux-wireless@vger.kernel.org>, <brcm80211@lists.linux.dev>,
	<wlan-kernel-dev-list@infineon.com>, <gokulkumar.sivakumar@infineon.com>
Subject: [PATCH] wifi: brcmfmac: fix EXTSAE WPA3 connection failure due to AUTH TX failure
Date: Thu, 3 Jul 2025 17:03:39 +0530
Message-ID: <20250703113339.6356-1-gokulkumar.sivakumar@infineon.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MUCSE823.infineon.com (172.23.29.54) To
 MUCSE827.infineon.com (172.23.29.20)

From: Ting-Ying Li <tingying.li@cypress.com>

For WPA3-SAE Connection in EXTSAE mode, the userspace daemon is allowed to
generate the SAE Auth frames. The driver uses the "mgmt_frame" FW IOVAR to
transmit this MGMT frame.

Before sending the IOVAR, the Driver is incorrectly treating the channel
number read from the FW as a frequency value and again attempts to convert
this into a channel number using ieee80211_frequency_to_channel().

This added an invalid channel number as part of the IOVAR request to the FW
And some FW which strictly expects a valid channel would return BAD_CHAN
error, while failing to transmit the driver requested SAE Auth MGMT frame.

Fix this in the CYW vendor specific MGMT TX cfg80211 ops handler, by not
treating the channel number read from the FW as frequency value and skip
the attempt to convert it again into a channel number.

Also fix this in the generic MGMT TX cfg80211 ops handler.

Fixes: c2ff8cad6423 ("brcm80211: make mgmt_tx in brcmfmac accept a NULL channel")
Fixes: 66f909308a7c ("wifi: brcmfmac: cyw: support external SAE authentication in station mode")
Signed-off-by: Ting-Ying Li <tingying.li@cypress.com>
Signed-off-by: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>
---
 .../broadcom/brcm80211/brcmfmac/cfg80211.c    | 21 +++++++++++--------
 .../broadcom/brcm80211/brcmfmac/cyw/core.c    | 19 ++++++++++-------
 2 files changed, 23 insertions(+), 17 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
index 40a9a8177de6..cecaca194979 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
@@ -5545,7 +5545,7 @@ brcmf_cfg80211_mgmt_tx(struct wiphy *wiphy, struct wireless_dev *wdev,
 	struct brcmf_fil_af_params_le *af_params;
 	bool ack;
 	s32 chan_nr;
-	u32 freq;
+	u32 hw_channel;
 
 	brcmf_dbg(TRACE, "Enter\n");
 
@@ -5606,19 +5606,22 @@ brcmf_cfg80211_mgmt_tx(struct wiphy *wiphy, struct wireless_dev *wdev,
 		/* Add the channel. Use the one specified as parameter if any or
 		 * the current one (got from the firmware) otherwise
 		 */
-		if (chan)
-			freq = chan->center_freq;
-		else
+		if (chan) {
+			chan_nr = ieee80211_frequency_to_channel(chan->center_freq);
+			af_params->channel = cpu_to_le32(chan_nr);
+		} else {
 			brcmf_fil_cmd_int_get(vif->ifp, BRCMF_C_GET_CHANNEL,
-					      &freq);
-		chan_nr = ieee80211_frequency_to_channel(freq);
-		af_params->channel = cpu_to_le32(chan_nr);
+					      &hw_channel);
+			af_params->channel = hw_channel;
+		}
+
 		af_params->dwell_time = cpu_to_le32(params->wait);
 		memcpy(action_frame->data, &buf[DOT11_MGMT_HDR_LEN],
 		       le16_to_cpu(action_frame->len));
 
-		brcmf_dbg(TRACE, "Action frame, cookie=%lld, len=%d, freq=%d\n",
-			  *cookie, le16_to_cpu(action_frame->len), freq);
+		brcmf_dbg(TRACE, "Action frame, cookie=%lld, len=%d, channel=%d\n",
+			  *cookie, le16_to_cpu(action_frame->len),
+			  le32_to_cpu(af_params->channel));
 
 		ack = brcmf_p2p_send_action_frame(cfg, cfg_to_ndev(cfg),
 						  af_params);
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/core.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/core.c
index c9537fb597ce..57d7c32e517c 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/core.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/core.c
@@ -113,10 +113,10 @@ int brcmf_cyw_mgmt_tx(struct wiphy *wiphy, struct wireless_dev *wdev,
 	s32 err = 0;
 	bool ack = false;
 	s32 chan_nr;
-	u32 freq;
 	struct brcmf_mf_params_le *mf_params;
 	u32 mf_params_len;
 	s32 ready;
+	u32 hw_channel;
 
 	brcmf_dbg(TRACE, "Enter\n");
 
@@ -143,13 +143,15 @@ int brcmf_cyw_mgmt_tx(struct wiphy *wiphy, struct wireless_dev *wdev,
 	mf_params->len = cpu_to_le16(len - DOT11_MGMT_HDR_LEN);
 	mf_params->frame_control = mgmt->frame_control;
 
-	if (chan)
-		freq = chan->center_freq;
-	else
+	if (chan) {
+		chan_nr = ieee80211_frequency_to_channel(chan->center_freq);
+		mf_params->channel = cpu_to_le32(chan_nr);
+	} else {
 		brcmf_fil_cmd_int_get(vif->ifp, BRCMF_C_GET_CHANNEL,
-				      &freq);
-	chan_nr = ieee80211_frequency_to_channel(freq);
-	mf_params->channel = cpu_to_le16(chan_nr);
+				      &hw_channel);
+		mf_params->channel = hw_channel;
+	}
+
 	memcpy(&mf_params->da[0], &mgmt->da[0], ETH_ALEN);
 	memcpy(&mf_params->bssid[0], &mgmt->bssid[0], ETH_ALEN);
 	mf_params->packet_id = cpu_to_le32(*cookie);
@@ -159,7 +161,8 @@ int brcmf_cyw_mgmt_tx(struct wiphy *wiphy, struct wireless_dev *wdev,
 	brcmf_dbg(TRACE, "Auth frame, cookie=%d, fc=%04x, len=%d, channel=%d\n",
 		  le32_to_cpu(mf_params->packet_id),
 		  le16_to_cpu(mf_params->frame_control),
-		  le16_to_cpu(mf_params->len), chan_nr);
+		  le16_to_cpu(mf_params->len),
+		  le32_to_cpu(mf_params->channel));
 
 	vif->mgmt_tx_id = le32_to_cpu(mf_params->packet_id);
 	set_bit(BRCMF_MGMT_TX_SEND_FRAME, &vif->mgmt_tx_status);
-- 
2.43.0


