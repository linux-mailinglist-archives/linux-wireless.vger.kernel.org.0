Return-Path: <linux-wireless+bounces-15918-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94A229E4DD9
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Dec 2024 08:00:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A9C6281DD4
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Dec 2024 06:59:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89FE919A2B0;
	Thu,  5 Dec 2024 06:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Iv9q2Qxm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFBA441C92;
	Thu,  5 Dec 2024 06:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733381996; cv=none; b=Xd/SiITIO7hXDYiOaksBX3ibUEB4qmmhkyK72dYW3ijWybiCvzfJC97vTXUj56aAIeWbs3JCt9QEdRdd55wfHjU7j3UDFLjr2/e82AG7ia33/AY7h6g1lYIinTYQzIX7bAMGo8MhMqX4yRAmbl3OIm8glZq34uOPRa8nI5F3PK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733381996; c=relaxed/simple;
	bh=JQYPwugyUj9jKvmbjblvHsew22Ptk9It2ss44YppIgI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=l1tpOnD9JXTt7QznDP244ERHAPz3Irm/eAg8SNgKi/0XFTLFRNCqK6XOlRgUg1QusYnPuBKOStvOHH2SIqP3az0Qm4a0zsrrlgr9YXlrldl01RzBb38MXzK7Ca1wl1mJYf0zlnav1hCyFiIaRkrgTwBUqfnNdQUyFmAT8IT1p1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Iv9q2Qxm; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B4NP5Nl025869;
	Thu, 5 Dec 2024 06:59:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=+okP/dHU+CdjRsXfg1HtzK
	0pejk+R0Bah+ClpjfRk8o=; b=Iv9q2Qxm3qMrqD8bTD2V1CiIfOiJgimFwOCnZY
	mkw7blKzIbO/lWzIKV6qJ5MjkqMA+hbrQBhc7kpA8N1xCkglG15/CIfbdjNbO73T
	uyUYp/GbjO1LrvLKAZ19fgRVY1D4KsGhnfXu31q0d7iLPFxtgDtNw5LqdO2ZvMIm
	yiorvuwOit1kd7zDv/b5kCq5MNMSbyT2TRvL15Lk8m1htNqAEejoeI0wnE6zrAHW
	cmTW7CB6Rzzz+s1wsQoxqqTZDh7oCmhROuxyRNec0L5QAEVQcdVeEjBwXKHf7RUz
	xTC/bo+xVdECLFV2MewL5iBsUNSlk2InWeFDTKd+aQnDBzzw==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 439yr9p3dp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Dec 2024 06:59:50 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4B56xnTb029686
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 5 Dec 2024 06:59:49 GMT
Received: from hu-adisi-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 4 Dec 2024 22:59:47 -0800
From: Aditya Kumar Singh <quic_adisi@quicinc.com>
Date: Thu, 5 Dec 2024 12:29:29 +0530
Subject: [PATCH] wifi: mac80211: re-order unassigning channel in activate
 links
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20241205-unassign_activate_links-v1-1-84097a1abdeb@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAFBPUWcC/x3MQQqDMBBA0avIrA1oMKbxKiIy1akdKtOSUSkE7
 25w+Rb/J1CKTApdkSDSwcpfyajLAqY3ykKG52ywlW1qWzmzC6ryIiNOGx+40biyfNS06HzzcOE
 Zgodc/yK9+H+f++E8L49fX89pAAAA
X-Change-ID: 20241205-unassign_activate_links-6a574859b997
To: Johannes Berg <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Aditya
 Kumar Singh" <quic_adisi@quicinc.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: BSOHpOIE2j23DLCTSClGVHCk3_5NPvX2
X-Proofpoint-GUID: BSOHpOIE2j23DLCTSClGVHCk3_5NPvX2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 impostorscore=0
 clxscore=1015 priorityscore=1501 mlxlogscore=999 phishscore=0
 lowpriorityscore=0 malwarescore=0 mlxscore=0 suspectscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412050052

