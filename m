Return-Path: <linux-wireless+bounces-32470-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8Pk9FE4qqGkdpAAAu9opvQ
	(envelope-from <linux-wireless+bounces-32470-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 04 Mar 2026 13:49:18 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D915E1FFD64
	for <lists+linux-wireless@lfdr.de>; Wed, 04 Mar 2026 13:49:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B7E70302C348
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Mar 2026 12:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B7CB1EFFA1;
	Wed,  4 Mar 2026 12:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="T1RNa96X"
X-Original-To: linux-wireless@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D71611F4C96;
	Wed,  4 Mar 2026 12:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772628477; cv=none; b=KM1LkduCt+tWU9xJ8UFvDFqeB1ivksFwhmRrLF1V+2kJZKlAS27G0iztHPFtxFrSWR0I+DQy052pBxw7YjmS/35GTg26rG2sCfuzyLeBEWpDmaV/N8EhryiywAQwlMXxcYy38buvISp4uP8sEv0vhVC6adxvAZnxoTj/m7IGP6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772628477; c=relaxed/simple;
	bh=hof7rouX38nmEzoDefI3x1AgAGZp8Hxze5p0FV+9bmU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hlpm3i0X867WnZQabsFbabIIqDhly/sV4lBL/S5HMwaWJtnNr4UHEjFyD3HyUYomVh1vT8FEL5dGbqCIJwzCUwTLw5Ta5eVc6828hIi84+r2aDdZ9jDvR3YRuQbh6SHNcwljgmgQHu00xJsuASkGwiyOM092LrUq1yVMd5A5rdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=T1RNa96X; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1772628474;
	bh=hof7rouX38nmEzoDefI3x1AgAGZp8Hxze5p0FV+9bmU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=T1RNa96XA6dPBKEZNn0Ri8Wk7cTMaTxMj0jc98kXGNAQPW96lzss7wqFHq+f9bhsh
	 gQcDu47A7ou3GOzljzFmwUMymuoxBTdV4MdgnrM4FBQvd2nc7+XqNL1w3rc/SGS/SD
	 D/WbBDCQldYyq3ECWsUN5kTjoUumUDUu0xfTWJemMKaTds2mz0xsmASworAcHzqy84
	 i4AXsI5AYtImisZOPIF7pZx1ExsuBY2X+7U7BdA4VEwUQnKu9EEGMLTOdcKoLKWZlK
	 76gY0NJVPUbjja1ftPrSDE0hM2q6g8ncK3iVDyDJ/vA8SK6QOP/GI794iP9qwpuWgN
	 W3AG39+C3npjw==
Received: from [192.168.1.53] (unknown [IPv6:2a01:6243:64f:0:a5a5:9171:d9e9:ce23])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: mattl)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 271D717E0EAA;
	Wed,  4 Mar 2026 13:47:54 +0100 (CET)
From: Matthew Leach <matthew.leach@collabora.com>
Date: Wed, 04 Mar 2026 12:47:14 +0000
Subject: [PATCH RFC 2/3] net: ath11k: add firmware lockup detection and
 recovery
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260304-ath11k-lockup-fixes-v1-2-67143c2fe2a1@collabora.com>
References: <20260304-ath11k-lockup-fixes-v1-0-67143c2fe2a1@collabora.com>
In-Reply-To: <20260304-ath11k-lockup-fixes-v1-0-67143c2fe2a1@collabora.com>
To: Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath11k@lists.infradead.org, 
 linux-kernel@vger.kernel.org, kernel@collabora.com, 
 Matthew Leach <matthew.leach@collabora.com>
