Return-Path: <linux-wireless+bounces-9492-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B88309146B5
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Jun 2024 11:53:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FA81286B70
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Jun 2024 09:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6B70132C3B;
	Mon, 24 Jun 2024 09:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="NXClR0Mv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 811A818E29
	for <linux-wireless@vger.kernel.org>; Mon, 24 Jun 2024 09:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719222810; cv=none; b=F5t2lAtCKuK2wRHF1joWdIi4PnOoJJYDlGI2PqrHJsRRip1dP3zSXANziPvGahPWVFAj/nhj31c1dNrbja6YroB2vOJbwzxLdOaEDGPpWqt8j86XZ04X9b5RIBl2Ft3PtKSr7yQCb5iXp8iSHDd0KyPBd4ZeAT3wnvaSJqL5HRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719222810; c=relaxed/simple;
	bh=shZLOmktrm32Ik+Y8BRlhYGRpMthB68+JKdrFOR6lrw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B0TxxLi1b34j6rQBo+vPWgeOR6zvSmD73y+YyWbAATboXvotIfhM/jnrfbaq9+GMXafIY9Rxnn3QusrsGQZL4r6OOCOiaUJ/cZ3LMDRFODZs+ahOkVDMydtztatPlFXLs2Fp2RZKt8sLPQC0kKP+NKfJ4PVYXoKy/LJO4RkI9JI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=NXClR0Mv; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45O8YV2L017095;
	Mon, 24 Jun 2024 09:53:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	5fuR4dJAaLdzg3oA2RMElOxL00dpVzLJ5hhnD8/CCos=; b=NXClR0Mv7EYFdrS1
	95pmuQ50sO3DqfKDIGSVQ2RJGyhII5eaI1lbhPxE3zWmHMapRLbwrub8hAB1W00C
	VoJQDAyeNCWkzwt7sfes1qpR2VjOz93ButTWBwPQv+cfRzrc8M7bd/CSrnwHpcDY
	nUOWX/ZRyjj9ZSrgaC0jnAYSp4MfUOiXlwGs1LLjgu0bq7rOe5BNHOLO0WHFu5RJ
	Py9lvaW0DpTaQpIfyiPsGTS79T5y6fbvlblC8r1NT7beuTUVbNz5DzbF76nKcP9r
	HKeJha0ms8YGWUe9RwJjr4p5Gd+b+l74iAXJgcy5eHy7tyaIwqgp7NZSNzeWs8sE
	GpKygg==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ywqw9b1w2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Jun 2024 09:53:25 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA01.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45O9rOOv011305
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Jun 2024 09:53:25 GMT
Received: from hu-aarasahu-blr.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 24 Jun 2024 02:53:23 -0700
From: Aaradhana Sahu <quic_aarasahu@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Aaradhana Sahu
	<quic_aarasahu@quicinc.com>
Subject: [PATCH v5 1/4] wifi: ath: create common testmode_i.h file for ath drivers
Date: Mon, 24 Jun 2024 15:23:02 +0530
Message-ID: <20240624095305.37189-2-quic_aarasahu@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240624095305.37189-1-quic_aarasahu@quicinc.com>
References: <20240624095305.37189-1-quic_aarasahu@quicinc.com>
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
X-Proofpoint-ORIG-GUID: C_4z3ibgsjjmv4yBlO10_hoeIIucOnce
X-Proofpoint-GUID: C_4z3ibgsjjmv4yBlO10_hoeIIucOnce
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-24_09,2024-06-21_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 clxscore=1015 impostorscore=0 mlxscore=0
 lowpriorityscore=0 malwarescore=0 mlxlogscore=999 phishscore=0 bulkscore=0
 adultscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2406140001 definitions=main-2406240079

User space application requires that the testmode interface
is exactly same between ath drivers. Move testmode_i.h file
in ath directory to ensure that all ath driver uses same testmode
interface instead of duplicating testmode_i.h for each ath drivers.

Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.7.0.1-01744-QCAHKSWPL_SILICONZ-1
Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.1.1-00210-QCAHKSWPL_SILICONZ-1

