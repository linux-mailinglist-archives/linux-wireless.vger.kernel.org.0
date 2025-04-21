Return-Path: <linux-wireless+bounces-21772-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E54DA94B0B
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Apr 2025 04:36:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95B5C3AF3F6
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Apr 2025 02:35:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 767221C5F09;
	Mon, 21 Apr 2025 02:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pzHwvk9r"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 585511E98EA
	for <linux-wireless@vger.kernel.org>; Mon, 21 Apr 2025 02:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745202939; cv=none; b=dRjg2vFvZxplI7jF4/WpxkIpmUcxdw7ZUXk+Eeyftqo5bmPAKo2KO3TeyXs6LY3wh07M11Nj9ubKIoBIaDpdSgT/iv/11YSbBbXjCzcMAxlUWkNq0Oqw2h3OSoVF5sLF4a98TuHCkp0FXSy1FTBgJhURg9ZKNRwHf9ROlNOLqWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745202939; c=relaxed/simple;
	bh=i7q4r0f+m0EFUWFLW/SlSB29XdwL1ys8qkMrLHoO+oA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=T+8WrL/FlgYSL6+338jnF2m248ixXBk79CbmMeZ+Js90hhJA3Wzv7j5yZW7zso8ciwDAuek7+bbCGW5VcptndmaJZaSC+AK0AkoMeHtk2Fgt0FlA8nckuioLj4IO7Ntphl04YENdN3t6vjtRKdCLlm3rgKvIHoH9U/1mDyjcL2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pzHwvk9r; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53KM3XNO005669
	for <linux-wireless@vger.kernel.org>; Mon, 21 Apr 2025 02:35:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=8/iAloNN3/S
	XBpDPjstF8I4cI2QpCksSU2jkEfuCzp8=; b=pzHwvk9rR0VOPFYpAPcA8WMz+zo
	e3SWmyfp1RmDEtDmZw1o0LnjnwUPCA8l4nb+jHYMn5kOy72ZMnOVk1mSbnR0uJT1
	EcJj8/SSnRNBg2PRtJKeBZXhHI7otheoxrKJ7n7K/5w5WpnHj83G6XUEevDa/ETc
	3ieWPGn1x7LAe4v1BL2iVgTqOz++JRLxZYwGsxyz5XPJtkpndEB28SdcvDlBSstt
	UMuqcK0g7+rpnpKiIqoq3VZxbWu/L4OFCZ0N8+efiqwzD7isVi1MtRShy0s1/5pX
	J48gAqVJ8STYo2O5DFfaPKkak8SNmfoESQfFL/xr6ZVhAWFD5dH2G9R6HGQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4642svau2w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 21 Apr 2025 02:35:36 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2254e500a73so24346025ad.0
        for <linux-wireless@vger.kernel.org>; Sun, 20 Apr 2025 19:35:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745202935; x=1745807735;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8/iAloNN3/SXBpDPjstF8I4cI2QpCksSU2jkEfuCzp8=;
        b=nP31nZtZv3p0q82SxjqgwbXPQbBdoUi6Kh53VfHvoHmEwrwIXEcyD98sZIN+/bjIvG
         rnNtdUAicWh7YYbiZm0+IiDJzWiTzpOcnGqnJzrLiTqHje4TUIUytPaaaDi1b3PJRW6Y
         78bB4Ki2SbObSdX/ZHrA6iyctkfZGiUl4jtHodrYOOH8ekIuHAiOFeIP1YVgFhO0W81k
         EKNriM+q+dV6aktzc5wLWbr/F1R+gcp1LoucmKl0l/nxS7JHZQ02/9CpyDpTGiIl9eyQ
         GOd2F3ylSaX9JhZVGLqDUCb2nVNxQp0yXGhTIBzi4ntYoCtNKkFncWHAANMSeUF4v6+G
         uiIQ==
X-Gm-Message-State: AOJu0YzOypEuK/VE8OXuaKG6ar5QTI/IUuIbW0fFvVF0EtSROQ/EBfX7
	X0j93FkxajdBJrJfTnjPwPoDFJMPsWMSYhSfNEfekUrc2adfEcWw1C4+oetoW7lhFTcxFF5dL1M
	9YjG6ixLJAcGIX+RMjtELHuyXdytKTcxH1EtqBI7UFXJ+VNGk9WblEC8lw+w7qQ+52w==
