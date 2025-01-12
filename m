Return-Path: <linux-wireless+bounces-17372-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E5D09A0A764
	for <lists+linux-wireless@lfdr.de>; Sun, 12 Jan 2025 08:16:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0CF53A76A0
	for <lists+linux-wireless@lfdr.de>; Sun, 12 Jan 2025 07:16:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FF0D2C6A3;
	Sun, 12 Jan 2025 07:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="SDVmONyJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB5E91392
	for <linux-wireless@vger.kernel.org>; Sun, 12 Jan 2025 07:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736666211; cv=none; b=tlG/u6mc4XeamfwIoqJzbl1+rpACbSd0Z3bV3VDA8MEjwksHxhsLRIvBko4kOjMtmqBtCZ3FIdXcSdaiccVtk9H9s1dDLmlFmMWs04R4b8TZuBrfOxqrb1k3kWYHhNUWGOk4XuteH0LwzGTuhLapKlkiujKFyLq0xANvDB6uXEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736666211; c=relaxed/simple;
	bh=zk1/yHR5rZAe6oC6LrCZKmZhDraOPr+b2dtnZzIVNMA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Q7M37a2UZHZm4Inos8HUSpcfmflsJRnw51NeRzYaqigWVqP7mKvUeBPfdxwZ/8udidwaksMzdfC9ILuUMvDdxlPRoy9TV+P9XwsaJH0X3hakQ1c4elIrlHb5BCAzNeGxJsqtaQxTAh4NtqfpycEWsHFRsItWYIBCgGEUIZpL4OE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=SDVmONyJ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50C78H7T006196;
	Sun, 12 Jan 2025 07:16:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=U6FlXsTcg2w2ONuQekAyiS
	ULXWTW2vZiiLeIiKxognU=; b=SDVmONyJjARcy4xTmHzuk7wxxCw0n/2nUQmfO3
	NDQnAj87Q1OaUqht0d4QTYbeY2xOPgIyDUZjHjxgbJvGa89BfB2Outzpr2Oe7KIc
	xD5PYnkj0saUUcNjdwzBumhsSYWW+tLEzfHZA4EAtiH6YqqCvLDIbh+JYTHOA51A
	wq6iZw0BNfo1vAUThAgNm1+hW6x42HVr9Ky4HPdUPkVV02tfaLjbH1E4iBr5sX8z
	N9AK+lv1wmVSLm1cTWadkZkVMLq2h9nD3lMDBSDiPe4+od9YXpC0VZFJvLL+Wy+a
	PKeTCv3Vr5cXs2NUm5OAjjONInVMLfAtp/itKJEU+Oh+Sfpw==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 443hjk9pet-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 12 Jan 2025 07:16:46 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50C7GjIR022366
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 12 Jan 2025 07:16:45 GMT
Received: from hu-periyasa-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Sat, 11 Jan 2025 23:16:43 -0800
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>
Subject: [PATCH v4 0/4] wifi: ath12k: Fix the static checker warning
Date: Sun, 12 Jan 2025 12:46:26 +0530
Message-ID: <20250112071630.4059410-1-quic_periyasa@quicinc.com>
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
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: CGvhrJP3F5Ixy33Fl6JyMz6Z8JBozM3q
X-Proofpoint-ORIG-GUID: CGvhrJP3F5Ixy33Fl6JyMz6Z8JBozM3q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 clxscore=1015
 spamscore=0 suspectscore=0 bulkscore=0 priorityscore=1501 mlxlogscore=472
 lowpriorityscore=0 malwarescore=0 phishscore=0 mlxscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2501120063

This patch series fix the below Smatch static checker warnings

Warnings:
mac.c:10941 ath12k_mac_destroy() error: we previously assumed 'ab' could be null (see line 11348)
mac.c:11007 ath12k_mac_allocate() error: uninitialized symbol 'ab'.
mac.c:11013 ath12k_mac_allocate() error: uninitialized symbol 'ab'.

v4:
 wifi: ath12k: Remove ath12k_get_num_hw() helper function
  - updated copyright
v3:
 wifi: ath12k: Remove ath12k_get_num_hw() helper function
  - Renamed the patch title
  - Removed ath12k_get_num_hw() helper function
v2:
 - Rebased on ToT

Karthikeyan Periyasamy (4):
  wifi: ath12k: Refactor ath12k_hw set helper function argument
  wifi: ath12k: Refactor the ath12k_hw get helper function argument
  wifi: ath12k: Remove ath12k_get_num_hw() helper function
  wifi: ath12k: Fix uninitialized variable access in
    ath12k_mac_allocate() function

 drivers/net/wireless/ath/ath12k/core.c | 22 +++++++-----
 drivers/net/wireless/ath/ath12k/core.h | 15 +++-----
 drivers/net/wireless/ath/ath12k/mac.c  | 49 +++++++++++++++++---------
 3 files changed, 50 insertions(+), 36 deletions(-)


base-commit: 0c5fcd9069dd5f984e39820629acbfbe0f1b4256
-- 
2.34.1


