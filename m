Return-Path: <linux-wireless+bounces-35180-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AESNMwS052lV/wEAu9opvQ
	(envelope-from <linux-wireless+bounces-35180-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Apr 2026 19:29:40 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3343543DF7B
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Apr 2026 19:29:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C9BDE302EEF5
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Apr 2026 17:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79E032E719C;
	Tue, 21 Apr 2026 17:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YtyJjmlJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20C072F9984
	for <linux-wireless@vger.kernel.org>; Tue, 21 Apr 2026 17:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776792380; cv=none; b=SVClxPdwT6Oq+lDwXtHsCtFR3JAeu14P1D+ZlwP1jdoJKg+8g1LW5Ne0A1offppiYjGQJY/IHtinTyNDWpoA/Vor4lTaLGoURZJUfYS+W8GsMilgejmrioOtFjv4Pel3Pa/OaEUiNzU3+FRp4ikCg0IfKPaMW+0ep9Wr/DBawL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776792380; c=relaxed/simple;
	bh=army6csuzlkfmCzKW9Q6UiVBt0h02XrDzPZdS88qN00=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fPOw5rsLBhUN93WizHd96OZR61kteuW8iJ9A30UM5Rkk9jVxZ+ir3ErdaRnhah3xNLVwQlaMfr9tMGy1KTAbUfU+vOQQidORCibfo4AVVYX7BiXCLHc0g1KLXWvVAz07MX5tExRsUYhJaWh+59YoKOyOdVJAhCps1fGdJTWkmnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YtyJjmlJ; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2b25cf1b5f0so25134865ad.3
        for <linux-wireless@vger.kernel.org>; Tue, 21 Apr 2026 10:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776792378; x=1777397178; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uu5+POdFqqclIWWOEr3Sv9HNAu+bDuUYEserSDIYQ6I=;
        b=YtyJjmlJxdQ/C/xhJkJ7NDgE9aJF/VGJWXK+/2rXjGlZqOykv1AZ4nh8HrrDO3Cb5h
         AK/cG417KP4s7ImNbdz2jXIRLHduZpZDFb3a9ynS5lD2E0kzsNfOuWZkzsRWxSZHux82
         pyxeEmUqmxPJV9B9ZgovJV+K5eEyAb77PE+oSz7gPkBQVXoy10RWhXA2+dkm4YPb/9yX
         YxIrZngJiPRFQTH+NHhDYqygObGQAOsexwsGgAYR/HjbioMpxn3EGK7Xvo5vzsT7d8ao
         kJloHzvVYCC5wfilrRszYx16dXm+BdcBGmiZZPfaNECXIjo90JEe3mZep7aG5s2QLlLs
         PJ4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776792378; x=1777397178;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Uu5+POdFqqclIWWOEr3Sv9HNAu+bDuUYEserSDIYQ6I=;
        b=sFP1ssA1S5QxgHdDg9MXQxlKH+gmk20vkk+u6ZGm80cdGnQwRS0x9vTrDx0mIv11it
         KlkAW7ESIXCuk/hiKdPij0GuVL2088S3rLIdwrVTYS/yxfSEfgV/Sc9b3U7EN2oX4KH6
         YJZ0FnLovzQETN5oFmWm3LYaPLiq8gBmjQj6t207adIiaoGo64dg0GP971IXrBH9jPph
         oUzhy7BRS4SVrzb9fDeAfTdo8cWOLB35OQb93uGj4rFKpBuVeHJHALw78FxXdTizkXCj
         jIsuJ4NmUvYhesyNDyS6bSxxf8RBKy7WDU5dKLwlFnfbYSmb73VQwek55aLJp901CX3X
         iggQ==
X-Forwarded-Encrypted: i=1; AFNElJ+RfDS/syhJrVOJHn8uWSr9b2LAPiBb3PZlshwqcQkmHVJoWpJA0AcMAWAF2rnXSfapjOVfAHiwac5whWudcA==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywo9wdWniI0C2Hae+/6d0oLGCdsdGReNTJ8AXZScG1ievySvMVd
	TxjYPRnPlm3W9hq5U62Mld5Y+CIwySUtwbn1uPMhL+anEUww6HxDJ62HHexQWvnL
X-Gm-Gg: AeBDieueSfYhEuxw+R+EVC6krBmv0zMKzwTZv1jm1sakdskIyzP7QV1t3S5785LbIFe
	OlbAte8GdjseAz9jTu0wt6HcWIvHZq59bIeZOPMRAJJwUpfagDn5Hs/lHS/5w7lb7Burh2iZqhB
	quNkqXIRGe6LiJvzHrfRNN8lF8NJ2D+5ulJ4dKUoSYNC/RQtOCveC1xkCt3j8f4KbE6PnCt327j
	aBexKoNWbxtMe3+q0zPtipVS89iBqPuDqRkdvyyCnrSO136fiMKyDsAXgdaov1Yt1dZeA1OYrxh
	HWo2sPs2E8P/hGsHiE/PPeMOABBeeZW0Y0QD1NigUrV/xG0i1Du89KwD3RFXX72Td8uRMF2k/9N
	fKCq2IDWRGpaF/bp/hzklBfxgTn6e6vpS30vDptz3nXOMotZjCyBaeYCZEa6iHE0Muj39cHhKi4
	ykm4sFujYmlvUGB2pYdnOlTybWvLdCdzuQTMriytT4xW7Twtk=
X-Received: by 2002:a17:902:db0d:b0:2b2:4fe3:7b89 with SMTP id d9443c01a7336-2b5f9f52879mr182995625ad.38.1776792378433;
        Tue, 21 Apr 2026 10:26:18 -0700 (PDT)
Received: from lenovo.localdomain ([123.110.133.16])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5faa507cbsm144897015ad.37.2026.04.21.10.26.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 10:26:18 -0700 (PDT)
From: Yu-Hsiang Tseng <asas1asas200@gmail.com>
To: Jeff Johnson <jjohnson@kernel.org>,
	ath12k@lists.infradead.org
Cc: Baochen Qiang <baochen.qiang@oss.qualcomm.com>,
	Rameshkumar Sundaram <quic_ramess@quicinc.com>,
	Kalle Valo <kvalo@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Subject: [PATCH v2] wifi: ath12k: fix false positive RCU warnings on PREEMPT_RT
Date: Wed, 22 Apr 2026 01:25:00 +0800
Message-ID: <20260421172500.1050754-1-asas1asas200@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <4cdf2e61-fe69-4168-9df7-55bb71585dfe@oss.qualcomm.com>
References: <4cdf2e61-fe69-4168-9df7-55bb71585dfe@oss.qualcomm.com>
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
	TAGGED_FROM(0.00)[bounces-35180-lists,linux-wireless=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3343543DF7B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Two functions in ath12k assert that the caller holds an RCU read lock:
ath12k_mac_get_arvif() and ath12k_p2p_noa_update_vdev_iter(). Both use:

    WARN_ON(!rcu_read_lock_any_held());

On PREEMPT_RT kernels built with CONFIG_PROVE_RCU=n, this produces a
false positive splat whenever these functions are invoked from paths
that do hold the RCU read lock (e.g. firmware stats processing or
mac80211 interface iteration).

Root cause:

  - On !PROVE_RCU, rcu_read_lock_any_held() is a static inline that
    returns !preemptible() as a proxy for "in an RCU read section".

  - On PREEMPT_RT, rcu_read_lock() does not disable preemption. A
    task can therefore be preemptible while legitimately holding an
    RCU read lock.

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

Replace the WARN_ON() with RCU_LOCKDEP_WARN(), which is gated on
debug_lockdep_rcu_enabled() and therefore compiles out entirely
when PROVE_RCU is disabled. PROVE_RCU kernels continue to get the
full lockdep-based check.

Fixes: 3dd2c68f206e ("wifi: ath12k: prepare vif data structure for MLO handling")
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.1.c5-00302-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.115823.3
Suggested-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Signed-off-by: Yu-Hsiang Tseng <asas1asas200@gmail.com>
---
Changes in v2:
  - Also fix the same WARN_ON() in ath12k_p2p_noa_update_vdev_iter()
    (suggested by Baochen Qiang)
  - Update commit message to cover both call sites

Link to v1: https://lore.kernel.org/ath12k/20260420161049.695518-1-asas1asas200@gmail.com/

 drivers/net/wireless/ath/ath12k/mac.c | 3 ++-
 drivers/net/wireless/ath/ath12k/p2p.c | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index fbdfe6424fd7..a772a5b6adc9 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -788,7 +788,8 @@ struct ath12k_link_vif *ath12k_mac_get_arvif(struct ath12k *ar, u32 vdev_id)
 
 	/* To use the arvif returned, caller must have held rcu read lock.
 	 */
-	WARN_ON(!rcu_read_lock_any_held());
+	RCU_LOCKDEP_WARN(!rcu_read_lock_any_held(),
+			 "RCU read lock not held");
 	arvif_iter.vdev_id = vdev_id;
 	arvif_iter.ar = ar;
 
diff --git a/drivers/net/wireless/ath/ath12k/p2p.c b/drivers/net/wireless/ath/ath12k/p2p.c
index 59589748f1a8..caa92612372b 100644
--- a/drivers/net/wireless/ath/ath12k/p2p.c
+++ b/drivers/net/wireless/ath/ath12k/p2p.c
@@ -123,7 +123,8 @@ static void ath12k_p2p_noa_update_vdev_iter(void *data, u8 *mac,
 	struct ath12k_p2p_noa_arg *arg = data;
 	struct ath12k_link_vif *arvif;
 
-	WARN_ON(!rcu_read_lock_any_held());
+	RCU_LOCKDEP_WARN(!rcu_read_lock_any_held(),
+			 "RCU read lock not held");
 	arvif = &ahvif->deflink;
 	if (!arvif->is_created || arvif->ar != arg->ar || arvif->vdev_id != arg->vdev_id)
 		return;
-- 
2.53.0


