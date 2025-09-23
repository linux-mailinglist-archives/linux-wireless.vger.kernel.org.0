Return-Path: <linux-wireless+bounces-27599-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BF686B94CBC
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Sep 2025 09:36:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B14A01893F47
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Sep 2025 07:36:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A7EE2E92BC;
	Tue, 23 Sep 2025 07:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="l0Zk/ilN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EBF031579B
	for <linux-wireless@vger.kernel.org>; Tue, 23 Sep 2025 07:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758612986; cv=none; b=fWws4Cec3fl0jzB6IErWdZyODZJxw5/TVxf5ZTo6sOPdOzbpnkXjLkZ3wduwTtq/Z0z0zNvR6JoAIvNkVbWCijkHlkILZCJ2QzuqwgEQPI8PkOD5R69+IC2e3FgjVgxrLmY87Bfa3DnMtHCz59yo4FDtdNadkQXvFK6207VKNpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758612986; c=relaxed/simple;
	bh=p3Q6sLtkpfXvbuNUllsZACdukh9gKe9jLNhSC1zV5vQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ntTssIKQzMfoDnPtI7nOxy7OstIafWkqUUcE3XEaRqwPwoQ/0raCJBAE4cS44fUPd1ZscoT2DcqtboQaHT2DoDZr8UB61xADRAyogaNEhhvZ17pozZ/NPxZejjh5pg9OlYxFhJgxM7euVehQ/BcPQ181/gqFyhl3VH5M5/fVN0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=l0Zk/ilN; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58N6ZhIX005251;
	Tue, 23 Sep 2025 07:36:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	JPA3u660Wy4XLo2BA0JH6Hxjl1wY1wEacj4Itw6SMcQ=; b=l0Zk/ilNESZNYT37
	DpTDlGFNAdoVH8R4v6NF8+SJXOh+O8OBn7wGXjdOuZHxNKJiyODLAY4TV+ERLDQu
	Z5c1VS/nWRSgS5hw7vpHZ7C+PuuM0JlA+ymOY1P6dtIYdqfsI/oiX5edFgxfKkm2
	eCuVsCEMl4YZ60SP/ez37fTZvjbw2PkH/BHK8bhVpxIfxyJUGIeiUTIW84TwcSqL
	1Ef8SMB2c9c0ri36Z5cIBSrHEWLShBHlQN1vO15eHc9QsrgC6Y/8fRDoh3I+6Tr2
	1ZBPvJbQDfGY88IcHlh83WmgnSFipYYBUjULXzv3KsbCKP7U/fTy4KvXRkNTrhwH
	wvPo9g==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49bjpdrskh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Sep 2025 07:36:20 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 58N7aJN4002200
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Sep 2025 07:36:19 GMT
Received: from hu-amitajit-blr.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.24; Tue, 23 Sep 2025 00:36:17 -0700
From: Amith A <quic_amitajit@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>, <quic_amitajit@quicinc.com>,
        "Hari
 Chandrakanthan" <quic_haric@quicinc.com>,
        Aditya Kumar Singh
	<aditya.kumar.singh@oss.qualcomm.com>
Subject: [PATCH wireless-next v3 2/3] wifi: mac80211: add support to handle incumbent signal detected event from driver
Date: Tue, 23 Sep 2025 13:05:53 +0530
Message-ID: <20250923073554.3438429-3-quic_amitajit@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250923073554.3438429-1-quic_amitajit@quicinc.com>
References: <20250923073554.3438429-1-quic_amitajit@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: qJ1yIVRHOc-wYOq7QTnXihYXjpm97OzQ
X-Authority-Analysis: v=2.4 cv=Pc//hjhd c=1 sm=1 tr=0 ts=68d24df4 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=fviwIs6HuNtE6Pcbgu4A:9 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: qJ1yIVRHOc-wYOq7QTnXihYXjpm97OzQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIzMDAyMCBTYWx0ZWRfXwfPKpYaEfWEq
 fNXvUbvya1ePWiahJ1OebhmUno1TV43MJjVxnH9leWjggziQvpHOB0ngMu9xjfJ3F2/twEPN1wX
 eq7vl5PCIvvOLzWlLL4Du9t9YSwBl42qYVk95iT9cIxY/c46tRQIXp1FrbcS/G1pKrWHmijbiZg
 RgXfnJ/vkDkk75bapFasTHd15KQwj8bqpCfbdQaa8aYunYAJovMVjVD2nHG0VILAasKpAazmdh9
 SK8LEwYzsgyBpQ4Vm9lJTL5Avleze0O36v1a19gPneQzSNJaU5V5IaqKfhGcxDJRRzqR0P1ZwvV
 6H9qIzRHM8qhv0ftCfwRDkFclzEJCK+msaSHDofEcZCv6/lgwvVABi/PpQZ4Gw+kZSDoLzn7AUT
 wVm0Kaz4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-23_01,2025-09-22_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 bulkscore=0 malwarescore=0 impostorscore=0
 spamscore=0 suspectscore=0 clxscore=1015 adultscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509230020

From: Hari Chandrakanthan <quic_haric@quicinc.com>

