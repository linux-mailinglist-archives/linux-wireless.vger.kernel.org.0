Return-Path: <linux-wireless+bounces-24275-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ABE9AE11B3
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Jun 2025 05:20:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED5883A5E7A
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Jun 2025 03:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E61C2819;
	Fri, 20 Jun 2025 03:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="GLDJx3/Z"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 900DF433B1;
	Fri, 20 Jun 2025 03:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750389645; cv=none; b=CIztmdrKKBNIFBy1huyjNvFZwONwOoAH5dK4GZ1AYe1MHdP0i5HWw3x+qCx/LN/CzhFLRDbRPhH6TzAWQnmAIzjk/U0PIqnQlJPmfEsGsubIYIsb0SqSx9FlSwRDTK2A8FQJwHzeaaUdXBLvypE8vMQTdtR5NqQcjml2TRnwWnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750389645; c=relaxed/simple;
	bh=i8rXo9oTmd+znrnGkpfCGoydf0YNzqjCk4FPDQRkQ5Q=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OLF/5xI1XknkO/9HnOIsR8rZJ3fylQOA0htstAyH1g9MOfpQxKi4aN9LR+G8XtmswD5q0uCrU+9Dq2J1r5cltww7JIDO0TUeRi6A3SkIhUrPzbymZ0YIf/XSiZIhNrlXHABFo3NLhjuTKf0agpHW7iHE7NheWBEICkoWfoe93Rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=GLDJx3/Z; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55JEtNFB022295;
	Fri, 20 Jun 2025 03:20:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=Sm1w9saYDvAue76l7Riw5u
	3/q50lAkpeH1iSpAdMW5o=; b=GLDJx3/ZLn8lcFzazmY/FtTTuPURXTHxEWJdnq
	o16UAM+7yK/icaTiDP9ByoDRE8Ycn2Dg12Y+ADVrP6PJltG9lGpEYTOIO7tyJ04J
	kGUX9UQx8SJzJlH688tPguwchIRV7xCV3hWRpX5dGcBPcGKxzCR1AyfjH0wmmHVg
	8wDcm6ka6AdXqaHGXzHSS1fyb7KIFcMtHJi7EmXukMb+RAxD8ZcVXSZ1bhUHSwih
	ywCLZUkinV0NLNMWqw5DnilSMUXhHSoDnHAQ4PL1KeOkjfBjmoi3fTKGdE1JOwUs
	sbiEVKc/Q6BXS3Cre9Fe74cYd7tELhrmoM59snubLauYT0RA==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4791enstqm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Jun 2025 03:20:30 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 55K3KToe027165
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Jun 2025 03:20:29 GMT
Received: from zhonhan-gv.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 19 Jun 2025 20:20:27 -0700
From: Zhongqiu Han <quic_zhonhan@quicinc.com>
To: <johannes@sipsolutions.net>, <miriam.rachel.korenblit@intel.com>
CC: <linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_zhonhan@quicinc.com>,
        <syzbot+5a7b40bcb34dea5ca959@syzkaller.appspotmail.com>
Subject: [PATCH v3] wifi: mac80211: Prevent disconnect reports when no AP is associated
Date: Fri, 20 Jun 2025 11:20:11 +0800
Message-ID: <20250620032011.1102373-1-quic_zhonhan@quicinc.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: IMnE3Nd3QSER419gqJ2ryYduQPWHW2Zp
X-Authority-Analysis: v=2.4 cv=D6RHKuRj c=1 sm=1 tr=0 ts=6854d37e cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=6IFa9wvqVegA:10 a=VwQbUJbxAAAA:8 a=1XWaLZrsAAAA:8
 a=COk6AnOGAAAA:8 a=hSkVLCK3AAAA:8 a=UgoVPfYcFPS3iaGcGjQA:9
 a=TjNXssC_j7lpFel5tvFf:22 a=cQPPKAXgyycSBL8etih5:22
