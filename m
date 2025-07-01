Return-Path: <linux-wireless+bounces-24720-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA95CAEF5EE
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Jul 2025 13:00:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D987A1BC4AC6
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Jul 2025 11:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A773270EA4;
	Tue,  1 Jul 2025 10:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="QgKnQQeq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAC08226CFF
	for <linux-wireless@vger.kernel.org>; Tue,  1 Jul 2025 10:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751367594; cv=none; b=muSKVLCk/peaBqAoSKW6FyaBkkzxKBGUjadSScLfzaFhqG9VpmxK4bZNO2SKuRUiQ0Ni04zB6ZjGYwVrcJ030dJLsLHmTv5NkAsbbRgsRmEvvH1JcGgJyV8zKLQmfMeQiliIlV7UaoHIIkz/A6KbIHJKLc00oVlUb2UcXXe2gNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751367594; c=relaxed/simple;
	bh=5/OhjIXicsSp66kAu0eaDFGWAulCwurMhgwoYcKmamo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AGebwAQPGfF78pIn5/2o0ko2tpbCbyJa/9eEXcADLJHxoh4FF1wzAv+M5r6mNcVmt1ZDBTD/UCAI24oQD8tCWx/sxbs63XG+wPrmlDRCo4Hk9sUGbIMmdNBS/f4TgwXmp+fZLcRVv/U4KZR0ALWCw8xz09cyvmLMwhxFnoY0E5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=QgKnQQeq; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5619oKaT002240;
	Tue, 1 Jul 2025 10:59:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=bYtZCgXTBaGNYpAUCYFWxZ
	6qrdRKNcML+AcPNmcED3o=; b=QgKnQQeq4KcuQLAELC2UTxkvGy0ptIYF1ilpFX
	nEcGq0YzvVQJUTtSivpZ67kG14z/0QSjErHcFF6xZQzEP2HqOm9C+lHSSaHrYldF
	jXwKAaXOsTGDJlqsW2AhisN26nlO+W3+XviTJzoMFb/hIOQMETj/NNA87IZbEOol
	EfH4WCMDzyLjZGLOA4uTvJFF20Gh6ZBTxHmVVB0eCp7IyCOhCVuL8xc/NN3ICPFI
	Guh8JC/Kk5punLy2ltQM/8+F6pRSRNwC6qy+j+Cg/+vBfFmeh4JgNVTrlCsCsBgL
	3Sc4IvSoUtHaqNd/Bag0nJq0QZWY8iM5I9r9EWPGGFEJUvNQ==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47j9pcrex3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 01 Jul 2025 10:59:45 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 561AxjoD021805
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 1 Jul 2025 10:59:45 GMT
Received: from hu-sarishar-blr.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Tue, 1 Jul 2025 03:59:43 -0700
From: Sarika Sharma <quic_sarishar@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Sarika Sharma
	<quic_sarishar@quicinc.com>
Subject: [PATCH ath-next v8 0/5] wifi: ath12k: add support to fill link statistics of multi-link station
Date: Tue, 1 Jul 2025 16:29:22 +0530
Message-ID: <20250701105927.803342-1-quic_sarishar@quicinc.com>
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
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: f8Lf86jLvSfj4RkwY9F7_AnduUI2EvVZ
X-Proofpoint-ORIG-GUID: f8Lf86jLvSfj4RkwY9F7_AnduUI2EvVZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAxMDA2NiBTYWx0ZWRfXxT9lFUa/Xywy
 qgS39NxFcueAgVLHNsO0/CWVGvL+RweZHCa95yWn1J2ogaMRujuez9sQJD6ZICZbfdLgQT1atLT
 r8v3nJDytT9Zw0agtmPCzvrVxUDEJdNikL7OKYMFD/zqzyWbqOVR4XcRURo6iwyL/Z/XFYr9NTN
 ZFeXaH8z2H1eZRGEBEzdDzWhCxVx9jIGKoNUJWtSzVW5InM15Gy3ba6iqood4tqlNi6soG8AWZ/
 evwMZSbWFuMlevoclSjPyZQXSiwTlX1CGDI0GRrpsDde4TIn57VgfNem90Wdno5LwAEFThSs19x
 clCbm72PgtCW5cSjhgHzilcdsYIvQSIsgI0wRRRyDILJUvCdGDHYCHPgqV4rxQD2E6VsC9ClArc
 tgN1uBRRmdThx1BBnHB3o1e85KNxzlxFycQhVZn5LsB+3TAvggAyHOf0B97o0bgj9v8+q0m3
X-Authority-Analysis: v=2.4 cv=QMFoRhLL c=1 sm=1 tr=0 ts=6863bfa1 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=Wb1JkmetP80A:10 a=kYzkSp3CTHGy5h0v6O0A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-01_02,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 bulkscore=0 spamscore=0 adultscore=0
 mlxlogscore=708 mlxscore=0 lowpriorityscore=0 suspectscore=0 impostorscore=0
 clxscore=1015 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507010066

Currently, station statistics are filled at deflink for both non-ML and
multi-link(ML) station.

Hence, add support to fill station statistics for the corresponding
link of station.

V8:
 - Remove unnecessary initialization of bool is_ofdma.

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


base-commit: 0339e1433e228fbbbb106d9284dcc8b35ae6c4e6
-- 
2.34.1


