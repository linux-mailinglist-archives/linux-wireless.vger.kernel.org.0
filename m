Return-Path: <linux-wireless+bounces-14386-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42A2B9ACB44
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Oct 2024 15:31:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 638631C2159D
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Oct 2024 13:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 846301C75F2;
	Wed, 23 Oct 2024 13:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q3NSIijH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FCE91C75EB
	for <linux-wireless@vger.kernel.org>; Wed, 23 Oct 2024 13:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729690213; cv=none; b=Do/8ip69ugnMm/nOE6Me0r4M+qqPwrPriJpd311Rp3ETlm/cDwuIRHEgx6DW0GiL+oPA1x/sznSqXJ78ZONb4lF31ySTY1E5b6y/u/F5BI4PRufa3KkFlneb7uige9Mxaj4vb7Bv+Gv8ndqs5diG+1SkQYwDnmyP5C5eTy1Y1r8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729690213; c=relaxed/simple;
	bh=25UdV06RM1zMhWc8okhUSDGQGG6N1KonlEa4Juerxus=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WrdSK6nzjPCmq6mn/9FkmZuMlm9QHZPnMfvIMkqNKN45ALi7AiNg/aSekBhJbMutzFZnNwf2aX4im38pLIiG8o6km//u27WOjq8nEas4KXlWAYUD7z7Cw322RdgKFzIh6PhYTTduCrZgNBvoZP9SnguzQvgSmph6Tx/09ww75uU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q3NSIijH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8EB6C4CEE4;
	Wed, 23 Oct 2024 13:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729690213;
	bh=25UdV06RM1zMhWc8okhUSDGQGG6N1KonlEa4Juerxus=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=q3NSIijHbTWwOWOElA9QrSRQvXhc9s0AZyZ8y3i7Lew4x6NGhFM8aQ+UC/He+SDBn
	 HmvXmumGI+j19/Ym3CgJ0qV0ler7xr5+cluctO/h3w8e9EneWD6PRGVWBtfdGFkgg3
	 vwPw2CNgp6GDMO7xSd+QNzCfoObtkj/ehL+vtlI06gpQPRbM+LnWFnFL/YpeTJj+wI
	 xT2tRSzJdbpWpu9PZQy4JRNxLCdm3dI9jiv8Q3gmODzP21TypOcaW3McRy9lZjoAB9
	 kMTqLAtvFWBxHExZJrzboivIsLGweg5EdJ+ebRU1BRsGxIfnuPt5EwXRh70kn0kXQ5
	 vzrBB22FyLsww==
From: Kalle Valo <kvalo@kernel.org>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH 6/8] wifi: ath12k: add multi-link flag in peer create command
Date: Wed, 23 Oct 2024 16:30:02 +0300
Message-Id: <20241023133004.2253830-7-kvalo@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241023133004.2253830-1-kvalo@kernel.org>
References: <20241023133004.2253830-1-kvalo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sriram R <quic_srirrama@quicinc.com>

Driver should indicate to firmware whether a peer is multi-link or not in peer
create command using multi-link flag. Add changes to support
WMI_TAG_MLO_PEER_CREATE_PARAMS in WMI_PEER_CREATE_CMDID.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Sriram R <quic_srirrama@quicinc.com>
Signed-off-by: Harshitha Prem <quic_hprem@quicinc.com>
Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/mac.c |  5 +++--
 drivers/net/wireless/ath/ath12k/wmi.c | 27 +++++++++++++++++++++++----
 drivers/net/wireless/ath/ath12k/wmi.h |  6 ++++++
 3 files changed, 32 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 019a1a6c6777..b628bc2fd0f5 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -4981,8 +4981,9 @@ static int ath12k_mac_station_add(struct ath12k *ar,
 	}
 
 	peer_param.vdev_id = arvif->vdev_id;
-	peer_param.peer_addr = sta->addr;
+	peer_param.peer_addr = arsta->addr;
 	peer_param.peer_type = WMI_PEER_TYPE_DEFAULT;
