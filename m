Return-Path: <linux-wireless+bounces-17162-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0BA0A0492E
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Jan 2025 19:27:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C86F17A2AB5
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Jan 2025 18:27:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC89E1F37DA;
	Tue,  7 Jan 2025 18:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="gUUYEQCA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 808D71F3D2B
	for <linux-wireless@vger.kernel.org>; Tue,  7 Jan 2025 18:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736274429; cv=none; b=FOWuRzUVZVLalQI/aipE8/VKJgT85M53U1kdLUN9teAhZ7dUQ/cK9hODoyFYGmyiURsGhe32HP/6NKsB60rr/ecwucU9K+rGd555GuEHvKmtQtMoyS2/t+B1JUg92j0duVFBYuaQYqXJX/S8SrTzhOBoXS7ggR+8j82VZW4ghOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736274429; c=relaxed/simple;
	bh=7Ml/MXeOsFD0gEHA+UM/OhjX8lrxN/EJ0leDg+B6/WM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uybAnFj1zWzapwEgY1HMt1FjMj9W9K3DfiPViLt3tMWgdJTikVJz0gpgeZMlSvX4WP4n5FqcPSG3cutBoyrcE0mhuTGnarQAMkwcqSNwYPf7WHCiF72be35B6jrIHmeEcwHz6MBrgeJpEccVKLFWJUwMQF+2YDsimjvrUwjue+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=gUUYEQCA; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 507C0eO4018235;
	Tue, 7 Jan 2025 18:27:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	TP4cI7cwISXCny2fXj602pz+rk8S/7RFkQLLnsCGOa0=; b=gUUYEQCAswSa4AfX
	20nh/TrLomOdQBOSfHsWZxGEFj5HTTJ0U+h96WNpJI6FaDZ3GU9DOvpnS3FWQXXY
	w7mogMJLKlXWGYj9RZ3K6gcFlihy8vIPvUafAR2AYyMWeZEdgU+BBoXFbfzgnisL
	TmRRH/MZtpkbVFGZBBzwYCFexujz3raqm28XVuarYw3aO5nghwAYAXHkOrEuPgCP
	85YEYomMHe0jWjps8Zvivn3I2TzoWrgAtgvy65HUKLIkBhIlGHpJamtyLwd0u2yo
	gT30K8aviJZlRJ9E9o/qgNLAcp025/ck6ECQnDhMk/VBFMKh5YlqL7OC2MEymXZp
	a7ld8g==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4413w98ykx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Jan 2025 18:27:00 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 507IQxgU032255
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 7 Jan 2025 18:26:59 GMT
Received: from hu-ramess-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 7 Jan 2025 10:26:57 -0800
From: Rameshkumar Sundaram <quic_ramess@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Roopni Devanathan
	<quic_rdevanat@quicinc.com>,
        Rameshkumar Sundaram <quic_ramess@quicinc.com>
Subject: [PATCH RFC 2/5] wifi: cfg80211: Report per-radio RTS threshold to userspace
Date: Tue, 7 Jan 2025 23:55:03 +0530
Message-ID: <20250107182506.1838704-3-quic_ramess@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250107182506.1838704-1-quic_ramess@quicinc.com>
References: <20250107182506.1838704-1-quic_ramess@quicinc.com>
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
X-Proofpoint-ORIG-GUID: UdIyhfDl42QXqQTLel-KWzKVdi5Bzf4q
X-Proofpoint-GUID: UdIyhfDl42QXqQTLel-KWzKVdi5Bzf4q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 priorityscore=1501 spamscore=0 malwarescore=0 lowpriorityscore=0
 adultscore=0 clxscore=1015 mlxscore=0 phishscore=0 suspectscore=0
 mlxlogscore=999 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2411120000 definitions=main-2501070153

From: Roopni Devanathan <quic_rdevanat@quicinc.com>

In case of multi-radio wiphys, with per-radio RTS threshold brought
into use, RTS threshold for each radio in a wiphy can be recorded in
wiphy parameter - wiphy_radio_cfg, as an array. When a request for
getting RTS threshold for a particular radio is received, parse the
radio id and get the required data. Add support to report this data
to userspace.

Note:
The proposed design can be extended to all per-radio attributes, such as,
frag_threshold, retry_short, retry_long, coverage_class, etc. The added
NL80211_ATTR_WIPHY_RADIO_INDEX attribute can be used to identify the
index of radio, which is passed from the userspace.

Signed-off-by: Roopni Devanathan <quic_rdevanat@quicinc.com>
Signed-off-by: Rameshkumar Sundaram <quic_ramess@quicinc.com>
---
 net/wireless/nl80211.c | 29 +++++++++++++++++++++++------
 1 file changed, 23 insertions(+), 6 deletions(-)

diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 3b004b419a74..7cf6597b4c18 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -2505,7 +2505,8 @@ struct nl80211_dump_wiphy_state {
 static int nl80211_send_wiphy(struct cfg80211_registered_device *rdev,
 			      enum nl80211_commands cmd,
 			      struct sk_buff *msg, u32 portid, u32 seq,
-			      int flags, struct nl80211_dump_wiphy_state *state)
+			      int flags, u8 radio_id,
+			      struct nl80211_dump_wiphy_state *state)
 {
 	void *hdr;
 	struct nlattr *nl_bands, *nl_band;
@@ -2516,7 +2517,7 @@ static int nl80211_send_wiphy(struct cfg80211_registered_device *rdev,
 	int i;
 	const struct ieee80211_txrx_stypes *mgmt_stypes =
 				rdev->wiphy.mgmt_stypes;
-	u32 features;
+	u32 features, rts_threshold;
 
 	hdr = nl80211hdr_put(msg, portid, seq, flags, cmd);
 	if (!hdr)
@@ -2537,6 +2538,11 @@ static int nl80211_send_wiphy(struct cfg80211_registered_device *rdev,
 
 	switch (state->split_start) {
 	case 0:
+		if (radio_id >= rdev->wiphy.n_radio)
+			rts_threshold = rdev->wiphy.rts_threshold;
+		else
+			rts_threshold = rdev->wiphy.radio_cfg[radio_id].rts_threshold;
+
 		if (nla_put_u8(msg, NL80211_ATTR_WIPHY_RETRY_SHORT,
 			       rdev->wiphy.retry_short) ||
 		    nla_put_u8(msg, NL80211_ATTR_WIPHY_RETRY_LONG,
@@ -2544,7 +2550,7 @@ static int nl80211_send_wiphy(struct cfg80211_registered_device *rdev,
 		    nla_put_u32(msg, NL80211_ATTR_WIPHY_FRAG_THRESHOLD,
 				rdev->wiphy.frag_threshold) ||
 		    nla_put_u32(msg, NL80211_ATTR_WIPHY_RTS_THRESHOLD,
-				rdev->wiphy.rts_threshold) ||
+				rts_threshold) ||
 		    nla_put_u8(msg, NL80211_ATTR_WIPHY_COVERAGE_CLASS,
 			       rdev->wiphy.coverage_class) ||
 		    nla_put_u8(msg, NL80211_ATTR_MAX_NUM_SCAN_SSIDS,
@@ -3211,7 +3217,9 @@ static int nl80211_dump_wiphy(struct sk_buff *skb, struct netlink_callback *cb)
 						 skb,
 						 NETLINK_CB(cb->skb).portid,
 						 cb->nlh->nlmsg_seq,
-						 NLM_F_MULTI, state);
+						 NLM_F_MULTI,
+						 NL80211_WIPHY_RADIO_ID_MAX,
+						 state);
 			if (ret < 0) {
 				/*
 				 * If sending the wiphy data didn't fit (ENOBUFS
@@ -3260,13 +3268,21 @@ static int nl80211_get_wiphy(struct sk_buff *skb, struct genl_info *info)
 	struct sk_buff *msg;
 	struct cfg80211_registered_device *rdev = info->user_ptr[0];
 	struct nl80211_dump_wiphy_state state = {};
+	u8 radio_id = NL80211_WIPHY_RADIO_ID_MAX;
 
 	msg = nlmsg_new(4096, GFP_KERNEL);
 	if (!msg)
 		return -ENOMEM;
 
+	if (info->attrs[NL80211_ATTR_WIPHY_RADIO_INDEX]) {
+		radio_id = nla_get_u8(info->attrs[NL80211_ATTR_WIPHY_RADIO_INDEX]);
+
+		if (radio_id >= rdev->wiphy.n_radio)
+			return -EINVAL;
+	}
+
 	if (nl80211_send_wiphy(rdev, NL80211_CMD_NEW_WIPHY, msg,
-			       info->snd_portid, info->snd_seq, 0,
+			       info->snd_portid, info->snd_seq, 0, radio_id,
 			       &state) < 0) {
 		nlmsg_free(msg);
 		return -ENOBUFS;
@@ -17693,7 +17709,8 @@ void nl80211_notify_wiphy(struct cfg80211_registered_device *rdev,
 	if (!msg)
 		return;
 
-	if (nl80211_send_wiphy(rdev, cmd, msg, 0, 0, 0, &state) < 0) {
+	if (nl80211_send_wiphy(rdev, cmd, msg, 0, 0, 0, NL80211_WIPHY_RADIO_ID_MAX,
+			       &state) < 0) {
 		nlmsg_free(msg);
 		return;
 	}
-- 
2.34.1