The current flow in _ieee80211_set_active_links() during link removal
does not align with the operational requirements of drivers that groups
multiple hardware under a single wiphy. These drivers (e.g ath12k) rely on
channel information to determine the appropriate hardware for each link.

Now, during the link removal process, the channel is first unassigned from
the links via a call to __ieee80211_link_release_channel(). After this, the
state of all connected stations is updated via drv_change_sta_links().
This is followed by handling keys in the links, and finally, removing the
link by calling drv_change_vif_links().

For above mentioned drivers (such as ath12k), with the above flow, once the
channel is unassigned from the link, the link would be deleted at the
driver and firmware level. However, at this point, the station still exist,
leading to failures in deactivating the links.

Additionally, if we consider the link addition flow [1], channels are first
assigned, and then stations are created. So conversely, during removal,
ideally, the station should be removed first, and then the channel should
be unassigned.

Therefore, re-order the logic so that stations are handled first and then
channel is unassigned.

[1]: https://lore.kernel.org/linux-wireless/20241001085034.2745669-1-quic_adisi@quicinc.com/

Signed-off-by: Aditya Kumar Singh <quic_adisi@quicinc.com>
---
 net/mac80211/link.c | 44 ++++++++++++++++++++++----------------------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff --git a/net/mac80211/link.c b/net/mac80211/link.c
index 58a76bcd6ae68670fbbe7fa7d07540c04ff996f8..3c46d2b2ee254fab324d57f4d0fbe94ace76d89d 100644
--- a/net/mac80211/link.c
+++ b/net/mac80211/link.c
@@ -367,28 +367,6 @@ static int _ieee80211_set_active_links(struct ieee80211_sub_if_data *sdata,
 		}
 	}
 
-	for_each_set_bit(link_id, &rem, IEEE80211_MLD_MAX_NUM_LINKS) {
-		struct ieee80211_link_data *link;
-
-		link = sdata_dereference(sdata->link[link_id], sdata);
-
-		ieee80211_teardown_tdls_peers(link);
-
-		__ieee80211_link_release_channel(link, true);
-
-		/*
-		 * If CSA is (still) active while the link is deactivated,
-		 * just schedule the channel switch work for the time we
-		 * had previously calculated, and we'll take the process
-		 * from there.
-		 */
-		if (link->conf->csa_active)
-			wiphy_delayed_work_queue(local->hw.wiphy,
-						 &link->u.mgd.csa.switch_work,
-						 link->u.mgd.csa.time -
-						 jiffies);
-	}
-
 	for_each_set_bit(link_id, &add, IEEE80211_MLD_MAX_NUM_LINKS) {
 		struct ieee80211_link_data *link;
 
@@ -458,6 +436,28 @@ static int _ieee80211_set_active_links(struct ieee80211_sub_if_data *sdata,
 		__ieee80211_sta_recalc_aggregates(sta, active_links);
 	}
 
+	for_each_set_bit(link_id, &rem, IEEE80211_MLD_MAX_NUM_LINKS) {
+		struct ieee80211_link_data *link;
+
+		link = sdata_dereference(sdata->link[link_id], sdata);
+
+		ieee80211_teardown_tdls_peers(link);
+
+		__ieee80211_link_release_channel(link, true);
+
+		/*
+		 * If CSA is (still) active while the link is deactivated,
+		 * just schedule the channel switch work for the time we
+		 * had previously calculated, and we'll take the process
+		 * from there.
+		 */
+		if (link->conf->csa_active)
+			wiphy_delayed_work_queue(local->hw.wiphy,
+						 &link->u.mgd.csa.switch_work,
+						 link->u.mgd.csa.time -
+						 jiffies);
+	}
+
 	for_each_set_bit(link_id, &add, IEEE80211_MLD_MAX_NUM_LINKS) {
 		struct ieee80211_link_data *link;
 

---
base-commit: b81e0211e9c70be9eb70924e4e29698bfbbbc03a
change-id: 20241205-unassign_activate_links-6a574859b997


