Return-Path: <linux-wireless+bounces-27937-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 578CDBCECB7
	for <lists+linux-wireless@lfdr.de>; Sat, 11 Oct 2025 02:10:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5345419A683A
	for <lists+linux-wireless@lfdr.de>; Sat, 11 Oct 2025 00:11:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27C6779DA;
	Sat, 11 Oct 2025 00:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="RB2DVPVU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B85194C83;
	Sat, 11 Oct 2025 00:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760141447; cv=none; b=KWFR3nxapeumEhKOWDwVYMfZVUJ39E2RSHbBj9CaLzl9Oy7Evfb0+N8dh3QEcDBhg22OQeEXMUA7ddGt9a02LbgU4ZP63eFZUkwpzXYok55bxO1KODhnJUkuIjuH593Vz3fuFK1/OhxeScr1nchy+8fBuOcYnRez6RJrptWrWZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760141447; c=relaxed/simple;
	bh=6JkGx+B33muFi7i+3fkH0KGs/YlfEUjc07uhM09Pb80=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cP/UzTgF177PocJdZYClq8KLhYLKnjGLTXJ5LHnblGsjkPGG3FrWZVP8Hy1u9geEdVvukCBWx46Nq3kg4zzi9nm7wwA+RZ/ICmw82WZgN8jePLwODtlefjH8wjPv9tBFXtNao7N03bCOnzyKaZxnIrVOL/LUsfKM/SLM0dDw8mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=RB2DVPVU; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=cxvmckp001eqW77msuYCbAncWeEK7Ge75hIv96aombQ=; b=RB2DVPVUH/GPauPR
	KCKFJzpE9uhsbBlot/DeEwasHmhV7jufgwjFhQnhaQE0iRyFr5TyFAEZJcEeiTqhKRkkd1ooceg6g
	u3mclvT+RNM6p6l0UlGdeKw7/xTUafBeRMO1w5X8G+8Ia5B/VawDDmuqQyEb5WHCIMW5hGZokL5dn
	i39ljr4igck/qvuNAzC5dMEyPhA2bTP/g2oUy+80txoJC+cYfPePFXUGfLOmS7ZGMzTrUKFd2sreU
	TqlRTpksyrrKJ4t3spnaMULCs7yMnbGxoyQhD3TyyRadt+MzFqByL9M4RCSp8y7VWe8GY0yscpO1j
	UPUb4yORx10uhEp9xw==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1v7NC3-00Fnxf-06;
	Sat, 11 Oct 2025 00:10:39 +0000
From: linux@treblig.org
To: loic.poulain@oss.qualcomm.com,
	jeff.johnson@oss.qualcomm.com
Cc: linux-kernel@vger.kernel.org,
	wcn36xx@lists.infradead.org,
	linux-wireless@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH v2] wifi: wcn36xx: Remove unused wcn36xx_smd_update_scan_params
Date: Sat, 11 Oct 2025 01:10:38 +0100
Message-ID: <20251011001038.352393-1-linux@treblig.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

wcn36xx_smd_update_scan_params() last use was removed in 2020 by
commit 5973a2947430 ("wcn36xx: Fix software-driven scan")

Remove it.

This leaves the wcn36xx_hal_update_scan_params_req_ex and
wcn36xx_hal_update_scan_params_resp structs unused.

Remove them, together with the unused
wcn36xx_hal_update_scan_params_req.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
v2
  Remove the unused scan structures as suggested by Jeff

 drivers/net/wireless/ath/wcn36xx/hal.h | 74 --------------------------
 drivers/net/wireless/ath/wcn36xx/smd.c | 60 ---------------------
 drivers/net/wireless/ath/wcn36xx/smd.h |  1 -
 3 files changed, 135 deletions(-)

diff --git a/drivers/net/wireless/ath/wcn36xx/hal.h b/drivers/net/wireless/ath/wcn36xx/hal.h
index d3a9d00e65e1..ef9ea4ff891b 100644
--- a/drivers/net/wireless/ath/wcn36xx/hal.h
+++ b/drivers/net/wireless/ath/wcn36xx/hal.h
@@ -4484,80 +4484,6 @@ struct set_rssi_filter_resp {
 	u32 status;
 };
 
