Return-Path: <linux-wireless+bounces-20709-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 457EEA6CE4A
	for <lists+linux-wireless@lfdr.de>; Sun, 23 Mar 2025 08:40:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A52A616D8A9
	for <lists+linux-wireless@lfdr.de>; Sun, 23 Mar 2025 07:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 527EE202970;
	Sun, 23 Mar 2025 07:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Zt4Xv8gS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF9951F91C8
	for <linux-wireless@vger.kernel.org>; Sun, 23 Mar 2025 07:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742715645; cv=none; b=MtjVjXdNLTO38kAHXS//fJTxdyhWx1TmVoreBh0hUby3msbKD5VMXZ0ZlsZ3zrYpccC+3flyGcP9KWc9O5LF13yIs/f3rJx8JyWf904zIizx2MXFg3ALOrl7p9OEVMTsZbdsp71zvSJpYcFNFNbir+n1KZHuR0X4Zm7muAnP7uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742715645; c=relaxed/simple;
	bh=SxneD5m20UM1WF//izx3S1LxckhqYd4Mn+/sLLUk9C4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q1H9qu6zxab/HjvsK6Un+LnIgd57+8uBaKvLcY7WFq5ER0JtjhkhaNd0jmtPxUpHFGuuPKQmajHz5ayh6UHTpPP7Beot7z3HgyfdH7z7iuYbjMD2sXI8+YsnPlGYx3kLlA1s+IBP408vQaejC/xGeKqiipHVrVOjCE4hkj4XqVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Zt4Xv8gS; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52N7aL3N017877;
	Sun, 23 Mar 2025 07:40:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	A8TtqabTM21C+3QCJVmoSzmWs6JdYWp/IDmKeGQPLLc=; b=Zt4Xv8gSkZVIFnmm
	ePB6EDhMdpHtT5MGAiw1IX4vMMq+xHM/6Eg3PyvHQ97IXymlTslslD5RPLTMIsKM
	s/ioUsRVlfSuHtbF9KBXeAYRON4KYWTo9q5Ew0giKwWiaM3vYKowFvqCKM+74adm
	1ohwSupFamrY+Xwx5slRAQ1Eao04sztOA97rObiL42Q2/1SJLjcd2ngWfRnxOkTQ
	gudH444VGSY/LncHzF6URcsxd0S+wONZzCCZ6PwlncoMvXTOlKArQOf6GAVKOKYl
	4O37Tb+54DsKA5zOfPDv0r1UZ/H9z3E9ltzS0b1iR3yBGYhA0tIIk+4zEHOWHFlf
	gATXrg==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45hnyj9nqc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 23 Mar 2025 07:40:35 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 52N7eZrT012198
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 23 Mar 2025 07:40:35 GMT
Received: from hu-rdevanat-blr.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Sun, 23 Mar 2025 00:40:33 -0700
From: Roopni Devanathan <quic_rdevanat@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Roopni Devanathan
	<quic_rdevanat@quicinc.com>
Subject: [PATCH v5 2/5] wifi: cfg80211: Report per-radio RTS threshold to userspace
Date: Sun, 23 Mar 2025 13:09:56 +0530
Message-ID: <20250323073959.2872641-3-quic_rdevanat@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250323073959.2872641-1-quic_rdevanat@quicinc.com>
References: <20250323073959.2872641-1-quic_rdevanat@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=Ybu95xRf c=1 sm=1 tr=0 ts=67dfbaf3 cx=c_pps a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=GEpy-HfZoHoA:10 a=Vs1iUdzkB0EA:10 a=COk6AnOGAAAA:8 a=t2xFH_FA9tHEZGNgIz8A:9 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: boTqbxHg_4yM6Onyu1MRgEU9FWT4uNPn
X-Proofpoint-ORIG-GUID: boTqbxHg_4yM6Onyu1MRgEU9FWT4uNPn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-23_03,2025-03-21_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 suspectscore=0 mlxlogscore=999 priorityscore=1501 spamscore=0
 lowpriorityscore=0 mlxscore=0 malwarescore=0 bulkscore=0 clxscore=1015
 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503230057

