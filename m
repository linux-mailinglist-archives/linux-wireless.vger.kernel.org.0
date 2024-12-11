Return-Path: <linux-wireless+bounces-16257-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1097F9ED026
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Dec 2024 16:45:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0C6B286CB0
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Dec 2024 15:45:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C41031D9A5F;
	Wed, 11 Dec 2024 15:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mvesHzbl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F06C1D9A70
	for <linux-wireless@vger.kernel.org>; Wed, 11 Dec 2024 15:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733931843; cv=none; b=HL45AmetksV+Su8/8n0DGC70E+GOftPma6nnF+l86bJw+Ez6m4SHEwZJ8efFqGiNOU6Eub7lTfESHd49w2nIiM9C1IIMshlxo5ds9FLUNmw+0K3+r4IsJO1T0p8dp6U0c6HzWBsucPmltWT0PVH/FdiBinmA4c7UAyqFftl2PW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733931843; c=relaxed/simple;
	bh=tboF5zHLY+awhgwSforkB0qKkI0bgoMMkM7j9lFOmSk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bTPaVnSi76k6P+sb811rRcjq9Kq/t1/SeiguArfoWm/lhcHLjzfK/IoeSXhO6fVoqt+HPhbkigXD6AVdq4HZVbG2fmAzfGafKlqlOdoMx9V5QzxbOj5VFcKf2WamHPIKf3vqYAQ/h0fA3qXljGfp6VARYUW4/3AeChqGFz6nfXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mvesHzbl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EAB7C4CED4;
	Wed, 11 Dec 2024 15:44:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733931843;
	bh=tboF5zHLY+awhgwSforkB0qKkI0bgoMMkM7j9lFOmSk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mvesHzblt61sucaDo3KfWUzSH0vNIQLvUZ3zdFmrMZB72UidWNE9TipesK9hxaeXI
	 BF98FgquR1Gdh9+XajqVPzgmzooWR7cEbbPR59GHzDYbkoMkHi54kfjBvKNCTQ9F4Q
	 rhWs/773ZliEctwPbGtt3l7Hi0MZa0QjJHKKum61jHHpHUakcbCmyIIXIHV6jAXkEe
	 bstg9Zh+x0QKD3WfX8DjAeTpJzLj5TWr26v8xlFgTJgnKJSoD0SAnaW8sFZ/pQzrf/
	 P6NT3HTXCjWcgv3i/ruzhlsL1xU0MikMWr89NlJVHaj1OHsVZEyP4ntw4VWYJmmBrP
	 THVliyEIQ8PHw==
From: Kalle Valo <kvalo@kernel.org>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH 2/7] wifi: ath12k: add can_activate_links mac operation
Date: Wed, 11 Dec 2024 17:43:53 +0200
Message-Id: <20241211154358.776279-3-kvalo@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241211154358.776279-1-kvalo@kernel.org>
References: <20241211154358.776279-1-kvalo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Aditya Kumar Singh <quic_adisi@quicinc.com>

When operating as an ML station, mac80211 initially activates only one link in
the driver until the peer is authorized. Once the state changes to authorized,
the driver should call mac80211 API to activate all other partner links.

Before doing so, mac80211 checks if the driver supports activating links via
the can_activate_links mac80211_ops. Therefore, add support for this
mac80211_ops and call the API to activate the links once the state changes to
authorized.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Aditya Kumar Singh <quic_adisi@quicinc.com>
Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index bd5a3c790c3b..7962bfa955ba 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -5645,6 +5645,19 @@ static int ath12k_mac_op_sta_state(struct ieee80211_hw *hw,
 		}
 	}
 
+	/* In the ML station scenario, activate all partner links once the
+	 * client is transitioning to the associated state.
+	 *
+	 * FIXME: Ideally, this activation should occur when the client
+	 * transitions to the authorized state. However, there are some
+	 * issues with handling this in the firmware. Until the firmware
+	 * can manage it properly, activate the links when the client is
+	 * about to move to the associated state.
+	 */
+	if (ieee80211_vif_is_mld(vif) && vif->type == NL80211_IFTYPE_STATION &&
+	    old_state == IEEE80211_STA_AUTH && new_state == IEEE80211_STA_ASSOC)
+		ieee80211_set_active_links(vif, ieee80211_vif_usable_links(vif));
+
 	/* Handle all the other state transitions in generic way */
 	valid_links = ahsta->links_map;
 	for_each_set_bit(link_id, &valid_links, IEEE80211_MLD_MAX_NUM_LINKS) {
@@ -5939,6 +5952,15 @@ static int ath12k_mac_op_change_sta_links(struct ieee80211_hw *hw,
 	return 0;
 }
 
+static bool ath12k_mac_op_can_activate_links(struct ieee80211_hw *hw,
+					     struct ieee80211_vif *vif,
+					     u16 active_links)
+{
+	/* TODO: Handle recovery case */
+
+	return true;
+}
+
 static int ath12k_conf_tx_uapsd(struct ath12k_link_vif *arvif,
 				u16 ac, bool enable)
 {
@@ -10249,6 +10271,7 @@ static const struct ieee80211_ops ath12k_ops = {
 	.remain_on_channel              = ath12k_mac_op_remain_on_channel,
 	.cancel_remain_on_channel       = ath12k_mac_op_cancel_remain_on_channel,
 	.change_sta_links               = ath12k_mac_op_change_sta_links,
+	.can_activate_links             = ath12k_mac_op_can_activate_links,
 #ifdef CONFIG_PM
 	.suspend			= ath12k_wow_op_suspend,
 	.resume				= ath12k_wow_op_resume,
-- 
2.39.5


