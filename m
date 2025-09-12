Return-Path: <linux-wireless+bounces-27255-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F20DB540D3
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Sep 2025 05:21:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E997A4E1787
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Sep 2025 03:21:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D70022D4F1;
	Fri, 12 Sep 2025 03:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="W2nohIFp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AE462DC763
	for <linux-wireless@vger.kernel.org>; Fri, 12 Sep 2025 03:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757647298; cv=none; b=cwEfpU4VmmI9gyRd15GICJFWcaqf7GbwpBVK7ZgfFRdnDEikRrj0/ChErx969NZ+sogje0gOf1PSZM0khmLlBIUmghlYU7UfKrKLiVpI5jdBRK8RyTbWsOrLUs01y6COdMOLxJ21nU1ktPBOq/nLeLAnnL6tIVCYOag0QYUH2Qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757647298; c=relaxed/simple;
	bh=DuqeXvU4ZHavEX/SZ6ltBqO1c4736WjVGUm0QJ9CwCY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gjzTcfd0LXpdGFoJe/PkYJrctOsK4OAmhWn+L3BDMnIa/2HyJGgz/R1fg6wXZ9I/yAsVu7GI6N/LD+dNY3/VpsjmKujdZ/iIS+MX/ungGzpkVm/PrzC9ZRsc2DWboMYk2DrY32x8pNS8nODlTqKUuCSgrweYX+PhAGPD8Wpau6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=W2nohIFp; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58BMDsZv019591;
	Fri, 12 Sep 2025 03:21:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	vJcAcQal1/cPOcBUIy233N36c0Me9yZgWBCtoAQD3Sg=; b=W2nohIFpu3RtrO9i
	mNIa/xiX4BchV1mSH4v5qtd32lvxCPfxz1/eHEwfVeMZ1rSYLAJCaPdchabbbmaf
	rHG9ACf6b495v7Dk+PUKZ32nfvvMc3a8GI0GLT7zpEBBatShdsmaRLfFtaMVqluY
	suYghpL+DrcCvOp5p63nSTlfGCfazYnjEllqGe8VkM2CNkaD8jPBkbI2cb/Yq6d9
	5Pw4v/yCpuynVY6YtCRs4/rcBIiCKXy61W2yv67oZFjUWmXg3F+Hc48ui/AE4skq
	FkCg2neYkKpuoijQlK7/gSmrFHcXYoozp9FgnBxfP7fWeejgpjz2aPAX0wWqZUfM
	x2YK1A==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 493qphuryc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Sep 2025 03:21:32 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 58C3LVa5028329
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Sep 2025 03:21:31 GMT
Received: from hu-amitajit-blr.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.24; Thu, 11 Sep 2025 20:21:29 -0700
From: Amith A <quic_amitajit@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>, <quic_amitajit@quicinc.com>,
        "Aditya
 Kumar Singh" <aditya.kumar.singh@oss.qualcomm.com>
Subject: [PATCH wireless-next v2 3/3] wifi: mac80211_hwsim: add incumbent signal interference detection support
Date: Fri, 12 Sep 2025 08:51:05 +0530
Message-ID: <20250912032105.714949-4-quic_amitajit@quicinc.com>
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
X-Authority-Analysis: v=2.4 cv=aPDwqa9m c=1 sm=1 tr=0 ts=68c391bc cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8
 a=tY_mIoszEBng5VlgR_sA:9 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: ATyWc2_qawYDVNg7EkiA79An2_3Ux5M2
X-Proofpoint-ORIG-GUID: ATyWc2_qawYDVNg7EkiA79An2_3Ux5M2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTExMDA0MCBTYWx0ZWRfXwVtUJIfAjyd5
 Ic2pyskvRuisMJ/BDNVQtgVbXj08Rs8P1MECGkKyBG9I5ASt57ety7cxhOHWqJOH8fZYCcD6+/J
 UvLARYfpvqS/aaolAbz7fdVa1ctn9KDUKJ7+r3198rSqyjmt9ky0PHpC4HtFcfO59Ir/ku0FNMW
 Dj8ns+KZm3XfqsTei9X+6E8rsDmVKbgKHbONWm7lHhMuQi1gk7R2bYG5O5SWqRxYmQagHfSCd6X
 m3fIoM9/PgBAlbedgRy8PN9rf6zdoZf/O3l9N6yPS29Tid3/LwnRFU9B2PqJK6htXHTVl1yjegF
 tiNDaAyzhHAorJj7qA8CeegcznVrMGtMwOpGrEL8oU5jPK/x5pGg357VxF/nDMWvS7KE6Cdgxks
 +StVb1gB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-12_01,2025-09-11_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 impostorscore=0 malwarescore=0 bulkscore=0
 clxscore=1015 spamscore=0 suspectscore=0 adultscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509110040

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


