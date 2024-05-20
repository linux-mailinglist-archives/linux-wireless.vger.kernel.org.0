Return-Path: <linux-wireless+bounces-7828-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 74EDA8C97FC
	for <lists+linux-wireless@lfdr.de>; Mon, 20 May 2024 04:42:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A671B1C20AE8
	for <lists+linux-wireless@lfdr.de>; Mon, 20 May 2024 02:42:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DF0417F5;
	Mon, 20 May 2024 02:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="auug4S7D"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCF74BA40
	for <linux-wireless@vger.kernel.org>; Mon, 20 May 2024 02:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716172940; cv=none; b=nf3Nmsjs+tKJhcFr5GDlgo+5N5vTT2Ku4qGsq23Fb5t5DNhn45PyAYpVS5eE/U5vhphcFrxQnyE//IKWZx0LA652MjLMrpenX5PAEEwJK79zSWqgo2pfBGYmmGQZFcJu3s8qqzJm3GoBoaD+gWgxlzbos3l6x3qIc7j7Pb6XguU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716172940; c=relaxed/simple;
	bh=3uwOH9Jh+0XaTH7VF/dhMYoJEA9pokEM0LGVqJpY1Gc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Kds6/CICkFeM4adUNxjAJ32AZ1ma+efJM18Ukh6yBmt1F/+MVQXVun8Z+LSy+bAEPLxnukfIV82gC0i+dEFZZsWgYSuJIBYQlgPcLFJdefpUcuuQ/1iD07FdiO/kdc87N5OAVymxNzrnB2rdoWCCYFQIkHk/U6+moWO8cKGmR4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=auug4S7D; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44JNCNne015601;
	Mon, 20 May 2024 02:42:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=RW3lHWw
	gaUIdCoh2MB8yVlzTo8lzF7zfG4AEgSLjiRI=; b=auug4S7Dgnf7mCLRa8IdQvH
	qmnY5O082FnIbbONuVIoHAkyF3SYXexwgx5JzQP8Kh8LO3j0nTRMzyRX5C58sEU7
	eK7WOPpuwHlpxjle7gIZe0RVbjk5Z33MmQq4IsDiYSTIHj40bFY5Hflu8aqT+5O0
	F3G3W3BPlu/JDFhj73aE2DLSU1i7HwUebgG5WzOtONBcLCGPsn5q5uMgqLve1gxt
	dV9roEPaxeuungr9i0iKU9yWxBAV1eQtdwgIj3GEwKeRaQ5AxjcS9Z1LACJ/r7xo
	7eeYBIZap6CgnUUThMe4c7rTIgOjZWQlZzHyWwiLu+snwZfkuQAEQ9Qb9QlXLfg=
	=
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3y6n3tah8x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 May 2024 02:42:09 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44K2fxwR032642
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 May 2024 02:41:59 GMT
Received: from bqiang-SFF.qca.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Sun, 19 May 2024 19:41:58 -0700
From: Baochen Qiang <quic_bqiang@quicinc.com>
To: <ath11k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <quic_bqiang@quicinc.com>
Subject: [PATCH 0/2] wifi: ath11k: fix wrong regdomain after hibernation
Date: Mon, 20 May 2024 10:41:46 +0800
Message-ID: <20240520024148.5472-1-quic_bqiang@quicinc.com>
X-Mailer: git-send-email 2.25.1
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
X-Proofpoint-GUID: Kj06P_a5qhp0eJFjSXYcd1F1xRYkSdy1
X-Proofpoint-ORIG-GUID: Kj06P_a5qhp0eJFjSXYcd1F1xRYkSdy1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-20_01,2024-05-17_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 bulkscore=0 priorityscore=1501 malwarescore=0 mlxlogscore=686
 lowpriorityscore=0 phishscore=0 spamscore=0 impostorscore=0 clxscore=1015
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405010000 definitions=main-2405200020

We got report that regdomain is not correct after hibernation,
see details in patch 2.

To fix it, host needs to restore country code to firmware using
ath11k_wmi_send_set_current_country_cmd(). There are several places
where it is called and all of them share the same code snippet. So
refactor them to make code clean, this is done in the first patch.
Actual fix comes in the second patch.

Baochen Qiang (2):
  wifi: ath11k: refactor setting country code logic
  wifi: ath11k: restore country code during resume

 drivers/net/wireless/ath/ath11k/core.c | 29 ++++++++++++++++----------
 drivers/net/wireless/ath/ath11k/mac.c  | 13 +++---------
 drivers/net/wireless/ath/ath11k/reg.c  | 14 +++++++++----
 drivers/net/wireless/ath/ath11k/reg.h  |  4 ++--
 4 files changed, 33 insertions(+), 27 deletions(-)


base-commit: d11f74006da48efd32f6304ef8fcec5894171641
-- 
2.25.1


