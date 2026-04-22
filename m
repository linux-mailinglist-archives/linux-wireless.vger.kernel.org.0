Return-Path: <linux-wireless+bounces-35222-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oKvwJ5756GnLSQIAu9opvQ
	(envelope-from <linux-wireless+bounces-35222-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Apr 2026 18:38:54 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 459F1448C73
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Apr 2026 18:38:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CA53C305D1FF
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Apr 2026 16:33:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AD2E271443;
	Wed, 22 Apr 2026 16:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bFp8vjWK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 818AE37CD3F
	for <linux-wireless@vger.kernel.org>; Wed, 22 Apr 2026 16:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776875582; cv=none; b=Yk/me9zwuM5K8Ua5FJ4Jz/63PdOgf+IQXDjGdpt4NVhgfJfoRRywlOJXSy7rmXl5iiOiM1hsT5nFiBCT2EvJ2Wo15bAoYOJ4bDe4IdGWHAoBQKiMDa7NqMeYxYh/wOesBy4TZB93ZLuj6Qt1WT2vl76QfZTZCQXs94LPlZcNvJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776875582; c=relaxed/simple;
	bh=3nFeSucDBJKGdnOTCeahosFXgN/K6d38XNU6R+Y8N5E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XDnfzux3jSlKINhCj1mLIWlm1SF8EdzmKPWliohX00ez0+15ZfoEteJAtEn8UBjE23xpo08eb3mtLGCtb2heQBCad0XPQyw6ek0nN1lTbuhrtAQRhy+ir0TYtuJ6f8p8Zre1cxXvRAWchameC8gaBvrTKIIAAWQ8hK14xYOMBaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bFp8vjWK; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4891d7164ddso22669265e9.3
        for <linux-wireless@vger.kernel.org>; Wed, 22 Apr 2026 09:33:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776875579; x=1777480379; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bmBDooZo7vOPaIxv6eVnCqcVx+IqKCBf8vptCbn1QR0=;
        b=bFp8vjWKluZfYtmS5ydHNRcGbZVnQPWjdUaJRSCVpCM+SGOo+ZJjvTatfHveI1c2ka
         yCiqJ/t7f+V3IIC/85m6ekMK+ZzCGEWYmA7sLVvWPiBjpwdZ4v/sIP0AlGgLVnAs2li3
         TVERXje9RXflytWX9nHGy2hU5jwrBs0mwSlfgItL9oAx+u+MP2DdRo70/pI6LCMzaCep
         9gVXTnuJ+fT1ogUN5+ONsUcZJYqUF9d7qPVGsRU+kyrTF7uFYXj6MdgeTbdVoWVIa3Iv
         0hQhwPdQaOeEZr7s+s6V7OUUIPYcTejQcorXq27W9J/D6AtDkxW03FEg+aufwrhx10nW
         ffBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776875579; x=1777480379;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bmBDooZo7vOPaIxv6eVnCqcVx+IqKCBf8vptCbn1QR0=;
        b=tZ8/GJXXCmoy/D3z93+EHZsia0kCMiLc2DpRb7I1BgjpxcrCW7DGJ+P0fPEN5WIDRJ
         VQMnzOT87nTlBcp+uRU2IdjynZghV8OrR5vDlUP2ApjVDahQnoG5UsEV+wVEaVmL1LHR
         scUWtdntGRJjeAVGBa4/IoFAYIypHwtBxizdXi8NpMSCJ89kuXyfFY7gkIo5dVFaoeDg
         ykvwu9QsspsJKABVlBWH2/LXT2JANzv7o03TBefSEv64gO7P6Bu1GDR4J3GBPMW4ByzO
         yp4E5kXpFI03oPh4BNqpOX9ZRGXmKkhwCdD/LlEBFFlMYIL37Bz8h/C6jSZm2mJPwfjX
         O+/A==
X-Gm-Message-State: AOJu0Yy1bpqbUPxtgWPsNE9aLSqUeOnW+AbnIKPb21qLnW4mY15kgK9i
	1xZMPk6vBqjsXDCw7VnMbiBeCi0oj3+whZjLWe6C2Q3HFp4GOcUKBY50
X-Gm-Gg: AeBDievYUboFJJx2810ifm2EYexGVe573YTgs4UnCwtvfkjTODijQtWLamcUoPqXbKJ
	0NGf4umHxaPBE8mnyjp4AZneeG3BidAVGSQpCAunNoD6ot5ip4cg2AKIOng1lu3QEeFzUeNNDCy
	dOXtYX9qUPjE3GRTr8GRVB66F/10WJUAY+YLlBu17Q+/GBg5f/QnvAdyUDyUPcqAGtzwZhIYtnA
	e0n2KlDBZpl02+j/gL0WMHvnVRxs3vogy+NtrYXMY1+fCKQMns0Y8H5l//2SEg/iD8bmp1eDR/L
	lpWjo9Az4FC362Z3ueHj2JT6SuzeMPW9BGA/E2bFgOJ3v2Fv5c9g9KMbfUQeUkbKg6xuyAGcc4n
	usnsVmdUo0CusSQrz/aRtBUsn4Q957eztpFGcbulgJsPAMO22/eu+CfZfDSxb6mRYRPRGW9qqrZ
	NreoS49IqIFajMxJg/r8GIBy84RGSDzAbnS5dcTqRJgBim4TnJmtYmNJWMmjcXtYKe62s=
X-Received: by 2002:a05:600c:308a:b0:48a:54fd:54ea with SMTP id 5b1f17b1804b1-48a54fd690emr83495655e9.12.1776875578748;
        Wed, 22 Apr 2026 09:32:58 -0700 (PDT)
Received: from syracuse.iliad.local (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4e4633bsm46189945f8f.26.2026.04.22.09.32.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 09:32:58 -0700 (PDT)
From: Nicolas Escande <nico.escande@gmail.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH ath] wifi: ath12k: fix leak in some ath12k_wmi_xxx() functions
Date: Wed, 22 Apr 2026 18:32:58 +0200
Message-ID: <20260422163258.3013872-1-nico.escande@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_FROM(0.00)[bounces-35222-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
X-Rspamd-Queue-Id: 459F1448C73
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Some wmi functions were using plain 'return ath12k_wmi_cmd_send(...)'
without explicitly handling the error code. This leads to leaking the skb
in case of error.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00218-QCAHKSWPL_SILICONZ-1

Fixes: 66a9448b1b89 ("wifi: ath12k: implement hardware data filter")
Fixes: 593174170919 ("wifi: ath12k: implement WoW enable and wakeup commands")
Fixes: 4a3c212eee0e ("wifi: ath12k: add basic WoW functionalities")
Fixes: 16f474d6d49d ("wifi: ath12k: add WoW net-detect functionality")
Fixes: 1666108c74c4 ("wifi: ath12k: support ARP and NS offload")
Fixes: aab4ae566fa1 ("wifi: ath12k: support GTK rekey offload")
Fixes: 7af01e569529 ("wifi: ath12k: handle keepalive during WoWLAN suspend and resume")
Signed-off-by: Nicolas Escande <nico.escande@gmail.com>
---
 drivers/net/wireless/ath/ath12k/wmi.c | 103 ++++++++++++++++++++++----
 1 file changed, 88 insertions(+), 15 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
index 65a05a9520ff..75c87edd2a8a 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -10251,7 +10251,7 @@ int ath12k_wmi_hw_data_filter_cmd(struct ath12k *ar, struct wmi_hw_data_filter_a
 {
 	struct wmi_hw_data_filter_cmd *cmd;
 	struct sk_buff *skb;
-	int len;
+	int ret, len;
 
 	len = sizeof(*cmd);
 	skb = ath12k_wmi_alloc_skb(ar->wmi->wmi_ab, len);
@@ -10275,7 +10275,13 @@ int ath12k_wmi_hw_data_filter_cmd(struct ath12k *ar, struct wmi_hw_data_filter_a
 		   "wmi hw data filter enable %d filter_bitmap 0x%x\n",
 		   arg->enable, arg->hw_filter_bitmap);
 
-	return ath12k_wmi_cmd_send(ar->wmi, skb, WMI_HW_DATA_FILTER_CMDID);
+	ret = ath12k_wmi_cmd_send(ar->wmi, skb, WMI_HW_DATA_FILTER_CMDID);
+	if (ret) {
+		ath12k_warn(ar->ab, "failed to send WMI_HW_DATA_FILTER_CMDID\n");
+		dev_kfree_skb(skb);
+	}
+
+	return ret;
 }
 
 int ath12k_wmi_wow_host_wakeup_ind(struct ath12k *ar)
@@ -10283,6 +10289,7 @@ int ath12k_wmi_wow_host_wakeup_ind(struct ath12k *ar)
 	struct wmi_wow_host_wakeup_cmd *cmd;
 	struct sk_buff *skb;
 	size_t len;
+	int ret;
 
 	len = sizeof(*cmd);
 	skb = ath12k_wmi_alloc_skb(ar->wmi->wmi_ab, len);
@@ -10295,14 +10302,20 @@ int ath12k_wmi_wow_host_wakeup_ind(struct ath12k *ar)
 
 	ath12k_dbg(ar->ab, ATH12K_DBG_WMI, "wmi tlv wow host wakeup ind\n");
 
-	return ath12k_wmi_cmd_send(ar->wmi, skb, WMI_WOW_HOSTWAKEUP_FROM_SLEEP_CMDID);
+	ret = ath12k_wmi_cmd_send(ar->wmi, skb, WMI_WOW_HOSTWAKEUP_FROM_SLEEP_CMDID);
+	if (ret) {
+		ath12k_warn(ar->ab, "failed to send WMI_WOW_HOSTWAKEUP_FROM_SLEEP_CMDID\n");
+		dev_kfree_skb(skb);
+	}
+
+	return ret;
 }
 
 int ath12k_wmi_wow_enable(struct ath12k *ar)
 {
 	struct wmi_wow_enable_cmd *cmd;
 	struct sk_buff *skb;
-	int len;
+	int ret, len;
 
 	len = sizeof(*cmd);
 	skb = ath12k_wmi_alloc_skb(ar->wmi->wmi_ab, len);
@@ -10317,7 +10330,13 @@ int ath12k_wmi_wow_enable(struct ath12k *ar)
 	cmd->pause_iface_config = cpu_to_le32(WOW_IFACE_PAUSE_ENABLED);
 	ath12k_dbg(ar->ab, ATH12K_DBG_WMI, "wmi tlv wow enable\n");
 
-	return ath12k_wmi_cmd_send(ar->wmi, skb, WMI_WOW_ENABLE_CMDID);
+	ret = ath12k_wmi_cmd_send(ar->wmi, skb, WMI_WOW_ENABLE_CMDID);
+	if (ret) {
+		ath12k_warn(ar->ab, "failed to send WMI_WOW_ENABLE_CMDID\n");
+		dev_kfree_skb(skb);
+	}
+
+	return ret;
 }
 
 int ath12k_wmi_wow_add_wakeup_event(struct ath12k *ar, u32 vdev_id,
@@ -10327,6 +10346,7 @@ int ath12k_wmi_wow_add_wakeup_event(struct ath12k *ar, u32 vdev_id,
 	struct wmi_wow_add_del_event_cmd *cmd;
 	struct sk_buff *skb;
 	size_t len;
+	int ret;
 
 	len = sizeof(*cmd);
 	skb = ath12k_wmi_alloc_skb(ar->wmi->wmi_ab, len);
@@ -10343,7 +10363,13 @@ int ath12k_wmi_wow_add_wakeup_event(struct ath12k *ar, u32 vdev_id,
 	ath12k_dbg(ar->ab, ATH12K_DBG_WMI, "wmi tlv wow add wakeup event %s enable %d vdev_id %d\n",
 		   wow_wakeup_event(event), enable, vdev_id);
 
-	return ath12k_wmi_cmd_send(ar->wmi, skb, WMI_WOW_ENABLE_DISABLE_WAKE_EVENT_CMDID);
+	ret = ath12k_wmi_cmd_send(ar->wmi, skb, WMI_WOW_ENABLE_DISABLE_WAKE_EVENT_CMDID);
+	if (ret) {
+		ath12k_warn(ar->ab, "failed to send WMI_WOW_ENABLE_DISABLE_WAKE_EVENT_CMDID\n");
+		dev_kfree_skb(skb);
+	}
+
+	return ret;
 }
 
 int ath12k_wmi_wow_add_pattern(struct ath12k *ar, u32 vdev_id, u32 pattern_id,
@@ -10356,6 +10382,7 @@ int ath12k_wmi_wow_add_pattern(struct ath12k *ar, u32 vdev_id, u32 pattern_id,
 	struct sk_buff *skb;
 	void *ptr;
 	size_t len;
+	int ret;
 
 	len = sizeof(*cmd) +
 	      sizeof(*tlv) +			/* array struct */
@@ -10435,7 +10462,13 @@ int ath12k_wmi_wow_add_pattern(struct ath12k *ar, u32 vdev_id, u32 pattern_id,
 	ath12k_dbg_dump(ar->ab, ATH12K_DBG_WMI, NULL, "wow bitmask: ",
 			bitmap->bitmaskbuf, pattern_len);
 
-	return ath12k_wmi_cmd_send(ar->wmi, skb, WMI_WOW_ADD_WAKE_PATTERN_CMDID);
+	ret = ath12k_wmi_cmd_send(ar->wmi, skb, WMI_WOW_ADD_WAKE_PATTERN_CMDID);
+	if (ret) {
+		ath12k_warn(ar->ab, "failed to send WMI_WOW_ADD_WAKE_PATTERN_CMDID\n");
+		dev_kfree_skb(skb);
+	}
+
+	return ret;
 }
 
 int ath12k_wmi_wow_del_pattern(struct ath12k *ar, u32 vdev_id, u32 pattern_id)
@@ -10443,6 +10476,7 @@ int ath12k_wmi_wow_del_pattern(struct ath12k *ar, u32 vdev_id, u32 pattern_id)
 	struct wmi_wow_del_pattern_cmd *cmd;
 	struct sk_buff *skb;
 	size_t len;
+	int ret;
 
 	len = sizeof(*cmd);
 	skb = ath12k_wmi_alloc_skb(ar->wmi->wmi_ab, len);
@@ -10459,7 +10493,13 @@ int ath12k_wmi_wow_del_pattern(struct ath12k *ar, u32 vdev_id, u32 pattern_id)
 	ath12k_dbg(ar->ab, ATH12K_DBG_WMI, "wmi tlv wow del pattern vdev_id %d pattern_id %d\n",
 		   vdev_id, pattern_id);
 
-	return ath12k_wmi_cmd_send(ar->wmi, skb, WMI_WOW_DEL_WAKE_PATTERN_CMDID);
+	ret = ath12k_wmi_cmd_send(ar->wmi, skb, WMI_WOW_DEL_WAKE_PATTERN_CMDID);
+	if (ret) {
+		ath12k_warn(ar->ab, "failed to send WMI_WOW_DEL_WAKE_PATTERN_CMDID\n");
+		dev_kfree_skb(skb);
+	}
+
+	return ret;
 }
 
 static struct sk_buff *
@@ -10595,6 +10635,7 @@ int ath12k_wmi_wow_config_pno(struct ath12k *ar, u32 vdev_id,
 			      struct wmi_pno_scan_req_arg  *pno_scan)
 {
 	struct sk_buff *skb;
+	int ret;
 
 	if (pno_scan->enable)
 		skb = ath12k_wmi_op_gen_config_pno_start(ar, vdev_id, pno_scan);
@@ -10604,7 +10645,13 @@ int ath12k_wmi_wow_config_pno(struct ath12k *ar, u32 vdev_id,
 	if (IS_ERR_OR_NULL(skb))
 		return -ENOMEM;
 
-	return ath12k_wmi_cmd_send(ar->wmi, skb, WMI_NETWORK_LIST_OFFLOAD_CONFIG_CMDID);
+	ret = ath12k_wmi_cmd_send(ar->wmi, skb, WMI_NETWORK_LIST_OFFLOAD_CONFIG_CMDID);
+	if (ret) {
+		ath12k_warn(ar->ab, "failed to send WMI_NETWORK_LIST_OFFLOAD_CONFIG_CMDID\n");
+		dev_kfree_skb(skb);
+	}
+
+	return ret;
 }
 
 static void ath12k_wmi_fill_ns_offload(struct ath12k *ar,
@@ -10717,6 +10764,7 @@ int ath12k_wmi_arp_ns_offload(struct ath12k *ar,
 	void *buf_ptr;
 	size_t len;
 	u8 ns_cnt, ns_ext_tuples = 0;
+	int ret;
 
 	ns_cnt = offload->ipv6_count;
 
@@ -10752,7 +10800,13 @@ int ath12k_wmi_arp_ns_offload(struct ath12k *ar,
 	if (ns_ext_tuples)
 		ath12k_wmi_fill_ns_offload(ar, offload, &buf_ptr, enable, 1);
 
-	return ath12k_wmi_cmd_send(ar->wmi, skb, WMI_SET_ARP_NS_OFFLOAD_CMDID);
+	ret = ath12k_wmi_cmd_send(ar->wmi, skb, WMI_SET_ARP_NS_OFFLOAD_CMDID);
+	if (ret) {
+		ath12k_warn(ar->ab, "failed to send WMI_SET_ARP_NS_OFFLOAD_CMDID\n");
+		dev_kfree_skb(skb);
+	}
+
+	return ret;
 }
 
 int ath12k_wmi_gtk_rekey_offload(struct ath12k *ar,
@@ -10762,7 +10816,7 @@ int ath12k_wmi_gtk_rekey_offload(struct ath12k *ar,
 	struct wmi_gtk_rekey_offload_cmd *cmd;
 	struct sk_buff *skb;
 	__le64 replay_ctr;
-	int len;
+	int ret, len;
 
 	len = sizeof(*cmd);
 	skb =  ath12k_wmi_alloc_skb(ar->wmi->wmi_ab, len);
@@ -10789,7 +10843,13 @@ int ath12k_wmi_gtk_rekey_offload(struct ath12k *ar,
 
 	ath12k_dbg(ar->ab, ATH12K_DBG_WMI, "offload gtk rekey vdev: %d %d\n",
 		   arvif->vdev_id, enable);
-	return ath12k_wmi_cmd_send(ar->wmi, skb, WMI_GTK_OFFLOAD_CMDID);
+	ret = ath12k_wmi_cmd_send(ar->wmi, skb, WMI_GTK_OFFLOAD_CMDID);
+	if (ret) {
+		ath12k_warn(ar->ab, "failed to send WMI_GTK_OFFLOAD_CMDID offload\n");
+		dev_kfree_skb(skb);
+	}
+
+	return ret;
 }
 
 int ath12k_wmi_gtk_rekey_getinfo(struct ath12k *ar,
@@ -10797,7 +10857,7 @@ int ath12k_wmi_gtk_rekey_getinfo(struct ath12k *ar,
 {
 	struct wmi_gtk_rekey_offload_cmd *cmd;
 	struct sk_buff *skb;
-	int len;
+	int ret, len;
 
 	len = sizeof(*cmd);
 	skb =  ath12k_wmi_alloc_skb(ar->wmi->wmi_ab, len);
@@ -10811,7 +10871,13 @@ int ath12k_wmi_gtk_rekey_getinfo(struct ath12k *ar,
 
 	ath12k_dbg(ar->ab, ATH12K_DBG_WMI, "get gtk rekey vdev_id: %d\n",
 		   arvif->vdev_id);
-	return ath12k_wmi_cmd_send(ar->wmi, skb, WMI_GTK_OFFLOAD_CMDID);
+	ret = ath12k_wmi_cmd_send(ar->wmi, skb, WMI_GTK_OFFLOAD_CMDID);
+	if (ret) {
+		ath12k_warn(ar->ab, "failed to send WMI_GTK_OFFLOAD_CMDID getinfo\n");
+		dev_kfree_skb(skb);
+	}
+
+	return ret;
 }
 
 int ath12k_wmi_sta_keepalive(struct ath12k *ar,
@@ -10822,6 +10888,7 @@ int ath12k_wmi_sta_keepalive(struct ath12k *ar,
 	struct wmi_sta_keepalive_cmd *cmd;
 	struct sk_buff *skb;
 	size_t len;
+	int ret;
 
 	len = sizeof(*cmd) + sizeof(*arp);
 	skb = ath12k_wmi_alloc_skb(wmi->wmi_ab, len);
@@ -10849,7 +10916,13 @@ int ath12k_wmi_sta_keepalive(struct ath12k *ar,
 		   "wmi sta keepalive vdev %d enabled %d method %d interval %d\n",
 		   arg->vdev_id, arg->enabled, arg->method, arg->interval);
 
-	return ath12k_wmi_cmd_send(wmi, skb, WMI_STA_KEEPALIVE_CMDID);
+	ret = ath12k_wmi_cmd_send(wmi, skb, WMI_STA_KEEPALIVE_CMDID);
+	if (ret) {
+		ath12k_warn(ar->ab, "failed to send WMI_STA_KEEPALIVE_CMDID\n");
+		dev_kfree_skb(skb);
+	}
+
+	return ret;
 }
 
 int ath12k_wmi_mlo_setup(struct ath12k *ar, struct wmi_mlo_setup_arg *mlo_params)
-- 
2.53.0


