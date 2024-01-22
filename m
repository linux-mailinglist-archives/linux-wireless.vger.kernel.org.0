Return-Path: <linux-wireless+bounces-2308-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C8C0835D6C
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Jan 2024 09:57:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2F8F1F2470F
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Jan 2024 08:57:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D71FC3A1CA;
	Mon, 22 Jan 2024 08:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="InQ7zlst"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 345C63A1C8
	for <linux-wireless@vger.kernel.org>; Mon, 22 Jan 2024 08:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705913657; cv=none; b=XJ3gA5ukhsrRdnYtu87bxXY7AtUE2HRiPXtDoQmfjNE2udCtL8z+xdTXI8kLSIF+QfQNxZUOfGQfS2f/yM0CKmyVBkTNYrKjn/pc9u96UxKxfir32DysocJD+SjY7kqy+AIhordfrsnFVlYK5zw08EXh0GK0r7eocoYJ51jlylA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705913657; c=relaxed/simple;
	bh=iBs8DPxIvX8pcgOUGoUEviFGy25Dvsu7w1g1J7VeWKk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ggqpl68MtODRvrsQYCoBJp2STxkUeSyV0L/M5r9c8l4L1u1cZamri8FZx5FNz9gQadgzqjw59ZkTIn4AcF42JchQtQThW/ujMFb5E+lTF8/Zc+yPOcZDL3KJD7Zfg564nsXzxKPeu4vOS/+R5fQ12Mn818Cr5j+i36M2iwTCxT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=InQ7zlst; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40M8QC23022007;
	Mon, 22 Jan 2024 08:54:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=QHi93Vm
	VVIBnqsqe+B/ofcwI5xBCxvtR69nYUIfnCQs=; b=InQ7zlst45hgojJzmd98yrO
	uxdeuyvPgkPI+6M8b0KQ4A/f55MYqLiywNYl7Qo7e+MGGjF9XTmz6EdZzf0ywOng
	99YfkfKGCu6jwES/ZDU4BppfbSe87zONiuL1A8aLDF2sPuaMbSw9GcFwuwx/Tvhv
	wa7pirnHIgx8sPnN2aCASwLRKaR2t0tCKG7U0b59gMnlcH6F3sHgigh5hg2uiOlW
	laOeajy8aYJDO8dJPbiLWpjqDC8xHYPzBDnUioICch0B+LYCmc8AlYE6ziX7OEl/
	aBGiXawH6wtaqs76s/cpnGXYsYFsTEj5QJer5ow9/VN3alZkhXHSbyJxlQMVHQQ=
	=
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vsmuag1pk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Jan 2024 08:54:08 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40M8s7bO022526
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Jan 2024 08:54:07 GMT
Received: from lingbok-Latitude-E5440.qca.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 22 Jan 2024 00:54:06 -0800
From: Lingbo Kong <quic_lingbok@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <quic_lingbok@quicinc.com>
Subject: [PATCH v2 0/2] wifi: ath12k: add processing for TWT enable/disable event
Date: Mon, 22 Jan 2024 03:53:34 -0500
Message-ID: <20240122085336.3985-1-quic_lingbok@quicinc.com>
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
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: iHbBweQraIZHumy2M9fa0sQf88zCLLxo
X-Proofpoint-ORIG-GUID: iHbBweQraIZHumy2M9fa0sQf88zCLLxo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-21_04,2024-01-19_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=439 mlxscore=0
 clxscore=1011 impostorscore=0 suspectscore=0 spamscore=0
 lowpriorityscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 phishscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2311290000 definitions=main-2401220062

This patch set is used for processing TWT enable/disable event. It can be
more convenient to debug TWT.

The patches work with WCN7850 and QCN9274.

v2:
1.Change the call way of ath12k_wmi_tlv_parse_alloc() based on 
wifi: ath12k: refactor ath12k_wmi_tlv_parse_alloc()

Lingbo Kong (2):
  wifi: ath12k: add processing for TWT enable event
  wifi: ath12k: add processing for TWT disable event

 drivers/net/wireless/ath/ath12k/wmi.c | 70 ++++++++++++++++++++++++++-
 drivers/net/wireless/ath/ath12k/wmi.h | 10 ++++
 2 files changed, 78 insertions(+), 2 deletions(-)


base-commit: 8ff464a183f92836d7fd99edceef50a89d8ea797
-- 
2.34.1


