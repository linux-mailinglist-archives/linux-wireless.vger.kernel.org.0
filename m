Return-Path: <linux-wireless+bounces-30176-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DD667CE9063
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Dec 2025 09:29:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 730133065788
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Dec 2025 08:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EBCD3043DC;
	Tue, 30 Dec 2025 08:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DbyGS7T8";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="iK6DD8TI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1536E303C87
	for <linux-wireless@vger.kernel.org>; Tue, 30 Dec 2025 08:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767083144; cv=none; b=plpVGIlWTDHn40mJbzuu4MFDomZtmTpFiYVXurlX5ZpMfq3gldG24xHKYtHyBNq+HUZJ6U0Yt1rURGtdhIB7GU3TU/V7hbsRbabGXTBVez0XH9OLnCPvTaSrB5p07zbOY3WHzVS9sNQ3WOkSxImbhDjkMFN06W+r1mGqfbFk4+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767083144; c=relaxed/simple;
	bh=TlBJQa9HxhscuCLaV7cdMtIxVCocqBPsT95DFl1UNo8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GwWBCutT84pdsugmiD4cjUNGf6wZKryVfKYTgvbEUt81gO6EOby61qpYdtmnryYAU5bTJQCwdfKeUJMnG6I/Z4wVKcusN3aFLzX66TBgDdpCSharCI2VcPGNld+1M5Jgm55qZZVNY4KVDNK1JLuEJ7xUWECdy7a2cnf0nHK8YMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DbyGS7T8; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=iK6DD8TI; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BU3jjEv3555942
	for <linux-wireless@vger.kernel.org>; Tue, 30 Dec 2025 08:25:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=dANJwONd9//
	CbIooEk0BRFZtRNns7625dAAREAYAVdI=; b=DbyGS7T8ze0Ce6etIaX3GMu43FF
	JnkBY5xRurXoWQBmrXPTsV9qTOWbTjsPnj2hNwMzOdn8TVSKUnb34vFqhii0SeZM
	jG0b7K9czjGhu+RXzunX2qU35cYcQEBMbdVWhSxVI+qzOmIIUmE7RAfvSvFEZbKj
	eQmLf/6/rJSZ3ftRYLSoFvv12y71oyw+TXIj+ewHZREOP/NupAI2DLDhqq3yNwnN
	l5MBTbPDuwBmWWx/+UPooQ7HIERZsnVtIjf3MI0ORczrJ8vu6vGwrEpVrL63I379
	ORUbVDz69KHQxz+fYtbGaM9H4ouPWLJyyX2cxtJ6glzfXesAtgS/E8m8EYw==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bc7460js4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 30 Dec 2025 08:25:40 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-bb27b422cf2so17874211a12.1
        for <linux-wireless@vger.kernel.org>; Tue, 30 Dec 2025 00:25:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767083140; x=1767687940; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dANJwONd9//CbIooEk0BRFZtRNns7625dAAREAYAVdI=;
        b=iK6DD8TIupCfbuDeLsUb5w1bNDquJMS3XwhSyHw7YhTd9v47NraD+Xq3zrUzTsiwvD
         gNMVXlRn7y0YIkGiJDA2tQmbu8gTffOnBjX20W7h6tcudyPmjJDpGKCKVnyfGuEZT480
         bPEF//jdBVKQF1gvMwWVUcMsYbqFpwFFTYfHa6DPs2bLuTVooiRSWwVAovSJx/2vl7d2
         Q56+dMgIX895w4VMePgvpJYwGm+FDQNcUgcR8eEGZKhrswlTNXx2KB7irYBbjMFi3I4O
         Y4Gi7zJ9+Kv61guocztAhikOhKR/PUDobnP2wzHpnDRLmnvsNPRCUMf74q11xzkK6IGO
         SVig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767083140; x=1767687940;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dANJwONd9//CbIooEk0BRFZtRNns7625dAAREAYAVdI=;
        b=oZNOKoijEWGzIR2QQW9BA23y4NFwDF6MBI6pM5k6sgtBqEUmyG6hlH0PsO5HUQyiLt
         R6NSU/nWkF5A6TJGlOyU6mlwcN0m1GxydFoHO+Ie+3trsYxQMyN+CmB+YzPOzIj6GJpe
         1YDvWArZ4vmBKWHkXdYVqI2piNgQXHYVtqknCBrbrQeuXPpb70niQCkkf86ahouNc43f
         LfiwmyDIHjPDTTRwlWgBZam85PD+0FWXhtwlM35HE/xUwjoFvEMv0zx8FOY1XYT2qP4b
         fkwpQ5qrkpe2B79B8CiwhsnLclbpPBjHcFLtz+fUZsW01GtjNb1xF58h0yCKAmk6ndoq
         tLmg==
