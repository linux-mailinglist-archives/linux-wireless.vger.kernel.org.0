Return-Path: <linux-wireless+bounces-21777-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B4D0A94B11
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Apr 2025 04:36:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D087C18871D5
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Apr 2025 02:36:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0283F44C63;
	Mon, 21 Apr 2025 02:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hxmy0TNm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56CEB2571D8
	for <linux-wireless@vger.kernel.org>; Mon, 21 Apr 2025 02:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745202944; cv=none; b=ddUT8DEY8j3xuu3W6+Sb2O4gh8SpVlJnXd6YWGZ8st8/QUdUUM/v9m9bfYReueDn9aQi0oPEiF3ckMAgTSfJDZ5M2KY4yvykxKTKK70DwRWQFnO4Br+2NtVppxaBaKfZwvkqGnV+RCetQp6sWBt0EIUZoQv/3o7FJg8EG4SfORs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745202944; c=relaxed/simple;
	bh=NDS5KIp4JbiQJbMDUBU+LRiTZZHwICPTJbbejXyWZR0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RM0xj46pLtGqt9WmBzB0Qe0DLin8oHAq1j6ZYfYnHJDqFuRDzaUb+ZAfuRDT7ZzGCytnue0oxMNC4QJp3Jy9bqJDLqMvSwYE7hop+mUG+fSqQciZbatQNKTKpkoKvse8PeSbn5veg4QwP2TXEve5aG0jCMabPIdAEk5EZ2CB7VM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hxmy0TNm; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53KMo9oJ031101
	for <linux-wireless@vger.kernel.org>; Mon, 21 Apr 2025 02:35:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=nrfVX/gBeLQ
	iUTHGX4OfY5iM7SyOYw04n25h+TZF3B4=; b=hxmy0TNmSg+Ymc+ve17EOuZcwLz
	u8JByzuQWxbuLNs2CzZQxOWNDk5brWrGYuuZOt+EF3KnYk5NUgz8lICBSWOub2yV
	CxdwBF+8utVpCV1POVI92z3VMsV+5z/2GLlchDJgM6pr4XMv5U+Vde3BGdKP5+hH
	k/Jb2YQQ+7p6oewkHzGwJIGw9OdtMqm/c8hUTT7ifo7w9xKkgf1+LrubWw3Owsnp
	fgjgdWuistD5iYoyFj8vNRSbBkdtcvsIEfgb/7iLeUP2LIwc0O1dK3Q7F5U+m8dM
	GnbsoXnQCISzHxb89nWGq0XGzomIpoJ0CDUDTbYTz2leI4oQZ/8xXiInVxw==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4644kjaq31-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 21 Apr 2025 02:35:42 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2ff605a7a43so5306708a91.3
        for <linux-wireless@vger.kernel.org>; Sun, 20 Apr 2025 19:35:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745202921; x=1745807721;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nrfVX/gBeLQiUTHGX4OfY5iM7SyOYw04n25h+TZF3B4=;
        b=TyGqmF9FepSFsBtalnJg/Yp4+P6ZupbK6GWkEP5RMo2dq6pICBMYk1QxUGLS/rjhsJ
         B/gXjeaJixVDNgRfrO6po/WOcTbS1h2smuwDguYyi8xRnii72gUYRcq6EjTB7Fwut7PQ
         JWN3yMzG1efNTgCP1dn2wnW+j2tdZfu1OhrqGbpw9vYc3SXWNDqvuqbHZxfcevT2qAW7
         p62bSlQCpGOwEKPHHqgGjoTn34Nt+YeAgmvejsc0i2Ip6Pvo9L5qup6L+RDvbXgGleWu
         GbpnHL37Vve2r4s0cwMTx1Fc4c9XhnFjtQPOXZgA8IleXxpOVWEp92DP8p856t5C8lyr
         pXIw==
X-Gm-Message-State: AOJu0Yy00KfsbNFjIwNh+wU6baeSF4UhHIQiDGoj/AmPvc0gmgvuLqON
	vhIbM3OVRncFi+GYSalwreeNKhjFvlCG9j3zFFs4xm0bgIq0DnQZGlne5z4Doh23RpRszzzU+0p
	asblnX74fNB++oyfeUkmBL8XSN6Wu44V86vpYRzFGHW02mft7UFcaghMZRpoc5W0I3eNRPO1n43
	hp
X-Gm-Gg: ASbGncuZQdYtX7zJkZuh6oRizo5v1Vw9N+L8hAJY1DYcxer8epuaB8VInrDquSidPgw
	Ol68LQ1bwDaZroawAnabzZVp7uHsJQoGLB0Jh9gt98NEwlq2sgxekw/B9DjTO8Ds4j0/+QTuZhw
	4OqjRlKHicdZ2vhhjZtUJ+QUNLx94JfcY+90lpH93L5FNoGUdOvdvrJ7/oRvH9ODLbvpt/72J9H
	bxZLuRQXZFHSdDnR4vR4lnpa4HV30gQMEpG1pR/azw7JXh4kyK7om9Un4BQya7vjtlJXKLgt9Wd
	+KAlfIqPxVLBjFL/g/LwFJFv/hrlKouh5g1V8UETH/78ef0q1KcUd4BIzuyGMjd1c39cb35K1LR
	890hHvr+PuwA=
