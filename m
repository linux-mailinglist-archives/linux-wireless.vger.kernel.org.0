Return-Path: <linux-wireless+bounces-34179-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sPx3OiZMymmb7QUAu9opvQ
	(envelope-from <linux-wireless+bounces-34179-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Mar 2026 12:10:46 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BA7B358ED0
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Mar 2026 12:10:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D92203023D93
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Mar 2026 10:06:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBABC3B894A;
	Mon, 30 Mar 2026 10:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="OfBinJ8Y"
X-Original-To: linux-wireless@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36ADF3B7B95;
	Mon, 30 Mar 2026 10:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774865167; cv=none; b=aRSD18JdpsZE3CLowmZTja9D30bhIVekrx3n1KESfoI6MrnygFJIjK2HZuMMXo3pSt7TWHSkcdS6mAmtexaPIKC1qtyZI9+QdUpfZWnNTq/R2QEkxzodH9pWYRDTk+fZjPQinvzFT6Q9NLMe+lW745I+zEqZ2as0bKMDzLXDPMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774865167; c=relaxed/simple;
	bh=qTa6bNhVs6NpYSFFFtl049zj5lWrm0xAmHqh8jsaWps=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=o2pCws8nkl+mzB61nRxCSFRDwq77cXH/Cc2SwgEbrb4+SkoVW+GTZtdGght3+3kb2EyFPaIfAH8lmgrucvOESTAH26ACBkJR+OxWkIMIEA0HqBOJI9Mql4X9Hw9jqYl6a6TFhbqLC9JQOFgZKKTs9sB79oncboONYEa/DCIPw7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=OfBinJ8Y; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1774865159;
	bh=qTa6bNhVs6NpYSFFFtl049zj5lWrm0xAmHqh8jsaWps=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=OfBinJ8YDDkQWc9DlTwXWMmem1rFOC0WLOHthBSuk9Re1OSLLQP4M+aZh9nRetKmD
	 umHaIScGeW72pWCHNdEerrUbBPZjxfffVPd6Nkq8TMWBB35g1V9uTSXQgh5nuHkCoP
	 0HBSUIkqE0QyEMQeD11Ng1aB4xfmcjrRJ2pzsiQHwsmnTU1TtR/hmr5+wPIjMV0Bn8
	 uy6nVJ8z8bbfg2kFjeNu1kfXfeIi6RKno6W1Fxe3MGiVFCKpxibcN3uuHeMiG01DQG
	 KoNOpT9fiI4QLOQAlVMGc0ECDhDwSNeH4wni3UP3fsImUaTvGR1DvPdtDoqXGmkId5
	 1C7YLkb23xkXA==
Received: from [192.168.1.53] (unknown [IPv6:2a01:6243:628:0:43ea:f64d:fc7e:3a2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: mattl)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 3F0DD17E41BB;
	Mon, 30 Mar 2026 12:05:59 +0200 (CEST)
From: Matthew Leach <matthew.leach@collabora.com>
Date: Mon, 30 Mar 2026 11:05:33 +0100
Subject: [PATCH RESEND RFC 3/3] net: ath11k: add lockup simulation via
 debugfs
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260330-ath11k-lockup-fixes-v1-3-7ed21095c2c4@collabora.com>
References: <20260330-ath11k-lockup-fixes-v1-0-7ed21095c2c4@collabora.com>
In-Reply-To: <20260330-ath11k-lockup-fixes-v1-0-7ed21095c2c4@collabora.com>
To: Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath11k@lists.infradead.org, 
 linux-kernel@vger.kernel.org, kernel@collabora.com, 
 Matthew Leach <matthew.leach@collabora.com>
X-Mailer: b4 0.15.0
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[collabora.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[collabora.com:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34179-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[collabora.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matthew.leach@collabora.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,collabora.com:dkim,collabora.com:email,collabora.com:mid]
X-Rspamd-Queue-Id: 6BA7B358ED0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add a debugfs command to simulate a firmware lockup.

This does not hang the hardware. Instead, it forces the driver down an
error path that reproduces the sequence observed during real lockups:

  ath11k_pci 0000:03:00.0: failed to transmit frame -12
  ath11k_pci 0000:03:00.0: failed to transmit frame -12
  ath11k_pci 0000:03:00.0: failed to transmit frame -12
  ...
  ath11k_pci 0000:03:00.0: wmi command 28680 timeout
  ath11k_pci 0000:03:00.0: failed to submit WMI_MGMT_TX_SEND_CMDID cmd
  ath11k_pci 0000:03:00.0: failed to send mgmt frame: -11

This allows validation of the firmware lockup detection and recovery
mechanism without requiring a real hardware failure.

Signed-off-by: Matthew Leach <matthew.leach@collabora.com>
---
 drivers/net/wireless/ath/ath11k/core.h    | 1 +
 drivers/net/wireless/ath/ath11k/debugfs.c | 7 ++++++-
 drivers/net/wireless/ath/ath11k/hal.c     | 7 +++++--
 drivers/net/wireless/ath/ath11k/htc.c     | 2 +-
 drivers/net/wireless/ath/ath11k/wmi.c     | 6 +++++-
 5 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/core.h b/drivers/net/wireless/ath/ath11k/core.h
index 221dcd23b3dd..44b02ae1e85b 100644
--- a/drivers/net/wireless/ath/ath11k/core.h
+++ b/drivers/net/wireless/ath/ath11k/core.h
@@ -1041,6 +1041,7 @@ struct ath11k_base {
 	struct ath11k_dbring_cap *db_caps;
 	u32 num_db_cap;
 	u64 last_frame_tx_error_jiffies;
+	bool simulate_lockup;
 
 	/* To synchronize 11d scan vdev id */
 	struct mutex vdev_id_11d_lock;
diff --git a/drivers/net/wireless/ath/ath11k/debugfs.c b/drivers/net/wireless/ath/ath11k/debugfs.c
index 0c1138407838..ca0b72a3e0b0 100644
--- a/drivers/net/wireless/ath/ath11k/debugfs.c
+++ b/drivers/net/wireless/ath/ath11k/debugfs.c
@@ -356,7 +356,8 @@ static ssize_t ath11k_read_simulate_fw_crash(struct file *file,
 	const char buf[] =
 		"To simulate firmware crash write one of the keywords to this file:\n"
 		"`assert` - this will send WMI_FORCE_FW_HANG_CMDID to firmware to cause assert.\n"
-		"`hw-restart` - this will simply queue hw restart without fw/hw actually crashing.\n";
+		"`hw-restart` - this will simply queue hw restart without fw/hw actually crashing.\n"
+		"`lockup` - simulate a firmware lockup without the h/w actually hanging.\n";
 
 	return simple_read_from_buffer(user_buf, count, ppos, buf, strlen(buf));
 }
@@ -413,6 +414,10 @@ static ssize_t ath11k_write_simulate_fw_crash(struct file *file,
 		ath11k_info(ab, "user requested hw restart\n");
 		queue_work(ab->workqueue_aux, &ab->reset_work);
 		ret = 0;
+	} else if (!strcmp(buf, "lockup")) {
+		ath11k_info(ab, "simulating lockup\n");
+		ab->simulate_lockup = true;
+		ret = 0;
 	} else {
 		ret = -EINVAL;
 		goto exit;
diff --git a/drivers/net/wireless/ath/ath11k/hal.c b/drivers/net/wireless/ath/ath11k/hal.c
index e821e5a62c1c..e01fb17a4734 100644
--- a/drivers/net/wireless/ath/ath11k/hal.c
+++ b/drivers/net/wireless/ath/ath11k/hal.c
@@ -691,7 +691,7 @@ int ath11k_hal_srng_dst_num_free(struct ath11k_base *ab, struct hal_srng *srng,
 
 	tp = srng->u.dst_ring.tp;
 
-	if (sync_hw_ptr) {
+	if (sync_hw_ptr && !ab->simulate_lockup) {
 		hp = *srng->u.dst_ring.hp_addr;
 		srng->u.dst_ring.cached_hp = hp;
 	} else {
@@ -743,7 +743,7 @@ u32 *ath11k_hal_srng_src_get_next_entry(struct ath11k_base *ab,
 	 */
 	next_hp = (srng->u.src_ring.hp + srng->entry_size) % srng->ring_size;
 
-	if (next_hp == srng->u.src_ring.cached_tp)
+	if (next_hp == srng->u.src_ring.cached_tp || ab->simulate_lockup)
 		return NULL;
 
 	desc = srng->ring_base_vaddr + srng->u.src_ring.hp;
@@ -828,6 +828,9 @@ void ath11k_hal_srng_access_begin(struct ath11k_base *ab, struct hal_srng *srng)
 
 	lockdep_assert_held(&srng->lock);
 
+	if (ab->simulate_lockup)
+		return;
+
 	if (srng->ring_dir == HAL_SRNG_DIR_SRC) {
 		srng->u.src_ring.cached_tp =
 			*(volatile u32 *)srng->u.src_ring.tp_addr;
diff --git a/drivers/net/wireless/ath/ath11k/htc.c b/drivers/net/wireless/ath/ath11k/htc.c
index 4571d01cc33d..b05d04a1f5e8 100644
--- a/drivers/net/wireless/ath/ath11k/htc.c
+++ b/drivers/net/wireless/ath/ath11k/htc.c
@@ -208,7 +208,7 @@ static int ath11k_htc_process_trailer(struct ath11k_htc *htc,
 			break;
 		}
 
-		if (ab->hw_params.credit_flow) {
+		if (ab->hw_params.credit_flow && !ab->simulate_lockup) {
 			switch (record->hdr.id) {
 			case ATH11K_HTC_RECORD_CREDITS:
 				len = sizeof(struct ath11k_htc_credit_report);
diff --git a/drivers/net/wireless/ath/ath11k/wmi.c b/drivers/net/wireless/ath/ath11k/wmi.c
index 7d9f0bcbb3b0..27d6d4a2f803 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.c
+++ b/drivers/net/wireless/ath/ath11k/wmi.c
@@ -345,9 +345,13 @@ int ath11k_wmi_cmd_send(struct ath11k_pdev_wmi *wmi, struct sk_buff *skb,
 
 		if (time_in_range64(ab->last_frame_tx_error_jiffies,
 				    range_start, jiffies_64) &&
-		    queue_work(ab->workqueue_aux, &ab->reset_work))
+		    queue_work(ab->workqueue_aux, &ab->reset_work)) {
 			ath11k_err(wmi_ab->ab,
 				   "Firmware lockup detected.  Resetting.");
+
+			/* Assume that reset gets us out of lockup. */
+			ab->simulate_lockup = false;
+		}
 	}
 
 	if (ret == -ENOBUFS)

-- 
2.53.0


