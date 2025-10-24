Return-Path: <linux-wireless+bounces-28215-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BD81C0459F
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Oct 2025 06:47:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0569819A7274
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Oct 2025 04:48:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E2221E3787;
	Fri, 24 Oct 2025 04:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="QdQdR5hn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A76E21519AC
	for <linux-wireless@vger.kernel.org>; Fri, 24 Oct 2025 04:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761281251; cv=none; b=dxM8Y0yF1xLP+Gg4SDnIQSy/gz55ddP7R0vOlgZiIgpucBj8uIaBCboY+KTpgouqfREz6RPjzm1U0+BpkGUQse5PpFr9H5B6+0JP81JkkACQdGU2qbWyOpJRb3VlI1KVTj7nkEyqWCciej0jgeNkpuGNfspfD4a1FlvwbCHvCM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761281251; c=relaxed/simple;
	bh=FmhSTFMtnA4vNEUaSfj9neobrQKuWrRfEty3aRHh3fc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Nl5RtNFNKPqCeRRDIPWFhHRHhhiYRh11Jlm2iUnMDP5wwvOuupNzmfUA7McKZEGl2oNAsTzq4OhSwARy3LW7KaI9ZNy56FkFuuX/ZcPO4NXYNuPSnnqUbgRDgZoTftpXQNhTWVVUVlh0jAppIuB39Nj8tm2Q4S9OIXukwMH9jE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=QdQdR5hn; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59O3FHJZ015941;
	Fri, 24 Oct 2025 04:47:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	h6Pr/eiBNIdOsFvBHvjF4T4jkzO0QlDpmVKhB2EuB78=; b=QdQdR5hnNDkhTpl/
	mPJfCOBZBYfEpRfEspZXFzgirLoTZZdU/gFu3O0zJP7RXn/wuZwixvslZTcSapvP
	NxxE54IFhvyqIMnFl9xgciqn03EEHwiePlkilTsslV4nW+OLeskEm63qsS8OF4XI
	qX+s8y5AX44yVWLDE7R0xUpoLJvtZr366wSyWumDDXoRE36LIkr0tm8OhIJMJVq6
	fRq3MqiMoq1HQL1OtEwG8oK2WxctQ8dB80isgZ7fwgGvRSa/YJD8y84qsAQCAxBI
	7zfukuJMXF9aFCkf+KuIX/tGbOb7AQRkex98jIchpuncLfK5wLr4tMRsjyQwpAfR
	IwHyIg==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49xkpsgdac-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Oct 2025 04:47:23 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 59O4lNjd021274
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Oct 2025 04:47:23 GMT
Received: from hu-rdevanat-blr.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.24; Thu, 23 Oct 2025 21:47:21 -0700
From: Roopni Devanathan <quic_rdevanat@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Roopni Devanathan
	<quic_rdevanat@quicinc.com>
Subject: [PATCH wireless-next 1/2] wifi: cfg80211: Add debugfs support for multi-radio wiphy
Date: Fri, 24 Oct 2025 10:16:48 +0530
Message-ID: <20251024044649.483557-2-quic_rdevanat@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251024044649.483557-1-quic_rdevanat@quicinc.com>
References: <20251024044649.483557-1-quic_rdevanat@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIxMDE5MCBTYWx0ZWRfX0+hAxwkKVVtY
 PM4YqIai6yRxipjNQmMvATwq5V2iMxZQqoB37R1UgL7VdI/blDrskuaIp9LAISG79M5kOIsPVAp
 h2lKMLI1sZvjfYMfKI2Ef7QgKdaiUS6F2C7T5pJGy4rN0nUFgshYovA0Lfvzy9xmRS5cwApc5Ia
 SQ43eC8xj7rlVqdy0PE7mAOnU0HXBsXZqKZWiunOYqJ+n54c8t6OJty7VqcuLwUf/ULKmT07Pjk
 YbuXoWJnwD9zfhWhcgi5wt3MCIKLDkVvAViwlqIN2WmgwtZa3SM02YiCPvgs8PzFNO4wKS+llQ0
 UGgzjQUFbTGaJIw6mIPNNa92v0Sk2Htuz2bLF86VezPzkFJWtV18+PjtO6FPg+/92Vq5M9DWG8j
 OQObdY7s8Wt92XckLJ0yp5ILpaHOQg==
