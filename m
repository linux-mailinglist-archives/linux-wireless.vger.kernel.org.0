Return-Path: <linux-wireless+bounces-4572-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DC2B878702
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Mar 2024 19:08:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C3381C20E5B
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Mar 2024 18:08:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFE795467F;
	Mon, 11 Mar 2024 18:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="AXRs41N2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E634053E11
	for <linux-wireless@vger.kernel.org>; Mon, 11 Mar 2024 18:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710180502; cv=none; b=MFjCxzuRf1Js60V1imX54EyHYT2IYINyjV0tjnnIDRMnQnvzTshBxcXaiJWeYIJufgNvQNcfgnoScuTsoApN9g/Gz8EBxCtTyWYT8IArG7yA1qznVa1rvb3dB4V4OsY/kRirSBRjqvMoN091AB3Pnt+khL1t/KdKmXsx85wBgeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710180502; c=relaxed/simple;
	bh=/oRAhq/MvTx62WsR69JiHEKZSJs1+fQWQxvV9xfg1yk=;
	h=From:To:Cc:Subject:Date:Message-Id; b=CtpTL+B7nBXyD0FGUD5oy9fa0VoRDETtkawrwi0Ph9TnEG1YRU5QXYzWr7g5Ln7NjSSG+IQO71XIEIFCdz7Ucts95oZUEOR3e+rEyGge0B7Hksyc+ElOIWRqbdeo/u8doD4h9U0opM5ElifVg2BpVxG108JR7dl8+LRFE4ZDh7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=AXRs41N2; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42BHxCAn022218;
	Mon, 11 Mar 2024 18:08:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id; s=qcppdkim1; bh=ffhkJEvhkCCn
	Veu7Xa2ZsnIBaMqm3tt4l87ZT/SYlXY=; b=AXRs41N213CSFNoM1UpxSfT0ZmBO
	wNNsmyHTZVGAj9xgxFOVJwzJInwlcff7FVW5angeLXqX0x6GAtkfNEBErm/r2Jfp
	YkIbN6+LWS0mzcVSs105C4kD0hrx3k9PGe1UCZQw/0jH8nC1Mm3gThvgzl5KUter
	6Z2N75EmD4Mtha9n+2v8pccn08LeVO6ZwpxNLMRVPSIitIUjF0Bs7966u3PHt1cB
	StwqU42/9uNTxsUVhtt3R61h4B3ZZm3Ja0hfXhuBFPsIt23+Cch9+OX+fcvtRwq3
	b+6j1IROkgLhEkRtVkw9fCyXxIXxPEvCR5m88IRQJhDMbN9nb6RCRC6N8g==
Received: from apblrppmta02.qualcomm.com ([103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wswrssmvb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Mar 2024 18:08:00 +0000 (GMT)
Received: from hu-maiyas18a-blr.qualcomm.com (hu-tmariyap-blr.qualcomm.com [10.131.36.89])
	by APBLRPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 42BI79V9021173;
	Mon, 11 Mar 2024 18:07:09 GMT
Received: by hu-maiyas18a-blr.qualcomm.com (Postfix, from userid 0)
	id 77F3DA01944; Mon, 11 Mar 2024 23:37:08 +0530 (+0530)
From: quic_tmariyap@quicinc.com
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH v2] wifi: ath12k: fix desc address calculation in wbm tx completion
Date: Mon, 11 Mar 2024 23:37:08 +0530
Message-Id: <20240311180708.9334-1-quic_tmariyap@quicinc.com>
X-Mailer: git-send-email 2.17.1
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: boIj-hdxqyHbXziOGu3CzkGde7uJhL3d
X-Proofpoint-ORIG-GUID: boIj-hdxqyHbXziOGu3CzkGde7uJhL3d
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-11_10,2024-03-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 spamscore=0
 malwarescore=0 priorityscore=1501 impostorscore=0 mlxscore=0
 suspectscore=0 mlxlogscore=999 bulkscore=0 adultscore=0 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403110136
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>

From: Thiraviyam Mariyappan <quic_tmariyap@quicinc.com>

In tx completion, status desc is obtained from offsetting the address
from wbm ring. Having HTT_TX_WBM_COMP_STATUS_OFFSET(8) and reserved 8
bytes in status desc offsets the address twice and read the values
from the incorrect address. Hence, remove the
HTT_TX_WBM_COMP_STATUS_OFFSET from wbm completion address calculation.

Also this patch is applicable for WCN7850.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1

Signed-off-by: Thiraviyam Mariyappan <quic_tmariyap@quicinc.com>
---
v2:
 - removed the addition of HTT_TX_WBM_COMP_STATUS_OFFSET instead of
structure changes.
 - modified commit log and renamed subject from "wifi: ath12k: remove
reserve member of wbm completion structure".
---
 drivers/net/wireless/ath/ath12k/dp.h    | 2 --
 drivers/net/wireless/ath/ath12k/dp_tx.c | 2 +-
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/dp.h b/drivers/net/wireless/ath/ath12k/dp.h
index eb2dd408e081..9b83b9230bbc 100644
--- a/drivers/net/wireless/ath/ath12k/dp.h
+++ b/drivers/net/wireless/ath/ath12k/dp.h
@@ -377,8 +377,6 @@ struct ath12k_dp {
 /* peer meta data */
 #define HTT_TCL_META_DATA_PEER_ID		GENMASK(15, 2)
 
-#define HTT_TX_WBM_COMP_STATUS_OFFSET 8
-
 /* HTT tx completion is overlaid in wbm_release_ring */
 #define HTT_TX_WBM_COMP_INFO0_STATUS		GENMASK(16, 13)
 #define HTT_TX_WBM_COMP_INFO1_REINJECT_REASON	GENMASK(3, 0)
diff --git a/drivers/net/wireless/ath/ath12k/dp_tx.c b/drivers/net/wireless/ath/ath12k/dp_tx.c
index 572b87153647..9b6d7d72f57c 100644
--- a/drivers/net/wireless/ath/ath12k/dp_tx.c
+++ b/drivers/net/wireless/ath/ath12k/dp_tx.c
@@ -414,7 +414,7 @@ ath12k_dp_tx_process_htt_tx_complete(struct ath12k_base *ab,
 	struct ath12k_dp_htt_wbm_tx_status ts = {0};
 	enum hal_wbm_htt_tx_comp_status wbm_status;
 
-	status_desc = desc + HTT_TX_WBM_COMP_STATUS_OFFSET;
+	status_desc = desc;
 
 	wbm_status = le32_get_bits(status_desc->info0,
 				   HTT_TX_WBM_COMP_INFO0_STATUS);
-- 
2.17.1


