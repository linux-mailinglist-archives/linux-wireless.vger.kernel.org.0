Return-Path: <linux-wireless+bounces-5433-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D756288F8B5
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Mar 2024 08:30:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 074E41C296D5
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Mar 2024 07:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02E2E50A93;
	Thu, 28 Mar 2024 07:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="mBe9qt4t"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A0C2561F
	for <linux-wireless@vger.kernel.org>; Thu, 28 Mar 2024 07:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711611005; cv=none; b=M/X7M/e8khoMDTgMQ81iBTQ3oyW4r60hhJvd/rbm2/gAeXcIaeLPzzY1HGg08hmicrqDum7N7fQd8AX5nBNZFXD4iYEp4qC/WB5q/GuiqDflOphOMVEOSauN+Pp8M+EPnXv7N2nhIG4WYKTnkjqLyvEfsIa/GF1nFwW2sybQK2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711611005; c=relaxed/simple;
	bh=98V+gNE2ku1GYZJ+TfuXi6ZGJRzuUymnDi5gHlAKa9Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RAvRtvvFaaZs1k4OxTD9W5+XNM10YCZ8GSPDCwx9OmsIii4IKJWiXYEEtNxfY2QST+sKlmyyQ+oCdGY4F4G6bxxyD1onWxIrNC7w3hP1T55yy6nOf14/1O6FQMpHk3YN1UD4BsBgi5wQz9tnqrPcQfhfRwA1T28w0B+u0vWniXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=mBe9qt4t; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42S6iX8A017470;
	Thu, 28 Mar 2024 07:29:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=RWPAWZS5q6QijauSiOmT/R9lEekKzDrnSghigim3D8w=; b=mB
	e9qt4tlHfgeDeESll4ymYKG/8m404H0hmHYMrcXvXSw3DRMQZNc7GJWNpY/nZaz4
	rtopVJ9KAlSAtlO7Nuter/UbvJej+JLOWYfL8+0Me0UZlLAeFaNmW6Gzskfj/mRg
	pje1B7dm3TZ9WVu4yrLdoB4UOReMaca6o3TyCmzE50fj34rqfJgCMejz4kFFoalb
	WLntqe48UsF5vhVukpgeXIOFfN9WOTkTJksVv7YM4zt/C1T0/MYLLqS1pAB+Qx6E
	8OxftLBHyZRwXS2d4s9iYrF7hwG60M6Z/LorWCnf3rkm5bUvLlRjPyFDCq5Z8iIG
	Fa1NT+GkNDFhc4fuDX9Q==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x4u1wjb83-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Mar 2024 07:29:58 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42S7TvKK001172
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Mar 2024 07:29:57 GMT
Received: from hu-periyasa-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 28 Mar 2024 00:29:55 -0700
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
To: <ath12k@lists.infradead.org>, <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Vasanthakumar Thiagarajan
	<quic_vthiagar@quicinc.com>,
        Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>
Subject: [PATCH 06/13] wifi: nl80211: send iface combination to user space in multi-hardware wiphy
Date: Thu, 28 Mar 2024 12:59:09 +0530
Message-ID: <20240328072916.1164195-7-quic_periyasa@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240328072916.1164195-1-quic_periyasa@quicinc.com>
References: <20240328072916.1164195-1-quic_periyasa@quicinc.com>
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
X-Proofpoint-GUID: bGI7j-f7Ma6VzT_rySZUtLpTIQR0sOGS
X-Proofpoint-ORIG-GUID: bGI7j-f7Ma6VzT_rySZUtLpTIQR0sOGS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-28_06,2024-03-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 suspectscore=0 adultscore=0 mlxlogscore=864 spamscore=0 impostorscore=0
 malwarescore=0 phishscore=0 clxscore=1015 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403210001 definitions=main-2403280048

From: Vasanthakumar Thiagarajan <quic_vthiagar@quicinc.com>

As originally discussed in the RFC [1], add a new nested attribute to the
existing NL80211_CMD_NEW_WIPHY command. This attribute should advertise the
iface combination capability for each underlying physical hardware device.
This is necessary when the driver groups more than one physical hardware
under single wiphy.