X-Received: by 2002:a17:90a:c105:b0:2f9:c56b:6ec8 with SMTP id 98e67ed59e1d1-3087bb579b7mr16101176a91.10.1745202921299;
        Sun, 20 Apr 2025 19:35:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFwIQAaaajvjoyocb0BpfSXshEezhkBoqxZJ+lZKhKxZycXlXlbETJq5aZORWHIEhSCaAa0ew==
X-Received: by 2002:a17:90a:c105:b0:2f9:c56b:6ec8 with SMTP id 98e67ed59e1d1-3087bb579b7mr16101156a91.10.1745202920814;
        Sun, 20 Apr 2025 19:35:20 -0700 (PDT)
Received: from kangyang.ap.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c50eb4287sm54631685ad.130.2025.04.20.19.35.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Apr 2025 19:35:20 -0700 (PDT)
From: Kang Yang <kang.yang@oss.qualcomm.com>
To: ath12k@lists.infradead.org, kang.yang@oss.qualcomm.com
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH ath-next 01/13] wifi: ath12k: parse msdu_end tlv in ath12k_dp_mon_rx_parse_status_tlv()
Date: Mon, 21 Apr 2025 10:34:32 +0800
Message-Id: <20250421023444.1778-2-kang.yang@oss.qualcomm.com>
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
X-Proofpoint-GUID: 8aW7hYDcxuRgj1Uaxg3YcirUe9Iqf0O9
X-Authority-Analysis: v=2.4 cv=f5pIBPyM c=1 sm=1 tr=0 ts=6805aefe cx=c_pps a=0uOsjrqzRL749jD1oC5vDA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17 a=XR8D0OoHHMoA:10 a=EUspDBNiAAAA:8 a=IxprkX8A5F3MZX6Gb8UA:9 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-ORIG-GUID: 8aW7hYDcxuRgj1Uaxg3YcirUe9Iqf0O9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-21_01,2025-04-17_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 impostorscore=0 adultscore=0 priorityscore=1501
 clxscore=1015 suspectscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504210018

Currently, error bitmap and decap format are parsed in
ath12k_dp_mon_parse_rx_dest_tlv(). Then stored into dp_rx_mon_mpdu_list.
ath12k_dp_mon_parse_rx_dest_tlv() and dp_rx_mon_mpdu_list are only used
by QCN9274.

For WCN7850, error bitmap and decap format are also needed. So need to
parse MSDU END TLV in ath12k_dp_mon_rx_parse_status_tlv(), this is the
common function for WCN7850 and QCN9274. Then store error bitmap and
decap format so that QCN9274 can fetch them when processing MSDU payload.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1

Signed-off-by: Kang Yang <kang.yang@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/dp.h     |  2 +
 drivers/net/wireless/ath/ath12k/dp_mon.c | 78 ++++++++++++------------
 2 files changed, 40 insertions(+), 40 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/dp.h b/drivers/net/wireless/ath/ath12k/dp.h
index 706d766d8c81..2ce6f0d7574f 100644
--- a/drivers/net/wireless/ath/ath12k/dp.h
+++ b/drivers/net/wireless/ath/ath12k/dp.h
@@ -121,6 +121,8 @@ struct ath12k_mon_data {
 	u32 mon_last_buf_cookie;
 	u64 mon_last_linkdesc_paddr;
 	u16 chan_noise_floor;
+	u32 err_bitmap;
+	u8 decap_format;
 
 	struct ath12k_pdev_mon_stats rx_mon_stats;
 	/* lock for monitor data */
diff --git a/drivers/net/wireless/ath/ath12k/dp_mon.c b/drivers/net/wireless/ath/ath12k/dp_mon.c
index 17117315ec7b..7404d21eed3b 100644
--- a/drivers/net/wireless/ath/ath12k/dp_mon.c
+++ b/drivers/net/wireless/ath/ath12k/dp_mon.c
@@ -1416,6 +1416,40 @@ ath12k_dp_mon_hal_rx_parse_user_info(const struct hal_receive_user_info *rx_usr_
 	}
 }
 
