Return-Path: <linux-wireless+bounces-17156-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8830EA0489C
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Jan 2025 18:51:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC85C3A63AA
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Jan 2025 17:51:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 226781898ED;
	Tue,  7 Jan 2025 17:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ppQxBQyu"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DED115D1
	for <linux-wireless@vger.kernel.org>; Tue,  7 Jan 2025 17:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736272308; cv=none; b=RDF5ju4ECdG4I3SHh5lhSxC0nugoZDmhAVa5bGwEHLLY7+mV3uW51UpS8RBGxrSe7NY07Yqnqsh9bzeuhashdoCWSpKZ62W+EXyYyG8KfJ4PH3WsXFheOYoEgAicqGL5NrJQZJ2yqK7ZUnMQF3xxr/ErsuA1zrjx+OgwgqLyeRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736272308; c=relaxed/simple;
	bh=0AP+pb5CoTkC4+mnv8ojLh6BURLqjcibBG+frOg0Udo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=p1rRbYB7anIulwUZbhm7zWpzjDezYURHPwyh5CF0jJzYLhQQQXQzR4ysoib45tuUggFPkXYXe+Gbrm1CvdlURrSoztzXj3WBR9yJhQ26hu7FLO9qWiQJb9f5V47SqqEK3q3+qYtR7zrd8314yPsOjVkavhtfO7yckP8EU8DWqy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ppQxBQyu; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 507AfeWc025740;
	Tue, 7 Jan 2025 17:51:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=SKB2IZnikxWa6Af4Eg/dAJ
	JHvvzOv7t/0PN1M2lM178=; b=ppQxBQyue04pnYCPb+P+0JFU08UledLHaXZD+c
	DeGt85jJ4M4m0XoU2C2EMqy242o/6YIpXT60A7bKToqIpVdMPr22idXmfDKpmOOK
	kiDe9oQ/vyZHA4ynD1KIEFK0RrLC1O9lPMk+mczpLidf43t3iUwqD7CToqwBvw5s
	vdYiLG+jTCFhfw+p73wJCLYVV5pgH82+BpvjTbQYnTOlKsyMMmbtvudFl2uc8uXO
	Y+HBZI2vM4JniZIPmB533dhBqpvjWYx7Emd8cRApN05MzaQ1DdqJhPxGBiwSMMei
	HwV2QwdIIirFYcRFn0mF0Nq7l0PUvilwSom1RUacdhbF4uRQ==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4412r7937w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Jan 2025 17:51:35 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 507HpYdr021767
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 7 Jan 2025 17:51:34 GMT
Received: from hu-ramess-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 7 Jan 2025 09:51:32 -0800
From: Rameshkumar Sundaram <quic_ramess@quicinc.com>
To: <johannes@sipsolutions.net>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Rameshkumar Sundaram
	<quic_ramess@quicinc.com>
Subject: [PATCH 0/3]  wifi: cfg80211: update EML capabilities of an ML Station
Date: Tue, 7 Jan 2025 23:17:59 +0530
Message-ID: <20250107174802.1793252-1-quic_ramess@quicinc.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: XYsHYooNRLkTtrr7X7NitEZMTWIVInoi
X-Proofpoint-ORIG-GUID: XYsHYooNRLkTtrr7X7NitEZMTWIVInoi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=749 malwarescore=0 mlxscore=0 clxscore=1015 spamscore=0
 suspectscore=0 phishscore=0 adultscore=0 impostorscore=0
 priorityscore=1501 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2411120000 definitions=main-2501070148

When EMLSR is enabled for an ML association, the EML capabilities
advertised by the ML Station needs to be updated to drivers in order to
trigger EMLSR operation.
Add support to fetch EML capabilities advertised by ML station and
cache it in ieee80211_sta data structure so that drivers can use them
whenever required.

Ramasamy Kaliappan (3):
  wifi: cfg80211: Add support to get EMLSR capabilities of non-AP MLD
  wifi: mac80211: update ML STA with EML capabilities
  wifi: ath12k: update EMLSR capabilities of ML Station

 drivers/net/wireless/ath/ath12k/mac.c |  3 +-
 drivers/net/wireless/ath/ath12k/wmi.c | 81 ++++++++++++++++++++++++++-
 drivers/net/wireless/ath/ath12k/wmi.h |  3 +-
 include/net/cfg80211.h                |  2 +
 include/net/mac80211.h                |  2 +
 net/mac80211/cfg.c                    |  3 +
 net/wireless/nl80211.c                |  8 +++
 7 files changed, 98 insertions(+), 4 deletions(-)


base-commit: 09fa3b6974a1245ddd0751747609431494ba5b4f
-- 
2.34.1


