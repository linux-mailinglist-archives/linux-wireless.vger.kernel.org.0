Return-Path: <linux-wireless+bounces-9581-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 87FF5917834
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Jun 2024 07:36:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA56FB22703
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Jun 2024 05:36:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A6D22F5E;
	Wed, 26 Jun 2024 05:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="D+vUASld"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5D4CDDC9
	for <linux-wireless@vger.kernel.org>; Wed, 26 Jun 2024 05:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719380194; cv=none; b=fhF4WcgATElAI3JqdjdfaApSG53EqStpDGxtBoDp1JqvDfxiKRuQf1YcjrPkmpbVh0aVf/BfALlxDgmmD5ApJA0k8XDdnHk1hc+duSs7RL9/UvUUJoNL+YoUcUqBWx+NtqTSiu2ZmUsOvPjnHalEcs28NoefCyJS1GRuCyzZTZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719380194; c=relaxed/simple;
	bh=Z9VTkXAbP7JA10A4yUoEKz4/DmsVVguMa5O/x5VMnH8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QyMyBRBMW/HBHFxxMDtRMKghFeCko//4IrKJSpU/8hjWSjRbP0RG5OSAy5ea52Vdn2pYkhlRkeubC9szj9zGuOw14JiUGJL/4glXGQv0ng9gqTi4y1FCGktk5DgV5PHS2KAaROyarsYsS3RWCVahpuy/4TY0T2lqMzrBk1OjHd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=D+vUASld; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45Q3mwsi002335;
	Wed, 26 Jun 2024 05:36:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=DgXqAgHQiIr+OyWmm6Eb1J
	B8fnmEqo0j+yyZ4Kn8bac=; b=D+vUASldmU8ISl2zicpho+snmYO0S4ayllZLN9
	y2L/Clrd7gggvdrCee+rjNQSOz5c2bXGuazkTmJrki11/9m8yqczU1cogy7Vt7Nb
	ZqtcLcqKCvKUuFe3xB4HiyyUPuA0MRTow58T0NIYsIGLXxlmMHfKtL12/lnAN5Sg
	Ay6Q/rXTaoR9h4lVfPEbog1AA6DGkSJnusP4ukTORvUVSYCkUsc4UWQ8T1H0j5/N
	emKNWEfVgxNtzEwzV1NT8qeB+T8yAonmYi2LW9d+SJFdgg4XwkEvP3Q6bORVTnz8
	FqEKvtzeA8axkJ8dbWJjn69XgzgJ+XzRhCRW4PpNskbzXb/w==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 400bdq86tk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Jun 2024 05:36:22 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA05.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45Q5aLtR000357
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Jun 2024 05:36:21 GMT
Received: from kangyang.ap.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 25 Jun 2024 22:36:19 -0700
From: Kang Yang <quic_kangyang@quicinc.com>
To: <ath11k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <quic_kangyang@quicinc.com>
Subject: [PATCH] wifi: ath11k: use work queue to process beacon tx event
Date: Wed, 26 Jun 2024 13:35:43 +0800
Message-ID: <20240626053543.1946-1-quic_kangyang@quicinc.com>
X-Mailer: git-send-email 2.34.1.windows.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: H2bUcINakRBOOFpM-9dvvp28XNSsSQwM
X-Proofpoint-GUID: H2bUcINakRBOOFpM-9dvvp28XNSsSQwM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-26_03,2024-06-25_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxlogscore=999
 adultscore=0 bulkscore=0 lowpriorityscore=0 impostorscore=0 malwarescore=0
 mlxscore=0 suspectscore=0 priorityscore=1501 clxscore=1011 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2406140001
 definitions=main-2406260042

Commit 3a415daa3e8b ("wifi: ath11k: add P2P IE in beacon template")
from Feb 28, 2024 (linux-next), leads to the following Smatch static
checker warning:

drivers/net/wireless/ath/ath11k/wmi.c:1742 ath11k_wmi_p2p_go_bcn_ie()
warn: sleeping in atomic context

The reason is that ath11k_bcn_tx_status_event() will directly call might
sleep function ath11k_wmi_cmd_send() during RCU read-side critical
sections. The call trace is like:

