Return-Path: <linux-wireless+bounces-28400-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 43B00C1E5BD
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Oct 2025 05:33:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C2471891B78
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Oct 2025 04:33:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B45E32BF49;
	Thu, 30 Oct 2025 04:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NkyBkCZZ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GnePhQvv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2F4F322DD6
	for <linux-wireless@vger.kernel.org>; Thu, 30 Oct 2025 04:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761798722; cv=none; b=UudnVlxeB9jb5+C8wbI3mA5LwmzhnVwPRAVlmmGqrh2od/2bY4PjlSgbpeyMg5upBQlAMWe7AGSiSjPPBzzajnf4dvZYSRxTxt9LYVaNzaPPRejTIu4ML2XUTHJSCbd00oK6yHeqfmMaVbHrPwFEIrU2H+ExI0CIKXQfxWYamx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761798722; c=relaxed/simple;
	bh=gx3jFNFiNHV4CqY4I40KFU+Nh9bVWD2CmnD6P5zNR/c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QU3poONDydCD/XDZ5O+gm7KrSo3JJTFVe6mXzGGBAJvGjnW98cd6azDudMJGQhtH+GKs69LEsFwLcqvBZBV/Og/080WRkPfRWrbG+Zi/hxlGnEJ69l9tqAF3rs24PfxIksWFDLRDXXZTLHas3sx00hrla7R9Y9JA1ja6UdhEnuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NkyBkCZZ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=GnePhQvv; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59TKVKNR1501790
	for <linux-wireless@vger.kernel.org>; Thu, 30 Oct 2025 04:31:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=dWqC+Om9px2
	qP7N766OVXi+Jo21nhKLxdACoMyRB9aI=; b=NkyBkCZZla5nydhaW6aw5wDejdv
	Jtw7vlnQ7PT3ylEnxDkKZ8a+OY23885wQC8ZcX6t+YgIvraGbpSFP51hdhjObwwq
	Yo/qJk/veAA4YhxAGoNDoXRp5YCd5VGK9kbQ/SYWfjRrMVIF2LntHXYmJ7g3tAV7
	D0SItKldKiidkCPDwNylZS52exw6zxKfRWfKcYhCJXfv0mbwMOse/yyOmg4ngq/1
	5rM+AbViFaVQtvu5PIpr4KXjUvuaLOjIcXO/akCFjKBoWmz250H+WIak2Ot/vSN/
	O2igp4x8oLqPDiYR/H77z2gpFROhVXDrMGYZaWAPIY/d+b43dwo1szLdWlw==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a3t1js5qg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 30 Oct 2025 04:31:59 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b6d0014d416so402864a12.1
        for <linux-wireless@vger.kernel.org>; Wed, 29 Oct 2025 21:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761798718; x=1762403518; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dWqC+Om9px2qP7N766OVXi+Jo21nhKLxdACoMyRB9aI=;
        b=GnePhQvvvu30YYo1195X8ZKsNLwlxzgoyqH8plISGuky2cWrK22IgtfJK5INUkNKHy
         Tp77k2EtGtlaUqDHKKsCyv5D83XAvl+RVKCT4yl3oyNv/jlUMG9Rbf9REvKYc69Abzo7
         puSIXcDh2hqy6apGozomJMlSpniA7sG5PTvNR/5QW6hkssC3CUgOCYIcf4kN/lDV6iTo
         bW5I3oT87EcNFchF8f5eSKvvCTf3mSYRqt6hQBdOEjQU1L5W8YedfFNDFyQUxns3l94y
         iWUvpwzYNTPeE5QO9GF3ZgCdRxhOkYvDxdwv3p85LL97/EE6fv3Zj+sqDxidJMUGfAMq
         fv0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761798718; x=1762403518;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dWqC+Om9px2qP7N766OVXi+Jo21nhKLxdACoMyRB9aI=;
        b=cRKgIW8+haINA2l1xXAnoXo1FAKGNRR5f30JQQLhN0sggJCmo5F84opxkYIGzXMj21
         b1DR+4TfC3yaQTwvSmxvZab23LMdjj/XKWKzWmNfFOcxrk8lMaAbelMn3PVKORmPwom7
         0I7AUT36y6kV38F10ou7gKNWM70Q1YHXr3CKXJNUlfe8pMzL8AzUHfHWHt+W9Wd1aNPv
         xLZT5dlHelasic451FAcEpyQ8wdiag29XwNgfLl0WPs9ONlHPBgJAG1b9nL8Q4OOcPHW
         N2DRm+Z6w8yf2FajUITqrph2tayH/khrRJafEtE7wkCU29EOYFgNDKXT3n1D1bj7v1WM
         5AFw==
