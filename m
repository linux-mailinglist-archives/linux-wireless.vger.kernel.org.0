Return-Path: <linux-wireless+bounces-31488-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8CETIQFogWl5GAMAu9opvQ
	(envelope-from <linux-wireless+bounces-31488-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 03 Feb 2026 04:14:09 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C7ADAD405A
	for <lists+linux-wireless@lfdr.de>; Tue, 03 Feb 2026 04:14:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B4B5830495C1
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Feb 2026 03:14:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E218B2F290A;
	Tue,  3 Feb 2026 03:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=139.com header.i=@139.com header.b="bF9xXUCB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from n169-113.mail.139.com (n169-113.mail.139.com [120.232.169.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FFAD1FE47C;
	Tue,  3 Feb 2026 03:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=120.232.169.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770088442; cv=none; b=m8N8OdVA/AJiyALspyhJiuDGeFIOC9zyYtlPJexGJrvl2QJ9xI+66js0WG6yrfQyQRnjWDYBZSEf9HsceGObVkOs2zChWeLIUz/yAHBXfRQ8paN/hz5Ch8FO81nXORl0iuZoQ6gfdYrjM/yFasdSvWtkxiCBbJUvaOXFEA/x2b4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770088442; c=relaxed/simple;
	bh=5UkKq/PQcRPKT071SnACLvK1PSuY7S1FbMoyniqH04A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ijj0ANGCQsnta0AZYgJ6Puu5L4MraRFtmRFktwngtThU2qTA/2i+fk4cSzzQOvXOKeuu8Lux8b0C4p7wshXkm3iRDPRkKwoWs9VTjrxXoOsoxAGeNNym9JV3jQmnhVJQvaMK+zOcDCjyYmL4AdD92ACUjK3NL9051i7YsNF4kfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=139.com; spf=pass smtp.mailfrom=139.com; dkim=pass (1024-bit key) header.d=139.com header.i=@139.com header.b=bF9xXUCB; arc=none smtp.client-ip=120.232.169.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=139.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=139.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=139.com; s=dkim; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=bF9xXUCBYr14DTlSP3qW82ZV2LS9j203TZXrBWdDQM9Sz7QJtxdViRC+IoO5haIusaksYLTJ9K1vZ
	 005CSKOB9xMlgQuB81xBm2SBdNYPzoBG7oasP69F4CBIiQmpw6BzqJxqf9DejVX83et0dAlFEBy4DN
	 n9lGAcm2h24BhV4E=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM:                                                                                        
X-RM-SPAM-FLAG:00000000
Received:from NTT-kernel-dev (unknown[60.247.85.88])
	by rmsmtp-lg-appmail-32-12046 (RichMail) with SMTP id 2f0e698167da3b3-0440b;
	Tue, 03 Feb 2026 11:13:34 +0800 (CST)
X-RM-TRANSID:2f0e698167da3b3-0440b
From: Li hongliang <1468888505@139.com>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org,
	quic_kangyang@quicinc.com
Cc: patches@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	kvalo@kernel.org,
	jjohnson@kernel.org,
	quic_vthiagar@quicinc.com,
	quic_vnaralas@quicinc.com,
	quic_msinada@quicinc.com,
	gseset@codeaurora.org,
	linux-wireless@vger.kernel.org,
	ath11k@lists.infradead.org,
	quic_jjohnson@quicinc.com,
	jeff.johnson@oss.qualcomm.com
Subject: [PATCH 6.6.y] wifi: ath11k: add srng->lock for ath11k_hal_srng_* in monitor mode
Date: Tue,  3 Feb 2026 11:13:45 +0800
Message-Id: <20260203031345.1357063-1-1468888505@139.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_REJECT(1.00)[139.com:s=dkim];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-31488-lists,linux-wireless=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[139.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[139.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[1468888505@139.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[139.com:-];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:email,msgid.link:url]
X-Rspamd-Queue-Id: C7ADAD405A
X-Rspamd-Action: no action

From: Kang Yang <quic_kangyang@quicinc.com>

[ Upstream commit 63b7af49496d0e32f7a748b6af3361ec138b1bd3 ]

ath11k_hal_srng_* should be used with srng->lock to protect srng data.

For ath11k_dp_rx_mon_dest_process() and ath11k_dp_full_mon_process_rx(),
they use ath11k_hal_srng_* for many times but never call srng->lock.

So when running (full) monitor mode, warning will occur:
RIP: 0010:ath11k_hal_srng_dst_peek+0x18/0x30 [ath11k]
Call Trace:
 ? ath11k_hal_srng_dst_peek+0x18/0x30 [ath11k]
 ath11k_dp_rx_process_mon_status+0xc45/0x1190 [ath11k]
 ? idr_alloc_u32+0x97/0xd0
 ath11k_dp_rx_process_mon_rings+0x32a/0x550 [ath11k]
 ath11k_dp_service_srng+0x289/0x5a0 [ath11k]
 ath11k_pcic_ext_grp_napi_poll+0x30/0xd0 [ath11k]
 __napi_poll+0x30/0x1f0
 net_rx_action+0x198/0x320
 __do_softirq+0xdd/0x319

So add srng->lock for them to avoid such warnings.

Inorder to fetch the srng->lock, should change srng's definition from
'void' to 'struct hal_srng'. And initialize them elsewhere to prevent
one line of code from being too long. This is consistent with other ring
process functions, such as ath11k_dp_process_rx().

Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.30
Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.7.0.1-01744-QCAHKSWPL_SILICONZ-1

Fixes: d5c65159f289 ("ath11k: driver for Qualcomm IEEE 802.11ax devices")
Signed-off-by: Kang Yang <quic_kangyang@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
Link: https://patch.msgid.link/20241219110531.2096-3-quic_kangyang@quicinc.com
Signed-off-by: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Signed-off-by: Li hongliang <1468888505@139.com>
---
 drivers/net/wireless/ath/ath11k/dp_rx.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/dp_rx.c b/drivers/net/wireless/ath/ath11k/dp_rx.c
index dc54ea16c12a..ed1ea61c8142 100644
--- a/drivers/net/wireless/ath/ath11k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath11k/dp_rx.c
@@ -5093,7 +5093,7 @@ static void ath11k_dp_rx_mon_dest_process(struct ath11k *ar, int mac_id,
 	struct ath11k_mon_data *pmon = (struct ath11k_mon_data *)&dp->mon_data;
 	const struct ath11k_hw_hal_params *hal_params;
 	void *ring_entry;
-	void *mon_dst_srng;
+	struct hal_srng *mon_dst_srng;
 	u32 ppdu_id;
 	u32 rx_bufs_used;
 	u32 ring_id;
@@ -5117,6 +5117,7 @@ static void ath11k_dp_rx_mon_dest_process(struct ath11k *ar, int mac_id,
 
 	spin_lock_bh(&pmon->mon_lock);
 
+	spin_lock_bh(&mon_dst_srng->lock);
 	ath11k_hal_srng_access_begin(ar->ab, mon_dst_srng);
 
 	ppdu_id = pmon->mon_ppdu_info.ppdu_id;
@@ -5175,6 +5176,7 @@ static void ath11k_dp_rx_mon_dest_process(struct ath11k *ar, int mac_id,
 								mon_dst_srng);
 	}
 	ath11k_hal_srng_access_end(ar->ab, mon_dst_srng);
+	spin_unlock_bh(&mon_dst_srng->lock);
 
 	spin_unlock_bh(&pmon->mon_lock);
 
@@ -5564,7 +5566,7 @@ static int ath11k_dp_full_mon_process_rx(struct ath11k_base *ab, int mac_id,
 	struct hal_sw_mon_ring_entries *sw_mon_entries;
 	struct ath11k_pdev_mon_stats *rx_mon_stats;
 	struct sk_buff *head_msdu, *tail_msdu;
-	void *mon_dst_srng = &ar->ab->hal.srng_list[dp->rxdma_mon_dst_ring.ring_id];
+	struct hal_srng *mon_dst_srng;
 	void *ring_entry;
 	u32 rx_bufs_used = 0, mpdu_rx_bufs_used;
 	int quota = 0, ret;
@@ -5580,6 +5582,9 @@ static int ath11k_dp_full_mon_process_rx(struct ath11k_base *ab, int mac_id,
 		goto reap_status_ring;
 	}
 
+	mon_dst_srng = &ar->ab->hal.srng_list[dp->rxdma_mon_dst_ring.ring_id];
+	spin_lock_bh(&mon_dst_srng->lock);
+
 	ath11k_hal_srng_access_begin(ar->ab, mon_dst_srng);
 	while ((ring_entry = ath11k_hal_srng_dst_peek(ar->ab, mon_dst_srng))) {
 		head_msdu = NULL;
@@ -5623,6 +5628,7 @@ static int ath11k_dp_full_mon_process_rx(struct ath11k_base *ab, int mac_id,
 	}
 
 	ath11k_hal_srng_access_end(ar->ab, mon_dst_srng);
+	spin_unlock_bh(&mon_dst_srng->lock);
 	spin_unlock_bh(&pmon->mon_lock);
 
 	if (rx_bufs_used) {
-- 
2.34.1



