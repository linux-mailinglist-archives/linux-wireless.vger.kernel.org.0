Return-Path: <linux-wireless+bounces-4013-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66E70867BB3
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Feb 2024 17:23:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2195C28107E
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Feb 2024 16:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 931CA12C7E2;
	Mon, 26 Feb 2024 16:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="mor9/FBs"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA8C71D531
	for <linux-wireless@vger.kernel.org>; Mon, 26 Feb 2024 16:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708964611; cv=none; b=aBAPbVKlacC9p6fySBb5s0hS9ISqKl+xCjlBIx8NvQRr+s37CycsVQVKDgKABld+QZ+0kQPWnyBOazC5ZMOdWldJso0fv7cnxzQncdV9WrJ2RZ+4g0aWYgJpQv8VbPmoHYZFgn4FXkCg2oE4iS6ZfLMWr6PLPCehruSpW3D0xm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708964611; c=relaxed/simple;
	bh=Vlw37CJ5c4Ads5D5L0IXLoGm7nv58SFI2jiUgSpfyy4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jMGSlfUjNHTM3gKPrYByHBmJ6lZzHl+mvb5uzMsFPGHpxUyLj5OA8JZV31cHgkWr707rFWPsoCQUjDNezZnvZzZGFyU2UX4fLuYdgu7+hNe7C4VUpYBen0DZVT8sgbW21c4NG54XRjcGOiRIEdg+btMFnoBhcKfNCU7RGPFJaOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=mor9/FBs; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41QF9JUu005305;
	Mon, 26 Feb 2024 16:23:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=nHi1cEM
	C/ne0nYmkEiSGYF3tJxAaBHM1XwXPq1FjdTA=; b=mor9/FBsUiy0x0uab0tr8mH
	KhPYryIhDkdwWQxkxBuLO9tEXQ4p5PKbdts4sTVG6fpzXRbJAisZbip7bru1OF/C
	SVXZm3YAkxlVJhagUI41cbTnzLJp+Jx1te5krRipqukwACQ5iIGD6BYsMN/cPgmF
	lCRSoIecF4bve1xZWRkSk2/U9SlM4LBQ7IWmkldfJy6HrbhDMh3HKpjvR7PJB4Mw
	v4iQ/MIQGLMjjjJJiFVgSipMBDkVjw7hJQojLIFGRmUVJuoYZ/Athnii2eNJqXfS
	gL4iz1F95vZZdBqP6nJEAbHJbOs1+96HyhHFq0JtMe2Pe7Al+0Ze8axPiudPwXg=
	=
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wgkxkse39-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 Feb 2024 16:23:26 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41QGNPlF026850
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 Feb 2024 16:23:25 GMT
Received: from hu-periyasa-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 26 Feb 2024 08:23:23 -0800
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>
Subject: [PATCH 0/3] wifi: ath12k: Optimize the lock contention in Rx data path
Date: Mon, 26 Feb 2024 21:53:07 +0530
Message-ID: <20240226162310.629162-1-quic_periyasa@quicinc.com>
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
X-Proofpoint-ORIG-GUID: rGEdEgznggbe75Ejprt81Za69zpkz85A
X-Proofpoint-GUID: rGEdEgznggbe75Ejprt81Za69zpkz85A
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-26_11,2024-02-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=1 impostorscore=0
 lowpriorityscore=0 phishscore=0 mlxlogscore=208 malwarescore=0
 suspectscore=0 bulkscore=0 adultscore=0 spamscore=1 clxscore=1015
 priorityscore=1501 mlxscore=1 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2402120000 definitions=main-2402260124

Refactor the Rxdma replenish procedure and avoid the Rx descriptor used
list to reduce the lock contention in Rx data path.

Karthikeyan Periyasamy (3):
  wifi: ath12k: Refactor Rxdma buffer replinish argument
  wifi: ath12k: Optimize the lock contention of used list in Rx data
    path
  wifi: ath12k: Refactor error handler of Rxdma replenish

 drivers/net/wireless/ath/ath12k/dp.c    |  31 ++++--
 drivers/net/wireless/ath/ath12k/dp.h    |   5 +-
 drivers/net/wireless/ath/ath12k/dp_rx.c | 140 +++++++++++++++---------
 drivers/net/wireless/ath/ath12k/dp_rx.h |   1 +
 4 files changed, 113 insertions(+), 64 deletions(-)


base-commit: c39a5cfa0448f3afbee78373f16d87815a674f11
-- 
2.34.1