X-Forwarded-Encrypted: i=1; AJvYcCW0QLTpaxfxFGDXylVoT9IFqtQ1/vBZql+Gwvim2a88OZoj38hGcxDya7MxYDr820ur0q1xuVF4bkwbTkq3jg==@vger.kernel.org
X-Gm-Message-State: AOJu0YykRcR12+Hrz7R4UdjkntoSx0cB2AkyYR8SA1wkaDhKdUN/8nDS
	gs9q8Zx31y61vscW4VVkkkznW1tLj5te1FCAKN4uYIzP1Vp1bJdfzTIfm7Y/GWIi/ppgjueK2ox
	ljvYWpZ+Z0NGoD1YurdBxxT4aX3AEAZ4pBurwxmhJcdF0/dY6+J4nm6hUZTxowc9ulyDnFzRaBp
	20aXDY
X-Gm-Gg: ASbGnctDgEX6RdxS7LogScM5CPDzR7L6b4uOgUCnUnWTTlbrEMv4M1S7cJyT7gHvJtJ
	x28efpzZF5mwtfBIHMTXNG1Ky7MefUZ6+fSQN1yacZn24O/IKXHVshOLWRbs1TuTraX4omF1ql6
	23Gxt3dd4vgqx+bvpUC7SaFKYpVeQbLHBlJorVrjGVMIcw3rC79nq5KIcXWkkX7/3dwUFnpXkKK
	o7tH2fYHO2nbpFJzzo2z+zDFZQ7F8YB56GaRcKeevh/Ijv76hJjgNzK4jY5srm9Nkkxj+JnNNLK
	gUMxKueQOPnU0kuhHiJxijv0BnzOh+ktMT/OnjU5LQsnnPm5CBrLBIfLYVwYfmDVyeUiuN20Sj2
	uetbT9+0HU32mpcdobhmjK6dgOF2ql6qL7feXOx0KoP+4
X-Received: by 2002:a05:6a20:914b:b0:342:77fa:4aa0 with SMTP id adf61e73a8af0-3465422a456mr6900674637.31.1761798718199;
        Wed, 29 Oct 2025 21:31:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGteZ8vB1lYWtSpT4zx1cwMAy2LGBxNeF+DLnXOVeYkh4WtzeOj8LbLbKjdIMbm88XEis/RLQ==
X-Received: by 2002:a05:6a20:914b:b0:342:77fa:4aa0 with SMTP id adf61e73a8af0-3465422a456mr6900633637.31.1761798717602;
        Wed, 29 Oct 2025 21:31:57 -0700 (PDT)
