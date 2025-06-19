Return-Path: <linux-wireless+bounces-24262-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BD16ADFD79
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Jun 2025 08:06:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABFD9175F12
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Jun 2025 06:06:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B01B219A6B;
	Thu, 19 Jun 2025 06:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WhIl/T0/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6878414F98
	for <linux-wireless@vger.kernel.org>; Thu, 19 Jun 2025 06:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750313208; cv=none; b=HvwkcxwFlo5JszpD9P4i6S0xjhHkE9J98/r44CXBRjcmlypCFo0XxKozJPXTbuXI0VFmEtzi6N7838htGvDBQOwkXVvIgcod29LXjfRhyo3Co7rU/ol/SEFtDJYRUl4Fbtbk0LrsmeTvfdKjWAwC0jjdNOpRNCGTI/Zq+BVen4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750313208; c=relaxed/simple;
	bh=Qcsb7U/Zl/CP9oklJPYCetdMsR9EvscPHhDH26fLrWE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JiQzXSzkJdUkXeUxKe6yUh+RvTtUPcLJNvuhgUr5y7KFH5KWua5cAW5TPwLYWwPVcQydtnhbtTiM9WB3IIGdcilld0jdh6mliIX0fzv9XSuUjrnZQxBmTyzKfQriy+3Sts+qp3Nr7BgkJCLq31TZxF9Kh2B7Uwdj4sBKnGS3PlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WhIl/T0/; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55J2FB13007549;
	Thu, 19 Jun 2025 06:06:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=umzCRoR01fg0vFmZRQ6LHdJQxvnj7oMRkWM
	aP6uHyMY=; b=WhIl/T0/RWPBF0PKXCCZLk0ipihnBiMHE/lzs9c6ylu71I8yxs2
	3zDsHY2RR5y5oqNw5CPqhOGcl/W7KXc43l5CeO86O0yzktnQUyput5AahVARSGVw
	tHEW9rAp/Nvke9pC5T2Qk4Ab5M2/ccvxrz6yButH0TA3Y8g9kPCRhrFmPR/7wbsY
	MxwNvnYGdFLUrf1EELk3kfK2tSYfSllW+rlGit4x9M+UAKNMm9+A7MOzC7zIp2Aa
	sHl37dPfBwQOAp58XpbhMiUPxpEvSaFrdjyGrmMTbTpEimOX5pX8bDBoT+IzRD93
	Js9k4zgrrsi/7z0LkyIaQoZpYAkBQHGbMvQ==
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47c9krrh85-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Jun 2025 06:06:43 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 55J66dMV022893;
	Thu, 19 Jun 2025 06:06:39 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 479k1h46ja-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Jun 2025 06:06:39 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 55J66dwr022888;
	Thu, 19 Jun 2025 06:06:39 GMT
Received: from hu-devc-blr-u22-a.qualcomm.com (hu-tamizhr-blr.qualcomm.com [10.190.110.180])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 55J66dH9022887
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Jun 2025 06:06:39 +0000
Received: by hu-devc-blr-u22-a.qualcomm.com (Postfix, from userid 380741)
	id 30E0C41106; Thu, 19 Jun 2025 11:36:38 +0530 (+0530)
