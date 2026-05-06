Return-Path: <linux-wireless+bounces-36031-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iD66BiJG+2lPYgMAu9opvQ
	(envelope-from <linux-wireless+bounces-36031-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 06 May 2026 15:46:10 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 846814DB446
	for <lists+linux-wireless@lfdr.de>; Wed, 06 May 2026 15:46:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D2940309B22A
	for <lists+linux-wireless@lfdr.de>; Wed,  6 May 2026 13:43:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A81E547D95B;
	Wed,  6 May 2026 13:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AF/4/A1/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A29C347DD6B
	for <linux-wireless@vger.kernel.org>; Wed,  6 May 2026 13:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778074968; cv=none; b=BBJLNmXXCZSDhVm86oyDU3oJnh/mo+ah6N42OM+lvZ4vNT9z4yQrmNG3RBk/xMfBd7fvPwO5uc7fXfHVhmfC8p70NLh732dJ2y4Iz5UjNZhUZkUEmcCmxyenuhza86jyz7tnJF3o79rbOP5zmVweu48TV3xoWyDv0LbnJ2XpM9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778074968; c=relaxed/simple;
	bh=15YLNtu4DqxZYp/ssYvCyxCTXnE4wk1KN8ymKybQ/MU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rNhnwjofhManRK7yFWE93AxQH26hnVr7m5P3f7aOOWhgivgx4DfUJj3qewfsMUuUl2/nRTwTrhydW9+I0X+MgffPr7YRMm9QoUGnAbrM4LOEI+yy0wmRGtt0GVi09lyxLLI6LYBSyzYc14DbfPDJ4KhTo1k5WvBhNYmm6Z8qZ+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AF/4/A1/; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-43eb05b1875so3463581f8f.3
        for <linux-wireless@vger.kernel.org>; Wed, 06 May 2026 06:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778074963; x=1778679763; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mvBq+xLHwx+fK/mB2YwxQsW3HjTF7InbZSrqKmztdrE=;
        b=AF/4/A1/KV0apxGTr5SJOC6NqgsuSpOHXJoxsKqRuXV64hujVd4YBaCWBHFChlbvCb
         xRLw86etkt3kgFvux8inYzHSFicqz1wrMqFjFuQIv9YwHpF2rv0Y76FqMXtnNEZfIqMw
         LKrgbXOOa81rxTLh+UC6R0ruaEmtlY7GQEPfh0qFGmT01aeOJPEZuJgOzUw5PNx39NLg
         pilkMdv6FQn2N95IEvrOPvkoVZns+8cS4oyg45rq+fAjzkJGuBSnmsT3BfQW4cmW+eXX
         hzEwuQ/khV44K3QSRywI1cspubcaINJoaab32i0bWXgRP3cDPkr5LnGt/RdsMMLHLDiy
         80Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778074963; x=1778679763;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mvBq+xLHwx+fK/mB2YwxQsW3HjTF7InbZSrqKmztdrE=;
        b=V9yiihC1SClBltesKdQIPchoYeo2LiqHMb/hm4aP2iUzYfW0a/2Vw8rEzyOVYl7BxW
         asPISTSe1dhFFCy3p98Q9pQnlRxmcBkxcgZ0Ubnf8vSkXIqA2phaOJ6aQW1/UuCoICFt
         IKii4wCEs8iV9fWWcF4zBhCtB3Fw2ChDgqhyt6/sU2vBQrs+V8b7z0RxnMrxl7xRrwt/
         Vb2VP3XOCYngMCvLsfwOCrEkfjtI6t/H1F2yth7KOo3bY4neUFJGKnM1qMa1y3ammaZf
         8bVeNKfauzon0AknQx5FU9rNEy9MPZrnlo/f+Vg91Mz5+dgJnMKXWB7khEFXJoDBUFjk
         6xow==
X-Gm-Message-State: AOJu0YynV4883/p4znVjYRlPiVU7JO/LMw9Fkku6BRY0ISFdcURwjljW
	HuDvbcbv5vRmWLsvF7GCRfWzcLMLm6EBcfKBTTBQCxFsM6QGtsXzm/wfSMLzvA==
X-Gm-Gg: AeBDieufCs+zMOct30T0bnXC7MTSiYLej0rggoVGvnyqVYY1LvWwrE69s3/lJhtpkjh
	xLgRgb37TtWC9xahxW0Go55AP8dVS0xwglOwgfOGBk6XqwZR5c03w+XD/2pDCHvZ0H6bVH0cKhZ
	21GRewirh7Fiw7kUQ1WvZiSOsxqWzquUCKANsmnYMOGlrW7DboTINC2lBJNL0Zx3Sb5bWkglsfB
	i7GM4VCAIAG8KC+m65X1ejMteUmdJliFFjoha1jLioGcFjVVlgdX+ttv3zkS/yJcPCssFbjbNoU
	UPhwzQ5ejnzEph6Ukr/Xas8TWsAdgxeMlnf6PJqTsOwOjN3t2DT1RufKPpES/HNa2xlPnVeypdP
	9820cN7hfQtYR7BHksHnI5i01Y7goaPwocdotY5DFK8tpmcgy49Olu9o0I+/gKCAdwUiRXNII/a
	QsreyQ8fcYcGts+7riPaEsOMaRkcow7cZu3hyJk5QjlIvw5papBvYpeZ57U9xMdWtRisk=
X-Received: by 2002:a05:6000:2381:b0:43d:7261:8759 with SMTP id ffacd0b85a97d-4515d008856mr6046157f8f.28.1778074962344;
        Wed, 06 May 2026 06:42:42 -0700 (PDT)
Received: from syracuse.iliad.local (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45052483166sm12542182f8f.7.2026.05.06.06.42.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 06:42:41 -0700 (PDT)
From: Nicolas Escande <nico.escande@gmail.com>
To: ath11k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH v2 2/3] wifi: ath11k: fix error path leaks in some WMI calls
Date: Wed,  6 May 2026 15:42:39 +0200
Message-ID: <20260506134240.2284016-3-nico.escande@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260506134240.2284016-1-nico.escande@gmail.com>
References: <20260506134240.2284016-1-nico.escande@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 846814DB446
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_FROM(0.00)[bounces-36031-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

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
2.54.0


