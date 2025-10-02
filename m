Return-Path: <linux-wireless+bounces-27768-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AC670BB21B0
	for <lists+linux-wireless@lfdr.de>; Thu, 02 Oct 2025 02:07:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A3B61C506F
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Oct 2025 00:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E31D34BA3C;
	Thu,  2 Oct 2025 00:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ptR/eFRH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2121184
	for <linux-wireless@vger.kernel.org>; Thu,  2 Oct 2025 00:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759363671; cv=none; b=JXV21RNrwz8iVZYQCYU4XTrkq/LM0WRRt9StFR4e6JL7lKUv4/IosSexdmVaBdyG7VB8UPZm3zPhXFk9cqcCewEKTP5naUugphNAni4nPIT72ieEhyrVYUtRSTFJQfRioftL9zU9vpAlEJgw/Cm9uHGNBPG+erdhatTu9JF495M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759363671; c=relaxed/simple;
	bh=sDt6krkwIti+GYzPRIAZmbwdgKWfDPLE8zwmrMyDykE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NGFrWBmU9rNE0IIy6yDg86SHMSMq9QW+kHR9vTv0CJICNfK5q/SEdmXef2z09R6mWM5gATIAzd+okAOVrF2gtEu+uBEJj+HLmJzF19/yctMFQ4UjaAj+HEKlBSOP3o8ZmcBS2CsNJ74YWvANmpKdxZ6pxVw6Al6qNKEczJHgqqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ptR/eFRH; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 591IcSXo024130;
	Thu, 2 Oct 2025 00:07:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=5e+o/eBl44A4s9g8vibFtN
	nQb3h12wCSa+YcF4aHM5g=; b=ptR/eFRHpooi4NduGz9mQM5ETrFtX/26PAbjYI
	lxcAsslJBx5+V7whQ4fcEgxKMlOiaan0Z/JpZPvTqUuHDs1rqWjhbnUnSvHzd0ki
	dNniRMXW/UkSQClBeL0o9gRyn8dtE8hK7ywO5A9XHRBqa8d8uqfnb/91FPpMEzAD
	Zx+JXHxqMac1gW/CjftGYmFDWuG6ZjX+NYQ+UbCNaR3k47sXHyOiRe6XCZ7kR9uR
	emyI+Y6aW3NcdZfDXj7q3e15PtkJmVeRfPFtuEYLxsU2fc5RrnqEJcPJLUzJS2IT
	XBDGMNH4gBrrsZm3Qa8/mtYJATZVPkawLYOpam/Ek1iB/5Eg==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49e8a6680h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 02 Oct 2025 00:07:44 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 59207hum013963
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 2 Oct 2025 00:07:43 GMT
Received: from ath12k-linux2.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.24; Wed, 1 Oct 2025 17:07:42 -0700
From: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, Baochen Qiang <quic_bqiang@quicinc.com>,
        Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
Subject: [PATCH ath-next V16 0/2] wifi: ath12k: fix TX and RX MCS configurations in VHT and HE modes
Date: Wed, 1 Oct 2025 17:07:30 -0700
Message-ID: <20251002000732.1916364-1-quic_pradeepc@quicinc.com>
X-Mailer: git-send-email 2.43.0
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
X-Authority-Analysis: v=2.4 cv=RZKdyltv c=1 sm=1 tr=0 ts=68ddc250 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=x6icFKpwvdMA:10 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8
 a=HofUMcyOe6VF9sWmV4wA:9 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: BZBLnaS4xnQs6lGmogGLnXoFUXhauMZ1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAzMyBTYWx0ZWRfX7srpFTEQp2U0
 4tyQrocwXbzXgJdAoLTOlcvHb9qML0//Je7cZVQrkvGRRiB26Kb7LGTNTbQtVYPIE3ydjFTPKfG
 7ImpkKGBgoBewSbvLh3A1BS9jMndkbJ0LjaWtbY3tWLDtjm9efJx0jx0heMsLX+9yCN6//Dasbc
 ERTPQ24pwQFpPL7OUzGXIahB+jG8xoIKsbYQjxf5oV0rdbXaJ4F7M3+cZUa5PV1ddyOOkyoHfej
 g3kjkcbMmXQo56HQGUDXD1JqvJ43UTEo5liUd8h503hLU9a4UYCZzocCxqqe15utnToyQvkHjKO
 7ZHz40bqQlJHV/fo+WERsfHvvn+VY7JbDXeaKmvOsgfbMoZIr3AiPvGxA9x9at53NnEp/ExAalO
 dp/8OWYWooY5YOWzw8SYB7sX5Sd/8A==
X-Proofpoint-ORIG-GUID: BZBLnaS4xnQs6lGmogGLnXoFUXhauMZ1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-01_07,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 malwarescore=0 priorityscore=1501 adultscore=0 phishscore=0
 impostorscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509270033

This is revision version for patch:
https://patchwork.kernel.org/project/linux-wireless/patch/20250701010408.1257201-6-quic_pradeepc@quicinc.com/

changes in v16:
 - remove patches in series which hare accepted already
   https://patchwork.kernel.org/project/linux-wireless/list/?series=977538&state=*
 - Fix review comment on last revision https://patchwork.kernel.org/project/linux-wireless/patch/20250701010408.1257201-6-quic_pradeepc@quicinc.com/
 - Add similar VHT related changes into separate patch.

Baochen Qiang (1):
  wifi: ath12k: fix VHT MCS assignment

Pradeep Kumar Chitrapu (1):
  wifi: ath12k: fix TX and RX MCS rate configurations in HE mode

 drivers/net/wireless/ath/ath12k/mac.c | 12 +++++-------
 drivers/net/wireless/ath/ath12k/wmi.c | 11 +++++++----
 drivers/net/wireless/ath/ath12k/wmi.h |  2 ++
 3 files changed, 14 insertions(+), 11 deletions(-)


base-commit: 94aced6ed9e2630bae0b5631e384a5302c4b6783
-- 
2.43.0


