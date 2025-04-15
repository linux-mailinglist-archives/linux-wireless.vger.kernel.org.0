Return-Path: <linux-wireless+bounces-21530-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D12B4A892C8
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Apr 2025 06:21:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0C60165100
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Apr 2025 04:21:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A951514B945;
	Tue, 15 Apr 2025 04:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="FG8/RVjj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86ECF1DE3C4
	for <linux-wireless@vger.kernel.org>; Tue, 15 Apr 2025 04:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744690879; cv=none; b=TIPHmcf/1UekuWVDgWTezaS2s8129/461r7WkOhWZJseH+0cciMSk71QRN/patWlugi4lqCmLisw86vwbWEomVyhaugsxxlhPK6X/nWaIazZD56AZO57+DBy353HoMWOfn8w327BA6rGF4KGikCP3UHbB6LvU43r2qoMNdAJI3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744690879; c=relaxed/simple;
	bh=uezanOTHkuX0S5qBcpicWJ5CUm6sY+FsBbUEHvc/Aoo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YpXGDXz1jApxJnu2lEcW7eXlVfRNc72Z5omdVEUZ81yJrICLqcPB57ojzKeE3AZi4Ay07K+zxm/XdylzmnAxeOkiICNnm550+pUtWYERVWYJaoVs/DU0fhvADdrsdI/O4cpaaw4G7leBwOy/j8EducRn/qZBpCNgmloTgu3gpjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=FG8/RVjj; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53F15gRP031547;
	Tue, 15 Apr 2025 04:21:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	PIftVPqnkOlbJYLi/ce8V1mRQBem/jP22VqNT089nzk=; b=FG8/RVjjk32Q+QIz
	m+MWC/SNmuApyrQKbrvticKVwaPWF5sFXVI4Dy0pC2cWufcrIQS9/R/FQdxfVeQq
	CtiHawLO7OEZ/dIZkUk02IqwjsWg30pe1YyAUuNEnisv/EHPFRLtAHfF+Czm1TEM
	nqqieW73N2tgY2NSlkiMFGdH4Nx+ZbSbF8RmHnXikrvQmz6bsURDDd4DxRfzeCUu
	xDbazy3lC++KVX7cTALLbvJ9jSqWtKNFjhO4NT3T2WU97FxM1ujGjH1pSkHCto3K
	miUximspmPTTtEJdWVITQTzF3XV6k+YoOrszGq7EEklXxksqDspCxuRI+sCHxBVh
	z3TQGA==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45ygxjxg7w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Apr 2025 04:21:11 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 53F4LBiA020586
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Apr 2025 04:21:11 GMT
Received: from hu-sarishar-blr.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 14 Apr 2025 21:21:09 -0700
From: Sarika Sharma <quic_sarishar@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Sarika Sharma
	<quic_sarishar@quicinc.com>
Subject: [PATCH wireless-next v6 06/11] wifi: cfg80211: add flag to indicate driver supports ML station statistics
Date: Tue, 15 Apr 2025 09:50:25 +0530
Message-ID: <20250415042030.1246187-7-quic_sarishar@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250415042030.1246187-1-quic_sarishar@quicinc.com>
References: <20250415042030.1246187-1-quic_sarishar@quicinc.com>
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
X-Authority-Analysis: v=2.4 cv=WecMa1hX c=1 sm=1 tr=0 ts=67fddeb7 cx=c_pps a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=GEpy-HfZoHoA:10 a=XR8D0OoHHMoA:10 a=COk6AnOGAAAA:8 a=S-8NWVhTYUyOai8fu3UA:9 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: -0j7p0KU8N8ZTaodReTV2RZ6ClEzdJtO
X-Proofpoint-ORIG-GUID: -0j7p0KU8N8ZTaodReTV2RZ6ClEzdJtO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-15_01,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 suspectscore=0
 adultscore=14 clxscore=1015 lowpriorityscore=0 phishscore=0 mlxscore=0
 impostorscore=0 mlxlogscore=999 spamscore=0 malwarescore=0
 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504150026

Currently, while filling NL attributes for the link level station
statistics, valid_links is checked. There might be the case when
driver offload link station statistics and does not provide per-link
statistics.

Hence, add flag WIPHY_FLAG_SUPPORTS_MLO_STA_PER_LINK_STATS in wiphy
structure to indicate that driver supports per link station statistics.
Set this flag if driver supports per-link station statistics and
check this flag while filling the station_info structure
for MLO and while embedding the info into NL message.

Signed-off-by: Sarika Sharma <quic_sarishar@quicinc.com>
---
 include/net/cfg80211.h | 3 +++
 net/wireless/nl80211.c | 3 ++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 4f7eb59ef3ee..22edd98cea25 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -5093,6 +5093,8 @@ struct cfg80211_ops {
  * @WIPHY_FLAG_SUPPORTS_NSTR_NONPRIMARY: support connection to non-primary link
  *	of an NSTR mobile AP MLD.
  * @WIPHY_FLAG_DISABLE_WEXT: disable wireless extensions for this device
+ * @WIPHY_FLAG_SUPPORTS_MLO_STA_PER_LINK_STATS: The driver does not offload
+ *	link decisions and provide per-link statistics for MLO STA.
  */
 enum wiphy_flags {
 	WIPHY_FLAG_SUPPORTS_EXT_KEK_KCK		= BIT(0),
@@ -5121,6 +5123,7 @@ enum wiphy_flags {
 	WIPHY_FLAG_HAS_CHANNEL_SWITCH		= BIT(23),
 	WIPHY_FLAG_NOTIFY_REGDOM_BY_DRIVER	= BIT(24),
 	WIPHY_FLAG_CHANNEL_CHANGE_ON_BEACON     = BIT(25),
+	WIPHY_FLAG_SUPPORTS_MLO_STA_PER_LINK_STATS = BIT(26),
 };
 
 /**
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 4d5ed9a22fe9..0fc59e0d0f1d 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -6917,7 +6917,8 @@ static int nl80211_send_station(struct sk_buff *msg, u32 cmd, u32 portid,
 		    &sinfo->sta_flags))
 		goto nla_put_failure;
 
-	if (sinfo->valid_links) {
+	if ((rdev->wiphy.flags & WIPHY_FLAG_SUPPORTS_MLO_STA_PER_LINK_STATS) &&
+	    sinfo->valid_links) {
 		/* TODO: Add accumulated stats for packets, bytes for
 		 *	 better representation at MLO level.
 		 */
-- 
2.34.1


