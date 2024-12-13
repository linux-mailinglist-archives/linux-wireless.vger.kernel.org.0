Return-Path: <linux-wireless+bounces-16372-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FDA79F0BF4
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Dec 2024 13:12:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CC03167EC8
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Dec 2024 12:12:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71BA61DE3BB;
	Fri, 13 Dec 2024 12:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="KFx2usbE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC620364D6
	for <linux-wireless@vger.kernel.org>; Fri, 13 Dec 2024 12:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734091924; cv=none; b=HHh+GbePYcPN3Gko6lhcA9sY0F7hs9TfixIf24pE6ahLpZP54ObYzuEhtmHmqW7mXs1NijSk5NSmlxFzOcLowg4kO5/Q4G27nNpqUVE91C8Zbvp0b+6ZsoUFQLq9YuU4tI4gHU05JLGRutr/CzP6SE1svB4g/+ErUAygeKSJUdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734091924; c=relaxed/simple;
	bh=lliztgWVjN/I1LimOcyJbuLcEnKXvN9SxkzKgquunqo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=h6h7/LkV4dFOgTp4KdXD6DXaUvCdoVzOEIQsv/4R+MwWaZxQ88yODtvaXfckiTsy67bUpsujFigV0DvyxIDDZt0HCossnZoPeKDnAT/hRzfkvTd+mQk7Y6IYYqCT2lCszbESDegqmTjUJxLo9fHQS0mCARVag20cTIfa4n78VT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=KFx2usbE; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BD3lcfc002014;
	Fri, 13 Dec 2024 12:11:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=SlZy57Lyxs4zG+n5z/9HSt
	QMCXEJLzeKXgcWWQkovpc=; b=KFx2usbEgWvR0lPmZDrK4YR4CGBMJbbPE7DeoU
	hJYHexJgPxLhiqvSz07zQDKho2O0ePgFcIdLTL3Y8Orw9+M6wiOJ638/D6QSHYxQ
	rztUxD/Q+TUpWFL/2YGqP23u58eV895lfgeABzx8WFV/iOTprn5j6VX5nPdRm+Hq
	fcXQmcQwEJQ0tNj2LkHVNnqKAhOIZzAvcTRb56VBZiCk+NGN6uwk3POSDNkmx7FG
	hv/GpXf74+wijSjq+qzPM4E8+Jy9o3xLxQCp4tI+QBD/nlZJ9PSgFDeJ/RmWn75m
	vjIuVI75ckqRN/I6wAf7jtbPLGDFBuDfXcdgbOPPwm7wSOqA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43fd40pa1r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Dec 2024 12:11:58 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4BDCBvZc024839
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Dec 2024 12:11:57 GMT
Received: from hu-vjakkam-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 13 Dec 2024 04:11:56 -0800
From: Veerendranath Jakkam <quic_vjakkam@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>, <quic_vjakkam@quicinc.com>
Subject: [PATCH] wifi: ieee80211: update Indoor AFC standard power type definition
Date: Fri, 13 Dec 2024 17:41:46 +0530
Message-ID: <20241213121146.2398269-1-quic_vjakkam@quicinc.com>
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
X-Proofpoint-GUID: DpXtlyRAigr0nkmjzm_qSRpOwE8AEmPF
X-Proofpoint-ORIG-GUID: DpXtlyRAigr0nkmjzm_qSRpOwE8AEmPF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 spamscore=0
 suspectscore=0 impostorscore=0 phishscore=0 clxscore=1011 bulkscore=0
 lowpriorityscore=0 mlxlogscore=999 priorityscore=1501 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412130085

Update 6 GHz regulatory info subfield mask and Indoor AFC standard power
type definitions to align with spec changes introduced in the Draft
P802.11Revme_D4.2, Figure 9-896 and Table E-13.

Signed-off-by: Veerendranath Jakkam <quic_vjakkam@quicinc.com>
---
 include/linux/ieee80211.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/ieee80211.h b/include/linux/ieee80211.h
index 05dedc45505c..2091af5e8b8c 100644
--- a/include/linux/ieee80211.h
+++ b/include/linux/ieee80211.h
@@ -2764,7 +2764,7 @@ static inline bool ieee80211_he_capa_size_ok(const u8 *data, u8 len)
 #define IEEE80211_6GHZ_CTRL_REG_SP_AP		1
 #define IEEE80211_6GHZ_CTRL_REG_VLP_AP		2
 #define IEEE80211_6GHZ_CTRL_REG_INDOOR_LPI_AP	3
-#define IEEE80211_6GHZ_CTRL_REG_INDOOR_SP_AP	4
+#define IEEE80211_6GHZ_CTRL_REG_INDOOR_SP_AP	8
 
 /**
  * struct ieee80211_he_6ghz_oper - HE 6 GHz operation Information field
@@ -2782,7 +2782,7 @@ struct ieee80211_he_6ghz_oper {
 #define		IEEE80211_HE_6GHZ_OPER_CTRL_CHANWIDTH_80MHZ	2
 #define		IEEE80211_HE_6GHZ_OPER_CTRL_CHANWIDTH_160MHZ	3
 #define IEEE80211_HE_6GHZ_OPER_CTRL_DUP_BEACON	0x4
-#define IEEE80211_HE_6GHZ_OPER_CTRL_REG_INFO	0x38
+#define IEEE80211_HE_6GHZ_OPER_CTRL_REG_INFO	0x78
 	u8 control;
 	u8 ccfs0;
 	u8 ccfs1;
-- 
2.34.1


