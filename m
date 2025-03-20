Return-Path: <linux-wireless+bounces-20589-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BCFDDA69E4D
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Mar 2025 03:30:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F343A1897729
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Mar 2025 02:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 642F11CAA8A;
	Thu, 20 Mar 2025 02:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="UowMmgTM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90B6118C02E
	for <linux-wireless@vger.kernel.org>; Thu, 20 Mar 2025 02:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742437821; cv=none; b=f7wmFK7VOby16RVG0a+r+NrLeSRaoQ4VpCUGLiNObzSl8WOkXn3uF9u5ppoJ+xTxmPKMwu6yQRhQXOUAfM1iqUOamQMuNINmx4+3nJVYB3mpK1zjGGvfZnMAwxSEkI9qHA2fNwqUY3sV6qOpmRsYRQdoJHoiRDgG0Y/whwn8X5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742437821; c=relaxed/simple;
	bh=l0RyQoOasWTozFtP4++dOyvGvW8E8O3z+3URSRKngS0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qapg9w7EJLDHS/rwSBUzOOOg1NXcLXkaHJ7sd54gGZ0yx2kPeGuyl3FnKIg4kEIzcPVL4ULM3e7OH1PM54/LU0Y5rVHTcm7+tiOXlP+pTBgk1JXpAIaCC7EwbFj//50pwCuW5roVDLqAZDhK0rwC+RbKM/cOzS2UA+HulR6Q9Vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=UowMmgTM; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52JG7Z0e031271;
	Thu, 20 Mar 2025 02:30:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=9UnTybxmMZFlU7y+EwxN0L
	FDCR9zp7D/whUB1r2NRjQ=; b=UowMmgTMN/V2DXUp+jmEfIlegkNwQUsyOTManN
	CVzxdG5a7ro84gA42PbPbrkDTeAVB6tXgVVm4iyXtCNmyUIHeS1uneQ2ujgBAL0A
	ltDxO5sr9dHL3pNMG5cmunr9Qe5gbYzv7IM8vIJYW9oU6cIt+WNdm8G3UhEvmW0D
	8qc450fgBPCulZfXqz4vWTFYwnEIEIZg0EXrdJPRSRdL8H4HR24eahzvL/L3jG83
	/aT6R2q0BolrUvgT8AQ1N9isbHnVOUIv5bihrdIpmLMPYxnfcJRlBknxpg5GG5hO
	6GHaP+KhKWndqCt79o871FOr2VMp7VVoyJxRnf9oQlv+1TTw==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45g15y1bur-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Mar 2025 02:30:15 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 52K2UEmh011310
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Mar 2025 02:30:14 GMT
Received: from bqiang-SFF.qca.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 19 Mar 2025 19:30:13 -0700
From: Baochen Qiang <quic_bqiang@quicinc.com>
To: <ath11k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <quic_bqiang@quicinc.com>
Subject: [PATCH ath-next 0/5] wifi: ath11k: bring hibernation support back
Date: Thu, 20 Mar 2025 10:29:58 +0800
Message-ID: <20250320023003.65028-1-quic_bqiang@quicinc.com>
X-Mailer: git-send-email 2.25.1
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
X-Proofpoint-GUID: NjtdsxdgaXIlH9apn6xzCBADJe5B_eRV
X-Proofpoint-ORIG-GUID: NjtdsxdgaXIlH9apn6xzCBADJe5B_eRV
X-Authority-Analysis: v=2.4 cv=VaD3PEp9 c=1 sm=1 tr=0 ts=67db7db7 cx=c_pps a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=GEpy-HfZoHoA:10 a=Vs1iUdzkB0EA:10 a=VwQbUJbxAAAA:8 a=GTWTkweOQRfIT-LzBWMA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-20_01,2025-03-19_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 bulkscore=0 lowpriorityscore=0 adultscore=0 mlxlogscore=543 phishscore=0
 spamscore=0 priorityscore=1501 suspectscore=0 mlxscore=0 malwarescore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503200015

To handle the Lenovo unexpected wakeup issue [1], previously we revert
commit 166a490f59ac ("wifi: ath11k: support hibernation"). However we
need to bring it back, of course with additional changes such that Lenovo
machines would not break.

As those machines work well in Non-WoWLAN suspend mode, the thought here
is that we do WoWLAN suspend on Lenovo machines while do non-WoWLAN
suspend (which is done in the reverted commit) on other machines. This
requires us to identify Lenovo machines from others. For that purpose,
read machine info from DMI interface, match it against all known affected
machines. If there is a match, choose WoWLAN suspend mode, else choose
non-WoWLAN mode.

[1] https://bugzilla.kernel.org/show_bug.cgi?id=219196

Baochen Qiang (5):
  wifi: ath11k: determine PM policy based on machine model
  wifi: ath11k: introduce ath11k_core_continue_suspend_resume()
  wifi: ath11k: refactor ath11k_core_suspend/_resume()
  wifi: ath11k: support non-WoWLAN mode suspend as well
  Reapply "wifi: ath11k: restore country code during resume"

 drivers/net/wireless/ath/ath11k/ahb.c  |   4 +-
 drivers/net/wireless/ath/ath11k/core.c | 245 +++++++++++++++++++++++--
 drivers/net/wireless/ath/ath11k/core.h |  11 ++
 drivers/net/wireless/ath/ath11k/hif.h  |  14 +-
 drivers/net/wireless/ath/ath11k/mhi.c  |  14 +-
 drivers/net/wireless/ath/ath11k/mhi.h  |   5 +-
 drivers/net/wireless/ath/ath11k/pci.c  |  44 ++++-
 drivers/net/wireless/ath/ath11k/qmi.c  |   4 +-
 8 files changed, 301 insertions(+), 40 deletions(-)


base-commit: b6f473c96421b8b451a8df8ccb620bcd71d4b3f4
-- 
2.25.1


