Return-Path: <linux-wireless+bounces-34409-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iPI9AZdw1GkruAcAu9opvQ
	(envelope-from <linux-wireless+bounces-34409-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Apr 2026 04:48:55 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 71B9C3A93E5
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Apr 2026 04:48:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DA37E3009CF3
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Apr 2026 02:48:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 554CA17A31E;
	Tue,  7 Apr 2026 02:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QmhmO4DM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED80E1474CC
	for <linux-wireless@vger.kernel.org>; Tue,  7 Apr 2026 02:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775530132; cv=none; b=gxLgxOuJN0yFkEJkK8R6gujlm/ThGdroDSuOSFDuwZuUH2p5fEY8SkkYSN4XH/5N0NKvSrqmlftS190JjVQWcIIwnnBqlLvTBnQMhRPUzhBgV+xfdTcKuwkCrclJoG97Eux5Rb4geAcoJsYr91LyPdQhS645ykLBwSM0mc+sq5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775530132; c=relaxed/simple;
	bh=nlGRjZ8B9NSuKCgnxx4DoaH/1P25GDmTeQ7lLhNh+ss=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aeRapeLJJ8x1rqFWavAL88SFu3N1rF3UIQLwwyv5fIkTr5ru37Br4nAvnEWvlbQQCgK9brzarJxCvPI5yyg0/g+0AvpxCmmHmOSIBZDxx9/IIjv+EIJbCjzQqYq0o1sF+vb9Y28iAi8J06fjByi7iYBEA4dnrcXUwlLhBlRE5CI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QmhmO4DM; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-79a60975dc5so42397307b3.0
        for <linux-wireless@vger.kernel.org>; Mon, 06 Apr 2026 19:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775530130; x=1776134930; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Os/4pn0L/ASajHM2IP5+TXjMdCaPJ2tuIwT9Dt1v7s0=;
        b=QmhmO4DMHefgBtzvSOPjsQG0Ihv6p+Yxi/Z1Z5FHABK2CwceqMm9MS4v74P1JqSaZl
         usBJB8YlSy+YmbJKZ1NXzn5Xv2DwACIJYmKeRbhquqm0MKzD4qPIxvED10gDHG4o/IZJ
         Jk4sMERcA4KVN+8GU6rhPCw9Gki+y4DNuLw51QJCyqIw2avT55tfayvRMShzl6+Pgfjb
         JztR71HilOrBJnC8oKdXSQFfNG9CpL6ov2SBf4TsbmZt0bQIYMs8WQROmWyE/thkJZ88
         rc/mpfFx0zeT6/HEG/lhFYYj44QrvEhVQPCu32Gz1sFqnRta66uORg+eIjvEePhjyi4T
         zK4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775530130; x=1776134930;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Os/4pn0L/ASajHM2IP5+TXjMdCaPJ2tuIwT9Dt1v7s0=;
        b=rUttLckdwBdcx4hrQEqvxJM5CDzVID8g8bZhfP67n0Q+KrjkTRwE3/Hpz6WqWvHiOn
         6U3baWfufcMR+m3uOM8vT5eyz4vDepi1T/an044HPieQc2gOLp9xfuNcOkrHCoTMUjP2
         CVwymO0CNFdW1BhaauLwefMpEd2lxlzmR9aH+Tf48NvPYh+N9eQr4HqYDvmz5thkRYH2
         6j098+jp9XR+tInMQArksu/s/cS3Gt4L8GymDJ7Uhj2Y/1mZr4Ug9vGLJ41VgboRKLG5
         MFPnvMPBJBXoqxBHdfCQjC2zLBjsJIc5pEGKaMbjUAF2F/aElIHHlX8v7z+CEee6lHdA
         xLFA==
X-Gm-Message-State: AOJu0YwPi5qxL0Vl59t9FGBMsH/bR4vRDvdHoAVZFILWNOhnTyabzryq
	QVnUS+p1vwDZT64sKOIpcsf4O1O2lY/hG95uTM9RmNhvlHhS18orEw6S6l2zj7KT
X-Gm-Gg: AeBDievX6hzYPrcKX2BuW3vYgOw6+XWeIlKFoK2Upmd/3SLSuXsuDlq6Ft7IQYk5pvx
	WXurnvRexjUIdOUUPhG9AbfkChhM+kLGV9fJR5CVSdjPHluy5dhrlgrRAmD3U6Yu+LbQzjWrUu/
	Ps4r+pIKAgKsr2Fm1mX3x0TNUE98GIU3yjD2+DwuFpLZRxVzhYRT0MRxzt56iCm9TT7j7+tb3tK
	4YcA+pnts7PNAP+uZ3zzumUnCsmIhMRD1iK3OtehFNiomMIfjvwxM4qeCkNhkRJove/PyjjbL3L
	8Qig6Kh9nQijMwUJ4YolYt/ezBN1a1iyALTcIDkcHoT7wyL4Aoyp1G305l0j7/4qrcs0KK3HS0x
	9gnUKEJwofGDwi8oUMtv7+xGsgORQb85n60deY4C2iWQ4XYbgbf07WPWOVnsY2JNOfnT2IujLJs
	R9l2AH2kTvHjM+gfiP8LPi98IMN9h3Y09rdMQmuwbN2SohlXpQXA++bMXBn6tt
X-Received: by 2002:a05:690c:39b:b0:79c:c51c:7f41 with SMTP id 00721157ae682-7a4d556e135mr148205687b3.29.1775530129831;
        Mon, 06 Apr 2026 19:48:49 -0700 (PDT)
Received: from DEV.lan (c-75-74-152-49.hsd1.fl.comcast.net. [75.74.152.49])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7a36e42ff31sm61216267b3.6.2026.04.06.19.48.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 19:48:49 -0700 (PDT)
From: Joshua Klinesmith <joshuaklinesmith@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: ath11k@lists.infradead.org,
	Joshua Klinesmith <joshuaklinesmith@gmail.com>
Subject: [PATCH wireless] wifi: ath11k: fix monitor mode frame length by using correct descriptor size
Date: Mon,  6 Apr 2026 22:48:36 -0400
Message-ID: <20260407024836.53871-1-joshuaklinesmith@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[lists.infradead.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34409-lists,linux-wireless=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joshuaklinesmith@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-0.999];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 71B9C3A93E5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The monitor mode RX path in ath11k_dp_rx_mon_mpdu_pop() and
ath11k_dp_rx_full_mon_mpdu_pop() uses sizeof(struct hal_rx_desc) to
compute the packet buffer offset. This is the size of the union of all
chip-specific descriptors (the maximum), not the actual descriptor size
for the running chip. The later ath11k_dp_rx_msdus_set_payload() then
strips only hw_params.hal_desc_sz bytes (the chip-specific size) from
the front of the skb.

On IPQ8074 and QCN9074, sizeof(struct hal_rx_desc) is 392 but
hal_desc_sz is 384, leaving 8 extra bytes of descriptor data at the
end of every monitor mode frame delivered to userspace. On WCN6855 the
sizes happen to match so the bug is not visible.

The same mismatch in ath11k_dp_mon_set_frag_len() causes incorrect
fragment length calculation for multi-buffer MSDUs, under-counting
intermediate fragments by 8 bytes and over-counting the last fragment.

Fix by using ar->ab->hw_params.hal_desc_sz consistently in both
monitor mpdu_pop functions and passing it through to set_frag_len.

Fixes: d5c65159f289 ("ath11k: driver for Qualcomm IEEE 802.11ax devices")
Link: https://github.com/openwrt/openwrt/issues/16183
Signed-off-by: Joshua Klinesmith <joshuaklinesmith@gmail.com>
---
 drivers/net/wireless/ath/ath11k/dp_rx.c | 27 ++++++++++++++-----------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/dp_rx.c b/drivers/net/wireless/ath/ath11k/dp_rx.c
index 85defe11750d..c86ffc203f15 100644
--- a/drivers/net/wireless/ath/ath11k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath11k/dp_rx.c
@@ -4511,10 +4511,11 @@ int ath11k_dp_rx_pdev_alloc(struct ath11k_base *ab, int mac_id)
 	return 0;
 }
 
