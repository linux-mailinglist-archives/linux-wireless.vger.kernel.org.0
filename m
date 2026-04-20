Return-Path: <linux-wireless+bounces-35088-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KD7eOJZZ5mnGvAEAu9opvQ
	(envelope-from <linux-wireless+bounces-35088-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 18:51:34 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A8DEA4301E2
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 18:51:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D16BA32DCBD5
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 16:11:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 944EC344057;
	Mon, 20 Apr 2026 16:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UUIZBJ/8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50F7C3431F8
	for <linux-wireless@vger.kernel.org>; Mon, 20 Apr 2026 16:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776701460; cv=none; b=Boq//L/fvTcCn1joZI3AWT4Jdr0gla4V2NnSSaIUVs3WjLBeHv66oN7JBmGEyCnrTBiPs765wVTedL7NT1kRjzjkDVbTS46lBCQgSx9RiL4uOJYnaMJsmN8AMP9opgXRMf4p0+CMALTWJ3ZWp/0aoWBEReYdmjWmtYNbFDcagxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776701460; c=relaxed/simple;
	bh=MOJKKXRCJBvIZ1NSF5DMTj9lzqj4jacPCsNx3GboOOo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BbXvJ/FecIXyTtj+eJPgpywjMJtJJB2NdEafVzzFLJiuJ0Iq+5v7+j4oXUv+T4l+lJ9T09V0lEDQPM30bCc0QlMdL6AukYSldtei/j1furgPdACT6sUoviZDOUgq/cNg1uVsB+H9T2675pciup2NALhhJRlLyY6WL2KMCc0Lgnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UUIZBJ/8; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-c6dd5b01e14so1092348a12.0
        for <linux-wireless@vger.kernel.org>; Mon, 20 Apr 2026 09:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776701459; x=1777306259; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Sxo5kEtdYHH/dmttcUyKVQWx6oJy7kEINBaa4a+z/+s=;
        b=UUIZBJ/8MkE+8ai05mxNABZpac0RIPMRl9pk0bz0UFT36xSRPhHXfpbmTCyffMj3RX
         UfmXi7kBhWyTZat47mH1XdSVqcgbjCJT6qGslhovx9iRG4aW7RGLLFkpDmaWmkzcquRW
         SIjKrDvdWflmJFys7iWIiC7RL4YT4O4u0Rdwr4k+azut7HPFt6wytI4H05E8YeR0jS0A
         AvYIzzt+aw2MlrLDGZOyS2tVEthW78O9MXXUqqVVsI6VsLdE8z8sOnRHGIu9pEUmAkkl
         Np1P4ERW53KM05nOm6FDuy05kQ4sNnQ5LZ2OsMZXWesb8K2otThKQHs+STkhSip4e9XB
         DsBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776701459; x=1777306259;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sxo5kEtdYHH/dmttcUyKVQWx6oJy7kEINBaa4a+z/+s=;
        b=lgJwG5PJ/fYdHInSXpiVAd9dGIP1O/zhX2QfAdAfe5rFzTG4KHOiXEAX3R6ABq1QyY
         0Zl0fgq9W7mye0saYa/i2Vm2DcmRmSULbYFh3NESkpJg9bDNPr2JIT08GvkQ4qgm8dfD
         iycZ48WIZLMLKx2++HiJY1xaXF1uGyecIu5QnXJKJwn0Ql9uTF1Sbwt0o5Iylfy30Sq7
         uCWC9gfGqwgSbM0d0ADgHFJh1jGfTLte0b6YEn1nmJLMpu+DR3JKTO1BflqW6UX/GFkR
         2lff5VWzhzGRBpDJCgbYl96XK3zDquRFHz6mwA9eBe6Vx1AC+WyIq5aNxEheQKotjQbp
         yRuA==
X-Forwarded-Encrypted: i=1; AFNElJ8vEhlfwXtw8qIpKYfnGVQF8FveiLelH09EeN3ZSl9M8dAvb4BH9+fsaVa/YgI7MdMaL96YMKq2ltgN8/Z+4A==@vger.kernel.org
X-Gm-Message-State: AOJu0YwwcGdYqrcvPq88P+pZVpXmdYgWjhdRbp2+todQ4uI0SpVAa2Fd
	chDUrYqpyOYpt4JmWEuM26xz3DJGEK2omArFuBT1xdkUqbB9H4bG/9AWLY2TOVe5
X-Gm-Gg: AeBDietddDYGQr9Vm52hoIdPLhZUNC+GlxZj7ybwaYtKrjt/fVSjXW+l0mK23ptWvfM
	WrCFFmcBVfONvqdyjQZwVQQXk7uGrvFRawXi4PAntspZ6aKVXVBhQbvYSsvDeqrw1OAovHVPmIX
	N3QfLx0Ka5XD2SvaHCOnz6NKddRIzCo7WGnsP+HrLdWrOkp+xJmfRErRB18XxNFWxLhvGqyo4nF
	aWxg67/WYzLOUl0AVP7g/saKtmWp8O+P0TD9DiMZmvcgCmo7GwDtdk/NSs7xHYuuqVJS3BV4Vaa
	ZlCYOUcl2FqUExhxSY8Nf1nX7jySVBIwJqkWF7a2iO9xzjjrOJvqrzEa/JH/f/4Qgp/Y5Ted2M2
	wXVZ9cuZpps9/Lj7C0b2SLRXJRBOs5UNCr4AbvsnUao9RpLIatKf0hLIf4DDyvy54dipaSNq/0R
	cRNAXgXm2HiRVLE6Km4mM0RsRRPFpVBkbSrMQxx1s0ByNLcHlnjTpBOlZXNQ==
X-Received: by 2002:a05:6a20:7285:b0:39f:27ab:2454 with SMTP id adf61e73a8af0-3a08d90d557mr15520783637.49.1776701458590;
        Mon, 20 Apr 2026 09:10:58 -0700 (PDT)
Received: from lenovo.localdomain ([123.110.133.16])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c797701b1a3sm8243470a12.19.2026.04.20.09.10.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 09:10:58 -0700 (PDT)
From: Yu-Hsiang Tseng <asas1asas200@gmail.com>
To: Jeff Johnson <jjohnson@kernel.org>,
	ath12k@lists.infradead.org
Cc: Sriram R <quic_srirrama@quicinc.com>,
	Rameshkumar Sundaram <quic_ramess@quicinc.com>,
	Kalle Valo <kvalo@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Subject: [PATCH] wifi: ath12k: fix false positive RCU warning on PREEMPT_RT
Date: Tue, 21 Apr 2026 00:10:49 +0800
Message-ID: <20260420161049.695518-1-asas1asas200@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35088-lists,linux-wireless=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A8DEA4301E2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

ath12k_mac_get_arvif() asserts that the caller holds an RCU read lock:

    WARN_ON(!rcu_read_lock_any_held());

On PREEMPT_RT kernels built with CONFIG_PROVE_RCU=n, this produces a
false positive splat whenever firmware stats events are processed,
even though the caller does hold the RCU read lock.

Root cause:

  - On !PROVE_RCU, rcu_read_lock_any_held() is a static inline that
    returns !preemptible() as a proxy for "in an RCU read section".

  - On PREEMPT_RT, rcu_read_lock() does not disable preemption. A
    task can therefore be preemptible while legitimately holding an
    RCU read lock.

  - ath12k_wmi_tlv_rssi_chain_parse() holds the RCU read lock via
    guard(rcu)() before calling ath12k_mac_get_arvif(), so the
    warning is incorrect.

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
Signed-off-by: Yu-Hsiang Tseng <asas1asas200@gmail.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

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
 
-- 
2.53.0


