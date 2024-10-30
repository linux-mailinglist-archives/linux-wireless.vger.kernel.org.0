Return-Path: <linux-wireless+bounces-14706-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 557CF9B5A22
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Oct 2024 03:55:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CAFCB1F23BCF
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Oct 2024 02:55:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4C7A126C0A;
	Wed, 30 Oct 2024 02:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="DMgBQ5Xu"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 346D84437
	for <linux-wireless@vger.kernel.org>; Wed, 30 Oct 2024 02:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730256941; cv=none; b=O3h5oi2Jn7Ng/+aFKp0CI5n3tsfHTOMGxbnvaF7vZWqq7ql+HE5sVNwOgViTOzbrzY/4gjKX0aO7np28IUZmdEtSnxp8n3y+KoQUTnSOqHqplkvFIBX8Z9/R02Lw02DqAO112K5XE+VE3dn4Xwqz1n/R/c5SAxgHae2YXhVW4fE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730256941; c=relaxed/simple;
	bh=6acucyxbAGrVHMzr9rZNPeXugzatzQhDGxrb1xY9baY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kmboK+UzwUSV/126IjzLkae58jr99lFt/PPdxEea9vyik0fk4hTuWXLSAVLUrZmkkwbZMDBWD9Nxrxeb/H5UuMRHsgsGxywwsLFDiI0YMYH3OeiYR3UDadcoqUinWEoAzi5hKjAHeJytZCHAQ0gqI3gspfa/gNd6OLs8ldWH8y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=DMgBQ5Xu; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49TMZPcb023870;
	Wed, 30 Oct 2024 02:55:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=u3LZpCuW9bTjSRKdTnqsve
	/i3hWOKJOhEPVbGSQAXMM=; b=DMgBQ5Xu96bN0jUIGJAzOpL+uw/2b0zra/Rw2T
	TpmfrgDnXWNpu5pmLzN1L+c+Fwb9hGpddstZFE63/XuXGos1I4q53D3tCZmQUpkt
	O6WhCTHerLvdKxHNxY0l22m5tqpfqBvwjSrd8YY3KDW7BVKr/rk59gStvncfZaKE
	eLeyLEXELzial9gDbmSuXxnATh7YACeNmpSgp+Tbqk169aGO4VgnJkRelgjYUj7E
	Po+cn54opBMIPlBZQg+AnFjnQejuUq26l+gYJ5tKRXu/w1pFLCvgxABiN+9PuN7b
	yigqzWNgxRyhR8+3kDLaKGEPp1gcDFe8GI6e8aq7S8tGxqtQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42gsq8jd3u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 30 Oct 2024 02:55:34 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49U2tY6W027378
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 30 Oct 2024 02:55:34 GMT
Received: from lingbok-Birman-PHX.qca.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 29 Oct 2024 19:55:28 -0700
From: Lingbo Kong <quic_lingbok@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <quic_lingbok@quicinc.com>
Subject: [PATCH] wifi: cfg80211: Correctly handle Medium Synchronization Delay
Date: Wed, 30 Oct 2024 10:55:15 +0800
Message-ID: <20241030025515.16004-1-quic_lingbok@quicinc.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 1DFGsIZ29JwZqFT6aPJYABNHMPVtAWch
X-Proofpoint-ORIG-GUID: 1DFGsIZ29JwZqFT6aPJYABNHMPVtAWch
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 bulkscore=0
 adultscore=0 mlxscore=0 priorityscore=1501 mlxlogscore=999 impostorscore=0
 lowpriorityscore=0 malwarescore=0 clxscore=1011 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2410300021

Currently, when the driver attempts to connect to an AP MLD with multiple
APs, the cfg80211_mlme_check_mlo_compat() function requires the Medium
Synchronization Delay values from different APs of the same AP MLD to be
equal, which may result in connection failures.

This is because when the driver receives a multi-link probe response from
an AP MLD with multiple APs, cfg80211 updates the Elements for each AP
based on the multi-link probe response. If the Medium Synchronization Delay
is set in the multi-link probe response, the Elements for each AP belonging
to the same AP MLD will have the Medium Synchronization Delay set
simultaneously. If non-multi-link probe responses are received from
different APs of the same MLD AP, cfg80211 will still update the Elements
based on the non-multi-link probe response. Since the non-multi-link probe
response does not set the Medium Synchronization Delay
(IEEE 802.11be-2024-35.3.4.4), if the Elements from a non-multi-link probe
response overwrite those from a multi-link probe response that has set the
Medium Synchronization Delay, the Medium Synchronization Delay values for
APs belonging to the same AP MLD will not be equal. This discrepancy causes
the cfg80211_mlme_check_mlo_compat() function to fail, leading to
connection failures. Commit ccb964b4ab16
("wifi: cfg80211: validate MLO connections better") did not take this into
account.

To address this issue, add a u16 type member to the struct cfg80211_bss to
store the Medium Synchronization Delay. When the driver receives a probe
response with the Medium Synchronization Delay set, update this member’s
value; otherwise, do not update it. Additionally, modify the parameter list
of cfg80211_mlme_check_mlo_compat() so that this member variable can be
directly accessed within the cfg80211_mlme_check_mlo_compat() function viaq
a pointer to the struct cfg80211_bss. This will allow checking whether the
Medium Synchronization Delay values from different APs of the same AP MLD
are equal.