X-Proofpoint-GUID: IMnE3Nd3QSER419gqJ2ryYduQPWHW2Zp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjIwMDAyNCBTYWx0ZWRfX4NcqNFXS0wtQ
 OGDJBpS7M9vUJ2pnGcZBbfL1xkfNywTm++V9BARANXEKgPB0g6HsuRK4NIL2xnZIO9Mqgn1LiD7
 kHtv6SAyKb/kf6/sta/T8u2HloIgtDJs3jZta2tKBKv0Q2UGEui0fC0satrMF2pTFnk8ZJZkeco
 MApyphYKOuLYz/rIV5VEieu2CZktaEOTrW73XlOIQquvOidmHGUftYvV4hhyqSyirug8W+0vNn4
 NIkzL2ny3fxhJTtbN1GP1JrZ6jMJuumB8lMiLPRkORtnnOohHZG9E2hNuUA7sPcPFjo7SwOCx22
 BNiA/6y+Gti9CnR+AFsB83NKhW8dkU9FFRUqZRx0xonBKcW1QkTVvyeER4rwbT64SvXcFWNRBxZ
 bCqe8DTDBoCF8oWDvSOFvoLduG2pEbrQn/DkmiYu/sP9uvJS9zgXzSqATOE6xCau+Unpq0KM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-20_01,2025-06-18_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 impostorscore=0 phishscore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 clxscore=1011 mlxscore=0 lowpriorityscore=0
 spamscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506200024

syzbot reports that cfg80211_tx_mlme_mgmt is using uninit-value:

=====================================================
BUG: KMSAN: uninit-value in cfg80211_tx_mlme_mgmt+0x155/0x300 net/wireless/mlme.c:226
cfg80211_tx_mlme_mgmt+0x155/0x300 net/wireless/mlme.c:226
ieee80211_report_disconnect net/mac80211/mlme.c:4238 [inline]
ieee80211_sta_connection_lost+0xfa/0x150 net/mac80211/mlme.c:7811
ieee80211_sta_work+0x1dea/0x4ef0
ieee80211_iface_work+0x1900/0x1970 net/mac80211/iface.c:1684
cfg80211_wiphy_work+0x396/0x860 net/wireless/core.c:435
process_one_work kernel/workqueue.c:3236 [inline]
process_scheduled_works+0xc1a/0x1e80 kernel/workqueue.c:3317
worker_thread+0xea7/0x14f0 kernel/workqueue.c:3398
kthread+0x6b9/0xef0 kernel/kthread.c:464
ret_from_fork+0x6d/0x90 arch/x86/kernel/process.c:148
ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Local variable frame_buf created at:
ieee80211_sta_connection_lost+0x43/0x150 net/mac80211/mlme.c:7806
ieee80211_sta_work+0x1dea/0x4ef0
=====================================================

If ieee80211_report_disconnect() relies on the frame_buf initialized by
ieee80211_set_disassoc(), it must ensure that ieee80211_set_disassoc() has
called ieee80211_send_deauth_disassoc() to initialize it and has not
returned early. Since commit 687a7c8a7227 ("wifi: mac80211: change
disassoc sequence a bit"), ieee80211_set_disassoc() may return immediately
when no AP station is present, leaving frame_buf uninitialized.

To fix this issue, check the return value of ieee80211_set_disassoc()
before calling ieee80211_report_disconnect() if the latter relies on the
frame_buf initialized by the former.

Reported-by: syzbot+5a7b40bcb34dea5ca959@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/67bf36d3.050a0220.38b081.01ff.GAE@google.com/
Fixes: 687a7c8a7227 ("wifi: mac80211: change disassoc sequence a bit")
Signed-off-by: Zhongqiu Han <quic_zhonhan@quicinc.com>
---
v2 -> v3:
- Rebased on top of current next.
- Update the v2 code implementation:
  - Remove zero-initialization of frame_buf
  - Remove WARN_ON and early return in ieee80211_report_disconnect()
  - Change the return type of ieee80211_set_disassoc(). If
    ieee80211_report_disconnect() uses the frame_buf initialized by
    ieee80211_set_disassoc(), its invocation is now conditional based
    on the return value of ieee80211_set_disassoc(). 
- Update commit message to reflect the modified code logic.
- Link to v2: https://lore.kernel.org/all/20250314120614.4032434-1-quic_zhonhan@quicinc.com/

v1 -> v2:
- Rebased on top of current next.
- Reorder the tags.
- Link to v1: https://lore.kernel.org/all/20250227090932.1871272-1-quic_zhonhan@quicinc.com/

 net/mac80211/mlme.c | 109 +++++++++++++++++++++++++++-----------------
 1 file changed, 67 insertions(+), 42 deletions(-)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 2d46d4af60d7..51750db61a54 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -3917,7 +3917,12 @@ static void ieee80211_ml_reconf_reset(struct ieee80211_sub_if_data *sdata)
 	}
 }
 
