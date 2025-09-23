Return-Path: <linux-wireless+bounces-27600-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AF71B94CBF
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Sep 2025 09:36:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFFB118A0784
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Sep 2025 07:37:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7250314D36;
	Tue, 23 Sep 2025 07:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="PYp2ilu1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEB0E3161B3
	for <linux-wireless@vger.kernel.org>; Tue, 23 Sep 2025 07:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758612988; cv=none; b=XcZNWHPCZDiRN2QRMKEpqyQ4gfaLPlOnenGw/fyP8JVOiCWN7P9URn0UQA8V1/4nSwmf+3Um4IHWmbtgRbsnQ2KsLI8r7u3ojSIUoRXH83MmIu99J86KNkHtE1a/n9f7ACCZldXkwrulOdpmlYVvNibLIAKMvK7nsbWAjHXU16s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758612988; c=relaxed/simple;
	bh=DuqeXvU4ZHavEX/SZ6ltBqO1c4736WjVGUm0QJ9CwCY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ql0u5yT0FYRRc1l07OyiXRr0zMsz+tp1dVWyzkOX04ywIEp1IWnQGm29ovaC+1If+CxzoPaNHcOEmfqE1bPvYVatYdmrN0Y572n94FeqwgPHG5/KONIF0yumqBrBNaBFcOvQMfl12JhX4LuEde9LzIv2YSK6uke5HP8JIiW+jF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=PYp2ilu1; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58N6ZjvR030086;
	Tue, 23 Sep 2025 07:36:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	vJcAcQal1/cPOcBUIy233N36c0Me9yZgWBCtoAQD3Sg=; b=PYp2ilu1NKzBsGGF
	/ZnkBXafJYusxasduCyJgWQFkpt+AQMvIdZbQxal7Me92EJlPOIIz2aS8J2aiOrX
	BWUPeq2IPByUMtgPcoruHXP7qrpqJXox+0+uujxUgqdLLlGjELfaRulyqfPgoEft
	r4b2KZEqY1x1kw4pjUAySYBuMybs/AWQ0NhNDVTp8TFsDOQU5VLfIhpryYv4zR3G
	2a5AsgMapZ7j5eiD9IQ8TFQPd1M4y2n4rrpDSRNj+VbrGDog8CbK8BNU27+HUODd
	YeezoOesLIlkhi+ozNIqz9eDG0G3XuvXOk9NuLPwM+gZQmgDXrBfAkPe9/4Tonlt
	gj+I9A==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499k98fmp1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Sep 2025 07:36:22 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 58N7aLcT007040
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Sep 2025 07:36:21 GMT
Received: from hu-amitajit-blr.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.24; Tue, 23 Sep 2025 00:36:19 -0700
From: Amith A <quic_amitajit@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>, <quic_amitajit@quicinc.com>,
        "Aditya
 Kumar Singh" <aditya.kumar.singh@oss.qualcomm.com>
Subject: [PATCH wireless-next v3 3/3] wifi: mac80211_hwsim: add incumbent signal interference detection support
Date: Tue, 23 Sep 2025 13:05:54 +0530
Message-ID: <20250923073554.3438429-4-quic_amitajit@quicinc.com>
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
X-Proofpoint-GUID: AFP6X2hZcpWjdXjCjIR4FlhGB83om5Wu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAxOCBTYWx0ZWRfX3MFyreLg/wmv
 hD1ovDc5l7b7DEBRWDk2llof/hGzCeXwHafGP6pQYAGkWdJPfthQdSS91k7Xuy+3oZvcpWEbhcc
 I3+iI9bbN+cGijEFaa78xGONOMBGddttktUBzfpnJ5ItlESMg8iBdtQXj+YLFSh46AiX6B9tTI3
 phbtVZ+gY/KKgDFBG3Bb1jWuu60L7axWmZgOjn+DrcIebN7XexiAPjLYA3a2/2Az24iPW3VO6Z8
 Bkn7RuXUKhKWAQpDMXbkQuZRcHR3A0QnBGr2mHeUKiUl2L/NQ41elz6t80qklNNJDPhqsKbek8b
 6cE91V3j3gSF5GOeaaDDTfwUWVmierddRCd1wWam04Qe4hojPW1MQH6ZxsZ1wROHDWYvr/c+aDR
 ZDhe+9EE
