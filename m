Return-Path: <linux-wireless+bounces-24648-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D9980AED4DE
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Jun 2025 08:45:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3D4918968C9
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Jun 2025 06:46:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2A1120F069;
	Mon, 30 Jun 2025 06:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="H8mNcbN2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E87B1F4CA4
	for <linux-wireless@vger.kernel.org>; Mon, 30 Jun 2025 06:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751265929; cv=none; b=KVQ/opU1nHMMkxX9bBxQ/GaOlIcVTX6f+IN2/HBWBsFS3juaGKDGMP/00ZT6B0ja0tzhsRtm732cFBpwKYsaKBZtyeSi6WTVNFrk7eZ2LuEX2E9oJ7g/YhvqkH03bQom64o8gs7fCgZ5Mnyo1nNYrKpSryzZ8GLUnJdNdA4gyaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751265929; c=relaxed/simple;
	bh=nTxJm9k1Qpau8WKR0HROuKBeYTXHhl7pBxbaUHVALGI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EVBu6wtp6nVB1qXa8vgq0OJOvaruotlauzt1VD/wZHS4ckQIHJiDP7qSZzBGo9HRlpSH39RJ1M5E0ipLgB2qb5HK+9j6gkYsQCZkB0VBEyJSlh1JoD+UsNvedYFKjPveaIrZ0rBhqRzgF1cdSn8z+KfaMCWhMiPrZes/X9ZXxSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=H8mNcbN2; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55TLeodw007424;
	Mon, 30 Jun 2025 06:45:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=wSuD+H1Tbpx0DjzHpljEMo
	na78eEmzW/sxLoGQ+9hRk=; b=H8mNcbN2mLaxAmbP4ZYjnxJMsSJ0aHl5vjPVlX
	XeVb0831oH7HHnUbCT2/xWnzbrNh5iTmhLddeXk6i9beTFVxM17JnKwfd8X2ZXDL
	+yfaM3clxIRfAXBsOZXlTYJGQyED+cwxhqbMBj4dqM77oO7kOfAomaFc6KINXUzt
	Dn9WgM/dmPRVovy7XYXyR+dIzWFjA4k3ZiszS37MlEpxkqd3g0stmETs5mMLW0RO
	nIh8hIweFFMjYqNzvbUsWEX1u2tJ1BOP40xt9aBO6TqOzdNPuZOKh8l2vZbngkLn
	d+VfUMYSYpNLLImUx4O8tvi9OVccXTOTV6vfX2tUzcWWq7BA==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47j801umn9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Jun 2025 06:45:23 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 55U6j3Is016286
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Jun 2025 06:45:03 GMT
Received: from hu-sarishar-blr.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Sun, 29 Jun 2025 23:45:02 -0700
From: Sarika Sharma <quic_sarishar@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Sarika Sharma
	<quic_sarishar@quicinc.com>
Subject: [PATCH ath-next] wifi: ath12k: properly set bit for pdev mask for firmware PPDU_STATS request
Date: Mon, 30 Jun 2025 12:14:31 +0530
Message-ID: <20250630064431.3446333-1-quic_sarishar@quicinc.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Hjpw_8FoCR8tJcGIkR5SxUuFKjunYO09
X-Authority-Analysis: v=2.4 cv=YPWfyQGx c=1 sm=1 tr=0 ts=68623283 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=6IFa9wvqVegA:10 a=COk6AnOGAAAA:8 a=cZj-qgbuDKRneyf3sl4A:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: Hjpw_8FoCR8tJcGIkR5SxUuFKjunYO09
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjMwMDA1NSBTYWx0ZWRfX94Arb9DQhYre
 D11wC8uQNrrblUMF/ZkB1d/pKkF71SQbkiHMfyXaiJuJ0IZc/axAty80yCEZSpwzuMNMPm1bKQY
 Kt78hCB+1c1LOwMorCwOn1MOl/XU1DMGTZyurjai3SdJ6Kl53oIwJ4YUVDPdy6It9/OK46gMY1v
 Ast/+3YbOHdSaKaPjWoqldViXkKuPw4N1gH7TazsLOBxuUfZCmNKJxxXff41rhq4jJJhd/g2/7u
 Or+MEI+DnI38GBJ+46DkWQIG/qetAPqo3pteM9FqawqkKLlVtc2sGmeuWByH5oZ8DlhzwLpf2D/
 5TyGWH4UKHtAxYtHXSVOP6ADTA6zyiwZacz7gmQItNRALZzWqtNr2rb4JbIvooGbYtJ9AcUVsn5
 6TwQW+LUlIj6pMPE0VzUtwF2P77/jbZ8pWcO/AZ2cbPM5b5/UyORJNF2OBPM0lVntxieL1f+
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-30_01,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 mlxlogscore=999 mlxscore=0 malwarescore=0 suspectscore=0
 lowpriorityscore=0 clxscore=1015 impostorscore=0 adultscore=0
 priorityscore=1501 bulkscore=0 phishscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506300055