[1]: https://lore.kernel.org/linux-wireless/20220920100518.19705-5-quic_vthiagar@quicinc.com/

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.1.1-00188-QCAHKSWPL_SILICONZ-1

Signed-off-by: Vasanthakumar Thiagarajan <quic_vthiagar@quicinc.com>
Co-developed-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
---
 include/uapi/linux/nl80211.h | 50 ++++++++++++++++++++++++++++++-
 net/wireless/nl80211.c       | 58 ++++++++++++++++++++++++++++++++++++
 2 files changed, 107 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index c53c9f941663..aa0988be1f2a 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -6004,6 +6004,10 @@ enum nl80211_iface_limit_attrs {
  * @NL80211_IFACE_COMB_BI_MIN_GCD: u32 attribute specifying the minimum GCD of
  *	different beacon intervals supported by all the interface combinations
  *	in this group (if not present, all beacon intervals be identical).
+ * @NL80211_IFACE_COMB_PER_HW_COMB: nested attribute specifying the interface
+ *	combination for each underlying hardware when multiple hardware are
+ *	registered under one wiphy,
+ *	see &enum nl80211_if_comb_per_hw_comb_attrs.
  * @NUM_NL80211_IFACE_COMB: number of attributes
  * @MAX_NL80211_IFACE_COMB: highest attribute number
  *
@@ -6020,7 +6024,19 @@ enum nl80211_iface_limit_attrs {
  *	numbers = [ #{STA} <= 1, #{P2P-client,P2P-GO} <= 3 ], max = 4
  *	=> allows a STA plus three P2P interfaces
  *
- * The list of these four possibilities could completely be contained
+ *	When describing per-hardware combinations in multi-hardware in
+ *	one wiphy model, the first possibility can further include the finer
+ *	capabilities like below
+ *	hw_chan_idx = 0, numbers = [ #{STA} <= 1, #{AP} <= 1 ],
+ *	channels = 1, max = 2
+ *	=> allows a STA plus an AP interface on the underlying hardware mac
+ *	   advertised at index 0 in wiphy @hw_chans array.
+ *	hw_chan_idx = 1, numbers = [ #{STA} <= 1, #{AP} <= 2 ],
+ *	channels = 1, max = 3
+ *	=> allows a STA plus two AP interfaces on the underlying hardware mac
+ *	   advertised at index 1 in wiphy @hw_chans array.
+ *
+ * The list of these five possibilities could completely be contained
  * within the %NL80211_ATTR_INTERFACE_COMBINATIONS attribute to indicate
  * that any of these groups must match.
  *
@@ -6039,12 +6055,44 @@ enum nl80211_if_combination_attrs {
 	NL80211_IFACE_COMB_RADAR_DETECT_WIDTHS,
 	NL80211_IFACE_COMB_RADAR_DETECT_REGIONS,
 	NL80211_IFACE_COMB_BI_MIN_GCD,
+	NL80211_IFACE_COMB_PER_HW_COMB,
 
 	/* keep last */
 	NUM_NL80211_IFACE_COMB,
 	MAX_NL80211_IFACE_COMB = NUM_NL80211_IFACE_COMB - 1
 };
 
+/**
+ * enum nl80211_if_comb_per_hw_comb_attrs - per-hardware iface combination
+ * attributes with multi-hw radios in one wiphy model
+ *
+ * @NL80211_IFACE_COMB_PER_HW_COMB_UNSPEC: (reserved)
+ * @NL80211_IFACE_COMB_PER_HW_COMB_HW_IDX: u8 attribute specifying the index
+ *	to the wiphy @hw_chans list for which the iface combination is being
+ *	described.
+ * @NL80211_IFACE_COMB_PER_HW_COMB_LIMITS: nested attribute containing the
+ *	limits for the given interface types, see
+ *	&enum nl80211_iface_limit_attrs.
+ * @NL80211_IFACE_COMB_PER_HW_COMB_MAXIMUM: u32 attribute giving the maximum
+ *	number of interfaces that can be created in this group. This number
+ *	does not apply to the interfaces purely managed in software.
+ * @NL80211_IFACE_COMB_PER_HW_COMB_NUM_CHANNELS: u32 attribute specifying the
+ *	number of different channels that can be used in this group.
+ * @NUM_NL80211_IFACE_COMB_PER_HW_COMB: number of attributes
+ * @MAX_NL80211_IFACE_COMB_PER_HW_COMB: highest attribute number
+ */
+enum nl80211_if_comb_per_hw_comb_attrs {
+	NL80211_IFACE_COMB_PER_HW_COMB_UNSPEC,
+	NL80211_IFACE_COMB_PER_HW_COMB_HW_IDX,
+	NL80211_IFACE_COMB_PER_HW_COMB_LIMITS,
+	NL80211_IFACE_COMB_PER_HW_COMB_MAXIMUM,
+	NL80211_IFACE_COMB_PER_HW_COMB_NUM_CHANNELS,
+
+	/* keep last */
+	NUM_NL80211_IFACE_COMB_PER_HW_COMB,
+	MAX_NL80211_IFACE_COMB_PER_HW_COMB =
+			NUM_NL80211_IFACE_COMB_PER_HW_COMB - 1
+};
 
 /**
  * enum nl80211_plink_state - state of a mesh peer link finite state machine
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 37524a61f417..87436924834f 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -1653,6 +1653,61 @@ nl80211_put_iface_limits(struct sk_buff *msg,
 	return -ENOBUFS;
 }
 
+static int
+nl80211_put_per_hw_iface_combinations(struct wiphy *wiphy, struct sk_buff *msg,
+				      const struct ieee80211_iface_combination *c)
+{
+	struct nlattr *hw_combis;
+	int i;
+
+	if (!wiphy->num_hw)
+		return 0;
+
+	hw_combis = nla_nest_start(msg, NL80211_IFACE_COMB_PER_HW_COMB);
+	if (!hw_combis)
+		return -ENOBUFS;
+
+	for (i = 0; i < c->n_hw_list; i++) {
+		struct nlattr *hw_combi, *limits;
+
+		hw_combi = nla_nest_start(msg, i + 1);
+		if (!hw_combi)
+			return -ENOBUFS;
+
+		if (nla_put_u8(msg, NL80211_IFACE_COMB_PER_HW_COMB_HW_IDX,
+			       c->iface_hw_list[i].hw_chans_idx))
+			return -ENOBUFS;
+
+		limits = nla_nest_start(msg,
+					NL80211_IFACE_COMB_PER_HW_COMB_LIMITS);
+		if (!limits)
+			return -ENOBUFS;
+
+		if (nl80211_put_iface_limits(msg,
+					     c->iface_hw_list[i].limits,
+					     c->iface_hw_list[i].n_limits))
+			return -ENOBUFS;
+
+		nla_nest_end(msg, limits);
+
+		if (nla_put_u32(msg,
+				NL80211_IFACE_COMB_PER_HW_COMB_NUM_CHANNELS,
+				c->iface_hw_list[i].num_different_channels))
+			return -ENOBUFS;
+
+		if (nla_put_u16(msg,
+				NL80211_IFACE_COMB_PER_HW_COMB_MAXIMUM,
+				c->iface_hw_list[i].max_interfaces))
+			return -ENOBUFS;
+
+		nla_nest_end(msg, hw_combi);
+	}
+
+	nla_nest_end(msg, hw_combis);
+
+	return 0;
+}
+
 static int nl80211_put_iface_combinations(struct wiphy *wiphy,
 					  struct sk_buff *msg,
 					  bool large)
@@ -1704,6 +1759,9 @@ static int nl80211_put_iface_combinations(struct wiphy *wiphy,
 				c->beacon_int_min_gcd))
 			goto nla_put_failure;
 
+		if (large && nl80211_put_per_hw_iface_combinations(wiphy, msg, c))
+			goto nla_put_failure;
+
 		nla_nest_end(msg, nl_combi);
 	}
 
-- 
2.34.1


