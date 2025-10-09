Return-Path: <linux-wireless+bounces-27897-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C1E26BC7BD9
	for <lists+linux-wireless@lfdr.de>; Thu, 09 Oct 2025 09:41:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 82AC84E0F15
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Oct 2025 07:41:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A17F11E1E12;
	Thu,  9 Oct 2025 07:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b="kf259hRe"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp9.infineon.com (smtp9.infineon.com [217.10.52.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F362176AC8
	for <linux-wireless@vger.kernel.org>; Thu,  9 Oct 2025 07:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.10.52.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759995678; cv=none; b=D2p08dTcrVU3HtFD4bOyZP/89uR9Yql8o4iCnVfIS0Nrdd6lNqLYHnm5Tr9Aw/GSaEOT12e3zNjF74nFlCCUybE/MYmemxaInWpFS9telXX8MOtf9pq+JN6dGqFisRuSADW69yCuVEXZteAMpF4SOicLVCawKBmO8c+EryetQbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759995678; c=relaxed/simple;
	bh=khhYQIFfTJZ/0y9HtmMGis7h93KnZJoA3xGYkamUlp8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hwbuiCP8p9zI7lY4xMGC8HHD50iuc0fGs1id2uLLDRO21tb8+mim2fUtVg4h/w2UBSoloLhWjRb6XljrmJqMgPIp5sDTRTA+ucfgpRt4nEMyzLTneueUA8/T9AB29cnqOu3shUB90otkhAw4zX6upyt90v12cSvjJB0KNVGYJPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com; spf=pass smtp.mailfrom=infineon.com; dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b=kf259hRe; arc=none smtp.client-ip=217.10.52.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infineon.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1759995674; x=1791531674;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=khhYQIFfTJZ/0y9HtmMGis7h93KnZJoA3xGYkamUlp8=;
  b=kf259hReFAp4Ro60E68bV+7xDUrWKAeyhAlh0hqCRdWWjU8JZTDEJOfz
   Y9IyMpfxnGs6B5Kr7jduDyEkIm04GNfF267PQTsWdX5Elq0Y/Hnutx13e
   o1wGZukXscTUjWzcTbV0pGb2Jfqc1YaHjM3oqW6DTS6NVhCwEjbYsvIuu
   s=;
X-CSE-ConnectionGUID: ugOg9ET4Q3qFt82d4krMFw==
X-CSE-MsgGUID: eLH92vjhRpmOmqis5+Cdwg==
X-IronPort-AV: E=McAfee;i="6800,10657,11576"; a="67362608"
X-IronPort-AV: E=Sophos;i="6.19,215,1754949600"; 
   d="scan'208";a="67362608"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO MUCSE814.infineon.com) ([172.23.29.40])
  by smtp9.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2025 09:40:02 +0200
Received: from MUCSE827.infineon.com (172.23.29.20) by MUCSE814.infineon.com
 (172.23.29.40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 9 Oct
 2025 09:40:02 +0200
Received: from ISCN5CG14747PP.infineon.com (10.161.6.196) by
 MUCSE827.infineon.com (172.23.29.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 9 Oct 2025 09:39:59 +0200
From: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>
To: <arend.vanspriel@broadcom.com>
CC: <brcm80211-dev-list.pdl@broadcom.com>, <brcm80211@lists.linux.dev>,
	<chris@streetlogic.pro>, <gokulkumar.sivakumar@infineon.com>,
	<linux-wireless@vger.kernel.org>, <richard@govivid.ai>, <s311332@gmail.com>,
	<wahrenst@gmx.net>, <wlan-kernel-dev-list@infineon.com>,
	<johannes@sipsolutions.net>
Subject: [PATCH wireless-next] wifi: brcmfmac: fix crash while sending Action Frames in standalone AP Mode
Date: Thu, 9 Oct 2025 13:09:28 +0530
Message-ID: <20251009073928.6803-1-gokulkumar.sivakumar@infineon.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <9a0849d8-befd-4fca-9d5d-a24520ccfa26@broadcom.com>
References: <9a0849d8-befd-4fca-9d5d-a24520ccfa26@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MUCSE804.infineon.com (172.23.29.30) To
 MUCSE827.infineon.com (172.23.29.20)

Currently, whenever there is a need to transmit an Action frame,
the brcmfmac driver always uses the P2P vif to send the "actframe" IOVAR to
firmware. The P2P interfaces were available when wpa_supplicant is managing
the wlan interface.

However, the P2P interfaces are not created/initialized when only hostapd
is managing the wlan interface. And if hostapd receives an ANQP Query REQ
Action frame even from an un-associated STA, the brcmfmac driver tries
to use an uninitialized P2P vif pointer for sending the IOVAR to firmware.
This NULL pointer dereferencing triggers a driver crash.

 [ 1417.074538] Unable to handle kernel NULL pointer dereference at virtual
 address 0000000000000000
 [...]
 [ 1417.075188] Hardware name: Raspberry Pi 4 Model B Rev 1.5 (DT)
 [...]
 [ 1417.075653] Call trace:
 [ 1417.075662]  brcmf_p2p_send_action_frame+0x23c/0xc58 [brcmfmac]
 [ 1417.075738]  brcmf_cfg80211_mgmt_tx+0x304/0x5c0 [brcmfmac]
 [ 1417.075810]  cfg80211_mlme_mgmt_tx+0x1b0/0x428 [cfg80211]
 [ 1417.076067]  nl80211_tx_mgmt+0x238/0x388 [cfg80211]
 [ 1417.076281]  genl_family_rcv_msg_doit+0xe0/0x158
 [ 1417.076302]  genl_rcv_msg+0x220/0x2a0
 [ 1417.076317]  netlink_rcv_skb+0x68/0x140
 [ 1417.076330]  genl_rcv+0x40/0x60
 [ 1417.076343]  netlink_unicast+0x330/0x3b8
 [ 1417.076357]  netlink_sendmsg+0x19c/0x3f8
 [ 1417.076370]  __sock_sendmsg+0x64/0xc0
 [ 1417.076391]  ____sys_sendmsg+0x268/0x2a0
 [ 1417.076408]  ___sys_sendmsg+0xb8/0x118
 [ 1417.076427]  __sys_sendmsg+0x90/0xf8
 [ 1417.076445]  __arm64_sys_sendmsg+0x2c/0x40
 [ 1417.076465]  invoke_syscall+0x50/0x120
 [ 1417.076486]  el0_svc_common.constprop.0+0x48/0xf0
 [ 1417.076506]  do_el0_svc+0x24/0x38
 [ 1417.076525]  el0_svc+0x30/0x100
 [ 1417.076548]  el0t_64_sync_handler+0x100/0x130
 [ 1417.076569]  el0t_64_sync+0x190/0x198
 [ 1417.076589] Code: f9401e80 aa1603e2 f9403be1 5280e483 (f9400000)

Fix this, by always using the vif corresponding to the wdev on which the
Action frame Transmission request was initiated by the userspace. This way,
even if P2P vif is not available, the IOVAR is sent to firmware on AP vif
and the ANQP Query RESP Action frame is transmitted without crashing the
driver.

Remove init_completion() for "send_af_done" from brcmf_p2p_create_p2pdev()
and do it in brcmf_p2p_tx_action_frame() instead of reinit_completion().
Because the formar function would not get executed when hostapd is managing
wlan interface, and so it is not safe to do reinit_completion() without any
prior init_completion().

And in the brcmf_p2p_tx_action_frame() function, the condition check for
P2P Presence response frame is not needed, since the wpa_supplicant is
properly sending the P2P Presense Response frame on the P2P-GO vif instead
of the P2P-Device vif.

Fixes: 18e2f61db3b7 ("brcmfmac: P2P action frame tx.")
Signed-off-by: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>
---
 .../broadcom/brcm80211/brcmfmac/cfg80211.c    |  3 +-
 .../broadcom/brcm80211/brcmfmac/p2p.c         | 28 ++++++-------------
 .../broadcom/brcm80211/brcmfmac/p2p.h         |  3 +-
 3 files changed, 11 insertions(+), 23 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
index 8afaffe31031..bb96b87b2a6e 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
@@ -5627,8 +5627,7 @@ brcmf_cfg80211_mgmt_tx(struct wiphy *wiphy, struct wireless_dev *wdev,
 			  *cookie, le16_to_cpu(action_frame->len),
 			  le32_to_cpu(af_params->channel));
 
-		ack = brcmf_p2p_send_action_frame(cfg, cfg_to_ndev(cfg),
-						  af_params);
+		ack = brcmf_p2p_send_action_frame(vif->ifp, af_params);
 
 		cfg80211_mgmt_tx_status(wdev, *cookie, buf, len, ack,
 					GFP_KERNEL);
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c
index 0dc9d28cd77b..c7c40dc3be08 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c
@@ -1529,6 +1529,7 @@ int brcmf_p2p_notify_action_tx_complete(struct brcmf_if *ifp,
 /**
  * brcmf_p2p_tx_action_frame() - send action frame over fil.
  *
+ * @ifp: interface to transmit on.
  * @p2p: p2p info struct for vif.
  * @af_params: action frame data/info.
  *
@@ -1538,28 +1539,20 @@ int brcmf_p2p_notify_action_tx_complete(struct brcmf_if *ifp,
  * The WLC_E_ACTION_FRAME_COMPLETE event will be received when the action
  * frame is transmitted.
  */
-static s32 brcmf_p2p_tx_action_frame(struct brcmf_p2p_info *p2p,
+static s32 brcmf_p2p_tx_action_frame(struct brcmf_if *ifp,
+				     struct brcmf_p2p_info *p2p,
 				     struct brcmf_fil_af_params_le *af_params)
 {
 	struct brcmf_pub *drvr = p2p->cfg->pub;
-	struct brcmf_cfg80211_vif *vif;
-	struct brcmf_p2p_action_frame *p2p_af;
 	s32 err = 0;
 
 	brcmf_dbg(TRACE, "Enter\n");
 
-	reinit_completion(&p2p->send_af_done);
+	init_completion(&p2p->send_af_done);
 	clear_bit(BRCMF_P2P_STATUS_ACTION_TX_COMPLETED, &p2p->status);
 	clear_bit(BRCMF_P2P_STATUS_ACTION_TX_NOACK, &p2p->status);
 
-	/* check if it is a p2p_presence response */
-	p2p_af = (struct brcmf_p2p_action_frame *)af_params->action_frame.data;
-	if (p2p_af->subtype == P2P_AF_PRESENCE_RSP)
-		vif = p2p->bss_idx[P2PAPI_BSSCFG_CONNECTION].vif;
-	else
-		vif = p2p->bss_idx[P2PAPI_BSSCFG_DEVICE].vif;
-
-	err = brcmf_fil_bsscfg_data_set(vif->ifp, "actframe", af_params,
+	err = brcmf_fil_bsscfg_data_set(ifp, "actframe", af_params,
 					sizeof(*af_params));
 	if (err) {
 		bphy_err(drvr, " sending action frame has failed\n");
@@ -1711,16 +1704,14 @@ static bool brcmf_p2p_check_dwell_overflow(u32 requested_dwell,
 /**
  * brcmf_p2p_send_action_frame() - send action frame .
  *
- * @cfg: driver private data for cfg80211 interface.
- * @ndev: net device to transmit on.
+ * @ifp: interface to transmit on.
  * @af_params: configuration data for action frame.
  */
-bool brcmf_p2p_send_action_frame(struct brcmf_cfg80211_info *cfg,
-				 struct net_device *ndev,
+bool brcmf_p2p_send_action_frame(struct brcmf_if *ifp,
 				 struct brcmf_fil_af_params_le *af_params)
 {
+	struct brcmf_cfg80211_info *cfg = ifp->drvr->config;
 	struct brcmf_p2p_info *p2p = &cfg->p2p;
-	struct brcmf_if *ifp = netdev_priv(ndev);
 	struct brcmf_fil_action_frame_le *action_frame;
 	struct brcmf_config_af_params config_af_params;
 	struct afx_hdl *afx_hdl = &p2p->afx_hdl;
@@ -1857,7 +1848,7 @@ bool brcmf_p2p_send_action_frame(struct brcmf_cfg80211_info *cfg,
 		if (af_params->channel)
 			msleep(P2P_AF_RETRY_DELAY_TIME);
 
-		ack = !brcmf_p2p_tx_action_frame(p2p, af_params);
+		ack = !brcmf_p2p_tx_action_frame(ifp, p2p, af_params);
 		tx_retry++;
 		dwell_overflow = brcmf_p2p_check_dwell_overflow(requested_dwell,
 								dwell_jiffies);
@@ -2217,7 +2208,6 @@ static struct wireless_dev *brcmf_p2p_create_p2pdev(struct brcmf_p2p_info *p2p,
 
 	WARN_ON(p2p_ifp->bsscfgidx != bsscfgidx);
 
-	init_completion(&p2p->send_af_done);
 	INIT_WORK(&p2p->afx_hdl.afx_work, brcmf_p2p_afx_handler);
 	init_completion(&p2p->afx_hdl.act_frm_scan);
 	init_completion(&p2p->wait_next_af);
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.h b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.h
index d2ecee565bf2..d3137ebd7158 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.h
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.h
@@ -168,8 +168,7 @@ int brcmf_p2p_notify_action_frame_rx(struct brcmf_if *ifp,
 int brcmf_p2p_notify_action_tx_complete(struct brcmf_if *ifp,
 					const struct brcmf_event_msg *e,
 					void *data);
-bool brcmf_p2p_send_action_frame(struct brcmf_cfg80211_info *cfg,
-				 struct net_device *ndev,
+bool brcmf_p2p_send_action_frame(struct brcmf_if *ifp,
 				 struct brcmf_fil_af_params_le *af_params);
 bool brcmf_p2p_scan_finding_common_channel(struct brcmf_cfg80211_info *cfg,
 					   struct brcmf_bss_info_le *bi);

base-commit: 94aced6ed9e2630bae0b5631e384a5302c4b6783
-- 
2.25.1


