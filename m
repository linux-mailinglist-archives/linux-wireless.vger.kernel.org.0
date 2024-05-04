Return-Path: <linux-wireless+bounces-7175-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 924D78BBE3E
	for <lists+linux-wireless@lfdr.de>; Sat,  4 May 2024 23:45:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3DE61C20B84
	for <lists+linux-wireless@lfdr.de>; Sat,  4 May 2024 21:45:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCC4D84DF9;
	Sat,  4 May 2024 21:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="X1u6qQZb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5665C757F5;
	Sat,  4 May 2024 21:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714859130; cv=none; b=H++O/ip95QdssXdAzoA4QL+ZtPepoHj9Wf0oSq5OxEzE9gvUHxUn/EQI+GtsdLSSmR6NbeGZA6q6DfnUc//edoL+W32FBG/qtRLg3ZofAVebOPjqLSnfxFeqH0pGFxDUIA571R63TLc3dp3PYdEDc1yGG0fH0Dt5tJKlXgSGTNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714859130; c=relaxed/simple;
	bh=BUtG3A1QIrpDVjUGzwUb1/6Ol9d3nUxADM9GQPual9o=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=TZi8e0rXPc8olu49p2et0KdnF1qxZ+wMeTi4iadwN8w0sSspS5t23Q2APg1UaopVrc3bMSNntvr2XAjM/RGio5CWJ4YayMX1A5ITTukAP26IEW+O3zEs9scMufhT6ZePQtw2G+uCu+8Swst9r+RjPLO9Fp4Op+4M7aoBol23U3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=X1u6qQZb; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 444LhEre014028;
	Sat, 4 May 2024 21:45:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding:to:cc; s=qcppdkim1; bh=YKR/TREcDCkkxS
	IHj35FFn4VXxtfKPyhd2S5bG1e1SU=; b=X1u6qQZb6rWCioR4gmBnyhgadVz5Ka
	RNYMewk+GG/zyPaguiQveD4tJq2lcbxZSFDxHwyzc+FfrBLGBpePx1zc41SJ6Gzp
	ldRBoO0Bkc+Dgw6CyIkVIGaN5M7nZ83wc/KpemJVLx98tudC3WJUQQBRGX43vEPi
	OWuQeMxRyAzvyE1pPubbMCOGWy0N3wIgNK0IQjIRsRvapxMrXx4MaUnqc7Jju11l
	mDZF2HIKxnemU3VY4r+CvwvebfzDbL6NCb3qzTzDbsFPJ3SB+nY4vFdUSD4/REBN
	wgHwOP1NbUFd2Dnm7somR5tjmA3pKV+OwjhnccIdd1YYQZNXBKJrqCvQ==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xwddc11tu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 04 May 2024 21:45:22 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 444LjLYD001237
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 4 May 2024 21:45:21 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sat, 4 May 2024
 14:45:18 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Subject: [PATCH 0/2] wifi: ath12k: Fix spelling and smatch issues
Date: Sat, 4 May 2024 14:45:16 -0700
Message-ID: <20240504-ath12k_dp_rxdma_ring_sel_config_wcn7850-ret-v1-0-44d2843a2857@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGysNmYC/x3NQQrDIBBA0auEWVdQiU3pVUoRoxMd2pgwShoIu
 Xttl2/z/wEFmbDAvTuAcaNCS25Qlw58cjmioNAMWupeGqmEq0nplw2r5T3MzjLlaAu+rV/yRNF
 +fB5uRgrGKozy/WiCvppBQyuujBPt/9vj2Ty6gmJkl336PWZXKjKc5xebOtWAlgAAAA==
To: Kalle Valo <kvalo@kernel.org>, Jeff Johnson <jjohnson@kernel.org>
CC: <linux-wireless@vger.kernel.org>, <ath12k@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Jeff Johnson <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 5d-T7qCA7Rdi9KgQpfb3i1LTA64HVsal
X-Proofpoint-GUID: 5d-T7qCA7Rdi9KgQpfb3i1LTA64HVsal
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-04_17,2024-05-03_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=779
 priorityscore=1501 malwarescore=0 bulkscore=0 spamscore=0 suspectscore=0
 impostorscore=0 mlxscore=0 phishscore=0 adultscore=0 clxscore=1015
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2405040140

The original goal was to fix the smatch issue:

drivers/net/wireless/ath/ath12k/dp_rx.c:4065 ath12k_dp_rxdma_ring_sel_config_wcn7850() error: uninitialized symbol 'ret'.

But in the process I discovered a misspelling in a struct member name,
so fix that first.

---
Jeff Johnson (2):
      wifi: ath12k: fix misspelling of "dma" in num_rxmda_per_pdev
      wifi: ath12k: initialize 'ret' in ath12k_dp_rxdma_ring_sel_config_wcn7850()

 drivers/net/wireless/ath/ath12k/dp.c    | 10 +++++-----
 drivers/net/wireless/ath/ath12k/dp_rx.c | 16 ++++++++--------
 drivers/net/wireless/ath/ath12k/dp_tx.c |  2 +-
 drivers/net/wireless/ath/ath12k/hw.c    |  6 +++---
 drivers/net/wireless/ath/ath12k/hw.h    |  2 +-
 drivers/net/wireless/ath/ath12k/wmi.c   |  2 +-
 6 files changed, 19 insertions(+), 19 deletions(-)
---
base-commit: 50971dc6694c0845fcddfe337ea39c5b723d5a92
change-id: 20240501-ath12k_dp_rxdma_ring_sel_config_wcn7850-ret-51c4b5d26572


