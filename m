Return-Path: <linux-wireless+bounces-4631-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A8A4D8797E7
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Mar 2024 16:46:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EECF281101
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Mar 2024 15:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 032517B3E5;
	Tue, 12 Mar 2024 15:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="VyHLFHr0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5458754FA1
	for <linux-wireless@vger.kernel.org>; Tue, 12 Mar 2024 15:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710258411; cv=none; b=oFnkTr31P7sOK5uFLmsBJv5wX05+EPyvYW5NdaipRmsdNYgnTJIOlFv2d1jDsOE++GAfrLv+m2VkFktYxuaHfKDHa8FrhlFLPDR+ML1KIExHAQVWX2KkgHwa0uSxyfUVaa53vLEXgqmQ84IHpdftO6lzCZshtB1zH3QF23dpg1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710258411; c=relaxed/simple;
	bh=2nhzszbz7r+3VAFRVMBgRPUs0D/pBgtAtvQCGhGw1+s=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HefkoE3wOlu8uEaA6E/KN3spmXFZlyJ9+8QOfCznZXYN3dE6bFrIHgzo5pQYebPryiZvSwFjBKC15HTPTgzcAwOW/AxcwDOjCpIbTpN5gOJ3fP1l1TAgbwc+m4HgGrZGJns9bCD41b/KNd7t3Hbn9sfoyUq1aWizrQ2QCohscsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=VyHLFHr0; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42CCTFEI007698;
	Tue, 12 Mar 2024 15:46:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=K/B/mh5
	nCfsZF9AAgCEI6YXTz4dTuWkM9LNMpjp9S38=; b=VyHLFHr0MMCbHSzWEu9B3M5
	DrALU9clm9fwNqF1D7raDq/JwFn2P0B3rF3YH22boa1iLn9mSBDI1vSls6AmiyAf
	vr2xHyAD/n0ZO1mByHGymuJCnGJcVpXOl11sezlmzcFbT5rjy1YW/RMhoNOJdD7X
	Xm71PesIJ2Qqmcaga4TmwORmIoTKNjKmj3eMNTZzb9T/LeGziyA8+yzgReLlDXx7
	kXPp+YI2mKyvRJG1lR59UUD16+AmAjJrTb6p8afkKscs2p8v4z9TsTumO9U9puv+
	RgotGNKp654sAwvVCFLRtWcbKybeilITXywps37+D79WC5zXkZyv8YMqUgc8c/A=
	=
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wtjwus15n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Mar 2024 15:46:46 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42CFkjdC014587
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Mar 2024 15:46:46 GMT
Received: from cdcwlex322514-lin.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 12 Mar 2024 08:46:44 -0700
From: Aditya Kumar Singh <quic_adisi@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>, Sriram R <quic_srirrama@quicinc.com>,
        Aditya Kumar Singh <quic_adisi@quicinc.com>
Subject: [PATCH] wifi: mac80211: validate link status before deciding on off channel Tx
Date: Tue, 12 Mar 2024 21:16:20 +0530
Message-ID: <20240312154620.242773-1-quic_adisi@quicinc.com>
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
X-Proofpoint-GUID: fg3X0O2InATFOoz5qtUOk1E-pbSHoTMx
X-Proofpoint-ORIG-GUID: fg3X0O2InATFOoz5qtUOk1E-pbSHoTMx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-12_10,2024-03-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=923 clxscore=1015
 malwarescore=0 impostorscore=0 bulkscore=0 mlxscore=0 phishscore=0
 suspectscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403120120

From: Sriram R <quic_srirrama@quicinc.com>

Currently we check the status of bss active flag to see if the AP is
active. But in case of an AP MLD, when some of the links are getting
teardown and some are active, management Tx (like deauthentication) can
be sent on some links before they are brought down as well.

In such cases, the bss active flag might not provide the exact
status of the MLD links. Hence check if any of the links can
be used for management Tx before returning error status.

While at it, when source address is same as the link conf's address and
if userspace requested Tx on a specific link, add changes to use the same
link id if the link bss is matching the requested channel.

Signed-off-by: Sriram R <quic_srirrama@quicinc.com>
Signed-off-by: Aditya Kumar Singh <quic_adisi@quicinc.com>
---
 net/mac80211/offchannel.c | 46 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 44 insertions(+), 2 deletions(-)

diff --git a/net/mac80211/offchannel.c b/net/mac80211/offchannel.c
index 221695d841fd..83f6229fe33b 100644
--- a/net/mac80211/offchannel.c
+++ b/net/mac80211/offchannel.c
@@ -774,6 +774,39 @@ int ieee80211_cancel_remain_on_channel(struct wiphy *wiphy,
 	return ieee80211_cancel_roc(local, cookie, false);
 }
 
+static bool ieee80211_is_link_bss_active(struct ieee80211_sub_if_data *sdata,
+					 int link_id)
+{
+	struct ieee80211_link_data *link;
+
+	lockdep_assert_wiphy(sdata->local->hw.wiphy);
+
+	if (!sdata->bss)
+		return false;
+
+	/* This is consolidated status of the MLD or non ML bss */
+	if (sdata->bss->active)
+		return true;
+
+	if (link_id < 0)
+		return false;
+
+	if (!sdata->vif.valid_links)
+		return false;
+
+	if (!(sdata->vif.valid_links & BIT(link_id)))
+		return false;
+
+	link = sdata_dereference(sdata->link[link_id], sdata);
+	if (!link)
+		return false;
+
+	if (sdata_dereference(link->u.ap.beacon, sdata))
+		return true;
+
+	return false;
+}
+
 int ieee80211_mgmt_tx(struct wiphy *wiphy, struct wireless_dev *wdev,
 		      struct cfg80211_mgmt_tx_params *params, u64 *cookie)
 {
@@ -817,7 +850,7 @@ int ieee80211_mgmt_tx(struct wiphy *wiphy, struct wireless_dev *wdev,
 	case NL80211_IFTYPE_P2P_GO:
 		if (sdata->vif.type != NL80211_IFTYPE_ADHOC &&
 		    !ieee80211_vif_is_mesh(&sdata->vif) &&
-		    !sdata->bss->active)
+		    !ieee80211_is_link_bss_active(sdata, params->link_id))
 			need_offchan = true;
 
 		rcu_read_lock();
@@ -897,8 +930,17 @@ int ieee80211_mgmt_tx(struct wiphy *wiphy, struct wireless_dev *wdev,
 				break;
 			}
 
-			if (ether_addr_equal(conf->addr, mgmt->sa))
+			if (ether_addr_equal(conf->addr, mgmt->sa)) {
+				/* If userspace requested Tx on a specific link
+				 * use the same link id if the link bss is matching
+				 * the requested chan.
+				 */
+				if (sdata->vif.valid_links &&
+				    params->link_id >= 0 && params->link_id == i &&
+				    params->chan == chanctx_conf->def.chan)
+					link_id = i;
 				break;
+			}
 
 			chanctx_conf = NULL;
 		}

base-commit: c2b25092864a16c7865e406badedece5cc25fc2b
-- 
2.25.1