X-Authority-Analysis: v=2.4 cv=FbM6BZ+6 c=1 sm=1 tr=0 ts=68fb04db cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=COk6AnOGAAAA:8 a=TUo8hqh4tmkRTkgfV0UA:9 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: 8_CojtucScvth0A2laSaUik-bOVgQCAP
X-Proofpoint-ORIG-GUID: 8_CojtucScvth0A2laSaUik-bOVgQCAP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-23_03,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 spamscore=0 impostorscore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510210190

In multi-radio wiphy architecture, where a single wiphy can have
multiple radios tied to it, radio specific configuration parameters
and global wiphy parameters are maintained for the entire physical
device and common to all radios. But, each radio in a wiphy can have
different values for each radio configuration parameter, like RTS
threshold. With the current debugfs directory structure, the values
of global wiphy configuration parameters can be viewed, but, values
of individual radio configuration parameters cannot be viewed, as
radio specific configuration parameters are not maintained, separately.

To address this, in addition to maintaining global wiphy configuration
parameters common to all radios, create separate debugfs directories
for each radio in a wiphy to maintain parameters corresponding to that
radio in this directory.

In implementation, maintain a dentry structure in wiphy_radio_cfg, a
structure  containing radio configurations of a wiphy. This struct is
maintained to denote per-radio configurations of a wiphy. Create
separate directories representing each radio within phy#X directory in
debugfs during wiphy registration.

Sample directory structure with this change:
ls /sys/kernel/debug/ieee80211/phy0/radio
radio0/ radio1/ radio2/

Signed-off-by: Roopni Devanathan <quic_rdevanat@quicinc.com>
---
 include/net/cfg80211.h |  4 ++++
 net/wireless/core.c    | 15 +++++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 781624f5913a..d45845503479 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -5683,9 +5683,13 @@ struct wiphy_iftype_akm_suites {
  *
  * @rts_threshold: RTS threshold (dot11RTSThreshold);
  *	-1 (default) = RTS/CTS disabled
+ * @radio_debugfsdir: Pointer to debugfs directory containing the radio-
+ *	specific parameters.
+ *	NULL (default) = Debugfs directory not created
  */
 struct wiphy_radio_cfg {
 	u32 rts_threshold;
+	struct dentry *radio_debugfsdir;
 };
 
 /**
diff --git a/net/wireless/core.c b/net/wireless/core.c
index 797f9f2004a6..f3568eb5e592 100644
--- a/net/wireless/core.c
+++ b/net/wireless/core.c
@@ -34,6 +34,9 @@
 /* name for sysfs, %d is appended */
 #define PHY_NAME "phy"
 
+/* maximum length of radio debugfs directory name */
+#define RADIO_DEBUGFSDIR_MAX_LEN	8
+
 MODULE_AUTHOR("Johannes Berg");
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("wireless configuration support");
@@ -1042,6 +1045,18 @@ int wiphy_register(struct wiphy *wiphy)
 	/* add to debugfs */
 	rdev->wiphy.debugfsdir = debugfs_create_dir(wiphy_name(&rdev->wiphy),
 						    ieee80211_debugfs_dir);
+	if (wiphy->n_radio > 0) {
+		int idx;
+		char radio_name[RADIO_DEBUGFSDIR_MAX_LEN];
+
+		for (idx = 0; idx < wiphy->n_radio; idx++) {
+			scnprintf(radio_name, sizeof(radio_name), "radio%d",
+				  idx);
+			wiphy->radio_cfg[idx].radio_debugfsdir =
+				debugfs_create_dir(radio_name,
+						   rdev->wiphy.debugfsdir);
+		}
+	}
 
 	cfg80211_debugfs_rdev_add(rdev);
 	nl80211_notify_wiphy(rdev, NL80211_CMD_NEW_WIPHY);
-- 
2.25.1