X-Proofpoint-ORIG-GUID: AFP6X2hZcpWjdXjCjIR4FlhGB83om5Wu
X-Authority-Analysis: v=2.4 cv=Dp1W+H/+ c=1 sm=1 tr=0 ts=68d24df6 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8
 a=tY_mIoszEBng5VlgR_sA:9 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-23_01,2025-09-22_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 adultscore=0 bulkscore=0 impostorscore=0
 phishscore=0 spamscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200018

From: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>

Add a debugfs 'simulate_incumbent_signal_interference' which calls the
function ieee80211_incumbent_signal_detected() and starts the incumbent
signal detection.

Signed-off-by: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
Signed-off-by: Amith A <quic_amitajit@quicinc.com>
---
 drivers/net/wireless/virtual/mac80211_hwsim.c | 33 +++++++++++++++++++
 drivers/net/wireless/virtual/mac80211_hwsim.h |  4 +++
 2 files changed, 37 insertions(+)

diff --git a/drivers/net/wireless/virtual/mac80211_hwsim.c b/drivers/net/wireless/virtual/mac80211_hwsim.c
index 3789d46d5614..a311ba6b3e4f 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim.c
+++ b/drivers/net/wireless/virtual/mac80211_hwsim.c
@@ -1154,6 +1154,36 @@ static int hwsim_write_simulate_radar(void *dat, u64 val)
 DEFINE_DEBUGFS_ATTRIBUTE(hwsim_simulate_radar, NULL,
 			 hwsim_write_simulate_radar, "%llu\n");
 
+static void hwsim_6ghz_chanctx_iter(struct ieee80211_hw *hw,
+				    struct ieee80211_chanctx_conf *conf,
+				    void *data)
+{
+	struct hwsim_get_any_chanctx_conf_arg *arg = data;
+
+	if (conf->def.chan && conf->def.chan->band == NL80211_BAND_6GHZ)
+		arg->chanctx_conf = conf;
+}
+
+static int hwsim_write_simulate_incumbent_signal(void *dat, u64 val)
+{
+	struct mac80211_hwsim_data *data = dat;
+	struct hwsim_get_any_chanctx_conf_arg arg = { .chanctx_conf = NULL };
+
+	ieee80211_iter_chan_contexts_atomic(data->hw,
+					    hwsim_6ghz_chanctx_iter,
+					    &arg);
+
+	if (!arg.chanctx_conf)
+		return -EINVAL;
+
+	ieee80211_incumbent_signal_detected(data->hw, arg.chanctx_conf, (u32)val);
+
+	return 0;
+}
+
+DEFINE_DEBUGFS_ATTRIBUTE(hwsim_simulate_incumbent_signal, NULL,
+			 hwsim_write_simulate_incumbent_signal, "%llu\n");
+
 static int hwsim_fops_group_read(void *dat, u64 *val)
 {
 	struct mac80211_hwsim_data *data = dat;
@@ -5590,6 +5620,9 @@ static int mac80211_hwsim_new_radio(struct genl_info *info,
 		debugfs_create_file("dfs_simulate_radar", 0222,
 				    data->debugfs,
 				    data, &hwsim_simulate_radar);
+	debugfs_create_file("simulate_incumbent_signal_interference", 0200,
+			    data->debugfs,
+			    data, &hwsim_simulate_incumbent_signal);
 
 	if (param->pmsr_capa) {
 		data->pmsr_capa = *param->pmsr_capa;
diff --git a/drivers/net/wireless/virtual/mac80211_hwsim.h b/drivers/net/wireless/virtual/mac80211_hwsim.h
index fa157c883f7f..4dc48cf33ec4 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim.h
+++ b/drivers/net/wireless/virtual/mac80211_hwsim.h
@@ -341,4 +341,8 @@ enum hwsim_rate_info_attributes {
 	HWSIM_RATE_INFO_ATTR_MAX = NUM_HWSIM_RATE_INFO_ATTRS - 1
 };
 
+struct hwsim_get_any_chanctx_conf_arg {
+	struct ieee80211_chanctx_conf *chanctx_conf;
+};
+
 #endif /* __MAC80211_HWSIM_H */
-- 
2.34.1


