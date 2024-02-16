Return-Path: <linux-wireless+bounces-3678-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 974F7857F77
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Feb 2024 15:39:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37BF128A2DC
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Feb 2024 14:39:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF58912EBC4;
	Fri, 16 Feb 2024 14:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="AlX+SmLm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BC6612EBE3
	for <linux-wireless@vger.kernel.org>; Fri, 16 Feb 2024 14:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708094385; cv=none; b=jNeTBJhClm0COthKsGDSGCt3zMqyhHXkwlDDklPe0NkrDtJWW9sNPJKpP+1aAtSC3Ow4nOBZkplwXmkOCoe3Wq/NtXopba2tEzlQiZBXzqTIAHcXpazvrdKgPdBrJmyvv7MC4OFTk65b4gByLtW6vj98WAUGD6Wbtefw7l08hcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708094385; c=relaxed/simple;
	bh=/Y18czAarCmbkiaTwNIACeEC72nikeU89t62oafydQk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KIL1QssVjjxNVLfc8UUixS2R/6CWJLCwoUW+gdoXY28teU6hgzv9F4bRoPBrVNwXcvlg6hLQhY+L/vRtjpHIAwn/vPMl8Dne0n8oR90nRcR4BFqvLXrz97CKJOMzJafLzGyAgfKIqqVwceV/SaEz78xV5dIFvgaggKYQEJ9eZ6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=AlX+SmLm; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41GDs9rF009776;
	Fri, 16 Feb 2024 14:39:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=7Yjn+VmYduAApuPzrdl2EiqaX3bAskbKBBr8DoP60vM=; b=Al
	X+SmLmwXSLrTRglN782E6A//vrE5Z0t6ud7HqqCThdMfvChwGF8ln7UPzxYbQk5N
	IQ4TaoEHwt1uLBm7ju2d2lnrZLfyLv0kBzF0bXZSwEhCEaZNmdd8upGkNAnS4RLH
	4p0xUiVCvLNVWSxLK6H0rRR/EbY1iQQELAyHZ5zrucB/EDLcpQgXwNa69PorOUTd
	GXun7faPUsYmMapsdh9DtrT0V2OA4JLOdqJKAn1KU3s+qA8ITi78FkVPoluEDvu7
	I7hXAkzm21gHJ+M8+L4eYBmgW4+NR3GnVq5fD+z8z0Scrv8YT9co0U4HLeZA4Tev
	7vo5Oves61y7u623+Dhw==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wa3bh0rw6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Feb 2024 14:39:39 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41GEdcwr023937
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Feb 2024 14:39:38 GMT
Received: from cdcwlex322514-lin.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 16 Feb 2024 06:39:37 -0800
From: Aditya Kumar Singh <quic_adisi@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Aditya Kumar Singh
	<quic_adisi@quicinc.com>
Subject: [PATCH v2 2/2] wifi: mac80211_hwsim: add support for switch_vif_chanctx callback
Date: Fri, 16 Feb 2024 20:09:18 +0530
Message-ID: <20240216143918.514140-3-quic_adisi@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240216143918.514140-1-quic_adisi@quicinc.com>
References: <20240216143918.514140-1-quic_adisi@quicinc.com>
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
X-Proofpoint-GUID: dZm727TwLiAZE_ts3t40yU9xmSVZ84su
X-Proofpoint-ORIG-GUID: dZm727TwLiAZE_ts3t40yU9xmSVZ84su
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-16_13,2024-02-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 impostorscore=0
 mlxscore=0 bulkscore=0 clxscore=1015 adultscore=0 priorityscore=1501
 malwarescore=0 mlxlogscore=920 phishscore=0 lowpriorityscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402160117

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


