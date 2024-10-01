Return-Path: <linux-wireless+bounces-13363-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D710198B791
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Oct 2024 10:51:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6ADD1282EC0
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Oct 2024 08:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0F9619D07E;
	Tue,  1 Oct 2024 08:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="KzCCZrzL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BB95192B79
	for <linux-wireless@vger.kernel.org>; Tue,  1 Oct 2024 08:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727772669; cv=none; b=TUgBVp1wLA5nZXA9EK9WIUuAijnOoMUAicHryjXV3eEQU8ZBTb5GmP9n3XaNZrk3RahlnpaCGOqTwQ3odhU+B7PmnIwkfwaz8V9OtOqRnQkhIC/iTI76PVh/fVGdip76c2zJF0UYHS9eppjIvzOEtjOo7pSKCTufj8d874Bwx0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727772669; c=relaxed/simple;
	bh=C0sQkRIHxaRkLa1RXMjKQMk8szRYLug+i0WZUztLg/c=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VJg0fOSLouk/BIDVTRsUFKa4MGxtltW69vjLTDi9R/uX55KfbsSt8Oc4OtxKYgyaTGGRNV8ISUoj7DamG0UJ4z0oGhndXt6QPxRvFTK5KiZbmWCaytqM41PQNl+y5rNeMAwFUtcGCRTbkhab85qbukD90QQJBIiq4z6lVZZU/Qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=KzCCZrzL; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4913SnwE027724;
	Tue, 1 Oct 2024 08:50:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=xINYJRJuHyewl3XgyedS07
	o0JAromGlSz5DwoaexBfo=; b=KzCCZrzLcfg3ko1448uqNbj3QlIw2XqOWtoHhn
	Xtstl4lWdKh+SZTLLkWwg2DscdMUerj20k3IXC+k9kbFfo06d4uDtC121WZaFx4P
	ngX+BdKGSoZ7uKqai06AEzo5jFuSXqMq96qWHjZ3NLLg36iYGWQi8feTlmhT/ujx
	3IVrL+hN2FQOHT0sP8e/ycGPIBrg+YpwUB5rVWD+GPPJHLCBHA/+LAWrN7J1uE5x
	B1yzJvs/GxhmXvkzfjRcVcKQRMHvf34NwOwWJF7Yw1aqcBPMiJfjhvb9IDfxTzbP
	2L0sJ0TJMsQOErauTQxjL/gI1Ef0Df74aQF8RslpmBCNCpWw==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41xte0xbyu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 01 Oct 2024 08:50:52 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4918oplJ007463
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 1 Oct 2024 08:50:51 GMT
Received: from hu-adisi-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 1 Oct 2024 01:50:48 -0700
From: Aditya Kumar Singh <quic_adisi@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>, <ath12k@lists.infradead.org>,
        "Aditya
 Kumar Singh" <quic_adisi@quicinc.com>
Subject: [PATCH v2] wifi: mac80211: re-order assigning channel in activate links
Date: Tue, 1 Oct 2024 14:20:34 +0530
Message-ID: <20241001085034.2745669-1-quic_adisi@quicinc.com>
X-Mailer: git-send-email 2.34.1
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
X-Proofpoint-ORIG-GUID: e40LJUqdbXXQ8T7So2Ucm-azmLrOOrB3
X-Proofpoint-GUID: e40LJUqdbXXQ8T7So2Ucm-azmLrOOrB3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 suspectscore=0 spamscore=0 impostorscore=0 lowpriorityscore=0 adultscore=0
 priorityscore=1501 bulkscore=0 phishscore=0 mlxscore=0 clxscore=1015
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2410010057

The current flow in _ieee80211_set_active_links() does not align with the
operational requirements of drivers that groups multiple hardware
under a single wiphy. These drivers (e.g ath12k) rely on channel
assignment to determine the appropriate hardware for each link. Without
this, the drivers cannot correctly establish the link interface.

