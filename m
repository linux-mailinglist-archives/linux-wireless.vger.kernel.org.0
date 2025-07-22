Return-Path: <linux-wireless+bounces-25795-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 341E6B0D0EE
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Jul 2025 06:46:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4031354279F
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Jul 2025 04:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 556101ABED9;
	Tue, 22 Jul 2025 04:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b="A+syiu4v"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp14.infineon.com (smtp14.infineon.com [217.10.52.160])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F17162AE6C
	for <linux-wireless@vger.kernel.org>; Tue, 22 Jul 2025 04:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.10.52.160
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753159608; cv=none; b=aFmwXIBclosjkmdEmBLMYIugIvtc0Xf4QFmmPFVakimsabMTJwZWi6uK/v194UdrG0Ba+udQI20xBOVxOBCgUM6SIdTHwhEc60fg+T/OWBOYoAZApAxm3Z0Fo1Gyf/DgDvkyp6jggYIm9gNDiy00b7gyYiU292cwxflCyIDveyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753159608; c=relaxed/simple;
	bh=SYivqxCPm9LQm7dkbIeg3oRDa228+MkB+hQxas6ijuw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jUxdxS+MM7aXAqpGo6THg2w121RO+NRSIJN9h38v+13BlnYd/XdzHpwuHgULYOgV75nD/eif+hzfJImhlZE+naZ6CTCcyGOaIpUyMMj/oTta9R9+WxirSMPCjLsS1HfVxfwm5U+GvuVXngWbCn4waCzyQmdnEzBSowZEoNZEBd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com; spf=pass smtp.mailfrom=infineon.com; dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b=A+syiu4v; arc=none smtp.client-ip=217.10.52.160
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infineon.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1753159606; x=1784695606;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=SYivqxCPm9LQm7dkbIeg3oRDa228+MkB+hQxas6ijuw=;
  b=A+syiu4vRLAoOMDTsFzyM8VHmUmUP/Xgg6gQoedRd6fytva7ewSjw9W0
   V2bJhZioNFVVwepJtJZK6ZGF/HjZLkqPMkTXR5c4R//b/EiMURtLX0VE7
   OXF0Xjc9CGl4JqrqLcZOuafEKOSme4+WIebm+hGBf23nDzWQ3d80LsP+J
   Q=;
X-CSE-ConnectionGUID: Bt3BzFcuTZyoVAPH9Qf0rA==
X-CSE-MsgGUID: QvG+GlO+QMC167nW9dOLQA==
X-IronPort-AV: E=McAfee;i="6800,10657,11499"; a="92249881"
X-IronPort-AV: E=Sophos;i="6.16,330,1744063200"; 
   d="scan'208";a="92249881"
Received: from unknown (HELO MUCSE805.infineon.com) ([172.23.29.31])
  by smtp14.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2025 06:45:34 +0200
Received: from MUCSE827.infineon.com (172.23.29.20) by MUCSE805.infineon.com
 (172.23.29.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 22 Jul
 2025 06:45:33 +0200
Received: from ISCN5CG14747PP.infineon.com (10.161.6.196) by
 MUCSE827.infineon.com (172.23.29.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 22 Jul 2025 06:45:32 +0200
From: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>
To: Arend van Spriel <arend.vanspriel@broadcom.com>, Johannes Berg
	<johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>, <brcm80211@lists.linux.dev>,
	<wlan-kernel-dev-list@infineon.com>, Gokul Sivakumar
	<gokulkumar.sivakumar@infineon.com>
Subject: [PATCH wireless-next v3 RESEND] wifi: brcmfmac: fix EXTSAE WPA3 connection failure due to AUTH TX failure
Date: Tue, 22 Jul 2025 10:15:15 +0530
Message-ID: <20250722044515.2562-1-gokulkumar.sivakumar@infineon.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MUCSE812.infineon.com (172.23.29.38) To
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

v3 RESEND:
  * Resending the same v3 patch for review reminder, after adding additional
    mailing lists in CC.

v3:
  * Fixed the "warning: incorrect type in assignment (different base types)"
    properly now, after kernel test robot reported it again.

  * Used brcmf_fil_cmd_data_get() instead of brcmf_fil_cmd_int_get() util
    for reading the channel number from the firmware as __le32 / __le16
    type instead of s32 type.

v2:
  * Fixed wifibot "warning: incorrect type in assignment (different base types)"
    in cyw/core.c file.

  * Fixed >80 line length checkpatch warning by reducing variable name len
    in cfg80211.c file.

  * Handled the return value of the BRCMF_C_GET_CHANNEL IOCTL Read operation
    in cfg80211.c & cyw/core.c files.

 .../broadcom/brcm80211/brcmfmac/cfg80211.c    | 33 ++++++++++++-------
 .../broadcom/brcm80211/brcmfmac/cyw/core.c    | 29 ++++++++++------
 2 files changed, 41 insertions(+), 21 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
index 40a9a8177de6..54b1f0c8117e 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
@@ -5544,8 +5544,8 @@ brcmf_cfg80211_mgmt_tx(struct wiphy *wiphy, struct wireless_dev *wdev,
 	struct brcmf_fil_action_frame_le *action_frame;
 	struct brcmf_fil_af_params_le *af_params;
 	bool ack;
-	s32 chan_nr;
-	u32 freq;
+	s32 ch;
+	__le32 hw_ch;
 
 	brcmf_dbg(TRACE, "Enter\n");
 
@@ -5606,25 +5606,36 @@ brcmf_cfg80211_mgmt_tx(struct wiphy *wiphy, struct wireless_dev *wdev,
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
+			err = brcmf_fil_cmd_data_get(vif->ifp,
+						     BRCMF_C_GET_CHANNEL,
+						     &hw_ch, sizeof(hw_ch));
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
index c9537fb597ce..2cbb4a809ca7 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/core.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/core.c
@@ -112,8 +112,8 @@ int brcmf_cyw_mgmt_tx(struct wiphy *wiphy, struct wireless_dev *wdev,
 	struct brcmf_cfg80211_vif *vif;
 	s32 err = 0;
 	bool ack = false;
-	s32 chan_nr;
-	u32 freq;
+	s32 ch;
+	__le16 hw_ch;
 	struct brcmf_mf_params_le *mf_params;
 	u32 mf_params_len;
 	s32 ready;
@@ -143,13 +143,20 @@ int brcmf_cyw_mgmt_tx(struct wiphy *wiphy, struct wireless_dev *wdev,
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
+		err = brcmf_fil_cmd_data_get(vif->ifp, BRCMF_C_GET_CHANNEL,
+					     &hw_ch, sizeof(hw_ch));
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

base-commit: 6b04716cdcac37bdbacde34def08bc6fdb5fc4e2
-- 
2.43.0


