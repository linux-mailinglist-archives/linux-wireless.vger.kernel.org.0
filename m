Return-Path: <linux-wireless+bounces-6062-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8903489E9B4
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Apr 2024 07:27:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 024631F24C94
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Apr 2024 05:27:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF3B312E70;
	Wed, 10 Apr 2024 05:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ZMqYE5kI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F9DE20326
	for <linux-wireless@vger.kernel.org>; Wed, 10 Apr 2024 05:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712726848; cv=none; b=cftF+CbOG1ID8+dzrTEACfWufwLW0EIdTiMzBmZISVdVhqeIUta0zFQWHWgiE+BrHZedLnKjh6bEwCpKECZ8D/tezUhPnrTvnFKBuDj2qOi93z2TjGCsumROoJcUa1rs2oLH/n/qU2pNlCvRScrJbcBxpyvaFYC+Uzgwelchjg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712726848; c=relaxed/simple;
	bh=ROV3LK2VMoWYtCH4AZwNIlW9xgzdb9nTkXUKOIlwxpo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cINel3NbUGV7tpPfRG9qVsum9MNZwr8+Xs+9tEuXdTKgE03sZLJwfj1HlcokgDAdm3lDq2wVQXmHRKOVqiT7PNs9opbO8XvB7tFm8OnvvqSxjCGLqymYXnng8eQlee4ELQZiQPaMtG45qePb23UB5MOgplAf+7U7Zhc+985+TLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ZMqYE5kI; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43A4ZaFr002260;
	Wed, 10 Apr 2024 05:27:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=cFc/TYl
	4C6J0PUylXhWx0DT6OdqsKBIE/Wd2PiUKI+I=; b=ZMqYE5kIOh/+5kubUPxm9vp
	YhbQYNkvSq3B/yAAWUPAaK1DmdJlvXhMhSL7H8eRI9awPvP6nHvbiXrwkzL+AN04
	GSaYBxH9UODYglEUWbWdeL6+VhjNxiXIvDOSv4hNKTt7DGihxzMCv04MFzoyG3/e
	4QagU3TUa9MDxkJWgXSoprbIhdtOemLrlz8rCT/rHVCeWLARN8cp+OaRzKSVKvdA
	v3IuRYztPkqG/VYnR6X9APpVH4mv8Db69NZyqwc0ldml2PAxBqZA7mvxKVSgrlnV
	byKPdj0k2vWQYCub3jhremvMQC55xp9T6l9gzt4jleS+aPmWXj3aZgc7HAO3Bow=
	=
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xdkv8g9ke-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Apr 2024 05:27:23 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43A5RMrB005416
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Apr 2024 05:27:22 GMT
Received: from hu-adisi-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 9 Apr 2024 22:27:20 -0700
From: Aditya Kumar Singh <quic_adisi@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>, Sriram R <quic_srirrama@quicinc.com>,
        Aditya Kumar Singh <quic_adisi@quicinc.com>
Subject: [PATCH v2] wifi: mac80211: handle link ID during management Tx
Date: Wed, 10 Apr 2024 10:57:05 +0530
Message-ID: <20240410052705.169865-1-quic_adisi@quicinc.com>
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
X-Proofpoint-ORIG-GUID: FcjHa-uld-hXlGlanaAQa6SgDISKvg1y
X-Proofpoint-GUID: FcjHa-uld-hXlGlanaAQa6SgDISKvg1y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-09_12,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 clxscore=1015 suspectscore=0 priorityscore=1501 spamscore=0 phishscore=0
 malwarescore=0 lowpriorityscore=0 mlxlogscore=804 impostorscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404100038

From: Sriram R <quic_srirrama@quicinc.com>

During management Tx, when source address is same as one of the link conf's
address and even when userspace requested Tx on a specific link, link ID
is not set. Now if MLD address is also same as that of the link address,
then mac80211 fills link as unspecified. Due to this, later in driver, the
channel context is fetched from vif->bss_conf instead of link's conf which
in turn gives channel as NULL and hence as a result, the packet is
ultimately dropped.

Add changes to use the same link id and set it if the link bss is matching
the requested channel. This will prevent the packet from getting dropped.

Signed-off-by: Sriram R <quic_srirrama@quicinc.com>
Signed-off-by: Aditya Kumar Singh <quic_adisi@quicinc.com>
---
v2: rephrased commit message to describe how packet is getting dropped.

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

base-commit: a35b36e6ee5dcf323d846ec3881159e4af90c9b4
-- 
2.25.1