-/* Update scan params - sent from host to PNO to be used during PNO
- * scanningx */
-struct wcn36xx_hal_update_scan_params_req {
-
-	struct wcn36xx_hal_msg_header header;
-
-	/* Host setting for 11d */
-	u8 dot11d_enabled;
-
-	/* Lets PNO know that host has determined the regulatory domain */
-	u8 dot11d_resolved;
-
-	/* Channels on which PNO is allowed to scan */
-	u8 channel_count;
-	u8 channels[WCN36XX_HAL_PNO_MAX_NETW_CHANNELS];
-
-	/* Minimum channel time */
-	u16 active_min_ch_time;
-
-	/* Maximum channel time */
-	u16 active_max_ch_time;
-
-	/* Minimum channel time */
-	u16 passive_min_ch_time;
-
-	/* Maximum channel time */
-	u16 passive_max_ch_time;
-
-	/* Cb State */
-	enum phy_chan_bond_state state;
-} __packed;
-
-/* Update scan params - sent from host to PNO to be used during PNO
- * scanningx */
-struct wcn36xx_hal_update_scan_params_req_ex {
-
-	struct wcn36xx_hal_msg_header header;
-
-	/* Host setting for 11d */
-	u8 dot11d_enabled;
-
-	/* Lets PNO know that host has determined the regulatory domain */
-	u8 dot11d_resolved;
-
-	/* Channels on which PNO is allowed to scan */
-	u8 channel_count;
-	u8 channels[WCN36XX_HAL_PNO_MAX_NETW_CHANNELS_EX];
-
-	/* Minimum channel time */
-	u16 active_min_ch_time;
-
-	/* Maximum channel time */
-	u16 active_max_ch_time;
-
-	/* Minimum channel time */
-	u16 passive_min_ch_time;
-
-	/* Maximum channel time */
-	u16 passive_max_ch_time;
-
-	/* Cb State */
-	enum phy_chan_bond_state state;
-} __packed;
-
-/* Update scan params - sent from host to PNO to be used during PNO
- * scanningx */
-struct wcn36xx_hal_update_scan_params_resp {
-
-	struct wcn36xx_hal_msg_header header;
-
-	/* status of the request */
-	u32 status;
-} __packed;
-
 struct wcn36xx_hal_set_tx_per_tracking_req_msg {
 	struct wcn36xx_hal_msg_header header;
 
diff --git a/drivers/net/wireless/ath/wcn36xx/smd.c b/drivers/net/wireless/ath/wcn36xx/smd.c
index 2cf86fc3f8fe..136acc414714 100644
--- a/drivers/net/wireless/ath/wcn36xx/smd.c
+++ b/drivers/net/wireless/ath/wcn36xx/smd.c
@@ -1127,66 +1127,6 @@ int wcn36xx_smd_process_ptt_msg(struct wcn36xx *wcn,
 	return ret;
 }
 
-static int wcn36xx_smd_update_scan_params_rsp(void *buf, size_t len)
-{
-	struct wcn36xx_hal_update_scan_params_resp *rsp;
-
-	rsp = buf;
-
-	/* Remove the PNO version bit */
-	rsp->status &= (~(WCN36XX_FW_MSG_PNO_VERSION_MASK));
-
-	if (WCN36XX_FW_MSG_RESULT_SUCCESS != rsp->status) {
-		wcn36xx_warn("error response from update scan\n");
-		return rsp->status;
-	}
-
-	return 0;
-}
-
-int wcn36xx_smd_update_scan_params(struct wcn36xx *wcn,
-				   u8 *channels, size_t channel_count)
-{
-	struct wcn36xx_hal_update_scan_params_req_ex msg_body;
-	int ret;
-
-	mutex_lock(&wcn->hal_mutex);
-	INIT_HAL_MSG(msg_body, WCN36XX_HAL_UPDATE_SCAN_PARAM_REQ);
-
-	msg_body.dot11d_enabled	= false;
-	msg_body.dot11d_resolved = true;
-
-	msg_body.channel_count = channel_count;
-	memcpy(msg_body.channels, channels, channel_count);
-	msg_body.active_min_ch_time = 60;
-	msg_body.active_max_ch_time = 120;
-	msg_body.passive_min_ch_time = 60;
-	msg_body.passive_max_ch_time = 110;
-	msg_body.state = PHY_SINGLE_CHANNEL_CENTERED;
-
-	PREPARE_HAL_BUF(wcn->hal_buf, msg_body);
-
-	wcn36xx_dbg(WCN36XX_DBG_HAL,
-		    "hal update scan params channel_count %d\n",
-		    msg_body.channel_count);
-
-	ret = wcn36xx_smd_send_and_wait(wcn, msg_body.header.len);
-	if (ret) {
-		wcn36xx_err("Sending hal_update_scan_params failed\n");
-		goto out;
-	}
-	ret = wcn36xx_smd_update_scan_params_rsp(wcn->hal_buf,
-						 wcn->hal_rsp_len);
-	if (ret) {
-		wcn36xx_err("hal_update_scan_params response failed err=%d\n",
-			    ret);
-		goto out;
-	}
-out:
-	mutex_unlock(&wcn->hal_mutex);
-	return ret;
-}
-
 static int wcn36xx_smd_add_sta_self_rsp(struct wcn36xx *wcn,
 					struct ieee80211_vif *vif,
 					void *buf,
diff --git a/drivers/net/wireless/ath/wcn36xx/smd.h b/drivers/net/wireless/ath/wcn36xx/smd.h
index 2c1ed9e570bf..4e39df5589b3 100644
--- a/drivers/net/wireless/ath/wcn36xx/smd.h
+++ b/drivers/net/wireless/ath/wcn36xx/smd.h
@@ -66,7 +66,6 @@ int wcn36xx_smd_finish_scan(struct wcn36xx *wcn, enum wcn36xx_hal_sys_mode mode,
 int wcn36xx_smd_init_scan(struct wcn36xx *wcn, enum wcn36xx_hal_sys_mode mode,
 			  struct ieee80211_vif *vif);
 
-int wcn36xx_smd_update_scan_params(struct wcn36xx *wcn, u8 *channels, size_t channel_count);
 int wcn36xx_smd_start_hw_scan(struct wcn36xx *wcn, struct ieee80211_vif *vif,
 			      struct cfg80211_scan_request *req);
 int wcn36xx_smd_stop_hw_scan(struct wcn36xx *wcn);
-- 
2.51.0