Received: from hu-yuzha-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a41409e456sm16912161b3a.71.2025.10.29.21.31.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 21:31:57 -0700 (PDT)
From: "Yu Zhang(Yuriy)" <yu.zhang@oss.qualcomm.com>
To: jjohnson@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath11k@lists.infradead.org
Subject: [PATCH ath-next 6/6] wifi: ath11k: Register handler for CFR capture event
Date: Wed, 29 Oct 2025 21:31:50 -0700
Message-Id: <20251030043150.3905086-7-yu.zhang@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251030043150.3905086-1-yu.zhang@oss.qualcomm.com>
References: <20251030043150.3905086-1-yu.zhang@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: WnbmC5hnQtKI20fv1TnucpGDrxjRIEV3
X-Proofpoint-ORIG-GUID: WnbmC5hnQtKI20fv1TnucpGDrxjRIEV3
X-Authority-Analysis: v=2.4 cv=M/lA6iws c=1 sm=1 tr=0 ts=6902ea3f cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=RXpQw9b9vDifZkLeuRoA:9
 a=_Vgx9l1VpLgwpw_dHYaR:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMwMDAzNCBTYWx0ZWRfX5DHR5y7YLrcm
 WU3Vju4qebNSZaloDpas/l3ybEKq+mHDrf7ldUyWq4h563ERNzfbZ/1XZ5+SAhsUtAxcuUK7jNY
 yF4yYsfgcTgnvbOLiLBfQc5OXjzS1lU4mXr0zH0x6jJXLhuqyHdgdpjGpZ1UFIf8yEA6DSHNeFg
 3IeAH8gDck+/x1ilylYYP1j/XbrrcvDqT9A8Q163uDioo/xpZKyYK/3Kmfq1ZgwfR9hMTsAydPd
 VP1PhFw3SWRSHcfqcboOUXumEZFxWZLSrNjyD5VOptmJxJKaNrBlZlkEeX99RG7m9nwJEeLsjfc
 naV9QXkbQi+h5VbDt5tbaF5qoevGlhaQlGpcvaT+U/3YUKg1JUOSZ6gMBW/CRP9nWvJRJZAMaWe
 8FetCK2LjeLxhAoKep3tuzVHKIaOYQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-30_01,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 spamscore=0 clxscore=1015 adultscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2510300034

From: Venkateswara Naralasetty <quic_vnaralas@quicinc.com>

Firmware sends CFR meta data through the WMI event
WMI_PEER_CFR_CAPTURE_EVENT. Parse the meta data coming from the firmware
and invoke correlate_and_relay function to correlate the CFR meta data
with the CFR payload coming from the other WMI event
WMI_PDEV_DMA_RING_BUF_RELEASE_EVENT.

Release the buffer to user space once correlate and relay return
success.

Tested-on: IPQ8074 hw2.0 PCI IPQ8074 WLAN.HK.2.5.0.1-00991-QCAHKSWPL_SILICONZ-1
Tested-on: WCN6855 hw2.1 PCI WLAN.HSP.1.1-04685-QCAHSPSWPL_V1_V2_SILICONZ_IOE-1

Signed-off-by: Venkateswara Naralasetty <quic_vnaralas@quicinc.com>
Co-developed-by: Yu Zhang(Yuriy) <yu.zhang@oss.qualcomm.com>
Signed-off-by: Yu Zhang(Yuriy) <yu.zhang@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath11k/cfr.c | 145 ++++++++++++++++++++++++++
 drivers/net/wireless/ath/ath11k/cfr.h |  62 ++++++++++-
 drivers/net/wireless/ath/ath11k/wmi.c |  90 ++++++++++++++++
 drivers/net/wireless/ath/ath11k/wmi.h |  44 ++++++++
 4 files changed, 340 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath11k/cfr.c b/drivers/net/wireless/ath/ath11k/cfr.c
index e8a976d64733..61eeb02af6c5 100644
--- a/drivers/net/wireless/ath/ath11k/cfr.c
+++ b/drivers/net/wireless/ath/ath11k/cfr.c
@@ -247,6 +247,151 @@ static int ath11k_cfr_process_data(struct ath11k *ar,
 	return status;
 }
 
