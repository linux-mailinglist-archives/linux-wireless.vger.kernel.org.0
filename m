Return-Path: <linux-wireless+bounces-24792-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12925AF7632
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Jul 2025 15:54:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B9F64A8569
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Jul 2025 13:53:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEC7E2E612E;
	Thu,  3 Jul 2025 13:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b="ZUPvJCt2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp9.infineon.com (smtp9.infineon.com [217.10.52.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E6F617332C
	for <linux-wireless@vger.kernel.org>; Thu,  3 Jul 2025 13:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.10.52.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751550838; cv=none; b=Av/Ni99HO3RkoeP8FOG9MYEEcwZfP5t2cIF92o122SMWY+oNJV3gZ/DRkA6Vzj39sDJQTvzt5DEbHpnWJXha6D/W5LyP2GokjLJxi61bruUQfu4iXfMj3pHl4EnAAZnsC2pVp5oEuZv3hWxIu/prZWU07uZbJkwccceeRXlTgj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751550838; c=relaxed/simple;
	bh=6jRudO0+LIFk9WSrywnOWGs8Lzh1HFDF7jGrPpfbeGA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=am9kpX3Y2mLjEvtJF4h+KiP3Oxhr14QixWrsCO2HpQtg9Bi4DA/+OeE4VrU+QaOd6Yuu9WdHYRHXMTVDM8Eb3e56f9479IaiiQnPq8GRMCUGEcwhjnfBphfim+G+VaoemnW9wc9ZtbGwmJ/jg2qoKBpRw0qqLin7ls3EihKojJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com; spf=pass smtp.mailfrom=infineon.com; dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b=ZUPvJCt2; arc=none smtp.client-ip=217.10.52.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infineon.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1751550836; x=1783086836;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=6jRudO0+LIFk9WSrywnOWGs8Lzh1HFDF7jGrPpfbeGA=;
  b=ZUPvJCt2y+5hzgI35EnZFFh9jOZYtQaONO6PRvyoW0Ga+HLQCshH7hBW
   zgkoGGXFbeh2Zht9A8/ILVsYQ2FIEbZQYY3TMxQqBevGdCjO4AP20f6mH
   TzRe2Kk/lFz1yfsoVcHaEueeld+/agfjKBFE8tkDB+f6wEnuq091FxbhS
   w=;
X-CSE-ConnectionGUID: XF5XJ/vlQQ2yDWZxKxcpbA==
X-CSE-MsgGUID: QGOMRJHcQ5W8WAdkG2n9Wg==
X-IronPort-AV: E=McAfee;i="6800,10657,11483"; a="56643547"
X-IronPort-AV: E=Sophos;i="6.16,284,1744063200"; 
   d="scan'208";a="56643547"
Received: from unknown (HELO MUCSE822.infineon.com) ([172.23.29.53])
  by smtp9.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2025 15:53:48 +0200
