Return-Path: <linux-wireless+bounces-27757-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93747BAE493
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Sep 2025 20:19:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D4A667A1E5D
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Sep 2025 18:17:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CA2F20C038;
	Tue, 30 Sep 2025 18:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="idqD1EFT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 719D5175A5
	for <linux-wireless@vger.kernel.org>; Tue, 30 Sep 2025 18:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759256350; cv=none; b=calKyH1wBlkA8+L5D8lhMp4B7oKVlfPYdCrKri37hvcC0N1KQLl+o88xSQzpDB51a6utuLaXsRDsC+x/Af1brxO2VAIaElwv2f7p7ska8XBV7tCbdbrVD/GNqo8P1V+T5na/7EQPkz+veYdOOEBoReoY+bXYswwqwzyYwdwTCds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759256350; c=relaxed/simple;
	bh=wfrjsh9Le+U+JI3vYpydWFu7b3evVLdLqzTnC6yK2A8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YzyX9N4nmWoFJS9M2iH7TkSq/OS+6V3yjFxF0y72YHYH6UJ7pyNZS7DpN7MD3CGVwi7YN9WQvgXS1kpM6sYhYcJgsdXmuAyvZ7IwaBHyZ90RX+22pM5ZXQ7TZAioOuJ0yxtNqDOgk186m0tiw5tB0nHSv6IBvYHY+UauUvEJ+WU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=idqD1EFT; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58UCmERv030557;
	Tue, 30 Sep 2025 18:19:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=AnSIY2Q+EBereeOInQaRgg
	ZeIM3gds6yuEb94eIbGeI=; b=idqD1EFTW4S0dng9UKGEe8UUaK7ZSmzvS8VG3P
	tvSYdVeYBNK5a9PZWu0QzPgo7SZRWZQRXsIwKUTfR4Ep/Sw1FCUjpUGAbH2wkU+/
	0Tot8a/V2j3RIb9q+KA0MW6dYYw4cFDMCTdvcuPPEC/6FTOnDBOjGu8pFQYGdLa5
	DpCWY4XYUc6e63uXxqdRKfu8egUKjn8rteYtiHJgrqOjo7JrRrZ1CHdkhc0n5aL2
	wMJkU5YH2dnVNVNHHNQQTUrlCVzX9778pGpQmfjhxRBIwfRxcpjc2H0Ln/MCE4gq
	9p1VZeR4JcSyHGRDFC0OYfr2TIfcy+L2kilT8m9NbP3pmVkw==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49e8pdhsfh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Sep 2025 18:19:05 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 58UIJ5J4028693
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Sep 2025 18:19:05 GMT
Received: from hu-rdeuri-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.24; Tue, 30 Sep 2025 11:19:04 -0700
From: Ripan Deuri <quic_rdeuri@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
Subject: [PATCH ath12k-ng 0/2] wifi: ath12k: Modularization of PDEV object for Next Generation Driver
Date: Tue, 30 Sep 2025 23:48:46 +0530
Message-ID: <20250930181848.3386271-1-quic_rdeuri@quicinc.com>
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
X-Proofpoint-GUID: DrBmjCTkfFr4PJGsCAbCH2R7gxSAytwU
X-Authority-Analysis: v=2.4 cv=MYZhep/f c=1 sm=1 tr=0 ts=68dc1f19 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=yJojWOMRYYMA:10 a=SmmkiwoZhC3QOVmOaGEA:9
X-Proofpoint-ORIG-GUID: DrBmjCTkfFr4PJGsCAbCH2R7gxSAytwU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAzNiBTYWx0ZWRfX+cWOkZ5JVigz
 GzM1YWufVQr5ehZA1Q3pAwRRLsew0MMnuX6Et05TxLq5n5UPWCxSKnEtHhEDRIEGZNwZ+2QSMfN
 YNFieZsgE1w7QQ8qFMe8L7ZJhb9ZR1YNakulI3plgKbAS8ZZhEnMxWeAXEjSRc3zkhk9Gp2y+Lz
 ijCWXWEGCzF45BfCCTPS1YlkZ7HHe4vVIqwHM7hTdVTkomHbQM2BKlcPHJ54ad0BNJnCQzhXbfo
 nazgXRXYSyiyChUy9v4bTFPLwmgmZEcNT71tpReAKU9uoS/MBeEcf7SgA0Rcj8K7dXZ5mD5vVm7
 g3135pMQaKdop9NAc4YJidZdwY42/LTm2kotMK+oRvv9IC8/eS8zUNkL/sZPVZ5u8h/6qGn2CEe
 Lg4rPoBlPC+jn3lXuuOzWID+a78y1w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-30_03,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 bulkscore=0 lowpriorityscore=0
 priorityscore=1501 phishscore=0 malwarescore=0 spamscore=0 impostorscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2509150000
 definitions=main-2509270036

This patch series continues the effort to modularize data path structures
in ath12k, focusing on improving the organization of DP pdev handling and
preparing for future architecture-specific extensions.

Patch 1 refactors DP pdev handling by consolidating all DP-related fields
of a radio into struct ath12k_pdev_dp structure. An RCU-protected array of
these objects is introduced in ath12k_dp to facilitate dp_pdev lookup from
ath12k_dp.

Patch 2 encapsulates PPDU statistics within dp_pdev, as these stats are
associated with out-of-band data path operations. This reorganization
provides a cleaner structure by grouping both in-band (per-packet) fields
and out-of-band stats under the same ath12k_pdev_dp object.

These changes are part of a broader effort to establish a base framework
for next-generation driver development, allowing the data path to remain
flexible for future extensions.
---
Ripan Deuri (2):
  wifi: ath12k: Refactor data path pdev struct
  wifi: ath12k: Rearrange PPDU radio stats

 drivers/net/wireless/ath/ath12k/core.h        |  20 --
 drivers/net/wireless/ath/ath12k/dp.c          |  28 +++
 drivers/net/wireless/ath/ath12k/dp.h          |  42 ++++
 drivers/net/wireless/ath/ath12k/dp_cmn.h      |  18 ++
 drivers/net/wireless/ath/ath12k/dp_htt.c      |  59 +++--
 drivers/net/wireless/ath/ath12k/dp_mon.c      | 183 ++++++++-------
 drivers/net/wireless/ath/ath12k/dp_mon.h      |   9 +-
 drivers/net/wireless/ath/ath12k/dp_rx.c       |  99 ++++----
 drivers/net/wireless/ath/ath12k/dp_rx.h       |  13 +-
 drivers/net/wireless/ath/ath12k/mac.c         |  34 ++-
 drivers/net/wireless/ath/ath12k/wifi7/dp_rx.c | 216 ++++++++++--------
 drivers/net/wireless/ath/ath12k/wifi7/dp_tx.c |  66 +++---
 drivers/net/wireless/ath/ath12k/wifi7/dp_tx.h |   2 +-
 13 files changed, 490 insertions(+), 299 deletions(-)


base-commit: af66c7640cf94aa77314cf8d5e95141bdecbc1ee
-- 
2.34.1


