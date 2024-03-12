Return-Path: <linux-wireless+bounces-4587-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2726D878E10
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Mar 2024 06:01:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB1A7B20CEC
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Mar 2024 05:01:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFA88182CF;
	Tue, 12 Mar 2024 05:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="YPZW6JD+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B3961804C
	for <linux-wireless@vger.kernel.org>; Tue, 12 Mar 2024 05:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710219706; cv=none; b=fFdA68fvGd0Cvc+3q6kw3I1EDdB5cAkwcJHkxM+3krq6DqaSHAtBnYwGnfxUUIZ7GKH/x1P8+iJTLUtC9zmrtLNigijyE0BtbmfoNahUY2h4WrWoX8GMBnkNThDDeWP7R1Q6VSTx3sb2b3qZUoI5evRTwgwgcdZgcg89YyeYlv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710219706; c=relaxed/simple;
	bh=H1bUD+azuS0Amp2OcTHz7LmOuMnGSDe6hSWsHayoFQQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fO7RprhU2rwYaZ6CAaZ0p/A2s8RDG9cKWF2ZG1Hs78LI7vdvegaXxMnIN6ojpC4oJQhnfy3llPe1vY7C61RmKRYC8kVbQVzSpQerllV77aLdWuoqnTXyUAghKxiI2iSGAj8YCIjWC23O2Yi9IuEHj8r5FRkEYU31dyg0JxuUH2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=YPZW6JD+; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42C4lnH3008372;
	Tue, 12 Mar 2024 05:00:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=jKsGwHZ
	3T2U68FtpKdj83eKOSUbUBd7Six3XGd7umtg=; b=YPZW6JD+Ne9Y58+uN/tWKLq
	U9RofJYOoSxppqDSYLPaQcM1z80aADHNdstz7FdcMoXeM4Zk5ZuPYLlfe9+2knOW
	EVG0ScLzlN/2gdOMqq28F8jBndFMZCHX+TKBxfTxQUYxPmQWDKtNyGoBZJxMshhx
	0iYGV4Lc/RqR1NyWGD98rkxjaGqLHyVr0BvQetBNNpNiQ57tuWJbOe2OWrDcwV6W
	rkWZy27xaVq8A7CYwpRFAsRg0k0MdI7uApgUUISVeAi3RwoN+kb9knZ0x+oDv69+
	X18PtRfgAX3JbLVUrR+uX3ZjVXfoWf+BcgCHKdVfd3Umzr+Y2pf/Dyea4AL4snw=
	=
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wtckh0d8q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Mar 2024 05:00:59 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42C50xRT032032
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Mar 2024 05:00:59 GMT
Received: from Mayan.qca.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 11 Mar 2024 22:00:57 -0700
From: Kang Yang <quic_kangyang@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <quic_kangyang@quicinc.com>
Subject: [PATCH 0/2] wifi: ath12k: dynamically update puncturing bitmap
Date: Tue, 12 Mar 2024 12:59:45 +0800
Message-ID: <20240312045947.576231-1-quic_kangyang@quicinc.com>
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
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Pq_4p4v1b-xah5nhuaYFHtjPeWOkWjoy
X-Proofpoint-GUID: Pq_4p4v1b-xah5nhuaYFHtjPeWOkWjoy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-12_04,2024-03-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=562
 impostorscore=0 mlxscore=0 lowpriorityscore=0 priorityscore=1501
 bulkscore=0 clxscore=1015 suspectscore=0 spamscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403120036

Dynamically update puncturing bitmap.

Kang Yang (2):
  wifi: mac80211: supplement parsing of puncturing bitmap
  wifi: ath12k: dynamically update puncturing bitmap

 drivers/net/wireless/ath/ath12k/mac.c | 58 +++++++++++++++++++++++++++
 drivers/net/wireless/ath/ath12k/wmi.h | 16 ++++++++
 net/mac80211/spectmgmt.c              |  4 ++
 net/mac80211/util.c                   |  2 +
 4 files changed, 80 insertions(+)


base-commit: ffd4e60352172cc167ff74e8bfd8a331a5830013
-- 
2.34.1


