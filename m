Return-Path: <linux-wireless+bounces-17257-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 465C6A08008
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Jan 2025 19:43:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C9651654CE
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Jan 2025 18:43:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F8D618A6AB;
	Thu,  9 Jan 2025 18:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="aHhys1zn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6F3C13B2B8;
	Thu,  9 Jan 2025 18:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736448210; cv=none; b=EUUxdJ/nVRoH6JOBNejUI9nDc9zuvk0GstRO0DlTJNvfuJBRagM27xwL3JRywEoYSF+/uv3Y3qwchsZ0nS0pGBZHPI6A7qTrcgLdS4PNuff2shUfKMWYmjY3G74hqCxO1cMaqbDISPWmokSeuWIJEK0vpOsTiRiDvCdAtZ+igMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736448210; c=relaxed/simple;
	bh=BZXYms+g/BqvcZ426737oC/VLGSVs8msh8+OFUMjPV0=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=ES0JOe9K+1IUxEPKszZt6OGXo3hb5mWonjdFMT3VoV/S6Va14GpVnAOCiDhXe1JrlcqydweDDs+JEbLo6cV9SeExuGHOxSkaOIL836EbdrZL+GvRcP+QbDn97dSBR6B9gCAUAGMg2R8GS5YPJUbdwCo6D9KurFEdP9lbnw+sXa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=aHhys1zn; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 509Bcrle000581;
	Thu, 9 Jan 2025 18:43:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=6fUGQgLlJS6LEL9AOOUpxI
	sT5RuD8FZlNiVYfm22PsE=; b=aHhys1znKW7kUPilbjR/baHgM2iT0b6Ieh7LR5
	x+tmOlcpqi7QO7eeOdQAwL1HeU+RMzQWtUVcQgVD2JzCecoRfgjYpiBvTa1mz8K5
	sEtcXAFzilTSsQPquo7gSqucoBlNzGClZ0z7jJFnisPTTRvi/eZHOLWfvI4z6EtG
	SODfmnmlr4diQ/Ttrh8hyctBp939+GAthsP1GnNumnXlVZzyyLgo8HZKijYye53A
	5dG2oTFDFo0ML2mOc9GoUovqXmMlf/YJoIvwpozkvYCn4VF8S136CsHpLlhQHehJ
	c4ezGI3DgNbW6XhbImswvgIIpIY3SOJYahmGot/JIp9yc6Kg==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 442drws1et-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Jan 2025 18:43:22 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 509IhLm3018523
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 9 Jan 2025 18:43:21 GMT
Received: from hu-adisi-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 9 Jan 2025 10:43:19 -0800
From: Aditya Kumar Singh <quic_adisi@quicinc.com>
Subject: [PATCH 0/2] wifi: ath12k: handle
 ath12k_mac_ieee80211_sta_bw_to_wmi() for link sta
Date: Fri, 10 Jan 2025 00:13:11 +0530
Message-ID: <20250110-fix_link_sta_bandwidth_update-v1-0-61b6f3ef2ea3@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAL8YgGcC/x3MSQqEMBBA0atIrTsQIw7xKo2E0pRadBMliQOId
 ze4fIv/LwjkmQK02QWedg68uIT8k8Ewo5tIsE0GJVUpc6nFyKf5s/uZENH06OzBNs5mWy1GEsW
 Ig260knVVQXqsnlLw/r/dfT+gMXMEbwAAAA==
X-Change-ID: 20250109-fix_link_sta_bandwidth_update-3fac98920766
To: Kalle Valo <kvalo@kernel.org>, Jeff Johnson <jjohnson@kernel.org>
CC: <linux-wireless@vger.kernel.org>, <ath12k@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Aditya Kumar Singh <quic_adisi@quicinc.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: eInbEW924o4WpgTt0lA3ANf5wbMQBMX8
X-Proofpoint-GUID: eInbEW924o4WpgTt0lA3ANf5wbMQBMX8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 malwarescore=0
 impostorscore=0 adultscore=0 mlxscore=0 mlxlogscore=460 spamscore=0
 clxscore=1015 phishscore=0 priorityscore=1501 lowpriorityscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501090148

Currently ath12k_mac_ieee80211_sta_bw_to_wmi() handles the bandwidth from
sta's deflink member. This works only for non-ML station. Now that MLO
support is there, extend this function to use link sta instead of deflink.

Patch 1 relocates ath12k_mac_ieee80211_sta_bw_to_wmi() so that it can be
called from a function used in Patch 2. No functionality change.

Patch 2 actually extends the ath12k_mac_ieee80211_sta_bw_to_wmi() to handle
link sta.

---
Aditya Kumar Singh (2):
      wifi: ath12k: relocate ath12k_mac_ieee80211_sta_bw_to_wmi()
      wifi: ath12k: handle ath12k_mac_ieee80211_sta_bw_to_wmi() for link sta

 drivers/net/wireless/ath/ath12k/mac.c | 79 +++++++++++++++++------------------
 1 file changed, 38 insertions(+), 41 deletions(-)
---
base-commit: dbe50a7420e22954c747e79e72df2750d795ea77
change-id: 20250109-fix_link_sta_bandwidth_update-3fac98920766


