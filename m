Return-Path: <linux-wireless+bounces-24649-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66C9BAED54F
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Jun 2025 09:12:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B43181754C5
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Jun 2025 07:12:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE4302185A8;
	Mon, 30 Jun 2025 07:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="GX/Z9DsS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 340C71C1F13
	for <linux-wireless@vger.kernel.org>; Mon, 30 Jun 2025 07:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751267542; cv=none; b=kHBW/KGhGDkCCEyFFuxrcvgjmEsFOOf5VWJQed+fYYEEN5b/zlXxoXAPrW/l9hJOPbEVjVTOeAB97EHBGVzJFQNl6t995tlmc6Ze9AVk86P9UZ2nf0f7lg8cHjHTUH7B3d1VLfOcelHl4n6EWoJnTdAgU2UFfN1qioCdsd4fEq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751267542; c=relaxed/simple;
	bh=y2/YchpeFujHT1LClGpetzw2cADnY4G6xsNxSdGxcrI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Otew00sr032XG/SadMK4gLi1Bb3XOToYobh3JD+oEnN39ySW+cv1ImfSm4DxJxbvYQ+vfLhGuAR2hJVhGHKCkySlx4i2B5XbYyvMRa23V3ZzcNnufBTILkoQYThBi6/bZGE2InDFXT2BzyCZXn4T8M1s1o4X7NtZ5CvhP9kfoIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=GX/Z9DsS; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55U6GIxp002572;
	Mon, 30 Jun 2025 07:12:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=2j0Vz830TXfxfsJ6fPnk25
	Dk7G+zaR8xCj6k5ShWMzg=; b=GX/Z9DsSSexokn2IDSrJDCCkNzrounE0lEa6LM
	5/2qKA0petXnyT4vNXc/xa1GRO1s/LLWUIJXYSxENPbfmUGlwFMoZLxtVLyIeH5N
	vniVrqBFH2MK2DWwcew6zv/Dgw+sw2VxKHxuivf1NrEdHBh/qLiOo+nkrPnwdJjx
	J+Uc5746psFTarP4uyUKREVPLzWbfnvb07W5zDVjYJet5rx3LeSFqcXY0907fQs2
	wytzybvBVGopPDuUMqMipueSi4blCdr8mduUAMOAyq2KgMFiF80dT+O7YEs/GaWZ
	tF/ziiHehcpm6u2NkA76LDZwJmOQow/PRhJicAEoz5uB0TBg==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47kn5j84er-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Jun 2025 07:12:18 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 55U7CIlD009585
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Jun 2025 07:12:18 GMT
Received: from hu-sarishar-blr.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 30 Jun 2025 00:12:16 -0700
From: Sarika Sharma <quic_sarishar@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Sarika Sharma
	<quic_sarishar@quicinc.com>
Subject: [PATCH ath-next v7 0/5] wifi: ath12k: add support to fill link statistics of multi-link station
Date: Mon, 30 Jun 2025 12:41:09 +0530
Message-ID: <20250630071114.3474672-1-quic_sarishar@quicinc.com>
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
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=KtJN2XWN c=1 sm=1 tr=0 ts=686238d2 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=6IFa9wvqVegA:10 a=kYzkSp3CTHGy5h0v6O0A:9
X-Proofpoint-ORIG-GUID: CDSM5BFTbNGfqeDQ350UQ0PxGL-Wn8I9
X-Proofpoint-GUID: CDSM5BFTbNGfqeDQ350UQ0PxGL-Wn8I9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjMwMDA1OCBTYWx0ZWRfX6i3yRahT6Wy9
 wxd2cjV2Z054FMH+FUJke9dJAwZUOywNlsNdqj07/Km2QBxU97rgihdSb15pFME3Ef3++YrpGIP
 18gbv9DWFMGjsXNNueG4f9A3HgAb8zvf0je+vzldwrAdiP0Exs+z7MxgbTG6LUKdjwQJ4jju7m8
 MezQx6v5htnKerO5IomyL/P/IfdVuPaQzlCwHr+Zjev3ydmyJt40n5P9kEJm0ZfnkOyXzffDPiW
 X0YD82+wrXJmXBYWoIxojDWDWTA/Aaa3Xe8Pnf/VbmecwaBCaTZwXILF8OKmcTKHObxa26ZT8c2
 yNJjq0uU0CcDM/OqrHZBezIHoFbcCWt8gOljvZVuIJ7wI57qI1MZeHw1XJdSqQac6iq8Qc6PbdF
 JsYn1wUlwG8c1WfsD49bmEtoMQJKpJp58I9ovmksP/D8HHkes/UjqrthFslEj8LfjqkRsnr8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-30_01,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 priorityscore=1501 malwarescore=0 suspectscore=0
 mlxscore=0 spamscore=0 adultscore=0 lowpriorityscore=0 phishscore=0
 clxscore=1015 mlxlogscore=620 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506300058

Currently, station statistics are filled at deflink for both non-ML and
multi-link(ML) station.

Hence, add support to fill station statistics for the corresponding
link of station.

V7:
 - Rebased to latest.

V6:
 - Remove dependent cfg80211 patch- as merged.
 - Change the code according to  design change of cfg80211 patch series.

V5:
 - Removed mac80211 patch from this series and included in dependent series.

V4:
 - Removed driver patches.
 - Added branch tree tag.
 
V3:
 - Fix kernel test robot build error

v2:
 - Convert RFC patch to actual PATCH with each patch bisectable.
 - Add new patch to update bw for ofdma packets.
 - Add new patch to fetch tx_retry and tx_failed packets.

Sarika Sharma (5):
  wifi: ath12k: fill link station statistics for MLO
  wifi: ath12k: add link support for multi-link in arsta
  wifi: ath12k: add EHT support for TX rate
  wifi: ath12k: correctly update bw for ofdma packets
  wifi: ath12k: fetch tx_retry and tx_failed from
    htt_ppdu_stats_user_cmpltn_common_tlv

 drivers/net/wireless/ath/ath12k/core.h   |  2 +
 drivers/net/wireless/ath/ath12k/dp.h     |  2 +
 drivers/net/wireless/ath/ath12k/dp_mon.c | 22 ++++--
 drivers/net/wireless/ath/ath12k/dp_rx.c  | 48 ++++++++++---
 drivers/net/wireless/ath/ath12k/mac.c    | 88 ++++++++++++++++++++++++
 drivers/net/wireless/ath/ath12k/peer.h   | 26 +++++++
 6 files changed, 173 insertions(+), 15 deletions(-)


base-commit: 391a83d0c8ebb1e476cba73bf4c010af73993111
-- 
2.34.1