+static void ath11k_cfr_fill_hdr_info(struct ath11k *ar,
+				     struct ath11k_csi_cfr_header *header,
+				     struct ath11k_cfr_peer_tx_param *params)
+{
+	header->cfr_metadata_version = ATH11K_CFR_META_VERSION_4;
+	header->cfr_data_version = ATH11K_CFR_DATA_VERSION_1;
+	header->cfr_metadata_len = sizeof(struct cfr_metadata);
+	header->chip_type = ar->ab->hw_rev;
+	header->meta_data.status = FIELD_GET(WMI_CFR_PEER_CAPTURE_STATUS,
+					     params->status);
+	header->meta_data.capture_bw = params->bandwidth;
+	header->meta_data.phy_mode = params->phy_mode;
+	header->meta_data.prim20_chan = params->primary_20mhz_chan;
+	header->meta_data.center_freq1 = params->band_center_freq1;
+	header->meta_data.center_freq2 = params->band_center_freq2;
+
+	/* Currently CFR data is captured on ACK of a Qos NULL frame.
+	 * For 20 MHz, ACK is Legacy and for 40/80/160, ACK is DUP Legacy.
+	 */
+	header->meta_data.capture_mode = params->bandwidth ?
+		ATH11K_CFR_CAPTURE_DUP_LEGACY_ACK : ATH11K_CFR_CAPTURE_LEGACY_ACK;
+	header->meta_data.capture_type = params->capture_method;
+	header->meta_data.num_rx_chain = ar->num_rx_chains;
+	header->meta_data.sts_count = params->spatial_streams;
+	header->meta_data.timestamp = params->timestamp_us;
+	ether_addr_copy(header->meta_data.peer_addr, params->peer_mac_addr);
+	memcpy(header->meta_data.chain_rssi, params->chain_rssi,
+	       sizeof(params->chain_rssi));
+	memcpy(header->meta_data.chain_phase, params->chain_phase,
+	       sizeof(params->chain_phase));
+	memcpy(header->meta_data.agc_gain, params->agc_gain,
+	       sizeof(params->agc_gain));
+}
+
+int ath11k_process_cfr_capture_event(struct ath11k_base *ab,
+				     struct ath11k_cfr_peer_tx_param *params)
+{
+	struct ath11k_look_up_table *lut = NULL;
+	u32 end_magic = ATH11K_CFR_END_MAGIC;
+	struct ath11k_csi_cfr_header *header;
+	struct ath11k_dbring_element *buff;
+	struct ath11k_vif *arvif;
+	struct ath11k_cfr *cfr;
+	dma_addr_t buf_addr;
+	struct ath11k *ar;
+	u8 tx_status;
+	int status;
+	int i;
+
+	rcu_read_lock();
+	arvif = ath11k_mac_get_arvif_by_vdev_id(ab, params->vdev_id);
+	if (!arvif) {
+		rcu_read_unlock();
+		ath11k_warn(ab, "Failed to get arvif for vdev id %d\n",
+			    params->vdev_id);
+		return -ENOENT;
+	}
+
+	ar = arvif->ar;
+	cfr = &ar->cfr;
+	rcu_read_unlock();
+
+	if (WMI_CFR_CAPTURE_STATUS_PEER_PS & params->status) {
+		ath11k_warn(ab, "CFR capture failed as peer %pM is in powersave",
+			    params->peer_mac_addr);
+		return -EINVAL;
+	}
+
+	if (!(WMI_CFR_PEER_CAPTURE_STATUS & params->status)) {
+		ath11k_warn(ab, "CFR capture failed for the peer : %pM",
+			    params->peer_mac_addr);
+		cfr->tx_peer_status_cfr_fail++;
+		return -EINVAL;
+	}
+
+	tx_status = FIELD_GET(WMI_CFR_FRAME_TX_STATUS, params->status);
+	if (tx_status != WMI_FRAME_TX_STATUS_OK) {
+		ath11k_warn(ab, "WMI tx status %d for the peer %pM",
+			    tx_status, params->peer_mac_addr);
+		cfr->tx_evt_status_cfr_fail++;
+		return -EINVAL;
+	}
+
+	buf_addr = (((u64)FIELD_GET(WMI_CFR_CORRELATION_INFO2_BUF_ADDR_HIGH,
+				    params->correlation_info_2)) << 32) |
+		   params->correlation_info_1;
+
+	spin_lock_bh(&cfr->lut_lock);
+
+	if (!cfr->lut) {
+		spin_unlock_bh(&cfr->lut_lock);
+		return -EINVAL;
+	}
+
+	for (i = 0; i < cfr->lut_num; i++) {
+		struct ath11k_look_up_table *temp = &cfr->lut[i];
+
+		if (temp->dbr_address == buf_addr) {
+			lut = &cfr->lut[i];
+			break;
+		}
+	}
+
+	if (!lut) {
+		spin_unlock_bh(&cfr->lut_lock);
+		ath11k_warn(ab, "lut failure to process tx event\n");
+		cfr->tx_dbr_lookup_fail++;
+		return -EINVAL;
+	}
+
+	lut->tx_ppdu_id = FIELD_GET(WMI_CFR_CORRELATION_INFO2_PPDU_ID,
+				    params->correlation_info_2);
+	lut->txrx_tstamp = jiffies;
+
+	header = &lut->header;
+	header->start_magic_num = ATH11K_CFR_START_MAGIC;
+	header->vendorid = VENDOR_QCA;
+	header->platform_type = PLATFORM_TYPE_ARM;
+
+	ath11k_cfr_fill_hdr_info(ar, header, params);
+
+	status = ath11k_cfr_correlate_and_relay(ar, lut,
+						ATH11K_CORRELATE_TX_EVENT);
+	if (status == ATH11K_CORRELATE_STATUS_RELEASE) {
+		ath11k_dbg(ab, ATH11K_DBG_CFR,
+			   "Releasing CFR data to user space");
+		ath11k_cfr_rfs_write(ar, &lut->header,
+				     sizeof(struct ath11k_csi_cfr_header),
+				     lut->data, lut->data_len,
+				     &end_magic, sizeof(u32));
+		buff = lut->buff;
+		ath11k_cfr_release_lut_entry(lut);
+
+		ath11k_dbring_bufs_replenish(ar, &cfr->rx_ring, buff,
+					     WMI_DIRECT_BUF_CFR);
+	} else if (status == ATH11K_CORRELATE_STATUS_HOLD) {
+		ath11k_dbg(ab, ATH11K_DBG_CFR,
+			   "dbr event is not yet received holding buf\n");
+	}
+
+	spin_unlock_bh(&cfr->lut_lock);
+
+	return 0;
+}
+
 /* Helper function to check whether the given peer mac address
  * is in unassociated peer pool or not.
  */
