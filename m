Return-Path: <linux-wireless+bounces-35278-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WOs8DMeC62kONwAAu9opvQ
	(envelope-from <linux-wireless+bounces-35278-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Apr 2026 16:48:39 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B7BF4605DA
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Apr 2026 16:48:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2FBBB3008A63
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Apr 2026 14:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7069F3E0232;
	Fri, 24 Apr 2026 14:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iqP4Wzuv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E3AD3E0231
	for <linux-wireless@vger.kernel.org>; Fri, 24 Apr 2026 14:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777042099; cv=none; b=TsREkytGwY9UNFHr4EzOE3qyHthYwrTTNfS+cx2HhZ+RGeAT1JR3/favQBxav56VrI7sz0svDFqTzVMW7SHnrsvGiiar71k5Ag4Ov+wolrdSompJJH3BMEVFfFqpUzLMdRJMTO9DBYrNbzrraGP6peKHaMQWsdKr3Pwn321yyjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777042099; c=relaxed/simple;
	bh=n/vdTricHmeNz/wdwIzGkyXopf5LreCvjxyRutu1WBI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b0aRzZPUtv3AaCFLrbcQSMdrG1rFhCHCFf5j7TyVN0DQgodnyOsemKwWZCiiQS117FLq6oqNqknPL9ZT8iv0DA1hfbWZwxQNH8e1UvypvBUeUIb5qM/XtRBuvOzxKxOGJYlqVIVQTNQq9dU6hpsP5kuqLk3EgLGwDpDP3hYCxGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iqP4Wzuv; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4838c15e3cbso74672895e9.3
        for <linux-wireless@vger.kernel.org>; Fri, 24 Apr 2026 07:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777042096; x=1777646896; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SeH/wRvlMGgMd5dC0u7MqW4CKB/r2MwZpbBb2EJdTBo=;
        b=iqP4Wzuvyuv0ssvaY4SsfeQF3UlBwsyoOir2RfgKIX7G7WOgeLNohVMX/A1Mb0XEKd
         8b1szZAv6HqxXOgoCSPIeOrO2zAqId2AzBSvih+Y/2BQLxyaRtRb0PThu5IJ8DshxGqW
         nhLJ0AV5lOY5kALFwr0j5VJ56HrY2clBc295BcKgKcTMAm+gYwNPyrZFauJPfhzAdADO
         q0VuPi5Agl6a7f6hw2WVUcZElaY8Pph+5TzBIF+RtAQkFHRPuXezY6LKlc8se1Xn+pT1
         nFYYfxbqAstGNMHowkaqX/+nNYkT/AQNGH7rTUsH6CeHd6KXyWyUIVha3ea4DAKDaALb
         MJkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777042096; x=1777646896;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SeH/wRvlMGgMd5dC0u7MqW4CKB/r2MwZpbBb2EJdTBo=;
        b=hv208Z2YQi27vTLh1ldgeDIFB8IUqNPf3KRy0y82AQVJg5UmwVEsDNl1UBgtrt623b
         5uSWItFHnzbr0KULMC+sSb72Jcgl9Q/QuZi8ZMejgEvbNQ1pLKsItqOqPbfuQcQtT3eu
         pdW/81eESjoRTFqHW1f0MwoXeiTZjDy1letndQ0qNI5ilJtOtYHN62fy1vghxO8EW6g0
         UJl2PW1xpjA8r65CIRdLDxAlv16tUlnWVU3bdnycXrRbzDO36sJyODiGla4DH+MEuIK7
         jqbmdn2BMjrr2ltz689+hmxTw8eC7a8Qum2gz6oDlPJH8AWmASDKxAK0FdqFB36R6OfB
         e5kQ==
X-Gm-Message-State: AOJu0YxN74/3YlZ1p1AhV9xwAiC3fl4EJDeLx9tuJTfsrWd4lFkYSpah
	gJam/ejxhOIGyXR5sdVOAQTrOC2k08VYI87DWdwMakMvXlL89GMmSBUqvguELQ==
X-Gm-Gg: AeBDiesNPgV1v5GdyJDLLfNj3v4zWiMB2OKSOzCaFYAtv3wEseRV9tyGWSBOcPbW/wc
	vqn7at5PcYAsSC9IKdTbNs+JcIk85Tw6852nluc6boyoY06sPzv9ssPu2FJw3WUdB8EuS54lBbG
	g/16H5iw7XP1r4gwOBS7JhYPdoylBLEvB5sL0T+CiVr4lKhB3wkP5dYyElNbL2ALjaks4WoW46x
	48Y4Nq4ZNjq88Ba2R29n9t7gGnBSl0LbJyTPWL/7AQ92jpjYDjmTFSLjJwELxWd8IVN8/weY3Fc
	y7aCdYdwchQARHOc4vsiRSGTPDivu2gVjMZV0ghUhVVJuoxhh6c9HZlOdhpVgB+dJY1Kj1yFOAI
	WzRJsiZvoCAhZU8Y+A92kp3ks86L42PzDw5OB44wu0QtZCNMrF8XttJsiaRCCyMmLKl+/4TXCoY
	Hie3/+XR4ZJVMa2W9wxVKDGY72bVLc3htGJ2tGZaM/O0xYayJPjWNcZdtk47BKXkyvMIE=
X-Received: by 2002:a05:600c:a30b:b0:485:17a7:b9c7 with SMTP id 5b1f17b1804b1-488fb750a2bmr319030345e9.10.1777042095604;
        Fri, 24 Apr 2026 07:48:15 -0700 (PDT)
Received: from syracuse.iliad.local (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48919f54572sm157605825e9.26.2026.04.24.07.48.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2026 07:48:15 -0700 (PDT)
From: Nicolas Escande <nico.escande@gmail.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH 2/2] wifi: ath11k: fix error path leaks in some WMI calls
Date: Fri, 24 Apr 2026 16:48:13 +0200
Message-ID: <20260424144813.1708214-3-nico.escande@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260424144813.1708214-1-nico.escande@gmail.com>
References: <20260424144813.1708214-1-nico.escande@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 8B7BF4605DA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_FROM(0.00)[bounces-35278-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nicoescande@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

This is the same pattern that was previously identified as problematic:
direct 'return ath11k_wmi_cmd_send(...)' will leak the skb in the error
path if it is not explicitly handled.

Fixes: c417b247ba04 ("ath11k: implement hardware data filter")
Fixes: 9cbd7fc9be82 ("ath11k: support MAC address randomization in scan")
Fixes: ba9177fcef21 ("ath11k: Add basic WoW functionalities")
Fixes: fec4b898f369 ("ath11k: Add WoW net-detect functionality")
Fixes: c3c36bfe998b ("ath11k: support ARP and NS offload")
Fixes: a16d9b50cfba ("ath11k: support GTK rekey offload")
Fixes: 652f69ed9c1b ("ath11k: Add support for SAR")
Fixes: 0f84a156aa3b ("ath11k: Handle keepalive during WoWLAN suspend and resume")
Signed-off-by: Nicolas Escande <nico.escande@gmail.com>
---
 drivers/net/wireless/ath/ath11k/wmi.c | 112 ++++++++++++++++++++++----
 1 file changed, 96 insertions(+), 16 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/wmi.c b/drivers/net/wireless/ath/ath11k/wmi.c
index 024c2aad9fb4..dca6e011cc40 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.c
+++ b/drivers/net/wireless/ath/ath11k/wmi.c
@@ -9299,7 +9299,7 @@ int ath11k_wmi_hw_data_filter_cmd(struct ath11k *ar, u32 vdev_id,
 {
 	struct wmi_hw_data_filter_cmd *cmd;
 	struct sk_buff *skb;
-	int len;
+	int ret, len;
 
 	len = sizeof(*cmd);
 	skb = ath11k_wmi_alloc_skb(ar->wmi->wmi_ab, len);
@@ -9324,7 +9324,13 @@ int ath11k_wmi_hw_data_filter_cmd(struct ath11k *ar, u32 vdev_id,
 		   "hw data filter enable %d filter_bitmap 0x%x\n",
 		   enable, filter_bitmap);
 
-	return ath11k_wmi_cmd_send(ar->wmi, skb, WMI_HW_DATA_FILTER_CMDID);
+	ret = ath11k_wmi_cmd_send(ar->wmi, skb, WMI_HW_DATA_FILTER_CMDID);
+	if (ret) {
+		ath11k_warn(ar->ab, "failed to send WMI_HW_DATA_FILTER_CMDID\n");
+		dev_kfree_skb(skb);
+	}
+
+	return ret;
 }
 
 int ath11k_wmi_wow_host_wakeup_ind(struct ath11k *ar)
@@ -9389,7 +9395,7 @@ int ath11k_wmi_scan_prob_req_oui(struct ath11k *ar,
 	struct sk_buff *skb;
 	struct wmi_scan_prob_req_oui_cmd *cmd;
 	u32 prob_req_oui;
-	int len;
+	int ret, len;
 
 	prob_req_oui = (((u32)mac_addr[0]) << 16) |
 		       (((u32)mac_addr[1]) << 8) | mac_addr[2];
@@ -9408,7 +9414,13 @@ int ath11k_wmi_scan_prob_req_oui(struct ath11k *ar,
 	ath11k_dbg(ar->ab, ATH11K_DBG_WMI, "scan prob req oui %d\n",
 		   prob_req_oui);
 
-	return ath11k_wmi_cmd_send(ar->wmi, skb, WMI_SCAN_PROB_REQ_OUI_CMDID);
+	ret = ath11k_wmi_cmd_send(ar->wmi, skb, WMI_SCAN_PROB_REQ_OUI_CMDID);
+	if (ret) {
+		ath11k_warn(ar->ab, "failed to send WMI_SCAN_PROB_REQ_OUI_CMDID\n");
+		dev_kfree_skb(skb);
+	}
+
+	return ret;
 }
 
 int ath11k_wmi_wow_add_wakeup_event(struct ath11k *ar, u32 vdev_id,
@@ -9418,6 +9430,7 @@ int ath11k_wmi_wow_add_wakeup_event(struct ath11k *ar, u32 vdev_id,
 	struct wmi_wow_add_del_event_cmd *cmd;
 	struct sk_buff *skb;
 	size_t len;
+	int ret;
 
 	len = sizeof(*cmd);
 	skb = ath11k_wmi_alloc_skb(ar->wmi->wmi_ab, len);
@@ -9435,7 +9448,13 @@ int ath11k_wmi_wow_add_wakeup_event(struct ath11k *ar, u32 vdev_id,
 	ath11k_dbg(ar->ab, ATH11K_DBG_WMI, "tlv wow add wakeup event %s enable %d vdev_id %d\n",
 		   wow_wakeup_event(event), enable, vdev_id);
 
-	return ath11k_wmi_cmd_send(ar->wmi, skb, WMI_WOW_ENABLE_DISABLE_WAKE_EVENT_CMDID);
+	ret = ath11k_wmi_cmd_send(ar->wmi, skb, WMI_WOW_ENABLE_DISABLE_WAKE_EVENT_CMDID);
+	if (ret) {
+		ath11k_warn(ar->ab, "failed to send WMI_WOW_ENABLE_DISABLE_WAKE_EVENT_CMDID\n");
+		dev_kfree_skb(skb);
+	}
+
+	return ret;
 }
 
 int ath11k_wmi_wow_add_pattern(struct ath11k *ar, u32 vdev_id, u32 pattern_id,
@@ -9448,6 +9467,7 @@ int ath11k_wmi_wow_add_pattern(struct ath11k *ar, u32 vdev_id, u32 pattern_id,
 	struct sk_buff *skb;
 	u8 *ptr;
 	size_t len;
+	int ret;
 
 	len = sizeof(*cmd) +
 	      sizeof(*tlv) +			/* array struct */
@@ -9540,7 +9560,13 @@ int ath11k_wmi_wow_add_pattern(struct ath11k *ar, u32 vdev_id, u32 pattern_id,
 	ath11k_dbg(ar->ab, ATH11K_DBG_WMI, "tlv wow add pattern vdev_id %d pattern_id %d pattern_offset %d\n",
 		   vdev_id, pattern_id, pattern_offset);
 
-	return ath11k_wmi_cmd_send(ar->wmi, skb, WMI_WOW_ADD_WAKE_PATTERN_CMDID);
+	ret = ath11k_wmi_cmd_send(ar->wmi, skb, WMI_WOW_ADD_WAKE_PATTERN_CMDID);
+	if (ret) {
+		ath11k_warn(ar->ab, "failed to send WMI_WOW_ADD_WAKE_PATTERN_CMDID\n");
+		dev_kfree_skb(skb);
+	}
+
+	return ret;
 }
 
 int ath11k_wmi_wow_del_pattern(struct ath11k *ar, u32 vdev_id, u32 pattern_id)
@@ -9548,6 +9574,7 @@ int ath11k_wmi_wow_del_pattern(struct ath11k *ar, u32 vdev_id, u32 pattern_id)
 	struct wmi_wow_del_pattern_cmd *cmd;
 	struct sk_buff *skb;
 	size_t len;
+	int ret;
 
 	len = sizeof(*cmd);
 	skb = ath11k_wmi_alloc_skb(ar->wmi->wmi_ab, len);
@@ -9566,7 +9593,13 @@ int ath11k_wmi_wow_del_pattern(struct ath11k *ar, u32 vdev_id, u32 pattern_id)
 	ath11k_dbg(ar->ab, ATH11K_DBG_WMI, "tlv wow del pattern vdev_id %d pattern_id %d\n",
 		   vdev_id, pattern_id);
 
-	return ath11k_wmi_cmd_send(ar->wmi, skb, WMI_WOW_DEL_WAKE_PATTERN_CMDID);
+	ret = ath11k_wmi_cmd_send(ar->wmi, skb, WMI_WOW_DEL_WAKE_PATTERN_CMDID);
+	if (ret) {
+		ath11k_warn(ar->ab, "failed to send WMI_WOW_DEL_WAKE_PATTERN_CMDID\n");
+		dev_kfree_skb(skb);
+	}
+
+	return ret;
 }
 
 static struct sk_buff *
@@ -9710,6 +9743,7 @@ int ath11k_wmi_wow_config_pno(struct ath11k *ar, u32 vdev_id,
 			      struct wmi_pno_scan_req  *pno_scan)
 {
 	struct sk_buff *skb;
+	int ret;
 
 	if (pno_scan->enable)
 		skb = ath11k_wmi_op_gen_config_pno_start(ar, vdev_id, pno_scan);
@@ -9719,7 +9753,13 @@ int ath11k_wmi_wow_config_pno(struct ath11k *ar, u32 vdev_id,
 	if (IS_ERR_OR_NULL(skb))
 		return -ENOMEM;
 
-	return ath11k_wmi_cmd_send(ar->wmi, skb, WMI_NETWORK_LIST_OFFLOAD_CONFIG_CMDID);
+	ret = ath11k_wmi_cmd_send(ar->wmi, skb, WMI_NETWORK_LIST_OFFLOAD_CONFIG_CMDID);
+	if (ret) {
+		ath11k_warn(ar->ab, "failed to send WMI_NETWORK_LIST_OFFLOAD_CONFIG_CMDID\n");
+		dev_kfree_skb(skb);
+	}
+
+	return ret;
 }
 
 static void ath11k_wmi_fill_ns_offload(struct ath11k *ar,
@@ -9837,6 +9877,7 @@ int ath11k_wmi_arp_ns_offload(struct ath11k *ar,
 	u8 *buf_ptr;
 	size_t len;
 	u8 ns_cnt, ns_ext_tuples = 0;
+	int ret;
 
 	offload = &arvif->arp_ns_offload;
 	ns_cnt = offload->ipv6_count;
@@ -9875,7 +9916,13 @@ int ath11k_wmi_arp_ns_offload(struct ath11k *ar,
 	if (ns_ext_tuples)
 		ath11k_wmi_fill_ns_offload(ar, offload, &buf_ptr, enable, 1);
 
-	return ath11k_wmi_cmd_send(ar->wmi, skb, WMI_SET_ARP_NS_OFFLOAD_CMDID);
+	ret = ath11k_wmi_cmd_send(ar->wmi, skb, WMI_SET_ARP_NS_OFFLOAD_CMDID);
+	if (ret) {
+		ath11k_warn(ar->ab, "failed to send WMI_SET_ARP_NS_OFFLOAD_CMDID\n");
+		dev_kfree_skb(skb);
+	}
+
+	return ret;
 }
 
 int ath11k_wmi_gtk_rekey_offload(struct ath11k *ar,
@@ -9883,7 +9930,7 @@ int ath11k_wmi_gtk_rekey_offload(struct ath11k *ar,
 {
 	struct wmi_gtk_rekey_offload_cmd *cmd;
 	struct ath11k_rekey_data *rekey_data = &arvif->rekey_data;
-	int len;
+	int ret, len;
 	struct sk_buff *skb;
 	__le64 replay_ctr;
 
@@ -9917,14 +9964,20 @@ int ath11k_wmi_gtk_rekey_offload(struct ath11k *ar,
 
 	ath11k_dbg(ar->ab, ATH11K_DBG_WMI, "offload gtk rekey vdev: %d %d\n",
 		   arvif->vdev_id, enable);
-	return ath11k_wmi_cmd_send(ar->wmi, skb, WMI_GTK_OFFLOAD_CMDID);
+	ret = ath11k_wmi_cmd_send(ar->wmi, skb, WMI_GTK_OFFLOAD_CMDID);
+	if (ret) {
+		ath11k_warn(ar->ab, "failed to send WMI_GTK_OFFLOAD_CMDID offload\n");
+		dev_kfree_skb(skb);
+	}
+
+	return ret;
 }
 
 int ath11k_wmi_gtk_rekey_getinfo(struct ath11k *ar,
 				 struct ath11k_vif *arvif)
 {
 	struct wmi_gtk_rekey_offload_cmd *cmd;
-	int len;
+	int ret, len;
 	struct sk_buff *skb;
 
 	len = sizeof(*cmd);
@@ -9941,7 +9994,13 @@ int ath11k_wmi_gtk_rekey_getinfo(struct ath11k *ar,
 
 	ath11k_dbg(ar->ab, ATH11K_DBG_WMI, "get gtk rekey vdev_id: %d\n",
 		   arvif->vdev_id);
-	return ath11k_wmi_cmd_send(ar->wmi, skb, WMI_GTK_OFFLOAD_CMDID);
+	ret = ath11k_wmi_cmd_send(ar->wmi, skb, WMI_GTK_OFFLOAD_CMDID);
+	if (ret) {
+		ath11k_warn(ar->ab, "failed to send WMI_GTK_OFFLOAD_CMDID getinfo\n");
+		dev_kfree_skb(skb);
+	}
+
+	return ret;
 }
 
 int ath11k_wmi_pdev_set_bios_sar_table_param(struct ath11k *ar, const u8 *sar_val)
@@ -9951,6 +10010,7 @@ int ath11k_wmi_pdev_set_bios_sar_table_param(struct ath11k *ar, const u8 *sar_va
 	struct sk_buff *skb;
 	u8 *buf_ptr;
 	u32 len, sar_len_aligned, rsvd_len_aligned;
+	int ret;
 
 	sar_len_aligned = roundup(BIOS_SAR_TABLE_LEN, sizeof(u32));
 	rsvd_len_aligned = roundup(BIOS_SAR_RSVD1_LEN, sizeof(u32));
@@ -9981,7 +10041,13 @@ int ath11k_wmi_pdev_set_bios_sar_table_param(struct ath11k *ar, const u8 *sar_va
 	tlv->header = FIELD_PREP(WMI_TLV_TAG, WMI_TAG_ARRAY_BYTE) |
 		      FIELD_PREP(WMI_TLV_LEN, rsvd_len_aligned);
 
-	return ath11k_wmi_cmd_send(wmi, skb, WMI_PDEV_SET_BIOS_SAR_TABLE_CMDID);
+	ret = ath11k_wmi_cmd_send(wmi, skb, WMI_PDEV_SET_BIOS_SAR_TABLE_CMDID);
+	if (ret) {
+		ath11k_warn(ar->ab, "failed to send WMI_PDEV_SET_BIOS_SAR_TABLE_CMDID\n");
+		dev_kfree_skb(skb);
+	}
+
+	return ret;
 }
 
 int ath11k_wmi_pdev_set_bios_geo_table_param(struct ath11k *ar)
@@ -9992,6 +10058,7 @@ int ath11k_wmi_pdev_set_bios_geo_table_param(struct ath11k *ar)
 	struct sk_buff *skb;
 	u8 *buf_ptr;
 	u32 len, rsvd_len_aligned;
+	int ret;
 
 	rsvd_len_aligned = roundup(BIOS_SAR_RSVD2_LEN, sizeof(u32));
 	len = sizeof(*cmd) + TLV_HDR_SIZE + rsvd_len_aligned;
@@ -10011,7 +10078,13 @@ int ath11k_wmi_pdev_set_bios_geo_table_param(struct ath11k *ar)
 	tlv->header = FIELD_PREP(WMI_TLV_TAG, WMI_TAG_ARRAY_BYTE) |
 		      FIELD_PREP(WMI_TLV_LEN, rsvd_len_aligned);
 
-	return ath11k_wmi_cmd_send(wmi, skb, WMI_PDEV_SET_BIOS_GEO_TABLE_CMDID);
+	ret = ath11k_wmi_cmd_send(wmi, skb, WMI_PDEV_SET_BIOS_GEO_TABLE_CMDID);
+	if (ret) {
+		ath11k_warn(ar->ab, "failed to send WMI_PDEV_SET_BIOS_GEO_TABLE_CMDID\n");
+		dev_kfree_skb(skb);
+	}
+
+	return ret;
 }
 
 int ath11k_wmi_sta_keepalive(struct ath11k *ar,
@@ -10022,6 +10095,7 @@ int ath11k_wmi_sta_keepalive(struct ath11k *ar,
 	struct wmi_sta_keepalive_arp_resp *arp;
 	struct sk_buff *skb;
 	size_t len;
+	int ret;
 
 	len = sizeof(*cmd) + sizeof(*arp);
 	skb = ath11k_wmi_alloc_skb(wmi->wmi_ab, len);
@@ -10053,7 +10127,13 @@ int ath11k_wmi_sta_keepalive(struct ath11k *ar,
 		   "sta keepalive vdev %d enabled %d method %d interval %d\n",
 		   arg->vdev_id, arg->enabled, arg->method, arg->interval);
 
-	return ath11k_wmi_cmd_send(wmi, skb, WMI_STA_KEEPALIVE_CMDID);
+	ret = ath11k_wmi_cmd_send(wmi, skb, WMI_STA_KEEPALIVE_CMDID);
+	if (ret) {
+		ath11k_warn(ar->ab, "failed to send WMI_STA_KEEPALIVE_CMDID\n");
+		dev_kfree_skb(skb);
+	}
+
+	return ret;
 }
 
 bool ath11k_wmi_supports_6ghz_cc_ext(struct ath11k *ar)
-- 
2.53.0


