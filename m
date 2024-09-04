Return-Path: <linux-wireless+bounces-12447-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7692696AEE4
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Sep 2024 05:09:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7F8A1C2139B
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Sep 2024 03:09:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1152D4778C;
	Wed,  4 Sep 2024 03:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="pWCndNqr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6844D4317B
	for <linux-wireless@vger.kernel.org>; Wed,  4 Sep 2024 03:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725419385; cv=none; b=rJW/82hw0ih2+G7504F39kO2+VWoiPaVv/fY9c/Nh3nmVZFW7i8KsCs/WtPD8rTc2NxE45mLdfuVXhi1HD5bOKU/yKu8bcAv0S6HjkICSPIqOeHwDrTg+mFlBprUvEfF71gNxtpb5mpGIhIQW4oZmoeWIXN7Jvg4i92Fb6c4Cko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725419385; c=relaxed/simple;
	bh=iSt0RWEQKxe1mf7QTrt4Wm3UZuORK4qyyHmrZQKodwQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cvkGJ/AguFXDHcPA2qJOBIzejkT1pPBNPKyiW9Or8ProkZ9rKOWJH7IQYevAGpdqN5USuUpt634xJlkLXvZRe8wvyolihvgcPJG8po2VZrFohP3697YAnfJlfLzlk7kr0XMPK0wV2lweD7zmI1CqCoG6vhR9YwX3zWiSFICTtII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=pWCndNqr; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 483MVCqx032362;
	Wed, 4 Sep 2024 03:09:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	PwwxI+3roeI/0Z2Edm1fe0eDnycl7rcQIRBWymTV+M4=; b=pWCndNqrpY3IPojM
	iuEVCRjsmMIL0p7XIwAuBPIK8WMLPYrwtTmc19BhMGuVkvqmI4D3Z6ZFzff0xyFC
	PB59wrfORbwgnYhF/cF5z255ss/RXfYYhK36WmUDorFSx/VmzTavSmHh+SmNEhS0
	s7NJog/R8dv8zMbmcIKCpoA2T31LALxC8AhsMw7OzW/hgiFXzcpMIS9vUXtACZ0+
	UvuFNdg9T++x96yV5+wOrY2OZUWWqegUw/QHS3zjXyEzHGg4IPTS4eqHSmUz9A82
	bzGcj0FJlldCgHsGsGEz9/AIQh/3g+RwBKFqeDhiQeVuvrO2ex4oGvYj/64KZ1b2
	BC7IBg==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41drqe3msf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Sep 2024 03:09:38 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 48439bqT004619
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 4 Sep 2024 03:09:37 GMT
Received: from hu-vjakkam-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 3 Sep 2024 20:09:35 -0700
From: Veerendranath Jakkam <quic_vjakkam@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>, <quic_vjakkam@quicinc.com>
Subject: [PATCH v2 1/3] wifi: cfg80211: make BSS source types public
Date: Wed, 4 Sep 2024 08:39:15 +0530
Message-ID: <20240904030917.3602369-2-quic_vjakkam@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240904030917.3602369-1-quic_vjakkam@quicinc.com>
References: <20240904030917.3602369-1-quic_vjakkam@quicinc.com>
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
X-Proofpoint-GUID: HpbgjJZgsghNNcSY0maNV8HkYdtSq8Zc
X-Proofpoint-ORIG-GUID: HpbgjJZgsghNNcSY0maNV8HkYdtSq8Zc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-04_01,2024-09-03_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0 mlxscore=0
 phishscore=0 adultscore=0 suspectscore=0 priorityscore=1501 clxscore=1015
 impostorscore=0 spamscore=0 mlxlogscore=708 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2409040021

Define public enum with BSS source types in core.h. Upcoming patches
need this to store BSS source type in struct cfg80211_internal_bss.

Signed-off-by: Veerendranath Jakkam <quic_vjakkam@quicinc.com>
---
 net/wireless/core.h | 6 ++++++
 net/wireless/scan.c | 6 +-----
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/net/wireless/core.h b/net/wireless/core.h
index 41c8c0e3ba2e..eace1800f5de 100644
--- a/net/wireless/core.h
+++ b/net/wireless/core.h
@@ -170,6 +170,12 @@ static inline int for_each_rdev_check_rtnl(void)
 	if (for_each_rdev_check_rtnl()) {} else				\
 		list_for_each_entry(rdev, &cfg80211_rdev_list, list)
 
+enum bss_source_type {
+	BSS_SOURCE_DIRECT = 0,
+	BSS_SOURCE_MBSSID,
+	BSS_SOURCE_STA_PROFILE,
+};
+
 struct cfg80211_internal_bss {
 	struct list_head list;
 	struct list_head hidden_list;
diff --git a/net/wireless/scan.c b/net/wireless/scan.c
index d99319d82205..38541eba386c 100644
--- a/net/wireless/scan.c
+++ b/net/wireless/scan.c
@@ -2149,11 +2149,7 @@ struct cfg80211_inform_single_bss_data {
 	const u8 *ie;
 	size_t ielen;
 
-	enum {
-		BSS_SOURCE_DIRECT = 0,
-		BSS_SOURCE_MBSSID,
-		BSS_SOURCE_STA_PROFILE,
-	} bss_source;
+	enum bss_source_type bss_source;
 	/* Set if reporting bss_source != BSS_SOURCE_DIRECT */
 	struct cfg80211_bss *source_bss;
 	u8 max_bssid_indicator;
-- 
2.34.1