diff --git a/drivers/net/wireless/ath/ath11k/cfr.h b/drivers/net/wireless/ath/ath11k/cfr.h
index e8b5c23b15cc..0129f9a924e2 100644
--- a/drivers/net/wireless/ath/ath11k/cfr.h
+++ b/drivers/net/wireless/ath/ath11k/cfr.h
@@ -27,8 +27,37 @@ enum ath11k_cfr_correlate_event_type {
 struct ath11k_sta;
 struct ath11k_per_peer_cfr_capture;
 
+#define ATH11K_CFR_START_MAGIC 0xDEADBEAF
 #define ATH11K_CFR_END_MAGIC 0xBEAFDEAD
 
+#define VENDOR_QCA 0x8cfdf0
+#define PLATFORM_TYPE_ARM 2
+
+enum ath11k_cfr_meta_version {
+	ATH11K_CFR_META_VERSION_NONE,
+	ATH11K_CFR_META_VERSION_1,
+	ATH11K_CFR_META_VERSION_2,
+	ATH11K_CFR_META_VERSION_3,
+	ATH11K_CFR_META_VERSION_4,
+	ATH11K_CFR_META_VERSION_MAX = 0xFF,
+};
+
+enum ath11k_cfr_data_version {
+	ATH11K_CFR_DATA_VERSION_NONE,
+	ATH11K_CFR_DATA_VERSION_1,
+	ATH11K_CFR_DATA_VERSION_MAX = 0xFF,
+};
+
+enum ath11k_cfr_capture_ack_mode {
+	ATH11K_CFR_CAPTURE_LEGACY_ACK,
+	ATH11K_CFR_CAPTURE_DUP_LEGACY_ACK,
+	ATH11K_CFR_CAPTURE_HT_ACK,
+	ATH11K_CFR_CAPTURE_VHT_ACK,
+
+	/*Always keep this at last*/
+	ATH11K_CFR_CAPTURE_INVALID_ACK
+};
+
 enum ath11k_cfr_correlate_status {
 	ATH11K_CORRELATE_STATUS_RELEASE,
 	ATH11K_CORRELATE_STATUS_HOLD,
@@ -41,6 +70,28 @@ enum ath11k_cfr_preamble_type {
 	ATH11K_CFR_PREAMBLE_TYPE_VHT,
 };
 
+struct ath11k_cfr_peer_tx_param {
+	u32 capture_method;
+	u32 vdev_id;
+	u8 peer_mac_addr[ETH_ALEN];
+	u32 primary_20mhz_chan;
+	u32 bandwidth;
+	u32 phy_mode;
+	u32 band_center_freq1;
+	u32 band_center_freq2;
+	u32 spatial_streams;
+	u32 correlation_info_1;
+	u32 correlation_info_2;
+	u32 status;
+	u32 timestamp_us;
+	u32 counter;
+	u32 chain_rssi[WMI_MAX_CHAINS];
+	u16 chain_phase[WMI_MAX_CHAINS];
+	u32 cfo_measurement;
+	u8 agc_gain[HOST_MAX_CHAINS];
+	u32 rx_start_ts;
+};
+
 struct cfr_metadata {
 	u8 peer_addr[ETH_ALEN];
 	u8 status;
@@ -70,7 +121,7 @@ struct ath11k_csi_cfr_header {
 	u8 cfr_data_version;
 	u8 chip_type;
 	u8 platform_type;
-	u32 reserved;
+	u32 cfr_metadata_len;
 	struct cfr_metadata meta_data;
 } __packed;
 
@@ -180,6 +231,8 @@ int ath11k_cfr_send_peer_cfr_capture_cmd(struct ath11k *ar,
 					 const u8 *peer_mac);
 struct ath11k_dbring *ath11k_cfr_get_dbring(struct ath11k *ar);
 void ath11k_cfr_release_lut_entry(struct ath11k_look_up_table *lut);
+int ath11k_process_cfr_capture_event(struct ath11k_base *ab,
+				     struct ath11k_cfr_peer_tx_param *params);
 
 #else
 static inline int ath11k_cfr_init(struct ath11k_base *ab)
@@ -237,5 +290,12 @@ struct ath11k_dbring *ath11k_cfr_get_dbring(struct ath11k *ar)
 {
 	return NULL;
 }
+
+static inline
+int ath11k_process_cfr_capture_event(struct ath11k_base *ab,
+				     struct ath11k_cfr_peer_tx_param *params)
+{
+	return 0;
+}
 #endif /* CONFIG_ATH11K_CFR */
 #endif /* ATH11K_CFR_H */
diff --git a/drivers/net/wireless/ath/ath11k/wmi.c b/drivers/net/wireless/ath/ath11k/wmi.c
index 0b4cc943c290..65f084524855 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.c
+++ b/drivers/net/wireless/ath/ath11k/wmi.c
@@ -8802,6 +8802,93 @@ static void ath11k_wmi_p2p_noa_event(struct ath11k_base *ab,
 	kfree(tb);
 }
 
+static void ath11k_wmi_tlv_cfr_capture_event_fixed_param(const void *ptr,
+							 void *data)
+{
+	struct ath11k_cfr_peer_tx_param *tx_params = data;
+	const struct ath11k_wmi_cfr_peer_tx_event_param *params = ptr;
+
+	tx_params->capture_method = params->capture_method;
+	tx_params->vdev_id = params->vdev_id;
+	ether_addr_copy(tx_params->peer_mac_addr, params->mac_addr.addr);
+	tx_params->primary_20mhz_chan = params->chan_mhz;
+	tx_params->bandwidth = params->bandwidth;
+	tx_params->phy_mode = params->phy_mode;
+	tx_params->band_center_freq1 = params->band_center_freq1;
+	tx_params->band_center_freq2 = params->band_center_freq2;
+	tx_params->spatial_streams = params->sts_count;
+	tx_params->correlation_info_1 = params->correlation_info_1;
+	tx_params->correlation_info_2 = params->correlation_info_2;
+	tx_params->status = params->status;
+	tx_params->timestamp_us = params->timestamp_us;
+	tx_params->counter = params->counter;
+	tx_params->rx_start_ts = params->rx_start_ts;
+
+	memcpy(tx_params->chain_rssi, params->chain_rssi,
+	       sizeof(tx_params->chain_rssi));
+
+	if (WMI_CFR_CFO_MEASUREMENT_VALID & params->cfo_measurement)
+		tx_params->cfo_measurement = FIELD_GET(WMI_CFR_CFO_MEASUREMENT_RAW_DATA,
+						       params->cfo_measurement);
+}
+
+static void ath11k_wmi_tlv_cfr_capture_phase_fixed_param(const void *ptr,
+							 void *data)
+{
+	struct ath11k_cfr_peer_tx_param *tx_params = data;
+	const struct ath11k_wmi_cfr_peer_tx_event_phase_param *params = ptr;
+	int i;
+
+	for (i = 0; i < WMI_MAX_CHAINS; i++) {
+		tx_params->chain_phase[i] = params->chain_phase[i];
+		tx_params->agc_gain[i] = params->agc_gain[i];
+	}
+}
+
+static int ath11k_wmi_tlv_cfr_capture_evt_parse(struct ath11k_base *ab,
+						u16 tag, u16 len,
+						const void *ptr, void *data)
+{
+	switch (tag) {
+	case WMI_TAG_PEER_CFR_CAPTURE_EVENT:
+		ath11k_wmi_tlv_cfr_capture_event_fixed_param(ptr, data);
+		break;
+	case WMI_TAG_CFR_CAPTURE_PHASE_PARAM:
+		ath11k_wmi_tlv_cfr_capture_phase_fixed_param(ptr, data);
+		break;
+	default:
+		ath11k_warn(ab, "Invalid tag received tag %d len %d\n",
+			    tag, len);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static void ath11k_wmi_parse_cfr_capture_event(struct ath11k_base *ab,
+					       struct sk_buff *skb)
+{
+	struct ath11k_cfr_peer_tx_param params = {};
+	int ret;
+
+	ath11k_dbg_dump(ab, ATH11K_DBG_CFR_DUMP, "cfr_dump:", "",
+			skb->data, skb->len);
+
+	ret = ath11k_wmi_tlv_iter(ab, skb->data, skb->len,
+				  ath11k_wmi_tlv_cfr_capture_evt_parse,
+				  &params);
+	if (ret) {
+		ath11k_warn(ab, "failed to parse cfr capture event tlv %d\n",
+			    ret);
+		return;
+	}
+
+	ret = ath11k_process_cfr_capture_event(ab, &params);
+	if (ret)
+		ath11k_dbg(ab, ATH11K_DBG_CFR,
+			   "failed to process cfr capture ret = %d\n", ret);
+}
+
 static void ath11k_wmi_tlv_op_rx(struct ath11k_base *ab, struct sk_buff *skb)
 {
 	struct wmi_cmd_hdr *cmd_hdr;
@@ -8932,6 +9019,9 @@ static void ath11k_wmi_tlv_op_rx(struct ath11k_base *ab, struct sk_buff *skb)
 	case WMI_P2P_NOA_EVENTID:
 		ath11k_wmi_p2p_noa_event(ab, skb);
 		break;
+	case WMI_PEER_CFR_CAPTURE_EVENTID:
+		ath11k_wmi_parse_cfr_capture_event(ab, skb);
+		break;
 	default:
 		ath11k_dbg(ab, ATH11K_DBG_WMI, "unsupported event id 0x%x\n", id);
 		break;
diff --git a/drivers/net/wireless/ath/ath11k/wmi.h b/drivers/net/wireless/ath/ath11k/wmi.h
index afc78fa4389b..baed501b640b 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.h
+++ b/drivers/net/wireless/ath/ath11k/wmi.h
@@ -1889,6 +1889,8 @@ enum wmi_tlv_tag {
 	WMI_TAG_NDP_EVENT,
 	WMI_TAG_PDEV_PEER_PKTLOG_FILTER_CMD = 0x301,
 	WMI_TAG_PDEV_PEER_PKTLOG_FILTER_INFO,
+	WMI_TAG_PEER_CFR_CAPTURE_EVENT = 0x317,
+	WMI_TAG_CFR_CAPTURE_PHASE_PARAM = 0x33b,
 	WMI_TAG_FILS_DISCOVERY_TMPL_CMD = 0x344,
 	WMI_TAG_PDEV_SRG_BSS_COLOR_BITMAP_CMD = 0x37b,
 	WMI_TAG_PDEV_SRG_PARTIAL_BSSID_BITMAP_CMD,
@@ -4237,6 +4239,48 @@ enum ath11k_wmi_cfr_capture_method {
 	WMI_CFR_CAPTURE_METHOD_MAX,
 };
 
+#define WMI_CFR_FRAME_TX_STATUS GENMASK(1, 0)
+#define WMI_CFR_CAPTURE_STATUS_PEER_PS BIT(30)
+#define WMI_CFR_PEER_CAPTURE_STATUS BIT(31)
+
+#define WMI_CFR_CORRELATION_INFO2_BUF_ADDR_HIGH GENMASK(3, 0)
+#define WMI_CFR_CORRELATION_INFO2_PPDU_ID GENMASK(31, 16)
+
+#define WMI_CFR_CFO_MEASUREMENT_VALID BIT(0)
+#define WMI_CFR_CFO_MEASUREMENT_RAW_DATA GENMASK(14, 1)
+
+struct ath11k_wmi_cfr_peer_tx_event_param {
+	u32 capture_method;
+	u32 vdev_id;
+	struct wmi_mac_addr mac_addr;
+	u32 chan_mhz;
+	u32 bandwidth;
+	u32 phy_mode;
+	u32 band_center_freq1;
+	u32 band_center_freq2;
+	u32 sts_count;
+	u32 correlation_info_1;
+	u32 correlation_info_2;
+	u32 status;
+	u32 timestamp_us;
+	u32 counter;
+	u32 chain_rssi[WMI_MAX_CHAINS];
+	u32 cfo_measurement;
+	u32 rx_start_ts;
+} __packed;
+
+struct ath11k_wmi_cfr_peer_tx_event_phase_param {
+	u32 chain_phase[WMI_MAX_CHAINS];
+	u8 agc_gain[WMI_MAX_CHAINS];
+} __packed;
+
+enum ath11k_wmi_frame_tx_status {
+	WMI_FRAME_TX_STATUS_OK,
+	WMI_FRAME_TX_STATUS_XRETRY,
+	WMI_FRAME_TX_STATUS_DROP,
+	WMI_FRAME_TX_STATUS_FILTERED,
+};
+
 struct wmi_peer_cfr_capture_conf_arg {
 	enum ath11k_wmi_cfr_capture_bw bw;
 	enum ath11k_wmi_cfr_capture_method method;
-- 
2.34.1