+	peer_param.ml_enabled = sta->mlo;
 
 	ret = ath12k_peer_create(ar, arvif, sta, &peer_param);
 	if (ret) {
@@ -7016,7 +7017,7 @@ int ath12k_mac_vdev_create(struct ath12k *ar, struct ath12k_link_vif *arvif)
 	struct ath12k_vif *ahvif = arvif->ahvif;
 	struct ieee80211_vif *vif = ath12k_ahvif_to_vif(ahvif);
 	struct ath12k_wmi_vdev_create_arg vdev_arg = {0};
-	struct ath12k_wmi_peer_create_arg peer_param;
+	struct ath12k_wmi_peer_create_arg peer_param = {0};
 	struct ieee80211_bss_conf *link_conf;
 	u32 param_id, param_value;
 	u16 nss;
diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
index e089b58bbea1..0583d832fac7 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -1230,9 +1230,14 @@ int ath12k_wmi_send_peer_create_cmd(struct ath12k *ar,
 	struct ath12k_wmi_pdev *wmi = ar->wmi;
 	struct wmi_peer_create_cmd *cmd;
 	struct sk_buff *skb;
-	int ret;
+	int ret, len;
+	struct wmi_peer_create_mlo_params *ml_param;
+	void *ptr;
+	struct wmi_tlv *tlv;
 
-	skb = ath12k_wmi_alloc_skb(wmi->wmi_ab, sizeof(*cmd));
+	len = sizeof(*cmd) + TLV_HDR_SIZE + sizeof(*ml_param);
+
+	skb = ath12k_wmi_alloc_skb(wmi->wmi_ab, len);
 	if (!skb)
 		return -ENOMEM;
 
@@ -1244,9 +1249,23 @@ int ath12k_wmi_send_peer_create_cmd(struct ath12k *ar,
 	cmd->peer_type = cpu_to_le32(arg->peer_type);
 	cmd->vdev_id = cpu_to_le32(arg->vdev_id);
 
+	ptr = skb->data + sizeof(*cmd);
+	tlv = ptr;
+	tlv->header = ath12k_wmi_tlv_hdr(WMI_TAG_ARRAY_STRUCT,
+					 sizeof(*ml_param));
+	ptr += TLV_HDR_SIZE;
+	ml_param = ptr;
+	ml_param->tlv_header =
+			ath12k_wmi_tlv_cmd_hdr(WMI_TAG_MLO_PEER_CREATE_PARAMS,
+					       sizeof(*ml_param));
+	if (arg->ml_enabled)
+		ml_param->flags = cpu_to_le32(ATH12K_WMI_FLAG_MLO_ENABLED);
+
+	ptr += sizeof(*ml_param);
+
 	ath12k_dbg(ar->ab, ATH12K_DBG_WMI,
-		   "WMI peer create vdev_id %d peer_addr %pM\n",
-		   arg->vdev_id, arg->peer_addr);
+		   "WMI peer create vdev_id %d peer_addr %pM ml_flags 0x%x\n",
+		   arg->vdev_id, arg->peer_addr, ml_param->flags);
 
 	ret = ath12k_wmi_cmd_send(wmi, skb, WMI_PEER_CREATE_CMDID);
 	if (ret) {
diff --git a/drivers/net/wireless/ath/ath12k/wmi.h b/drivers/net/wireless/ath/ath12k/wmi.h
index 33b9643644c6..07bd275608bf 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.h
+++ b/drivers/net/wireless/ath/ath12k/wmi.h
@@ -3026,6 +3026,12 @@ struct ath12k_wmi_peer_create_arg {
 	const u8 *peer_addr;
 	u32 peer_type;
 	u32 vdev_id;
+	bool ml_enabled;
+};
+
+struct wmi_peer_create_mlo_params {
+	__le32 tlv_header;
+	__le32 flags;
 };
 
 struct ath12k_wmi_pdev_set_regdomain_arg {
-- 
2.39.5


