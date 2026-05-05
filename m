Return-Path: <linux-wireless+bounces-35949-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sDhRKhYo+mmHKQMAu9opvQ
	(envelope-from <linux-wireless+bounces-35949-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 05 May 2026 19:25:42 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DB9F4D1FF1
	for <lists+linux-wireless@lfdr.de>; Tue, 05 May 2026 19:25:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 520123069EAB
	for <lists+linux-wireless@lfdr.de>; Tue,  5 May 2026 17:24:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFAFF47DFAB;
	Tue,  5 May 2026 17:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mokrynskyi.com header.i=@mokrynskyi.com header.b="L3ZfOOA1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.mokrynskyi.com (mail.mokrynskyi.com [65.109.39.229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 928353E929C
	for <linux-wireless@vger.kernel.org>; Tue,  5 May 2026 17:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.39.229
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778001882; cv=none; b=ZoHw/22jctkarhyFV2uQW1TDjsQI0kGElXR76V+dNvwSWUCIHaXgRyXpnxQNEp4OnWhF8QvIdu2FWsKul1shxYgssXUBf5aQcD8ALQz2T49+XFxnVujIXtoVo3bNvw2puqver/cAOMhgsgCpQD03OP1+pEJ8yrq83hFLmBqvkFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778001882; c=relaxed/simple;
	bh=N5EUruJ6yaDQi8PdgEeY6uh5PLCG7sQb5Ry0LUHIqUc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z8Issny2pu5gpac/q2g9wzmqem8Bxha4sWgcnpRYdBctSRhgdB8gb8HjwhLAU1ugXP//StDxVpRLUpIIN5tQpE2FC0CdaZbyfZqHpvuPyvVDHUvA6F52KvLDGvfBWkzIp2836N5xIMpiHx5Jja6cZBd7wNxJFwPJHiWVxN1MA6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mokrynskyi.com; spf=pass smtp.mailfrom=mokrynskyi.com; dkim=pass (2048-bit key) header.d=mokrynskyi.com header.i=@mokrynskyi.com header.b=L3ZfOOA1; arc=none smtp.client-ip=65.109.39.229
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mokrynskyi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mokrynskyi.com
From: Nazar Mokrynskyi <nazar@mokrynskyi.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mokrynskyi.com;
	s=dkim; t=1778001876;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xRjGmSXnfyqa5TGEncOZBsbYdyG6uICmkKgL4DXNmjQ=;
	b=L3ZfOOA1PdmLNse/2N0fpZS1uFo00roq2A4Vn2ExFte1N21poMOMyl2I03pPakUydzpi1O
	7zJG+/cW4KRDxhu3EGlA6Gt7tSHC16ed9CBo+uC0UTTaJdsBl9oRj916I/dA4WcJZ2YWY+
	g1pN9zGDJhwzka3wVZNL2M37LLjaf2DELWHrivyRSjw3ejft57xHp/1H3tbcyFdvOfAHbN
	DpzDXfPbjfq+Y/v3KF+j1sxwjJhLSu76cTR5LOKC6F/7bA/7NWQ3WyM40Zz9X7vA9FV31m
	rpI9Vk75BJhstcvG2TF3KBKk9wJhRxW1GeX39byh6IbeStA/+cuw+Ga5hm7t9w==
Authentication-Results: mail.mokrynskyi.com;
	auth=pass smtp.mailfrom=nazar@mokrynskyi.com
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
	jeff.johnson@oss.qualcomm.com,
	Nazar Mokrynskyi <nazar@mokrynskyi.com>
Subject: [PATCH 2/2] wifi: ath12k: skip unknown direct buffer ring module IDs
Date: Tue,  5 May 2026 20:24:15 +0300
Message-ID: <20260505172415.566328-3-nazar@mokrynskyi.com>
In-Reply-To: <20260505172415.566328-1-nazar@mokrynskyi.com>
References: <20260505172415.566328-1-nazar@mokrynskyi.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: -----
X-Rspamd-Queue-Id: 0DB9F4D1FF1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[mokrynskyi.com,reject];
	R_DKIM_ALLOW(-0.20)[mokrynskyi.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35949-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nazar@mokrynskyi.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[mokrynskyi.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mokrynskyi.com:email,mokrynskyi.com:dkim,mokrynskyi.com:mid]

The firmware may advertise direct buffer ring capabilities for module
IDs beyond what the driver currently knows about (WMI_DIRECT_BUF_MAX).
This happens with newer firmware versions that support additional ring
types not yet implemented in the driver.

The current code treats an unknown module_id as a fatal error, returning
-EINVAL and tearing down the entire driver initialization. This is
incorrect: the driver only needs to set up rings for types it uses
(SPECTRAL=0, CFR=1) and can safely ignore capability advertisements for
unknown types.

Change the unknown module_id handling to skip the entry with a debug
message rather than failing, allowing initialization to proceed.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.6-01243-QCAHKSWPL_SILICONZ-1

Signed-off-by: Nazar Mokrynskyi <nazar@mokrynskyi.com>
---
 drivers/net/wireless/ath/ath12k/wmi.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
index 484fdd3b1..0e776a8d8 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -4814,10 +4814,10 @@ static int ath12k_wmi_dma_ring_caps(struct ath12k_base *ab,
 	dir_buff_caps = ab->db_caps;
 	for (i = 0; i < dma_caps_parse->n_dma_ring_caps; i++) {
 		if (le32_to_cpu(dma_caps[i].module_id) >= WMI_DIRECT_BUF_MAX) {
-			ath12k_warn(ab, "Invalid module id %d\n",
-				    le32_to_cpu(dma_caps[i].module_id));
-			ret = -EINVAL;
-			goto free_dir_buff;
+			ath12k_dbg(ab, ATH12K_DBG_WMI,
+				   "Skipping unknown direct buf ring module id %d\n",
+				   le32_to_cpu(dma_caps[i].module_id));
+			continue;
 		}
 
 		dir_buff_caps[i].id = le32_to_cpu(dma_caps[i].module_id);
@@ -4829,10 +4829,6 @@ static int ath12k_wmi_dma_ring_caps(struct ath12k_base *ab,
 	}
 
 	return 0;
-
-free_dir_buff:
-	ath12k_wmi_free_dbring_caps(ab);
-	return ret;
 }
 
 static void
-- 
2.43.0