Currently, the HTT_H2T_MSG_TYPE_PPDU_STATS_CFG request uses bits
8 to 15 as the bitmask for HTT_PPDU_STATS_CFG_PDEV_ID for firmware
PPDU_STATS. However, bit 8 is reserved for SOC stats, and the actual
PDEV ID should be encoded using bits 9 to 15. This leads to incorrect
PDEV ID encoding in the request, causing it to either ignore the
request or apply it to the wrong PDEV.

Additionally, pdev_mask calculation is done as
pdev_mask = 1 << (i + 1); (i.e. i= num_rxmda_per_pdev)
but this is not valid for multiple pdevs(multi-MAC configurations)
with 1 rxdma per pdev, as this will mask the same value for all pdevs.
To correctly identify each and exact MAC in multi-MAC configurations,
the calculation should include ar->pdev_idx:
pdev_mask = 1 << i + ar->pdev_idx;

Due to these issues, the firmware does not send PPDU_STATS for the
intended PDEV, leading to inaccurate and incomplete statistics on the
host. This might trigger certain WARN_ON() conditions in host that
rely on these statistics.

Hence, change the bitmask for HTT_PPDU_STATS_CFG_PDEV_ID as bit 9
to 15 to properly fill the pdev id in request message and change
the pdev_mask calculation to consider ar->pdev_idx to mask pdev
correctly.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1

Signed-off-by: Sarika Sharma <quic_sarishar@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/dp.h    | 3 ++-
 drivers/net/wireless/ath/ath12k/dp_tx.c | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/dp.h b/drivers/net/wireless/ath/ath12k/dp.h
index a353333f83b6..a537c3420f91 100644
--- a/drivers/net/wireless/ath/ath12k/dp.h
+++ b/drivers/net/wireless/ath/ath12k/dp.h
@@ -703,7 +703,8 @@ struct htt_ppdu_stats_cfg_cmd {
 } __packed;
 
 #define HTT_PPDU_STATS_CFG_MSG_TYPE		GENMASK(7, 0)
-#define HTT_PPDU_STATS_CFG_PDEV_ID		GENMASK(15, 8)
+#define HTT_PPDU_STATS_CFG_SOC_STATS		BIT(8)
+#define HTT_PPDU_STATS_CFG_PDEV_ID		GENMASK(15, 9)
 #define HTT_PPDU_STATS_CFG_TLV_TYPE_BITMASK	GENMASK(31, 16)
 
 enum htt_ppdu_stats_tag_type {
diff --git a/drivers/net/wireless/ath/ath12k/dp_tx.c b/drivers/net/wireless/ath/ath12k/dp_tx.c
index ca3d97043da0..1fa37cda1046 100644
--- a/drivers/net/wireless/ath/ath12k/dp_tx.c
+++ b/drivers/net/wireless/ath/ath12k/dp_tx.c
@@ -1257,7 +1257,7 @@ int ath12k_dp_tx_htt_h2t_ppdu_stats_req(struct ath12k *ar, u32 mask)
 		cmd->msg = le32_encode_bits(HTT_H2T_MSG_TYPE_PPDU_STATS_CFG,
 					    HTT_PPDU_STATS_CFG_MSG_TYPE);
 
-		pdev_mask = 1 << (i + 1);
+		pdev_mask = 1 << (i + ar->pdev_idx);
 		cmd->msg |= le32_encode_bits(pdev_mask, HTT_PPDU_STATS_CFG_PDEV_ID);
 		cmd->msg |= le32_encode_bits(mask, HTT_PPDU_STATS_CFG_TLV_TYPE_BITMASK);
 

base-commit: 391a83d0c8ebb1e476cba73bf4c010af73993111
-- 
2.34.1


