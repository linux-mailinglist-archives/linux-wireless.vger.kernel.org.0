Return-Path: <linux-wireless+bounces-27254-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E76BB540D2
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Sep 2025 05:21:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C9F816FB2F
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Sep 2025 03:21:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE4B9136351;
	Fri, 12 Sep 2025 03:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="gDyt1pU8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF57B22D4F1
	for <linux-wireless@vger.kernel.org>; Fri, 12 Sep 2025 03:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757647296; cv=none; b=qteZqo0F58r+EVDxwrLCrDLtoMIQRLdWQ1BhpWqdjGbaa6e/Ata5geUo4YBzW1SKepni/C97OY2YLYbT1SLHHOJbQT3XWieOKFagoywUEu/QDRrd4v3oeLYNV/Da0YjyhITXlvevfmBFL4uuK3Wa5UvoCs72F3xCZXibw65tSiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757647296; c=relaxed/simple;
	bh=78G58ZzGsdGZ0mXUVSyu6B5P0JMSFn9xCCm+iv6vUPQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NM2rw1+3Ax5goPR43kn9oirobp+nePZqWyKeiU8v8cWdIXc7iTFcJ/uOMAz/dxVvBH2Gon2DXyyCEeOD3+seB9WP3+try7u7s2H0sESoBQsxeU1NjYiIhOJd/Q3O121SIKk5UTEcFxo2YWO9w6HZHGJ789fIAjTtkVLf75471k8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=gDyt1pU8; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58BJpjNT002355;
	Fri, 12 Sep 2025 03:21:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	dy0raelbG4C6Ba5mp2G3DdvF402zF7Ze57zpzt+uwD0=; b=gDyt1pU8TO3oe00w
	RhmhKVbx3n5EiER9fdJ8CKiTE57mow0SyfJSMQNsjP0BlfTYhJwJ2oM6PnZu6Uvd
	2+M/SO7w5W33uNQqUhmalPqqeo9yfG2kHLZKlRtgsYFr5f35QmZ9CJG8YoFiNdlz
	MGiKeJKFRYR5KWAlhNBXHnLGn/GV2IUFMF7+U+oJ0fotnT4bTyN9gPBvw6XUqrun
	OqHmnvjGlCKKQpvg6IaiojsjejEI/moWeCg8kuAdnI0xDTXDKxVs+zNhhgurVIGg
	e7rw4ZZqF8pkaSKAxNaDda/pFXk48i3FcdHkBzDdnY//vKWUtvJ2qQpK9JUd4mSS
	d29Slg==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490db8t420-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Sep 2025 03:21:30 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 58C3LTBD006136
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Sep 2025 03:21:29 GMT
Received: from hu-amitajit-blr.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.24; Thu, 11 Sep 2025 20:21:27 -0700
From: Amith A <quic_amitajit@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>, <quic_amitajit@quicinc.com>,
        "Hari
 Chandrakanthan" <quic_haric@quicinc.com>,
        Aditya Kumar Singh
	<aditya.kumar.singh@oss.qualcomm.com>
Subject: [PATCH wireless-next v2 2/3] wifi: mac80211: add support to handle incumbent signal detected event from driver
Date: Fri, 12 Sep 2025 08:51:04 +0530
Message-ID: <20250912032105.714949-3-quic_amitajit@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250912032105.714949-1-quic_amitajit@quicinc.com>
References: <20250912032105.714949-1-quic_amitajit@quicinc.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAzMSBTYWx0ZWRfX0hGDHSnvPpFK
 0eH+rl0L+qRiT4AgvqIcVgwBZCDi2QSE68SwYaGumtqFrEO8dsLc7hK4Zn+5/D5ki2FpD3mOtXW
 l/RYFH/9mGPqFTADMVmFtFTEAPgtE9fUEJZPCYiwPYxu7uLH9f8bSequjHPDGIm2UsO8plqt1yR
 y9OAMnHx+G2rjXF79V5I1Wy48FfuLu/gdg2Hz2FHr3bgSpncEb1X7acG2wWjCCU0JGK0fsZ+T8t
 LKGWaTPsPJlIm/BwHWvsvCgNoXCfySRxJJsBNkAP72xGMSBD/xb3MQxLvtaUlBvfivvGTp9QncK
 6vFvMGl20V4D5G6c5RQ2x/Kv9opS783vu5XRJuzEgMZtjrK1M1/qK/kIFc5m17JMcmkp1iM8G0a
 9FjpeQhf
X-Proofpoint-ORIG-GUID: emKwMLvykQ8QfohlWW6A9rCckChT39Ax
X-Proofpoint-GUID: emKwMLvykQ8QfohlWW6A9rCckChT39Ax
X-Authority-Analysis: v=2.4 cv=VIDdn8PX c=1 sm=1 tr=0 ts=68c391ba cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=3BgXE5mZoGmYsdH7UdcA:9 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-12_01,2025-09-11_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0
 phishscore=0 adultscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060031

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
index 07f5fb11569b..6f389c4adf9b 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -1683,6 +1683,8 @@ struct ieee80211_local {
 	u8 ext_capa[8];
 
 	bool wbrf_supported;
+
+	struct wiphy_work incumbent_signal_detected_work;
 };
 
 static inline struct ieee80211_sub_if_data *
@@ -2892,4 +2894,7 @@ ieee80211_determine_chan_mode(struct ieee80211_sub_if_data *sdata,
 #define VISIBLE_IF_MAC80211_KUNIT static
 #endif
 
+void ieee80211_incumbent_signal_detected_work(struct wiphy *wiphy,
+					      struct wiphy_work *work);
+
 #endif /* IEEE80211_I_H */
diff --git a/net/mac80211/main.c b/net/mac80211/main.c
index e8c85aa77c56..0c40183a33f7 100644
--- a/net/mac80211/main.c
+++ b/net/mac80211/main.c
@@ -1002,6 +1002,8 @@ struct ieee80211_hw *ieee80211_alloc_hw_nm(size_t priv_data_len,
 
 	wiphy_work_init(&local->radar_detected_work,
 			ieee80211_dfs_radar_detected_work);
+	wiphy_work_init(&local->incumbent_signal_detected_work,
+			ieee80211_incumbent_signal_detected_work);
 
 	wiphy_work_init(&local->reconfig_filter, ieee80211_reconfig_filter);
 
@@ -1675,6 +1677,7 @@ void ieee80211_unregister_hw(struct ieee80211_hw *hw)
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
index 9eb35e3b9e52..dc43f2e0f2af 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -3534,6 +3534,32 @@ void ieee80211_dfs_cac_cancel(struct ieee80211_local *local,
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
@@ -3592,6 +3618,19 @@ void ieee80211_radar_detected(struct ieee80211_hw *hw,
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


