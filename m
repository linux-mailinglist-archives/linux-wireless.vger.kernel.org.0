Return-Path: <linux-wireless+bounces-13683-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76062993E66
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Oct 2024 07:43:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C83EB20764
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Oct 2024 05:42:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE18C143C77;
	Tue,  8 Oct 2024 05:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="QgHN+u3O"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE2E0143866
	for <linux-wireless@vger.kernel.org>; Tue,  8 Oct 2024 05:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728365910; cv=none; b=kxKB0eN89ASP+SkTkuel44DXAyFDLKSSqZxcKlGPGKPUjFPwytjR8cGWbZgJ2nWLT5qsaMdvfIusgJbB2mxoacFG3w3QIYYOLXL5GVs73+MlSM+MIYGcauKOmlGuKqfrTp3cLe19FR4Wr+SkjS9EuB18uJZYWwVk3ImPq6djXo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728365910; c=relaxed/simple;
	bh=J+xRYZKAO3/mRFnA1jyPFMBS7pERFY9uknyOjVmu1AM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IVZOLKeCT4xQivkFE+zzhFgCS+JWiioeNZHDNT9Gj9PFTDXrmZ4huJWt1iViPeSXsVnndhUPNNtD9RNN7XnV1xnQhylKnGEp76vUIu3oU7bibv4A+QyNn4yLbG48x3brUSDBKPIZH0FdN2lmPYYte7LTuwYBCvxWgIWl+06Uo28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=QgHN+u3O; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4984Sbqt008697;
	Tue, 8 Oct 2024 05:38:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=T3MYwjOfQAwtfMN57P9fzh
	kxKfgygxNZGA6QgqUVxV4=; b=QgHN+u3OILVwnTW3k5zmmp7mafishpRFC6l7mA
	IPF+4+v9k/h80V+n2Mm7peokFdoLhHstRwjxTmSC0yE17pjMoc72560ybac8Cm6N
	VnXTYUaWrc0ueR57/QM5jgpBhh+DkrEJCwMlxRfpo6JiDGybyzG+bdwrYu+xSFZ0
	xry0Nr0PLsDwnInxrrmt3dAhtbNFyY5VoddkmWRne+fBSKklevflfUm+duPx/vaP
	SEgxooVZ6EX1xeyQGTAmgLq7QRxFd/F/losaSf6XRGQOkL9BpZykov5V1dz/CGfX
	Tf0AkOvSCBeXX1ELN62O+oUXlgA6niCetAyJf75aXL5nYh2A==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 424wrc041s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Oct 2024 05:38:26 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4985cPq3025681
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 8 Oct 2024 05:38:25 GMT
Received: from kangyang.ap.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 7 Oct 2024 22:38:24 -0700
From: Kang Yang <quic_kangyang@quicinc.com>
To: <ath11k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <quic_kangyang@quicinc.com>
Subject: [PATCH v3 0/2] wifi: ath11k: fix full monitor mode for QCN9074
Date: Tue, 8 Oct 2024 13:37:42 +0800
Message-ID: <20241008053744.1070-1-quic_kangyang@quicinc.com>
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
X-Proofpoint-GUID: LZYoXu2xanclc0CbSBFIIOTwv13gPs9f
X-Proofpoint-ORIG-GUID: LZYoXu2xanclc0CbSBFIIOTwv13gPs9f
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 impostorscore=0 suspectscore=0 mlxscore=0 clxscore=1015 spamscore=0
 adultscore=0 priorityscore=1501 phishscore=0 lowpriorityscore=0
 mlxlogscore=901 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410080035

Fix a warning and a bug for full monitor mode. With these two fixes,
full monitor mode can work properly to capture packets on QCN9074.

v3:
    1. add fix tag for all patches.
    2. typo error: occurr/occur.
    3. delete unnecessary Unicode characters in patch #1.
v2:
    1. delete duplicate commit message in patch #1.
    2. explain this fix is for QCN9074.

Kang Yang (1):
  wifi: ath11k: add srng->lock for ath11k_hal_srng_* in monitor mode

P Praneesh (1):
  wifi: ath11k: fix RCU stall while reaping monitor destination ring

 drivers/net/wireless/ath/ath11k/dp_rx.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)


base-commit: d35bb26e150d7fb7434959fad9fcaeaac99906e6
-- 
2.34.1


