Return-Path: <linux-wireless+bounces-24480-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99B91AE82E5
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Jun 2025 14:40:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D89AD17DEA8
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Jun 2025 12:40:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B18A25B30D;
	Wed, 25 Jun 2025 12:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="o78QC3rL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A53E20ED;
	Wed, 25 Jun 2025 12:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750855241; cv=none; b=AQs/LN9GLQYiAoMclFZDh+1mlms1SNt1cxjZd4/Cjj77bMnJ6KlMQsuy6gtXrKdxoiC3J7YuzT8CAFGDse1htKlXn23g+NM/yLfQb0YR3yUh+eXGy5pH8FeAlVazNFCY8OduHG/lsF6DkFgBjZN9TwUnuK57p8zmemx/ol6Oc9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750855241; c=relaxed/simple;
	bh=y0hkaVwbnqtjs4vf13OkIMb+hHZDqL9yGEMEaQNX+AQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=X/4k3TsDSeSfbV8oFuALT4P4spqMBxj9ecNh4GyqEhMi0QR+Q0X/CZXA051+09m4gMzlSA82XMuNb0HtWMFpEgOxGrn2KFGm8RN/ZC4jkNzOb3SRSv6T/yoexyCLUHkvWBg7JZnMmr40DchJtRnG/Ow5h5LpRLrFVl02XapHOT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=o78QC3rL; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55P5ck7W014586;
	Wed, 25 Jun 2025 12:40:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=pn2rr8qtfR81HONg3c9HH9
	dcH2La71U/aphNpTb63L4=; b=o78QC3rL1dUz42XMZPUc6LO8yEK7vG0+Vourfj
	qULxw9PcTLDWATnFYeq5pyhzwq8FQQW8Yg4Idm5ryzwt62C+w634qYhWJDKmxDkd
	DPCJ3dOZvsfhcczBfDgxeQ7zIjhqn5f6OIJq+5QVEf9iX9kl0R8QJVpGmZRcnjzA
	sxGwSHk2xRGxf/4nJnG0lCdPlah06DHWooiBG52/WJ+/pZP/g/bkXR9sQzN3xEzN
	KXOuOBGctOy2jYuvmOxkjNMADtTYvRnConYUW0gcCbJQp17jKGpWhrhpuRmxLomB
	IvBn0LtL4a9iPLHo2+lguSlO9xIL2Yz8l57YDfj1ROpqjjFg==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47f2rq03w7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Jun 2025 12:40:29 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 55PCeSrV024905
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Jun 2025 12:40:28 GMT
Received: from zhonhan-gv.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 25 Jun 2025 05:40:26 -0700
From: Zhongqiu Han <quic_zhonhan@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_zhonhan@quicinc.com>
Subject: [PATCH] wifi: mac80211: zero-initialize frame_buf to prevent potential kernel stack data leak
Date: Wed, 25 Jun 2025 20:40:10 +0800
Message-ID: <20250625124010.2742027-1-quic_zhonhan@quicinc.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=NdDm13D4 c=1 sm=1 tr=0 ts=685bee3d cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=6IFa9wvqVegA:10 a=COk6AnOGAAAA:8 a=qN8r6Z1KdJKGFDsjT9sA:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI1MDA5MyBTYWx0ZWRfXxc7CRYbmD6nq
 9A5Jb0HSxmMQZORrf11ctqRtIhRRFYDtaqwN7uf0NBBVTx4AGG8ljij+Ha42+6aTKK0fdJMGi7J
 BGxpYNxn9NvxHAOCudp8NFWU/4LcdQ86Q0qVblyEG4+cwCUflF1YL2Yh+pMlqeoxieL9ttEsObr
 QO+Q8ZHZ56N7xsHHMTS8NFb6/9YrXZ5DdeK02OfVnYiCQ42l01MrngEzGms/bXa8nY5PR/4I2g5
 tCg+YLTxdRYfWaKYRqDu+T+2myIM0Fb6bkdWZthVDhFT7OrKp/Z1w0Ho/st7g+F6RFcg6F8q66E
 HaYkEziiDGjjrPt9lpKZr8+w0RMYIM+SdKM+di3Kh6xrwYp8V6hJ0XTL+nhFbo0HY1MD0k2rL+F
 h0qUspCR5nplSK9KGkiMFxtUxwRwUqlzt2uxIQxQXdb8tw9XG/ZYet1zHR/jq7ubFN3On2PW
X-Proofpoint-ORIG-GUID: ZcMybz-9hVftx9KjQJxBy9ZtekDhf9ZF
X-Proofpoint-GUID: ZcMybz-9hVftx9KjQJxBy9ZtekDhf9ZF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-25_03,2025-06-25_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 mlxscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 phishscore=0 priorityscore=1501 suspectscore=0 mlxlogscore=999 adultscore=0
 clxscore=1015 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506250093

