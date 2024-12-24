Return-Path: <linux-wireless+bounces-16758-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BB759FBC75
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Dec 2024 11:37:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5BDB16B52E
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Dec 2024 10:26:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3373619992C;
	Tue, 24 Dec 2024 10:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="pyLbzCrW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9648D1B6CF5
	for <linux-wireless@vger.kernel.org>; Tue, 24 Dec 2024 10:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735035635; cv=none; b=oMnw4tcWNE1UxrJl9kGOK4iMfa7DAKGp0pfsOMcWJD/tVSWvmminSchz7IDloHiYgQW5RUVeyFbc/wCrt+awDTt0pP9MbyF0RPwsr9rA2FosOSoocoTfUy3YjU21aNipIakBiYezE+joFTCMSlSk3Mkzth3RdOZoB7YHO1E2fZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735035635; c=relaxed/simple;
	bh=sMBmo9NaZJVBPVLZNAfWavq1zjeh0UlMAli0LwWpmbE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SU2KlyOU2DBnzlNSO8Yuk+DbAB5QOjQCSdMX8YHMh6W0tPm7kwuXHvmSbRVZ5eIkxCUkkP8/dpO2EMdz7Q7PItEZCMeizTVuqyA6E1cf6RTFq/JyADgAAKWC/1tM7/y+4VbEJ6rngsnNrXfB/yj7TUkWzZfYW4KCLypq3goVqdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=pyLbzCrW; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BO5WYC3008076;
	Tue, 24 Dec 2024 10:20:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=/cHdqEJKeY2HpW3xK+rto7
	NbzwszTcC5doO9ISYbtG4=; b=pyLbzCrWeHcgQb/C0zQTKRBTLs8JkNmxlLEMkz
	Ei5sZZ9GHp0cq/veDzlPZWUSRN6yDySGybPt7V3eFAv4QuiTMZcoa4z+Kb2lFFSr
	OoT8w7tPwogP9vFEiWne+BDs/U1ykhwEp+B9EDDrotSPrkAaaLTM4ZOCoRJTNuaJ
	UDvp4r51Ko00uMfQagcTXfOf/hhyIREhV1nNLnEyJPGJF4M+qfebC4MU6PA6Vu05
	PY8ApSi/omhnFij4pqhkxBSrMETxxYa3vQR84Au2N3/oVwJPrOBSyEQuhOdjbw2O
	6/up1pYNoiprVTBmCAkWMVmXfUz/Mh75CUBL2FGB7lwmEMeA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43qpwb9mr6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Dec 2024 10:20:30 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4BOAKTOE022387
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Dec 2024 10:20:29 GMT
Received: from hu-rdevanat-blr.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 24 Dec 2024 02:20:27 -0800
From: Roopni Devanathan <quic_rdevanat@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Roopni Devanathan
	<quic_rdevanat@quicinc.com>
Subject: [PATCH v2 0/6] wifi: ath12k: Support Sounding, Latency, Trigger, FSE stats
Date: Tue, 24 Dec 2024 15:50:07 +0530
Message-ID: <20241224102013.1530055-1-quic_rdevanat@quicinc.com>
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
X-Proofpoint-GUID: zy3TKqu7CjE_--GGUUV-bcrxgVxwySOS
X-Proofpoint-ORIG-GUID: zy3TKqu7CjE_--GGUUV-bcrxgVxwySOS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 phishscore=0
 lowpriorityscore=0 priorityscore=1501 mlxlogscore=809 adultscore=0
 suspectscore=0 mlxscore=0 spamscore=0 bulkscore=0 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412240087

Add support to request HTT stats type 22, 25, 26, 27 and 28 from
firmware. These stats give sounding stats, latency stats, trigger stats
for uplink OFDMA and MUMIMO and FSE stats, respectively.

Depends-on:
[PATCH 0/2] wifi: ath12k: Support Rate and OFDMA Stats
Link: https://lore.kernel.org/all/20241128110949.3672364-1-quic_rdevanat@quicinc.com/

[PATCH v4 0/2] wifi: ath12k: Support AST and Puncture Stats
Link: https://lore.kernel.org/all/20241217055408.1293764-1-quic_rdevanat@quicinc.com/

v2:
 - Added line breaks where necessary, as pointed out by Kalle.
 - Modified the use of pointer arithmetic print_array_to_buf_s8().
 - Modified commit logs, as suggested by Kalle. 

Dinesh Karthikeyan (5):
  wifi: ath12k: Support Sounding Stats
  wifi: ath12k: Support Latency Stats
  wifi: ath12k: Support Uplink OFDMA Trigger Stats
  wifi: ath12k: Support Uplink MUMIMO Trigger Stats
  wifi: ath12k: Support Received FSE Stats

Roopni Devanathan (1):
  wifi: ath12k: Add API to print s8 arrays in HTT stats

 .../wireless/ath/ath12k/debugfs_htt_stats.c   | 736 ++++++++++++++++++
 .../wireless/ath/ath12k/debugfs_htt_stats.h   | 267 ++++++-
 2 files changed, 970 insertions(+), 33 deletions(-)


base-commit: 09fa3b6974a1245ddd0751747609431494ba5b4f
prerequisite-patch-id: c30df5e4af6f5773ed942d8f78de88c05ce2b18b
prerequisite-patch-id: f2181eee4bce2e3487db9bd81ed962f477759e7e
-- 
2.25.1


