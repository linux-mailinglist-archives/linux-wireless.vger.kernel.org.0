Return-Path: <linux-wireless+bounces-26434-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D5B6CB29EF1
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Aug 2025 12:21:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20372189651A
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Aug 2025 10:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53D8F221DAD;
	Mon, 18 Aug 2025 10:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="jy0g3HQx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE4F1315786
	for <linux-wireless@vger.kernel.org>; Mon, 18 Aug 2025 10:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755512425; cv=none; b=NOVo8NQnO1yzsdTGGujIrJaWFEQDg6/cKiqprHFrMFmheWAkNRqqaGykPfVWO10p4VcLa+qb7v1b8BfoyHKy5la68UG67d0NJPKXdhASgC2qVNMRY6Ibkf+so5vhQOBOejrXhaejOpEOyrXX+mB4nhPNMeCYKT6/qxs/KUOaURQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755512425; c=relaxed/simple;
	bh=DuqeXvU4ZHavEX/SZ6ltBqO1c4736WjVGUm0QJ9CwCY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tmav4dZ1w3LNVtx+hQpAZqDUaAmxijqGUaLXslRZ9fPgHjDTRX/9RH8F1gohFvoqzcXOJiF0254P11MdpBXoplqyjrc/9+TbKvZ9ybtGRCNSdSIDZNjlnzbtlpJnAuF62at0PmvWXK9TGUz8MjiAOfX1FHqKxGiuQnq1tx46jNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=jy0g3HQx; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57I8gF8e018574;
	Mon, 18 Aug 2025 10:20:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	vJcAcQal1/cPOcBUIy233N36c0Me9yZgWBCtoAQD3Sg=; b=jy0g3HQxukqZbFsr
	sSdFvySy0mVvV2B9P10DUjkkkTukxWHSTZGh8rq6f6gCOeF+Uc+vckdJL65SZyDo
	B5N8cVxyv7u4u60k2gGpHpsMAGEk0uR6IFMoX9KpEGOvxRB5bUeP79syra5QmEPq
	uMMO9M/SlV+YVDbKuUoQq2+gQ6LvyDdnSeWIEFFHAikRP2YgyHXv7CmAFsnej2OB
	0DnXZ09z9jg1K/VDDnvwpfxrBRpsjVUB99N24f9ahx+xlFYmW2qT8rrI/IfM6DFv
	iPIP371v67atf5duJaL2buBg/WLGAy/So2mjzPb2ZEYjafUIwFyNsEUdQjUIRKx+
	HqnaCw==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48jhagv9ds-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Aug 2025 10:20:18 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 57IAKBQH007142
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Aug 2025 10:20:11 GMT
Received: from hu-amitajit-blr.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 18 Aug 2025 03:20:09 -0700
From: Amith A <quic_amitajit@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>, <quic_amitajit@quicinc.com>,
        "Aditya
 Kumar Singh" <aditya.kumar.singh@oss.qualcomm.com>
Subject: [PATCH wireless-next 3/3] wifi: mac80211_hwsim: add incumbent signal interference detection support
Date: Mon, 18 Aug 2025 15:49:47 +0530
Message-ID: <20250818101947.2464612-4-quic_amitajit@quicinc.com>
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
X-Authority-Analysis: v=2.4 cv=D9xHKuRj c=1 sm=1 tr=0 ts=68a2fe62 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8
 a=tY_mIoszEBng5VlgR_sA:9 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: iEvbApyhe20NrcdMyaxD8MTFuwlJBm1j
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE2MDAyNCBTYWx0ZWRfX+1J7GXA3/yXQ
 7pa5J77rX9+n8cRaQib0qv39DZCplR1zvB9xhOuE1HOpHYXPNTQW8LB7v0iFcrxBuaeo7COD4NH
 E+wh5iu08wh3NVfb78fl2p/iFTcL2EB9IFkpMnNUJ/sWKWV59rM4rx2ISJpvlzXDjG40aXg6crU
 f2jsl3de5mpyVJFu8tUqI7epZrQus6f04dj13hTkveBaCt/OdZ+8AxCuY5cUXmKyQ3V8sgmeSen
 ASBBwiTwyMe4C4yQ+HeM5Psn5VzSBwwrPcEmOQH9Mu7mVGmVVRC44bzYBJQK+JBQqmwyObvor7T
 5iuWREMcy4E+LlAjU4oi5sie5JjV9x2JtM2VcqYfNqDrxfogCDfItcUFndpQtaDLBKOvAKvIvyU
 lW6qfMQd
X-Proofpoint-GUID: iEvbApyhe20NrcdMyaxD8MTFuwlJBm1j
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-18_04,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 phishscore=0 impostorscore=0 bulkscore=0
 priorityscore=1501 spamscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508160024

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


