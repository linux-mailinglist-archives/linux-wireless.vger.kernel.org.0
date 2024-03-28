Return-Path: <linux-wireless+bounces-5431-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0626888F8B1
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Mar 2024 08:30:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 876151F276CC
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Mar 2024 07:30:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D43FC51C5F;
	Thu, 28 Mar 2024 07:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="WdnrgXYR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BBD22561F
	for <linux-wireless@vger.kernel.org>; Thu, 28 Mar 2024 07:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711610996; cv=none; b=dyY8woVRq7O3XaJvocrBF0cC9RNDJxKFK1gWAdUiIiIMgp7ue77lqy7tkEoJYDRAnJ/uD0A6kPg6dWXX6VFshbLRu8nfBC1qUidEmr08m8oRS4umqB0aHfPzRVUBhROvABgRwIq9Yw3oOLZLdfHsaMhajMqzQnkOlllmGdmy9qY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711610996; c=relaxed/simple;
	bh=kkhe/Ekhfg39O5N45xmWkwhiq40y3S8mBwzZQZFDlOo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZFQGR5stlz36fIqXq5OgkTqvvHpCdJqzbSU2GcoES1cD2qonDvJC/fN3I5xV0loHzp4p9TDplHI4Y4S2lGixdd+haV64FVXVOD5NSxJy2Y39dwMeTza3ysLDknSh6WKiKF6XY9E5D2ntNJCeYlgnIho+zfNj7s9g9ftl9U5DDr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=WdnrgXYR; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42S2kSln015207;
	Thu, 28 Mar 2024 07:29:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=UaH4fMBk+JQl0hAOLd24qlZKav6+aNCUI7YTLNvxBs4=; b=Wd
	nrgXYRlZbhgYkBBm4F4zAgG8L84DTW2kd8vCRgObryGFJgDh2+dIbLiHGHuk/fpD
	tzv42bWZJuLz7dz3ZxXxe0FMeQIz3w+IbbtRz/qJbaAtMu4FihjBlPlia+fAjWnm
	F5p/c/nY4VR5br16qxJ/flYpE+xEBFKQFLPolfWXPH5XJXcASo2PKbVPHgG4USlJ
	0g/Y/+lhztDI6/5fcq3c/Lmab9dqKERKlhIpypzhse5yw4LDo+pgItS1Gquey4xO
	YKRVn9T0E9V2loS71fhcS5NFZCg5ekuzAdXuAlEMwHg40e+9eG2t1oa+e5icXo0r
	ho4/Zizfk4ID4He70XOw==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x4u1wjb7a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Mar 2024 07:29:48 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42S7TmYp000618
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Mar 2024 07:29:48 GMT
Received: from hu-periyasa-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 28 Mar 2024 00:29:45 -0700
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
To: <ath12k@lists.infradead.org>, <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Vasanthakumar Thiagarajan
	<quic_vthiagar@quicinc.com>,
        Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>
Subject: [PATCH 02/13] wifi: nl80211: send underlying multi-hardware channel capabilities to user space
Date: Thu, 28 Mar 2024 12:59:05 +0530
Message-ID: <20240328072916.1164195-3-quic_periyasa@quicinc.com>
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
X-Proofpoint-GUID: fMrZDl1MtlaHgYHUBoxzlprMN36AtsIb
X-Proofpoint-ORIG-GUID: fMrZDl1MtlaHgYHUBoxzlprMN36AtsIb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-28_06,2024-03-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 suspectscore=0 adultscore=0 mlxlogscore=999 spamscore=0 impostorscore=0
 malwarescore=0 phishscore=0 clxscore=1015 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403210001 definitions=main-2403280048

From: Vasanthakumar Thiagarajan <quic_vthiagar@quicinc.com>

As originally discussed in the RFC [1], when driver supports multiple
physical hardware under one wiphy, wiphy->num_hw != 0, send per-hardware
supported frequency list to user space. List of frequency are reported
inside an index which identifies the hardware as in wiphy->hw_chans[].
This hardware index will be used in follow up patches to identify the
interface combination capability for each of the underlying physical
hardware abstracted under one wiphy.

[1]: https://lore.kernel.org/linux-wireless/20220920100518.19705-3-quic_vthiagar@quicinc.com/

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.1.1-00188-QCAHKSWPL_SILICONZ-1

Signed-off-by: Vasanthakumar Thiagarajan <quic_vthiagar@quicinc.com>
Co-developed-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
---
 include/uapi/linux/nl80211.h | 28 +++++++++++++++++++++
 net/wireless/nl80211.c       | 47 ++++++++++++++++++++++++++++++++++++
 2 files changed, 75 insertions(+)

diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index f917bc6c9b6f..c53c9f941663 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -2856,6 +2856,11 @@ enum nl80211_commands {
  *	%NL80211_CMD_ASSOCIATE indicating the SPP A-MSDUs
  *	are used on this connection
  *
+ * @NL80211_ATTR_MULTI_HW: nested attribute to send the hardware specific
+ *	channel capabilities to user space. Drivers registering multiple
+ *	physical hardware under a wiphy can use this attribute,
+ *	see &enum nl80211_multi_hw_mac_attrs.
+ *
  * @NUM_NL80211_ATTR: total number of nl80211_attrs available
  * @NL80211_ATTR_MAX: highest attribute number currently defined
  * @__NL80211_ATTR_AFTER_LAST: internal use
@@ -3401,6 +3406,8 @@ enum nl80211_attrs {
 
 	NL80211_ATTR_ASSOC_SPP_AMSDU,
 
+	NL80211_ATTR_MULTI_HW,
+
 	/* add attributes here, update the policy in nl80211.c */
 
 	__NL80211_ATTR_AFTER_LAST,
@@ -7999,4 +8006,25 @@ enum nl80211_ap_settings_flags {
 	NL80211_AP_SETTINGS_SA_QUERY_OFFLOAD_SUPPORT	= 1 << 1,
 };
 
+/**
+ * nl80211_multi_hw_attrs - multi-hw attributes
+ *
+ * @NL80211_MULTI_HW_ATTR_INVALID: invalid
+ * @NL80211_MULTI_HW_ATTR_IDX: (u8) multi-HW index to refer the underlying HW
+ *	for which the supported channel list is advertised. Internally refer
+ *	the index of the wiphy's @hw_chans array.
+ * @NL80211_MULTI_HW_ATTR_FREQS: array of supported center frequencies
+ * @__NL80211_MULTI_HW_ATTR_LAST: internal use
+ * @NL80211_MULTI_HW_ATTR_MAX: maximum multi-hw mac attribute
+ */
+enum nl80211_multi_hw_attrs {
+	__NL80211_MULTI_HW_ATTR_INVALID,
+
+	NL80211_MULTI_HW_ATTR_IDX,
+	NL80211_MULTI_HW_ATTR_FREQS,
+
+	/* keep last */
+	__NL80211_MULTI_HW_ATTR_LAST,
+	NL80211_MULTI_HW_ATTR_MAX = __NL80211_MULTI_HW_ATTR_LAST - 1
+};
 #endif /* __LINUX_NL80211_H */
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index b4edba6b0b7b..2a5e395e2e0b 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -2392,6 +2392,47 @@ static int nl80211_put_mbssid_support(struct wiphy *wiphy, struct sk_buff *msg)
 	return -ENOBUFS;
 }
 
+static int nl80211_put_multi_hw_support(struct wiphy *wiphy,
+					struct sk_buff *msg)
+{
+	struct nlattr *hw_macs, *hw_mac;
+	struct nlattr *freqs;
+	int i, c;
+
+	if (!wiphy->num_hw)
+		return 0;
+
+	hw_macs = nla_nest_start(msg, NL80211_ATTR_MULTI_HW);
+	if (!hw_macs)
+		return -ENOBUFS;
+
+	for (i = 0; i < wiphy->num_hw; i++) {
+		hw_mac = nla_nest_start(msg, i + 1);
+		if (!hw_mac)
+			return -ENOBUFS;
+
+		if (nla_put_u8(msg, NL80211_MULTI_HW_ATTR_IDX, i))
+			return -ENOBUFS;
+
+		freqs = nla_nest_start(msg,
+				       NL80211_MULTI_HW_ATTR_FREQS);
+		if (!freqs)
+			return -ENOBUFS;
+
+		for (c = 0; c < wiphy->hw_chans[i]->n_chans; c++)
+			if (nla_put_u32(msg, c + 1,
+					wiphy->hw_chans[i]->chans[c].center_freq))
+				return -ENOBUFS;
+
+		nla_nest_end(msg, freqs);
+
+		nla_nest_end(msg, hw_mac);
+	}
+
+	nla_nest_end(msg, hw_macs);
+	return 0;
+}
+
 struct nl80211_dump_wiphy_state {
 	s64 filter_wiphy;
 	long start;
@@ -3001,6 +3042,12 @@ static int nl80211_send_wiphy(struct cfg80211_registered_device *rdev,
 				rdev->wiphy.hw_timestamp_max_peers))
 			goto nla_put_failure;
 
+		state->split_start++;
+		break;
+	case 17:
+		if (nl80211_put_multi_hw_support(&rdev->wiphy, msg))
+			goto nla_put_failure;
+
 		/* done */
 		state->split_start = 0;
 		break;
-- 
2.34.1