Fixes: ccb964b4ab16 ("wifi: cfg80211: validate MLO connections better")
Signed-off-by: Lingbo Kong <quic_lingbok@quicinc.com>
---
 include/net/cfg80211.h |  4 ++++
 net/wireless/mlme.c    | 11 +++++++----
 net/wireless/scan.c    | 15 +++++++++++++++
 3 files changed, 26 insertions(+), 4 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 27acf1292a5c..ebeb305c1d0c 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -2956,6 +2956,8 @@ struct cfg80211_bss_ies {
  * @cannot_use_reasons: the reasons (bitmap) for not being able to connect,
  *	if @restrict_use is set and @use_for is zero (empty); may be 0 for
  *	unspecified reasons; see &enum nl80211_bss_cannot_use_reasons
+ * @med_sync_delay: Medium Synchronization delay as described in
+ *	IEEE 802.11be-2024 Figure 9-1074q.
  * @priv: private area for driver use, has at least wiphy->bss_priv_size bytes
  */
 struct cfg80211_bss {
@@ -2986,6 +2988,8 @@ struct cfg80211_bss {
 	u8 use_for;
 	u8 cannot_use_reasons;
 
+	u16 med_sync_delay;
+
 	u8 priv[] __aligned(sizeof(void *));
 };
 
diff --git a/net/wireless/mlme.c b/net/wireless/mlme.c
index 4dac81854721..ae00c36779d2 100644
--- a/net/wireless/mlme.c
+++ b/net/wireless/mlme.c
@@ -326,7 +326,9 @@ void cfg80211_oper_and_vht_capa(struct ieee80211_vht_cap *vht_capa,
 }
 
 static int
-cfg80211_mlme_check_mlo_compat(const struct ieee80211_multi_link_elem *mle_a,
+cfg80211_mlme_check_mlo_compat(const struct cfg80211_bss *bss_a,
+			       const struct cfg80211_bss *bss_b,
+			       const struct ieee80211_multi_link_elem *mle_a,
 			       const struct ieee80211_multi_link_elem *mle_b,
 			       struct netlink_ext_ack *extack)
 {
@@ -340,8 +342,7 @@ cfg80211_mlme_check_mlo_compat(const struct ieee80211_multi_link_elem *mle_a,
 		return -EINVAL;
 	}
 
-	if (ieee80211_mle_get_eml_med_sync_delay((const u8 *)mle_a) !=
-	    ieee80211_mle_get_eml_med_sync_delay((const u8 *)mle_b)) {
+	if (bss_a->med_sync_delay != bss_b->med_sync_delay) {
 		NL_SET_ERR_MSG(extack, "link EML medium sync delay mismatch");
 		return -EINVAL;
 	}
@@ -426,7 +427,9 @@ static int cfg80211_mlme_check_mlo(struct net_device *dev,
 		if (WARN_ON(!mles[i]))
 			goto error;
 
-		if (cfg80211_mlme_check_mlo_compat(mles[req->link_id], mles[i],
+		if (cfg80211_mlme_check_mlo_compat(req->links[req->link_id].bss,
+						   req->links[i].bss,
+						   mles[req->link_id], mles[i],
 						   extack)) {
 			req->links[i].error = -EINVAL;
 			goto error;
diff --git a/net/wireless/scan.c b/net/wireless/scan.c
index 1c6fd45aa809..6ad935475484 100644
--- a/net/wireless/scan.c
+++ b/net/wireless/scan.c
@@ -1899,6 +1899,13 @@ cfg80211_update_known_bss(struct cfg80211_registered_device *rdev,
 	 */
 	if (signal_valid)
 		known->pub.signal = new->pub.signal;
+
+	/* update medium synchronization delay when its value is not
+	 * the default.
+	 */
+	if (new->pub.med_sync_delay != IEEE80211_MED_SYNC_DELAY_DEFAULT)
+		known->pub.med_sync_delay = new->pub.med_sync_delay;
+
 	known->pub.capability = new->pub.capability;
 	known->ts = new->ts;
 	known->ts_boottime = new->ts_boottime;
@@ -2224,6 +2231,7 @@ cfg80211_inform_single_bss_data(struct wiphy *wiphy,
 	int bss_type;
 	bool signal_valid;
 	unsigned long ts;
+	const struct element *ml;
 
 	if (WARN_ON(!wiphy))
 		return NULL;
@@ -2267,6 +2275,7 @@ cfg80211_inform_single_bss_data(struct wiphy *wiphy,
 	tmp.pub.use_for = data->use_for;
 	tmp.pub.cannot_use_reasons = data->cannot_use_reasons;
 	tmp.bss_source = data->bss_source;
+	tmp.pub.med_sync_delay = IEEE80211_MED_SYNC_DELAY_DEFAULT;
 
 	switch (data->bss_source) {
 	case BSS_SOURCE_MBSSID:
@@ -2321,6 +2330,12 @@ cfg80211_inform_single_bss_data(struct wiphy *wiphy,
 		break;
 	case CFG80211_BSS_FTYPE_PRESP:
 		rcu_assign_pointer(tmp.pub.proberesp_ies, ies);
+		ml = cfg80211_find_ext_elem(WLAN_EID_EXT_EHT_MULTI_LINK,
+					    ies->data, ies->len);
+		if (ml)
+			tmp.pub.med_sync_delay =
+				ieee80211_mle_get_eml_med_sync_delay(ml->data + 1);
+
 		break;
 	}
 	rcu_assign_pointer(tmp.pub.ies, ies);

base-commit: e7e2957f403ba4655199f2ba9920c1a015a7be44
-- 
2.34.1


