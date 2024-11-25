Return-Path: <linux-wireless+bounces-15684-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 068D29D8324
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Nov 2024 11:13:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA98E28B4BB
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Nov 2024 10:13:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49FA2192D65;
	Mon, 25 Nov 2024 10:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="nz5BHL4g"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E663190661
	for <linux-wireless@vger.kernel.org>; Mon, 25 Nov 2024 10:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732529380; cv=none; b=rjI7AzDF9FXYZ7UNkEAlg9xdn+srbaebVELwj2OEQ3LM7J6mHO4S1GFD4D0zGOm8zM/fei7s1ezqQYlfGMSSsnhionX5H3HSYAhrB5ODmoIskfyE58O9iQMu36uCY5593osFWVZJM+lJV6kswjO4jnHLDOL59JmSaCCyKnZlk2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732529380; c=relaxed/simple;
	bh=3Y2YBK+8i3A9mqYtS860W0T9XUPZH0vB6o8uBG1BNaI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HPbkLfUNRuiE1IcgfMerWpQnQ85W1aiXY7fyS71EI6H6kDCpeO+ZvXkjLrKBkeYGisivPZOKzxJf9mW83DD6DS66ePLpb7x66Uj3ydsX/ShzV5YnjOXP44tt2Jx9Zr68fXH4+tp2iEcTkgcwwQ1jPIUpNiePJK6Vj9j9utMo35o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=nz5BHL4g; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AP7Vglm010591;
	Mon, 25 Nov 2024 10:09:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=Bpr2N7YvmvALprS+bEo9d8
	6g6ZmrF5U0etFqus7tB2k=; b=nz5BHL4gTh9WYIHMlLNkXobNE3BYCm4ZyssM68
	/saKj8Pmhb+jTCnkfPIxnY5WqqXJSRDriKvZm/wFYt9XOMkMTQrxxCXBBa/SZBE7
	k5tuVn3c9DHVdvJlVI3var/E0RgadTvAYqhtUKKN9lR8QKcJuwoS6F2SU9sSj5XR
	ouKxY88qRyc0uVAYALm/pLduKlquq2NSI6oA+FCO8+Yl7ahovNWlf0ZmjuneL1CA
	XQBtdYd86Nr2dtuYQ3ztdiV3SownfdGRw3KM1f+cBmErr6tfaqbyxrmzh81mWdo9
	y0CfXB57cqZ3NhMBShq3yDYF25bwt7d1N+nkv/n/csj6zB/g==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 434mx70evj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Nov 2024 10:09:34 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4APA9XT8028540
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Nov 2024 10:09:33 GMT
Received: from hu-ramess-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 25 Nov 2024 02:09:31 -0800
From: Rameshkumar Sundaram <quic_ramess@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Aaradhana Sahu
	<quic_aarasahu@quicinc.com>,
        Rameshkumar Sundaram <quic_ramess@quicinc.com>
Subject: [PATCH] iw: print tx power per link for MLD
Date: Mon, 25 Nov 2024 15:39:13 +0530
Message-ID: <20241125100913.261319-1-quic_ramess@quicinc.com>
X-Mailer: git-send-email 2.34.1
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
X-Proofpoint-GUID: mGIJNXlLu-KaIdxPOaz2ez4S8NQGu0BR
X-Proofpoint-ORIG-GUID: mGIJNXlLu-KaIdxPOaz2ez4S8NQGu0BR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 mlxlogscore=999 malwarescore=0 adultscore=0 spamscore=0 mlxscore=0
 bulkscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411250086

From: Aaradhana Sahu <quic_aarasahu@quicinc.com>

Add support to print tx power per link for an ML interface

Sample output:
phy#0
        Interface wlp88s0
                ifindex 5
                wdev 0x1
                addr 00:03:7f:01:54:92
                ssid tx_power_123
                type AP
                multicast TXQ:
                        qsz-byt qsz-pkt flows   drops   marks   overlmt hashcol tx-bytes        tx-packets
                        0       0       0       0       0       0       0       0               0
                MLD with links:
                 - link ID  0 link addr 00:03:7f:01:54:92
                   channel 36 (5180 MHz), width: 80 MHz, center1: 5210 MHz
                   txpower 30.00 dBm

Signed-off-by: Aaradhana Sahu <quic_aarasahu@quicinc.com>
Signed-off-by: Rameshkumar Sundaram <quic_ramess@quicinc.com>
---
 interface.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/interface.c b/interface.c
index bb1a1d30385c..0d4ff042c7a6 100644
--- a/interface.c
+++ b/interface.c
@@ -490,6 +490,11 @@ static int print_iface_handler(struct nl_msg *msg, void *arg)
 				printf("\n%s\t   ", indent);
 				print_channel(tb);
 			}
+			if (tb[NL80211_ATTR_WIPHY_TX_POWER_LEVEL]) {
+				int32_t txp = nla_get_u32(tb[NL80211_ATTR_WIPHY_TX_POWER_LEVEL]);
+
+				printf("\n%s\t   txpower %d.%.2d dBm", indent, txp / 100, txp % 100);
+			}
 			printf("\n");
 		}
 	}

base-commit: 478ddd470cce0302e928c089062365ca69aa36f9
-- 
2.34.1


