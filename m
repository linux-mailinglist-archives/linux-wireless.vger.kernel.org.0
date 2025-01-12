Return-Path: <linux-wireless+bounces-17368-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F32EEA0A74E
	for <lists+linux-wireless@lfdr.de>; Sun, 12 Jan 2025 06:50:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4B831655C2
	for <lists+linux-wireless@lfdr.de>; Sun, 12 Jan 2025 05:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A9EF146D6A;
	Sun, 12 Jan 2025 05:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="jjiMkytw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B061A145FE8;
	Sun, 12 Jan 2025 05:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736661009; cv=none; b=Ruvxcl3qRf+i8RJKTnSXz/Pu7QKFP32Y/9aPQB6p4NIt+0A8h6Ghh5oUrP5jcp9FcBDe4oGlLcqt4Gu/WpXNHP9KhNA301FQ0yeAk1z5Ussu2NGxU25aGaX/G/tqGPQDVFbt1w0rsEETju8BD/ZiZD6yX2OAWkWkO2t1hNZ9uIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736661009; c=relaxed/simple;
	bh=zz/NnMJCVtYhrAPKbbRDt1zaZOkEZaoEMOJdbb4biQo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=AOvXr8QwXlB3EhjrTDXIrrtke7zz10Ro4nvnWyImXaZjj9JQ+x5DMzoKMBdqSG6KyfSRoaPq0UpI/3hoder3vGGEmVrnbNwl+Ty9mFTxI4H9BM9gcmRJwqvbVdXPk8bHJgmxAzuqAR5W4kKIiTNCKarY1Jh8dn2SGfISopMOb64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=jjiMkytw; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50C4idGG016323;
	Sun, 12 Jan 2025 05:49:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=VtVKi/vRwZXgAU9wodaPKD
	0j9pv33+qWADe8hElvCqo=; b=jjiMkytwcMfni2XgFL4lZIQgO323CiYNTudtYb
	8b7AC7Bhe7HCmeM0QdYd1o025xZb/LemGpvtaJCzN/d3iK7WquTnekE7QvC6yKkO
	Yk5hGxyyvpMzPUZUZvMcKcTdts0MP+MuXKfj3OgRkGlYSbYDnhEAGGxfY+A1m4HA
	oUEtted4b0WKizFPPetwoYtqi3+bVLH2129w8uu2BvDf5jjP12yxJyNOWcwV85xV
	PjJ9p/Q3hTiomkJCY/viXm2rpoQu2XlgS+UZMCyzoK/85KJnKcT4Egboic/3jwBp
	3BJozCndHSDcIvuSYc68YWadp73WBIo8OIK46OGEC4Wn5tQw==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 443hj2skq3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 12 Jan 2025 05:49:58 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50C5nvJf030090
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 12 Jan 2025 05:49:57 GMT
Received: from hu-adisi-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Sat, 11 Jan 2025 21:49:54 -0800
From: Aditya Kumar Singh <quic_adisi@quicinc.com>
Date: Sun, 12 Jan 2025 11:19:42 +0530
Subject: [PATCH] wifi: ath12k: fix key cache handling
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250112-fix_key_cache_handling-v1-1-aa952cd3c368@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAPZXg2cC/x2MQQqAIBAAvxJ7TnANO/SVCEnbaiksFKKQ/t7Sc
 WBmCmRKTBm6qkCiizMfUQDrCsI6xoUUT8JgtLEa0aiZb7fR48IYVnKiTDvHRaE3DWrdepwtSHw
 mEvMf98P7ftPKSDBoAAAA
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
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: cmsYtSWm6nWpwuWAklN8rRTKqhNDBXoS
X-Proofpoint-ORIG-GUID: cmsYtSWm6nWpwuWAklN8rRTKqhNDBXoS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 clxscore=1015
 mlxscore=0 phishscore=0 mlxlogscore=999 adultscore=0 malwarescore=0
 bulkscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2411120000 definitions=main-2501120049

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
 drivers/net/wireless/ath/ath12k/mac.c | 30 ++++++++++++++++++------------
 1 file changed, 18 insertions(+), 12 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 48d110e2a7ded61c4094b0ce7e5bbb50b94d5cd4..01c688c29b6d02785a2b37e36ed423a2eb37e33b 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
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