-static void ieee80211_set_disassoc(struct ieee80211_sub_if_data *sdata,
+/*
+ * Note that if ieee80211_report_disconnect() relies on the *frame_buf
+ * initialized by this function, then it must only be called if this function
+ * returns true; otherwise, it may use an uninitialized buffer.
+ */
+static bool ieee80211_set_disassoc(struct ieee80211_sub_if_data *sdata,
 				   u16 stype, u16 reason, bool tx,
 				   u8 *frame_buf)
 {
@@ -3935,13 +3940,13 @@ static void ieee80211_set_disassoc(struct ieee80211_sub_if_data *sdata,
 	lockdep_assert_wiphy(local->hw.wiphy);
 
 	if (WARN_ON(!ap_sta))
-		return;
+		return false;
 
 	if (WARN_ON_ONCE(tx && !frame_buf))
-		return;
+		return false;
 
 	if (WARN_ON(!ifmgd->associated))
-		return;
+		return false;
 
 	ieee80211_stop_poll(sdata);
 
@@ -4168,6 +4173,8 @@ static void ieee80211_set_disassoc(struct ieee80211_sub_if_data *sdata,
 
 	memset(ifmgd->userspace_selectors, 0,
 	       sizeof(ifmgd->userspace_selectors));
+
+	return true;
 }
 
 static void ieee80211_reset_ap_probe(struct ieee80211_sub_if_data *sdata)
@@ -4448,6 +4455,7 @@ static void __ieee80211_disconnect(struct ieee80211_sub_if_data *sdata)
 	struct ieee80211_local *local = sdata->local;
 	struct ieee80211_if_managed *ifmgd = &sdata->u.mgd;
 	u8 frame_buf[IEEE80211_DEAUTH_FRAME_LEN];
+	bool report_disconnect;
 
 	lockdep_assert_wiphy(local->hw.wiphy);
 
@@ -4477,20 +4485,22 @@ static void __ieee80211_disconnect(struct ieee80211_sub_if_data *sdata)
 		}
 	}
 
-	ieee80211_set_disassoc(sdata, IEEE80211_STYPE_DEAUTH,
-			       ifmgd->driver_disconnect ?
-					WLAN_REASON_DEAUTH_LEAVING :
-					WLAN_REASON_DISASSOC_DUE_TO_INACTIVITY,
-			       true, frame_buf);
+	report_disconnect = ieee80211_set_disassoc(sdata, IEEE80211_STYPE_DEAUTH,
+						   ifmgd->driver_disconnect ?
+						   WLAN_REASON_DEAUTH_LEAVING :
+						   WLAN_REASON_DISASSOC_DUE_TO_INACTIVITY,
+						   true, frame_buf);
 	/* the other links will be destroyed */
 	sdata->vif.bss_conf.csa_active = false;
 	sdata->deflink.u.mgd.csa.waiting_bcn = false;
 	sdata->deflink.u.mgd.csa.blocked_tx = false;
 	ieee80211_vif_unblock_queues_csa(sdata);
 
-	ieee80211_report_disconnect(sdata, frame_buf, sizeof(frame_buf), true,
-				    WLAN_REASON_DISASSOC_DUE_TO_INACTIVITY,
-				    ifmgd->reconnect);
+	if (report_disconnect)
+		ieee80211_report_disconnect(sdata, frame_buf, sizeof(frame_buf),
+					    true, WLAN_REASON_DISASSOC_DUE_TO_INACTIVITY,
+					    ifmgd->reconnect);
+
 	ifmgd->reconnect = false;
 }
 
