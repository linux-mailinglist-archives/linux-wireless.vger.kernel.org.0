Return-Path: <linux-wireless+bounces-20625-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B65ACA6B2B8
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Mar 2025 02:46:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44CD0880FA2
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Mar 2025 01:46:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0F821C5F37;
	Fri, 21 Mar 2025 01:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="UpO/J9ca"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5C8615820C;
	Fri, 21 Mar 2025 01:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742521606; cv=none; b=qIumh2lq7uJO7ceZwrLTWiGEoLz/w+FKHM7nxWwYGSklt1aSsbVKfsWKnC+svPIQs6Ugy1Ifu4+3IqhxUoNHFyhLwDCVxE/3elRqF5JFnpa80dExj5ZdoHXPMZ0Bm+5ngCJRnMmLyILulNsgeulL9SKW8FBGStDbgwxXaHSmGC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742521606; c=relaxed/simple;
	bh=y5k+WGVbmLOx9zmwieFUjE+czP2TB3cI343tVDN4iyo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=LxFoFHzuDEsLMCFByfXqj4uJVckec8UtHhyKhcxBG1R5kq3n7Qa7vmePAvvsqchzSuXIrkF2excgicmNIuR0b/hKjjHSvvy4m3nRayqA87cMW6yo+P1it//+QMWDC1EACTPeniReoJqYVD7zCSHzZ8ZTr43p9hUyZw3VvYxMofk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=UpO/J9ca; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52L1Wd22010236;
	Fri, 21 Mar 2025 01:46:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=TZkanKkLeMm6zSZhEdPwL9
	AeMOk6nmlwmWL5HpmB02Y=; b=UpO/J9caj7uVcjvXQY0iKYmxdDZB+VIdgX9CQ7
	YoAPO+CdWuILhSsy1Ot9lYoJdDCYtFuwJDyfkK32hZ+t6LJhR7LVfVbwiZkdgAyD
	s+vAba+YFzJMsu+v5fHjQfLTa/2cxtvwAQMA1MxJfJGoxoiVDiV4MV2SoecHIOLQ
	h7s1vfJgoBcx7fnKYj4OAjO+GJD2v/eNbHMmp7ZoFlb3DSY65PXIRT/yQ9SGkzf7
	KC4rukF1XSnKaj9fsN5cIb80PIetEeCslLAMSiyk07ZBygckW0KIgVWznNaBtm3N
	AB6VmA1wmPk4Fv1oKJbAhqnkl8yx+fIiVg2ZJkQtalfmprQg==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45gt5kghcc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Mar 2025 01:46:28 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 52L1kSba002944
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Mar 2025 01:46:28 GMT
Received: from [127.0.1.1] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 20 Mar
 2025 18:46:26 -0700
From: Baochen Qiang <quic_bqiang@quicinc.com>
Date: Fri, 21 Mar 2025 09:45:53 +0800
Subject: [PATCH ath-next] wifi: ath12k: don't put ieee80211_chanctx_conf
 struct in ath12k_link_vif
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250321-ath12k-dont-put-chanctx-in-arvif-v1-1-c8e93061952b@quicinc.com>
X-B4-Tracking: v=1; b=H4sIANDE3GcC/x2N0QqDMAxFf0XyvEAarYP9ythDqXEGoUqbSUH89
 3V7PHDPPScUySoFHt0JWQ4tuqUG7tZBXEJ6C+rUGJjYU88Ogy2OV5y2ZLh/DH+raBU1YciHzui
 JBj/c48jkoN3sWWat/8QTmo1JqsHrur69hoi0fAAAAA==
X-Change-ID: 20250321-ath12k-dont-put-chanctx-in-arvif-5004547c6201
To: Johannes Berg <johannes@sipsolutions.net>,
        Jeff Johnson
	<jjohnson@kernel.org>
CC: <linux-wireless@vger.kernel.org>, <ath12k@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        "Gustavo A. R. Silva"
	<gustavoars@kernel.org>,
        Baochen Qiang <quic_bqiang@quicinc.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: m3a0AwRBFXoZxNKtbvo5WHfYONWJJZn7
