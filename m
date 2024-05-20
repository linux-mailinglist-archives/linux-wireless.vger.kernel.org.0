Return-Path: <linux-wireless+bounces-7834-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB28F8C9914
	for <lists+linux-wireless@lfdr.de>; Mon, 20 May 2024 09:01:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FE51281845
	for <lists+linux-wireless@lfdr.de>; Mon, 20 May 2024 07:01:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 288D6D52F;
	Mon, 20 May 2024 07:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="DKxznlQC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE881171AA
	for <linux-wireless@vger.kernel.org>; Mon, 20 May 2024 07:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716188472; cv=none; b=YYAOWoJGmPpgzCIiw2/sy7RqOB73cn1ZgyikhtGMHFZY6MpMm8rKImS5QwIRngnYYwDMK+JIGG4XD+a4y5iPvWMflDSjtAGRebYoiPMeFXwl/kzcTvhwvq7GZXnxhncjklx6TVwMp033qIwtsbcCevd89jMKeE0iKz7wwulURqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716188472; c=relaxed/simple;
	bh=udW869aFXt3hDGy/ENxWOzvccTZyBF5FnAyJXLCARN8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rnMVdx9racGrlIiPibvZa/kTSmF20AmAW1BY6lsYkhoMRbWf0VsVGQAK5JS3D8i6XeBZVlpTInI7WPfsQA5kFJhcbPmRi54Mzib63u10eCoA4ksfMtWlTFEGz5T+tDKk8TNkCUMSki01taiN2disBSICsg+jER38NbiYaRvLbw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=DKxznlQC; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44JNL9Ok007323;
	Mon, 20 May 2024 07:01:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=JFXPW2R
	52kKlqCtJsRjZwKr6ySCVr9G1ryTOM4iDIpM=; b=DKxznlQCFeOiEpyjuAb0kc1
	k9EIljAGxj4kWNp1k7u/aaUvrTq2dWJsKSqlU0OKdpi9mo/H5DfSZ8y5ZPNL9Ifw
	Ht06PZgksB3fT2FIqiNquTRK40FF1lIVO51pRo2Cs30IZaNXC7YldSsR5K2jlhWd
	l7PedzryXHGsJNm6NRHtYHGeuoHe5W8hsmxWQuRLCcEG4loEl7wUR9/0X33sUKS9
	lWZgMiDuSGSouhLgPnUCbmpGXGm6yc7ODhJ9C+MDU/bFtdhD/EMokehWXUvOcEPg
	v8yy6V9Z1yTAMXt7xMpcgTP9QFxn8AI4Z7nAl3R4zNRTYTrcI2bIhfcf1/rEm8w=
	=
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3y6pqajgfg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 May 2024 07:01:07 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44K715eu011964
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 May 2024 07:01:05 GMT
Received: from hu-ppranees-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 20 May 2024 00:01:04 -0700
From: P Praneesh <quic_ppranees@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, P Praneesh <quic_ppranees@quicinc.com>
Subject: [PATCH 0/3] wifi: ath12k: fix issues in rx fragmentation path
Date: Mon, 20 May 2024 12:30:42 +0530
Message-ID: <20240520070045.631029-1-quic_ppranees@quicinc.com>
X-Mailer: git-send-email 2.34.1
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
X-Proofpoint-GUID: 5LcFHmGC8725C08oGJHM-OR9SQD7YEus
X-Proofpoint-ORIG-GUID: 5LcFHmGC8725C08oGJHM-OR9SQD7YEus
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-20_04,2024-05-17_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 impostorscore=0 suspectscore=0 bulkscore=0 mlxscore=0 adultscore=0
 spamscore=0 malwarescore=0 mlxlogscore=274 clxscore=1011
 priorityscore=1501 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2405010000 definitions=main-2405200057

This series addresses issues in rx fragmentation path.

P Praneesh (3):
  wifi: ath12k: change DMA direction while mapping reinjected packets
  wifi: ath12k: fix invalid memory access while processing fragmented
    packets
  wifi: ath12k: fix firmware crash during reo reinject

 drivers/net/wireless/ath/ath12k/dp_rx.c | 18 ++++++++----------
 drivers/net/wireless/ath/ath12k/hw.c    |  6 +-----
 2 files changed, 9 insertions(+), 15 deletions(-)


base-commit: 0ef7606c6012f05a1f5398e3a1964c35eb9c08a4
-- 
2.25.1


