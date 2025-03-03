Return-Path: <linux-wireless+bounces-19727-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D7020A4CE26
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Mar 2025 23:19:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9D491893A8B
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Mar 2025 22:20:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBEAE238D28;
	Mon,  3 Mar 2025 22:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="knP5MsAU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30D44235C1D
	for <linux-wireless@vger.kernel.org>; Mon,  3 Mar 2025 22:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741040353; cv=none; b=XMJwaiea4hfptT2TcJqngqO10FQ3FWrR0c9KeA1FJj9iBS5sYIkVIpy+vdttZs2EUyQGAOXNl9OR6UMQ5EBvSLNyALwSoRZUx0S5nB5zgjuyZ9KmjnoqQnZTP6/uF5XtXpzwD4gEhWuch1kdgP6mQV4fNC0SFR2L7XIRi9LyLHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741040353; c=relaxed/simple;
	bh=c5SmEMan/FfnpMDTLt3JLqmmC/N8P69os032UEgThqI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aZr3KwMTbQ1PEYuGY9b4qnYo0eUxQimo02mbzcXR8dSxC2UAze/geEkbMkkkLmtKpA+xprm5Ct8lkj6FslSLciXaKhMEHHqkNmhngrguaiODi/jxBl5U7vIc/k+/O9gVjtLEhdJEl7L7Go8tCUG3Fg9iqM1pR6JxrILvsVi8c7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=knP5MsAU; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 523AwCIQ022737;
	Mon, 3 Mar 2025 22:19:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jsQYahd56p8iD7rT66MO+DkRt9uZksoQbbXlVQ/seuM=; b=knP5MsAUdl+P+K2W
	b6aME/9Nn8bTh0e9MrNHuTavYZfxcRn5Bo/JsKKkfzGH1GbSwS4QCuRGZb4zMee9
	v+ISgKgrnaO4Za4ATFxvl4b96+os8o9btXtOfbYm1ktT28B26Yg+ECsJHiBcMk1+
	lqATaPd48/cbsDQG3eXq5fkMPh4jLXo7IV1yc2WFVZnzZgDb7Rcun+Su0ITa+7F3
	aKj6+n2Qae7s7Kso2NB0uLGNk0GXSjAePEyJDSLi+ke8Gg2UoUN1z8nOFyrbaPVO
	qC2DrFWpGH16Qg1/FG/22qZwzxyaru3857QXYWmnz5lH4xaIQmVjZE491dxlKkiL
	HZgNMQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 453t7hx7f9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Mar 2025 22:19:06 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 523MJ5cr022844
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 3 Mar 2025 22:19:05 GMT
Received: from hu-ramess-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 3 Mar 2025 14:19:03 -0800
From: Rameshkumar Sundaram <quic_ramess@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>, <ath12k@lists.infradead.org>,
        "Ramasamy
 Kaliappan" <quic_rkaliapp@quicinc.com>,
        Rameshkumar Sundaram
	<quic_ramess@quicinc.com>
Subject: [PATCH wireless-next v3 2/4] wifi: mac80211: update ML STA with EML capabilities
Date: Tue, 4 Mar 2025 03:48:41 +0530
Message-ID: <20250303221843.1809753-3-quic_ramess@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250303221843.1809753-1-quic_ramess@quicinc.com>
References: <20250303221843.1809753-1-quic_ramess@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: m3mHOqIu8_Bizcv1SH6DzL_RMwB3ojm1
X-Proofpoint-ORIG-GUID: m3mHOqIu8_Bizcv1SH6DzL_RMwB3ojm1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-03_11,2025-03-03_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0 malwarescore=0
 adultscore=0 suspectscore=0 mlxlogscore=999 clxscore=1015 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503030173

From: Ramasamy Kaliappan <quic_rkaliapp@quicinc.com>

When an AP and Non-AP MLD operates in EMLSR mode, EML capabilities
advertised during Association contains information such as EMLSR
transition delay, padding delay and transition timeout values.

Save the EML capabilities information that is received during station
addition and capabilities update in ieee80211_sta so that drivers can use
it for triggering EMLSR operation.

Signed-off-by: Ramasamy Kaliappan <quic_rkaliapp@quicinc.com>
Signed-off-by: Rameshkumar Sundaram <quic_ramess@quicinc.com>
---
 include/net/mac80211.h | 2 ++
 net/mac80211/cfg.c     | 3 +++
 2 files changed, 5 insertions(+)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index c498f685d01f..99c3224a081a 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -2488,6 +2488,7 @@ struct ieee80211_link_sta {
  * @max_amsdu_subframes: indicates the maximal number of MSDUs in a single
  *	A-MSDU. Taken from the Extended Capabilities element. 0 means
  *	unlimited.
+ * @eml_cap: EML capabilities of this MLO station
  * @cur: currently valid data as aggregated from the active links
  *	For non MLO STA it will point to the deflink data. For MLO STA
  *	ieee80211_sta_recalc_aggregates() must be called to update it.
@@ -2522,6 +2523,7 @@ struct ieee80211_sta {
 	bool mlo;
 	bool spp_amsdu;
 	u8 max_amsdu_subframes;
+	u16 eml_cap;
 
 	struct ieee80211_sta_aggregates *cur;
 
diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 09708a060bb7..e73f54a36aed 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -2066,6 +2066,9 @@ static int sta_apply_parameters(struct ieee80211_local *local,
 	if (params->listen_interval >= 0)
 		sta->listen_interval = params->listen_interval;
 
+	if (params->eml_cap_present)
+		sta->sta.eml_cap = params->eml_cap;
+
 	ret = sta_link_apply_parameters(local, sta, STA_LINK_MODE_STA_MODIFY,
 					&params->link_sta_params);
 	if (ret)
-- 
2.34.1