X-Gm-Gg: ASbGncuTtYhO7/0MCNE6+YdSn1T5H9mtG9o14kRK+BqYyR2Rw5XiMAN3zNrh6MJzPnF
	N+s00z+5bZwQJIw3csWg3MxQZYPD8oLqdriZ6TCgItrjf+fiYo9lOA+w62vNCOz9NhaLj3Ig7Ka
	0mJH25O1VkEFIX9AvnMrTr5CCmcBWYkxr3tlpr/WTEXDnsPBxlvxq5oOyxmEMnKXKcVHcHCewJW
	RKEOI/VZCiT29PW+FiPYznVwmRvCZKcJOQAfG3U4RZRheo7HuuqXtdelnFRP5BEvy6UxNElv8fl
	s/FNUiALA+X15hhKOg1MUlGp+jQuUD8EKvDtSgc1cQKDL0RhwT0XWnPZ6JuudMG6PQtQI+THKR2
	2lrET7fCdMMY=
X-Received: by 2002:a17:902:dac7:b0:224:b60:3cd3 with SMTP id d9443c01a7336-22c53583e10mr142394975ad.19.1745202935236;
        Sun, 20 Apr 2025 19:35:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGrkcI/0BiCsIXdu6s0AWnAWWQcdRF6xiO+kw4zovKCP10CKRTyYBrCybOX2OVcWfxxRFeR5w==
X-Received: by 2002:a17:902:dac7:b0:224:b60:3cd3 with SMTP id d9443c01a7336-22c53583e10mr142394715ad.19.1745202934838;
        Sun, 20 Apr 2025 19:35:34 -0700 (PDT)
Received: from kangyang.ap.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c50eb4287sm54631685ad.130.2025.04.20.19.35.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Apr 2025 19:35:34 -0700 (PDT)
From: Kang Yang <kang.yang@oss.qualcomm.com>
To: ath12k@lists.infradead.org, kang.yang@oss.qualcomm.com
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH ath-next 10/13] wifi: ath12k: add support to reap and process mon dest ring
Date: Mon, 21 Apr 2025 10:34:41 +0800
Message-Id: <20250421023444.1778-11-kang.yang@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1.windows.1
In-Reply-To: <20250421023444.1778-1-kang.yang@oss.qualcomm.com>
References: <20250421023444.1778-1-kang.yang@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: vl_ncP-1c9fLgrvHUNKf6MkpyqK0DlTO
X-Proofpoint-ORIG-GUID: vl_ncP-1c9fLgrvHUNKf6MkpyqK0DlTO
X-Authority-Analysis: v=2.4 cv=QLJoRhLL c=1 sm=1 tr=0 ts=6805aef8 cx=c_pps a=JL+w9abYAAE89/QcEU+0QA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17 a=XR8D0OoHHMoA:10 a=EUspDBNiAAAA:8 a=qOhdtzLYn0TtUq8GnO0A:9 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-21_01,2025-04-17_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 lowpriorityscore=0 mlxscore=0 spamscore=0 mlxlogscore=999 malwarescore=0
 adultscore=0 phishscore=0 suspectscore=0 impostorscore=0
 priorityscore=1501 clxscore=1015 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504210018

WCN7850 uses error dst ring as mon dest ring. Each time hardware
receives a packet, will fill the payload into mon dest ring.

The mon dest ring may store many MSDUs, which belonged to different
MPDUs. Need to retrieve MSDUs based on the PPDU ID, only processing the
MSDUs with same PPDU ID each time.

The PPDU ID is used in cycles,  the difference between the PPDU IDs
of the two rings must be checked. If the status PPDU ID minus the
dest PPDU ID is greater than 20000, it is considered a wrap-around
case.

After reaping the mon dest ring, should prepare packet and deliver it to
mac80211 when status PPDU ID is equal to dest PPDU ID. Then start to
process next PPDU if exists.

But if dest PPDU ID > status PPDU ID, should hold on to mon dest ring
processing. If it exceeds 16 consecutive times, status PPDU ID will be
forcibly set to dest PPDU ID to avoid backpressure issue.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1

Signed-off-by: Kang Yang <kang.yang@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/dp_mon.c | 356 ++++++++++++++++++++++-
 drivers/net/wireless/ath/ath12k/dp_rx.c  |  22 +-
 drivers/net/wireless/ath/ath12k/dp_rx.h  |  10 +-
 drivers/net/wireless/ath/ath12k/hal_rx.c |  80 +++++
 drivers/net/wireless/ath/ath12k/hal_rx.h |   8 +
 5 files changed, 471 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/dp_mon.c b/drivers/net/wireless/ath/ath12k/dp_mon.c
index 9fd71665d086..7e0dc4d0327c 100644
--- a/drivers/net/wireless/ath/ath12k/dp_mon.c
+++ b/drivers/net/wireless/ath/ath12k/dp_mon.c
@@ -1835,6 +1835,40 @@ ath12k_dp_rx_mon_buf_done(struct ath12k_base *ab, struct hal_srng *srng,
 	return DP_MON_STATUS_REPLINISH;
 }
 
