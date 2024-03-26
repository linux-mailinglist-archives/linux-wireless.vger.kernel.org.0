Return-Path: <linux-wireless+bounces-5267-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B83288B987
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Mar 2024 05:53:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE1E8B21684
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Mar 2024 04:53:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7BD31C6A3;
	Tue, 26 Mar 2024 04:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="PaXb+64w"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F61E29B0
	for <linux-wireless@vger.kernel.org>; Tue, 26 Mar 2024 04:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711428785; cv=none; b=L4NxCaSgBNFqLp76GOdHmwgRHxEfsJ7HaUW/4MhVzAeqL0Hf1tX20r11B/J17kSiyQlg2YGPMIhf/SWXRKGdR3oH8tOLBYYrBqjB3cpqjfNiKOFidNGZREDSwTxmYcWOgCgQwD0xLtSSwfGMQXrmnhes/Ze6pl0TMYmcYNtZ3fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711428785; c=relaxed/simple;
	bh=iUWkyjmtAbSP8ogaM/KXmdArfAv1p1TGj3w0OruuT44=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rThXbT0nwHTfKn2KJF2KGq3yFHwT9ijZzHACsWhOQXkoIs+MOfMOslxgqK1bnU/WB371Vv4ffiC9sb5/3SsiqW48t35Am4kmLX6IfAcW3uGa4zysPtDqUoN2pFD0eXboM+ZCLkR41j+uA4xH4UcHj38e0FP4Wj/4wU8ikGAgA2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=PaXb+64w; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42Q4Q6R0005983;
	Tue, 26 Mar 2024 04:52:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=mHSAyzA
	9ffhncPLNQoNRs6ADEHMTYzLRW8AsYqOl1VM=; b=PaXb+64woauDQp2y3IHhxSa
	F+BL9F6mEqzp/O7HQ2PYojFkvpaOAoUrZQ9TBCvvCxOWIRbol+ABrY+UbpynWfdp
	c7038oYiLZoFWa0zkQtUeZGrLFmdyhCGxyX5SXpSZcQtgEL046+S71zNJpeaszhQ
	KKSQZq35B3FNNnnHoSBXensnxLL+HbIsbdMsyRYBwPsQU6uTCKE3o7S9w7luxh0g
	QhO1YnLy9hr3k8VcI8hvBWzldP9TV/8jjeCRMjf3H3PcWYf/ezoJSy5NTc3Qnm7c
	Msl7X9zeOkAUCH6kpTJxjKOrA81X0iOZr1owv0iSu3GW1Hf0M2m+8pNbRntVIYQ=
	=
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x3j54gk23-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Mar 2024 04:52:58 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42Q4qv5e002496
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Mar 2024 04:52:57 GMT
Received: from hu-adisi-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 25 Mar 2024 21:52:55 -0700
From: Aditya Kumar Singh <quic_adisi@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>, Sriram R <quic_srirrama@quicinc.com>,
        Aditya Kumar Singh <quic_adisi@quicinc.com>
Subject: [PATCH] wifi: mac80211: handle link ID during management Tx
Date: Tue, 26 Mar 2024 10:22:42 +0530
Message-ID: <20240326045242.3190611-1-quic_adisi@quicinc.com>
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
X-Proofpoint-GUID: G8QFghb8geyfCvAkiR2g-OZO_WiIpSev
X-Proofpoint-ORIG-GUID: G8QFghb8geyfCvAkiR2g-OZO_WiIpSev
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-26_02,2024-03-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 malwarescore=0
 impostorscore=0 priorityscore=1501 phishscore=0 clxscore=1015
 lowpriorityscore=0 adultscore=0 spamscore=0 suspectscore=0 mlxlogscore=577
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403210001 definitions=main-2403260028

From: Sriram R <quic_srirrama@quicinc.com>

During management Tx, when source address is same as the link conf's
address and even when userspace requested Tx on a specific link, link ID
is not set which leads to dropping of the frame later.

Add changes to use the same link id and set it if the link bss is matching
the requested channel.

Signed-off-by: Sriram R <quic_srirrama@quicinc.com>
Signed-off-by: Aditya Kumar Singh <quic_adisi@quicinc.com>
---
 net/mac80211/offchannel.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/net/mac80211/offchannel.c b/net/mac80211/offchannel.c
index 221695d841fd..65e1e9e971fd 100644
--- a/net/mac80211/offchannel.c
+++ b/net/mac80211/offchannel.c
@@ -897,8 +897,18 @@ int ieee80211_mgmt_tx(struct wiphy *wiphy, struct wireless_dev *wdev,
 				break;
 			}
 
-			if (ether_addr_equal(conf->addr, mgmt->sa))
+			if (ether_addr_equal(conf->addr, mgmt->sa)) {
+				/* If userspace requested Tx on a specific link
+				 * use the same link id if the link bss is matching
+				 * the requested chan.
+				 */
+				if (sdata->vif.valid_links &&
+				    params->link_id >= 0 && params->link_id == i &&
+				    params->chan == chanctx_conf->def.chan)
+					link_id = i;
+
 				break;
+			}
 
 			chanctx_conf = NULL;
 		}
-- 
2.25.1