In case of multi-radio wiphys, with per-radio RTS threshold brought
into use, RTS threshold for each radio in a wiphy can be recorded in
wiphy parameter - wiphy_radio_cfg, as an array. Add a new attribute -
NL80211_WIPHY_RADIO_ATTR_RTS_THRESHOLD in nested parameter -
NL80211_ATTR_WIPHY_RADIOS. When a request for getting RTS threshold
for a particular radio is received, parse the radio id and get the
required data. Add this data to the newly added nested attribute
NL80211_WIPHY_RADIO_ATTR_RTS_THRESHOLD. Add support to report this
data to userspace.

Signed-off-by: Roopni Devanathan <quic_rdevanat@quicinc.com>
---
 include/uapi/linux/nl80211.h | 2 ++
 net/wireless/nl80211.c       | 9 ++++++++-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index e3dff8657487..3f841b601847 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -8093,6 +8093,7 @@ enum nl80211_ap_settings_flags {
  *	and contains attributes defined in &enum nl80211_if_combination_attrs.
  * @NL80211_WIPHY_RADIO_ATTR_ANTENNA_MASK: bitmask (u32) of antennas
  *	connected to this radio.
+ * @NL80211_WIPHY_RADIO_ATTR_RTS_THRESHOLD: RTS threshold (u32) of this radio.
  *
  * @__NL80211_WIPHY_RADIO_ATTR_LAST: Internal
  * @NL80211_WIPHY_RADIO_ATTR_MAX: Highest attribute
@@ -8104,6 +8105,7 @@ enum nl80211_wiphy_radio_attrs {
 	NL80211_WIPHY_RADIO_ATTR_FREQ_RANGE,
 	NL80211_WIPHY_RADIO_ATTR_INTERFACE_COMBINATION,
 	NL80211_WIPHY_RADIO_ATTR_ANTENNA_MASK,
+	NL80211_WIPHY_RADIO_ATTR_RTS_THRESHOLD,
 
 	/* keep last */
 	__NL80211_WIPHY_RADIO_ATTR_LAST,
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index a929a0212a1e..cb03545ddd70 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -2444,6 +2444,7 @@ static int nl80211_put_mbssid_support(struct wiphy *wiphy, struct sk_buff *msg)
 static int nl80211_put_radio(struct wiphy *wiphy, struct sk_buff *msg, int idx)
 {
 	const struct wiphy_radio *r = &wiphy->radio[idx];
+	const struct wiphy_radio_cfg *rcfg = &wiphy->radio_cfg[idx];
 	struct nlattr *radio, *freq;
 	int i;
 
@@ -2454,6 +2455,11 @@ static int nl80211_put_radio(struct wiphy *wiphy, struct sk_buff *msg, int idx)
 	if (nla_put_u32(msg, NL80211_WIPHY_RADIO_ATTR_INDEX, idx))
 		goto nla_put_failure;
 
+	if (rcfg->rts_threshold &&
+	    nla_put_u32(msg, NL80211_WIPHY_RADIO_ATTR_RTS_THRESHOLD,
+			rcfg->rts_threshold))
+		goto nla_put_failure;
+
 	if (r->antenna_mask &&
 	    nla_put_u32(msg, NL80211_WIPHY_RADIO_ATTR_ANTENNA_MASK,
 			r->antenna_mask))
@@ -3237,7 +3243,8 @@ static int nl80211_dump_wiphy(struct sk_buff *skb, struct netlink_callback *cb)
 						 skb,
 						 NETLINK_CB(cb->skb).portid,
 						 cb->nlh->nlmsg_seq,
-						 NLM_F_MULTI, state);
+						 NLM_F_MULTI,
+						 state);
 			if (ret < 0) {
 				/*
 				 * If sending the wiphy data didn't fit (ENOBUFS
-- 
2.25.1


