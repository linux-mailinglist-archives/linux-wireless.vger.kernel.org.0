Return-Path: <linux-wireless+bounces-35224-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gMHIHScQ6WmiTwIAu9opvQ
	(envelope-from <linux-wireless+bounces-35224-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Apr 2026 20:15:03 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 62DD8449A01
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Apr 2026 20:15:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4BB0730F4D59
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Apr 2026 18:08:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CD9E3CAE71;
	Wed, 22 Apr 2026 18:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nu813LOc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0BDE3B2FD8
	for <linux-wireless@vger.kernel.org>; Wed, 22 Apr 2026 18:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776881311; cv=none; b=ja7J14XO0xfNmmxhsZCvdeL6MrjU2pWENipUdBjYRny1p6bEFOfAc44Ki0iF+I6AaNorvDU4dkwypdDHIJxr2OTpHjsMkBXasLyn5SUdbStxaK29OHdCuKMQ+GzH6ESiZzl8Bv50BRvfQ0FjOo90eg42fgALXPFewfUlwN2/7KU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776881311; c=relaxed/simple;
	bh=xR4VS+ANUEtgHiWt6wIQMm1UNiZmGqAkBG+YFkQwadw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OdNYltxPBT4HtwAqtxNdWkJ5dByk40avZLVkbiSWVtfrn80YYqq+XxWQCx7MWbSlFlr2mEBf2EbcMnPx7OuLHsvQwLr48zcbgLta8TpDjnIwb5ZWR/mQn2P4LiA6IyuSrRC5ncxtcRQ9CMyhA5jY7lMKA5QorRcFNEz6Izk7r3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nu813LOc; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-362bb3260f1so1636055a91.2
        for <linux-wireless@vger.kernel.org>; Wed, 22 Apr 2026 11:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776881308; x=1777486108; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dXm+cvPf8Xjp+Os3ArHn258/YE9KQwcLs3zxc5vFNZA=;
        b=Nu813LOcq1cmlfyUoC4f2ShjMT6BCw7VjRhoWIiy/5xkOWis6ezl96IXXsZX1LmtiK
         FSfi01BqP8w7VboNuwvplhvNUO1rgYuCGB/1ztiETrtTRRzbypYlyXy7aPliqXL0Zw/E
         YVhuUfpT6DZeVsywsVTYpv+1FWL2UKXtGYQXeAWf2VjKXcCqSeRXLxdCy2YiCL2RFeHe
         b46h7Bz0lz4Bz0uA2WEUnV5cuD1Di81mLSBrZ8B0L2a2p7TD1Ij0G17oLjEiiZRJticW
         7zhmu0GnfOSUSIOhfUCTUop2B83zUSB1rFEMQqmUBzwPN7z73lBzXuHXbHZ/QqZhUm7i
         jdwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776881308; x=1777486108;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dXm+cvPf8Xjp+Os3ArHn258/YE9KQwcLs3zxc5vFNZA=;
        b=h/r7O1JSbmjb7RxI9eEDF9JVsnJVxVq8+h4uirR7Ltlt7Ix/JfqtsSI1jfrly1vi9j
         j3DueWn1Sq4R8siSnmaCbcHoZbVRn8VtJL0yweIDEpun9coO5lmxRCF2Mf2Z90X5z3U/
         PN1P3wtr6L6mFO+9MZWIhGANXuDNMoIumz8oA7p+0ie4WdDnJhUQtjBUSE3Be+3X6YyR
         PPug+XjRBiJ9qMfyKg2ShTfsC1KQhRKDI5LW2jVfdsF83kZGrAx5M0/SqYDi4IAyglpv
         +6wpG3bqqmskD8ZGkSJ3G4SGFi6YfuLG1ezF2rPfsOsMNTHtFI8f7IkNiHXKtfLVPPKq
         TrLw==
X-Forwarded-Encrypted: i=1; AFNElJ/2IZ3Qf9pguIcfCvFrC6aHRvAXB6ZR/ARH+gsaY6B2jsPW8hnFgM5+kPnNq6H+uTbo9hTT4reaah+pXZegvA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxCZOTQkdYfuhjS3RbwWWa4QNeOqGOgmT6qgCliRZLgrFd41yTg
	765TYG/gNfaEKD9zT3/H6dF65kOQUDMRfpxhGjTnvwYxYuLyBSjDYWmO
X-Gm-Gg: AeBDieved3O85Nf2N331a4mmFPIKKXV69nPUHcLSuSUrfQtjo5V+/j+O3OL/1D2GrW3
	Fp1zH8bBR210IB91e/AfjcL8hpy/7gGTOaljzVxAGhFk+jA2wseLPY6iWreLOG0foxuaMJI/nRn
	0kQRJYmn8x014L5uoY3lWK4iXrMszMIbOiM+ULEtsnzkKF1TYm7w8+7G8AkyLba+SyDhKbNLIik
	/Bj2EKV3l/f/l9A8G2f3uuTEstHpXE8h6pp1Zum0BtWMrytsF58155IKUZzPp8td8SC+e9gNgxi
	5D9T2TVH9V1QtamrKTyVWesvlHBLDkYgVdRwslGjxe+5Xw300XM3NlkoETaKIlPti+OctKUKhYc
	g+ZNDS5dqzt1DRtDq3hR9DP2ZBKraXHdb8Lyv1YNH+0BFNVUahBBPfeAcoU1Dl3UgdjjrBcTA0m
	rcURRw5aVX8hCt4zzg5GWftJqg2DLyxkQi+ARvp44CQyq3+paq0tFS3qn5E3TAFvCmMydTxPYS1
	e1HFg==
X-Received: by 2002:a17:90a:e704:b0:35f:b1ad:fdfc with SMTP id 98e67ed59e1d1-361404b0aaemr22056621a91.27.1776881308057;
        Wed, 22 Apr 2026 11:08:28 -0700 (PDT)
Received: from lenovo.localdomain (211-23-53-87.hinet-ip.hinet.net. [211.23.53.87])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5fab3a929sm166137985ad.72.2026.04.22.11.08.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 11:08:27 -0700 (PDT)
From: Yu-Hsiang Tseng <asas1asas200@gmail.com>
To: Jeff Johnson <jjohnson@kernel.org>,
	ath12k@lists.infradead.org
Cc: Baochen Qiang <baochen.qiang@oss.qualcomm.com>,
	Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>,
	Kalle Valo <kvalo@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Subject: [PATCH v3] wifi: ath12k: use lockdep_assert_in_rcu_read_lock() for RCU assertions
Date: Thu, 23 Apr 2026 02:08:14 +0800
Message-ID: <20260422180814.1938317-1-asas1asas200@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35224-lists,linux-wireless=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[asas1asas200@gmail.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linutronix.de:email]
X-Rspamd-Queue-Id: 62DD8449A01
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Two functions in ath12k assert that the caller holds an RCU read lock:
ath12k_mac_get_arvif() and ath12k_p2p_noa_update_vdev_iter(). Both use:

    WARN_ON(!rcu_read_lock_any_held());

On kernels using preemptible RCU (CONFIG_PREEMPT=y or CONFIG_PREEMPT_RT=y)
without CONFIG_DEBUG_LOCK_ALLOC, this produces a false positive splat
whenever these functions are invoked from paths that do hold the RCU
read lock (e.g. firmware stats processing or mac80211 interface
iteration).

Root cause:

  - Without CONFIG_DEBUG_LOCK_ALLOC, rcu_read_lock_any_held() is a
    static inline that returns !preemptible() as a proxy for "in an
    RCU read section".

  - With preemptible RCU, rcu_read_lock() does not disable preemption.
    A task can therefore be preemptible while legitimately holding an
    RCU read lock, making the proxy unreliable.

  - Callers such as ath12k_wmi_tlv_rssi_chain_parse() (via guard(rcu)())
    and ieee80211_iterate_active_interfaces_atomic() do hold the RCU
    read lock, so these warnings are incorrect.

Typical splat seen on a WCN7850 station with periodic fw stats
processing:

  WARNING: drivers/net/wireless/ath/ath12k/mac.c:791 at
    ath12k_mac_get_arvif+0x9e/0xd0 [ath12k]
  Tainted: G W O 6.19.13-rt #1 PREEMPT_RT
  Call Trace:
   ath12k_wmi_tlv_rssi_chain_parse+0x69/0x170 [ath12k]
   ath12k_wmi_tlv_iter+0x7f/0x120 [ath12k]
   ath12k_wmi_tlv_fw_stats_parse+0x342/0x6b0 [ath12k]
   ath12k_wmi_op_rx+0xe9e/0x3150 [ath12k]
   ath12k_htc_rx_completion_handler+0x3df/0x5b0 [ath12k]
   ath12k_ce_per_engine_service+0x325/0x3e0 [ath12k]
   ath12k_pci_ce_workqueue+0x20/0x40 [ath12k]

Replace WARN_ON(!rcu_read_lock_any_held()) with
lockdep_assert_in_rcu_read_lock(), which is gated on CONFIG_PROVE_RCU
and therefore compiles out entirely when PROVE_RCU is disabled.
PROVE_RCU kernels continue to get the full lockdep-based check, and
the new helper precisely checks for rcu_read_lock() rather than any
RCU variant, which better matches the callers' expectations.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.1.c5-00302-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.115823.3

Fixes: 3dd2c68f206e ("wifi: ath12k: prepare vif data structure for MLO handling")
Suggested-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Suggested-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Reviewed-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Reviewed-by: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
Signed-off-by: Yu-Hsiang Tseng <asas1asas200@gmail.com>
---
Changes in v3:
  - Use lockdep_assert_in_rcu_read_lock() instead of RCU_LOCKDEP_WARN()
    for clearer intent and more precise semantics (suggested by
    Sebastian Andrzej Siewior)
  - Reword commit message: this affects preemptible RCU in general,
    not only PREEMPT_RT
  - Move Tested-on before the official tags per ath convention

Changes in v2:
  - Also fix the same WARN_ON() in ath12k_p2p_noa_update_vdev_iter()
    (suggested by Baochen Qiang)
  - Update commit message to cover both call sites

Link to v1: https://lore.kernel.org/ath12k/20260420161049.695518-1-asas1asas200@gmail.com/
Link to v2: https://lore.kernel.org/ath12k/20260421172500.1050754-1-asas1asas200@gmail.com/

 drivers/net/wireless/ath/ath12k/mac.c | 2 +-
 drivers/net/wireless/ath/ath12k/p2p.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index fbdfe6424fd7..df2334f3bad6 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -788,7 +788,7 @@ struct ath12k_link_vif *ath12k_mac_get_arvif(struct ath12k *ar, u32 vdev_id)
 
 	/* To use the arvif returned, caller must have held rcu read lock.
 	 */
-	WARN_ON(!rcu_read_lock_any_held());
+	lockdep_assert_in_rcu_read_lock();
 	arvif_iter.vdev_id = vdev_id;
 	arvif_iter.ar = ar;
 
diff --git a/drivers/net/wireless/ath/ath12k/p2p.c b/drivers/net/wireless/ath/ath12k/p2p.c
index 59589748f1a8..19ebcd1d8eb2 100644
--- a/drivers/net/wireless/ath/ath12k/p2p.c
+++ b/drivers/net/wireless/ath/ath12k/p2p.c
@@ -123,7 +123,7 @@ static void ath12k_p2p_noa_update_vdev_iter(void *data, u8 *mac,
 	struct ath12k_p2p_noa_arg *arg = data;
 	struct ath12k_link_vif *arvif;
 
-	WARN_ON(!rcu_read_lock_any_held());
+	lockdep_assert_in_rcu_read_lock();
 	arvif = &ahvif->deflink;
 	if (!arvif->is_created || arvif->ar != arg->ar || arvif->vdev_id != arg->vdev_id)
 		return;
-- 
2.53.0