Signed-off-by: Aaradhana Sahu <quic_aarasahu@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/testmode.c    | 78 +++++++++----------
 .../wireless/ath/{ath11k => }/testmode_i.h    | 54 ++++++-------
 2 files changed, 66 insertions(+), 66 deletions(-)
 rename drivers/net/wireless/ath/{ath11k => }/testmode_i.h (50%)

diff --git a/drivers/net/wireless/ath/ath11k/testmode.c b/drivers/net/wireless/ath/ath11k/testmode.c
index 302d66092b97..5d0680d4053d 100644
--- a/drivers/net/wireless/ath/ath11k/testmode.c
+++ b/drivers/net/wireless/ath/ath11k/testmode.c
@@ -10,18 +10,18 @@
 #include "wmi.h"
 #include "hw.h"
 #include "core.h"
-#include "testmode_i.h"
+#include "../testmode_i.h"
 
 #define ATH11K_FTM_SEGHDR_CURRENT_SEQ		GENMASK(3, 0)
 #define ATH11K_FTM_SEGHDR_TOTAL_SEGMENTS	GENMASK(7, 4)
 
-static const struct nla_policy ath11k_tm_policy[ATH11K_TM_ATTR_MAX + 1] = {
-	[ATH11K_TM_ATTR_CMD]		= { .type = NLA_U32 },
-	[ATH11K_TM_ATTR_DATA]		= { .type = NLA_BINARY,
-					    .len = ATH11K_TM_DATA_MAX_LEN },
-	[ATH11K_TM_ATTR_WMI_CMDID]	= { .type = NLA_U32 },
-	[ATH11K_TM_ATTR_VERSION_MAJOR]	= { .type = NLA_U32 },
-	[ATH11K_TM_ATTR_VERSION_MINOR]	= { .type = NLA_U32 },
+static const struct nla_policy ath11k_tm_policy[ATH_TM_ATTR_MAX + 1] = {
+	[ATH_TM_ATTR_CMD]		= { .type = NLA_U32 },
+	[ATH_TM_ATTR_DATA]		= { .type = NLA_BINARY,
+					    .len = ATH_TM_DATA_MAX_LEN },
+	[ATH_TM_ATTR_WMI_CMDID]		= { .type = NLA_U32 },
+	[ATH_TM_ATTR_VERSION_MAJOR]	= { .type = NLA_U32 },
+	[ATH_TM_ATTR_VERSION_MINOR]	= { .type = NLA_U32 },
 };
 
 static struct ath11k *ath11k_tm_get_ar(struct ath11k_base *ab)
@@ -73,9 +73,9 @@ static void ath11k_tm_wmi_event_unsegmented(struct ath11k_base *ab, u32 cmd_id,
 		goto out;
 	}
 
-	if (nla_put_u32(nl_skb, ATH11K_TM_ATTR_CMD, ATH11K_TM_CMD_WMI) ||
-	    nla_put_u32(nl_skb, ATH11K_TM_ATTR_WMI_CMDID, cmd_id) ||
-	    nla_put(nl_skb, ATH11K_TM_ATTR_DATA, skb->len, skb->data)) {
+	if (nla_put_u32(nl_skb, ATH_TM_ATTR_CMD, ATH_TM_CMD_WMI) ||
+	    nla_put_u32(nl_skb, ATH_TM_ATTR_WMI_CMDID, cmd_id) ||
+	    nla_put(nl_skb, ATH_TM_ATTR_DATA, skb->len, skb->data)) {
 		ath11k_warn(ab, "failed to populate testmode unsegmented event\n");
 		kfree_skb(nl_skb);
 		goto out;
@@ -140,7 +140,7 @@ static int ath11k_tm_process_event(struct ath11k_base *ab, u32 cmd_id,
 
 	data_pos = ab->testmode.data_pos;
 
-	if ((data_pos + datalen) > ATH11K_FTM_EVENT_MAX_BUF_LENGTH) {
+	if ((data_pos + datalen) > ATH_FTM_EVENT_MAX_BUF_LENGTH) {
 		ath11k_warn(ab, "Invalid ftm event length at %d: %d\n",
 			    data_pos, datalen);
 		ret = -EINVAL;
@@ -172,10 +172,10 @@ static int ath11k_tm_process_event(struct ath11k_base *ab, u32 cmd_id,
 		goto out;
 	}
 
-	if (nla_put_u32(nl_skb, ATH11K_TM_ATTR_CMD,
-			ATH11K_TM_CMD_WMI_FTM) ||
-	    nla_put_u32(nl_skb, ATH11K_TM_ATTR_WMI_CMDID, cmd_id) ||
-	    nla_put(nl_skb, ATH11K_TM_ATTR_DATA, data_pos,
+	if (nla_put_u32(nl_skb, ATH_TM_ATTR_CMD,
+			ATH_TM_CMD_WMI_FTM) ||
+	    nla_put_u32(nl_skb, ATH_TM_ATTR_WMI_CMDID, cmd_id) ||
+	    nla_put(nl_skb, ATH_TM_ATTR_DATA, data_pos,
 		    &ab->testmode.eventdata[0])) {
 		ath11k_warn(ab, "failed to populate segmented testmode event");
 		kfree_skb(nl_skb);
@@ -235,23 +235,23 @@ static int ath11k_tm_cmd_get_version(struct ath11k *ar, struct nlattr *tb[])
 
 	ath11k_dbg(ar->ab, ATH11K_DBG_TESTMODE,
 		   "cmd get version_major %d version_minor %d\n",
-		   ATH11K_TESTMODE_VERSION_MAJOR,
-		   ATH11K_TESTMODE_VERSION_MINOR);
+		   ATH_TESTMODE_VERSION_MAJOR,
+		   ATH_TESTMODE_VERSION_MINOR);
 
 	skb = cfg80211_testmode_alloc_reply_skb(ar->hw->wiphy,
 						nla_total_size(sizeof(u32)));
 	if (!skb)
 		return -ENOMEM;
 
-	ret = nla_put_u32(skb, ATH11K_TM_ATTR_VERSION_MAJOR,
-			  ATH11K_TESTMODE_VERSION_MAJOR);
+	ret = nla_put_u32(skb, ATH_TM_ATTR_VERSION_MAJOR,
+			  ATH_TESTMODE_VERSION_MAJOR);
 	if (ret) {
 		kfree_skb(skb);
 		return ret;
 	}
 
-	ret = nla_put_u32(skb, ATH11K_TM_ATTR_VERSION_MINOR,
-			  ATH11K_TESTMODE_VERSION_MINOR);
+	ret = nla_put_u32(skb, ATH_TM_ATTR_VERSION_MINOR,
+			  ATH_TESTMODE_VERSION_MINOR);
 	if (ret) {
 		kfree_skb(skb);
 		return ret;
@@ -277,7 +277,7 @@ static int ath11k_tm_cmd_testmode_start(struct ath11k *ar, struct nlattr *tb[])
 		goto err;
 	}
 
-	ar->ab->testmode.eventdata = kzalloc(ATH11K_FTM_EVENT_MAX_BUF_LENGTH,
+	ar->ab->testmode.eventdata = kzalloc(ATH_FTM_EVENT_MAX_BUF_LENGTH,
 					     GFP_KERNEL);
 	if (!ar->ab->testmode.eventdata) {
 		ret = -ENOMEM;
@@ -310,25 +310,25 @@ static int ath11k_tm_cmd_wmi(struct ath11k *ar, struct nlattr *tb[],
 
 	mutex_lock(&ar->conf_mutex);
 
-	if (!tb[ATH11K_TM_ATTR_DATA]) {
+	if (!tb[ATH_TM_ATTR_DATA]) {
 		ret = -EINVAL;
 		goto out;
 	}
 
-	if (!tb[ATH11K_TM_ATTR_WMI_CMDID]) {
+	if (!tb[ATH_TM_ATTR_WMI_CMDID]) {
 		ret = -EINVAL;
 		goto out;
 	}
 
-	buf = nla_data(tb[ATH11K_TM_ATTR_DATA]);
-	buf_len = nla_len(tb[ATH11K_TM_ATTR_DATA]);
+	buf = nla_data(tb[ATH_TM_ATTR_DATA]);
+	buf_len = nla_len(tb[ATH_TM_ATTR_DATA]);
 	if (!buf_len) {
 		ath11k_warn(ar->ab, "No data present in testmode wmi command\n");
 		ret = -EINVAL;
 		goto out;
 	}
 
-	cmd_id = nla_get_u32(tb[ATH11K_TM_ATTR_WMI_CMDID]);
+	cmd_id = nla_get_u32(tb[ATH_TM_ATTR_WMI_CMDID]);
 
 	/* Make sure that the buffer length is long enough to
 	 * hold TLV and pdev/vdev id.
@@ -409,13 +409,13 @@ static int ath11k_tm_cmd_wmi_ftm(struct ath11k *ar, struct nlattr *tb[])
 		goto out;
 	}
 
-	if (!tb[ATH11K_TM_ATTR_DATA]) {
+	if (!tb[ATH_TM_ATTR_DATA]) {
 		ret = -EINVAL;
 		goto out;
 	}
 
-	buf = nla_data(tb[ATH11K_TM_ATTR_DATA]);
-	buf_len = nla_len(tb[ATH11K_TM_ATTR_DATA]);
+	buf = nla_data(tb[ATH_TM_ATTR_DATA]);
+	buf_len = nla_len(tb[ATH_TM_ATTR_DATA]);
 	cmd_id = WMI_PDEV_UTF_CMDID;
 
 	ath11k_dbg(ar->ab, ATH11K_DBG_TESTMODE,
@@ -476,25 +476,25 @@ int ath11k_tm_cmd(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 		  void *data, int len)
 {
 	struct ath11k *ar = hw->priv;
-	struct nlattr *tb[ATH11K_TM_ATTR_MAX + 1];
+	struct nlattr *tb[ATH_TM_ATTR_MAX + 1];
 	int ret;
 
-	ret = nla_parse(tb, ATH11K_TM_ATTR_MAX, data, len, ath11k_tm_policy,
+	ret = nla_parse(tb, ATH_TM_ATTR_MAX, data, len, ath11k_tm_policy,
 			NULL);
 	if (ret)
 		return ret;
 
-	if (!tb[ATH11K_TM_ATTR_CMD])
+	if (!tb[ATH_TM_ATTR_CMD])
 		return -EINVAL;
 
-	switch (nla_get_u32(tb[ATH11K_TM_ATTR_CMD])) {
-	case ATH11K_TM_CMD_GET_VERSION:
+	switch (nla_get_u32(tb[ATH_TM_ATTR_CMD])) {
+	case ATH_TM_CMD_GET_VERSION:
 		return ath11k_tm_cmd_get_version(ar, tb);
-	case ATH11K_TM_CMD_WMI:
+	case ATH_TM_CMD_WMI:
 		return ath11k_tm_cmd_wmi(ar, tb, vif);
-	case ATH11K_TM_CMD_TESTMODE_START:
+	case ATH_TM_CMD_TESTMODE_START:
 		return ath11k_tm_cmd_testmode_start(ar, tb);
-	case ATH11K_TM_CMD_WMI_FTM:
+	case ATH_TM_CMD_WMI_FTM:
 		return ath11k_tm_cmd_wmi_ftm(ar, tb);
 	default:
 		return -EOPNOTSUPP;
diff --git a/drivers/net/wireless/ath/ath11k/testmode_i.h b/drivers/net/wireless/ath/testmode_i.h
similarity index 50%
rename from drivers/net/wireless/ath/ath11k/testmode_i.h
rename to drivers/net/wireless/ath/testmode_i.h
index 91b83873d660..b8fa5092e6ca 100644
--- a/drivers/net/wireless/ath/ath11k/testmode_i.h
+++ b/drivers/net/wireless/ath/testmode_i.h
@@ -1,59 +1,59 @@
 /* SPDX-License-Identifier: BSD-3-Clause-Clear */
 /*
  * Copyright (c) 2018-2019 The Linux Foundation. All rights reserved.
- * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2023-2024 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
-/* "API" level of the ath11k testmode interface. Bump it after every
+/* "API" level of the ath testmode interface. Bump it after every
  * incompatible interface change.
  */
-#define ATH11K_TESTMODE_VERSION_MAJOR 1
+#define ATH_TESTMODE_VERSION_MAJOR 1
 
 /* Bump this after every _compatible_ interface change, for example
  * addition of a new command or an attribute.
  */
-#define ATH11K_TESTMODE_VERSION_MINOR 1
+#define ATH_TESTMODE_VERSION_MINOR 1
 
-#define ATH11K_TM_DATA_MAX_LEN		5000
-#define ATH11K_FTM_EVENT_MAX_BUF_LENGTH 2048
+#define ATH_TM_DATA_MAX_LEN		5000
+#define ATH_FTM_EVENT_MAX_BUF_LENGTH	2048
 
-enum ath11k_tm_attr {
-	__ATH11K_TM_ATTR_INVALID		= 0,
-	ATH11K_TM_ATTR_CMD			= 1,
-	ATH11K_TM_ATTR_DATA			= 2,
-	ATH11K_TM_ATTR_WMI_CMDID		= 3,
-	ATH11K_TM_ATTR_VERSION_MAJOR		= 4,
-	ATH11K_TM_ATTR_VERSION_MINOR		= 5,
-	ATH11K_TM_ATTR_WMI_OP_VERSION		= 6,
+enum ath_tm_attr {
+	__ATH_TM_ATTR_INVALID		= 0,
+	ATH_TM_ATTR_CMD			= 1,
+	ATH_TM_ATTR_DATA		= 2,
+	ATH_TM_ATTR_WMI_CMDID		= 3,
+	ATH_TM_ATTR_VERSION_MAJOR	= 4,
+	ATH_TM_ATTR_VERSION_MINOR	= 5,
+	ATH_TM_ATTR_WMI_OP_VERSION	= 6,
 
 	/* keep last */
-	__ATH11K_TM_ATTR_AFTER_LAST,
-	ATH11K_TM_ATTR_MAX		= __ATH11K_TM_ATTR_AFTER_LAST - 1,
+	__ATH_TM_ATTR_AFTER_LAST,
+	ATH_TM_ATTR_MAX			= __ATH_TM_ATTR_AFTER_LAST - 1,
 };
 
-/* All ath11k testmode interface commands specified in
- * ATH11K_TM_ATTR_CMD
+/* All ath testmode interface commands specified in
+ * ATH_TM_ATTR_CMD
  */
-enum ath11k_tm_cmd {
-	/* Returns the supported ath11k testmode interface version in
-	 * ATH11K_TM_ATTR_VERSION. Always guaranteed to work. User space
+enum ath_tm_cmd {
+	/* Returns the supported ath testmode interface version in
+	 * ATH_TM_ATTR_VERSION. Always guaranteed to work. User space
 	 * uses this to verify it's using the correct version of the
 	 * testmode interface
 	 */
-	ATH11K_TM_CMD_GET_VERSION = 0,
+	ATH_TM_CMD_GET_VERSION = 0,
 
 	/* The command used to transmit a WMI command to the firmware and
 	 * the event to receive WMI events from the firmware. Without
 	 * struct wmi_cmd_hdr header, only the WMI payload. Command id is
-	 * provided with ATH11K_TM_ATTR_WMI_CMDID and payload in
-	 * ATH11K_TM_ATTR_DATA.
+	 * provided with ATH_TM_ATTR_WMI_CMDID and payload in
+	 * ATH_TM_ATTR_DATA.
 	 */
-	ATH11K_TM_CMD_WMI = 1,
+	ATH_TM_CMD_WMI = 1,
 
 	/* Boots the UTF firmware, the netdev interface must be down at the
 	 * time.
 	 */
-	ATH11K_TM_CMD_TESTMODE_START = 2,
+	ATH_TM_CMD_TESTMODE_START = 2,
 
 	/* The command used to transmit a FTM WMI command to the firmware
 	 * and the event to receive WMI events from the firmware. The data
@@ -62,5 +62,5 @@ enum ath11k_tm_cmd {
 	 * The data payload size could be large and the driver needs to
 	 * send segmented data to firmware.
 	 */
-	ATH11K_TM_CMD_WMI_FTM = 3,
+	ATH_TM_CMD_WMI_FTM = 3,
 };
-- 
2.34.1