Received: from MUCSE827.infineon.com (172.23.29.20) by MUCSE822.infineon.com
 (172.23.29.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 3 Jul
 2025 15:53:47 +0200
Received: from ISCN5CG14747PP.infineon.com (10.161.6.196) by
 MUCSE827.infineon.com (172.23.29.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 3 Jul 2025 15:53:45 +0200
From: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>
To: Johannes Berg <johannes@sipsolutions.net>, Arend van Spriel
	<arend.vanspriel@broadcom.com>
CC: <linux-wireless@vger.kernel.org>, <brcm80211@lists.linux.dev>,
	<wlan-kernel-dev-list@infineon.com>, <gokulkumar.sivakumar@infineon.com>
Subject: [PATCH wireless-next v2] wifi: brcmfmac: fix EXTSAE WPA3 connection failure due to AUTH TX failure
Date: Thu, 3 Jul 2025 19:23:07 +0530
Message-ID: <20250703135307.7433-1-gokulkumar.sivakumar@infineon.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MUCSE814.infineon.com (172.23.29.40) To
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

v2:
  * Fixed wifibot "warning: incorrect type in assignment (different base types)"
    in cyw/core.c file.

  * Fixed >80 line length checkpatch warning by reducing variable name len
    in cfg80211.c file.

  * Handled the return value of the BRCMF_C_GET_CHANNEL IOCTL Read operation
    in cfg80211.c & cyw/core.c files.

 .../broadcom/brcm80211/brcmfmac/cfg80211.c    | 32 ++++++++++++-------
 .../broadcom/brcm80211/brcmfmac/cyw/core.c    | 29 +++++++++++------
 2 files changed, 40 insertions(+), 21 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
index 501820411443..a8eb006b6c1b 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
@@ -5527,8 +5527,7 @@ brcmf_cfg80211_mgmt_tx(struct wiphy *wiphy, struct wireless_dev *wdev,
 	struct brcmf_fil_action_frame_le *action_frame;
 	struct brcmf_fil_af_params_le *af_params;
 	bool ack;
-	s32 chan_nr;
-	u32 freq;
+	s32 ch, hw_ch;
 
 	brcmf_dbg(TRACE, "Enter\n");
 
@@ -5589,25 +5588,36 @@ brcmf_cfg80211_mgmt_tx(struct wiphy *wiphy, struct wireless_dev *wdev,
 		/* Add the channel. Use the one specified as parameter if any or
 		 * the current one (got from the firmware) otherwise
 		 */
-		if (chan)
-			freq = chan->center_freq;
-		else
-			brcmf_fil_cmd_int_get(vif->ifp, BRCMF_C_GET_CHANNEL,
-					      &freq);
-		chan_nr = ieee80211_frequency_to_channel(freq);
-		af_params->channel = cpu_to_le32(chan_nr);
+		if (chan) {
+			ch = ieee80211_frequency_to_channel(chan->center_freq);
+			af_params->channel = cpu_to_le32(ch);
+		} else {
+			err = brcmf_fil_cmd_int_get(vif->ifp,
+						    BRCMF_C_GET_CHANNEL,
+						    &hw_ch);
+			if (err) {
+				bphy_err(drvr,
+					 "unable to get current hw channel\n");
+				goto free;
+			} else {
+				af_params->channel = hw_ch;
+			}
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
 
 		cfg80211_mgmt_tx_status(wdev, *cookie, buf, len, ack,
 					GFP_KERNEL);
+free:
 		kfree(af_params);
 	} else {
 		brcmf_dbg(TRACE, "Unhandled, fc=%04x!!\n", mgmt->frame_control);
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/core.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/core.c
index c9537fb597ce..28a014ede05f 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/core.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/core.c
@@ -112,8 +112,7 @@ int brcmf_cyw_mgmt_tx(struct wiphy *wiphy, struct wireless_dev *wdev,
 	struct brcmf_cfg80211_vif *vif;
 	s32 err = 0;
 	bool ack = false;
-	s32 chan_nr;
-	u32 freq;
+	s32 ch, hw_ch;
 	struct brcmf_mf_params_le *mf_params;
 	u32 mf_params_len;
 	s32 ready;
@@ -143,13 +142,21 @@ int brcmf_cyw_mgmt_tx(struct wiphy *wiphy, struct wireless_dev *wdev,
 	mf_params->len = cpu_to_le16(len - DOT11_MGMT_HDR_LEN);
 	mf_params->frame_control = mgmt->frame_control;
 
-	if (chan)
-		freq = chan->center_freq;
-	else
-		brcmf_fil_cmd_int_get(vif->ifp, BRCMF_C_GET_CHANNEL,
-				      &freq);
-	chan_nr = ieee80211_frequency_to_channel(freq);
-	mf_params->channel = cpu_to_le16(chan_nr);
+	if (chan) {
+		ch = ieee80211_frequency_to_channel(chan->center_freq);
+		mf_params->channel = cpu_to_le16(ch);
+	} else {
+		err = brcmf_fil_cmd_int_get(vif->ifp,
+					    BRCMF_C_GET_CHANNEL,
+					    &hw_ch);
+		if (err) {
+			bphy_err(drvr, "unable to get current hw channel\n");
+			goto free;
+		} else {
+			mf_params->channel = hw_ch;
+		}
+	}
+
 	memcpy(&mf_params->da[0], &mgmt->da[0], ETH_ALEN);
 	memcpy(&mf_params->bssid[0], &mgmt->bssid[0], ETH_ALEN);
 	mf_params->packet_id = cpu_to_le32(*cookie);
@@ -159,7 +166,8 @@ int brcmf_cyw_mgmt_tx(struct wiphy *wiphy, struct wireless_dev *wdev,
 	brcmf_dbg(TRACE, "Auth frame, cookie=%d, fc=%04x, len=%d, channel=%d\n",
 		  le32_to_cpu(mf_params->packet_id),
 		  le16_to_cpu(mf_params->frame_control),
-		  le16_to_cpu(mf_params->len), chan_nr);
+		  le16_to_cpu(mf_params->len),
+		  le16_to_cpu(mf_params->channel));
 
 	vif->mgmt_tx_id = le32_to_cpu(mf_params->packet_id);
 	set_bit(BRCMF_MGMT_TX_SEND_FRAME, &vif->mgmt_tx_status);
@@ -185,6 +193,7 @@ int brcmf_cyw_mgmt_tx(struct wiphy *wiphy, struct wireless_dev *wdev,
 tx_status:
 	cfg80211_mgmt_tx_status(wdev, *cookie, buf, len, ack,
 				GFP_KERNEL);
+free:
 	kfree(mf_params);
 	return err;
 }
-- 
2.47.0


