Return-Path: <linux-wireless+bounces-4825-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92DBF87E328
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Mar 2024 06:36:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA6AA2828E2
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Mar 2024 05:36:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 212DB2135B;
	Mon, 18 Mar 2024 05:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="iQdf+rXq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AB7A21350
	for <linux-wireless@vger.kernel.org>; Mon, 18 Mar 2024 05:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710740205; cv=none; b=pPnCFlKj4zSVRrg/1+ii8BtzrcyesSsyDpZEn1fVONaX3Xchk28/tGZl+R9BCI6AoNX0sl6H6Yq8E/V/Z8O9Zz5hlhc+ndHYruRvZcBT5efVDd9NLF8m8tSDqmo7haiINdBQACSSpi1FX5BkLrgmvHRGkjRLoK5b+T+pylSLXZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710740205; c=relaxed/simple;
	bh=3bzLpLmEN3flrMJ7RnBT4SI/mI7elb+BvDAVWoJjaGk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q/YHMLNLSuLWA2YvgwFGDHV3VpsZDnNZ7MZASMd3EN6jX2MUrTvAwFWYZc7a0ibz+8+CzbgVcaFV4iirHUgDTZ+vKml9kWluFP6gwt9t7/ElS+ZRC5ocUkh03/d6iPvfz6jTNyISZHx4Yo7Tav5ipUcDkkhbMTLmR5WUaDzBZMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=iQdf+rXq; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42I3ogJG021002;
	Mon, 18 Mar 2024 05:36:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=7e22XGmk9WAbxjklen6S05SYmbmU6HoTYhYaQUP66sM=; b=iQ
	df+rXqk2UaJbFZOh6XMQuC+V6zvH0h21oxf9ocFeebjrmpZ2CJGzX1JnI1VxAOSo
	RoOYo85edU82CJUoGwzz+qhl1GasLjEQ29ql08Kt5vS+FdFNV0w6yErhTVAXKYX7
	T1J/jR8hzwAm9e4GKyNDr+9ITph35dC05U5V8R4ZSeJCRB0rYFaxQBsN+12DqXOr
	TSGyttgxWo7Mzps6l0Aav9DIixn8d3lRY+AodnSX03Ff6Ptmb1Wdtlf9rMeFMB8e
	rGvtm8KBICSXngDmSdOJFpMnn4Z2u0UU4fXTFN5CmEMl9DBkRxVzHjqhPLSJC+NX
	ujGR2zg1fMCWcsjsp5fA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wwxta95b7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Mar 2024 05:36:33 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42I5aWHZ014017
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Mar 2024 05:36:32 GMT
Received: from hu-rrchinan-blr.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Sun, 17 Mar 2024 22:36:30 -0700
From: Rathees Kumar R Chinannan <quic_rrchinan@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Rathees Kumar R Chinannan
	<quic_rrchinan@quicinc.com>
Subject: [RFC 2/2] wifi: mac80211: Indicate ongoing critical update parameters
Date: Mon, 18 Mar 2024 11:06:07 +0530
Message-ID: <20240318053607.1056739-3-quic_rrchinan@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240318053607.1056739-1-quic_rrchinan@quicinc.com>
References: <20240318053607.1056739-1-quic_rrchinan@quicinc.com>
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
X-Proofpoint-GUID: WBzJv_-MMdhscaGXIiE4PlwJWUYcbzbP
X-Proofpoint-ORIG-GUID: WBzJv_-MMdhscaGXIiE4PlwJWUYcbzbP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-17_12,2024-03-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 malwarescore=0 adultscore=0 spamscore=0 impostorscore=0
 mlxscore=0 phishscore=0 lowpriorityscore=0 mlxlogscore=999 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403140001 definitions=main-2403180040

User space application doesn't have the latest ongoing critical
update parameters like critical update flag, BSS param change
count (BPCC) and CSA/CCA switch count for each link. Add an
ieee80211_critical_update() API to send these params to cfg80211
and call it when event received from firmware during probe or assoc
or reassoc request frame receive to update critical parameters to
user space and needed only on beacon offload case.

Signed-off-by: Rathees Kumar R Chinannan <quic_rrchinan@quicinc.com>
---
 include/net/mac80211.h | 13 +++++++++++++
 net/mac80211/cfg.c     | 35 ++++++++++++++++++++++++++++++++++-
 net/mac80211/rx.c      | 12 ++++++++++++
 net/mac80211/tx.c      |  5 +++++
 4 files changed, 64 insertions(+), 1 deletion(-)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 353488ab94a2..a369f0d7087d 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -7599,4 +7599,17 @@ int ieee80211_emulate_switch_vif_chanctx(struct ieee80211_hw *hw,
 					 int n_vifs,
 					 enum ieee80211_chanctx_switch_mode mode);
 
+/**
+ * ieee80211_critical_update - update critical params for each link
+ * @vif: the specified virtual interface
+ * @link_id: the link ID for MLO, otherwise 0
+ * @critical_flag: critical update information
+ * @bpcc: Bss parameter change count value
+ *
+ * The function is called when event received from firmware to update
+ * critical parameters to user space during probe or assoc or reassoc request
+ * frame receive and needed only on beacon offload case.
+ */
+void ieee80211_critical_update(struct ieee80211_vif *vif, unsigned int link_id,
+			       bool critical_flag, u8 bpcc);
 #endif /* MAC80211_H */
diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index f03452dc716d..65978f7b5a19 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -3606,6 +3606,7 @@ void ieee80211_csa_finish(struct ieee80211_vif *vif, unsigned int link_id)
 	struct ieee80211_sub_if_data *sdata = vif_to_sdata(vif);
 	struct ieee80211_local *local = sdata->local;
 	struct ieee80211_link_data *link_data;
+	struct wireless_dev *wdev = ieee80211_vif_to_wdev(vif);
 
 	if (WARN_ON(link_id >= IEEE80211_MLD_MAX_NUM_LINKS))
 		return;
@@ -3617,7 +3618,10 @@ void ieee80211_csa_finish(struct ieee80211_vif *vif, unsigned int link_id)
 		rcu_read_unlock();
 		return;
 	}
-
+	if (wdev->valid_links && wdev->links[link_id].ap.switch_count != 0) {
+		wdev->links[link_id].ap.switch_count = 0;
+		wdev->critical_update = true;
+	}
 	/* TODO: MBSSID with MLO changes */
 	if (vif->mbssid_tx_vif == vif) {
 		/* Trigger ieee80211_csa_finish() on the non-transmitting
@@ -3643,6 +3647,35 @@ void ieee80211_csa_finish(struct ieee80211_vif *vif, unsigned int link_id)
 }
 EXPORT_SYMBOL(ieee80211_csa_finish);
 
+/**
+ * ieee80211_critical_update - update critical params for each link
+ * @vif: the specified virtual interface
+ * @link_id: the link ID for MLO, otherwise 0
+ * @critical_flag: critical update information
+ * @bpcc: Bss parameter change count value
+ *
+ * The function is called when event received from firmware to update
+ * critical parameters to user space during probe or assoc or reassoc request
+ * frame receive and needed only on beacon offload case.
+ */
+void ieee80211_critical_update(struct ieee80211_vif *vif, unsigned int link_id,
+			       bool critical_flag, u8 bpcc)
+{
+	struct wireless_dev *wdev = ieee80211_vif_to_wdev(vif);
+
+	if (!wdev->valid_links)
+		return;
+	if (WARN_ON(link_id > IEEE80211_MLD_MAX_NUM_LINKS))
+		return;
+	if (wdev->links[link_id].ap.critical_flag != critical_flag ||
+	    wdev->links[link_id].ap.bpcc != bpcc) {
+		wdev->critical_update = true;
+		wdev->links[link_id].ap.critical_flag = critical_flag;
+		wdev->links[link_id].ap.bpcc = bpcc;
+	}
+}
+EXPORT_SYMBOL(ieee80211_critical_update);
+
 void ieee80211_channel_switch_disconnect(struct ieee80211_vif *vif, bool block_tx)
 {
 	struct ieee80211_sub_if_data *sdata = vif_to_sdata(vif);
diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index c1f850138405..e60560b4e3e4 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -3825,14 +3825,26 @@ static ieee80211_rx_result debug_noinline
 ieee80211_rx_h_userspace_mgmt(struct ieee80211_rx_data *rx)
 {
 	struct ieee80211_rx_status *status = IEEE80211_SKB_RXCB(rx->skb);
+	struct ieee80211_mgmt *mgmt = (void *)rx->skb->data;
+	__le16 stype;
+	struct wireless_dev *wdev = &rx->sdata->wdev;
+
 	struct cfg80211_rx_info info = {
 		.freq = ieee80211_rx_status_to_khz(status),
 		.buf = rx->skb->data,
 		.len = rx->skb->len,
 		.link_id = rx->link_id,
 		.have_link_id = rx->link_id >= 0,
+		.critical_update = false,
 	};
 
+	stype = mgmt->frame_control & cpu_to_le16(IEEE80211_FCTL_STYPE);
+	if (stype ==  cpu_to_le16(IEEE80211_STYPE_PROBE_REQ) ||
+	    stype ==  cpu_to_le16(IEEE80211_STYPE_ASSOC_REQ) ||
+	    stype ==  cpu_to_le16(IEEE80211_STYPE_REASSOC_REQ)) {
+		if (wdev->critical_update)
+			info.critical_update = true;
+	}
 	/* skip known-bad action frames and return them in the next handler */
 	if (status->rx_flags & IEEE80211_RX_MALFORMED_ACTION_FRM)
 		return RX_CONTINUE;
diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index 6bf223e6cd1a..00179e73396a 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -5041,6 +5041,7 @@ u8 ieee80211_beacon_update_cntdwn(struct ieee80211_vif *vif, unsigned int link_i
 	struct ieee80211_sub_if_data *sdata = vif_to_sdata(vif);
 	struct ieee80211_link_data *link;
 	struct beacon_data *beacon = NULL;
+	struct wireless_dev *wdev = ieee80211_vif_to_wdev(vif);
 	u8 count = 0;
 
 	if (WARN_ON(link_id >= IEEE80211_MLD_MAX_NUM_LINKS))
@@ -5063,6 +5064,10 @@ u8 ieee80211_beacon_update_cntdwn(struct ieee80211_vif *vif, unsigned int link_i
 		goto unlock;
 
 	count = __ieee80211_beacon_update_cntdwn(beacon);
+	if (wdev->valid_links && wdev->links[link_id].ap.switch_count != count) {
+		wdev->links[link_id].ap.switch_count = count;
+		wdev->critical_update = true;
+	}
 
 unlock:
 	rcu_read_unlock();
-- 
2.34.1


