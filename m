Return-Path: <linux-wireless+bounces-18400-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5772BA26DA9
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Feb 2025 09:51:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1709164D73
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Feb 2025 08:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAA6F206F37;
	Tue,  4 Feb 2025 08:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="FQCY/oRH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9E33207A0C
	for <linux-wireless@vger.kernel.org>; Tue,  4 Feb 2025 08:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738659052; cv=none; b=piKFRQJ67XGzLLQwFzF41BT6aUf5VVX8QxCjykQS6bgYH2c9GnfpySuioAYrESnBlcT+P7/oQig80FY+f8mZX9wIulQtdknKh1JG/c1VsQ1ADpM6vDlmoRdWSueT5aFEXLab679Z4Dw6UZv8rpAop3xIAYb8gAAZyEFxCrIZjCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738659052; c=relaxed/simple;
	bh=6SPbdiaC9dvQ/HrAJK6Qp0yZ02oezqZxwdm3OYH1IsU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TwZNG7l4380IhOnZA3v453fqGqUscPU9khPs+jqfVg1Vk5Mt0N3xM+EC3+LqeEQnA1++ogybHdZdJ2IPxvCXWp/TEqcKP5L9r0HJqxxVwGuI9AOMOk1moBRWyTqo97YQKuRw5hiSD99B9GMlpMaM6BFjcJpZCEWMGj15OAsXSSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=FQCY/oRH; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5148UHbJ006256;
	Tue, 4 Feb 2025 08:50:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	HxNHklzAdBHq+zxdanUaa02a1UsSgauJQBsAKcUgbv4=; b=FQCY/oRH+WSczdDx
	/tiVoxWcb2bUqbef2vWsivEtzYLXMd1qwc95FQZMJE7ADjjIrEfyL7U+HHhfQCgC
	NIM+HL2EmiC6l8vr8EoGMSirlhi+gsC7xQrleasBY3tIklAE6pxcrM9w9ZqdqMca
	s0JGstI6BVPFhc1AHTgcBpQz4qReZZwUa388xGEYvSl2AfjOyj0PuAj5omTZZqiE
	AtMtBZ+Kq+jICoUwM8HrWFKURL0PRJtPfAOfBVamLli1mSlS4FTQ6rdKbF47Y5vL
	h6/c7lV8D/Yr0L2CSDgHcc2YtF6jAMJbTL9eMjBIbmiR4tfafvVqZOxIUUEzhbKA
	q0N3Pw==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44kfe9g1e2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Feb 2025 08:50:44 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 5148ohDY006202
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 4 Feb 2025 08:50:43 GMT
Received: from hu-rdevanat-blr.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 4 Feb 2025 00:50:41 -0800
From: Roopni Devanathan <quic_rdevanat@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Rameshkumar Sundaram
	<quic_ramess@quicinc.com>,
        Roopni Devanathan <quic_rdevanat@quicinc.com>
Subject: [PATCH 2/2] iw: Add support to set per-radio Tx power config in multi-radio wiphy
Date: Tue, 4 Feb 2025 14:20:00 +0530
Message-ID: <20250204085000.3809769-3-quic_rdevanat@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250204085000.3809769-1-quic_rdevanat@quicinc.com>
References: <20250204085000.3809769-1-quic_rdevanat@quicinc.com>
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
X-Proofpoint-ORIG-GUID: 6JjpMH7ODfCnZlHHv5w2O1CpCH4LezQD
X-Proofpoint-GUID: 6JjpMH7ODfCnZlHHv5w2O1CpCH4LezQD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-04_04,2025-01-31_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 malwarescore=0
 spamscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0 mlxscore=0
 suspectscore=0 mlxlogscore=999 impostorscore=0 priorityscore=1501
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502040071

From: Rameshkumar Sundaram <quic_ramess@quicinc.com>

