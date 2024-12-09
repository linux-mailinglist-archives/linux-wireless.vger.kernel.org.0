Return-Path: <linux-wireless+bounces-16001-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9F369E8944
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Dec 2024 03:42:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54F411885C31
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Dec 2024 02:42:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F06F44360;
	Mon,  9 Dec 2024 02:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="girPbniK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 652FC5A4D5
	for <linux-wireless@vger.kernel.org>; Mon,  9 Dec 2024 02:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733712124; cv=none; b=K0FngpIyhToMbUz97HRzTTEdfEskuT5NTUYDVHsQLnbvMzf5wbfM4Tfi/IgoXAUE/mNd5DtOk+U1hZQTbdzEXj+4nec4Ib9BQGegoTi9KPe0qsyg+A41qeY6TMPOZpk60kfZy1bt961Se1ygUtZ9vFuM/vXSmSc1T4w4GOb0MVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733712124; c=relaxed/simple;
	bh=26jEDUPX92YNWA8y+CzbDN1qkTyf49t6Wgg9LrunVmk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HQIuYA1Nfr6d5mrNMfmeSJ86bAUWI6B1no3F7HWjI1QAfDQpgWCMfPNEU8/EqgkdFqN5RzzDzzez3Guav0IoIDKVPz8Sn6Is1uZpbbMn7wtqZkrzERr1TOPrRwqfhYo91jSoUHGOsrDMmOOxJGe6lGOnDir2wC6FCzx5ukj32Es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=girPbniK; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B8MK1qg022735;
	Mon, 9 Dec 2024 02:41:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=5ktBAWct96S9fIp8SK/v2L
	JzzKjMOBuyw6DeKNeU8CE=; b=girPbniKiviosvBHko8L/4bsNTyjP5SfxB+kzz
	c/TDxbQSl///Be4zetS9kYGqxOlcqAWwBll9u2w9NmA4yoyXyerRqi1Pk/sCZtcG
	SfJgajOzOo7rP2UA0ZuXPW8u1VlHLjPMyAXOYkm/rWjJ0ZLjCiA3Is/hcxUtZauB
	md0RJvggCEXtE5+oSX5CoFTKhhKucZu0Iw0o26L4fGJ5OAm7xfK0x5PKNYROsIQA
	vhEGxBBUwf5mHG22fYZBtqF6CP2XKhkM4PJ25q6k9GUvUzvHOWQReGnYmmRfFBEw
	xFjZdMG7G9y9bAWxeRkhCi5PKuam26FLcNyNylj2UsRV+YSA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43cdpgk52k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Dec 2024 02:41:59 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4B92fwUA024931
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 9 Dec 2024 02:41:58 GMT
Received: from bqiang-SFF.qca.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Sun, 8 Dec 2024 18:41:57 -0800
From: Baochen Qiang <quic_bqiang@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <quic_bqiang@quicinc.com>
Subject: [PATCH] wifi: ath12k: use link specific bss_conf as well in ath12k_mac_vif_cache_flush()
Date: Mon, 9 Dec 2024 10:41:46 +0800
Message-ID: <20241209024146.3282-1-quic_bqiang@quicinc.com>
X-Mailer: git-send-email 2.25.1
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
X-Proofpoint-GUID: O6Mw8q3eumhi75wDSXAKEEzuH-nMt4av
X-Proofpoint-ORIG-GUID: O6Mw8q3eumhi75wDSXAKEEzuH-nMt4av
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 clxscore=1015 suspectscore=0 mlxscore=0 priorityscore=1501
 phishscore=0 mlxlogscore=999 spamscore=0 malwarescore=0 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412090021

Commit 3952657848c0 ("wifi: ath12k: Use mac80211 vif's link_conf instead of
bss_conf") aims at, where applicable, replacing all usage of vif's bss_conf
with link specific bss_conff, but missed one instance in
ath12k_mac_vif_cache_flush(). This results in wrong configurations passed
to ath12k_mac_bss_info_changed() when the link in question is not the default
link.

Change to use the link specific bss_conf to fix this issue.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4

Fixes: 3952657848c0 ("wifi: ath12k: Use mac80211 vif's link_conf instead of bss_conf")
Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index c4eab4c1c10e..629ce22f727a 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -7973,6 +7973,7 @@ static void ath12k_mac_vif_cache_flush(struct ath12k *ar, struct ath12k_link_vif
 	struct ieee80211_vif *vif = ath12k_ahvif_to_vif(ahvif);
 	struct ath12k_vif_cache *cache = ahvif->cache[arvif->link_id];
 	struct ath12k_base *ab = ar->ab;
+	struct ieee80211_bss_conf *link_conf;
 
 	int ret;
 
@@ -7991,7 +7992,13 @@ static void ath12k_mac_vif_cache_flush(struct ath12k *ar, struct ath12k_link_vif
 	}
 
 	if (cache->bss_conf_changed) {
-		ath12k_mac_bss_info_changed(ar, arvif, &vif->bss_conf,
+		link_conf = ath12k_mac_get_link_bss_conf(arvif);
+		if (!link_conf) {
+			ath12k_warn(ar->ab, "unable to access bss link conf in cache flush for vif %pM link %u\n",
+				    vif->addr, arvif->link_id);
+			return;
+		}
+		ath12k_mac_bss_info_changed(ar, arvif, link_conf,
 					    cache->bss_conf_changed);
 	}
 

base-commit: 400568fb3b022247c1603fdbdd6444b3ef14ffce
-- 
2.25.1


