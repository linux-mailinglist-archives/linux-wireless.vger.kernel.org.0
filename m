Return-Path: <linux-wireless+bounces-8899-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AF7F905EDB
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Jun 2024 00:54:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EA8D1C21246
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Jun 2024 22:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8C8112C470;
	Wed, 12 Jun 2024 22:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="YfanuPq7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ADAB12C482
	for <linux-wireless@vger.kernel.org>; Wed, 12 Jun 2024 22:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718232835; cv=none; b=LmW8UGhCEp65q7xPnRdVxwuE8+VuW41yR5PDe1g8qp6WKbhxr6yqaS/+Wzqogiu5nB+dfpR75GxhDJCiQHnhuMdNtyFMINEgpJDJKqCa6g08m/QwomqB23WNcdfgl42dvOxcsrQD1kVlXId6cNPxA0XVIug8VP08uTPDim1d0eU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718232835; c=relaxed/simple;
	bh=VIlf6vl1Zp7Mo84TH0+NMlLJLgIcyExQHN0OS0q2m60=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qCitnzF/u8eZv4VpNTh3OXOSROl/i4W298z4CJv2VB/oq2lMYugVkD3bqLH/mKcRy5tau1+3rg6wiH1nDprjepqkvKjeTJElUqw4N8YifShvTsLfE0Q2qlAmYAZLqU3TNpw9JhFvWFh62OLMFXBll+5bJw7Qtm+YcWFgr1Fa9ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=YfanuPq7; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45CKn7OM001101;
	Wed, 12 Jun 2024 22:53:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=9oYa6tI8cO56ucuYhLoP+I
	EPcoOWM0YoZSeApoHMRKI=; b=YfanuPq75pYlAGDlKSpLa7RxVcZRySXrnl1Alc
	/wV/o4/DY3siVAj4bwR9G4H5RygYFOEFy6FIDuA/ryOE+lpU41OGIScc1B9W9Hpq
	hGPa+njpREzKQU3U0SUPVx3IZsmdAKai3lVX+WNiaqLw6hDEX/dtH4tKYXH+Xt9v
	BQIG/24ldUdJsk7qTGyRx+m9hm3f82Fo/Z3MuwgHxmzXNnhHJBWgafnVOvNhSb4x
	IzdL33cDnqYGQ5HFUbiyLjwpM3C7jr7YKrL3jgaMy7ueM6RVC2XzFCxanhTBs0K+
	yZmFpWpmutuE+s7S5xbx3IHXVAAHIxNslauTfAqLxat3lDqg==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ypp87vtey-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Jun 2024 22:53:48 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45CMrlO6003753
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Jun 2024 22:53:47 GMT
Received: from pradeepc-linux2.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 12 Jun 2024 15:53:46 -0700
From: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Pradeep Kumar Chitrapu
	<quic_pradeepc@quicinc.com>,
        Aditya Kumar Singh <quic_adisi@quicinc.com>,
        Zachary Smith <dr.z.smith@gmail.com>
Subject: [PATCH] wifi: ath12k: fix legacy peer association due to missing HT or 6 GHz capabilities
Date: Wed, 12 Jun 2024 15:53:36 -0700
Message-ID: <20240612225336.2303119-1-quic_pradeepc@quicinc.com>
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
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: lYkiXREXHhJstBfT943psHOzJECjmfb3
X-Proofpoint-ORIG-GUID: lYkiXREXHhJstBfT943psHOzJECjmfb3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-12_10,2024-06-12_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 malwarescore=0
 spamscore=0 suspectscore=0 mlxlogscore=999 priorityscore=1501 adultscore=0
 bulkscore=0 mlxscore=0 clxscore=1011 impostorscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2405170001
 definitions=main-2406120163

Currently SMPS configuration failed when the Information
Elements (IEs) did not contain HT or 6 GHz capabilities. This
caused legacy peer association to fail as legacy peers do not
have HT or 6 GHz capabilities. Fix this by not returning an
error when SMPS configuration fails due to the absence of HT
or 6 GHz capabilities.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1

Fixes: f0e61dc7ecf9 ("wifi: ath12k: refactor SMPS configuration")
Reported-by: Aditya Kumar Singh <quic_adisi@quicinc.com>
Reported-by: Zachary Smith <dr.z.smith@gmail.com>
Closes: https://lore.kernel.org/all/CAM=znoFPcXrn5GhDmDmo50Syic3-hXpWvD+vkv8KX5o_ZTo8kQ@mail.gmail.com/
Signed-off-by: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 2259ce22cc8b..fa9f6656a06f 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -2255,9 +2255,6 @@ static int ath12k_get_smps_from_capa(const struct ieee80211_sta_ht_cap *ht_cap,
 				     const struct ieee80211_he_6ghz_capa *he_6ghz_capa,
 				     int *smps)
 {
-	if (!ht_cap->ht_supported && !he_6ghz_capa->capa)
-		return -EOPNOTSUPP;
-
 	if (ht_cap->ht_supported)
 		*smps = u16_get_bits(ht_cap->cap, IEEE80211_HT_CAP_SM_PS);
 	else
@@ -2277,6 +2274,9 @@ static void ath12k_peer_assoc_h_smps(struct ieee80211_sta *sta,
 	const struct ieee80211_sta_ht_cap *ht_cap = &sta->deflink.ht_cap;
 	int smps;
 
+	if (!ht_cap->ht_supported && !he_6ghz_capa->capa)
+		return;
+
 	if (ath12k_get_smps_from_capa(ht_cap, he_6ghz_capa, &smps))
 		return;
 
@@ -2756,6 +2756,9 @@ static int ath12k_setup_peer_smps(struct ath12k *ar, struct ath12k_vif *arvif,
 {
 	int smps, ret = 0;
 
+	if (!ht_cap->ht_supported && !he_6ghz_capa)
+		return 0;
+
 	ret = ath12k_get_smps_from_capa(ht_cap, he_6ghz_capa, &smps);
 	if (ret < 0)
 		return ret;

base-commit: e72048809ec7355a947415ae6836d2eb7fdcda39
-- 
2.34.1