-static void ath11k_dp_mon_set_frag_len(u32 *total_len, u32 *frag_len)
+static void ath11k_dp_mon_set_frag_len(u32 *total_len, u32 *frag_len,
+				       u32 hal_desc_sz)
 {
-	if (*total_len >= (DP_RX_BUFFER_SIZE - sizeof(struct hal_rx_desc))) {
-		*frag_len = DP_RX_BUFFER_SIZE - sizeof(struct hal_rx_desc);
+	if (*total_len >= (DP_RX_BUFFER_SIZE - hal_desc_sz)) {
+		*frag_len = DP_RX_BUFFER_SIZE - hal_desc_sz;
 		*total_len -= *frag_len;
 	} else {
 		*frag_len = *total_len;
@@ -4658,19 +4659,19 @@ static u32 ath11k_dp_rx_mon_comp_ppduid(u32 msdu_ppdu_id, u32 *ppdu_id,
 
 static void ath11k_dp_mon_get_buf_len(struct hal_rx_msdu_desc_info *info,
 				      bool *is_frag, u32 *total_len,
-				      u32 *frag_len, u32 *msdu_cnt)
+				      u32 *frag_len, u32 *msdu_cnt,
+				      u32 hal_desc_sz)
 {
 	if (info->msdu_flags & RX_MSDU_DESC_INFO0_MSDU_CONTINUATION) {
 		if (!*is_frag) {
 			*total_len = info->msdu_len;
 			*is_frag = true;
 		}
-		ath11k_dp_mon_set_frag_len(total_len,
-					   frag_len);
+		ath11k_dp_mon_set_frag_len(total_len, frag_len, hal_desc_sz);
 	} else {
 		if (*is_frag) {
-			ath11k_dp_mon_set_frag_len(total_len,
-						   frag_len);
+			ath11k_dp_mon_set_frag_len(total_len, frag_len,
+						   hal_desc_sz);
 		} else {
 			*frag_len = info->msdu_len;
 		}
@@ -4792,7 +4793,7 @@ u32 ath11k_dp_rx_mon_mpdu_pop(struct ath11k *ar, int mac_id,
 
 			rx_desc = (struct hal_rx_desc *)msdu->data;
 
-			rx_pkt_offset = sizeof(struct hal_rx_desc);
+			rx_pkt_offset = ar->ab->hw_params.hal_desc_sz;
 			l2_hdr_offset = ath11k_dp_rx_h_msdu_end_l3pad(ar->ab, rx_desc);
 
 			if (is_first_msdu) {
@@ -4823,7 +4824,8 @@ u32 ath11k_dp_rx_mon_mpdu_pop(struct ath11k *ar, int mac_id,
 			}
 			ath11k_dp_mon_get_buf_len(&msdu_list.msdu_info[i],
 						  &is_frag, &total_len,
-						  &frag_len, &msdu_cnt);
+						  &frag_len, &msdu_cnt,
+						  rx_pkt_offset);
 			rx_buf_size = rx_pkt_offset + l2_hdr_offset + frag_len;
 
 			ath11k_dp_pkt_set_pktlen(msdu, rx_buf_size);
@@ -5424,7 +5426,7 @@ ath11k_dp_rx_full_mon_mpdu_pop(struct ath11k *ar,
 
 			rx_desc = (struct hal_rx_desc *)msdu->data;
 
-			rx_pkt_offset = sizeof(struct hal_rx_desc);
+			rx_pkt_offset = ar->ab->hw_params.hal_desc_sz;
 			l2_hdr_offset = ath11k_dp_rx_h_msdu_end_l3pad(ar->ab, rx_desc);
 
 			if (is_first_msdu) {
@@ -5439,7 +5441,8 @@ ath11k_dp_rx_full_mon_mpdu_pop(struct ath11k *ar,
 
 			ath11k_dp_mon_get_buf_len(&msdu_list.msdu_info[i],
 						  &is_frag, &total_len,
-						  &frag_len, &msdu_cnt);
+						  &frag_len, &msdu_cnt,
+						  rx_pkt_offset);
 
 			rx_buf_size = rx_pkt_offset + l2_hdr_offset + frag_len;
 
-- 
2.43.0