+static u32 ath12k_dp_mon_comp_ppduid(u32 msdu_ppdu_id, u32 *ppdu_id)
+{
+	u32 ret = 0;
+
+	if ((*ppdu_id < msdu_ppdu_id) &&
+	    ((msdu_ppdu_id - *ppdu_id) < DP_NOT_PPDU_ID_WRAP_AROUND)) {
+		/* Hold on mon dest ring, and reap mon status ring. */
+		*ppdu_id = msdu_ppdu_id;
+		ret = msdu_ppdu_id;
+	} else if ((*ppdu_id > msdu_ppdu_id) &&
+		((*ppdu_id - msdu_ppdu_id) > DP_NOT_PPDU_ID_WRAP_AROUND)) {
+		/* PPDU ID has exceeded the maximum value and will
+		 * restart from 0.
+		 */
+		*ppdu_id = msdu_ppdu_id;
+		ret = msdu_ppdu_id;
+	}
+	return ret;
+}
+
+static
+void ath12k_dp_mon_next_link_desc_get(struct hal_rx_msdu_link *msdu_link,
+				      dma_addr_t *paddr, u32 *sw_cookie, u8 *rbm,
+				      struct ath12k_buffer_addr **pp_buf_addr_info)
+{
+	struct ath12k_buffer_addr *buf_addr_info;
+
+	buf_addr_info = &msdu_link->buf_addr_info;
+
+	ath12k_hal_rx_buf_addr_info_get(buf_addr_info, paddr, sw_cookie, rbm);
+
+	*pp_buf_addr_info = buf_addr_info;
+}
+
 static void
 ath12k_dp_mon_fill_rx_rate(struct ath12k *ar,
 			   struct hal_rx_mon_ppdu_info *ppdu_info,
@@ -2342,6 +2376,32 @@ static int ath12k_dp_pkt_set_pktlen(struct sk_buff *skb, u32 len)
 	return 0;
 }
 