In disconnection-related code paths, local frame buffers are used to build
deauthentication frames. If ieee80211_set_disassoc() fails to initialize
the buffer due to either an early return caused by a WARN_ON() or other
unexpected conditions, the buffer will remain uninitialized. It is then
passed to ieee80211_report_disconnect(), potentially exposing kernel stack
data to userspace, which could leak sensitive information or be exploited
to aid further attacks.

This patch ensures the buffers are explicitly zero-initialized to prevent
such data leaks.

Signed-off-by: Zhongqiu Han <quic_zhonhan@quicinc.com>
---
 net/mac80211/mlme.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 6001c8897d7c..96a7d92dcbe3 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -4447,7 +4447,7 @@ static void __ieee80211_disconnect(struct ieee80211_sub_if_data *sdata)
 {
 	struct ieee80211_local *local = sdata->local;
 	struct ieee80211_if_managed *ifmgd = &sdata->u.mgd;
-	u8 frame_buf[IEEE80211_DEAUTH_FRAME_LEN];
+	u8 frame_buf[IEEE80211_DEAUTH_FRAME_LEN] = {};
 
 	lockdep_assert_wiphy(local->hw.wiphy);
 
@@ -7214,7 +7214,7 @@ static void ieee80211_rx_mgmt_beacon(struct ieee80211_link_data *link,
 	u8 erp_value = 0;
 	u32 ncrc = 0;
 	u8 *bssid, *variable = mgmt->u.beacon.variable;
-	u8 deauth_buf[IEEE80211_DEAUTH_FRAME_LEN];
+	u8 deauth_buf[IEEE80211_DEAUTH_FRAME_LEN] = {};
 	struct ieee80211_elems_parse_params parse_params = {
 		.mode = link->u.mgd.conn.mode,
 		.link_id = -1,
@@ -8094,7 +8094,7 @@ static void ieee80211_sta_timer(struct timer_list *t)
 void ieee80211_sta_connection_lost(struct ieee80211_sub_if_data *sdata,
 				   u8 reason, bool tx)
 {
-	u8 frame_buf[IEEE80211_DEAUTH_FRAME_LEN];
+	u8 frame_buf[IEEE80211_DEAUTH_FRAME_LEN] = {};
 
 	ieee80211_set_disassoc(sdata, IEEE80211_STYPE_DEAUTH, reason,
 			       tx, frame_buf);
@@ -9090,7 +9090,7 @@ int ieee80211_mgd_auth(struct ieee80211_sub_if_data *sdata,
 		ieee80211_mark_sta_auth(sdata);
 
 	if (ifmgd->associated) {
-		u8 frame_buf[IEEE80211_DEAUTH_FRAME_LEN];
+		u8 frame_buf[IEEE80211_DEAUTH_FRAME_LEN] = {};
 
 		sdata_info(sdata,
 			   "disconnect from AP %pM for new auth to %pM\n",
@@ -9393,7 +9393,7 @@ int ieee80211_mgd_assoc(struct ieee80211_sub_if_data *sdata,
 	assoc_data->ext_mld_capa_ops = cpu_to_le16(req->ext_mld_capa_ops);
 
 	if (ifmgd->associated) {
-		u8 frame_buf[IEEE80211_DEAUTH_FRAME_LEN];
+		u8 frame_buf[IEEE80211_DEAUTH_FRAME_LEN] = {};
 
 		sdata_info(sdata,
 			   "disconnect from AP %pM for new assoc to %pM\n",
@@ -9724,7 +9724,7 @@ int ieee80211_mgd_deauth(struct ieee80211_sub_if_data *sdata,
 			 struct cfg80211_deauth_request *req)
 {
 	struct ieee80211_if_managed *ifmgd = &sdata->u.mgd;
-	u8 frame_buf[IEEE80211_DEAUTH_FRAME_LEN];
+	u8 frame_buf[IEEE80211_DEAUTH_FRAME_LEN] = {};
 	bool tx = !req->local_state_change;
 	struct ieee80211_prep_tx_info info = {
 		.subtype = IEEE80211_STYPE_DEAUTH,
@@ -9793,7 +9793,7 @@ int ieee80211_mgd_deauth(struct ieee80211_sub_if_data *sdata,
 int ieee80211_mgd_disassoc(struct ieee80211_sub_if_data *sdata,
 			   struct cfg80211_disassoc_request *req)
 {
-	u8 frame_buf[IEEE80211_DEAUTH_FRAME_LEN];
+	u8 frame_buf[IEEE80211_DEAUTH_FRAME_LEN] = {};
 
 	if (!sdata->u.mgd.associated ||
 	    memcmp(sdata->vif.cfg.ap_addr, req->ap_addr, ETH_ALEN))
-- 
2.43.0


