Return-Path: <linux-wireless+bounces-7169-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E64788BBDC3
	for <lists+linux-wireless@lfdr.de>; Sat,  4 May 2024 20:52:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EF482820D0
	for <lists+linux-wireless@lfdr.de>; Sat,  4 May 2024 18:52:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E511C762CD;
	Sat,  4 May 2024 18:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="FL16nOVe"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70A122595;
	Sat,  4 May 2024 18:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714848753; cv=none; b=ShXG2/slVm8M3qJZYQzCDyZOstsQ7k8DETZOiiC+A7tbjZ5IjnFoyDPDgNyji1+yR4iqhrDEZ3XnAUTrF8n8M8SCDQhpxsqLn5/m000E9TfEx6sWdL3V8hiBBOxFURMbNux/0hRirEHTqGMWfNjNJihhAHKFxB10bYibUkAgz8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714848753; c=relaxed/simple;
	bh=3LMVlety5ywZTfWLsXeiir1g8/HTfjgF5uTSfD3PZBc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=r/J1wWqaveS1hHgC7UJ/u6tFSGxMMJKSklPTO3CpRBdsndPK7TACzd9RCzATdjYH60JemVth40vfD9RoDfIEAkWyGjHRSrGB3frkxck/hceuTlGbdRvo+VcUTOhyHEvr76jkZ+ix+9BYz4ZbKxX/+Of+n2VzmZtlcdHzfUlhasU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=FL16nOVe; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 444I6OQ3030618;
	Sat, 4 May 2024 18:52:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:references:in-reply-to:to
	:cc; s=qcppdkim1; bh=aQ3tnX+75vTgmYSyUjYSSaDUcN+jsqorsHs+cJ8ibME
	=; b=FL16nOVewSvofFsDbWp0oyqmFeKw9iuVA+iby8HY9kSo9PVc8TR+8ccYz3Q
	SogMZ1XTIIVLu2ahnTxiFBGqjA/kEvUWN8cd+644pOnjj+ec0p/1kqpBLrgfocMG
	dNZl/IzM9kMHgn/4ycCJqlTpnFm6VW/aQjHnaJgqRmatLniKSetWBi57cFq7gvyw
	zG/WhU8XupFg5eBpgGz83xBnQaxCqpHj9oHxm7wbmwK2d+/VPaCHcvQnGttir1os
	SCj43CFDJd3/4oLfhsTk7OX6ZvlXM+/8PsaNx+/xcegGT0jL/PfhSacaQjTboIUu
	ar68Z/lyi7me3X39enHAI/7Q93g==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xwacsh3v6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 04 May 2024 18:52:11 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 444Iq9ri016627
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 4 May 2024 18:52:09 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sat, 4 May 2024
 11:52:09 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Sat, 4 May 2024 11:52:08 -0700
Subject: [PATCH 1/2] wifi: ath12k: initialize 'ret' in
 ath12k_qmi_load_file_target_mem()
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240504-qmi_load_file_target_mem-v1-1-069fc44c45eb@quicinc.com>
References: <20240504-qmi_load_file_target_mem-v1-0-069fc44c45eb@quicinc.com>
In-Reply-To: <20240504-qmi_load_file_target_mem-v1-0-069fc44c45eb@quicinc.com>
To: Kalle Valo <kvalo@kernel.org>, Jeff Johnson <jjohnson@kernel.org>
CC: <linux-wireless@vger.kernel.org>, <ath12k@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <ath11k@lists.infradead.org>,
        Jeff Johnson
	<quic_jjohnson@quicinc.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 9VDva7YNRO1XcAmbziOHrFRxh8suAnLm
X-Proofpoint-ORIG-GUID: 9VDva7YNRO1XcAmbziOHrFRxh8suAnLm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-04_15,2024-05-03_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 mlxscore=0
 bulkscore=0 spamscore=0 phishscore=0 impostorscore=0 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 adultscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2405040127

smatch flagged the following issue:

drivers/net/wireless/ath/ath12k/qmi.c:2619 ath12k_qmi_load_file_target_mem() error: uninitialized symbol 'ret'.

The reality is that 'ret' is initialized in every path through
ath12k_qmi_load_file_target_mem() except one, the case where the input
'len' is 0, and hence the "while (remaining)" loop is never entered.
But to make sure this case is also handled, add an initializer to the
declaration of 'ret'.

No functional changes, compile tested only.

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/qmi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath12k/qmi.c b/drivers/net/wireless/ath/ath12k/qmi.c
index 3bb730326a02..f273cb93dedb 100644
--- a/drivers/net/wireless/ath/ath12k/qmi.c
+++ b/drivers/net/wireless/ath/ath12k/qmi.c
@@ -2538,7 +2538,7 @@ static int ath12k_qmi_load_file_target_mem(struct ath12k_base *ab,
 	struct qmi_wlanfw_bdf_download_resp_msg_v01 resp = {};
 	struct qmi_txn txn;
 	const u8 *temp = data;
-	int ret;
+	int ret = 0;
 	u32 remaining = len;
 
 	req = kzalloc(sizeof(*req), GFP_KERNEL);

-- 
2.42.0