@@ -7477,9 +7487,12 @@ static void ieee80211_rx_mgmt_beacon(struct ieee80211_link_data *link,
 	changed |= ieee80211_recalc_twt_req(sdata, sband, link, link_sta, elems);
 
 	if (ieee80211_config_bw(link, elems, true, &changed, "beacon")) {
-		ieee80211_set_disassoc(sdata, IEEE80211_STYPE_DEAUTH,
-				       WLAN_REASON_DEAUTH_LEAVING,
-				       true, deauth_buf);
+		if (!ieee80211_set_disassoc(sdata,
+					    IEEE80211_STYPE_DEAUTH,
+					    WLAN_REASON_DEAUTH_LEAVING,
+					    true, deauth_buf))
+			goto free;
+
 		ieee80211_report_disconnect(sdata, deauth_buf,
 					    sizeof(deauth_buf), true,
 					    WLAN_REASON_DEAUTH_LEAVING,
@@ -8090,8 +8103,9 @@ void ieee80211_sta_connection_lost(struct ieee80211_sub_if_data *sdata,
 {
 	u8 frame_buf[IEEE80211_DEAUTH_FRAME_LEN];
 
-	ieee80211_set_disassoc(sdata, IEEE80211_STYPE_DEAUTH, reason,
-			       tx, frame_buf);
+	if (!ieee80211_set_disassoc(sdata, IEEE80211_STYPE_DEAUTH, reason,
+				    tx, frame_buf))
+		return;
 
 	ieee80211_report_disconnect(sdata, frame_buf, sizeof(frame_buf), true,
 				    reason, false);
@@ -8967,7 +8981,7 @@ int ieee80211_mgd_auth(struct ieee80211_sub_if_data *sdata,
 	struct ieee80211_bss *bss;
 	u16 auth_alg;
 	int err;
-	bool cont_auth, wmm_used;
+	bool cont_auth, wmm_used, report_disconnect;
 
 	lockdep_assert_wiphy(sdata->local->hw.wiphy);
 
@@ -9089,14 +9103,16 @@ int ieee80211_mgd_auth(struct ieee80211_sub_if_data *sdata,
 		sdata_info(sdata,
 			   "disconnect from AP %pM for new auth to %pM\n",
 			   sdata->vif.cfg.ap_addr, auth_data->ap_addr);
-		ieee80211_set_disassoc(sdata, IEEE80211_STYPE_DEAUTH,
-				       WLAN_REASON_UNSPECIFIED,
-				       false, frame_buf);
+		report_disconnect = ieee80211_set_disassoc(sdata,
+							   IEEE80211_STYPE_DEAUTH,
+							   WLAN_REASON_UNSPECIFIED,
+							   false, frame_buf);
 
-		ieee80211_report_disconnect(sdata, frame_buf,
-					    sizeof(frame_buf), true,
-					    WLAN_REASON_UNSPECIFIED,
-					    false);
+		if (report_disconnect)
+			ieee80211_report_disconnect(sdata, frame_buf,
+						    sizeof(frame_buf), true,
+						    WLAN_REASON_UNSPECIFIED,
+						    false);
 	}
 
 	/* needed for transmitting the auth frame(s) properly */
@@ -9345,6 +9361,7 @@ int ieee80211_mgd_assoc(struct ieee80211_sub_if_data *sdata,
 	struct cfg80211_bss *cbss;
 	bool override, uapsd_supported;
 	bool match_auth;
+	bool report_disconnect;
 	int i, err;
 	size_t size = sizeof(*assoc_data) + req->ie_len;
 
@@ -9392,14 +9409,16 @@ int ieee80211_mgd_assoc(struct ieee80211_sub_if_data *sdata,
 		sdata_info(sdata,
 			   "disconnect from AP %pM for new assoc to %pM\n",
 			   sdata->vif.cfg.ap_addr, assoc_data->ap_addr);
-		ieee80211_set_disassoc(sdata, IEEE80211_STYPE_DEAUTH,
-				       WLAN_REASON_UNSPECIFIED,
-				       false, frame_buf);
+		report_disconnect = ieee80211_set_disassoc(sdata,
+							   IEEE80211_STYPE_DEAUTH,
+							   WLAN_REASON_UNSPECIFIED,
+							   false, frame_buf);
 
-		ieee80211_report_disconnect(sdata, frame_buf,
-					    sizeof(frame_buf), true,
-					    WLAN_REASON_UNSPECIFIED,
-					    false);
+		if (report_disconnect)
+			ieee80211_report_disconnect(sdata, frame_buf,
+						    sizeof(frame_buf), true,
+						    WLAN_REASON_UNSPECIFIED,
+						    false);
 	}
 
 	memset(sdata->u.mgd.userspace_selectors, 0,
@@ -9720,6 +9739,7 @@ int ieee80211_mgd_deauth(struct ieee80211_sub_if_data *sdata,
 	struct ieee80211_if_managed *ifmgd = &sdata->u.mgd;
 	u8 frame_buf[IEEE80211_DEAUTH_FRAME_LEN];
 	bool tx = !req->local_state_change;
+	bool report_disconnect;
 	struct ieee80211_prep_tx_info info = {
 		.subtype = IEEE80211_STYPE_DEAUTH,
 	};
@@ -9773,11 +9793,14 @@ int ieee80211_mgd_deauth(struct ieee80211_sub_if_data *sdata,
 			   req->bssid, req->reason_code,
 			   ieee80211_get_reason_code_string(req->reason_code));
 
-		ieee80211_set_disassoc(sdata, IEEE80211_STYPE_DEAUTH,
-				       req->reason_code, tx, frame_buf);
-		ieee80211_report_disconnect(sdata, frame_buf,
-					    sizeof(frame_buf), true,
-					    req->reason_code, false);
+		report_disconnect = ieee80211_set_disassoc(sdata,
+							   IEEE80211_STYPE_DEAUTH,
+							   req->reason_code, tx, frame_buf);
+
+		if (report_disconnect)
+			ieee80211_report_disconnect(sdata, frame_buf,
+						    sizeof(frame_buf), true,
+						    req->reason_code, false);
 		return 0;
 	}
 
@@ -9788,6 +9811,7 @@ int ieee80211_mgd_disassoc(struct ieee80211_sub_if_data *sdata,
 			   struct cfg80211_disassoc_request *req)
 {
 	u8 frame_buf[IEEE80211_DEAUTH_FRAME_LEN];
+	bool report_disconnect;
 
 	if (!sdata->u.mgd.associated ||
 	    memcmp(sdata->vif.cfg.ap_addr, req->ap_addr, ETH_ALEN))
@@ -9798,12 +9822,13 @@ int ieee80211_mgd_disassoc(struct ieee80211_sub_if_data *sdata,
 		   req->ap_addr, req->reason_code,
 		   ieee80211_get_reason_code_string(req->reason_code));
 
-	ieee80211_set_disassoc(sdata, IEEE80211_STYPE_DISASSOC,
-			       req->reason_code, !req->local_state_change,
-			       frame_buf);
+	report_disconnect = ieee80211_set_disassoc(sdata, IEEE80211_STYPE_DISASSOC,
+						   req->reason_code, !req->local_state_change,
+						   frame_buf);
 
-	ieee80211_report_disconnect(sdata, frame_buf, sizeof(frame_buf), true,
-				    req->reason_code, false);
+	if (report_disconnect)
+		ieee80211_report_disconnect(sdata, frame_buf, sizeof(frame_buf), true,
+					    req->reason_code, false);
 
 	return 0;
 }
-- 
2.43.0