X-Gm-Message-State: AOJu0Yxs+NilKuruW91ZvjkAhbDlWD1+S2zR9hh8TN9ESss/oORVLXeg
	SH8oyOfWUj10lRchkEHaYrQVkMDDElYWBedozxcCuvb5m9NUSdHff2DTAiDB0DJJlvlUnftsLlE
	nIHDci5lRnK470nFf0jJtJ0YauqFLpry23ASVFRxbiKeMYxLWjIgBPe4UusArXY5oslscBw==
X-Gm-Gg: AY/fxX5RoMiXU2CMGiyhtwBBtGkt02uuICAffOBfmmaqwLob/6ix53zBMYPIxG48SBr
	9YWVw2kVfPs6RNQruWNI2RDOHa8XrBOTURCT23ix63zCYQ2bNuQPODgY7ltQVaWTQYizmY7gdAt
	u+1IjCEpOklicpezZUkV4eNppRskaSZfjKXWvzpODjfqR9EobQiBP7ts3N60tthf7B+rIjWhnhW
	sUd7kHokHVs0xQ2Jzy6jgbve2n/MUJJFJQ1MDV0HEM9iRKo3id3jH0XHsyfdQLcfcEvudUdhi+H
	2zxB4uSx/toX5x7SExPWI1iFHT1Cx7yWhfU3q5CVmw+xhfOBI1c6hA9glxgDompUw/g3UjCr2Av
	hh1WPNfpvMHa28gQsBP/5/cb/pJxmjIRH0Pc=
X-Received: by 2002:a05:7301:da02:b0:2ae:5ffa:8da4 with SMTP id 5a478bee46e88-2b05eb7dfacmr19427293eec.1.1767083139737;
        Tue, 30 Dec 2025 00:25:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEt8V6VGCxFr8KvOGpiK9lZGxAq3XG9JpbIK9WADuJ+1VU2ZdX6eYh+gfintO3AbDx2ARn08g==
X-Received: by 2002:a05:7301:da02:b0:2ae:5ffa:8da4 with SMTP id 5a478bee46e88-2b05eb7dfacmr19427277eec.1.1767083139087;
        Tue, 30 Dec 2025 00:25:39 -0800 (PST)
Received: from hu-zhangq-sha.qualcomm.com ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b05fcfc1b7sm73275620eec.0.2025.12.30.00.25.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Dec 2025 00:25:38 -0800 (PST)
From: Qian Zhang <qian.zhang@oss.qualcomm.com>
To: ath11k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Venkateswara Naralasetty <quic_vnaralas@quicinc.com>,
        Yu Zhang <yu.zhang@oss.qualcomm.com>,
        Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>,
        Baochen Qiang <baochen.qiang@oss.qualcomm.com>,
        Qian Zhang <qian.zhang@oss.qualcomm.com>