Currently in _ieee80211_set_active_links(), after calling
drv_change_vif_links() on the driver, the state of all connected stations
is updated via drv_change_sta_links(). This is followed by handling keys
in the links, and finally, assigning the channel to the links.
Consequently, drv_change_sta_links() prompts drivers to create the station
entry at their level and within their firmware. However, since channels
have not yet been assigned to links at this stage, drivers have not
created the necessary link interface for establishing link stations,
leading to failures in activating the links.

Therefore, re-order the logic so that after drv_change_vif_links() and
removing the old links, channels are assigned to newly added links.
Following this, the flow proceeds to station handling.

Signed-off-by: Aditya Kumar Singh <quic_adisi@quicinc.com>
---
v2: * assigned channel after removing older links.
    * kept the call to link_info_changed() in the original place itself.
    * got rid of using word 'fix'

---
 net/mac80211/link.c | 51 +++++++++++++++++++++++++++------------------
 1 file changed, 31 insertions(+), 20 deletions(-)

diff --git a/net/mac80211/link.c b/net/mac80211/link.c
index 0bbac64d5fa0..019e1c1311b4 100644
--- a/net/mac80211/link.c
+++ b/net/mac80211/link.c
@@ -385,6 +385,37 @@ static int _ieee80211_set_active_links(struct ieee80211_sub_if_data *sdata,
 						 jiffies);
 	}
 
+	for_each_set_bit(link_id, &add, IEEE80211_MLD_MAX_NUM_LINKS) {
+		struct ieee80211_link_data *link;
+
+		link = sdata_dereference(sdata->link[link_id], sdata);
+
+		/*
+		 * This call really should not fail. Unfortunately, it appears
+		 * that this may happen occasionally with some drivers. Should
+		 * it happen, we are stuck in a bad place as going backwards is
+		 * not really feasible.
+		 *
+		 * So lets just tell link_use_channel that it must not fail to
+		 * assign the channel context (from mac80211's perspective) and
+		 * assume the driver is going to trigger a recovery flow if it
+		 * had a failure.
+		 * That really is not great nor guaranteed to work. But at least
+		 * the internal mac80211 state remains consistent and there is
+		 * a chance that we can recover.
+		 */
+		ret = _ieee80211_link_use_channel(link,
+						  &link->conf->chanreq,
+						  IEEE80211_CHANCTX_SHARED,
+						  true);
+		WARN_ON_ONCE(ret);
+
+		/*
+		 * inform about the link info changed parameters after all
+		 * stations are also added
+		 */
+	}
+
 	list_for_each_entry(sta, &local->sta_list, list) {
 		if (sdata != sta->sdata)
 			continue;
@@ -428,26 +459,6 @@ static int _ieee80211_set_active_links(struct ieee80211_sub_if_data *sdata,
 
 		link = sdata_dereference(sdata->link[link_id], sdata);
 
-		/*
-		 * This call really should not fail. Unfortunately, it appears
-		 * that this may happen occasionally with some drivers. Should
-		 * it happen, we are stuck in a bad place as going backwards is
-		 * not really feasible.
-		 *
-		 * So lets just tell link_use_channel that it must not fail to
-		 * assign the channel context (from mac80211's perspective) and
-		 * assume the driver is going to trigger a recovery flow if it
-		 * had a failure.
-		 * That really is not great nor guaranteed to work. But at least
-		 * the internal mac80211 state remains consistent and there is
-		 * a chance that we can recover.
-		 */
-		ret = _ieee80211_link_use_channel(link,
-						  &link->conf->chanreq,
-						  IEEE80211_CHANCTX_SHARED,
-						  true);
-		WARN_ON_ONCE(ret);
-
 		ieee80211_mgd_set_link_qos_params(link);
 		ieee80211_link_info_change_notify(sdata, link,
 						  BSS_CHANGED_ERP_CTS_PROT |

base-commit: 5a4d42c1688c88f3be6aef46b0ea6c32694cd2b8
-- 
2.34.1


