Return-Path: <linux-wireless+bounces-17128-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A3E53A03594
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Jan 2025 03:57:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 809E1161F62
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Jan 2025 02:56:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB9A215A856;
	Tue,  7 Jan 2025 02:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="kVgPL0pk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B1713C8E8
	for <linux-wireless@vger.kernel.org>; Tue,  7 Jan 2025 02:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736218613; cv=none; b=Vx3wBCn9vINtxlsg8VuBjMzmRFi9Mh7yPOzF0mKX4WI0Ykw5GD1WsNNwsoH8B3SVXkv1rrTmacR2UAcS9f7zmTxO2RiJAX0nbMY8Lqac7LkwkMv7ONn4DuKN3ndgY94Cc9bEDpGDZ974kvDLe0Obqb9JvAC8yYY4rvXmsL88deo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736218613; c=relaxed/simple;
	bh=Jc+Z/WGq0Blcbr+ATxNZtTIVpQk5A5CIRGiiMrFRfL8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PjAHBt/rZQXbm1rux2Y0LM6TL0q4DBGl3gOZOFPOzKV+0pOoRL2sS4gnEpPtfZtvRKmHol0EQOOFRBEAT532JZ7rDMVvV/U90E93MdGGD+vRQ+ofto1l9wAL7URm/hp3FKqXGxHifB7hBldgDqV93sLCj/rGRm9aauZVgNv0KmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=kVgPL0pk; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 506E4XhB018151;
	Tue, 7 Jan 2025 02:56:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=7422LiGs/2ri8COxM9gw5C
	JrFel6qJL6pq8nSBXz4a0=; b=kVgPL0pkjkdzdJKbDfTsrZ5JRM3JycDsMlUjvD
	R4r9apeC0PyPhlXyQk9hgEpBePDG/EVXKEgIWX6DcXn30AwT5oA5jn6iQTGOx3/v
	mdvAIms5OQW06BiUhcZCjXKxSJb0LtnX8p5Gla0kzJMx0w2ZTYuHmiQ5KbWf1BOe
	IKtRFJTTAvdEqUc8X4yviqSYjUJIHr4HdzIkIROGGLhHBNwnhHiSUU/pzMtdUbxD
	B05pMoaecM0sv+qSdRxu2MnU37NmYOzwNlHCblxMGQeCWHEqW6DVdrDNLNMp1ZPp
	KX/y/POd2zzSeweaBvuZgp/3KB4GJ3M1dELMxH5w9QIGfnxg==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 440gmc1hm0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Jan 2025 02:56:45 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 5072uiCi018071
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 7 Jan 2025 02:56:44 GMT
Received: from kangyang.ap.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 6 Jan 2025 18:56:43 -0800
From: Kang Yang <quic_kangyang@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <quic_kangyang@quicinc.com>
Subject: [PATCH v6 0/3] wifi: ath12k: monitor mode cleanup and state handling
Date: Tue, 7 Jan 2025 10:56:18 +0800
Message-ID: <20250107025621.1907-1-quic_kangyang@quicinc.com>
X-Mailer: git-send-email 2.34.1.windows.1
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
X-Proofpoint-GUID: 8xjrnX3weohD4csZ5w3y5aAnE6eGMkv8
X-Proofpoint-ORIG-GUID: 8xjrnX3weohD4csZ5w3y5aAnE6eGMkv8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 phishscore=0 adultscore=0 mlxlogscore=621 mlxscore=0 suspectscore=0
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501070022

This patch-set do some cleanup and handle state variables correctly for
monitor mode.

Note: The quantity of this patch set was 11 in the previous version. 8
of them were merged:
https://patchwork.kernel.org/project/linux-wireless/cover/20241022110831.974-1-quic_kangyang@quicinc.com/

v6: update copyright for each patch.
v5: rebase on tag: ath/main(ath-202412191756).
v4: rebase on tag: ath/main(ath-202410161539).
v3: rebase on tag: ath/main(ath-202410111606).
v2: rebase on tag: ath-202410072115.

Kang Yang (3):
  wifi: ath12k: optimize storage size for struct ath12k
  wifi: ath12k: properly handling the state variables of monitor mode
  wifi: ath12k: delete mon reap timer

 drivers/net/wireless/ath/ath12k/core.c |  7 +++++-
 drivers/net/wireless/ath/ath12k/core.h | 27 +++++++++++------------
 drivers/net/wireless/ath/ath12k/dp.c   | 30 +-------------------------
 drivers/net/wireless/ath/ath12k/mac.c  | 13 ++++++++++-
 4 files changed, 32 insertions(+), 45 deletions(-)


base-commit: 09fa3b6974a1245ddd0751747609431494ba5b4f
-- 
2.34.1