Add a new API ieee80211_incumbent_signal_detected() that can be used by
wireless drivers to notify the higher layers about the interference of
incumbent signals in 6 GHz band with the operating channel (mandatory to
pass during MLO) and the interference bitmap in which each bit denotes
the affected 20 MHz in the operating channel.

Signed-off-by: Hari Chandrakanthan <quic_haric@quicinc.com>
Co-developed-by: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
Signed-off-by: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
Signed-off-by: Amith A <quic_amitajit@quicinc.com>
---
 include/net/mac80211.h | 18 ++++++++++++++++++
 net/mac80211/trace.h   | 26 ++++++++++++++++++++++++++
 net/mac80211/util.c    | 15 +++++++++++++++
 3 files changed, 59 insertions(+)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index a45e4bee65d4..678e58609280 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -257,6 +257,8 @@ struct ieee80211_chan_req {
  *	after RTS/CTS handshake to receive SMPS MIMO transmissions;
  *	this will always be >= @rx_chains_static.
  * @radar_enabled: whether radar detection is enabled on this channel.
+ * @incumbt_sig_intf_bmap: Bitmap indicating the sub-channels where an
+ *	incumbent signal's interference was detected.
  * @drv_priv: data area for driver use, will always be aligned to
  *	sizeof(void *), size is determined in hw information.
  */
@@ -270,6 +272,8 @@ struct ieee80211_chanctx_conf {
 
 	bool radar_enabled;
 
+	u32 incumbt_sig_intf_bmap;
+
 	u8 drv_priv[] __aligned(sizeof(void *));
 };
 
@@ -7834,4 +7838,18 @@ int ieee80211_emulate_switch_vif_chanctx(struct ieee80211_hw *hw,
 					 int n_vifs,
 					 enum ieee80211_chanctx_switch_mode mode);
 
+/**
+ * ieee80211_incumbent_signal_detected - inform that an incumbent signal
+ *	interference was detected
+ * @hw: pointer as obtained from ieee80211_alloc_hw()
+ * @chanctx_conf: Channel context on which the signal interference was detected.
+ *	Mandatory to pass a valid pointer for MLO. For non-MLO %NULL can be
+ *	passed
+ * @incumbt_sig_intf_bmap: Bitmap indicating where the incumbent signal was
+ *	detected.
+ */
+void ieee80211_incumbent_signal_detected(struct ieee80211_hw *hw,
+					 struct ieee80211_chanctx_conf *chanctx_conf,
+					 u32 incumbt_sig_intf_bmap);
+
 #endif /* MAC80211_H */
diff --git a/net/mac80211/trace.h b/net/mac80211/trace.h
index 0bfbce157486..ce97faab1765 100644
--- a/net/mac80211/trace.h
+++ b/net/mac80211/trace.h
@@ -3136,6 +3136,32 @@ TRACE_EVENT(api_radar_detected,
 	)
 );
 
+TRACE_EVENT(api_incumbent_signal_detected,
+	TP_PROTO(struct ieee80211_local *local,
+		 struct ieee80211_chanctx_conf *chanctx_conf),
+
+	TP_ARGS(local, chanctx_conf),
+
+	TP_STRUCT__entry(
+		LOCAL_ENTRY
+		CHANDEF_ENTRY
+		__field(u32, bitmap)
+	),
+
+	TP_fast_assign(
+		LOCAL_ASSIGN;
+		CHANDEF_ASSIGN(&chanctx_conf->def)
+		__entry->bitmap =
+			chanctx_conf ? chanctx_conf->incumbt_sig_intf_bmap : 0;
+	),
+
+	TP_printk(
+		LOCAL_PR_FMT " Incumbent signal detected."
+		CHANDEF_PR_FMT " Bitmap: 0x%x ",
+		LOCAL_PR_ARG, CHANDEF_PR_ARG, __entry->bitmap
+	)
+);
+
 TRACE_EVENT(api_request_smps,
 	TP_PROTO(struct ieee80211_local *local,
 		 struct ieee80211_sub_if_data *sdata,
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index 9eb35e3b9e52..68beb0725cf3 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -3592,6 +3592,21 @@ void ieee80211_radar_detected(struct ieee80211_hw *hw,
 }
 EXPORT_SYMBOL(ieee80211_radar_detected);
 
+void ieee80211_incumbent_signal_detected(struct ieee80211_hw *hw,
+					 struct ieee80211_chanctx_conf *chanctx_conf,
+					 u32 incumbt_sig_intf_bmap)
+{
+	struct ieee80211_local *local = hw_to_local(hw);
+
+	chanctx_conf->incumbt_sig_intf_bmap = incumbt_sig_intf_bmap;
+
+	trace_api_incumbent_signal_detected(local, chanctx_conf);
+	cfg80211_incumbent_signal_notify(hw->wiphy,
+					 &chanctx_conf->def,
+					 chanctx_conf->incumbt_sig_intf_bmap);
+}
+EXPORT_SYMBOL(ieee80211_incumbent_signal_detected);
+
 void ieee80211_chandef_downgrade(struct cfg80211_chan_def *c,
 				 struct ieee80211_conn_settings *conn)
 {
-- 
2.34.1