+static void ath12k_dp_mon_parse_rx_msdu_end_err(u32 info, u32 *errmap)
+{
+	if (info & RX_MSDU_END_INFO13_FCS_ERR)
+		*errmap |= HAL_RX_MPDU_ERR_FCS;
+
+	if (info & RX_MSDU_END_INFO13_DECRYPT_ERR)
+		*errmap |= HAL_RX_MPDU_ERR_DECRYPT;
+
+	if (info & RX_MSDU_END_INFO13_TKIP_MIC_ERR)
+		*errmap |= HAL_RX_MPDU_ERR_TKIP_MIC;
+
+	if (info & RX_MSDU_END_INFO13_A_MSDU_ERROR)
+		*errmap |= HAL_RX_MPDU_ERR_AMSDU_ERR;
+
+	if (info & RX_MSDU_END_INFO13_OVERFLOW_ERR)
+		*errmap |= HAL_RX_MPDU_ERR_OVERFLOW;
+
+	if (info & RX_MSDU_END_INFO13_MSDU_LEN_ERR)
+		*errmap |= HAL_RX_MPDU_ERR_MSDU_LEN;
+
+	if (info & RX_MSDU_END_INFO13_MPDU_LEN_ERR)
+		*errmap |= HAL_RX_MPDU_ERR_MPDU_LEN;
+}
+
+static void
+ath12k_dp_mon_parse_status_msdu_end(struct ath12k_mon_data *pmon,
+				    const struct hal_rx_msdu_end *msdu_end)
+{
+	ath12k_dp_mon_parse_rx_msdu_end_err(__le32_to_cpu(msdu_end->info2),
+					    &pmon->err_bitmap);
+	pmon->decap_format = le32_get_bits(msdu_end->info1,
+					   RX_MSDU_END_INFO11_DECAP_FORMAT);
+}
+
 static enum hal_rx_mon_status
 ath12k_dp_mon_rx_parse_status_tlv(struct ath12k *ar,
 				  struct ath12k_mon_data *pmon,
@@ -1655,6 +1689,7 @@ ath12k_dp_mon_rx_parse_status_tlv(struct ath12k *ar,
 	case HAL_MON_BUF_ADDR:
 		return HAL_RX_MON_STATUS_BUF_ADDR;
 	case HAL_RX_MSDU_END:
+		ath12k_dp_mon_parse_status_msdu_end(pmon, tlv_data);
 		return HAL_RX_MON_STATUS_MSDU_END;
 	case HAL_RX_MPDU_END:
 		return HAL_RX_MON_STATUS_MPDU_END;
@@ -2223,45 +2258,6 @@ static int ath12k_dp_pkt_set_pktlen(struct sk_buff *skb, u32 len)
 	return 0;
 }
 
-static void ath12k_dp_mon_parse_rx_msdu_end_err(u32 info, u32 *errmap)
-{
-	if (info & RX_MSDU_END_INFO13_FCS_ERR)
-		*errmap |= HAL_RX_MPDU_ERR_FCS;
-
-	if (info & RX_MSDU_END_INFO13_DECRYPT_ERR)
-		*errmap |= HAL_RX_MPDU_ERR_DECRYPT;
-
-	if (info & RX_MSDU_END_INFO13_TKIP_MIC_ERR)
-		*errmap |= HAL_RX_MPDU_ERR_TKIP_MIC;
-
-	if (info & RX_MSDU_END_INFO13_A_MSDU_ERROR)
-		*errmap |= HAL_RX_MPDU_ERR_AMSDU_ERR;
-
-	if (info & RX_MSDU_END_INFO13_OVERFLOW_ERR)
-		*errmap |= HAL_RX_MPDU_ERR_OVERFLOW;
-
-	if (info & RX_MSDU_END_INFO13_MSDU_LEN_ERR)
-		*errmap |= HAL_RX_MPDU_ERR_MSDU_LEN;
-
-	if (info & RX_MSDU_END_INFO13_MPDU_LEN_ERR)
-		*errmap |= HAL_RX_MPDU_ERR_MPDU_LEN;
-}
-
-static int
-ath12k_dp_mon_parse_status_msdu_end(struct ath12k_mon_data *pmon,
-				    const struct hal_rx_msdu_end *msdu_end)
-{
-	struct dp_mon_mpdu *mon_mpdu = pmon->mon_mpdu;
-
-	ath12k_dp_mon_parse_rx_msdu_end_err(__le32_to_cpu(msdu_end->info2),
-					    &mon_mpdu->err_bitmap);
-
-	mon_mpdu->decap_format = le32_get_bits(msdu_end->info1,
-					       RX_MSDU_END_INFO11_DECAP_FORMAT);
-
-	return 0;
-}
-
 static int
 ath12k_dp_mon_parse_status_buf(struct ath12k *ar,
 			       struct ath12k_mon_data *pmon,
@@ -2335,7 +2331,9 @@ ath12k_dp_mon_parse_rx_dest_tlv(struct ath12k *ar,
 		pmon->mon_mpdu = NULL;
 		break;
 	case HAL_RX_MON_STATUS_MSDU_END:
-		return ath12k_dp_mon_parse_status_msdu_end(pmon, tlv_data);
+		pmon->mon_mpdu->decap_format = pmon->decap_format;
+		pmon->mon_mpdu->err_bitmap = pmon->err_bitmap;
+		break;
 	default:
 		break;
 	}
-- 
2.34.1


