Return-Path: <linux-wireless+bounces-17369-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CB40A0A750
	for <lists+linux-wireless@lfdr.de>; Sun, 12 Jan 2025 06:53:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D8EDD7A3095
	for <lists+linux-wireless@lfdr.de>; Sun, 12 Jan 2025 05:53:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C56E114830A;
	Sun, 12 Jan 2025 05:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="O+QxPkbr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13270ECF;
	Sun, 12 Jan 2025 05:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736661205; cv=none; b=GS+sQH6xs5ob6MkOuLVQxdQaAJXK1DOIFyLSTYtc9SLgR0GAZv7CqQsRzc2vyHa3CTWAOUBheZR17Fg0RND90K+F88QZ34PboMfBI16sDc1fJPGLgSKdFgsO0usbUWsZTQq+NflCYjCEXbdrQ7jsfXT9WYpoMzb/SyhUR2913Fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736661205; c=relaxed/simple;
	bh=tWrxms+rxb1ht8Hw+RtRM+i+vK7eTZ3qIeY1sorRThw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=gB0qSXgLug+fOZwkwGVb9pQrdksEY9PX5uIZRcxY/MkhFVqnxD9g43DWyKtObezSybMV9EoyNui4F5pf1E46pGpV/sg+J8th69cKvmXrEhnfFvRGmuBesV/0Zjd9hrKOOpvrM1TV/J4segrv/YwrPvIqFTToXfuOc4lGbYVIaUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=O+QxPkbr; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50C4tIi2020754;
	Sun, 12 Jan 2025 05:53:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=rE9EtEQzv33/K9WiKV7Omy
	HBJiUvIKl7ximc6ShfFv8=; b=O+QxPkbrJxqH4SaB9ugkEhKU+vtveaNKK8/QVk
	EPus8dRQehwMFDg8/4dIRiJ177GUaj/wfRqcoC+zUtwUu6QQ5h6IuDKJsm94H4Gi
	GPnYW2xbCy35ftva+1XTxpIDfk2hfDN/s3y5qJcohQz2Mlc1ieazRtShp4FRkSTR
	Dhk0Gj/CCfudcf8EhOWI3AxDuTatN9/JpQbghUkI+IXO1F6nhFzB51OBQgQxleU1
	aVDPPnFB+P3XYVCEG/9JoKRUK1iDDk/Oyzey5KwBlZiz7ud9XLfQojG+XcWtXGIp
	3An+8TK4X2qmKedBB8BJvFMQb5VfVtgntSenRAYYadnQ/dyA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 443hkj9m0n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 12 Jan 2025 05:53:14 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50C5rDdB026255
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 12 Jan 2025 05:53:13 GMT
Received: from hu-adisi-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Sat, 11 Jan 2025 21:53:10 -0800
From: Aditya Kumar Singh <quic_adisi@quicinc.com>
Date: Sun, 12 Jan 2025 11:23:00 +0530
Subject: [PATCH v2] wifi: ath12k: fix key cache handling
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250112-fix_key_cache_handling-v2-1-70e142c6153e@quicinc.com>
X-B4-Tracking: v=1; b=H4sIALtYg2cC/4WNUQ6CMBBEr0L225puCUT98h6GkLJdYKMWbZVIS
 O9u5QJ+vsnMmxUiB+EIp2KFwLNEmXwGsyuARusHVuIyg9Gm0ohG9fJpr7y0ZGnkNlfcTfygsDM
 lal132FeQx4/AubmJL03mUeJrCsv2M+Mv/aucUaGy9lgZciWV9eH8fAuJpz1Nd2hSSl/C6n95v
 gAAAA==
X-Change-ID: 20250112-fix_key_cache_handling-1b231006b1f5
To: Kalle Valo <kvalo@kernel.org>, Jeff Johnson <jjohnson@kernel.org>,
        Rameshkumar Sundaram <quic_ramess@quicinc.com>
CC: Kalle Valo <quic_kvalo@quicinc.com>,
        Jeff Johnson
	<quic_jjohnson@quicinc.com>,
        <linux-wireless@vger.kernel.org>, <ath12k@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        "Aditya Kumar
 Singh" <quic_adisi@quicinc.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: hiQxdz3Ir6eDcKEEaGBK2fjuySzlSkfm
X-Proofpoint-ORIG-GUID: hiQxdz3Ir6eDcKEEaGBK2fjuySzlSkfm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 priorityscore=1501 bulkscore=0
 clxscore=1015 lowpriorityscore=0 adultscore=0 suspectscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501120049

Currently, an interface is created in the driver during channel assignment.
If mac80211 attempts to set a key for an interface before this assignment,
the driver caches the key. Once the interface is created, the driver
installs the cached key to the hardware. This sequence is exemplified in
mesh mode operation where the group key is set before channel assignment.

However, in ath12k_mac_update_key_cache(), after caching the key, due to
incorrect logic, it is deleted from the cache during the subsequent loop
iteration. As a result, after the interface is created, the driver does not
find any cached key, and the key is not installed to the hardware which is
wrong. This leads to issue in mesh, where broadcast traffic is not
encrypted over the air.

Fix this issue by adjusting the logic of ath12k_mac_update_key_cache()
properly.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1

Fixes: 25e18b9d6b4b ("wifi: ath12k: modify ath12k_mac_op_set_key() for MLO")
Signed-off-by: Aditya Kumar Singh <quic_adisi@quicinc.com>
---
Changes in v2:
- Add 2025 Copyright
---
 drivers/net/wireless/ath/ath12k/mac.c | 32 +++++++++++++++++++-------------
 1 file changed, 19 insertions(+), 13 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 48d110e2a7ded61c4094b0ce7e5bbb50b94d5cd4..2cd94405606f4236b3a18f8a42e53cecd5931e4a 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (c) 2018-2021 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2024 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2021-2025 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #include <net/mac80211.h>
@@ -4657,7 +4657,23 @@ static int ath12k_mac_update_key_cache(struct ath12k_vif_cache *cache,
 				       struct ieee80211_sta *sta,
 				       struct ieee80211_key_conf *key)
 {
-	struct ath12k_key_conf *key_conf = NULL, *tmp;
+	struct ath12k_key_conf *key_conf, *tmp;
+
+	list_for_each_entry_safe(key_conf, tmp, &cache->key_conf.list, list) {
+		if (key_conf->key != key)
+			continue;
+
+		/* If SET key entry is already present in cache, nothing to do,
+		 * just return
+		 */
+		if (cmd == SET_KEY)
+			return 0;
+
+		/* DEL key for an old SET key which driver hasn't flushed yet.
+		 */
+		list_del(&key_conf->list);
+		kfree(key_conf);
+	}
 
 	if (cmd == SET_KEY) {
 		key_conf = kzalloc(sizeof(*key_conf), GFP_KERNEL);
@@ -4671,17 +4687,7 @@ static int ath12k_mac_update_key_cache(struct ath12k_vif_cache *cache,
 		list_add_tail(&key_conf->list,
 			      &cache->key_conf.list);
 	}
-	if (list_empty(&cache->key_conf.list))
-		return 0;
-	list_for_each_entry_safe(key_conf, tmp, &cache->key_conf.list, list) {
-		if (key_conf->key == key) {
-			/* DEL key for an old SET key which driver hasn't flushed yet.
-			 */
-			list_del(&key_conf->list);
-			kfree(key_conf);
-			break;
-		}
-	}
+
 	return 0;
 }
 

---
base-commit: 0c5fcd9069dd5f984e39820629acbfbe0f1b4256
change-id: 20250112-fix_key_cache_handling-1b231006b1f5


