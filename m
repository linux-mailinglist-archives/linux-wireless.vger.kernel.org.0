Return-Path: <linux-wireless+bounces-13555-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E4305991651
	for <lists+linux-wireless@lfdr.de>; Sat,  5 Oct 2024 13:15:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AC891F23827
	for <lists+linux-wireless@lfdr.de>; Sat,  5 Oct 2024 11:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A58C313C8F6;
	Sat,  5 Oct 2024 11:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="kcmP2DJP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27850535D8
	for <linux-wireless@vger.kernel.org>; Sat,  5 Oct 2024 11:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728126929; cv=none; b=FWnOwEb0uyw0DU5G/FMYMt6oPBpIpzFz115oagsmyCXqfQbDM1OzmUz+VzVYaHH4DpSgfz9YZNsjXZLwE5ozqsarKTHugJ41rEPk58SrKPQts4C+jGa21uHBxzTGh1VVGPK0yKbES7V+vt66oLvaipuTfFfeoblmigdKhX3wrlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728126929; c=relaxed/simple;
	bh=qRoMABYqRuvSRvGEDW7DDrIrM9DxX9cJWv5psX6oSo0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=j9qls4jYRnl0HfxD+Tb9tDaQG36rZB/dTqL0mtlRx/tmWVt535SCiXU10ZCRbkOb+2ZpAvEw2yRRTw5oXAG4mifHoJ1mWexpfAcFEZ55UkqT/jc+SkDgL0ahcbPAXz6dY+JFlxL42cBKL5sPJHUMxtgryNhaXEkMTfpCMEeTHLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=kcmP2DJP; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 495B1O4i024108;
	Sat, 5 Oct 2024 11:15:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=zxQkgdJjKlFWJ/KlRWoJTz
	2m3MWx1hfG7PcrvAkcK+I=; b=kcmP2DJPgJsvnQnHzlif9JHMW0gtSki6S3kjL+
	T8rKSbQWnghghskha+uqa/jskqR4/WmVaMj709Uoy+mTdJyoGGtGM2vQNICa9RDs
	RjAjxYl6+m/QvqOnhIxb5/r27iq4OBJC5irTbWir3SDx4GsyV/kdRfCjJwO6Vqa1
	aNuPtkes4P2POFy1jazu9zNw71O9b7TVJM0Yx1Ao+h3z71/MkZiKGnG7YYsrLyOp
	caTcWBBFPSeXLN3GXz2uf07w+llkUnN5+pq8B8rDll7GaPryq6Ar92lL9SR4yLSR
	sHhB3rkuRhUxzlbf9NtQZqBL+gQscT4s6/G+JuJFIxwZtqoA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 422xr5genq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 05 Oct 2024 11:15:24 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 495BFORL007078
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 5 Oct 2024 11:15:24 GMT
Received: from hu-rdevanat-blr.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Sat, 5 Oct 2024 04:15:22 -0700
From: Roopni Devanathan <quic_rdevanat@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Roopni Devanathan
	<quic_rdevanat@quicinc.com>
Subject: [PATCH v2 0/2] wifi: ath12k: Support pdev Rate, Scheduled Algorithm Stats
Date: Sat, 5 Oct 2024 16:45:04 +0530
Message-ID: <20241005111506.3361688-1-quic_rdevanat@quicinc.com>
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
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: rCTUhQ2vdP7aV1ms2fEujuK2zRHxrsvd
X-Proofpoint-ORIG-GUID: rCTUhQ2vdP7aV1ms2fEujuK2zRHxrsvd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 suspectscore=0
 clxscore=1015 mlxlogscore=783 priorityscore=1501 impostorscore=0
 adultscore=0 mlxscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410050083

Add support to request HTT stats type 49 and 51 from firmware. These
stats give scheduled algorithm stats and BE OFDMA rate of pdev, respectively.

v2:
 - Modified the API print_array_to_buf_v2() to print_array_to_buf_index().
 - Updated dependencies.

Depends-on:
[PATCH v2] wifi: ath12k: Modify print_array_to_buf() to support arrays with 1-based semantics
Link: https://lore.kernel.org/all/20241004085915.1788951-1-quic_rdevanat@quicinc.com/

[PATCH v2 0/4] wifi: ath12k: Support Ring, SFM, Transmit MU, SelfGen stats, CCA stats
Link: https://lore.kernel.org/ath12k/20241005101816.3314728-1-quic_rdevanat@quicinc.com/

[PATCH v2] wifi: ath12k: Support Pdev OBSS Stats
Link: https://lore.kernel.org/ath12k/20241005104206.3327143-1-quic_rdevanat@quicinc.com/

[PATCH v2] wifi: ath12k: Support DMAC Reset Stats
Link: https://lore.kernel.org/ath12k/20241005105207.3350790-1-quic_rdevanat@quicinc.com/

Pradeep Kumar Chitrapu (1):
  wifi: ath12k: Support BE OFDMA Pdev Rate Stats

Sidhanta Sahu (1):
  wifi: ath12k: Support Pdev Scheduled Algorithm Stats

 .../wireless/ath/ath12k/debugfs_htt_stats.c   | 162 ++++++++++++++++++
 .../wireless/ath/ath12k/debugfs_htt_stats.h   |  59 +++++++
 2 files changed, 221 insertions(+)


base-commit: 8ed36fe71fd60c851540839b105fd1fddc870c61
prerequisite-patch-id: faf46024c8b5c094e201d392109e7f94dcecdd49
prerequisite-patch-id: c4662f64bc7be141322b7e37145e52ea4ab4e182
prerequisite-patch-id: 4d37990775694f110ce3e87096231fe8855f09f5
prerequisite-patch-id: 5959fd18b497d29cad98d36dcce59a876ffe8ca2
prerequisite-patch-id: ecac67f6fce1dd4d5089dbc3da840e311f6a7218
prerequisite-patch-id: 0537ae604d2617e42bef13bfb791aad4d11bf6e1
prerequisite-patch-id: da5a4e5cc3097994bfcba4b37680c90b0675ccf9
-- 
2.25.1