Subject: [PATCH ath-next v5 5/6] wifi: ath11k: Register DBR event handler for CFR data
Date: Tue, 30 Dec 2025 13:55:19 +0530
Message-Id: <20251230082520.3401007-6-qian.zhang@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251230082520.3401007-1-qian.zhang@oss.qualcomm.com>
References: <20251230082520.3401007-1-qian.zhang@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Do9bOW/+ c=1 sm=1 tr=0 ts=69538c84 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=X6MYPc9AQ2pAf6QSHKQA:9
 a=3WC7DwWrALyhR5TkjVHa:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: 0w5mXxfomyRD5ZmJssAX3FDGfDVB5PV5
X-Proofpoint-ORIG-GUID: 0w5mXxfomyRD5ZmJssAX3FDGfDVB5PV5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjMwMDA3NSBTYWx0ZWRfX+/P4CBMiQTxn
 D6wxNJy3mZNhmtUEA6z4zjxlvJR7L87WGXbJneJGH5i0hZEPMB0Zqy1Q7PeMklNKyIFAGeciRZO
 zyltV6+4Aiij98Ob91Dbb06wNEjX2dvwmRf5lmKz/rAqIdHy59YEpKssTxnF0GQeKddduh4P6vD
 2OhtpUnHxJvHzmJvFePjq3QArQsz7gnzgksc8XYboRiCIPFPTRbmED7O3Dx6f7caRRzR6OXIbrh
 EvoiNiqOV14fBQHDIOhzEIyC8JJY40T3xxBSOFghlcgsdB0ygWnOaHXdxoHKMLydWKmEUm7PjKP
 YYUIP57HvjM6TjygXvCgmtZUuLhWk/nqTpPJB+ulsTkVBsR5dwqlACwoIdXqacvbKtgJHMW3rM3
 CI/wkdeg5RNTfqPFvIFYOkVo6SNdU0ZHLDQTDx/UJPy4qm6r4fx0uoznbjXkbbdj+lrA6QQ8/88
 12HHGkX0btSEFxpwXEA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-29_07,2025-12-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 bulkscore=0 adultscore=0 impostorscore=0
 lowpriorityscore=0 spamscore=0 malwarescore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2512300075

From: Venkateswara Naralasetty <quic_vnaralas@quicinc.com>

Add handler for WMI_PDEV_DMA_RING_BUF_RELEASE_EVENT which indicates CFR
data availability in the DB ring.

Add CFR data processing from DB ring buffers. Use correlate_and_relay
API to match CFR data with metadata from WMI_PEER_CFR_CAPTURE_EVENT.

Release buffer to userspace through relayfs on successful correlation,
otherwise hold buffer waiting for matching WMI event from firmware.

Add new debug masks:
 - ATH11K_DBG_CFR:      Enables CFR-related debug logs.
 - ATH11K_DBG_CFR_DUMP: Enables detailed CFR data dump for analysis.

Tested-on: IPQ8074 hw2.0 PCI IPQ8074 WLAN.HK.2.5.0.1-00991-QCAHKSWPL_SILICONZ-1
Tested-on: WCN6855 hw2.1 PCI WLAN.HSP.1.1-04685-QCAHSPSWPL_V1_V2_SILICONZ_IOE-1

Signed-off-by: Venkateswara Naralasetty <quic_vnaralas@quicinc.com>
Co-developed-by: Yu Zhang (Yuriy) <yu.zhang@oss.qualcomm.com>
Signed-off-by: Yu Zhang (Yuriy) <yu.zhang@oss.qualcomm.com>
Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
Reviewed-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Signed-off-by: Qian Zhang <qian.zhang@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath11k/cfr.c    | 240 ++++++++++++++++++++++-
 drivers/net/wireless/ath/ath11k/cfr.h    |  82 ++++++++
 drivers/net/wireless/ath/ath11k/dbring.c |  10 +-
 drivers/net/wireless/ath/ath11k/dbring.h |   2 +
 drivers/net/wireless/ath/ath11k/debug.h  |   8 +-
 5 files changed, 339 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/cfr.c b/drivers/net/wireless/ath/ath11k/cfr.c