From: Tamizh Chelvam Raja <tamizh.raja@oss.qualcomm.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Tamizh Chelvam Raja <tamizh.raja@oss.qualcomm.com>
Subject: [PATCH ath-next] wifi: ath12k: Use spinlock when reading stats from arsta
Date: Thu, 19 Jun 2025 11:36:30 +0530
Message-Id: <20250619060630.4179796-1-tamizh.raja@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: fjbpimjy-Le0bHUSPCpT2DVYrq2DfdYQ
X-Authority-Analysis: v=2.4 cv=UPTdHDfy c=1 sm=1 tr=0 ts=6853a8f3 cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=6IFa9wvqVegA:10 a=EUspDBNiAAAA:8 a=iZCChBz09MV8xfH4l50A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE5MDA1MCBTYWx0ZWRfXx47ZEobGs3jG
 zxKA4FDEXzAUJGsF2rcfmjhX2XFHTZyo01Q/RN9BxGulHhpkeSVQ07id2vU+8U6soKsOoZZijdP
 Kckw/iQ6E1hvA5Quq5aX+Ehp4muitlEwTBPJ5Enrrj+xSEzOAjp+yYDFmYXEPNJVPwut9qQQWcp
 /khis/zhB+w2J08VUeja7JHQsn81bxQIrwNc5kgFwwAvU29Vz2PPa6qj/QcaGLAg4d6TzacKUPn
 ZQohZGp3ssXMyPVvDKWDxToI1r6DFioDk0a72zgiRswPQT7UdEYIF+hqQ3YstcPWUoICZtfKt1w
 q6T938ci3PUHVEQDjXhQA2gWA+TZ0Aqk2lEtbQ86u9ZeX46ABCtfz4ZCNlnMtMgpWEp8+wADtGI
 oDYPOlyp7kNcGhUZIlGqA65dbtV6uIs6dkRjcF9e9O6jI9R/svIrMhNLQwgVcfn1NnQVHEhW
X-Proofpoint-ORIG-GUID: fjbpimjy-Le0bHUSPCpT2DVYrq2DfdYQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-19_02,2025-06-18_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 impostorscore=0 spamscore=0 lowpriorityscore=0
 phishscore=0 mlxscore=0 mlxlogscore=999 priorityscore=1501 suspectscore=0
 adultscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506190050

The ab->base_lock spinlock is being used while updating the arsta
TX rate statistics and other fields like rssi/rx/tx_duration.
But these fields are accessed in ath12k_mac_op_sta_statistics()
without any lock protection, which can lead to reading incorrect or
partially updated values.

To prevent this race condition and avoid the inconsistency, the same
spinlock should also be used when accessing these statistics in
ath12k_mac_op_sta_statistics()

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1

Signed-off-by: Tamizh Chelvam Raja <tamizh.raja@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 2 ++
 drivers/net/wireless/ath/ath12k/wmi.c | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 88b59f3ff87a..9b117d9af27b 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -11056,6 +11056,7 @@ static void ath12k_mac_op_sta_statistics(struct ieee80211_hw *hw,
 	db2dbm = test_bit(WMI_TLV_SERVICE_HW_DB2DBM_CONVERSION_SUPPORT,
 			  ar->ab->wmi_ab.svc_map);
 
+	spin_lock_bh(&ar->ab->base_lock);
 	sinfo->rx_duration = arsta->rx_duration;
 	sinfo->filled |= BIT_ULL(NL80211_STA_INFO_RX_DURATION);
 
@@ -11097,6 +11098,7 @@ static void ath12k_mac_op_sta_statistics(struct ieee80211_hw *hw,
 	}
 
 	sinfo->signal_avg = ewma_avg_rssi_read(&arsta->avg_rssi);
+	spin_unlock_bh(&ar->ab->base_lock);
 
 	if (!db2dbm)
 		sinfo->signal_avg += ATH12K_DEFAULT_NOISE_FLOOR;
diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
index 60e2444fe08c..d7f438f41823 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -7524,7 +7524,9 @@ static int ath12k_wmi_tlv_fw_stats_data_parse(struct ath12k_base *ab,
 			if (sta) {
 				ahsta = ath12k_sta_to_ahsta(sta);
 				arsta = &ahsta->deflink;
+				spin_lock_bh(&ab->base_lock);
 				arsta->rssi_beacon = le32_to_cpu(src->beacon_snr);
+				spin_unlock_bh(&ab->base_lock);
 				ath12k_dbg(ab, ATH12K_DBG_WMI,
 					   "wmi stats vdev id %d snr %d\n",
 					   src->vdev_id, src->beacon_snr);

base-commit: 535de528015b56e34a40a8e1eb1629fadf809a84
-- 
2.34.1


