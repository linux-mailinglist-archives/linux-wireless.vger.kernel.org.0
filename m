Return-Path: <linux-wireless+bounces-26432-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 438B4B29EEC
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Aug 2025 12:20:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1AF864E00C5
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Aug 2025 10:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E88F0311581;
	Mon, 18 Aug 2025 10:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Vnb9UxK3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEED92701C3
	for <linux-wireless@vger.kernel.org>; Mon, 18 Aug 2025 10:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755512421; cv=none; b=ORzRnYuAOJ60FxigYRcUtW70ns5EoMBM9RBibIkGYnBP2akfw0Nz5YA+CwSdTWIDN5BPTByLCw6iCTkbn/WhDoubqdTgozKWyLJC5GCKdRiIz3mjT+8l/Xl52Tk1eftFBrBsG1iwxIu2+O7Lb91pAjbbsGSTLkZrUHTeZSiYVfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755512421; c=relaxed/simple;
	bh=sEp3tGuG0AHLU9I4E4dh3jenKwWkdpXE5h7GqvvxwSg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rbnZRj+iyYuXYyNRP3AbhN0ZzLahvNu4TG5B8rbPcxj+A0Go7Vsplx3FKw3aWxtSLXBflUR7Jb/UR1mSfi4uuaxZuhy2jKUQjjlWzsmKHJPcuxwhO4CkiF5UPwqnrmmDM+8FSsc70rp6wHKpRpGWhzngYfMA/h/ljOtcRHYsqWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Vnb9UxK3; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57I7nV16031285;
	Mon, 18 Aug 2025 10:20:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	v73dYQ0akVW8HLeJ18479ZnENBHkbzf9mRfxn9ODDpU=; b=Vnb9UxK3LYc5mqER
	N1HNXlye4eN0ASmLPsGQXLxC+ww+OJqfZMS29jGhZVdpuBpl626iFQWsqfMiZJHg
	Lw5YXqRHj09K3gJVX+YUlCW7lGvsY2QmqZczGGdjeoXrZeoI5UZX1HYC5uBJg4NY
	+ZEqgyYiq6NQziFyH7CBvzOKc3FFYfqy9tJSBfJPQQIC/ydobLODEfnRzk4tymsa
	L0+re8joy6U/2U4z5egM1coyxGSle0UKcylD7tGEJgOjsL9MGVPhehN0Oo14BaNZ
	l5wWInReDm8B5lPPxg2xFdUkbNQEG5yNbejJbUkrcPw2+C7V2MDshxn3pyDT/sxd
	2lfCMQ==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48jjc7v93u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Aug 2025 10:20:15 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 57IAK908016920
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Aug 2025 10:20:09 GMT
Received: from hu-amitajit-blr.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 18 Aug 2025 03:20:07 -0700
From: Amith A <quic_amitajit@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>, <quic_amitajit@quicinc.com>,
        "Hari
 Chandrakanthan" <quic_haric@quicinc.com>,
        Aditya Kumar Singh
	<aditya.kumar.singh@oss.qualcomm.com>
Subject: [PATCH wireless-next 2/3] wifi: mac80211: add support to handle incumbent signal detected event from driver
Date: Mon, 18 Aug 2025 15:49:46 +0530
Message-ID: <20250818101947.2464612-3-quic_amitajit@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250818101947.2464612-1-quic_amitajit@quicinc.com>
References: <20250818101947.2464612-1-quic_amitajit@quicinc.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE2MDAzMyBTYWx0ZWRfXyldSqaDrPkSB
 mfn6HcfRzvZh9VkPtTEw9iQvn1YEC4f8YPco3qWPcZcjFTqWjH8sI0E12TBgRozEnycXMYV2D3v
 mQg/F2aCxFxgwvBKmZTWQlZi05VJOjvowjZbLVC1zIFXqMiEYFP+5OzAHmH0M/N8kI36og6xAUQ
 6YGXFxVrJkoQg5BbYeY8/+EPWbqLW0vyRgaauZRbHMqDI8zE8XReizwNCmQY+PnQqSlWkTmOZfa
 dDPp+YpSvspFoXjys0X86O69dch5gfueD497h0DlV553ccB8Tsjqdy8iGl0KEXCRaiEdfvjBBFy
 Ll+djwnWSPVPST/MtV7kpmW615eg34RU/BITkOuZ8uRUzJRvNdG1rjraora/ZnxyJf68d4+tdhY
 A8t9/wbr
