Return-Path: <linux-wireless+bounces-17311-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D1DFA08EFD
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Jan 2025 12:19:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7211188A124
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Jan 2025 11:19:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5715620A5C2;
	Fri, 10 Jan 2025 11:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="RXDHhraP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A1E205AA7
	for <linux-wireless@vger.kernel.org>; Fri, 10 Jan 2025 11:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736507950; cv=none; b=XK/OTJyCn4OKAg1IAbQS6bdvmsXp3gaXor5XTdVes+kLhV5VCQSV1mWwcRAa5XFHdX5x9tNSE+r24zilAWF+h8WIDdWeUVQcNyIdYtglGvR56ZJgIS01Gg6bT+pGYcYjLvsdTuuEoIFe7vbl6mdpUFPgOzI/jPCO8FTgRV1nDhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736507950; c=relaxed/simple;
	bh=uvAyRCe9gYFw69puc6NVQRGagLMWMORlCjMjKegTSj8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aqarE54uuIivokfX+k4KTsa8Zf7cO6FJwsCGyhrixDecxoLK2ziLjs33c4CDe0FQOGBmALOIWpL0uBfL24BrrUWfi4vO7REiUEbtgw9fZnG7RZhpzXszVr6JROMbCMeu792u1fJAnhNoIA8R9+wObtrxMgAzkq9I5xUYHQxUh6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=RXDHhraP; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50A9rpCx027024;
	Fri, 10 Jan 2025 11:19:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	e4duurbcBjkWrcftjTacGV2sZKzcrgSgGmVYOsc2KsY=; b=RXDHhraPpqPJQ8qP
	iQaqrPvQLqvOwwMsNYTZJY+LFbQi9yJq8gdfR9GyrGWNrrlKBY67/aPhrBdKYTRU
	AbHg9b/e0rO0eK80uBMnsAWOxz66rFMpm50idIVxat0vAJINW2/x+v1G0fgzFFGm
	pegrSjzVX1lJ3BcO9zWtGtY9Ot97tl8AKCUuWkCc9bGLaZpCc7NQcEln1h6k6d1r
	hmAJzljhqBFuztnzhFuN8zLe1CGAS0IaXucw3wqKWR7XnGVL/IRnDuA4Bnin7ilk
	Rbx3hg+Gm1NOqQB3l7cY9eebA+8GVHz1vBwVO0xKsz/QWx+Mhfw5UhYZn2n4pTNO
	8+IPUA==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4431as06ym-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Jan 2025 11:19:05 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50ABJ4Ls019591
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Jan 2025 11:19:04 GMT
Received: from hu-aarasahu-blr.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 10 Jan 2025 03:19:03 -0800
From: Aaradhana Sahu <quic_aarasahu@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Aaradhana Sahu
	<quic_aarasahu@quicinc.com>
Subject: [PATCH v8 1/5] wifi: ath: create common testmode_i.h file for ath drivers
Date: Fri, 10 Jan 2025 16:48:41 +0530
Message-ID: <20250110111845.2920741-2-quic_aarasahu@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250110111845.2920741-1-quic_aarasahu@quicinc.com>
References: <20250110111845.2920741-1-quic_aarasahu@quicinc.com>
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
X-Proofpoint-GUID: kQ03GkvHJLlt9O0NJXPCn-8cEAGyVDrv
X-Proofpoint-ORIG-GUID: kQ03GkvHJLlt9O0NJXPCn-8cEAGyVDrv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 spamscore=0 mlxscore=0 priorityscore=1501 phishscore=0
 mlxlogscore=999 suspectscore=0 malwarescore=0 bulkscore=0 impostorscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501100088

User space application requires that the testmode interface
is exactly same between ath drivers. Move testmode_i.h file
in ath directory to ensure that all ath driver uses same testmode
interface instead of duplicating testmode_i.h for each ath drivers.

Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.7.0.1-01744-QCAHKSWPL_SILICONZ-1
Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1

Signed-off-by: Aaradhana Sahu <quic_aarasahu@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/testmode.c    | 80 +++++++++----------
 .../wireless/ath/{ath11k => }/testmode_i.h    | 54 ++++++-------
 2 files changed, 67 insertions(+), 67 deletions(-)
 rename drivers/net/wireless/ath/{ath11k => }/testmode_i.h (50%)

diff --git a/drivers/net/wireless/ath/ath11k/testmode.c b/drivers/net/wireless/ath/ath11k/testmode.c
index 302d66092b97..9be1cd742339 100644
--- a/drivers/net/wireless/ath/ath11k/testmode.c
+++ b/drivers/net/wireless/ath/ath11k/testmode.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (c) 2018-2019 The Linux Foundation. All rights reserved.
- * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2023-2025 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #include "testmode.h"
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
index 91b83873d660..980ef2f3f05f 100644
--- a/drivers/net/wireless/ath/ath11k/testmode_i.h
+++ b/drivers/net/wireless/ath/testmode_i.h
@@ -1,59 +1,59 @@
 /* SPDX-License-Identifier: BSD-3-Clause-Clear */
 /*
  * Copyright (c) 2018-2019 The Linux Foundation. All rights reserved.
- * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2023-2025 Qualcomm Innovation Center, Inc. All rights reserved.
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


