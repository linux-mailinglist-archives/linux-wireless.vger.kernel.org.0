Return-Path: <linux-wireless+bounces-18398-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CF27A26DA3
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Feb 2025 09:50:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A68621644D7
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Feb 2025 08:50:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24908206F38;
	Tue,  4 Feb 2025 08:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Awcf943A"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 198E3206F18
	for <linux-wireless@vger.kernel.org>; Tue,  4 Feb 2025 08:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738659044; cv=none; b=N6llEhQahk7Hq+JZ9cz705C1LjY+ZxGcjOyOvzlmY4R/ZwFpnN5CaLnDEFbDIXauez6DhFgm91PkpV/Yaqs1o9eioEsyAtRVpvzJXGmst8NUJmFbOa833lmPEDoylC9gKYiupgxMS/oukZYF09BxQPup2yNmLjQt4AvxQHRR2j4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738659044; c=relaxed/simple;
	bh=wldRjsZuSQPpMdpUWSDK8c+Yai2Bn4SEvTLCfQvpWAA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GU5wxo9p1+9AXEfkbFlUBe4KOVnKSAmDvWMee8VYme1tGfnrcwDsIMMX9o5HvQ+bswS+oRogAMxUz5qrMZGtNpOCP0i0AkVsxPqXr2DBkpkj0ucnx+gOESW7i3OiaTEUd8oF3h9q3N5SjkIAFVakN+qoUpAL8LHoqbcZc/D33jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Awcf943A; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5141BlsY021352;
	Tue, 4 Feb 2025 08:50:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=d7npWZfBlG9ja8ph6s6JVU
	gPfvWJ5qQU+0DkI3r3a/8=; b=Awcf943AF+O1U44hjAV4tEOc3+q5c6tyblMcj6
	z34l2BDZ6NP4FtY1/YgJ6C6M7uvbFFjgftzMxXav1gCQYdkSzSrThrWAJot+Uz0K
	Mv8LKPrUDe71GUl1Suso9x8GHK83P2Op7dNqLDNqnMoIIJhBTsco7xQNlXf108Hb
	e26mSHYSsde/6wA1Y/owh06EL31ALxpVFGoMWuolZRI6yQiKslG7fDCvyyNd0gDl
	LuQcra7ml5VPKQkUQul9Xfhm6MdUMT8lp+SKlXqwn6VU5ttgFUa/LiZBzgUzxzke
	6Xa8Dzv7jxU/DamkF12c3tOAdZtctPtuKt8CNyzPYAMzpujQ==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44k911gu9c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Feb 2025 08:50:35 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 5148oYfr021266
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 4 Feb 2025 08:50:34 GMT
Received: from hu-rdevanat-blr.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 4 Feb 2025 00:50:32 -0800
From: Roopni Devanathan <quic_rdevanat@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Roopni Devanathan
	<quic_rdevanat@quicinc.com>
Subject: [PATCH 0/2] iw: Add Support to Set per-radio attributes for each Radio
Date: Tue, 4 Feb 2025 14:19:58 +0530
Message-ID: <20250204085000.3809769-1-quic_rdevanat@quicinc.com>
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
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: fE8iBFR_NgBlQAItooUO34WWsF5OlPTJ
X-Proofpoint-ORIG-GUID: fE8iBFR_NgBlQAItooUO34WWsF5OlPTJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-04_04,2025-01-31_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 spamscore=0 mlxscore=0 phishscore=0 bulkscore=0 mlxlogscore=581
 adultscore=0 malwarescore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502040071

Currently, setting per-radio attribute like RTS threshold and Tx power,
changes the threshold and power for all radios in a wiphy. But, in a
multi-radio wiphy, different radios can have different attribute value
requirements. Modify the iw command to handle per-radio attributes for
RTS threshold and Tx power.

Rameshkumar Sundaram (1):
  iw: Add support to set per-radio Tx power config in multi-radio wiphy

Roopni Devanathan (1):
  iw: Add support to set per-radio RTS threshold in multi-radio wiphy

 info.c |  4 +++
 phy.c  | 80 ++++++++++++++++++++++++++++++++++++++++++++++++++--------
 2 files changed, 73 insertions(+), 11 deletions(-)


base-commit: a0a7ddef29fc412cee7e3ca027905218b145a40f
-- 
2.34.1


