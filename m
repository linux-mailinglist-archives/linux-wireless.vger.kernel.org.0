Return-Path: <linux-wireless+bounces-3639-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F1B3856992
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Feb 2024 17:29:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9AADB2B186
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Feb 2024 16:28:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2464213474E;
	Thu, 15 Feb 2024 16:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="mBpAKRa5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DE8C66B2D
	for <linux-wireless@vger.kernel.org>; Thu, 15 Feb 2024 16:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708014517; cv=none; b=pIKwmkW7C6AxP8C//vYeK4sE6wtizKxWdw1cOHVnGAyMsPgoE4GU0ZAF0ZT0nsPRw7EKQ2HYq22Z1NJwDsOW88xypLKnXzwmZax5nWfvxA3gRNtrQTJC1muXVgP8lHQ8k/CQJ/ZfchQQ24yEl59pZiKO+efRsIUzO3sS6aJHk6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708014517; c=relaxed/simple;
	bh=/Y18czAarCmbkiaTwNIACeEC72nikeU89t62oafydQk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Baj0Bi3rJBM8S8K//XrKMgPoA2xqv2uSsF+Ydqvf2wAMLp9P+UgD/by0I9uV75S5EggoLk3zmIysoUnP9uQX6/Dfq8lg0a9M+Zg2siJShscFxrZRaT59sSDzOOn8Rae/AGmvnAfayeU6PBlE27YVgZsfXvCsWUoBvqIn25K/wRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=mBpAKRa5; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41FDdsui001713;
	Thu, 15 Feb 2024 16:28:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=7Yjn+VmYduAApuPzrdl2EiqaX3bAskbKBBr8DoP60vM=; b=mB
	pAKRa5AoWqSN+aT7gfGn0e9gAxYDXuo7Q9vu+VLS/sXKrVZY9+Kf+Suzb834IvQs
	Nd1QFVcSh1nU9syzPs4zBfk+RQrhKruKQcXNAIrmIUsvcon0SHvyAUDDNRDzl5r7
	lB2kozsu7S0vJaczEQHPJqZ2BPju8v4Qlut2cIk/Cx0YjaUoFOXeahEjeuTv7KnD
	0np/2CQLwxzVCnqG1Aid/ilqcrjCj2zwWKMd/4S4mkIRm3DrUYsfEgNZ+VApADIZ
	KKiRvdjl6CSLdTAWiIh5oXV4sHswNb3pD1he4/jEJmcrKYex8Nq9xSjDlnLLy+vn
	ARoXtTE6wJtW8t2EsfNQ==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w9cd49gby-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 Feb 2024 16:28:31 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41FGSUVd026928
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 Feb 2024 16:28:30 GMT
Received: from cdcwlex322514-lin.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 15 Feb 2024 08:28:28 -0800
From: Aditya Kumar Singh <quic_adisi@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Aditya Kumar Singh
	<quic_adisi@quicinc.com>
Subject: [PATCH 2/2] wifi: mac80211_hwsim: add support for switch_vif_chanctx callback
Date: Thu, 15 Feb 2024 21:58:11 +0530
Message-ID: <20240215162811.506065-3-quic_adisi@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240215162811.506065-1-quic_adisi@quicinc.com>
References: <20240215162811.506065-1-quic_adisi@quicinc.com>
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
X-Proofpoint-GUID: ctV7fEKFLuzRX2W-uaSwpJ1d_csoDLSm
X-Proofpoint-ORIG-GUID: ctV7fEKFLuzRX2W-uaSwpJ1d_csoDLSm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-15_15,2024-02-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 impostorscore=0 spamscore=0 bulkscore=0 mlxlogscore=833 clxscore=1015
 malwarescore=0 mlxscore=0 adultscore=0 priorityscore=1501 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402150133

Currently switch_vif_chanctx mac80211 callback is not supported for
MLO. Add it.

Signed-off-by: Aditya Kumar Singh <quic_adisi@quicinc.com>
---
 drivers/net/wireless/virtual/mac80211_hwsim.c | 33 ++++++++++++++++++-
 1 file changed, 32 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/virtual/mac80211_hwsim.c b/drivers/net/wireless/virtual/mac80211_hwsim.c
index 2ea11a86d920..ccc321898d6f 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim.c
+++ b/drivers/net/wireless/virtual/mac80211_hwsim.c
@@ -3215,6 +3215,36 @@ static void mac80211_hwsim_unassign_vif_chanctx(struct ieee80211_hw *hw,
 	}
 }
 
+static int mac80211_hwsim_switch_vif_chanctx(struct ieee80211_hw *hw,
+					     struct ieee80211_vif_chanctx_switch *vifs,
+					     int n_vifs,
+					     enum ieee80211_chanctx_switch_mode mode)
+{
+	int i;
+
+	if (n_vifs <= 0)
+		return -EINVAL;
+
+	wiphy_dbg(hw->wiphy,
+		  "switch vif channel context mode: %u\n", mode);
+
+	for (i = 0; i < n_vifs; i++) {
+		hwsim_check_chanctx_magic(vifs[i].old_ctx);
+		wiphy_dbg(hw->wiphy,
+			  "switch vif channel context: %d MHz/width: %d/cfreqs:%d/%d MHz -> %d MHz/width: %d/cfreqs:%d/%d MHz\n",
+			  vifs[i].old_ctx->def.chan->center_freq,
+			  vifs[i].old_ctx->def.width,
+			  vifs[i].old_ctx->def.center_freq1,
+			  vifs[i].old_ctx->def.center_freq2,
+			  vifs[i].new_ctx->def.chan->center_freq,
+			  vifs[i].new_ctx->def.width,
+			  vifs[i].new_ctx->def.center_freq1,
+			  vifs[i].new_ctx->def.center_freq2);
+		hwsim_set_chanctx_magic(vifs[i].new_ctx);
+	}
+	return 0;
+}
+
 static const char mac80211_hwsim_gstrings_stats[][ETH_GSTRING_LEN] = {
 	"tx_pkts_nic",
 	"tx_bytes_nic",
@@ -3940,7 +3970,8 @@ static const struct ieee80211_ops mac80211_hwsim_ops = {
 	.remove_chanctx = mac80211_hwsim_remove_chanctx,	\
 	.change_chanctx = mac80211_hwsim_change_chanctx,	\
 	.assign_vif_chanctx = mac80211_hwsim_assign_vif_chanctx,\
-	.unassign_vif_chanctx = mac80211_hwsim_unassign_vif_chanctx,
+	.unassign_vif_chanctx = mac80211_hwsim_unassign_vif_chanctx, \
+	.switch_vif_chanctx = mac80211_hwsim_switch_vif_chanctx,
 
 static const struct ieee80211_ops mac80211_hwsim_mchan_ops = {
 	HWSIM_COMMON_OPS
-- 
2.25.1


