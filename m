Return-Path: <linux-wireless+bounces-3682-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B844F857FB2
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Feb 2024 15:47:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA6091C21247
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Feb 2024 14:47:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59A9512F363;
	Fri, 16 Feb 2024 14:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="FIDtkgEX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A50A612F37F
	for <linux-wireless@vger.kernel.org>; Fri, 16 Feb 2024 14:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708094808; cv=none; b=ZzAqc7GyuSxDS2qDY8KGjxHxKBVsvo0H1d51ubXQHBSawJK1QIgf9mg9nVYjxmO46VU1HlwZ83IIq2I37jDHhzTJySCnU/pckP5RziswKBgXe7mMZpAAhPVv75YPwDNgZEM1dFPbJwYigYgtBebo6otIBVvIMozG0fgCr4vjxQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708094808; c=relaxed/simple;
	bh=70buGIs29aOkh4lo9yTt3B5CkNFDdWgovq+rsO99VfQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=euxz8O5AyrTw6K28lr+ezoZoHkX9X/0Fl796KRMZYNeCxKTjjkP6nEQ4BZ6G1MuHAXWLU+LK9OvnZK9VnXNjTAP62J1et/XoFKvJ4dL+d5LHGjtyS1/wgbQ4+KqIVfHRi+iBCApr6SO40uPBV9wxCoWTMbnPLZnKZqnQQW1j73E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=FIDtkgEX; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41GD3VJf002219;
	Fri, 16 Feb 2024 14:46:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=g+JnUvx4Rvi3y6/LqyNrnqa9TgH0TXtP83+wP2Rsl+0=; b=FI
	DtkgEXSOv7v7R9SqUR/0iuSbY8EJIfZCyEEpB4mjH/mjYAHcdbm05Qa7MVhkzLCo
	UPUTLGtiHkXd6vG433sciH2uaHF349PNbVRhO0XtEVtmM7c3auCxM9jkXZgS9ana
	Eqk2kT8G6Y8Jbt0mwKiiD61juEfAFhHU42OEe7Ma4gl1VCaGp0VDu2P0Xj+5Ea98
	6hbOuQN7p1aCe+/r2r7fgVPeyqXyKhhinUNB9AF2CrN5VbL22eDBY+HdYL2bt/4/
	tzY3Zp40x607EiPVRaL59foV0y6XInelhdQoaXqqhodcW80NMYEcvvo4MpXUSqL6
	l/THHDlF81xxBMPlqdcQ==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w9fkfbtaf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Feb 2024 14:46:42 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41GEkfqn026890
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Feb 2024 14:46:41 GMT
Received: from cdcwlex322514-lin.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 16 Feb 2024 06:46:40 -0800
From: Aditya Kumar Singh <quic_adisi@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Aditya Kumar Singh
	<quic_adisi@quicinc.com>
Subject: [PATCH v3 2/2] wifi: mac80211_hwsim: add support for switch_vif_chanctx callback
Date: Fri, 16 Feb 2024 20:16:21 +0530
Message-ID: <20240216144621.514385-3-quic_adisi@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240216144621.514385-1-quic_adisi@quicinc.com>
References: <20240216144621.514385-1-quic_adisi@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: R-28YA4DfUSc9hul66TqgdeUv9wh7XQY
X-Proofpoint-GUID: R-28YA4DfUSc9hul66TqgdeUv9wh7XQY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-16_13,2024-02-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 adultscore=0 lowpriorityscore=0 impostorscore=0 mlxlogscore=855
 spamscore=0 bulkscore=0 suspectscore=0 mlxscore=0 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402160118

Currently switch_vif_chanctx mac80211 callback is not supported for
MLO. Add it.

Signed-off-by: Aditya Kumar Singh <quic_adisi@quicinc.com>
---
 drivers/net/wireless/virtual/mac80211_hwsim.c | 44 ++++++++++++++++++-
 1 file changed, 43 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/virtual/mac80211_hwsim.c b/drivers/net/wireless/virtual/mac80211_hwsim.c
index 2ea11a86d920..b55fe320633c 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim.c
+++ b/drivers/net/wireless/virtual/mac80211_hwsim.c
@@ -3215,6 +3215,47 @@ static void mac80211_hwsim_unassign_vif_chanctx(struct ieee80211_hw *hw,
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
+
+		switch (mode) {
+		case CHANCTX_SWMODE_REASSIGN_VIF:
+			hwsim_check_chanctx_magic(vifs[i].new_ctx);
+			break;
+		case CHANCTX_SWMODE_SWAP_CONTEXTS:
+			hwsim_set_chanctx_magic(vifs[i].new_ctx);
+			hwsim_clear_chanctx_magic(vifs[i].old_ctx);
+			break;
+		default:
+			WARN_ON("Invalid mode");
+		}
+	}
+	return 0;
+}
+
 static const char mac80211_hwsim_gstrings_stats[][ETH_GSTRING_LEN] = {
 	"tx_pkts_nic",
 	"tx_bytes_nic",
@@ -3940,7 +3981,8 @@ static const struct ieee80211_ops mac80211_hwsim_ops = {
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