Currently, setting transmit power changes the transmit power for all radios
in a wiphy. But different radios in a wiphy can have different transmit
power requirements. Modify the iw command to handle this. This will
ensure that the legacy userspace will interact with traditional drivers
as well as multi-radio wiphy drivers.

In order to be able to set transmit power for a particular radio from
user space, without disturbing the other radios in a wiphy, pass the
radio id for which the transmit power needs to be changed and its
transmit power value. The valid radio id values can be checked in
iw phy#XXX info, under "Supported wiphy radios".

Signed-off-by: Rameshkumar Sundaram <quic_ramess@quicinc.com>
Signed-off-by: Roopni Devanathan <quic_rdevanat@quicinc.com>
---
 phy.c | 39 ++++++++++++++++++++++++++++-----------
 1 file changed, 28 insertions(+), 11 deletions(-)

diff --git a/phy.c b/phy.c
index 890966d..bd7194d 100644
--- a/phy.c
+++ b/phy.c
@@ -727,20 +727,37 @@ static int handle_txpower(struct nl80211_state *state,
 			  enum id_input id)
 {
 	enum nl80211_tx_power_setting type;
-	int mbm;
+	int mbm, i = 0;
 
 	/* get the required args */
-	if (argc != 1 && argc != 2)
+	if (argc > 4)
 		return 1;
 
-	if (!strcmp(argv[0], "auto"))
+	/* check if radio idx is provided */
+	if (argc >= 2 && !strcmp(argv[0], "radio")) {
+		unsigned int radio_id;
+		char *endptr;
+
+		radio_id = strtoul(argv[1], &endptr, 10);
+		if (*endptr)
+			return 1;
+
+		NLA_PUT_U32(msg, NL80211_ATTR_WIPHY_RADIO_INDEX, radio_id);
+		i = 2;
+	}
+
+	/* check the required args without radio id */
+	if ((argc - i) != 1 && (argc - i) != 2)
+		return 1;
+
+	if (!strcmp(argv[i], "auto")) {
 		type = NL80211_TX_POWER_AUTOMATIC;
-	else if (!strcmp(argv[0], "fixed"))
+	} else if (!strcmp(argv[i], "fixed")) {
 		type = NL80211_TX_POWER_FIXED;
-	else if (!strcmp(argv[0], "limit"))
+	} else if (!strcmp(argv[i], "limit")) {
 		type = NL80211_TX_POWER_LIMITED;
-	else {
-		printf("Invalid parameter: %s\n", argv[0]);
+	} else {
+		printf("Invalid parameter: %s\n", argv[i]);
 		return 2;
 	}
 
@@ -748,16 +765,16 @@ static int handle_txpower(struct nl80211_state *state,
 
 	if (type != NL80211_TX_POWER_AUTOMATIC) {
 		char *endptr;
-		if (argc != 2) {
+		if ((argc - i) != 2) {
 			printf("Missing TX power level argument.\n");
 			return 2;
 		}
 
-		mbm = strtol(argv[1], &endptr, 10);
+		mbm = strtol(argv[++i], &endptr, 10);
 		if (*endptr)
 			return 2;
 		NLA_PUT_U32(msg, NL80211_ATTR_WIPHY_TX_POWER_LEVEL, mbm);
-	} else if (argc != 1)
+	} else if ((argc - i) != 1)
 		return 1;
 
 	return 0;
@@ -765,7 +782,7 @@ static int handle_txpower(struct nl80211_state *state,
  nla_put_failure:
 	return -ENOBUFS;
 }
-COMMAND(set, txpower, "<auto|fixed|limit> [<tx power in mBm>]",
+COMMAND(set, txpower, "[radio <radio idx>] <auto|fixed|limit> [<tx power in mBm>]",
 	NL80211_CMD_SET_WIPHY, 0, CIB_PHY, handle_txpower,
 	"Specify transmit power level and setting type.");
 COMMAND(set, txpower, "<auto|fixed|limit> [<tx power in mBm>]",
-- 
2.34.1


