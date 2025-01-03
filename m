Return-Path: <linux-wireless+bounces-17026-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91743A0042A
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Jan 2025 07:21:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7B3F1883E98
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Jan 2025 06:21:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32BD9DDC1;
	Fri,  3 Jan 2025 06:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="PGTlobeQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CE2013C9D9
	for <linux-wireless@vger.kernel.org>; Fri,  3 Jan 2025 06:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735885284; cv=none; b=Ti4dONugV3UCB+VePCLvgNeYkUK38pP1c0xV6QlOULLVV668uVGQtLKh8o4FrsZhcrr7vDfw2WgptIBlUjlBDbU36xFynKY3Cs/7e5LeNpKz5dzTw3Ke1EPzCSSe6MvwTEejuuMk+Hd0gVm7GyIF6kNUxZGlhPAwpD7aWXIOYBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735885284; c=relaxed/simple;
	bh=39z0k0/utIwbQs4hAXCPtD64yNVwfvf1vKQJfn+Gl6g=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bkuMd+smxRwcCOtKcuEW8ziX2N7TE44qvM5DKpLwFSDaZ9RfRW4VzjJOFaQXRD97VGdS/zEiwL2Pyr75tWEE6SzMkfVJ7wcigWGiKXk0utKPb/XYNlbmNmizwY9nXjog48AJnKIYuc0neptxWJc7CDwRh9H1NqkXpP/pYbhB4EQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=PGTlobeQ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 502G1Mia001677;
	Fri, 3 Jan 2025 06:21:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=JREXPsweAlWueab1yk2YBe
	IRMFolEv3FytRE2SSiyRw=; b=PGTlobeQFKFPY36qHkGdS7+cAm0FQ5HeH1lDzR
	VEJc0s/DaOMLPJZBIDB8Z3xG3YFUZiB0mf3ANJNFQbqQV+Kmxegm2YuUAhKaDzkY
	+CsRVb6o3mLsLn0bJ/ABLnWD1fObrVnWefVoIcMleaCnqKhGZVAmOoh/KhtfwRty
	PQchSgbMl/RV8GT3AX21MIEqOBYBxVpLmL1keYhXTmeMiWMZGn+DHEKMdIPxezra
	qmC8kDE3dSyb6jfObWxv3pQD6mi3dzbh5V2Vq0ZNAIOldQxlJZYiRbpMmI/apE5X
	vlW+NdMNBWY5njNtfn5OVzCIQvTzEgU/nVM2vkvNXnVfETNg==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43wrefj8e9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 03 Jan 2025 06:21:18 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 5036L5Zp009866
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 3 Jan 2025 06:21:05 GMT
Received: from kangyang.ap.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 2 Jan 2025 22:21:03 -0800
From: Kang Yang <quic_kangyang@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <quic_kangyang@quicinc.com>
Subject: [PATCH v5 0/3] wifi: ath12k: monitor mode cleanup and state handling
Date: Fri, 3 Jan 2025 14:20:38 +0800
Message-ID: <20250103062041.1857-1-quic_kangyang@quicinc.com>
X-Mailer: git-send-email 2.34.1.windows.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: C_sJO1K29vK4_SOIhbr-wVgAwFWURNJv
X-Proofpoint-ORIG-GUID: C_sJO1K29vK4_SOIhbr-wVgAwFWURNJv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 lowpriorityscore=0 clxscore=1015 impostorscore=0 phishscore=0
 mlxlogscore=682 bulkscore=0 malwarescore=0 spamscore=0 priorityscore=1501
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501030053

This patch-set do some cleanup and handle state variables correctly for
monitor mode.

Note: The quantity of this patch set was 11 in the previous version. 8
of them were merged:
https://patchwork.kernel.org/project/linux-wireless/cover/20241022110831.974-1-quic_kangyang@quicinc.com/

v5: rebase on tag: ath/main(ath-202412191756).
v4: rebase on tag: ath/main(ath-202410161539).
v3: rebase on tag: ath/main(ath-202410111606).
v2: rebase on tag: ath-202410072115.

Kang Yang (3):
  wifi: ath12k: optimize storage size for struct ath12k
  wifi: ath12k: properly handling the state variables of monitor mode
  wifi: ath12k: delete mon reap timer

 drivers/net/wireless/ath/ath12k/core.c |  5 +++++
 drivers/net/wireless/ath/ath12k/core.h | 25 +++++++++++------------
 drivers/net/wireless/ath/ath12k/dp.c   | 28 --------------------------
 drivers/net/wireless/ath/ath12k/mac.c  | 11 ++++++++++
 4 files changed, 28 insertions(+), 41 deletions(-)


base-commit: 09fa3b6974a1245ddd0751747609431494ba5b4f
-- 
2.34.1