ath11k_bcn_tx_status_event()
-> rcu_read_lock()
-> ath11k_mac_bcn_tx_event()
	-> ath11k_mac_setup_bcn_tmpl()
	……
		-> ath11k_wmi_bcn_tmpl()
			-> ath11k_wmi_cmd_send()
-> rcu_read_unlock()

Commit 886433a98425 ("ath11k: add support for BSS color change") added the
ath11k_mac_bcn_tx_event(), commit 01e782c89108 ("ath11k: fix warning
of RCU usage for ath11k_mac_get_arvif_by_vdev_id()") added the RCU lock
to avoid warning but also introduced this BUG.

Use work queue to avoid directly calling ath11k_mac_bcn_tx_event()
during RCU critical sections. No need to worry the deletion of vif.
Because cancel_work_sync() will drop the work if it doesn't start or
block vif deletion until the running work is done.

Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.30

Fixes: 3a415daa3e8b ("wifi: ath11k: add P2P IE in beacon template")
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/all/2d277abd-5e7b-4da0-80e0-52bd96337f6e@moroto.mountain/
Signed-off-by: Kang Yang <quic_kangyang@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/core.h |  1 +
 drivers/net/wireless/ath/ath11k/mac.c  | 12 ++++++++++++
 drivers/net/wireless/ath/ath11k/wmi.c  |  4 +++-
 3 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath11k/core.h b/drivers/net/wireless/ath/ath11k/core.h
index df24f0e409af..7122176dd91e 100644
--- a/drivers/net/wireless/ath/ath11k/core.h
+++ b/drivers/net/wireless/ath/ath11k/core.h
@@ -399,6 +399,7 @@ struct ath11k_vif {
 	u8 bssid[ETH_ALEN];
 	struct cfg80211_bitrate_mask bitrate_mask;
 	struct delayed_work connection_loss_work;
+	struct work_struct bcn_tx_work;
 	int num_legacy_stations;
 	int rtscts_prot_mode;
 	int txpower;
diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index 779009774567..7ed606aaf1a6 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -6599,6 +6599,16 @@ static int ath11k_mac_vdev_delete(struct ath11k *ar, struct ath11k_vif *arvif)
 	return ret;
 }
 
+static void ath11k_mac_bcn_tx_work(struct work_struct *work)
+{
+	struct ath11k_vif *arvif = container_of(work, struct ath11k_vif,
+						bcn_tx_work);
+
+	mutex_lock(&arvif->ar->conf_mutex);
+	ath11k_mac_bcn_tx_event(arvif);
+	mutex_unlock(&arvif->ar->conf_mutex);
+}
+
 static int ath11k_mac_op_add_interface(struct ieee80211_hw *hw,
 				       struct ieee80211_vif *vif)
 {
@@ -6637,6 +6647,7 @@ static int ath11k_mac_op_add_interface(struct ieee80211_hw *hw,
 	arvif->vif = vif;
 
 	INIT_LIST_HEAD(&arvif->list);
+	INIT_WORK(&arvif->bcn_tx_work, ath11k_mac_bcn_tx_work);
 	INIT_DELAYED_WORK(&arvif->connection_loss_work,
 			  ath11k_mac_vif_sta_connection_loss_work);
 
@@ -6879,6 +6890,7 @@ static void ath11k_mac_op_remove_interface(struct ieee80211_hw *hw,
 	int i;
 
 	cancel_delayed_work_sync(&arvif->connection_loss_work);
+	cancel_work_sync(&arvif->bcn_tx_work);
 
 	mutex_lock(&ar->conf_mutex);
 
diff --git a/drivers/net/wireless/ath/ath11k/wmi.c b/drivers/net/wireless/ath/ath11k/wmi.c
index 38f175dd1557..2662092ee00a 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.c
+++ b/drivers/net/wireless/ath/ath11k/wmi.c
@@ -7404,7 +7404,9 @@ static void ath11k_bcn_tx_status_event(struct ath11k_base *ab, struct sk_buff *s
 		rcu_read_unlock();
 		return;
 	}
-	ath11k_mac_bcn_tx_event(arvif);
+
+	queue_work(ab->workqueue, &arvif->bcn_tx_work);
+
 	rcu_read_unlock();
 }
 

base-commit: cac9bfd02678adbcca9a7dce770609b9f7434d37
-- 
2.34.1