X-Authority-Analysis: v=2.4 cv=c4mrQQ9l c=1 sm=1 tr=0 ts=68a2fe5f cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=2OwXVqhp2XgA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=FHPW5qoTcErFhgV2viAA:9 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: cC6dTiQ08wInp4fLrEI0kcSLAojhZFar
X-Proofpoint-ORIG-GUID: cC6dTiQ08wInp4fLrEI0kcSLAojhZFar
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-18_04,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 priorityscore=1501 adultscore=0 impostorscore=0
 bulkscore=0 phishscore=0 malwarescore=0 suspectscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508160033

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
 include/net/mac80211.h     | 18 ++++++++++++++++++
 net/mac80211/ieee80211_i.h |  5 +++++
 net/mac80211/main.c        |  3 +++
 net/mac80211/trace.h       | 26 +++++++++++++++++++++++++
 net/mac80211/util.c        | 39 ++++++++++++++++++++++++++++++++++++++
 5 files changed, 91 insertions(+)

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
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 8afa2404eaa8..d25930f6f122 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -1675,6 +1675,8 @@ struct ieee80211_local {
 	u8 ext_capa[8];
 
 	bool wbrf_supported;
+
+	struct wiphy_work incumbent_signal_detected_work;
 };
 
 static inline struct ieee80211_sub_if_data *
@@ -2884,4 +2886,7 @@ ieee80211_determine_chan_mode(struct ieee80211_sub_if_data *sdata,
 #define VISIBLE_IF_MAC80211_KUNIT static
 #endif
 
+void ieee80211_incumbent_signal_detected_work(struct wiphy *wiphy,
+					      struct wiphy_work *work);
+
 #endif /* IEEE80211_I_H */
diff --git a/net/mac80211/main.c b/net/mac80211/main.c
index 9c8f18b258a6..1495d2a16517 100644
--- a/net/mac80211/main.c
+++ b/net/mac80211/main.c
@@ -994,6 +994,8 @@ struct ieee80211_hw *ieee80211_alloc_hw_nm(size_t priv_data_len,
 
 	wiphy_work_init(&local->radar_detected_work,
 			ieee80211_dfs_radar_detected_work);
+	wiphy_work_init(&local->incumbent_signal_detected_work,
+			ieee80211_incumbent_signal_detected_work);
 
 	wiphy_work_init(&local->reconfig_filter, ieee80211_reconfig_filter);
 
@@ -1670,6 +1672,7 @@ void ieee80211_unregister_hw(struct ieee80211_hw *hw)
 	wiphy_work_cancel(local->hw.wiphy, &local->reconfig_filter);
 	wiphy_work_cancel(local->hw.wiphy, &local->sched_scan_stopped_work);
 	wiphy_work_cancel(local->hw.wiphy, &local->radar_detected_work);
+	wiphy_work_cancel(local->hw.wiphy, &local->incumbent_signal_detected_work);
 	wiphy_unlock(local->hw.wiphy);
 	rtnl_unlock();
 
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
index 32f1bc5908c5..82e3ef4165aa 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -3533,6 +3533,32 @@ void ieee80211_dfs_cac_cancel(struct ieee80211_local *local,
 	}
 }
 
+void ieee80211_incumbent_signal_detected_work(struct wiphy *wiphy,
+					      struct wiphy_work *work)
+{
+	struct ieee80211_local *local =
+		container_of(work, struct ieee80211_local,
+			     incumbent_signal_detected_work);
+	struct ieee80211_chanctx_conf *conf;
+	struct ieee80211_chanctx *ctx;
+
+	lockdep_assert_wiphy(local->hw.wiphy);
+
+	list_for_each_entry(ctx, &local->chanctx_list, list) {
+		if (ctx->replace_state == IEEE80211_CHANCTX_REPLACES_OTHER)
+			continue;
+
+		if (!ctx->conf.incumbt_sig_intf_bmap)
+			continue;
+
+		conf = &ctx->conf;
+		cfg80211_incumbent_signal_detect_event(local->hw.wiphy,
+						       &conf->def,
+						       conf->incumbt_sig_intf_bmap,
+						       GFP_KERNEL);
+	}
+}
+
 void ieee80211_dfs_radar_detected_work(struct wiphy *wiphy,
 				       struct wiphy_work *work)
 {
@@ -3591,6 +3617,19 @@ void ieee80211_radar_detected(struct ieee80211_hw *hw,
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
+	wiphy_work_queue(hw->wiphy, &local->incumbent_signal_detected_work);
+}
+EXPORT_SYMBOL(ieee80211_incumbent_signal_detected);
+
 void ieee80211_chandef_downgrade(struct cfg80211_chan_def *c,
 				 struct ieee80211_conn_settings *conn)
 {
-- 
2.34.1


