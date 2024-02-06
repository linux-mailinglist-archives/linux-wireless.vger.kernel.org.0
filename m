Return-Path: <linux-wireless+bounces-3199-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 055B384B0FF
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Feb 2024 10:22:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 89E27B24B86
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Feb 2024 09:22:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99B98481DB;
	Tue,  6 Feb 2024 09:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="KD+mTHqN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBD7712E1C7
	for <linux-wireless@vger.kernel.org>; Tue,  6 Feb 2024 09:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707211315; cv=none; b=RXHykjdKxgyvJIDWf2wm+bcuQy+Ke8LnjI/JFKA13jr6lJy3Tg3T/JT3ViWjv8hDN/IQlxDqSjbBx5xRA1liAyucXxF01HMzMWoi5Jnk3Eir/y1VBnPB581+GdYzlJJ6UiW7XkTXWIVCcchaqaVyDxsy4GmnhPEe8fj6HAy5pLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707211315; c=relaxed/simple;
	bh=pVSTBBSBSoq1cYJwGfhEvORJB+VSh7i0jFjv5uP80ss=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DsbnLsRmyoKkz1LJIQNFcmSsC5MOtEWGIQNvIOqnkHOMjbHMUOOfZlf0SfkWw1o8zN1LZkeXoxRLvj5igXeJa0eXiKidJ3TVrTvuxlnDJwrk7jTwIixP4XMxIWUhjchzilgkUqd7KLJGOUR42Nv6D7YUmLtSmuDCHIxdEDvVgbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=KD+mTHqN; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4165YHEb001034;
	Tue, 6 Feb 2024 09:21:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=bl7DJUB
	CmxHyqE1YURLVMxqoG8rrIpTmnmFABIjppEg=; b=KD+mTHqNv6iVJpThG0Ddg4W
	01DQCmmEV+3v1VbNfQesbPOWYHJboVFRhfrBisVJDNdicsVV1vdWchS13hfcFu+7
	qrd8fXoMEACmcHXKS8iDLC1noVzeNqSUAxC73gmQv66rL9g09DMaq/JBQQw9jtVs
	ickRvoOXE5zu3gMS5qwGZRhj8fcVMO1//1oeTLFearx14VHLQZKXXduARfDJU6I0
	cuPB5bQuktZIW7XfOd0+b6lI4sOdrFiR38eiWwl6N3/HJmJJ0IbYQMXj8I0MgBaW
	tKdYD2NAVKGPMylh4Cpv9UTv060Egjd5ClY1pza50YbDYvBeJgEOAFAVJlEi93w=
	=
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w399es20r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 06 Feb 2024 09:21:36 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4169LZ8e020750
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 6 Feb 2024 09:21:35 GMT
Received: from hu-ramess-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 6 Feb 2024 01:21:34 -0800
From: Rameshkumar Sundaram <quic_ramess@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, Sriram R <quic_srirrama@quicinc.com>
Subject: [PATCH v2 00/12] wifi: ath12k: Add single wiphy support
Date: Tue, 6 Feb 2024 14:49:42 +0530
Message-ID: <20240206091954.4144454-1-quic_ramess@quicinc.com>
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
X-Proofpoint-GUID: fA9W5gjzpkHqHo1CoiAMrmjCqikW014W
X-Proofpoint-ORIG-GUID: fA9W5gjzpkHqHo1CoiAMrmjCqikW014W
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-06_02,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=591
 adultscore=0 spamscore=0 clxscore=1011 suspectscore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402060064

From: Sriram R <quic_srirrama@quicinc.com>

With the introduction of Multi Link Operation (MLO) support in
IEEE802.11be, each EHT AP/non AP interface is capable of
operating with multiple radio links.

cfg80211/mac80211 expects drivers to abstract the communication
between such Multi Link HW and mac80211/cfg80211 since it depends
on different driver/HW implementation. Hence the single wiphy
abstraction with changes in datastructures were introduced in
"wifi: ath12k: Introduce hw abstraction"

This patchset extends the implementation to allow combination
of multiple underlying radios into a single composite hw/wiphy
for registration. Since now multiple radios are represented by
a single wiphy, changes are required in various mac ops that the
driver supports since the driver now needs to learn on how to tunnel
various mac ops properly to a specific radio.

This patchset covers the basic mac80211 ops for an interface bringup
and operation.

Note:
Monitor and hw reconfig support for Single Wiphy will be done in future
patchsets.

This patchset is dependent on "[0/3] wifi: ath12k: Refactor the hardware recovery procedures"

---
 v2:
  - Rebased on ToT and dependent patchset


Karthikeyan Periyasamy (1):
  wifi: ath12k: add multiple radio support in a single MAC HW
    un/register

Sriram R (11):
  wifi: ath12k: Modify add and remove chanctx ops for single wiphy
    support
  wifi: ath12k: modify ath12k mac start/stop ops for single wiphy
  wifi: ath12k: vdev statemachine changes for single wiphy
  wifi: ath12k: scan statemachine changes for single wiphy
  wifi: ath12k: fetch correct radio based on vdev status
  wifi: ath12k: Cache vdev configs before vdev create
  wifi: ath12k: Add additional checks for vif and sta iterators
  wifi: ath12k: modify regulatory support for single wiphy architecture
  wifi: ath12k: Modify set and get antenna mac ops for single wiphy
  wifi: ath12k: Modify rts threshold mac op for single wiphy
  wifi: ath12k: support get_survey mac op for single wiphy

 drivers/net/wireless/ath/ath12k/core.h |  35 +-
 drivers/net/wireless/ath/ath12k/hw.h   |   1 +
 drivers/net/wireless/ath/ath12k/mac.c  | 969 +++++++++++++++++++------
 drivers/net/wireless/ath/ath12k/reg.c  |  60 +-
 4 files changed, 836 insertions(+), 229 deletions(-)

-- 
2.25.1