X-Proofpoint-ORIG-GUID: m3a0AwRBFXoZxNKtbvo5WHfYONWJJZn7
X-Authority-Analysis: v=2.4 cv=PsuTbxM3 c=1 sm=1 tr=0 ts=67dcc4f5 cx=c_pps a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=bC-a23v3AAAA:8 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8
 a=pkFYjrFKJ6VnwjaiwVAA:9 a=QEXdDO2ut3YA:10 a=-FEs8UIgK8oA:10 a=FO4_E8m0qiDe52t0p3_H:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-21_01,2025-03-20_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 adultscore=0 spamscore=0 mlxscore=0 lowpriorityscore=0
 bulkscore=0 clxscore=1011 malwarescore=0 suspectscore=0 impostorscore=0
 mlxlogscore=736 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503210010

ieee80211_chanctx_conf struct is not put at the end of ath12k_link_vif.
Note ieee80211_chanctx_conf has flexible array member inside it, causing
below warning with GCC-14:

drivers/net/wireless/ath/ath12k/core.h:298:39: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]

Although there is no issue for now since the array is not getting used,
this should be fixed to avoid any potential data corruption issue in the
future.

Remove this struct from ath12k_link_vif, fetch it from ieee80211_bss_conf
instead when needed.

This change only applies to WCN7850, and should has no impact on other
chipsets.

This is an alternative to the solution proposed in [1].

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Reported-by: Gustavo A. R. Silva <gustavoars@kernel.org>
Link: https://msgid.link/Z8-Snz86Xfwdlyd7@kspp # [1]
Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/core.h |  1 -
 drivers/net/wireless/ath/ath12k/mac.c  | 15 ++++++++++++---
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index bed996919f040645fd8b474d9709539758a34150..4675648c7bcb1f282db7935c92bb6a46821e550a 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -295,7 +295,6 @@ struct ath12k_link_vif {
 	int txpower;
 	bool rsnie_present;
 	bool wpaie_present;
-	struct ieee80211_chanctx_conf chanctx;
 	u8 vdev_stats_id;
 	u32 punct_bitmap;
 	u8 link_id;
diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 9fda97667d4e3468f28194bf55cc194fe123533c..842eda56c8b152b3303c83b43fbef400442c59fc 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -9550,16 +9550,26 @@ static int ath12k_start_vdev_delay(struct ath12k *ar,
 	struct ath12k_base *ab = ar->ab;
 	struct ath12k_vif *ahvif = arvif->ahvif;
 	struct ieee80211_vif *vif = ath12k_ahvif_to_vif(arvif->ahvif);
+	struct ieee80211_chanctx_conf *chanctx;
+	struct ieee80211_bss_conf *link_conf;
 	int ret;
 
 	if (WARN_ON(arvif->is_started))
 		return -EBUSY;
 
-	ret = ath12k_mac_vdev_start(arvif, &arvif->chanctx);
+	link_conf = ath12k_mac_get_link_bss_conf(arvif);
+	if (!link_conf) {
+		ath12k_warn(ab, "failed to get link conf for vdev %u\n", arvif->vdev_id);
+		return -EINVAL;
+	}
+
+	chanctx	= wiphy_dereference(ath12k_ar_to_hw(arvif->ar)->wiphy,
+				    link_conf->chanctx_conf);
+	ret = ath12k_mac_vdev_start(arvif, chanctx);
 	if (ret) {
 		ath12k_warn(ab, "failed to start vdev %i addr %pM on freq %d: %d\n",
 			    arvif->vdev_id, vif->addr,
-			    arvif->chanctx.def.chan->center_freq, ret);
+			    chanctx->def.chan->center_freq, ret);
 		return ret;
 	}
 
@@ -9622,7 +9632,6 @@ ath12k_mac_op_assign_vif_chanctx(struct ieee80211_hw *hw,
 	    ahvif->vdev_type != WMI_VDEV_TYPE_AP &&
 	    ahvif->vdev_type != WMI_VDEV_TYPE_MONITOR &&
 	    !ath12k_peer_exist_by_vdev_id(ab, arvif->vdev_id)) {
-		memcpy(&arvif->chanctx, ctx, sizeof(*ctx));
 		ret = 0;
 		goto out;
 	}

---
base-commit: b6f473c96421b8b451a8df8ccb620bcd71d4b3f4
change-id: 20250321-ath12k-dont-put-chanctx-in-arvif-5004547c6201

Best regards,
-- 
Baochen Qiang <quic_bqiang@quicinc.com>