+/* Hardware fill buffer with 128 bytes aligned. So need to reap it
+ * with 128 bytes aligned.
+ */
+#define RXDMA_DATA_DMA_BLOCK_SIZE 128
+
+static void
+ath12k_dp_mon_get_buf_len(struct hal_rx_msdu_desc_info *info,
+			  bool *is_frag, u32 *total_len,
+			  u32 *frag_len, u32 *msdu_cnt)
+{
+	if (info->msdu_flags & RX_MSDU_DESC_INFO0_MSDU_CONTINUATION) {
+		*is_frag = true;
+		*frag_len = (RX_MON_STATUS_BASE_BUF_SIZE -
+			     sizeof(struct hal_rx_desc)) &
+			     ~(RXDMA_DATA_DMA_BLOCK_SIZE - 1);
+		*total_len += *frag_len;
+	} else {
+		if (*is_frag)
+			*frag_len = info->msdu_len - *total_len;
+		else
+			*frag_len = info->msdu_len;
+
+		*msdu_cnt -= 1;
+	}
+}
+
 static int
 ath12k_dp_mon_parse_status_buf(struct ath12k *ar,
 			       struct ath12k_mon_data *pmon,
@@ -3957,6 +4017,300 @@ static int ath12k_dp_rx_reap_mon_status_ring(struct ath12k_base *ab, int mac_id,
 	return num_buffs_reaped;
 }
 
+static u32
+ath12k_dp_rx_mon_mpdu_pop(struct ath12k *ar, int mac_id,
+			  void *ring_entry, struct sk_buff **head_msdu,
+			  struct sk_buff **tail_msdu,
+			  struct list_head *used_list,
+			  u32 *npackets, u32 *ppdu_id)
+{
+	struct ath12k_mon_data *pmon = (struct ath12k_mon_data *)&ar->dp.mon_data;
+	struct ath12k_buffer_addr *p_buf_addr_info, *p_last_buf_addr_info;
+	u32 msdu_ppdu_id = 0, msdu_cnt = 0, total_len = 0, frag_len = 0;
+	u32 rx_buf_size, rx_pkt_offset, sw_cookie;
+	bool is_frag, is_first_msdu, drop_mpdu = false;
+	struct hal_reo_entrance_ring *ent_desc =
+		(struct hal_reo_entrance_ring *)ring_entry;
+	u32 rx_bufs_used = 0, i = 0, desc_bank = 0;
+	struct hal_rx_desc *rx_desc, *tail_rx_desc;
+	struct hal_rx_msdu_link *msdu_link_desc;
+	struct sk_buff *msdu = NULL, *last = NULL;
+	struct ath12k_rx_desc_info *desc_info;
+	struct ath12k_buffer_addr buf_info;
+	struct hal_rx_msdu_list msdu_list;
+	struct ath12k_skb_rxcb *rxcb;
+	u16 num_msdus = 0;
+	dma_addr_t paddr;
+	u8 rbm;
+
+	ath12k_hal_rx_reo_ent_buf_paddr_get(ring_entry, &paddr,
+					    &sw_cookie,
+					    &p_last_buf_addr_info, &rbm,
+					    &msdu_cnt);
+
+	spin_lock_bh(&pmon->mon_lock);
+
+	if (le32_get_bits(ent_desc->info1,
+			  HAL_REO_ENTR_RING_INFO1_RXDMA_PUSH_REASON) ==
+			  HAL_REO_DEST_RING_PUSH_REASON_ERR_DETECTED) {
+		u8 rxdma_err = le32_get_bits(ent_desc->info1,
+					     HAL_REO_ENTR_RING_INFO1_RXDMA_ERROR_CODE);
+		if (rxdma_err == HAL_REO_ENTR_RING_RXDMA_ECODE_FLUSH_REQUEST_ERR ||
+		    rxdma_err == HAL_REO_ENTR_RING_RXDMA_ECODE_MPDU_LEN_ERR ||
+		    rxdma_err == HAL_REO_ENTR_RING_RXDMA_ECODE_OVERFLOW_ERR) {
+			drop_mpdu = true;
+			pmon->rx_mon_stats.dest_mpdu_drop++;
+		}
+	}
+
+	is_frag = false;
+	is_first_msdu = true;
+	rx_pkt_offset = sizeof(struct hal_rx_desc);
+
+	do {
+		if (pmon->mon_last_linkdesc_paddr == paddr) {
+			pmon->rx_mon_stats.dup_mon_linkdesc_cnt++;
+			spin_unlock_bh(&pmon->mon_lock);
+			return rx_bufs_used;
+		}
+
+		desc_bank = u32_get_bits(sw_cookie, DP_LINK_DESC_BANK_MASK);
+		msdu_link_desc =
+			ar->ab->dp.link_desc_banks[desc_bank].vaddr +
+			(paddr - ar->ab->dp.link_desc_banks[desc_bank].paddr);
+
+		ath12k_hal_rx_msdu_list_get(ar, msdu_link_desc, &msdu_list,
+					    &num_msdus);
+		desc_info = ath12k_dp_get_rx_desc(ar->ab,
+						  msdu_list.sw_cookie[num_msdus - 1]);
+		tail_rx_desc = (struct hal_rx_desc *)(desc_info->skb)->data;
+
+		for (i = 0; i < num_msdus; i++) {
+			u32 l2_hdr_offset;
+
+			if (pmon->mon_last_buf_cookie == msdu_list.sw_cookie[i]) {
+				ath12k_dbg(ar->ab, ATH12K_DBG_DATA,
+					   "i %d last_cookie %d is same\n",
+					   i, pmon->mon_last_buf_cookie);
+				drop_mpdu = true;
+				pmon->rx_mon_stats.dup_mon_buf_cnt++;
+				continue;
+			}
+
+			desc_info =
+				ath12k_dp_get_rx_desc(ar->ab, msdu_list.sw_cookie[i]);
+			msdu = desc_info->skb;
+
+			if (!msdu) {
+				ath12k_dbg(ar->ab, ATH12K_DBG_DATA,
+					   "msdu_pop: invalid msdu (%d/%d)\n",
+					   i + 1, num_msdus);
+				goto next_msdu;
+			}
+			rxcb = ATH12K_SKB_RXCB(msdu);
+			if (rxcb->paddr != msdu_list.paddr[i]) {
+				ath12k_dbg(ar->ab, ATH12K_DBG_DATA,
+					   "i %d paddr %lx != %lx\n",
+					   i, (unsigned long)rxcb->paddr,
+					   (unsigned long)msdu_list.paddr[i]);
+				drop_mpdu = true;
+				continue;
+			}
+			if (!rxcb->unmapped) {
+				dma_unmap_single(ar->ab->dev, rxcb->paddr,
+						 msdu->len +
+						 skb_tailroom(msdu),
+						 DMA_FROM_DEVICE);
+				rxcb->unmapped = 1;
+			}
+			if (drop_mpdu) {
+				ath12k_dbg(ar->ab, ATH12K_DBG_DATA,
+					   "i %d drop msdu %p *ppdu_id %x\n",
+					   i, msdu, *ppdu_id);
+				dev_kfree_skb_any(msdu);
+				msdu = NULL;
+				goto next_msdu;
+			}
+
+			rx_desc = (struct hal_rx_desc *)msdu->data;
+			l2_hdr_offset = ath12k_dp_rx_h_l3pad(ar->ab, tail_rx_desc);
+			if (is_first_msdu) {
+				if (!ath12k_dp_rxdesc_mpdu_valid(ar->ab, rx_desc)) {
+					drop_mpdu = true;
+					dev_kfree_skb_any(msdu);
+					msdu = NULL;
+					pmon->mon_last_linkdesc_paddr = paddr;
+					goto next_msdu;
+				}
+				msdu_ppdu_id =
+					ath12k_dp_rxdesc_get_ppduid(ar->ab, rx_desc);
+
+				if (ath12k_dp_mon_comp_ppduid(msdu_ppdu_id,
+							      ppdu_id)) {
+					spin_unlock_bh(&pmon->mon_lock);
+					return rx_bufs_used;
+				}
+				pmon->mon_last_linkdesc_paddr = paddr;
+				is_first_msdu = false;
+			}
+			ath12k_dp_mon_get_buf_len(&msdu_list.msdu_info[i],
+						  &is_frag, &total_len,
+						  &frag_len, &msdu_cnt);
+			rx_buf_size = rx_pkt_offset + l2_hdr_offset + frag_len;
+
+			if (ath12k_dp_pkt_set_pktlen(msdu, rx_buf_size)) {
+				dev_kfree_skb_any(msdu);
+				goto next_msdu;
+			}
+
+			if (!(*head_msdu))
+				*head_msdu = msdu;
+			else if (last)
+				last->next = msdu;
+
+			last = msdu;
+next_msdu:
+			pmon->mon_last_buf_cookie = msdu_list.sw_cookie[i];
+			rx_bufs_used++;
+			desc_info->skb = NULL;
+			list_add_tail(&desc_info->list, used_list);
+		}
+
+		ath12k_hal_rx_buf_addr_info_set(&buf_info, paddr, sw_cookie, rbm);
+
+		ath12k_dp_mon_next_link_desc_get(msdu_link_desc, &paddr,
+						 &sw_cookie, &rbm,
+						 &p_buf_addr_info);
+
+		ath12k_dp_rx_link_desc_return(ar->ab, &buf_info,
+					      HAL_WBM_REL_BM_ACT_PUT_IN_IDLE);
+
+		p_last_buf_addr_info = p_buf_addr_info;
+
+	} while (paddr && msdu_cnt);
+
+	spin_unlock_bh(&pmon->mon_lock);
+
+	if (last)
+		last->next = NULL;
+
+	*tail_msdu = msdu;
+
+	if (msdu_cnt == 0)
+		*npackets = 1;
+
+	return rx_bufs_used;
+}
+
+/* The destination ring processing is stuck if the destination is not
+ * moving while status ring moves 16 PPDU. The destination ring processing
+ * skips this destination ring PPDU as a workaround.
+ */
+#define MON_DEST_RING_STUCK_MAX_CNT 16
+
+static void ath12k_dp_rx_mon_dest_process(struct ath12k *ar, int mac_id,
+					  u32 quota, struct napi_struct *napi)
+{
+	struct ath12k_mon_data *pmon = (struct ath12k_mon_data *)&ar->dp.mon_data;
+	struct ath12k_pdev_mon_stats *rx_mon_stats;
+	u32 ppdu_id, rx_bufs_used = 0, ring_id;
+	u32 mpdu_rx_bufs_used, npackets = 0;
+	struct ath12k_dp *dp = &ar->ab->dp;
+	struct ath12k_base *ab = ar->ab;
+	void *ring_entry, *mon_dst_srng;
+	struct dp_mon_mpdu *tmp_mpdu;
+	LIST_HEAD(rx_desc_used_list);
+	struct hal_srng *srng;
+
+	ring_id = dp->rxdma_err_dst_ring[mac_id].ring_id;
+	srng = &ab->hal.srng_list[ring_id];
+
+	mon_dst_srng = &ab->hal.srng_list[ring_id];
+
+	spin_lock_bh(&srng->lock);
+
+	ath12k_hal_srng_access_begin(ab, mon_dst_srng);
+
+	ppdu_id = pmon->mon_ppdu_info.ppdu_id;
+	rx_mon_stats = &pmon->rx_mon_stats;
+
+	while ((ring_entry = ath12k_hal_srng_dst_peek(ar->ab, mon_dst_srng))) {
+		struct sk_buff *head_msdu, *tail_msdu;
+
+		head_msdu = NULL;
+		tail_msdu = NULL;
+
+		mpdu_rx_bufs_used = ath12k_dp_rx_mon_mpdu_pop(ar, mac_id, ring_entry,
+							      &head_msdu, &tail_msdu,
+							      &rx_desc_used_list,
+							      &npackets, &ppdu_id);
+
+		rx_bufs_used += mpdu_rx_bufs_used;
+
+		if (mpdu_rx_bufs_used) {
+			dp->mon_dest_ring_stuck_cnt = 0;
+		} else {
+			dp->mon_dest_ring_stuck_cnt++;
+			rx_mon_stats->dest_mon_not_reaped++;
+		}
+
+		if (dp->mon_dest_ring_stuck_cnt > MON_DEST_RING_STUCK_MAX_CNT) {
+			rx_mon_stats->dest_mon_stuck++;
+			ath12k_dbg(ar->ab, ATH12K_DBG_DATA,
+				   "status ring ppdu_id=%d dest ring ppdu_id=%d mon_dest_ring_stuck_cnt=%d dest_mon_not_reaped=%u dest_mon_stuck=%u\n",
+				   pmon->mon_ppdu_info.ppdu_id, ppdu_id,
+				   dp->mon_dest_ring_stuck_cnt,
+				   rx_mon_stats->dest_mon_not_reaped,
+				   rx_mon_stats->dest_mon_stuck);
+			spin_lock_bh(&pmon->mon_lock);
+			pmon->mon_ppdu_info.ppdu_id = ppdu_id;
+			spin_unlock_bh(&pmon->mon_lock);
+			continue;
+		}
+
+		if (ppdu_id != pmon->mon_ppdu_info.ppdu_id) {
+			spin_lock_bh(&pmon->mon_lock);
+			pmon->mon_ppdu_status = DP_PPDU_STATUS_START;
+			spin_unlock_bh(&pmon->mon_lock);
+			ath12k_dbg(ar->ab, ATH12K_DBG_DATA,
+				   "dest_rx: new ppdu_id %x != status ppdu_id %x dest_mon_not_reaped = %u dest_mon_stuck = %u\n",
+				   ppdu_id, pmon->mon_ppdu_info.ppdu_id,
+				   rx_mon_stats->dest_mon_not_reaped,
+				   rx_mon_stats->dest_mon_stuck);
+			break;
+		}
+
+		if (head_msdu && tail_msdu) {
+			tmp_mpdu = kzalloc(sizeof(*tmp_mpdu), GFP_ATOMIC);
+			if (!tmp_mpdu)
+				break;
+
+			tmp_mpdu->head = head_msdu;
+			tmp_mpdu->tail = tail_msdu;
+			tmp_mpdu->err_bitmap = pmon->err_bitmap;
+			tmp_mpdu->decap_format = pmon->decap_format;
+			ath12k_dp_mon_rx_deliver(ar, tmp_mpdu,
+						 &pmon->mon_ppdu_info, napi);
+			rx_mon_stats->dest_mpdu_done++;
+			kfree(tmp_mpdu);
+		}
+
+		ring_entry = ath12k_hal_srng_dst_get_next_entry(ar->ab,
+								mon_dst_srng);
+	}
+	ath12k_hal_srng_access_end(ar->ab, mon_dst_srng);
+
+	spin_unlock_bh(&srng->lock);
+
+	if (rx_bufs_used) {
+		rx_mon_stats->dest_ppdu_done++;
+		ath12k_dp_rx_bufs_replenish(ar->ab,
+					    &dp->rx_refill_buf_ring,
+					    &rx_desc_used_list,
+					    rx_bufs_used);
+	}
+}
+
 static int
 __ath12k_dp_mon_process_ring(struct ath12k *ar, int mac_id,
 			     struct napi_struct *napi, int *budget)
@@ -3987,7 +4341,7 @@ __ath12k_dp_mon_process_ring(struct ath12k *ar, int mac_id,
 		    hal_status == HAL_TLV_STATUS_PPDU_DONE) {
 			rx_mon_stats->status_ppdu_done++;
 			pmon->mon_ppdu_status = DP_PPDU_STATUS_DONE;
-			/*TODO: add mon dest ring processing here.*/
+			ath12k_dp_rx_mon_dest_process(ar, mac_id, *budget, napi);
 			pmon->mon_ppdu_status = DP_PPDU_STATUS_START;
 		}
 
diff --git a/drivers/net/wireless/ath/ath12k/dp_rx.c b/drivers/net/wireless/ath/ath12k/dp_rx.c
index 382d364fb3ff..b3f638af1717 100644
--- a/drivers/net/wireless/ath/ath12k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath12k/dp_rx.c
@@ -194,6 +194,22 @@ static void ath12k_dp_rxdesc_set_msdu_len(struct ath12k_base *ab,
 	ab->hal_rx_ops->rx_desc_set_msdu_len(desc, len);
 }
 
+u32 ath12k_dp_rxdesc_get_ppduid(struct ath12k_base *ab,
+				struct hal_rx_desc *rx_desc)
+{
+	return ab->hal_rx_ops->rx_desc_get_mpdu_ppdu_id(rx_desc);
+}
+
+bool ath12k_dp_rxdesc_mpdu_valid(struct ath12k_base *ab,
+				 struct hal_rx_desc *rx_desc)
+{
+	u32 tlv_tag;
+
+	tlv_tag = ab->hal_rx_ops->rx_desc_get_mpdu_start_tag(rx_desc);
+
+	return tlv_tag == HAL_RX_MPDU_START;
+}
+
 static bool ath12k_dp_rx_h_is_da_mcbc(struct ath12k_base *ab,
 				      struct hal_rx_desc *desc)
 {
@@ -843,9 +859,9 @@ void ath12k_dp_rx_peer_tid_delete(struct ath12k *ar,
 	rx_tid->active = false;
 }
 
-static int ath12k_dp_rx_link_desc_return(struct ath12k_base *ab,
-					 struct ath12k_buffer_addr *buf_addr_info,
-					 enum hal_wbm_rel_bm_act action)
+int ath12k_dp_rx_link_desc_return(struct ath12k_base *ab,
+				  struct ath12k_buffer_addr *buf_addr_info,
+				  enum hal_wbm_rel_bm_act action)
 {
 	struct hal_wbm_release_ring *desc;
 	struct ath12k_dp *dp = &ab->dp;
diff --git a/drivers/net/wireless/ath/ath12k/dp_rx.h b/drivers/net/wireless/ath/ath12k/dp_rx.h
index f5c05f17813b..e971a314bd2d 100644
--- a/drivers/net/wireless/ath/ath12k/dp_rx.h
+++ b/drivers/net/wireless/ath/ath12k/dp_rx.h
@@ -165,5 +165,13 @@ void ath12k_dp_rx_h_fetch_info(struct ath12k_base *ab,  struct hal_rx_desc *rx_d
 			       struct ath12k_dp_rx_info *rx_info);
 
 int ath12k_dp_rx_crypto_mic_len(struct ath12k *ar, enum hal_encrypt_type enctype);
-
+u32 ath12k_dp_rxdesc_get_ppduid(struct ath12k_base *ab,
+				struct hal_rx_desc *rx_desc);
+bool ath12k_dp_rxdesc_mpdu_valid(struct ath12k_base *ab,
+				 struct hal_rx_desc *rx_desc);
+int ath12k_dp_rx_link_desc_return(struct ath12k_base *ab,
+				  struct ath12k_buffer_addr *buf_addr_info,
+				  enum hal_wbm_rel_bm_act action);
+bool ath12k_dp_rxdesc_mpdu_valid(struct ath12k_base *ab,
+				 struct hal_rx_desc *rx_desc);
 #endif /* ATH12K_DP_RX_H */
diff --git a/drivers/net/wireless/ath/ath12k/hal_rx.c b/drivers/net/wireless/ath/ath12k/hal_rx.c
index 837284992cd9..d440dea37e99 100644
--- a/drivers/net/wireless/ath/ath12k/hal_rx.c
+++ b/drivers/net/wireless/ath/ath12k/hal_rx.c
@@ -446,6 +446,86 @@ void ath12k_hal_rx_reo_ent_paddr_get(struct ath12k_base *ab,
 	*cookie = le32_get_bits(buff_addr->info1, BUFFER_ADDR_INFO1_SW_COOKIE);
 }
 
+void ath12k_hal_rx_reo_ent_buf_paddr_get(void *rx_desc, dma_addr_t *paddr,
+					 u32 *sw_cookie,
+					 struct ath12k_buffer_addr **pp_buf_addr,
+					 u8 *rbm, u32 *msdu_cnt)
+{
+	struct hal_reo_entrance_ring *reo_ent_ring =
+		(struct hal_reo_entrance_ring *)rx_desc;
+	struct ath12k_buffer_addr *buf_addr_info;
+	struct rx_mpdu_desc *rx_mpdu_desc_info_details;
+
+	rx_mpdu_desc_info_details =
+			(struct rx_mpdu_desc *)&reo_ent_ring->rx_mpdu_info;
+
+	*msdu_cnt = le32_get_bits(rx_mpdu_desc_info_details->info0,
+				  RX_MPDU_DESC_INFO0_MSDU_COUNT);
+
+	buf_addr_info = (struct ath12k_buffer_addr *)&reo_ent_ring->buf_addr_info;
+
+	*paddr = (((u64)le32_get_bits(buf_addr_info->info1,
+				      BUFFER_ADDR_INFO1_ADDR)) << 32) |
+			le32_get_bits(buf_addr_info->info0,
+				      BUFFER_ADDR_INFO0_ADDR);
+
+	*sw_cookie = le32_get_bits(buf_addr_info->info1,
+				   BUFFER_ADDR_INFO1_SW_COOKIE);
+	*rbm = le32_get_bits(buf_addr_info->info1,
+			     BUFFER_ADDR_INFO1_RET_BUF_MGR);
+
+	*pp_buf_addr = (void *)buf_addr_info;
+}
+
+void ath12k_hal_rx_msdu_list_get(struct ath12k *ar,
+				 struct hal_rx_msdu_link *link_desc,
+				 struct hal_rx_msdu_list *msdu_list,
+				 u16 *num_msdus)
+{
+	struct hal_rx_msdu_details *msdu_details = NULL;
+	struct rx_msdu_desc *msdu_desc_info = NULL;
+	u32 last = 0, first = 0;
+	u8 tmp = 0;
+	int i;
+
+	last = u32_encode_bits(last, RX_MSDU_DESC_INFO0_LAST_MSDU_IN_MPDU);
+	first = u32_encode_bits(first, RX_MSDU_DESC_INFO0_FIRST_MSDU_IN_MPDU);
+	msdu_details = &link_desc->msdu_link[0];
+
+	for (i = 0; i < HAL_RX_NUM_MSDU_DESC; i++) {
+		if (!i && le32_get_bits(msdu_details[i].buf_addr_info.info0,
+					BUFFER_ADDR_INFO0_ADDR) == 0)
+			break;
+		if (le32_get_bits(msdu_details[i].buf_addr_info.info0,
+				  BUFFER_ADDR_INFO0_ADDR) == 0) {
+			msdu_desc_info = &msdu_details[i - 1].rx_msdu_info;
+			msdu_desc_info->info0 |= cpu_to_le32(last);
+			break;
+		}
+		msdu_desc_info = &msdu_details[i].rx_msdu_info;
+
+		if (!i)
+			msdu_desc_info->info0 |= cpu_to_le32(first);
+		else if (i == (HAL_RX_NUM_MSDU_DESC - 1))
+			msdu_desc_info->info0 |= cpu_to_le32(last);
+		msdu_list->msdu_info[i].msdu_flags = le32_to_cpu(msdu_desc_info->info0);
+		msdu_list->msdu_info[i].msdu_len =
+			 HAL_RX_MSDU_PKT_LENGTH_GET(msdu_desc_info->info0);
+		msdu_list->sw_cookie[i] =
+			le32_get_bits(msdu_details[i].buf_addr_info.info1,
+				      BUFFER_ADDR_INFO1_SW_COOKIE);
+		tmp = le32_get_bits(msdu_details[i].buf_addr_info.info1,
+				    BUFFER_ADDR_INFO1_RET_BUF_MGR);
+		msdu_list->paddr[i] =
+			((u64)(le32_get_bits(msdu_details[i].buf_addr_info.info1,
+					     BUFFER_ADDR_INFO1_ADDR)) << 32) |
+			le32_get_bits(msdu_details[i].buf_addr_info.info0,
+				      BUFFER_ADDR_INFO0_ADDR);
+		msdu_list->rbm[i] = tmp;
+	}
+	*num_msdus = i;
+}
+
 void ath12k_hal_rx_msdu_link_desc_set(struct ath12k_base *ab,
 				      struct hal_wbm_release_ring *desc,
 				      struct ath12k_buffer_addr *buf_addr_info,
diff --git a/drivers/net/wireless/ath/ath12k/hal_rx.h b/drivers/net/wireless/ath/ath12k/hal_rx.h
index ef8bda3c0fc2..a3ab588aae19 100644
--- a/drivers/net/wireless/ath/ath12k/hal_rx.h
+++ b/drivers/net/wireless/ath/ath12k/hal_rx.h
@@ -538,6 +538,7 @@ struct hal_rx_msdu_desc_info {
 #define HAL_RX_NUM_MSDU_DESC 6
 struct hal_rx_msdu_list {
 	struct hal_rx_msdu_desc_info msdu_info[HAL_RX_NUM_MSDU_DESC];
+	u64 paddr[HAL_RX_NUM_MSDU_DESC];
 	u32 sw_cookie[HAL_RX_NUM_MSDU_DESC];
 	u8 rbm[HAL_RX_NUM_MSDU_DESC];
 };
@@ -1157,5 +1158,12 @@ int ath12k_hal_wbm_desc_parse_err(struct ath12k_base *ab, void *desc,
 void ath12k_hal_rx_reo_ent_paddr_get(struct ath12k_base *ab,
 				     struct ath12k_buffer_addr *buff_addr,
 				     dma_addr_t *paddr, u32 *cookie);
+void ath12k_hal_rx_reo_ent_buf_paddr_get(void *rx_desc, dma_addr_t *paddr, u32 *sw_cookie,
+					 struct ath12k_buffer_addr **pp_buf_addr,
+					 u8 *rbm, u32 *msdu_cnt);
+void ath12k_hal_rx_msdu_list_get(struct ath12k *ar,
+				 struct hal_rx_msdu_link *link_desc,
+				 struct hal_rx_msdu_list *msdu_list,
+				 u16 *num_msdus);
 
 #endif
-- 
2.34.1