X-Mailer: b4 0.14.3
X-Rspamd-Queue-Id: D915E1FFD64
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[collabora.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[collabora.com:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32470-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[collabora.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matthew.leach@collabora.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[collabora.com:dkim,collabora.com:email,collabora.com:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

Detect firmware lockup when a WMI command times out and TX descriptor
exhaustion occurs within ATH11K_LOCKUP_DESC_ERR_RANGE_HZ (1 minute). In
this case, consider the firmware dead.

When a lockup is detected, queue reset work to restart the chip.
After reset completes, clear the lockup detection state.

Signed-off-by: Matthew Leach <matthew.leach@collabora.com>
---
 drivers/net/wireless/ath/ath11k/core.h |  2 ++
 drivers/net/wireless/ath/ath11k/mac.c  |  6 ++++++
 drivers/net/wireless/ath/ath11k/wmi.c  | 24 +++++++++++++++++++++++-
 3 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath11k/core.h b/drivers/net/wireless/ath/ath11k/core.h
index a0d725923ef2..221dcd23b3dd 100644
--- a/drivers/net/wireless/ath/ath11k/core.h
+++ b/drivers/net/wireless/ath/ath11k/core.h
@@ -70,6 +70,7 @@ extern bool ath11k_ftm_mode;
 #define ATH11K_RESET_FAIL_TIMEOUT_HZ (20 * HZ)
 #define ATH11K_RECONFIGURE_TIMEOUT_HZ (10 * HZ)
 #define ATH11K_RECOVER_START_TIMEOUT_HZ (20 * HZ)
+#define ATH11K_LOCKUP_DESC_ERR_RANGE_HZ (60 * HZ)
 
 enum ath11k_supported_bw {
 	ATH11K_BW_20	= 0,
@@ -1039,6 +1040,7 @@ struct ath11k_base {
 
 	struct ath11k_dbring_cap *db_caps;
 	u32 num_db_cap;
+	u64 last_frame_tx_error_jiffies;
 
 	/* To synchronize 11d scan vdev id */
 	struct mutex vdev_id_11d_lock;
diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index 748f779b3d1b..a0b4d60da330 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -9,6 +9,7 @@
 #include <linux/etherdevice.h>
 #include <linux/bitfield.h>
 #include <linux/inetdevice.h>
+#include <linux/jiffies.h>
 #include <net/if_inet6.h>
 #include <net/ipv6.h>
 
@@ -6546,6 +6547,10 @@ static void ath11k_mac_op_tx(struct ieee80211_hw *hw,
 
 	ret = ath11k_dp_tx(ar, arvif, arsta, skb);
 	if (unlikely(ret)) {
+		scoped_guard(spinlock_bh, &ar->ab->base_lock) {
+			ar->ab->last_frame_tx_error_jiffies = jiffies_64;
+		}
+
 		ath11k_warn(ar->ab, "failed to transmit frame %d\n", ret);
 		ieee80211_free_txskb(ar->hw, skb);
 	}
@@ -9281,6 +9286,7 @@ ath11k_mac_op_reconfig_complete(struct ieee80211_hw *hw,
 				atomic_dec(&ab->reset_count);
 				complete(&ab->reset_complete);
 				ab->is_reset = false;
+				ab->last_frame_tx_error_jiffies = 0;
 				atomic_set(&ab->fail_cont_count, 0);
 				ath11k_dbg(ab, ATH11K_DBG_BOOT, "reset success\n");
 			}
diff --git a/drivers/net/wireless/ath/ath11k/wmi.c b/drivers/net/wireless/ath/ath11k/wmi.c
index 40747fba3b0c..7d9f0bcbb3b0 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.c
+++ b/drivers/net/wireless/ath/ath11k/wmi.c
@@ -7,8 +7,11 @@
 #include <linux/ctype.h>
 #include <net/mac80211.h>
 #include <net/cfg80211.h>
+#include <linux/cleanup.h>
 #include <linux/completion.h>
 #include <linux/if_ether.h>
+#include <linux/jiffies.h>
+#include <linux/spinlock.h>
 #include <linux/types.h>
 #include <linux/pci.h>
 #include <linux/uuid.h>
@@ -325,9 +328,28 @@ int ath11k_wmi_cmd_send(struct ath11k_pdev_wmi *wmi, struct sk_buff *skb,
 			}), WMI_SEND_TIMEOUT_HZ);
 	}
 
-	if (ret == -EAGAIN)
+	if (ret == -EAGAIN) {
+		u64 range_start;
+
 		ath11k_warn(wmi_ab->ab, "wmi command %d timeout\n", cmd_id);
 
+		guard(spinlock_bh)(&ab->base_lock);
+
+		if (ab->last_frame_tx_error_jiffies == 0)
+			return ret;
+
+		range_start =
+			(jiffies_64 > ATH11K_LOCKUP_DESC_ERR_RANGE_HZ) ?
+				jiffies_64 - ATH11K_LOCKUP_DESC_ERR_RANGE_HZ :
+				0;
+
+		if (time_in_range64(ab->last_frame_tx_error_jiffies,
+				    range_start, jiffies_64) &&
+		    queue_work(ab->workqueue_aux, &ab->reset_work))
+			ath11k_err(wmi_ab->ab,
+				   "Firmware lockup detected.  Resetting.");
+	}
+
 	if (ret == -ENOBUFS)
 		ath11k_warn(wmi_ab->ab, "ce desc not available for wmi command %d\n",
 			    cmd_id);

-- 
2.53.0