index 495b2c6742aa..ee7626bd4b1a 100644
--- a/drivers/net/wireless/ath/ath11k/cfr.c
+++ b/drivers/net/wireless/ath/ath11k/cfr.c
@@ -8,10 +8,248 @@
 #include "core.h"
 #include "debug.h"
 
+struct ath11k_dbring *ath11k_cfr_get_dbring(struct ath11k *ar)
+{
+	if (ar->cfr_enabled)
+		return &ar->cfr.rx_ring;
+
+	return NULL;
+}
+
+static int ath11k_cfr_calculate_tones_from_dma_hdr(struct ath11k_cfr_dma_hdr *hdr)
+{
+	u8 bw = FIELD_GET(CFIR_DMA_HDR_INFO1_UPLOAD_PKT_BW, hdr->info1);
+	u8 preamble = FIELD_GET(CFIR_DMA_HDR_INFO1_PREAMBLE_TYPE, hdr->info1);
+
+	switch (preamble) {
+	case ATH11K_CFR_PREAMBLE_TYPE_LEGACY:
+		fallthrough;
+	case ATH11K_CFR_PREAMBLE_TYPE_VHT:
+		switch (bw) {
+		case 0:
+			return TONES_IN_20MHZ;
+		case 1: /* DUP40/VHT40 */
+			return TONES_IN_40MHZ;
+		case 2: /* DUP80/VHT80 */
+			return TONES_IN_80MHZ;
+		case 3: /* DUP160/VHT160 */
+			return TONES_IN_160MHZ;
+		default:
+			return TONES_INVALID;
+		}
+	case ATH11K_CFR_PREAMBLE_TYPE_HT:
+		switch (bw) {
+		case 0:
+			return TONES_IN_20MHZ;
+		case 1:
+			return TONES_IN_40MHZ;
+		default:
+			return TONES_INVALID;
+		}
+	default:
+		return TONES_INVALID;
+	}
+}
+
+void ath11k_cfr_release_lut_entry(struct ath11k_look_up_table *lut)
+{
+	memset(lut, 0, sizeof(*lut));
+}
+
+static void ath11k_cfr_rfs_write(struct ath11k *ar, const void *head,
+				 u32 head_len, const void *data, u32 data_len,
+				 const void *tail, int tail_data)
+{
+	struct ath11k_cfr *cfr = &ar->cfr;
+
+	if (!cfr->rfs_cfr_capture)
+		return;
+
+	relay_write(cfr->rfs_cfr_capture, head, head_len);
+	relay_write(cfr->rfs_cfr_capture, data, data_len);
+	relay_write(cfr->rfs_cfr_capture, tail, tail_data);
+	relay_flush(cfr->rfs_cfr_capture);
+}
+
+static void ath11k_cfr_free_pending_dbr_events(struct ath11k *ar)
+{
+	struct ath11k_cfr *cfr = &ar->cfr;
+	struct ath11k_look_up_table *lut;
+	int i;
+
+	if (!cfr->lut)
+		return;
+
+	for (i = 0; i < cfr->lut_num; i++) {
+		lut = &cfr->lut[i];
+		if (lut->dbr_recv && !lut->tx_recv &&
+		    lut->dbr_tstamp < cfr->last_success_tstamp) {
+			ath11k_dbring_bufs_replenish(ar, &cfr->rx_ring, lut->buff,
+						     WMI_DIRECT_BUF_CFR);
+			ath11k_cfr_release_lut_entry(lut);
+			cfr->flush_dbr_cnt++;
+		}
+	}
+}
+
+/**
+ * ath11k_cfr_correlate_and_relay() - Correlate and relay CFR events
+ * @ar: Pointer to ath11k structure
+ * @lut: Lookup table for correlation
+ * @event_type: Type of event received (TX or DBR)
+ *
+ * Correlates WMI_PDEV_DMA_RING_BUF_RELEASE_EVENT (DBR) and
+ * WMI_PEER_CFR_CAPTURE_EVENT (TX capture) by PPDU ID. If both events
+ * are present and the PPDU IDs match, returns CORRELATE_STATUS_RELEASE
+ * to relay thecorrelated data to userspace. Otherwise returns
+ * CORRELATE_STATUS_HOLD to wait for the other event.
+ *
+ * Also checks pending DBR events and clears them when no corresponding TX
+ * capture event is received for the PPDU.
+ *
+ * Return: CORRELATE_STATUS_RELEASE or CORRELATE_STATUS_HOLD
+ */
+
+static enum ath11k_cfr_correlate_status
+ath11k_cfr_correlate_and_relay(struct ath11k *ar,
+			       struct ath11k_look_up_table *lut,
+			       u8 event_type)
+{
+	enum ath11k_cfr_correlate_status status;
+	struct ath11k_cfr *cfr = &ar->cfr;
+	u64 diff;
+
+	if (event_type == ATH11K_CORRELATE_TX_EVENT) {
+		if (lut->tx_recv)
+			cfr->cfr_dma_aborts++;
+		cfr->tx_evt_cnt++;
+		lut->tx_recv = true;
+	} else if (event_type == ATH11K_CORRELATE_DBR_EVENT) {
+		cfr->dbr_evt_cnt++;
+		lut->dbr_recv = true;
+	}
+
+	if (lut->dbr_recv && lut->tx_recv) {
+		if (lut->dbr_ppdu_id == lut->tx_ppdu_id) {
+			/*
+			 * 64-bit counters make wraparound highly improbable,
+			 * wraparound handling is omitted.
+			 */
+			cfr->last_success_tstamp = lut->dbr_tstamp;
+			if (lut->dbr_tstamp > lut->txrx_tstamp) {
+				diff = lut->dbr_tstamp - lut->txrx_tstamp;
+				ath11k_dbg(ar->ab, ATH11K_DBG_CFR,
+					   "txrx event -> dbr event delay = %u ms",
+					   jiffies_to_msecs(diff));
+			} else if (lut->txrx_tstamp > lut->dbr_tstamp) {
+				diff = lut->txrx_tstamp - lut->dbr_tstamp;
+				ath11k_dbg(ar->ab, ATH11K_DBG_CFR,
+					   "dbr event -> txrx event delay = %u ms",
+					   jiffies_to_msecs(diff));
+			}
+
+			ath11k_cfr_free_pending_dbr_events(ar);
+
+			cfr->release_cnt++;
+			status = ATH11K_CORRELATE_STATUS_RELEASE;
+		} else {
+			/*
+			 * Discard TXRX event on PPDU ID mismatch because multiple PPDUs
+			 * may share the same DMA address due to ucode aborts.
+			 */
+
+			ath11k_dbg(ar->ab, ATH11K_DBG_CFR,
+				   "Received dbr event twice for the same lut entry");
+			lut->tx_recv = false;
+			lut->tx_ppdu_id = 0;
+			cfr->clear_txrx_event++;
+			cfr->cfr_dma_aborts++;
+			status = ATH11K_CORRELATE_STATUS_HOLD;
+		}
+	} else {
+		status = ATH11K_CORRELATE_STATUS_HOLD;
+	}
+
+	return status;
+}
+
 static int ath11k_cfr_process_data(struct ath11k *ar,
 				   struct ath11k_dbring_data *param)
 {
-	return 0;
+	u32 end_magic = ATH11K_CFR_END_MAGIC;
+	struct ath11k_csi_cfr_header *header;
+	struct ath11k_cfr_dma_hdr *dma_hdr;
+	struct ath11k_cfr *cfr = &ar->cfr;
+	struct ath11k_look_up_table *lut;
+	struct ath11k_base *ab = ar->ab;
+	u32 buf_id, tones, length;
+	u8 num_chains;
+	int status;
+	u8 *data;
+
+	data = param->data;
+	buf_id = param->buf_id;
+
+	if (param->data_sz < sizeof(*dma_hdr))
+		return -EINVAL;
+
+	dma_hdr = (struct ath11k_cfr_dma_hdr *)data;
+
+	tones = ath11k_cfr_calculate_tones_from_dma_hdr(dma_hdr);
+	if (tones == TONES_INVALID) {
+		ath11k_warn(ar->ab, "Number of tones received is invalid\n");
+		return -EINVAL;
+	}
+
+	num_chains = FIELD_GET(CFIR_DMA_HDR_INFO1_NUM_CHAINS,
+			       dma_hdr->info1);
+
+	length = sizeof(*dma_hdr);
+	length += tones * (num_chains + 1);
+
+	spin_lock_bh(&cfr->lut_lock);
+
+	if (!cfr->lut) {
+		spin_unlock_bh(&cfr->lut_lock);
+		return -EINVAL;
+	}
+
+	lut = &cfr->lut[buf_id];
+
+	ath11k_dbg_dump(ab, ATH11K_DBG_CFR_DUMP, "data_from_buf_rel:", "",
+			data, length);
+
+	lut->buff = param->buff;
+	lut->data = data;
+	lut->data_len = length;
+	lut->dbr_ppdu_id = dma_hdr->phy_ppdu_id;
+	lut->dbr_tstamp = jiffies;
+
+	memcpy(&lut->hdr, dma_hdr, sizeof(*dma_hdr));
+
+	header = &lut->header;
+	header->meta_data.channel_bw = FIELD_GET(CFIR_DMA_HDR_INFO1_UPLOAD_PKT_BW,
+						 dma_hdr->info1);
+	header->meta_data.length = length;
+
+	status = ath11k_cfr_correlate_and_relay(ar, lut,
+						ATH11K_CORRELATE_DBR_EVENT);
+	if (status == ATH11K_CORRELATE_STATUS_RELEASE) {
+		ath11k_dbg(ab, ATH11K_DBG_CFR,
+			   "releasing CFR data to user space");
+		ath11k_cfr_rfs_write(ar, &lut->header,
+				     sizeof(struct ath11k_csi_cfr_header),
+				     lut->data, lut->data_len,
+				     &end_magic, sizeof(u32));
+		ath11k_cfr_release_lut_entry(lut);
+	} else if (status == ATH11K_CORRELATE_STATUS_HOLD) {
+		ath11k_dbg(ab, ATH11K_DBG_CFR,
+			   "tx event is not yet received holding the buf");
+	}
+
+	spin_unlock_bh(&cfr->lut_lock);
+
+	return status;
 }
 
 /* Helper function to check whether the given peer mac address
diff --git a/drivers/net/wireless/ath/ath11k/cfr.h b/drivers/net/wireless/ath/ath11k/cfr.h
index 19f136d34c65..c8e5086674d2 100644
--- a/drivers/net/wireless/ath/ath11k/cfr.h
+++ b/drivers/net/wireless/ath/ath11k/cfr.h
@@ -19,9 +19,78 @@
 
 #define HOST_MAX_CHAINS 8
 
+enum ath11k_cfr_correlate_event_type {
+	ATH11K_CORRELATE_DBR_EVENT,
+	ATH11K_CORRELATE_TX_EVENT,
+};
+
 struct ath11k_sta;
 struct ath11k_per_peer_cfr_capture;
 
+#define ATH11K_CFR_END_MAGIC 0xBEAFDEAD
+
+enum ath11k_cfr_correlate_status {
+	ATH11K_CORRELATE_STATUS_RELEASE,
+	ATH11K_CORRELATE_STATUS_HOLD,
+	ATH11K_CORRELATE_STATUS_ERR,
+};
+
+enum ath11k_cfr_preamble_type {
+	ATH11K_CFR_PREAMBLE_TYPE_LEGACY,
+	ATH11K_CFR_PREAMBLE_TYPE_HT,
+	ATH11K_CFR_PREAMBLE_TYPE_VHT,
+};
+
+struct cfr_metadata {
+	u8 peer_addr[ETH_ALEN];
+	u8 status;
+	u8 capture_bw;
+	u8 channel_bw;
+	u8 phy_mode;
+	u16 prim20_chan;
+	u16 center_freq1;
+	u16 center_freq2;
+	u8 capture_mode;
+	u8 capture_type;
+	u8 sts_count;
+	u8 num_rx_chain;
+	u32 timestamp;
+	u32 length;
+	u32 chain_rssi[HOST_MAX_CHAINS];
+	u16 chain_phase[HOST_MAX_CHAINS];
+	u32 cfo_measurement;
+	u8 agc_gain[HOST_MAX_CHAINS];
+	u32 rx_start_ts;
+} __packed;
+
+struct ath11k_csi_cfr_header {
+	u32 start_magic_num;
+	u32 vendorid;
+	u8 cfr_metadata_version;
+	u8 cfr_data_version;
+	u8 chip_type;
+	u8 platform_type;
+	u32 reserved;
+	struct cfr_metadata meta_data;
+} __packed;
+
+#define TONES_IN_20MHZ  256
+#define TONES_IN_40MHZ  512
+#define TONES_IN_80MHZ  1024
+#define TONES_IN_160MHZ 2048 /* 160 MHz isn't supported yet */
+#define TONES_INVALID   0
+
+#define CFIR_DMA_HDR_INFO0_TAG GENMASK(7, 0)
+#define CFIR_DMA_HDR_INFO0_LEN GENMASK(13, 8)
+
+#define CFIR_DMA_HDR_INFO1_UPLOAD_DONE      GENMASK(0, 0)
+#define CFIR_DMA_HDR_INFO1_CAPTURE_TYPE     GENMASK(3, 1)
+#define CFIR_DMA_HDR_INFO1_PREAMBLE_TYPE    GENMASK(5, 4)
+#define CFIR_DMA_HDR_INFO1_NSS              GENMASK(8, 6)
+#define CFIR_DMA_HDR_INFO1_NUM_CHAINS       GENMASK(11, 9)
+#define CFIR_DMA_HDR_INFO1_UPLOAD_PKT_BW    GENMASK(14, 12)
+#define CFIR_DMA_HDR_INFO1_SW_PEER_ID_VALID GENMASK(15, 15)
+
 struct ath11k_cfr_dma_hdr {
 	u16 info0;
 	u16 info1;
@@ -37,6 +106,7 @@ struct ath11k_look_up_table {
 	u16 dbr_ppdu_id;
 	u16 tx_ppdu_id;
 	dma_addr_t dbr_address;
+	struct ath11k_csi_cfr_header header;
 	struct ath11k_cfr_dma_hdr hdr;
 	u64 txrx_tstamp;
 	u64 dbr_tstamp;
@@ -109,6 +179,8 @@ int ath11k_cfr_send_peer_cfr_capture_cmd(struct ath11k *ar,
 					 struct ath11k_sta *arsta,
 					 struct ath11k_per_peer_cfr_capture *params,
 					 const u8 *peer_mac);
+struct ath11k_dbring *ath11k_cfr_get_dbring(struct ath11k *ar);
+void ath11k_cfr_release_lut_entry(struct ath11k_look_up_table *lut);
 
 #else
 static inline int ath11k_cfr_init(struct ath11k_base *ab)
@@ -156,5 +228,15 @@ ath11k_cfr_send_peer_cfr_capture_cmd(struct ath11k *ar,
 {
 	return 0;
 }
+
+static inline void ath11k_cfr_release_lut_entry(struct ath11k_look_up_table *lut)
+{
+}
+
+static inline
+struct ath11k_dbring *ath11k_cfr_get_dbring(struct ath11k *ar)
+{
+	return NULL;
+}
 #endif /* CONFIG_ATH11K_CFR */
 #endif /* ATH11K_CFR_H */
diff --git a/drivers/net/wireless/ath/ath11k/dbring.c b/drivers/net/wireless/ath/ath11k/dbring.c
index ed2b781a6bab..d6994ce6ebff 100644
--- a/drivers/net/wireless/ath/ath11k/dbring.c
+++ b/drivers/net/wireless/ath/ath11k/dbring.c
@@ -295,6 +295,7 @@ int ath11k_dbring_buffer_release_event(struct ath11k_base *ab,
 	int size;
 	dma_addr_t paddr;
 	int ret = 0;
+	int status;
 
 	pdev_idx = ev->fixed.pdev_id;
 	module_id = ev->fixed.module_id;
@@ -328,6 +329,9 @@ int ath11k_dbring_buffer_release_event(struct ath11k_base *ab,
 	case WMI_DIRECT_BUF_SPECTRAL:
 		ring = ath11k_spectral_get_dbring(ar);
 		break;
+	case WMI_DIRECT_BUF_CFR:
+		ring = ath11k_cfr_get_dbring(ar);
+		break;
 	default:
 		ring = NULL;
 		ath11k_warn(ab, "Recv dma buffer release ev on unsupp module %d\n",
@@ -378,8 +382,12 @@ int ath11k_dbring_buffer_release_event(struct ath11k_base *ab,
 			handler_data.data = PTR_ALIGN(vaddr_unalign,
 						      ring->buf_align);
 			handler_data.data_sz = ring->buf_sz;
+			handler_data.buff = buff;
+			handler_data.buf_id = buf_id;
 
-			ring->handler(ar, &handler_data);
+			status = ring->handler(ar, &handler_data);
+			if (status == ATH11K_CORRELATE_STATUS_HOLD)
+				continue;
 		}
 
 		buff->paddr = 0;
diff --git a/drivers/net/wireless/ath/ath11k/dbring.h b/drivers/net/wireless/ath/ath11k/dbring.h
index 0a380120f7a0..e5f244dfa963 100644
--- a/drivers/net/wireless/ath/ath11k/dbring.h
+++ b/drivers/net/wireless/ath/ath11k/dbring.h
@@ -21,6 +21,8 @@ struct ath11k_dbring_data {
 	void *data;
 	u32 data_sz;
 	struct wmi_dma_buf_release_meta_data meta;
+	struct ath11k_dbring_element *buff;
+	u32 buf_id;
 };
 
 struct ath11k_dbring_buf_release_event {
diff --git a/drivers/net/wireless/ath/ath11k/debug.h b/drivers/net/wireless/ath/ath11k/debug.h
index cc8934d15697..aaa0034527a5 100644
--- a/drivers/net/wireless/ath/ath11k/debug.h
+++ b/drivers/net/wireless/ath/ath11k/debug.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: BSD-3-Clause-Clear */
 /*
  * Copyright (c) 2018-2019 The Linux Foundation. All rights reserved.
- * Copyright (c) 2022-2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 
 #ifndef _ATH11K_DEBUG_H_
@@ -27,6 +27,8 @@ enum ath11k_debug_mask {
 	ATH11K_DBG_DP_TX	= 0x00002000,
 	ATH11K_DBG_DP_RX	= 0x00004000,
 	ATH11K_DBG_CE		= 0x00008000,
+	ATH11K_DBG_CFR		= 0x00010000,
+	ATH11K_DBG_CFR_DUMP	= 0x00020000,
 };
 
 static inline const char *ath11k_dbg_str(enum ath11k_debug_mask mask)
@@ -64,6 +66,10 @@ static inline const char *ath11k_dbg_str(enum ath11k_debug_mask mask)
 		return "dp_rx";
 	case ATH11K_DBG_CE:
 		return "ce";
+	case ATH11K_DBG_CFR:
+		return "cfr";
+	case ATH11K_DBG_CFR_DUMP:
+		return "cfr_dump";
 
 	/* no default handler to allow compiler to check that the
 	 * enum is fully handled
-- 
2.34.1


