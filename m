Return-Path: <linux-wireless+bounces-33234-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oDr5OjNqtmnUBQEAu9opvQ
	(envelope-from <linux-wireless+bounces-33234-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 15 Mar 2026 09:13:39 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6629529035D
	for <lists+linux-wireless@lfdr.de>; Sun, 15 Mar 2026 09:13:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0FD263047DD6
	for <lists+linux-wireless@lfdr.de>; Sun, 15 Mar 2026 08:13:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D3AA2494FF;
	Sun, 15 Mar 2026 08:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cq/nbTP4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 104F923A99F
	for <linux-wireless@vger.kernel.org>; Sun, 15 Mar 2026 08:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773562417; cv=none; b=ooU4MSGLQYgbLZ4MEaCaUwjhbOaCXUBXbnRoy7vNZGOUtFdgdXTQqxE2Vg0LHHBS86XZLq5auf0uiSAG4jZb0YnIl3ycnMxIFoHWCskIVMAHCzHqSVJ2InRbhHo0ruyBR4f3a6yRkeHoTX+APyI0SpqRJ4MYpM2TggHJIGYlErQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773562417; c=relaxed/simple;
	bh=uKmJoLtmmsQeWmKY+Hq9ioE42HsbXjE6fak8QMHJMFk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U9CWN0RKqfGYx8WJbwx/em2ACRghkmXnMMROeBa5SBDHF9bTVPFokhGDKHfn4u6aCIR6RmKvVNhTJ1225ocojljLvIj/Iot4ZkCYBJWg0pLp260Uer+1vXNCQ75J08z0nYCR2DzOyhzEOvgxqF18fN7oXAWMbKogH/woO8HqDNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cq/nbTP4; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b9382e59c0eso575687466b.0
        for <linux-wireless@vger.kernel.org>; Sun, 15 Mar 2026 01:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773562414; x=1774167214; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CBdYfpQsARbdjGI37WFIgWl/KvYpW6/tXUSbnC+M6Nw=;
        b=cq/nbTP4vyzFjIfyecfSsafxnW+QtN3XW/HUFPjUXjm3Y6Gdnhsds5Q5YZZGSkuwVv
         j23JOzh0YzjscmX5gnub/LE4a3BxKM43opR0UrfZiODSDGY75ePywS9KyDGmND50R8v2
         UP58/A/3vHWgAvmgxUIAhmzyaUkoDpwTEcuTRiEA2dVMs0bZBtRbz4Cd33t+vDL4maVN
         hjrzJ7kWhhxV0rZrCVuLGM8hToLs8taNMM/LY7lWQIAqNEYKBBh0X5qEPHDVu3axfO33
         wqfUIo/CyqCt3ox1+f7vrdj91a7FEo0DCVgerj1ti53vj7s0foJj3gCqVRkckgRHcjyD
         TzUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773562414; x=1774167214;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CBdYfpQsARbdjGI37WFIgWl/KvYpW6/tXUSbnC+M6Nw=;
        b=ZMdHzqZCpMKtzMqx0iIoSpPhzlGMkaCaxdQ2d5oGWkgUylH8nqKGZ+aEfYjG53MNTv
         8GaDny6t/xur2fbmQ3Ft+8T/cx7CsN7pZjp4ZcPi7ET8YHvv6KCwyjfyrw422EFoDZgs
         O8dwbETdlvAH2SAfw99j7vlDqAdq8UWQzzancPKggyb9RvTAVhkyOqM5NmWgMD2hMABP
         ducWt1qhHSDHoHNPfIUusvkGS8s6yG9PkSUcySmGSoAVsqImErXP3TZkeOtkXuSJKAjw
         ks1+yGXwoRmYgw+BHsGA2BpGt6Cw1h65Ar7eqld3LjAtmMciAS0Fu3s0gqT/kP7bbxt9
         hBcg==
X-Gm-Message-State: AOJu0YwRkrybwZBz0ZxLHJOWCLTacGIIjWWPhyP4t95NDiGcnbR6eQ17
	K+PLgCp6VlOj/OVYVdO2tMd3YqgsFMoHyxqNZpTt+4DxHtTyLbPo7Cnt1yTAiLN9jvxyXA==
X-Gm-Gg: ATEYQzzwOkW9Q0Iot0TtSk0hPS6QF2m9JnnvEIXxtjOtP0GpFNtoFLiTk3356+x67aa
	XhOsQ+Pwn5QBSWqFSUYmHLIKerLtZ4xicvd3d5dZ81lr3J/lUb/n/2KBjq6W71v6y+JCfE6Oas4
	oKutbZl+nP+sIgq5iPFQW67+UDFMuirBz2bgQJcvKk66nUGwLvktPdWPOE0tvO16uECmkIW+b4y
	75FyBdeXYnq0dYAJOzra6va3jk9Fkw65rwyvy1PMO0ILeKSTnu8h1Tredr3yy6pbMR4zAPBxmva
	vct1bVI/8ZH2i+lhMo2wihIQsb6+4cGyWWOYt5A89DULzlTIXHddU6S90ZKFJ/ejgHKx4Fdp49I
	NdxDsYAPl8MW1pekMq7sMJcxvRzappGAhCSnQiD6HI+Djc8KEspr9icbmF6ZlK77sCZ3OhB4lkz
	oTLcVwgSyGH0g5ncgJjh7luA==
X-Received: by 2002:a17:906:9f96:b0:b97:b6ef:fc8c with SMTP id a640c23a62f3a-b97b6f016ccmr12604666b.23.1773562413742;
        Sun, 15 Mar 2026 01:13:33 -0700 (PDT)
Received: from zenbook ([176.98.224.6])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-66350d80a90sm3590633a12.32.2026.03.15.01.13.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2026 01:13:32 -0700 (PDT)
From: Sheroz Juraev <goodmartiandev@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: stable@vger.kernel.org,
	Sheroz Juraev <goodmartiandev@gmail.com>
Subject: [PATCH wireless v2] wifi: iwlwifi: mld: stop TX during firmware restart
Date: Sun, 15 Mar 2026 13:12:21 +0500
Message-ID: <20260315081221.2678478-1-goodmartiandev@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260303104217.180715-1-goodmartiandev@gmail.com>
References: <20260303104217.180715-1-goodmartiandev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-33234-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[goodmartiandev@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6629529035D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When iwlwifi firmware crashes (e.g., NMI_INTERRUPT_UNKNOWN on Intel
BE201/Wi-Fi 7), iwl_mld_nic_error() sets mld->fw_status.in_hw_restart
to true. However, iwl_mld_tx_from_txq() does not check this flag before
dequeuing frames from mac80211 and pushing them to the transport layer.

Since the firmware is dead, iwl_trans_tx() returns -EIO for each frame,
which then gets freed immediately. Under high-throughput conditions
(e.g., Tailscale UDP traffic or active SSH sessions), this creates a
tight dequeue-send-fail-free loop that wastes CPU cycles and generates
rapid skb allocation churn, leading to memory pressure from slab
fragmentation.

The RX path already has this guard (iwl_mld_rx_mpdu checks
in_hw_restart at rx.c:1906), and so does the TXQ allocation worker
(iwl_mld_add_txqs_wk at tx.c:156). Add the same guard to
iwl_mld_tx_from_txq() to stop all TX during firmware restart.

Frames left in mac80211's TXQs are naturally drained after restart
completes, when queue reallocation triggers iwl_mld_tx_from_txq()
via iwl_mld_add_txq_list(), or when new upper-layer traffic invokes
wake_tx_queue.

Tested on ASUS Zenbook 14 UX3405CA with Intel BE201 (Wi-Fi 7) on
kernel 6.19.5 where the firmware crashes approximately every 10-15
minutes under Tailscale traffic.

Fixes: d1e879ec600f ("wifi: iwlwifi: add iwlmld sub-driver")
Cc: stable@vger.kernel.org
Signed-off-by: Sheroz Juraev <goodmartiandev@gmail.com>
---
v2: add target tree name to subject, drop cover letter (single patch)
---
 drivers/net/wireless/intel/iwlwifi/mld/tx.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/tx.c b/drivers/net/wireless/intel/iwlwifi/mld/tx.c
index 3b4b575aa..c5eb36652 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/tx.c
@@ -959,6 +959,16 @@ void iwl_mld_tx_from_txq(struct iwl_mld *mld, struct ieee80211_txq *txq)
 	struct sk_buff *skb = NULL;
 	u8 zero_addr[ETH_ALEN] = {};

+	/*
+	 * Don't transmit during firmware restart. The firmware is dead,
+	 * so iwl_trans_tx() would return -EIO for each frame. Avoid the
+	 * overhead of dequeuing from mac80211 only to immediately free
+	 * the skbs, and the potential memory pressure from rapid skb
+	 * allocation churn during high-throughput restart scenarios.
+	 */
+	if (unlikely(mld->fw_status.in_hw_restart))
+		return;
+
 	/*
 	 * No need for threads to be pending here, they can leave the first
 	 * taker all the work.
--
2.47.2


